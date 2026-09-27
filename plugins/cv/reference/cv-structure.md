# Estructura y redacción del CV

Contrato de contenido para `tune` (paso "Generar el CV"). Dice **qué secciones lleva un CV, en qué orden, qué va en cada una y cómo se escribe**. El formato visual (estilos, tipografía) está en `template-styles.md`; los títulos de sección y las fechas por idioma, en `locales.md`; la regla de no inventar, en `honesty-rules.md` y prevalece sobre todo lo que dice este archivo.

## Principios

- **Una columna, secciones estándar, en un orden fijo** (ver abajo). Quien lee un CV lo recorre rápido de arriba hacia abajo: lo más relevante para el puesto va arriba, dentro de cada sección y en la primera página.
- **Se elige por relevancia, no por cantidad.** El perfil tiene todo; el CV muestra lo que le sirve a *este* puesto. Primero lo que cubre los requisitos excluyentes de la oferta.
- **Omití las secciones sin contenido.** Nunca dejes un título vacío ni rellenes.
- **Nada de lo que está en "No mostrar"** del perfil aparece, aunque la oferta lo pida.
- **Lo que no va, salvo pedido:** edad, fecha de nacimiento, documento de identidad, estado civil y nacionalidad solo se incluyen si están en el perfil **y** la persona lo pidió (ver `locales.md` para las convenciones por país). La foto no se incluye: las plantillas no la llevan.
- **Lo que no va nunca:** expectativa salarial, referencias, la frase "Curriculum Vitae" como título y un "objetivo" genérico.

## Voz y persona gramatical

Ver `voz-y-persona.md` (contrato compartido con `setup`, porque la misma regla ya tenía que aplicarse también al Resumen base del perfil). Se aplica igual acá, al resumen profesional (sección 2), a las viñetas de experiencia (sección 3) y a las de proyectos (sección 5).

## Orden de las secciones

Orden por defecto, que se aplica siempre salvo que la persona pida otro:

1. **Encabezado:** nombre, titular, contacto
2. **Perfil profesional** (opcional)
3. **Experiencia laboral**
4. **Educación**
5. **Proyectos** (solo si suman evidencia)
6. **Certificaciones**
7. **Habilidades**
8. **Idiomas**
9. **Referencias** (solo si la persona lo autorizó para este CV puntual, ver más abajo)

Los títulos exactos, según el idioma del CV, están en `locales.md`.

### Cambiar el orden: solo a pedido

**Nunca cambies el orden por tu cuenta.** Sí podés **sugerirlo** cuando el caso lo amerita, y solo lo aplicás si la persona lo acepta de forma explícita.

**Cuándo sugerirlo** (en el checkpoint de `tune`, paso 5, nunca durante la generación):

- **Persona junior o con poca experiencia relevante** (por ejemplo, menos de un año de experiencia, o experiencia que no tiene que ver con el puesto): sugerí poner **Educación** y **Proyectos** antes de **Experiencia laboral**.
- **Cambio de rubro**, cuando lo más relevante para el puesto es la formación o los proyectos y no los trabajos anteriores: sugerí poner **Educación** y **Proyectos** antes de **Experiencia laboral**.

**Cómo sugerirlo:** con una razón concreta y el orden alternativo, por ejemplo: "Como tu experiencia más relevante para este puesto viene de tu formación y de tus proyectos, podría poner Educación y Proyectos antes de Experiencia laboral. ¿Lo hago así o lo dejo con el orden habitual?". Aclará que si no dice nada, queda el orden habitual.

**Cómo aplicarlo:**

- Solo con un sí claro (por ejemplo "sí, poné la educación primero"). Un silencio, un "ok" al resto del resumen o un "generalo" no cuentan como permiso: ahí se usa el orden por defecto.
- Vale **para ese CV únicamente**. No lo guardes como preferencia ni lo repitas en el siguiente CV sin volver a preguntar.
- Si la persona pide por su cuenta otro orden (aunque no sea uno de los sugeridos), aplicalo también, siempre que respete estas reglas:
  - **Encabezado** y **Perfil profesional** siempre van arriba.
  - Cada sección se mueve entera; su contenido y su orden interno no cambian (siempre cronológico inverso en Experiencia y Educación).
  - Los títulos de sección siguen siendo los estándar de `locales.md`.
- Anotalo en el changelog y en el registro de `postulaciones/` ("Orden de secciones cambiado a pedido: …").

## Sección por sección

### 1. Encabezado

- **Nombre** (`CVNombre`): tal cual está en el perfil.
- **Titular** (`CVTitular`): el título profesional del perfil, o una descripción que el perfil respalde. Se puede ajustar la redacción al puesto si es el mismo rol (por ejemplo, "Ingeniera de datos senior" para una oferta de "Data Engineer"), pero **nunca un título que la persona no tiene**. En un cambio de rubro se usa la descripción honesta del perfil ("Docente en transición a diseño UX"), no el título del puesto al que aspira.
- **Contacto** (`CVContacto`): una sola línea, separada con ` | `: ciudad y país, email, teléfono y hasta 2 links relevantes para el puesto (LinkedIn, portfolio, GitHub). Sin dirección completa. Solo lo que está en el perfil.

### 2. Perfil profesional

- **Qué es:** 2 o 3 líneas (unas 40 a 60 palabras) que resumen quién es la persona para *este* puesto.
- **Estructura:** rol y años de experiencia + especialidad relevante para la oferta + un resultado concreto del perfil.
- **Años de experiencia:** calculalos desde las fechas del perfil y redondeá hacia abajo ("más de 10 años"). Nunca sumes tiempo que las fechas no respaldan.
- **Redacción:** seguí la regla de "Voz y persona gramatical" de más arriba (nominalizado por defecto en español, nunca tercera persona). Sin adjetivos vacíos ("proactivo", "apasionado", "dinámico") que no estén respaldados por un hecho.
- **Siempre coherente, nunca a medias.** Tiene que leerse como una o dos oraciones completas y con sentido. Si al recortarlo (ver "Longitud y cómo recortar") no entra manteniendo esa coherencia, no lo dejes a medio cortar: quitalo entero.
- **Omitilo** si el perfil no da base para un resumen honesto, o si ocuparía el lugar de algo más valioso en una página. En perfiles muy junior, un resumen de una línea o ninguno es mejor que uno inflado.
- **Estilo:** `CVTexto`.

### 3. Experiencia laboral

- **Orden:** cronológico inverso (lo más reciente primero).
- **Cada experiencia:**
  - `CVPuesto`: `Rol — Empresa`, con el rol tal cual figura en el perfil.
  - `CVMeta`: `período · lugar` (fechas según `locales.md`; `actual` / `Present` si sigue).
  - Opcional, `CVTexto`: una línea de contexto solo si aclara algo que las viñetas no dicen (por ejemplo, qué hace una empresa poco conocida).
  - `CVVineta`: los logros.
- **Cuántas viñetas:**
  - Experiencias recientes y muy relevantes para el puesto: 3 a 5 (hasta 6 en la actual si es senior y hay lugar).
  - Experiencias intermedias o de relevancia media: 2 o 3.
  - Experiencias antiguas o poco relevantes: 1 o 2, o solo el encabezado (`CVPuesto` + `CVMeta`) sin viñetas.
- **Orden de las viñetas:** por relevancia para el puesto, no por orden del perfil; primero las que cubren requisitos excluyentes.
- **Largo de cada viñeta:** 1 o 2 líneas (unas 15 a 25 palabras).
- **Cómo se escribe cada viñeta:** acción reformulada según la regla de "Voz y persona gramatical" (más arriba) + qué hizo + resultado o alcance. Sin "responsable de…" cuando el perfil tiene un logro concreto.
- **Métricas:** solo las del perfil, exactas. Sin número, se escribe el alcance que sí esté (cantidad de personas, frecuencia, tipo de clientes) y nada más.
- **La naturaleza del rol se mantiene visible.** Una pasantía, práctica, voluntariado, trabajo freelance o proyecto de curso se muestra como lo que es, en el rol o en la línea de período (por ejemplo `Diseñador UX (proyecto de práctica) — Escuela de Diseño Nube`). No lo presentes como un empleo formal.
- **Huecos entre trabajos:** no los rellenes ni los expliques; las fechas hablan solas.
- **Trabajos antiguos que no aportan:** se omiten, o quedan solo con el encabezado (sin viñetas). Ante la duda, dejá el encabezado.

### 4. Educación

- **Orden:** cronológico inverso.
- **Cada estudio:** `CVPuesto`: `Título — Institución`; `CVMeta`: años (`2015 – 2019`). Si está en curso, `en curso` / `in progress`; no inventes fecha de egreso.
- **Detalle** (promedio, tesis, honores): solo si está en el perfil y ayuda al puesto, sobre todo en perfiles junior. En perfiles senior alcanza con título e institución.
- **Bootcamps y cursos largos:** entran acá si son formación formal del perfil; los cursos cortos irrelevantes se omiten.
- **Secundaria:** se omite si hay estudios superiores (y si figura en el perfil).

### 5. Proyectos

- **Cuándo incluirlos:** cuando aportan evidencia de lo que pide la oferta, y sobre todo si la experiencia laboral es corta o de otro rubro. Si ya sobra evidencia en Experiencia, omitilos.
- **Cuántos:** 1 a 3, los más relevantes.
- **Cada proyecto:** `CVPuesto` con el nombre; `CVMeta` con el link si existe (ver `template-styles.md` para cómo insertarlo); 1 o 2 `CVVineta` con lo que hizo y con qué herramientas, con la misma fórmula que los logros.
- **Nunca** conviertas un proyecto personal o de curso en experiencia profesional.

### 6. Certificaciones

- **Solo las relevantes** para el puesto y las que estén en el perfil.
- **Formato:** una `CVVineta` por certificación: `Nombre — Emisor, año`.

### 7. Habilidades

- **Agrupá** por categoría, tomando los grupos del perfil (hasta 4 grupos; por ejemplo Lenguajes, Datos, Herramientas).
- **Formato:** una `CVVineta` (viñeta real) por grupo: `Grupo: skill, skill, skill`. Nunca un párrafo corrido: en viñetas se lee de un vistazo.
- **Orden dentro del grupo:** primero lo que la oferta pide, con el término exacto de la oferta si el perfil respalda el hecho.
- **Cantidad:** lo relevante, no todo; como referencia, no más de 20 ítems en total.
- **Sin niveles gráficos** (barras, estrellas, puntos). Un nivel en palabras solo si la persona lo declaró en el perfil.
- **Habilidades blandas** ("liderazgo", "comunicación"): solo si están en el perfil y son relevantes; funcionan mejor demostradas en una viñeta que listadas.
- **Nunca** agregues una skill que el perfil no tiene, aunque la oferta la pida.

### 8. Idiomas

- **Formato:** una línea `CVTexto`: `Español: nativo · Inglés: B2`. Incluí el idioma nativo.
- **Niveles:** exactamente como los declara el perfil; nunca los subas para acercarlos a lo que pide la oferta.
- **Los nombres de los idiomas** se escriben en el idioma del CV (`Inglés` en un CV en español; `Spanish` en uno en inglés).

### 9. Referencias

**Nunca aparece por defecto.** El perfil puede tener referencias guardadas para distintas experiencias, pero solo entran en un CV si la persona lo autoriza explícitamente **para esa generación en particular**, en el checkpoint de `tune`. No se arrastra de un CV al siguiente: se pregunta cada vez.

Cuando la persona dice que sí, `tune` pregunta además en qué formato mostrarlas para ese CV:

- **Línea genérica:** un único `CVTexto` con "Referencias disponibles a solicitud" (o el equivalente exacto en el idioma del CV, ver `locales.md`). No expone ningún nombre ni contacto de terceros en el documento.
- **Detalle completo:** una `CVVineta` por cada referencia autorizada: `Nombre — Rol/relación — Contacto`. Nunca incluyas el nombre de la empresa donde trabajó esa referencia si no aporta nada, ni datos de contacto que el perfil no tenga.

En cualquiera de los dos formatos, **usá solo referencias con "autorizó ser mencionada: sí"** en el perfil (`profile-schema.md`). Las que digan "no" o "sin confirmar" nunca se ofrecen ni se incluyen, aunque la persona dueña del perfil diga que sí quiere incluir referencias en general — es la propia referencia la que tiene que haber dado su autorización, no alcanza con que lo pida quien arma el CV.

Si ninguna experiencia incluida en este CV tiene una referencia con autorización "sí", no hay nada para ofrecer: no le preguntes a la persona por esto (ver `tune`, paso del checkpoint).

## Longitud y cómo recortar

**La preferencia explícita del perfil manda siempre.** Si `Preferencias → Longitud` dice "1 página" o "2 páginas", generá el CV pensando en esa extensión: no la cambies por tu cuenta ni la reemplaces por una regla genérica de seniority.

**Si el campo está vacío, o dice "lo que haga falta"**, no le pongas un límite de página fijo: no hay un valor por defecto de 1 o 2 páginas. Incluí todo el contenido relevante para *este* puesto que el perfil respalda (con los mismos criterios de cuántas viñetas por experiencia de más arriba) y dejá que el CV ocupe las páginas que haga falta. Ante la duda, es mejor que quede un poco más largo mostrando algo relevante que corto por haber sacado información que sí aporta — sobre todo habilidades y herramientas, que suelen ser justo lo que un reclutador o un ATS busca. En la práctica esto rara vez da más de 2 o 3 páginas, porque solo entra lo relevante para el puesto (ver "Principios").

Entregar un CV más corto de lo que la persona pidió (cuando hay preferencia explícita) es un error igual de real que pasarse: ella decidió cuánto espacio quiere ocupar, no vos.

Si el CV **con una preferencia explícita** se pasa de esa extensión, recortá **en este orden**, hasta que entre:

1. Viñetas de menor relevancia en las experiencias más antiguas.
2. Experiencias antiguas o irrelevantes: dejá solo el encabezado, sin viñetas.
3. Proyectos que no se relacionan con el puesto.
4. Acortar el perfil profesional **sin romper su coherencia** (sigue siendo una oración completa); si ni así entra, sacalo entero (ver sección 2).
5. Habilidades menos relevantes.
6. Detalles de Educación.

**Lo que no se toca para ganar espacio:** tipografía, márgenes o interlineado; el encabezado; las viñetas que cubren requisitos excluyentes de la oferta.

Con una preferencia explícita de 2 páginas, evitá que la segunda quede casi vacía (unas pocas líneas): recortá hasta que entre en 1 página o sumá contenido relevante que se había dejado afuera, sin inventar.

## Ajustes según el caso (sin cambiar el orden)

- **Junior o poca experiencia:** sin preferencia explícita, no la fuerces a 1 página si hay contenido relevante real que no entraría (ver "Longitud" arriba); los proyectos y la formación se detallan más; las pasantías y voluntariados cuentan como experiencia (con su naturaleza visible). Recordá **sugerir** el orden alternativo (ver arriba).
- **Cambio de rubro:** el perfil profesional explica el puente con hechos del perfil; las viñetas priorizan logros transferibles reales, sin renombrar los cargos anteriores. Recordá **sugerir** el orden alternativo.
- **Senior:** el resumen menciona años y liderazgo si están en el perfil; las experiencias antiguas se condensan; las viñetas con métrica van primero.
- **Perfiles no técnicos:** misma estructura; la sección de Habilidades puede llamarse por lo que contiene (`Herramientas`), respetando los títulos estándar de `locales.md`.
- **Perfil sin métricas:** las viñetas describen alcance (a cuántas personas, con qué frecuencia, para qué clientes) solo con datos del perfil; no se agregan números.

## Ejemplos de viñetas

| Situación | No | Sí |
|---|---|---|
| Persona y tiempo verbal | "Desarrolló dashboards de ventas." / "Participa en reuniones de equipo." *(tercera persona; y la segunda además en presente para un rol pasado)* | "Desarrollo de dashboards de ventas." *(nominalizado: sin persona ni tiempo verbal que decidir)* |
| Vaga, sin resultado | "Responsable de mejorar los procesos de atención." | "Reducción de los reclamos sin resolver a fin de mes, de 40 a 10, con seguimiento semanal de casos." *(si el perfil lo dice)* |
| Inflada | "Lideró el rediseño web de la empresa." | "Maquetado de 6 landing pages responsivas con HTML, CSS y JavaScript a partir de diseños en Figma." *(el perfil dice solo eso)* |
| Keyword sin respaldo | "Experiencia con TypeScript y Next.js." | *(se omite; se usa "JavaScript" y "React", que el perfil sí tiene)* |
| Número inventado | "Mejoró la velocidad un 30%." | "Mejora de la velocidad de carga de las páginas." *(el perfil no da número)* |
| Reformulación válida | "Armé dashboards para ventas." | "Desarrollo de dashboards de ventas." *(mismo hecho, mejor redacción)* |
| Logro de equipo | "Aumentó las ventas de la tienda un 20%." *(lo logró el equipo)* | "Coordinación de un equipo de 12 personas en turnos rotativos." *(lo que el perfil dice)* |
| Primera persona (solo si la persona lo pidió) | "Desarrolló dashboards de ventas." *(tercera persona, aunque la persona pidió primera)* | "Desarrollé dashboards de ventas." / "Coordino un equipo de 12 personas." *(pasado para rol anterior, presente para el actual)* |

## Checklist antes de entregar

Esta es la **única** lista de verificación antes de entregar un CV; `tune` la sigue directamente en su paso de verificación, sin repetirla.

- [ ] El orden es el de por defecto, o uno que la persona aceptó de forma explícita.
- [ ] Ninguna acción está en tercera persona; sigue la nominalización por defecto en español (o primera persona, solo si la persona lo pidió).
- [ ] Solo hay secciones con contenido, con los títulos de `locales.md`.
- [ ] Cada afirmación (cargo, empresa, fecha, logro, número, herramienta, título, idioma, certificación) tiene un ID de origen en el perfil, o un dato que la persona confirmó en esta conversación.
- [ ] Los números coinciden exactamente con los del perfil.
- [ ] Ninguna keyword de la oferta aparece sin respaldo; nada de "No mostrar".
- [ ] Longitud igual a la preferencia explícita del perfil (ni de más ni de menos); sin preferencia, tiene todo el contenido relevante sin forzarlo a una página fija. Sin tocar tipografía ni márgenes en ningún caso.
- [ ] El resumen profesional, si aparece, es una oración completa y con sentido — nunca un fragmento cortado a la mitad.
- [ ] Las habilidades están en viñetas (`CVVineta`), no en un párrafo corrido.
- [ ] Los links de contacto y de proyectos son hipervínculos reales, no solo texto (ver `template-styles.md`).
- [ ] Si hay una sección de Referencias, la persona la autorizó para este CV puntual, y cada referencia de detalle completo tiene "autorizó ser mencionada: sí" en el perfil.
- [ ] Los roles no laborales (pasantía, práctica, proyecto) se ven como tales.
- [ ] El idioma del documento (`w:lang`) coincide con el idioma del CV (ver `locales.md`, "Idioma del documento").
