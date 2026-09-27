---
name: setup
description: Prepara tu carpeta de trabajo de CV y arma tu perfil profesional (la base de todos tus CVs). Usalo la primera vez, o cuando pidan "armar mi perfil", "configurar mi CV", "empezar con mi CV", "cargar mi CV", "crear mi carpeta de CV" o "no tengo CV y quiero hacer uno". Funciona con un CV existente (PDF, Word o texto pegado), un link o export de LinkedIn, o desde cero con una entrevista.
---

# Setup: armar la carpeta de trabajo y el perfil

Ayudás a una persona a dejar lista su carpeta de CV y su **perfil maestro**: un archivo con todos sus datos y logros reales, del que después salen los CVs adaptados a cada puesto. Todo lo que se escriba acá tiene que ser verdad y venir de la persona.

Escribí para gente no técnica: frases cortas, una pregunta por vez, sin palabras como "markdown", "esquema", "parsear" o "ID". Si tenés que nombrar un archivo, decí "tu perfil" y, entre paréntesis, `CV/perfil.md`.

## Antes de empezar

Los contratos compartidos están en `${CLAUDE_PLUGIN_ROOT}/reference/`. Si esa variable no se resuelve, usá la ruta relativa a la carpeta de este skill: `../../reference/`. Leé, en este orden:

1. `workspace-layout.md`: dónde va cada cosa y las reglas de rutas.
2. `profile-schema.md`: cómo se escribe el perfil (secciones, IDs, reglas).
3. `honesty-rules.md`: reglas sobre cómo tratar los datos, por ejemplo: no inventar nada.
4. `external-links.md`: cómo (y cuándo no) leer un link de LinkedIn u otro sitio.
5. `voz-y-persona.md`: cómo redactar el Resumen base (nunca en tercera persona).

## 1. Carpeta de trabajo

Trabajá dentro de la **carpeta de trabajo activa de esta sesión**. Si no hay ninguna conectada, pedile a la persona que conecte una carpeta (una donde quiera guardar sus CVs) y esperá. No escribas rutas absolutas en ningún archivo; en mensajes mostrá siempre rutas relativas.

## 2. Ver qué hay (no pisar nada)

Buscá `CV/` y dentro `perfil.md` y `config.md`.

- si **No existe nada:** seguí con el paso 3.
- si **Existe `CV/perfil.md`:** si su `version-esquema` es mayor a la que conocés (`1`), avisale a la persona que tu versión del plugin es más vieja que su perfil y frená ahí (no lo toques). Si no, contale, en una línea, qué tiene (nombre y cantidad de experiencias). Preguntale qué prefiere: (a) dejarlo como está y salir, (b) agregarle cosas (derivá a `/cv:update-profile`), o (c) rehacerlo desde cero. Solo con un sí claro a (c) seguí, y antes de escribir archivá el perfil vigente en `CV/historial-perfiles/` con la convención de `workspace-layout.md` (nunca hace falta preguntar por esto: cada versión queda en su propio archivo con fecha, no se pisa nada).
- si **Existe `CV/` pero le falta `config.md` o alguna subcarpeta:** completá lo que falta, sin tocar lo demás, y avisale. Si `config.md` ya existe y su `version-layout` es mayor a la que conocés (`1`), no es motivo para frenar: avisá que hay un ajuste que no reconocés y usá los valores por defecto de `workspace-layout.md`.

## 3. Ingesta: ¿tiene un CV o LinkedIn?

Preguntá: "¿Tenés un CV actual, o preferís arrancar desde tu LinkedIn? Podés pasarme un PDF, un Word, texto pegado, el link a tu perfil de LinkedIn, o un archivo exportado de ahí. Si no tenés nada de eso, no hay problema: lo armamos conversando."

**Si te da más de una fuente** (por ejemplo, un CV y también un link de LinkedIn), procesá **todas**, no solo la primera que puedas leer. Que una fuente ya te haya dado datos suficientes para armar un perfil **no es motivo para dejar de lado otra que la persona también te pasó**: ella quiere que se combinen, no que elijas una. Si una de las fuentes no se puede leer (por ejemplo, LinkedIn bloqueado) pero otra sí, no asumas que ya tenés todo lo que hacía falta: explicale que esa fuente en particular no se pudo leer y pedile lo que corresponda para poder incluirla igual (ver 3b, paso 3, para LinkedIn). Seguí sin ella solo si la persona te dice explícitamente que no hace falta.

**Si combinás más de una fuente:** no dupliques la misma experiencia o logro si aparece en ambas (quedate con la versión más completa, o combiná los detalles de las dos). Si hay una diferencia real entre fuentes para el mismo dato (por ejemplo, distinta fecha de inicio en el mismo puesto), no elijas vos cuál vale: mostrale las dos versiones y preguntale cuál es la correcta.

### 3a. Tiene CV (archivo adjunto o texto pegado)

1. Leelo con lo que haya disponible. Si es un PDF escaneado o una imagen, leelo visualmente. Si no podés leer el archivo, decilo y pedile que pegue el texto.
2. Extraé los datos al esquema del perfil (`profile-schema.md`): datos personales, experiencias con sus logros, educación, skills, idiomas, proyectos, certificaciones. Asigná los IDs (`E1`, `E1.L1`…).
3. **Extraé solo lo que está escrito.** No completes fechas, cargos ni números que falten; lo dudoso o faltante va a **Pendientes**. Respetá los números tal cual aparecen.
4. Si el CV no tiene fechas o el orden es confuso, preguntá antes de suponer.
5. **Si el CV o el LinkedIn trae un resumen o "Acerca de" ya escrito**, no lo copies tal cual al **Resumen base**: reformulalo siguiendo `voz-y-persona.md` (nunca tercera persona; nominalizado por defecto en español). Los hechos que cuenta se mantienen igual, cambia solo cómo está redactado.

### 3b. Pasó un link a su perfil de LinkedIn

1. Intentá abrir el link (regla de `external-links.md`: si aparece una pantalla para iniciar sesión o cualquier muro parecido, es contenido no legible; **nunca la muestres ni le pidas a la persona que inicie sesión**).
2. **Si se puede leer** (sin ningún muro de por medio): extraé los datos igual que en 3a (puntos 2 a 5): solo lo que está escrito, con los mismos IDs, y el resumen reformulado según `voz-y-persona.md` si trae uno.
3. **Si está bloqueado:** es lo más frecuente, LinkedIn no deja ver casi ningún perfil sin sesión iniciada. Decíselo con calma y pedile una de estas dos cosas, lo que le resulte más fácil:
   - Un PDF de su perfil: en LinkedIn, desde su perfil, "Más" (o los tres puntos) → "Guardar en PDF" (el nombre exacto puede variar según el idioma de su cuenta).
   - El archivo completo que exporta LinkedIn: "Configuración y privacidad" → "Privacidad de los datos" → "Obtener una copia de tus datos".
   Cuando te lo pase, procesalo igual que un CV pegado (3a).
4. Guardá el link de LinkedIn en **Datos personales → Links**, se haya podido leer el contenido o no.

### 3c. No tiene ni CV ni LinkedIn

Armá el perfil por entrevista, una sección por vez, en este orden: datos de contacto, experiencia laboral (empezá por el trabajo más reciente), estudios, skills, idiomas, y proyectos o certificaciones si los hay. Para cada experiencia preguntá: qué puesto tenía, dónde, cuándo (mes y año aproximados están bien), qué hacía y qué logró. Si la persona no tiene experiencia laboral formal, seguí con estudios, proyectos, voluntariados y trabajos informales: también cuentan y son hechos reales.

Si dice "no sé qué poner", sugerí preguntas concretas ("¿qué era lo que más te pedían en ese trabajo?", "¿algo que hayas mejorado o resuelto?"). No propongas logros: preguntá y anotá lo que responda.

## 4. Entrevista de huecos

Cuando tengas la base (de 3a y/o 3b combinadas, o de 3c), revisá qué falta y preguntá **solo eso**, sin repetir lo ya cubierto:

- **Logros sin métrica:** por cada logro importante sin número, preguntá "¿recordás algún número, aunque sea aproximado (personas, tiempo, dinero, porcentajes)? Si no, lo dejamos sin número." No sugieras cifras: empuja a inventar (`honesty-rules.md`, regla 5).
- **Roles objetivo:** a qué tipo de puestos quiere postularse.
- **País y convenciones:** dónde busca trabajo (`locales.md`); qué datos prefiere incluir u omitir.
- **Idioma:** en qué idioma escribe normalmente y en cuál quiere el CV por defecto (recordale que, si no dice otro, el CV sale en el idioma de cada oferta).
- **Tono:** sobrio, cercano, técnico.
- **Longitud:** 1 página, 2 páginas o lo que haga falta.
- **Qué omitir:** empleos, fechas, datos o links que no quiere que aparezcan nunca.
- **Referencias:** preguntá una sola vez, en general, si para alguno de sus trabajos anteriores quiere guardar el contacto de alguien que pueda dar una referencia (un ex jefe, colega o cliente). Es opcional. Si dice que sí, por cada una pedile: nombre, de qué trabajo, cómo contactarla (teléfono y/o email), y preguntale explícitamente **"¿esta persona sabe que la vas a poner como referencia y está de acuerdo?"**. Guardá la respuesta tal cual (sí / no / no lo consulté todavía) — nunca asumas un sí.

Todo lo que siga sin respuesta se anota en **Pendientes**. Está bien que queden pendientes; no insistas.

## 5. Confirmación antes de guardar

Mostrale un **resumen legible** del perfil (no el archivo crudo): datos personales, cada experiencia con sus logros, estudios, skills, idiomas, preferencias, referencias (si las hay, con su estado de autorización), lo que no se muestra y los pendientes. Preguntá: "¿Está todo bien? ¿Querés cambiar o sacar algo?". Aplicá los cambios y repetí el resumen de lo modificado. **No guardes nada hasta recibir un sí claro.**

## 6. Guardar

Con la confirmación:

1. Creá, si no existen, `CV/`, `CV/cvs/` y `CV/postulaciones/`.
2. Escribí `CV/perfil.md` siguiendo `profile-schema.md`.
3. Si no existe, escribí `CV/config.md` con los valores por defecto de `workspace-layout.md` (plantilla `ats-clean`, formatos `docx, pdf`, idioma "según el posting"), ajustando el idioma solo si la persona pidió uno fijo. **No guardes rutas absolutas** en ningún archivo.
4. Verificá el guardado según `workspace-layout.md` ("Verificación de guardado"): releelo de cero, no lo des por hecho.

## 7. Cierre

Decile en dos o tres frases qué se creó (con rutas relativas: `CV/perfil.md`, `CV/config.md`), citando un detalle concreto de lo que confirmaste al releer (por ejemplo, algo de su primera experiencia), no solo "listo, guardado". Contale que sus datos quedan en su carpeta y que el siguiente paso es pasarle un puesto: "Cuando tengas una oferta, escribime `/cv:tune` y pegá el texto, el link o una captura". Si quedaron pendientes, mencioná cuántos y que puede completarlos cuando quiera con `/cv:update-profile`.

## Diagnóstico (temporal, hasta cerrar la Fase 2 del plan)

Solo mientras se valida el plugin en Cowork, al final agregá un bloque breve "Diagnóstico" que diga: qué carpeta detectaste como carpeta de trabajo (nombre, no ruta completa), si `${CLAUDE_PLUGIN_ROOT}` se resolvió o usaste la ruta relativa, y cómo llegó la base del perfil (archivo, texto pegado, link de LinkedIn leído, link de LinkedIn bloqueado + export recibido, o ninguno). Se elimina este bloque antes del release v0.1.0.
