# Variantes de idioma y país

El idioma del CV **sigue el del job posting** (salvo que `CV/config.md` fije otro). Este archivo dice cómo se escriben las secciones y las fechas en cada idioma, y qué convenciones cambian por país. Los estilos de la plantilla son los mismos en todos los idiomas; solo cambia el texto.

## Elegir el idioma

1. Idioma del posting. Si el posting mezcla idiomas, el del cuerpo del texto de requisitos.
2. Si `config.md` fija un idioma, ese.
3. Si sigue habiendo duda, preguntá una vez y aclará qué idioma vas a usar en el resumen previo.
4. Un solo idioma por CV. El contenido del perfil se traduce; no se agregan hechos al traducir.

## Títulos de sección

| Sección del perfil | `es` | `en` |
|---|---|---|
| Resumen | Perfil profesional | Professional Summary |
| Experiencia | Experiencia laboral | Work Experience |
| Educación | Educación | Education |
| Skills | Habilidades | Skills |
| Idiomas | Idiomas | Languages |
| Proyectos | Proyectos | Projects |
| Certificaciones | Certificaciones | Certifications |

Si hay que usar otro idioma, traducí con el título estándar equivalente en ese idioma (nada creativo: es lo que busca un ATS).

## Idioma del documento (`w:lang`)

Las plantillas traen fijado `es-ES` como idioma del documento (metadato interno del DOCX, no visible; lo usan el corrector ortográfico y gramatical de Word). Si el CV sale en otro idioma y no se corrige, Word va a subrayar como error ortográfico todo el texto: hay que ajustarlo siempre al generar (ver `template-styles.md`, paso "Idioma del documento").

| Idioma del CV | Código a usar |
|---|---|
| `es` | `es-ES` |
| `en` | `en-US` |

Para un idioma sin código en esta tabla, usá el código de idioma y país más común (`pt-BR`, `fr-FR`…); si no estás segura del país, alcanza con el código de dos letras solo (`pt`, `fr`).

## Fechas

| | `es` | `en` |
|---|---|---|
| Rango | `mar 2021 – actual` | `Mar 2021 – Present` |
| Solo año | `2019` | `2019` |
| Meses | ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic | Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec |

Usá el mismo formato en todo el documento. Si el perfil solo tiene el año, mostrá el año; no inventes el mes.

## Convenciones por país

Son tendencias, no reglas. La preferencia de la persona (en **Preferencias** del perfil) manda, y lo que esté en **No mostrar** nunca aparece.

- **EE. UU., Canadá, Reino Unido, Australia:** sin foto, sin fecha de nacimiento, estado civil ni nacionalidad. Normalmente 1 página (2 si hay mucha experiencia).
- **Latinoamérica:** hay variación. Muchas empresas aceptan CV sin foto; datos como edad o estado civil aparecen a veces, pero **no los agregues** salvo que la persona los pida y estén en su perfil.
- **España, Alemania, Francia:** algunos mercados esperan más datos personales o foto, pero las plantillas del plugin son ATS-first y no llevan foto. Si la persona la quiere, decile que ese CV va a ser una versión aparte, fuera de las plantillas ATS.
- Ante la duda, sobrio: sin datos personales sensibles.

## Autorización de trabajo y ubicación

Solo se muestran si están en el perfil. Si el posting los exige y faltan, es un gap (ver `honesty-rules.md`).
