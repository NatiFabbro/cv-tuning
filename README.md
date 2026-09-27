# cv-tuning

Un plugin de Claude para armar tu perfil profesional una sola vez y **afinar tu CV para cada oferta de trabajo**, sin inventar nada que no esté en tu perfil.

> **Estado: v1.1.0, en prueba activa en Cowork.** Los pasos de instalación siguen la [documentación oficial de Cowork](https://claude.com/docs/cowork/guide/plugins); si tu versión de la interfaz muestra otros nombres, avisame para corregirlo.

Este README tiene dos partes: una para quienes solo quieren **usar** el plugin (no hace falta saber nada técnico), y otra para quienes quieren **hacer un fork** y construir sus propias skills sobre esta misma base.

---

## Instalación y uso (para cualquier persona)

No hace falta saber programar ni entender de "plugins" para usar esto. Seguí estos pasos.

### Cómo se usa (3 pasos)

1. **Instalá el plugin** en Cowork: `Customize` → `Plugins` → `Add marketplace` con `NatiFabbro/cv-tuning` → buscá `cv` en `Discover` e instalalo. (Ver [Instalar y actualizar](#instalar-y-actualizar) para el detalle paso a paso.)
2. **Armá tu perfil, una sola vez.** Conectá una carpeta de trabajo y escribí `/cv:setup`. Podés pasarle tu CV actual (PDF, Word o texto) o contarle tu experiencia si no tenés uno. Te muestra un resumen y no guarda nada hasta que digas que sí.
3. **Adaptá tu CV a cada oferta.** Escribí `/cv:tune` y pegá el texto de la oferta, el link o una captura. Antes de generar nada, te muestra qué va a destacar y qué te falta para el puesto. Cuando confirmás, te entrega el CV en **Word (DOCX) y PDF**.

También podés pedirlo con tus palabras ("armame un CV para esta oferta"); no hace falta escribir el comando.

### Instalar y actualizar

**Instalar:**

1. En Cowork, abrí **Customize** en la barra lateral y elegí **Plugins**.
2. Elegí **Add marketplace** y pegá `NatiFabbro/cv-tuning` (o la URL completa `https://github.com/NatiFabbro/cv-tuning`).
3. Elegí **Discover** para ver los plugins disponibles, buscá **cv** y tocá **Install**. Te va a mostrar los permisos que pide antes de confirmar.
4. Este plugin no usa conectores (no se conecta a ningún servicio externo ni te pide iniciar sesión en nada); con instalarlo ya podés usar `/cv:setup` y `/cv:tune`.

**Actualizar:** en **Customize → Plugins**, buscá el marketplace `cv-tuning` y tocá **Check for updates** (o activá **Sync automatically** para que se actualice solo). Tu perfil y tus CVs no se tocan: viven en tu carpeta de trabajo, no en el plugin.

**Desinstalar:** abrí el plugin `cv` en **Customize → Plugins** y tocá **Remove**.

Superficie soportada: **Cowork primero**. Claude Code y otras IAs quedan para más adelante.

### Qué hace cada comando

| Comando | Para qué |
|---|---|
| `/cv:setup` | Crea tu carpeta `CV/` y tu perfil. Se usa la primera vez. |
| `/cv:tune` | Adapta tu CV a un puesto: analiza la oferta, marca gaps, pide tu OK, genera DOCX + PDF y guarda un registro de la postulación. |
| `/cv:update-profile` | Suma o corrige cosas en tu perfil (un trabajo nuevo, un número que recordaste) mostrándote los cambios antes de guardar. |

### Principios

- **No se inventa nada.** El CV solo usa hechos de tu perfil. Si la oferta pide algo que no tenés, se marca como *gap* y te pregunta; no lo agrega por su cuenta.
- **Vos confirmás antes de generar.** Siempre hay un resumen previo con lo que se destaca y lo que falta.
- **Cada afirmación se contrasta con tu perfil** antes de entregarte el CV.
- **El idioma del CV sigue el de la oferta.**
- **Formato compatible con ATS** (los sistemas que filtran CVs): una columna, sin tablas ni imágenes.

### Tus datos y privacidad

- Tus datos viven **en tu carpeta de trabajo**, en archivos de texto (`CV/perfil.md`, `CV/config.md`, `CV/cvs/`, `CV/postulaciones/`). Podés abrirlos, editarlos o borrarlos cuando quieras.
- El plugin **no tiene servidores propios, no envía datos a ningún lado ni recopila estadísticas.** Los archivos no salen de tu carpeta por obra del plugin.
- Cuando lo usás, tu perfil y las ofertas que pegues **las procesa Claude** dentro de tu sesión, según las condiciones de tu cuenta de Claude. Si no querés que un dato pase por ahí, no lo cargues en el perfil o marcalo en "No mostrar".
- Este repositorio no contiene datos de nadie: todo lo que se usa para pruebas es inventado.
- No subas tu carpeta `CV/` a un repositorio público ni la compartas sin revisarla: tiene tus datos de contacto y tu historial laboral.
- Los archivos no guardan rutas de tu computadora; la carpeta se detecta en cada sesión.

---

## Para quienes quieren hacer un fork y construir skills propias

Esta parte asume que sabés leer JSON y moverte en una terminal. Si solo querés usar el plugin, con la sección de arriba alcanza.

### Estructura del repo

```
.claude-plugin/marketplace.json     Catálogo del marketplace
plugins/cv/                         El plugin (todo lo compartido vive acá dentro)
├── .claude-plugin/plugin.json
├── skills/{setup,tune,update-profile}/SKILL.md
├── reference/                      Contratos compartidos (perfil, honestidad, ATS, layout…)
└── assets/templates/               Plantillas DOCX (ats-clean, visual)
evals/                              Perfiles y ofertas sintéticos + casos de prueba
tools/                              Scripts de desarrollo (plantillas, chequeos de release)
docs/                               Plan de implementación y notas de release
```

### Qué es reutilizable si construís otra skill (u otro plugin) sobre esta base

`plugins/cv/reference/` separa dos capas, y esa separación es la parte más reusable del diseño:

- **Genérico, reusable tal cual** para cualquier skill que maneje datos personales de una persona en una carpeta de trabajo:
  - [`workspace-layout.md`](plugins/cv/reference/workspace-layout.md): el patrón "todo bajo una carpeta, resolvé contra la carpeta activa de la sesión, nunca guardes una ruta absoluta". Sirve para cualquier dominio, no solo CVs.
  - [`profile-schema.md`](plugins/cv/reference/profile-schema.md): el perfil como única fuente de hechos, con IDs estables (`E1.L1`, `P1`…) para trazar de dónde sale cada afirmación.
  - [`honesty-rules.md`](plugins/cv/reference/honesty-rules.md): la regla anti-invención y el tratamiento de contenido de terceros (job postings, o cualquier texto externo) como dato y no como instrucciones.
- **Específico de "generar un CV"**, pensado como ejemplo de cómo escribir el equivalente para otro tipo de documento:
  - [`cv-structure.md`](plugins/cv/reference/cv-structure.md), [`ats-guidelines.md`](plugins/cv/reference/ats-guidelines.md), [`template-styles.md`](plugins/cv/reference/template-styles.md), [`locales.md`](plugins/cv/reference/locales.md), [`postulaciones-format.md`](plugins/cv/reference/postulaciones-format.md). Si armás, por ejemplo, una skill de carta de presentación, el patrón es escribir tu propio `carta-structure.md` pero seguir leyendo el mismo `perfil.md` y las mismas `honesty-rules.md`.

### Cómo agregar una skill nueva

1. Creá `plugins/cv/skills/<nombre>/SKILL.md` con frontmatter `name` y `description` (y `argument-hint` si toma un argumento). La `description` es lo que decide si la skill se activa: escribila con ejemplos concretos de cómo la pediría alguien, no solo el nombre técnico.
2. Al principio del cuerpo, listá qué archivos de `reference/` tiene que leer antes de actuar, y cómo ubicarlos: `${CLAUDE_PLUGIN_ROOT}/reference/…`, con `../../reference/…` como respaldo si esa variable no se resuelve (no está confirmado que Cowork la resuelva).
3. Seguí los mismos patrones que ya usan `setup`, `tune` y `update-profile`: nunca pisar un archivo existente sin mostrarlo y pedir confirmación explícita, checkpoint humano antes de cualquier generación final, y chequeo de la versión del esquema (`version-esquema`, `version-layout`) antes de leer o escribir.
4. Si tu skill genera un documento nuevo, sumá su plantilla a `plugins/cv/assets/templates/` (o a la carpeta equivalente de tu plugin) y regenerala con un script versionado como `tools/build-templates.ps1`, no la edites el `.docx` a mano.

### Si vas a renombrar el plugin

Si además de agregar skills querés que el plugin deje de llamarse `cv` (por ejemplo, para publicar tu propio marketplace con otro nombre y prefijo de comandos):

1. `plugins/cv/.claude-plugin/plugin.json`: campo `name` (define el prefijo de los comandos: `/tunombre:setup`), `homepage` y `repository`.
2. `.claude-plugin/marketplace.json`: `name` del marketplace, `owner`, y la entrada del plugin (`name`, y `source` si también renombrás la carpeta `plugins/cv/`).
3. Si renombrás la carpeta `plugins/cv/`, actualizá las rutas que están escritas a mano en `tools/check-release.mjs` (busca `plugins/cv` ahí) y en `tools/build-templates.ps1`.
4. Actualizá este README con tu propio usuario y repositorio.
5. Corré `claude plugin validate . --strict` y `node tools/check-release.mjs` para confirmar que quedó todo consistente.

### Reglas del repo

- **Nada de datos personales**, ni reales ni de prueba que parezcan reales. Todo fixture es sintético (`example.com`).
- **Sin rutas absolutas** en archivos del plugin, sin symlinks, paths con `/`, y todo lo compartido dentro de `plugins/cv/`.
- Regla anti-invención: ver [honesty-rules.md](plugins/cv/reference/honesty-rules.md).

### Testing y evals

`evals/` no se distribuye con el plugin (los usuarios instalan solo `plugins/cv/`); es el set de pruebas para el desarrollo:

- `fixtures/profiles/` y `fixtures/postings/`: perfiles y ofertas sintéticos (junior, senior, cambio de rubro, no técnico; español e inglés; incluye un caso con inyección de instrucciones dentro del posting).
- `criteria.md`: los criterios de evaluación (cero invención, gaps marcados, checkpoint humano, cobertura de keywords, idioma, longitud, formato ATS…), con cuáles son bloqueantes.
- `evals.json`: los casos de prueba en el formato que espera `skill-creator`, más algunos campos propios (ver [evals/README.md](evals/README.md)).
- `trigger-queries.json`: frases para probar que las `description` de cada skill activan cuando corresponde y no activan de más.

Si agregás una skill nueva, sumale sus propios fixtures y casos siguiendo el mismo esquema.

### Comandos útiles

```bash
claude plugin validate . --strict
node tools/check-release.mjs
```

Las plantillas se regeneran con `./tools/build-templates.ps1`. Para publicar una versión, seguí [docs/RELEASING.md](docs/RELEASING.md).

---

## Licencia

[CC0 1.0 Universal](LICENSE): dominio público, usalo como quieras.
