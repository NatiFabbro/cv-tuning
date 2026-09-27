# Contrato de las plantillas DOCX

Las plantillas de `assets/templates/` (`ats-clean.docx`, `visual.docx`) **no tienen contenido**: definen página, tipografía, viñetas y 8 estilos de párrafo. El CV se arma agregando párrafos con esos estilos. Como el formato vive en los estilos y no se aplica formato directo, todos los CVs salen consistentes y cambiar de plantilla no cambia cómo se genera.

Se regeneran con `tools/build-templates.ps1`; no las edites a mano.

## Estilos

El nombre del estilo es igual a su ID (es el formato que espera `assets/scripts/build_cv.py`, y también `python-docx` si alguna vez se usa directo).

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

**Método preferido: `assets/scripts/build_cv.py`.** Es un script del plugin (solo librería estándar de Python, sin dependencias) que hace todo esto en un solo paso: arma el JSON de contenido (un objeto por párrafo, con `style` y `text` o `runs`; ver el encabezado del script para el formato completo y un ejemplo), y llamalo:

```
python assets/scripts/build_cv.py --template assets/templates/<plantilla>.docx --content <json> --output <salida>.docx
```

Con `--content` podés fijar `"lang"` (idioma del documento, obligatorio) y `"page_size"` (`"A4"` por defecto, `"Letter"` para EE. UU./Canadá). El script copia la plantilla, agrega los párrafos con sus estilos, arma los hipervínculos reales, ajusta el idioma y **verifica el archivo guardado releyéndolo** antes de terminar (si algo no cierra, corta con un error en vez de entregar un DOCX a medio armar). Si necesitás instalar Python para poder usarlo, no lo hagas vos: seguí el paso siguiente y decíselo a la persona.

Si no hay Python disponible en el entorno (y no es el momento de instalarlo — ver `setup/SKILL.md`, chequeo de Python), seguí el método manual de abajo: hace exactamente lo mismo, a mano.

### Método manual (si el script no se puede usar)

Casi nunca hace falta: es lo mismo que hace `build_cv.py`, a mano. Usalo solo si el script falla por algo puntual (por ejemplo, la plantilla cambió y ya no encuentra `<w:sectPr>`) y necesitás salir del paso igual.

1. Copiá la plantilla a la carpeta de salida con el nombre final; no modifiques la original.
2. Un `.docx` es un zip. Insertá cada párrafo en `word/document.xml`, justo antes de `<w:sectPr>`, con el estilo por ID y el texto escapado para XML (`&`, `<`, `>`):
   ```xml
   <w:p><w:pPr><w:pStyle w:val="CVVineta"/></w:pPr><w:r><w:t xml:space="preserve">Texto</w:t></w:r></w:p>
   ```
   `zipfile` de la librería estándar de Python alcanza para leer y reescribir el zip.

   Para que un link salga clickeable (comportamiento por defecto, no opcional): la plantilla ya trae dos relaciones (`rId1` para `styles.xml`, `rId2` para `numbering.xml`), así que cada link usa un `rId` propio a partir de `rId3` (el siguiente libre por cada link que agregues en ese documento).
   1. En `word/_rels/document.xml.rels`, agregá una relación por link, justo antes de `</Relationships>`:
      ```xml
      <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="https://linkedin.com/in/persona-demo" TargetMode="External"/>
      ```
      `Target` lleva la URL completa, con `https://`, aunque el texto visible sea solo el dominio.
   2. En `word/document.xml`, envolvé el run del link en un `<w:hyperlink>` con ese mismo `r:id` (el `xmlns:r` se declara ahí mismo, no hace falta tocar la etiqueta raíz `<w:document>`):
      ```xml
      <w:p><w:pPr><w:pStyle w:val="CVContacto"/></w:pPr><w:r><w:t xml:space="preserve">Buenos Aires, Argentina | persona@example.com | </w:t></w:r><w:hyperlink xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" r:id="rId3"><w:r><w:t xml:space="preserve">linkedin.com/in/persona-demo</w:t></w:r></w:hyperlink></w:p>
      ```
3. **Idioma del documento (obligatorio):** con el DOCX ya guardado, volvé a abrirlo como zip y reemplazá, dentro de `word/styles.xml`, el valor de `w:lang` (`w:val`, `w:eastAsia` y `w:bidi`, los tres) por el código que corresponda al idioma de salida (tabla en `locales.md`, sección "Idioma del documento"). Es un simple reemplazo de texto sobre el XML; no hace falta tocar nada más.

### PDF (con cualquiera de los dos métodos)

1. Convertí con LibreOffice en modo headless (`soffice --headless --convert-to pdf --outdir <carpeta> <archivo.docx>`) si está disponible. Si no, decíselo a la persona: el DOCX ya sirve y el PDF se puede exportar desde Word.
2. Contá las páginas del PDF y contrastalas con la longitud pedida. Si sobra, acortá contenido; no achiques la tipografía.
