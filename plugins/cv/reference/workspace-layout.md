# Estructura de la carpeta de trabajo

Contrato compartido por todos los skills. Todo vive dentro de una subcarpeta `CV/` de la **carpeta de trabajo activa de la sesión** (la que la persona conectó).

## Regla de rutas

- Nunca escribas rutas absolutas en ningún archivo (ni en `config.md`, ni en registros, ni en mensajes que la persona vaya a copiar). Las rutas cambian entre máquinas y sesiones.
- Resolvé siempre contra la carpeta de trabajo activa y mostrá rutas relativas (`CV/perfil.md`).
- Si no hay carpeta de trabajo conectada, pedile a la persona que conecte una y frená.

## Árbol

```
CV/
├── perfil.md              # perfil maestro vigente: única fuente de hechos (ver profile-schema.md)
├── config.md              # ajustes del plugin (ver abajo)
├── historial-perfiles/    # versiones anteriores de perfil.md, una por cada vez que se reemplazó
│   └── perfil_2026-09-20.md
├── cvs/                   # CVs generados, una subcarpeta por postulación
│   └── 2026-09-26_acme_disenadora-ux/
│       ├── CV_Nombre-Apellido_Acme.docx
│       └── CV_Nombre-Apellido_Acme.pdf
└── postulaciones/         # un registro por ejecución de tune (ver postulaciones-format.md)
    └── 2026-09-26_acme_disenadora-ux.md
```

## Convención de nombres

- **Carpeta y registro:** `AAAA-MM-DD_empresa_puesto`, con `empresa` y `puesto` en minúsculas, espacios reemplazados por guiones y sin diacríticos: quitá tildes (á, é, í, ó, ú) y convertí `ñ` → `n`, `ü` → `u` (por ejemplo, "Diseñadora UX" → `disenadora-ux`). Para otros idiomas, aplicá el mismo criterio con el diacrítico equivalente.
- **Largo máximo:** ~50 caracteres cada uno (`empresa` y `puesto`). Si se pasa, cortá en el último guion completo antes del límite (nunca a mitad de palabra); por ejemplo, `analista-de-datos-para-el-area-de-riesgo` (41) se deja así, pero algo más largo se corta en el guion anterior a los 50.
- **Archivos del CV:** `CV_Nombre-Apellido_Empresa.docx` / `.pdf`. Mismas reglas de diacríticos y largo que arriba.
- Si la carpeta ya existe (misma fecha, empresa y puesto), agregá `_2`, `_3`… No pises nada.
- **Historial de perfiles:** `perfil_AAAA-MM-DD.md` (la fecha del día en que se reemplazó). Si ya existe uno con esa fecha (por ejemplo, dos cambios el mismo día), agregá `_2`, `_3`… igual que con las carpetas de CVs.

## `perfil.md` y su historial

`CV/perfil.md` es siempre la **versión vigente**; nunca hay una pregunta de "¿reemplazo la copia anterior?" porque no hay una sola copia de respaldo que pisar. Cuando `setup` (al rehacer el perfil desde cero) o `update-profile` (al guardar cambios) están por reemplazar el contenido de `perfil.md`:

1. Antes de escribir la versión nueva, **mové** (no copies y dejes ambas) el contenido vigente de `perfil.md` a `CV/historial-perfiles/perfil_AAAA-MM-DD.md`, con el nombre de arriba.
2. Recién ahí escribí la versión nueva en `perfil.md`.

Esto **no necesita confirmación de la persona**: cada versión anterior queda en su propio archivo, con su propia fecha, así que nunca hay nada que sobrescribir ni por qué preguntar. La confirmación que sí hace falta (mostrar el resumen y esperar un sí antes de guardar) es sobre el **contenido nuevo**, no sobre este archivado.

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

Antes de crear cualquier archivo, verificá si ya existe. Nunca pises `config.md`, ni nada dentro de `cvs/`, `postulaciones/` o `historial-perfiles/` sin mostrar qué hay y recibir un sí explícito. `perfil.md` es la única excepción: se reemplaza según "`perfil.md` y su historial" de arriba, sin preguntar por el archivado (la persona sí confirma el contenido nuevo antes de guardar, en cada skill).

## Verificación de guardado

Después de escribir cualquier archivo (`perfil.md`, `config.md`, un CV, un registro de `postulaciones/`), **no des el guardado por hecho todavía.** Que la herramienta de escritura no haya devuelto un error no alcanza como confirmación: hay entornos donde el archivo tarda un momento en reflejarse, o donde el guardado puede fallar en silencio.

1. **Volvé a leer el archivo de cero**, como una lectura independiente. No lo des por bueno solo porque el contenido "tiene sentido" en tu memoria de haberlo escrito recién: leelo de nuevo, de verdad.
2. **Confirmale a la persona con un detalle concreto del cambio**, no con una frase genérica tipo "listo, guardado". Citá o describí específicamente lo que quedó (por ejemplo: "en Certificaciones ahora figura '[C1] Linguaskill General — Cambridge — 2021'"). Si al releer no podés señalar ese detalle concreto, ahí tenés la señal de que algo no se guardó bien — no lo reportes como éxito.
3. **Si la lectura fresca no muestra el cambio esperado**, decíselo a la persona tal cual ("no pude confirmar que el cambio quedó guardado; puede que el archivo tarde un momento en reflejarse, o probá cerrarlo y volver a abrirlo") y reintentá la escritura antes de darlo por perdido.
