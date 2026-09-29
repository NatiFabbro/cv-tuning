---
name: help
description: Responde preguntas frecuentes sobre cómo usar este plugin. Usalo cuando pregunten "cómo uso esto", "qué hago si...", "ayuda con mi CV", "no entiendo esto", "perdí mi perfil", "subí el archivo que no era", "qué significa este aviso", o cuando parezcan perdidos sobre qué archivo subir, bajar o conservar.
---

# Ayuda: preguntas frecuentes

## Antes de empezar

Si necesitás confirmar en qué superficie está la persona (por ejemplo, para saber si "perdí mi perfil.md" tiene salida en `CV/historial-perfiles/` o no), leé `${CLAUDE_PLUGIN_ROOT}/reference/surface-detection.md` (o `../../reference/surface-detection.md` si esa variable no se resuelve).

Respondé en criollo, sin jerga técnica, con la pregunta de acá que más se parezca a lo que te preguntaron. Si la pregunta no está en esta lista, contestala igual con lo que sepas del resto de los `reference/`; no te limites a esto.

## ¿Modo carpeta o modo chat? ¿Cuál es la diferencia?

El plugin se instala siempre igual (`Customize → Plugins`), tengas o no Cowork. Lo que cambia es si la conversación tiene una carpeta de trabajo conectada:

- **Con carpeta conectada** (típico en Cowork; acá le decimos modo carpeta): tu perfil y tus CVs se guardan solos ahí (`CV/perfil.md`, `CV/config.md`...). No tenés que subir ni bajar nada a mano.
- **Sin carpeta conectada** (típico en el plan Free, o en cualquier chat sin un proyecto conectado; acá le decimos modo chat): no hay una carpeta que persista entre conversaciones. Cada vez que empezás una conversación nueva tenés que subir tu `perfil.md` (y `config.md` si lo tenés), y al final te dejamos los archivos nuevos para que los descargues vos y los guardes donde quieras.

Si no estás segura de cuál es tu caso: si en algún momento conectaste una carpeta, estás en modo carpeta. Si arrancás una conversación y no hay ninguna carpeta de por medio, estás en modo chat.

## Perdí mi perfil.md

Sin él no podemos armar ni adaptar tu CV, porque es la única fuente de tus datos. Si estás en modo carpeta, fijate si tenés una copia en `CV/historial-perfiles/` (ahí quedan las versiones anteriores, con fecha). Si no encontrás nada, no hay forma de recuperarlo: hay que rehacerlo con `/cv:setup`, pasándole tu CV actual si lo tenés a mano (así no arrancás totalmente de cero).

## Subí el archivo que no era

Decímelo apenas te des cuenta y subí el correcto; no sigo con un archivo equivocado sin que me avises. Si ya guardé algo con datos mal cargados, pedime que lo corrija con `/cv:update-profile`.

## Me aparece un aviso de "tu versión del plugin es más vieja que tu perfil"

Significa que tu `perfil.md` fue escrito por una versión más nueva de este plugin que la que estás usando ahora. Para no arriesgar a perder o mal-interpretar algo de tu perfil, el plugin frena ahí en vez de seguir. Actualizá el plugin a la última versión (`Customize → Plugins → cv-tuning → Check for updates`, tengas o no Cowork) y volvé a intentarlo.

## Quiero retomar una postulación que ya había empezado

Necesito el registro de esa postulación: en modo carpeta, está en `CV/postulaciones/<fecha_empresa_puesto>/postulacion.md` y `job-description.md`. En modo chat, son los dos archivos que te dejamos para descargar la vez que corriste `/cv:tune` para ese puesto — subilos y contame qué querés hacer (por ejemplo, generar una versión nueva del CV, o repasar los gaps que habían quedado).

## No puedo subir ni descargar archivos / dice que necesito activar algo

Andá a **Settings → Capabilities** y activá **"Code execution and file creation"**. Sin esa opción prendida, no puedo leer los archivos que subís ni generarte los tuyos para descargar.
