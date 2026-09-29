# Contrato de archivos en modo chat

Se usa en vez de `workspace-layout.md` cuando `surface-detection.md` determinó modo chat: no hay una carpeta `CV/` que persista entre conversaciones, así que la entrada y la salida de archivos se manejan a mano, por upload y por descarga.

## Entrada: pedir upload

Pedile a la persona que suba, como archivo adjunto, cada archivo que necesites (`perfil.md`, `config.md`, la oferta de trabajo). Nunca asumas que existe un `CV/perfil.md` en algún lado: en esta superficie, "existe" significa "la persona lo subió en algún momento de esta conversación".

Si falta alguno, explicale cuál te falta y de dónde puede salir (por ejemplo, "el que te dejamos al final de tu última conversación de setup") y esperá — no sigas con valores por defecto.

## Salida: entregar para descargar

Cuando generes un archivo (`perfil.md`, `config.md`, el CV en Word y PDF, `postulacion.md`, `job-description.md`), entregalo como descarga en la misma conversación, con el mismo nombre de archivo que usaría `workspace-layout.md` — así queda todo consistente si la persona alguna vez pasa a modo carpeta.

No hay `CV/postulaciones/` ni `CV/historial-perfiles/` persistentes acá: no busques ni chequees colisiones de nombre contra esas carpetas, no existen entre una conversación y otra.

## Empaquetado

Cuando entregues más de un archivo relacionado (por ejemplo `perfil.md` + `config.md` juntos, o el registro completo de una postulación), empaquetalos en un único `.zip` si tu entorno lo permite: reduce el riesgo de que la persona guarde uno y se olvide del otro.

## Qué conservar

Cada vez que entregues archivos, decile a la persona, en una frase, cuáles necesita conservar para una conversación futura (por ejemplo, `perfil.md` y `config.md` siempre; `postulacion.md` y `job-description.md` si quiere retomar esa postulación) y cuáles son solo para uso final (el CV en Word y PDF). El detalle exacto por skill está en `setup/SKILL.md`, `update-profile/SKILL.md` y `tune/SKILL.md`.

## Verificación antes de entregar

Vale la misma lógica que "Verificación de guardado" de `workspace-layout.md`, adaptada a esta superficie: después de generar cualquier archivo (`perfil.md`, `config.md`, el CV, `postulacion.md`, `job-description.md`), no lo des por bueno solo porque la herramienta no devolvió error.

1. **Volvé a leerlo de cero** antes de ofrecerlo para descargar, como una lectura independiente.
2. **Confirmale a la persona con un detalle concreto** de lo que quedó, no con una frase genérica tipo "listo, ya está". Si al releer no podés señalar ese detalle, ahí tenés la señal de que algo no se generó bien.
3. **Si la lectura no muestra lo esperado**, decíselo tal cual y volvé a generarlo antes de ofrecer la descarga.
