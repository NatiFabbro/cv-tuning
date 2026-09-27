# Evals del plugin `cv`

Casos de prueba para medir que los skills cumplen las reglas de diseño (sobre todo **cero invención** y **checkpoint antes de generar**). Este directorio no se distribuye con el plugin: los usuarios instalan solo `plugins/cv/`.

## Contenido

| Ruta | Qué es |
|---|---|
| `fixtures/profiles/` | 4 perfiles **sintéticos** en el formato de `plugins/cv/reference/profile-schema.md`: junior, senior, cambio de rubro y no técnico |
| `fixtures/postings/` | 8 job postings ficticios (ES/EN, distintos niveles y rubros), incluido uno con inyección de instrucciones y dos con desajuste grande de perfil |
| `fixtures/cv-text/` | CV en texto plano ficticio para probar la ingesta de `setup` |
| `criteria.md` | Criterios C1–C11 y cómo se comprueba cada uno |
| `evals.json` | 14 casos: perfil × posting × turnos × resultado esperado × criterios |
| `trigger-queries.json` | 18 frases (9 que deben activar un skill, 9 que no) para probar las `description` |

## Reglas

- **Todo es sintético.** Nombres, empresas y contactos son inventados (`example.com`). No agregues datos de personas reales, ni siquiera tuyos, ni CVs reales como fixtures.
- Los fixtures usan nombres como `junior-frontend.md`, no `perfil.md`, para no chocar con el `.gitignore` (que excluye `/perfil.md` y `/CV/` en la raíz).

## Cómo correr un caso

1. Crear un workspace de prueba **fuera del repo** (o usar `/CV/`, que está ignorado por git).
2. Copiar el perfil del caso a `CV/perfil.md` (salvo en los casos con `"profile": null`) y crear `CV/config.md` con los valores por defecto de `workspace-layout.md`.
3. Instalar el plugin y correr los `turns` del caso en orden, pegando el posting o el CV de texto cuando corresponda.
4. Puntuar el resultado con los criterios de `criteria.md` indicados en `criterios`.

## Con `skill-creator`

`evals.json` sigue la forma de `skill-creator` (`id`, `prompt`/`turns`, `expected_output`) con campos extra propios: `skill`, `profile`, `posting` o `input` (fixtures que arma el caso), `idioma_esperado`, `gaps_esperados` y `gaps_esperados_adicionales`, `keywords_respaldadas`, `criterios`, y `notas` cuando hace falta una aclaración. Al correr el ciclo de `skill-creator`, generá los `assertions` a partir de esos campos: cada gap esperado que **no** debe aparecer en el CV y cada keyword respaldada que **sí** debe aparecer son aserciones directas.

Las `description` se optimizan con `trigger-queries.json` (script `run_loop` de `skill-creator`).
