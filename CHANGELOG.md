# Changelog

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/). El número de versión es el mismo en `plugins/cv/.claude-plugin/plugin.json` y en `.claude-plugin/marketplace.json` (lo verifica `tools/check-release.mjs`).

## [Unreleased]

## [1.3.1] - 2026-09-29

### Fixed
- `/cv:setup`: si el CV que se sube trae una foto, ya no se guarda en el perfil (no hay campo para eso y las plantillas no la usan). Si la persona pregunta, se le explica que los CVs salen sin foto por ser ATS-first.

## [1.3.0] - 2026-09-29

### Added
- Soporte para uso con **plan Free**: se instala del mismo modo que en Cowork (`Customize → Plugins`), y cada skill detecta solo si hay una carpeta de trabajo conectada o no (`reference/surface-detection.md`). 
    - Sin carpeta conectada (plan Free), los skills piden los archivos de entrada como adjuntos y entregan los de salida para descargar (`reference/chat-file-contract.md`).
    - con carpeta conectada (Cowork), el comportamiento no cambió: lee o escribe en `CV/`.
- Skill `/cv:help`: preguntas frecuentes sobre el uso del plugin en Cowork y en el plan Free (perfil perdido, archivo equivocado, aviso de versión más nueva, cómo retomar una postulación, cómo activar la ejecución de código si no aparece disponible).

### Changed
- `/cv:tune`: 
    - la conversión de DOCX a PDF pasa a ser fail-open. 
    - Sin carpeta conectada (plan Free), si la persona confirma un dato nuevo que no estaba en el perfil, `tune` ya no ofrece correr `/cv:update-profile` como paso aparte: entrega un resumen del dato y un texto listo para copiar y pegar, para no depender de que el perfil siga disponible en otra conversación.

## [1.2.0] - 2026-09-27

Fixes y features de la tercera ronda de pruebas manuales en Cowork, más el script de generación de DOCX.

### Added
- Script `assets/scripts/build_cv.py`: arma el DOCX desde un JSON de contenido (solo librería estándar de Python, sin `python-docx`). Reemplaza el método de rellenar la plantilla a mano en `/cv:tune`, con verificación propia (relee el archivo guardado) antes de darlo por bueno.
- `/cv:setup` chequea en silencio si hay Python disponible y, si no, lo ofrece como mejora opcional en el cierre (nunca bloquea el setup ni el armado del CV): si la persona acepta, la guía paso a paso a instalarlo (`winget` en Windows, `brew` o instalador oficial en Mac).
- `job-description.md` en cada carpeta de postulación: empresa, puesto, link (si la persona compartió uno) y el **texto completo** de la oferta tal como se recibió — a diferencia de `postulacion.md`, que solo guarda un análisis breve. Sirve para volver a leer la oferta más adelante sin depender de que siga disponible en el sitio original.

### Changed
- `reference/template-styles.md`: el método manual de rellenar la plantilla (edición directa del XML del `.docx`) queda como respaldo, para cuando no hay Python disponible o el script falla; ya no duplica la receta de `python-docx`, cubierta ahora por el script.
- `CV/cvs/` y `CV/postulaciones/` se unificaron en una sola carpeta: cada postulación tiene su subcarpeta en `CV/postulaciones/<AAAA-MM-DD_empresa_puesto>/` con el registro (`postulacion.md`), el `.docx` y el `.pdf` juntos, en vez de dos árboles paralelos con el mismo nombre de carpeta/archivo. De paso, la colisión de nombres se resuelve una sola vez (a nivel de la carpeta), no en dos lugares que podían desincronizarse.

### Fixed
- El archivado del perfil (`historial-perfiles/`) volvió a crear `CV/perfil.anterior.md` en una prueba real, aunque la regla ya estaba escrita — probablemente porque el patrón exacto vivía solo en una referencia cruzada (`workspace-layout.md`) que no llegó a leerse. Ahora `setup` y `update-profile` tienen la carpeta y el patrón de nombre en línea, en el propio paso, y prohíben explícitamente el nombre viejo.
- `assets/scripts/build_cv.py` tenía un email y un link de LinkedIn reales hardcodeados en el docstring de ejemplo; reemplazados por datos sintéticos. `tools/check-release.mjs` no lo detectó porque su chequeo de emails no miraba archivos `.py` — ahora sí.

### Notes
- En prueba activa en Cowork.

## [1.1.1] - 2026-09-27

Fixes de la segunda ronda de pruebas manuales en Cowork sobre la 1.1.0.

### Fixed
- `/cv:setup` ya no descarta una fuente si otra ya le alcanzó para armar el perfil: si la persona da un CV y también un link de LinkedIn (u otra combinación), procesa las dos y las combina, y si una está bloqueada pide igual el export para no dejarla afuera sin avisar.
- La regla de "nunca tercera persona" (antes solo en `cv-structure.md`, para `tune`) se extrajo a un contrato compartido (`reference/voz-y-persona.md`) y ahora también la sigue `/cv:setup` al guardar el Resumen base del perfil: antes podía quedar copiado tal cual en tercera persona desde un CV o LinkedIn existente.
- La regla de no mostrar un login ahora cubre también el caso de leer un link con una herramienta de navegador visible (no solo lectura de texto en segundo plano): LinkedIn puede mostrar el cartel de inicio de sesión de forma transitoria mientras carga, aunque el contenido termine siendo legible. Ya no se reintenta con el navegador un link que la lectura en segundo plano marcó como bloqueado, se avisa antes de abrir un navegador si puede pasar esto, y si el cartel llegó a aparecer se informa en el resumen en vez de reportar una lectura limpia.
- El perfil ya no pregunta si reemplazar una única copia `perfil.anterior.md`: `CV/perfil.md` es siempre la versión vigente, y cada versión que se reemplaza (en `/cv:setup` al rehacerlo, o en `/cv:update-profile` al guardar) se archiva sola, con fecha, en `CV/historial-perfiles/`. Nunca hace falta confirmar el archivado, solo el contenido nuevo.
- Nueva regla compartida ("Verificación de guardado" en `workspace-layout.md`): ningún skill reporta un archivo como guardado sin releerlo de cero primero y citar un detalle concreto del cambio. Antes `update-profile` podía decir "guardado" con el archivo real todavía con el contenido viejo (visto en pruebas: una certificación que la persona veía vacía en su compu, aunque el skill había confirmado el guardado).

### Notes
- En prueba activa en Cowork.

## [1.1.0] - 2026-09-27

Fixes de la primera ronda de pruebas manuales en Cowork.

### Added
- Skill `/cv:setup` ahora también arma el perfil desde un link al perfil de LinkedIn de la persona, o desde su export descargable, además de un CV pegado o adjunto.
- Nueva regla dura compartida (`reference/external-links.md`): ningún skill de este plugin muestra ni completa una pantalla de inicio de sesión de un sitio de terceros (LinkedIn u otro). Si un link está bloqueado, se pide que la persona pegue el texto en vez de forzar el acceso o mostrarle el cartel de login.
- Nueva sección opcional de **Referencias** por experiencia en el perfil (nombre, rol o relación, contacto, y si esa persona autorizó ser mencionada). `/cv:tune` solo ofrece incluirlas en un CV puntual si hay al menos una autorizada, y pregunta en qué formato mostrarlas (línea genérica o detalle completo) para esa generación en particular; nunca se arrastra de un CV al siguiente.
- README: pasos de instalación reales en Cowork (`Customize → Plugins → Add marketplace → Discover → Install`), verificados contra la documentación oficial, en reemplazo del texto provisorio anterior; y una segunda sección para quienes quieran hacer un fork y construir skills propias.

### Fixed
- La preferencia explícita de longitud del perfil (`Preferencias → Longitud`) ahora manda siempre. Antes, un "valor por defecto" de 1 o 2 páginas según seniority podía pisarla y generar un CV más corto de lo pedido, cortando de más justo en Habilidades y Herramientas.
- El resumen profesional y las viñetas de experiencia dejaron de escribirse en tercera persona ("Desarrolló", "Participa"). Por defecto ahora usan construcciones nominalizadas en español ("Desarrollo de...", "Participación en..."), sin tiempo verbal que decidir; primera persona solo si la persona lo pide explícitamente.
- La sección de Habilidades usa viñetas reales (`CVVineta`), no un párrafo corrido.
- Al recortar el CV para que entre en la longitud pedida, el resumen profesional nunca queda cortado a media frase: si no entra completo y coherente, se saca entero en vez de dejarlo a medias.
- Los links de contacto y proyectos salen como hipervínculo real **por defecto** (antes era opcional, solo si había `python-docx`), con una receta también para el respaldo por XML puro. Verificado con un lector OOXML real (`System.IO.Packaging`) y una extracción de texto de prueba que no afecta lo que lee un ATS.

### Notes
- En prueba activa en Cowork.

## [1.0.0] - 2026-09-27

### Added
- Marketplace `cv-tuning` con el plugin `cv` (licencia CC0-1.0).
- Skill `/cv:setup`: crea la carpeta `CV/` y arma el perfil maestro desde un CV existente (PDF, Word o texto) o por entrevista, con confirmación antes de guardar.
- Skill `/cv:tune`: analiza un job posting, hace el análisis de gaps contra el perfil, pide confirmación, genera el CV en DOCX + PDF, verifica cada afirmación contra el perfil y registra la ejecución en `CV/postulaciones/`.
- Skill `/cv:update-profile`: agrega o corrige datos del perfil mostrando las diferencias antes de guardar.
- Contratos compartidos en `plugins/cv/reference/`: estructura de la carpeta de trabajo, esquema del perfil, reglas de honestidad, guía ATS, formato de postulaciones, variantes ES/EN y contrato de plantillas.
- Plantillas DOCX `ats-clean` y `visual` (una columna, mismos estilos), generadas con `tools/build-templates.ps1`.
- Guía de estructura y redacción del CV (`reference/cv-structure.md`): secciones, orden por defecto, contenido de cada una, recorte y ejemplos. El orden de secciones solo cambia a pedido de la persona; el skill puede sugerirlo en perfiles junior y en cambios de rubro.
- Evals: 4 perfiles sintéticos, 8 job postings, 14 casos y 18 frases de activación en `evals/`.

### Fixed
- Los tres skills ahora chequean `version-esquema` (perfil) y `version-layout` (`config.md`) antes de leer o escribir; antes solo `tune` lo hacía.
- El idioma interno del documento (`w:lang`) se corrige siempre al generar el CV, para que coincida con su idioma real (antes quedaba fijo en `es-ES` aunque el CV saliera en inglés).
- Un solo checklist de verificación (en `cv-structure.md`); `tune` ya no llevaba una segunda lista parcialmente duplicada.
- Los links de contacto y proyectos pueden salir como hipervínculo real si se genera con `python-docx`.
- Reglas explícitas para nombres de archivo: transliteración de tildes y `ñ`/`ü`, y largo máximo (~50 caracteres, cortado en palabra completa).

### Notes
- Pre-release: todavía no probado en Cowork ni con personas usuarias.
