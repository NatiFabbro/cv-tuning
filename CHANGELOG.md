# Changelog

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/). El número de versión es el mismo en `plugins/cv/.claude-plugin/plugin.json` y en `.claude-plugin/marketplace.json` (lo verifica `tools/check-release.mjs`).

## [Unreleased]

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
