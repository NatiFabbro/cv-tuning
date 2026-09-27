# Contrato de las plantillas DOCX

Las plantillas de `assets/templates/` (`ats-clean.docx`, `visual.docx`) **no tienen contenido**: definen página, tipografía, viñetas y 8 estilos de párrafo. El CV se arma agregando párrafos con esos estilos. Como el formato vive en los estilos y no se aplica formato directo, todos los CVs salen consistentes y cambiar de plantilla no cambia cómo se genera.

Se regeneran con `tools/build-templates.ps1`; no las edites a mano.

## Estilos

El nombre del estilo es igual a su ID (es lo que busca `python-docx`).

| Estilo | Para qué |
|---|---|
| `CVNombre` | Nombre de la persona (una vez, arriba) |
| `CVTitular` | Título profesional / titular, debajo del nombre |
| `CVContacto` | Una línea de contacto: ubicación, email, teléfono, links, separados por ` | ` |
| `CVSeccion` | Título de sección (se muestra en mayúsculas; el texto se escribe normal) |
| `CVPuesto` | `Rol — Empresa`, `Título — Institución`, nombre de proyecto |
| `CVMeta` | Línea de período y lugar: `mar 2021 – actual · Buenos Aires, Argentina` |
| `CVTexto` | Párrafo normal: resumen, descripción, una línea de skills o idiomas |
| `CVVineta` | Un logro (viñeta real de lista; no escribas el carácter `•`) |

## Qué estilo lleva cada elemento

Este es el mapa técnico. **Qué secciones van, en qué orden, qué contiene cada una y cómo se redacta** está en `cv-structure.md`; los títulos y las fechas por idioma, en `locales.md`. El orden de abajo es el orden por defecto; solo cambia si la persona lo pidió (ver `cv-structure.md`).

```
CVNombre
CVTitular
CVContacto
CVSeccion   Perfil profesional          (si hay resumen)
CVTexto
CVSeccion   Experiencia laboral
  CVPuesto  Rol — Empresa
  CVMeta    período · lugar
  CVTexto   descripción breve           (opcional)
  CVVineta  logro
  CVVineta  logro
  (repetir por experiencia, más reciente primero)
CVSeccion   Educación
  CVPuesto  Título — Institución
  CVMeta    años
CVSeccion   Proyectos                   (si aplican)
  CVPuesto  Nombre del proyecto
  CVMeta    link
  CVVineta  logro
CVSeccion   Certificaciones             (si aplican)
  CVVineta  Nombre — Emisor, año
CVSeccion   Habilidades
  CVVineta  Grupo: skill, skill, skill  (una viñeta por grupo)
CVSeccion   Idiomas
  CVTexto   Español: nativo · Inglés: B2
CVSeccion   Referencias                  (solo si la persona lo autorizó para este CV)
  CVTexto   Referencias disponibles a solicitud     (formato "línea genérica")
  CVVineta  Nombre — Rol/relación — Contacto        (formato "detalle completo", una por referencia)
```

Omití las secciones sin contenido; no dejes títulos vacíos.

## Reglas

- Sin formato directo: no cambies fuente, tamaño, color ni negrita a mano. Si algo no se ve bien, se corrige en el contenido (más corto) o en la plantilla, no en el CV.
- Sin tablas, imágenes, encabezados ni pies (ver `ats-guidelines.md`).
- Los links (contacto, proyectos) se muestran siempre como el texto de la URL (`linkedin.com/in/...`), nunca con un texto genérico tipo "ver perfil", y **siempre como hipervínculo real** (clickeable), con los dos métodos de más abajo. Un hipervínculo real no perjudica al ATS: es un contenedor alrededor de un run de texto normal, y el texto visible se extrae exactamente igual que cualquier otro texto del documento (así leen un `.docx` python-docx, docx2txt, Apache Tika y en general cualquier motor de ATS). Solo si ninguno de los dos métodos funciona, dejalo como texto plano y decíselo a la persona.
- El cuerpo de la plantilla viene vacío: agregá los párrafos en orden, sin dejar párrafos vacíos.
- Tamaño de página: A4 por defecto. Para EE. UU. y Canadá usá Carta (Letter): ancho 8.5", alto 11".
- **Idioma del documento:** las plantillas traen `es-ES` fijado como idioma interno. Es un paso obligatorio, no opcional (ver más abajo, "Idioma del documento"): si el CV no sale en español, hay que corregirlo, o el corrector de Word subraya como error todo el texto.

## Cómo rellenar (sin instalar nada)

1. Copiá la plantilla a la carpeta de salida con el nombre final; no modifiques la original.
2. Con `python-docx` (si está disponible):
   ```python
   from docx import Document
   from docx.shared import Inches

   doc = Document("CV_Nombre-Apellido_Empresa.docx")   # la copia
   # Solo EE. UU. / Canadá:
   # s = doc.sections[0]; s.page_width, s.page_height = Inches(8.5), Inches(11)

   doc.add_paragraph("Nombre Apellido", style="CVNombre")
   doc.add_paragraph("Diseñadora UX", style="CVTitular")
   doc.add_paragraph("Buenos Aires, Argentina | persona@example.com", style="CVContacto")
   doc.add_paragraph("Experiencia laboral", style="CVSeccion")
   doc.add_paragraph("Rol — Empresa", style="CVPuesto")
   doc.add_paragraph("mar 2021 – actual · Remoto", style="CVMeta")
   doc.add_paragraph("Logro con su métrica.", style="CVVineta")
   doc.save("CV_Nombre-Apellido_Empresa.docx")
   ```
   Para que un link salga clickeable (es el comportamiento por defecto, no opcional), usá una función auxiliar, porque `python-docx` no trae una directa:
   ```python
   from docx.oxml.ns import qn
   from docx.oxml import OxmlElement

   def add_hyperlink(paragraph, url, text):
       part = paragraph.part
       r_id = part.relate_to(
           url,
           "http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink",
           is_external=True,
       )
       hyperlink = OxmlElement("w:hyperlink")
       hyperlink.set(qn("r:id"), r_id)
       run = OxmlElement("w:r")
       run.append(OxmlElement("w:rPr"))
       t = OxmlElement("w:t")
       t.text = text
       run.append(t)
       hyperlink.append(run)
       paragraph._p.append(hyperlink)

   p = doc.add_paragraph(style="CVMeta")
   add_hyperlink(p, "https://linkedin.com/in/...", "linkedin.com/in/...")
   ```
3. Si `python-docx` no está: un `.docx` es un zip. Insertá cada párrafo en `word/document.xml`, justo antes de `<w:sectPr>`, con el estilo por ID y el texto escapado para XML (`&`, `<`, `>`):
   ```xml
   <w:p><w:pPr><w:pStyle w:val="CVVineta"/></w:pPr><w:r><w:t xml:space="preserve">Texto</w:t></w:r></w:p>
   ```
   `zipfile` de la librería estándar de Python alcanza para leer y reescribir el zip.

   Para que un link salga clickeable con este método (también es el comportamiento por defecto, no solo con `python-docx`): la plantilla ya trae dos relaciones (`rId1` para `styles.xml`, `rId2` para `numbering.xml`), así que cada link usa un `rId` propio a partir de `rId3` (el siguiente libre por cada link que agregues en ese documento).
   1. En `word/_rels/document.xml.rels`, agregá una relación por link, justo antes de `</Relationships>`:
      ```xml
      <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="https://linkedin.com/in/persona-demo" TargetMode="External"/>
      ```
      `Target` lleva la URL completa, con `https://`, aunque el texto visible sea solo el dominio.
   2. En `word/document.xml`, envolvé el run del link en un `<w:hyperlink>` con ese mismo `r:id` (el `xmlns:r` se declara ahí mismo, no hace falta tocar la etiqueta raíz `<w:document>`):
      ```xml
      <w:p><w:pPr><w:pStyle w:val="CVContacto"/></w:pPr><w:r><w:t xml:space="preserve">Buenos Aires, Argentina | persona@example.com | </w:t></w:r><w:hyperlink xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" r:id="rId3"><w:r><w:t xml:space="preserve">linkedin.com/in/persona-demo</w:t></w:r></w:hyperlink></w:p>
      ```
4. **Idioma del documento (obligatorio):** con el DOCX ya guardado, volvé a abrirlo como zip y reemplazá, dentro de `word/styles.xml`, el valor de `w:lang` (`w:val`, `w:eastAsia` y `w:bidi`, los tres) por el código que corresponda al idioma de salida (tabla en `locales.md`, sección "Idioma del documento"). Es un simple reemplazo de texto sobre el XML; no hace falta tocar nada más.
5. PDF: convertí con LibreOffice en modo headless (`soffice --headless --convert-to pdf --outdir <carpeta> <archivo.docx>`) si está disponible. Si no, decíselo a la persona: el DOCX ya sirve y el PDF se puede exportar desde Word.
6. Contá las páginas del PDF y contrastalas con la longitud pedida. Si sobra, acortá contenido; no achiques la tipografía.
