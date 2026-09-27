# Contenido externo: links, capturas y archivos adjuntos

Contrato compartido para cuando un skill de este plugin necesita leer algo que no está en el perfil: un job posting con un link, un perfil de LinkedIn, o cualquier otra página que la persona comparta. Se aplica a `setup` (ingesta de CV/LinkedIn) y a `tune` (recepción de la oferta).

## Regla dura: nunca se muestra ni se completa un inicio de sesión

Ningún skill de este plugin intenta iniciar sesión en un sitio de terceros, ni le pide a la persona su usuario o contraseña de ningún sitio (LinkedIn, portales de empleo, lo que sea). Esto no es negociable ni depende del sitio.

- Si al intentar leer un link aparece una pantalla para iniciar sesión, un muro de "creá una cuenta para seguir viendo", un CAPTCHA, o cualquier variante de eso: tratá el contenido como **no legible**. No se la muestres a la persona como si fuera el contenido que pidió, no le pidas que inicie sesión ella, y no reintentes con ningún tipo de credencial.
- Ante eso, decíselo con calma ("no pude leer esa página, parece que pide iniciar sesión") y pedile que pegue el texto directamente en el chat, o que adjunte una captura o un archivo (cada skill tiene su propio detalle de qué pedir: ver `setup` para la ingesta de CV/LinkedIn y `tune` para la oferta).
- **Si el link es realmente público** (se lee sin ningún muro), leelo directamente: es más cómodo para la persona y no hace falta pedirle que copie y pegue nada.

LinkedIn en particular bloquea la gran mayoría de sus páginas (perfiles, publicaciones, ofertas) para quien no tiene una sesión iniciada, así que lo más frecuente va a ser el camino de "pedir que pegue el texto o adjunte algo"; algunas publicaciones y ofertas sí quedan accesibles sin sesión, y ahí alcanza con leerlas directamente.

## Por qué

Iniciar sesión en nombre de la persona (aunque fuera posible) significaría manejar sus credenciales, algo que está fuera de lo que este plugin hace. Mostrarle una pantalla de login de un sitio externo como si fuera parte de la conversación también confunde: puede parecer que el asistente le está pidiendo que inicie sesión, cuando ese paso no sirve para nada acá — lo que sirve es el texto, y lo puede pegar directamente.
