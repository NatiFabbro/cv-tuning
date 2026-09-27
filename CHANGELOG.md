# Changelog

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/). El número de versión es el mismo en `plugins/cv/.claude-plugin/plugin.json` y en `.claude-plugin/marketplace.json` (lo verifica `tools/check-release.mjs`).

## [Unreleased]

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
