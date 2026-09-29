# Detección de superficie (modo carpeta vs. modo chat)

Contrato compartido por `setup`, `update-profile`, `tune` y `help`. Leelo primero, antes que el resto de los `reference/`, una sola vez por conversación.

## Cómo decidir

Al principio de la sesión, fijate si tu contexto incluye un anuncio de entorno con un directorio de trabajo persistente (por ejemplo, un bloque que diga algo como "Primary working directory") y herramientas de archivo (leer/escribir/editar/ejecutar comandos) atadas a esa ruta.

- **Si lo hay:** estás en **modo carpeta** (Cowork, Claude Code). Seguí usando `CV/` tal como describen `workspace-layout.md` y el resto de los `reference/`, sin cambios.
- **Si no lo hay** (solo tenés una herramienta de ejecución de código en una sandbox, sin ningún proyecto nombrado): estás en **modo chat** — un chat sin una carpeta de trabajo conectada, tengas o no el plan Cowork. Seguí `chat-file-contract.md` en vez de `workspace-layout.md` para todo lo que sea leer o guardar archivos.
- **Si no podés determinarlo con certeza:** tratalo como modo chat. Es el comportamiento más conservador: pedir un archivo de más nunca rompe nada; asumir una carpeta que no existe, sí.

## Una sola vez por conversación

No repitas este chequeo en cada paso, ni si te invocan de nuevo más adelante en la misma conversación (por ejemplo, `tune` derivando a `setup`). Si ya determinaste la superficie antes en esta conversación, reutilizá esa conclusión.
