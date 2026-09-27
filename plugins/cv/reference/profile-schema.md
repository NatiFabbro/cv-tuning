# Esquema del perfil maestro (`CV/perfil.md`)

El perfil es la **única fuente de hechos** para generar CVs (ver `honesty-rules.md`). Es un archivo markdown con secciones fijas; los skills lo leen y lo escriben siguiendo este esquema. Las secciones opcionales pueden quedar vacías o no aparecer.

## Identificadores

Cada experiencia, logro, estudio, proyecto, certificación y referencia lleva un ID estable. Sirven para trazar de dónde sale cada afirmación de un CV y para que la pasada de verificación pueda contrastarla. Reglas:

- `E1`, `E2`… experiencias · `E1.L1`, `E1.L2`… logros dentro de esa experiencia · `E1.R1`, `E1.R2`… referencias dentro de esa experiencia
- `ED1`… educación · `P1`… proyectos (`P1.L1`… sus logros) · `C1`… certificaciones
- Nunca reutilices ni renumeres un ID existente; los nuevos siguen la numeración. Si algo se borra, su ID queda libre pero no se reasigna.

## Plantilla

```markdown
---
version-esquema: 1
---
# Perfil

## Datos personales
- **Nombre:**
- **Título profesional:**
- **Ubicación:** ciudad, país
- **Email:**
- **Teléfono:**
- **Links:** (LinkedIn, portfolio, GitHub; uno por línea)
- **Autorización de trabajo / disponibilidad:** (opcional)

## Resumen base
Dos o tres líneas solo con hechos del perfil. (opcional)

## Experiencia
### E1 · Rol — Empresa
- **Lugar:** ciudad, país (o remoto)
- **Período:** 2021-03 – actual   (formato AAAA-MM; `actual` si sigue)
- **Descripción:** una o dos líneas de qué hacía
- **Logros:**
  - [E1.L1] Qué hizo, con qué resultado. Métrica exacta si existe.
  - [E1.L2] ...
- **Tecnologías / herramientas:** lista separada por comas
- **Referencias:** (opcional)
  - [E1.R1] Nombre — rol o relación con la persona (ex jefe, colega, cliente) — contacto (teléfono y/o email) — autorizó ser mencionada: sí / no / sin confirmar

## Educación
### ED1 · Título — Institución
- **Período:** 2015 – 2019
- **Detalle:** (opcional) promedio, tesis, honores

## Skills
- **<Grupo>:** skill 1, skill 2 (nivel entre paréntesis si la persona lo declaró)

## Idiomas
- **Español:** nativo
- **Inglés:** intermedio-alto (B2)

## Proyectos
### P1 · Nombre
- **Descripción:**
- **Link:** (opcional)
- **Logros:**
  - [P1.L1] ...

## Certificaciones
- [C1] Nombre — Emisor — año

## Preferencias
- **Roles objetivo:**
- **País y convenciones:** (ver locales.md: foto, fecha de nacimiento, largo, etc.)
- **Idioma por defecto del CV:**
- **Tono:** (sobrio / cercano / técnico…)
- **Longitud:** (1 página / 2 páginas / lo que haga falta)

## No mostrar
- Cosas que la persona no quiere que aparezcan nunca (empleos, datos, fechas, links).

## Pendientes
- Huecos conocidos del perfil: logros sin métrica, fechas dudosas, cosas por confirmar.
```

## Reglas de escritura

- Solo hechos que la persona dijo o que están en un documento suyo. Lo dudoso va a **Pendientes**, no al resto del perfil.
- Los logros llevan la métrica **tal cual** la dio la persona ("redujo el tiempo de carga un 40%"). Si no dio número, el logro va sin número y se anota en **Pendientes**.
- Las fechas se guardan como `AAAA-MM` (o `AAAA`); cómo se muestran lo decide `locales.md`.
- Lo que está en **No mostrar** no se usa en ningún CV, aunque el posting lo pida.
- Idioma del perfil: el que use la persona. La traducción al idioma del posting se hace al generar el CV, sin agregar hechos.
- El perfil no contiene rutas absolutas.
- **Referencias:** son datos personales de un tercero, no de la persona dueña del perfil. Guardá una solo si la persona la aporta, y marcá "autorizó ser mencionada" según lo que ella te confirme: si no lo consultó todavía con esa persona, es "sin confirmar", nunca "sí" por defecto. Una referencia "sin confirmar" o "no" queda en el perfil, pero ningún skill la ofrece para incluir en un CV (ver `tune`).
