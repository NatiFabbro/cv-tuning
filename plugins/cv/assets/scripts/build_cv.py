#!/usr/bin/env python3
"""Arma un CV a partir de una plantilla del plugin y un archivo de contenido en JSON.

Solo usa la librería estándar de Python (zipfile + xml): no requiere instalar
`python-docx` ni ninguna otra dependencia. Implementa el método manual descrito
en reference/template-styles.md ("Cómo rellenar (sin instalar nada)"), paso 3 en
adelante, para no reescribirlo a mano en cada corrida.

Uso:
    python build_cv.py --template ats-clean.docx --content contenido.json --output CV_Nombre-Apellido_Empresa.docx

Formato de --content (ver reference/template-styles.md para los estilos válidos):
{
  "lang": "es-ES",                 // código de reference/locales.md ("Idioma del documento")
  "page_size": "A4",               // opcional: "A4" (default) o "Letter"
  "paragraphs": [
    {"style": "CVNombre", "text": "Nombre Apellido"},
    {"style": "CVContacto", "runs": [
        {"text": "Buenos Aires, Argentina | persona@example.com | "},
        {"text": "linkedin.com/in/persona-demo", "link": "https://www.linkedin.com/in/persona-demo/"}
    ]}
  ]
}

Cada párrafo lleva "text" (un solo run sin formato) o "runs" (lista de runs;
un run con "link" se vuelve hipervínculo real, clickeable).
"""

import argparse
import json
import re
import sys
import zipfile
from xml.sax.saxutils import escape

DOCUMENT_XML = "word/document.xml"
STYLES_XML = "word/styles.xml"
RELS_XML = "word/_rels/document.xml.rels"

HYPERLINK_REL_TYPE = (
    "http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink"
)

PAGE_SIZES = {
    # (width, height) en twips (1/20 pt), como los guarda Word.
    "A4": (11906, 16838),
    "LETTER": (12240, 15840),
}


def load_content(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def next_rel_id(rels_xml_text):
    ids = [int(m) for m in re.findall(r'Id="rId(\d+)"', rels_xml_text)]
    return (max(ids) + 1) if ids else 1


def build_run_xml(run, rel_ids_used, next_id_holder):
    text = escape(run.get("text", ""))
    link = run.get("link")
    if not link:
        return f'<w:r><w:t xml:space="preserve">{text}</w:t></w:r>'
    r_id = f"rId{next_id_holder[0]}"
    next_id_holder[0] += 1
    rel_ids_used.append((r_id, link))
    return (
        f'<w:hyperlink xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" '
        f'r:id="{r_id}"><w:r><w:t xml:space="preserve">{text}</w:t></w:r></w:hyperlink>'
    )


def build_paragraph_xml(paragraph, rel_ids_used, next_id_holder):
    style = paragraph["style"]
    if "runs" in paragraph:
        runs_xml = "".join(
            build_run_xml(run, rel_ids_used, next_id_holder) for run in paragraph["runs"]
        )
    else:
        runs_xml = build_run_xml({"text": paragraph.get("text", "")}, rel_ids_used, next_id_holder)
    return f'<w:p><w:pPr><w:pStyle w:val="{style}"/></w:pPr>{runs_xml}</w:p>'


def build_cv(template_path, content, output_path):
    with zipfile.ZipFile(template_path, "r") as zin:
        names = zin.namelist()
        parts = {name: zin.read(name) for name in names}

    document_xml = parts[DOCUMENT_XML].decode("utf-8")
    rels_xml = parts[RELS_XML].decode("utf-8")
    styles_xml = parts[STYLES_XML].decode("utf-8")

    # 1. Párrafos + relaciones de hipervínculos.
    next_id_holder = [next_rel_id(rels_xml)]
    rel_ids_used = []
    paragraphs_xml = "".join(
        build_paragraph_xml(p, rel_ids_used, next_id_holder) for p in content["paragraphs"]
    )

    if "<w:sectPr>" not in document_xml:
        raise ValueError(f"No encontré <w:sectPr> en {DOCUMENT_XML}; ¿la plantilla cambió?")
    document_xml = document_xml.replace("<w:sectPr>", paragraphs_xml + "<w:sectPr>", 1)

    # 2. Tamaño de página (opcional, default A4 = lo que ya trae la plantilla).
    page_size = content.get("page_size", "A4").upper()
    if page_size not in PAGE_SIZES:
        raise ValueError(f"page_size desconocido: {page_size!r} (usá 'A4' o 'Letter')")
    if page_size != "A4":
        w, h = PAGE_SIZES[page_size]
        new_match = re.search(r'<w:pgSz w:w="(\d+)" w:h="(\d+)"', document_xml)
        if not new_match:
            raise ValueError("No encontré <w:pgSz> en el documento para ajustar el tamaño de página.")
        document_xml = re.sub(
            r'<w:pgSz w:w="\d+" w:h="\d+"',
            f'<w:pgSz w:w="{w}" w:h="{h}"',
            document_xml,
            count=1,
        )

    # 3. Relaciones de hipervínculos.
    if rel_ids_used:
        new_rels = "".join(
            f'<Relationship Id="{r_id}" Type="{HYPERLINK_REL_TYPE}" '
            f'Target="{escape(url)}" TargetMode="External"/>'
            for r_id, url in rel_ids_used
        )
        if "</Relationships>" not in rels_xml:
            raise ValueError(f"No encontré </Relationships> en {RELS_XML}.")
        rels_xml = rels_xml.replace("</Relationships>", new_rels + "</Relationships>", 1)

    # 4. Idioma del documento (obligatorio, ver reference/locales.md).
    lang = content.get("lang")
    if lang:
        pattern = r'<w:lang w:val="[^"]*" w:eastAsia="[^"]*" w:bidi="[^"]*"/>'
        if not re.search(pattern, styles_xml):
            raise ValueError(f"No encontré <w:lang .../> en {STYLES_XML}.")
        styles_xml = re.sub(
            pattern,
            f'<w:lang w:val="{lang}" w:eastAsia="{lang}" w:bidi="{lang}"/>',
            styles_xml,
        )

    parts[DOCUMENT_XML] = document_xml.encode("utf-8")
    parts[RELS_XML] = rels_xml.encode("utf-8")
    parts[STYLES_XML] = styles_xml.encode("utf-8")

    with zipfile.ZipFile(output_path, "w", zipfile.ZIP_DEFLATED) as zout:
        for name in names:
            zout.writestr(name, parts[name])

    return len(content["paragraphs"]), len(rel_ids_used)


def verify(output_path, expected_paragraphs, expected_links):
    """Relectura fresca del archivo guardado, no lo que se tenía en memoria."""
    with zipfile.ZipFile(output_path, "r") as z:
        document_xml = z.read(DOCUMENT_XML).decode("utf-8")
    found_paragraphs = document_xml.count("<w:p>")
    found_links = document_xml.count("<w:hyperlink ")
    if found_paragraphs != expected_paragraphs:
        raise ValueError(
            f"Verificación falló: esperaba {expected_paragraphs} párrafos, "
            f"encontré {found_paragraphs} en el archivo guardado."
        )
    if found_links != expected_links:
        raise ValueError(
            f"Verificación falló: esperaba {expected_links} hipervínculos, "
            f"encontré {found_links} en el archivo guardado."
        )


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--template", required=True, help="Ruta a la plantilla .docx (ats-clean.docx o visual.docx)")
    parser.add_argument("--content", required=True, help="Ruta al JSON de contenido")
    parser.add_argument("--output", required=True, help="Ruta del .docx a generar")
    args = parser.parse_args()

    content = load_content(args.content)
    if "paragraphs" not in content or not content["paragraphs"]:
        print("Error: el JSON de contenido no trae 'paragraphs' o está vacío.", file=sys.stderr)
        sys.exit(1)

    n_paragraphs, n_links = build_cv(args.template, content, args.output)
    verify(args.output, n_paragraphs, n_links)
    print(f"OK: {args.output} ({n_paragraphs} párrafos, {n_links} hipervínculos), verificado.")


if __name__ == "__main__":
    main()
