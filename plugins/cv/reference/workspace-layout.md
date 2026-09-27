# Estructura de la carpeta de trabajo

Contrato compartido por todos los skills. Todo vive dentro de una subcarpeta `CV/` de la **carpeta de trabajo activa de la sesión** (la que la persona conectó).

## Regla de rutas

- Nunca escribas rutas absolutas en ningún archivo (ni en `config.md`, ni en registros, ni en mensajes que la persona vaya a copiar). Las rutas cambian entre máquinas y sesiones.
- Resolvé siempre contra la carpeta de trabajo activa y mostrá rutas relativas (`CV/perfil.md`).
- Si no hay carpeta de trabajo conectada, pedile a la persona que conecte una y frená.

## Árbol

```
CV/
├── perfil.md          # perfil maestro: única fuente de hechos (ver profile-schema.md)
├── config.md          # ajustes del plugin (ver abajo)
├── cvs/               # CVs generados, una subcarpeta por postulación
│   └── 2026-09-26_acme_disenadora-ux/
│       ├── CV_Nombre-Apellido_Acme.docx
│       └── CV_Nombre-Apellido_Acme.pdf
└── postulaciones/     # un registro por ejecución de tune (ver postulaciones-format.md)
    └── 2026-09-26_acme_disenadora-ux.md
```

## Convención de nombres

- **Carpeta y registro:** `AAAA-MM-DD_empresa_puesto`, con `empresa` y `puesto` en minúsculas, espacios reemplazados por guiones y sin diacríticos: quitá tildes (á, é, í, ó, ú) y convertí `ñ` → `n`, `ü` → `u` (por ejemplo, "Diseñadora UX" → `disenadora-ux`). Para otros idiomas, aplicá el mismo criterio con el diacrítico equivalente.
- **Largo máximo:** ~50 caracteres cada uno (`empresa` y `puesto`). Si se pasa, cortá en el último guion completo antes del límite (nunca a mitad de palabra); por ejemplo, `analista-de-datos-para-el-area-de-riesgo` (41) se deja así, pero algo más largo se corta en el guion anterior a los 50.
- **Archivos del CV:** `CV_Nombre-Apellido_Empresa.docx` / `.pdf`. Mismas reglas de diacríticos y largo que arriba.
- Si la carpeta ya existe (misma fecha, empresa y puesto), agregá `_2`, `_3`… No pises nada.

## `config.md`

Ajustes que no son datos del perfil. Solo datos relativos y portables:

```markdown
---
version-layout: 1
---
# Configuración

- **Plantilla:** ats-clean
- **Formatos de salida:** docx, pdf
- **Idioma de la salida:** según el posting
```

- `Plantilla`: `ats-clean` (por defecto) o `visual`.
- `Idioma de la salida`: `según el posting` (por defecto) o un idioma fijo (`es`, `en`).
- No guardes acá la ruta de la carpeta de trabajo.
- Si `version-layout` es mayor a la que conocés (`1`), no es motivo para frenar: `config.md` solo tiene un par de ajustes. Avisale a la persona que hay un ajuste que tu versión no reconoce, usá los valores por defecto de esta página para lo que no entiendas, y seguí.

## Idempotencia

Antes de crear cualquier archivo, verificá si ya existe. Nunca pises `perfil.md`, `config.md`, ni nada dentro de `cvs/` o `postulaciones/` sin mostrar qué hay y recibir un sí explícito.
