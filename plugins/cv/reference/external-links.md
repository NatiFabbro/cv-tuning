# Contenido externo: links, capturas y archivos adjuntos

Contrato compartido para cuando un skill de este plugin necesita leer algo que no está en el perfil: un job posting con un link, un perfil de LinkedIn, o cualquier otra página que la persona comparta. Se aplica a `setup` (ingesta de CV/LinkedIn) y a `tune` (recepción de la oferta).

## Regla dura: nunca se muestra ni se completa un inicio de sesión

Ningún skill de este plugin intenta iniciar sesión en un sitio de terceros, ni le pide a la persona su usuario o contraseña de ningún sitio (LinkedIn, portales de empleo, lo que sea). Esto no es negociable ni depende del sitio.

- Si al intentar leer un link aparece una pantalla para iniciar sesión, un muro de "creá una cuenta para seguir viendo", un CAPTCHA, o cualquier variante de eso: tratá el contenido como **no legible**. No se la muestres a la persona como si fuera el contenido que pidió, no le pidas que inicie sesión ella, y no reintentes con ningún tipo de credencial.
- Ante eso, decíselo con calma ("no pude leer esa página, parece que pide iniciar sesión") y pedile que pegue el texto directamente en el chat, o que adjunte una captura o un archivo (cada skill tiene su propio detalle de qué pedir: ver `setup` para la ingesta de CV/LinkedIn y `tune` para la oferta).
- **Si el link es realmente público** (se lee sin ningún muro), leelo directamente: es más cómodo para la persona y no hace falta pedirle que copie y pegue nada.

LinkedIn en particular bloquea la gran mayoría de sus páginas (perfiles, publicaciones, ofertas) para quien no tiene una sesión iniciada, así que lo más frecuente va a ser el camino de "pedir que pegue el texto o adjunte algo"; algunas publicaciones y ofertas sí quedan accesibles sin sesión, y ahí alcanza con leerlas directamente.

## Si la lectura usa un navegador visible

Esta regla vale todavía más si para leer un link tenés que usar una herramienta de navegador (una que abre y renderiza la página de verdad, a diferencia de traer solo el texto en segundo plano): ahí lo que la página muestre en cada momento puede quedar visible para la persona, aunque vos nunca se lo pidas ni lo uses. LinkedIn en particular suele mostrar un cartel de "iniciá sesión" o "creá una cuenta" de forma transitoria mientras carga una página, incluso en publicaciones u ofertas que terminan siendo públicas y legibles igual.

- **Si un intento de lectura en segundo plano (sin navegador visible) ya te dijo que el link está bloqueado**, no reintentes el mismo link con un navegador visible: es muy probable que ahí sí se muestre el cartel de login, que es justo lo que esta regla evita. Seguí directamente con "pedile que pegue el texto".
- **Si vas a usar un navegador visible** para un link (porque es la única forma de leerlo, o porque no es de LinkedIn y no hay motivo para sospechar un muro), avisale a la persona **antes** de navegar: "voy a abrir el link en un navegador para intentar leerlo; si aparece un cartel para iniciar sesión, es normal en algunos sitios — no hace falta que hagas nada, no inicies sesión ahí." Así, si aparece, no es una sorpresa.
- **Si un cartel de inicio de sesión llegó a aparecer** en algún momento de la navegación, aunque al final hayas podido leer el contenido igual, decíselo tal cual en el resumen: "para leer esto tuve que abrir un navegador y en el camino apareció brevemente el cartel de inicio de sesión de LinkedIn; no inicié sesión, y pude leer el contenido igual." No reportes el resultado como una lectura limpia si la persona vio ese cartel: fue parte de lo que pasó y merece que se lo cuentes.

## Por qué

Iniciar sesión en nombre de la persona (aunque fuera posible) significaría manejar sus credenciales, algo que está fuera de lo que este plugin hace. Mostrarle una pantalla de login de un sitio externo como si fuera parte de la conversación también confunde: puede parecer que el asistente le está pidiendo que inicie sesión, cuando ese paso no sirve para nada acá — lo que sirve es el texto, y lo puede pegar directamente.
