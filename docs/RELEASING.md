# Cómo publicar una versión

Checklist antes de etiquetar un release. Todo tiene que pasar; si algo falla, no se publica.

1. **Validar los manifiestos (obligatorio en cada release):**
   ```bash
   claude plugin validate . --strict
   claude plugin validate plugins/cv --strict
   ```
2. **Chequeo de reglas de diseño** (versiones iguales en ambos manifiestos, sin symlinks, sin rutas absolutas, sin emails reales, skills con frontmatter válido, sin bloques de diagnóstico temporal):
   ```bash
   node tools/check-release.mjs --release
   ```
3. **Versión:** el mismo número en `plugins/cv/.claude-plugin/plugin.json` y en `.claude-plugin/marketplace.json`. Renombrá `[Unreleased]` en `CHANGELOG.md` a `[X.Y.Z] - AAAA-MM-DD` y agregá una sección `[Unreleased]` nueva vacía.
4. **Plantillas al día:** si cambiaste estilos, corré `./tools/build-templates.ps1` y commiteá los `.docx`.
5. **Evals:** correr `evals/evals.json` y confirmar que los criterios bloqueantes (C1, C2, C3, C9, C11) pasan en todos los casos.
6. **Instalación desde cero** en una máquina o cuenta limpia siguiendo solo el README.
7. **Etiquetar y publicar:**
   ```bash
   git tag vX.Y.Z
   git push origin vX.Y.Z
   ```

Los usuarios reciben la nueva versión al actualizar el marketplace en Cowork; por eso la versión debe subir en cada release (si no cambia, los clientes pueden no ver la actualización).
