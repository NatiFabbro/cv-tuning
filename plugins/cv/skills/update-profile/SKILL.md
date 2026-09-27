---
name: update-profile
description: Agrega o corrige cosas en tu perfil sin rehacer todo, por ejemplo un trabajo nuevo, un logro, un número que recordaste, una skill, un curso o un idioma. Usalo cuando pidan "actualizar mi perfil", "agregar esta experiencia", "sumar este logro", "cambié de trabajo", "corregir un dato de mi perfil", o cuando quieran guardar un dato nuevo que salió mientras adaptaban un CV.
argument-hint: "[qué querés agregar o cambiar]"
---

# Update profile: actualizar el perfil sin rehacerlo

Agregás o corregís datos en `CV/perfil.md` (el perfil maestro) y **siempre mostrás qué va a cambiar antes de guardar**. El perfil es la única fuente de hechos de los CVs, así que solo entra lo que la persona afirma.

Escribí para gente no técnica, una pregunta por vez, sin jerga.

## Antes de empezar

Los contratos están en `${CLAUDE_PLUGIN_ROOT}/reference/` (si esa variable no se resuelve, usá `../../reference/` relativo a la carpeta de este skill). Leé `profile-schema.md`, `honesty-rules.md` y `workspace-layout.md`.

Trabajá en la **carpeta de trabajo activa de la sesión**, sin rutas absolutas en ningún archivo.

## 1. Guard clause

Si no existe `CV/perfil.md`, explicá que primero hay que armar el perfil y arrancá `/cv:setup`. No sigas sin perfil.

Si existe, leelo entero antes de preguntar nada, para no pedir datos que ya están. Si su `version-esquema` es mayor a la que conocés (`1`), avisale a la persona que tu versión del plugin es más vieja que su perfil y frená ahí: no lo edites.

## 2. Entender qué cambia

El cambio puede venir como argumento (`$ARGUMENTS`), en el chat o en un archivo adjunto. Si no está claro, preguntá: "¿Qué querés agregar o cambiar?". Tipos habituales:

- **Nueva experiencia**, o **fin** de una actual (cargar fecha de cierre).
- **Nuevo logro** en una experiencia existente, o **una métrica** que faltaba en uno.
- **Skills, idiomas, estudios, certificaciones o proyectos** nuevos.
- **Referencia** nueva en una experiencia existente, o cambio en si esa persona autorizó ser mencionada. Si es nueva, preguntá siempre **"¿esta persona sabe que la vas a poner como referencia y está de acuerdo?"** y guardá la respuesta tal cual (sí / no / no lo consulté todavía); nunca asumas un sí.
- **Preferencias** (tono, longitud, roles objetivo, país) y **No mostrar**.
- **Corrección** de un dato erróneo.
- **Un dato surgido en un `/cv:tune`** (por ejemplo, experiencia que el perfil no tenía). Si vino de una conversación anterior, pedile que lo confirme de nuevo con sus palabras.

Preguntá lo que falte para escribir cada dato completo (rol, empresa, cuándo, qué hizo, qué logró). Métricas: solo si la persona las da; podés preguntar "¿recordás algún número, aunque sea aproximado? Si no, queda sin número", nunca sugerir cifras. Lo dudoso va a **Pendientes**.

## 3. Aplicar en el esquema

- Usá los IDs siguientes libres (`E4`, `E2.L5`, `E2.R2`, `ED2`…). **Nunca renumeres ni reutilices** IDs existentes: los registros de `postulaciones/` los citan.
- Mantené el orden cronológico inverso en Experiencia y Educación.
- Si el dato nuevo contradice algo del perfil (fechas, cargos, números), no elijas vos: mostrá las dos versiones y preguntá cuál es la correcta.
- Si el dato resuelve algo de **Pendientes**, sacalo de ahí.

## 4. Mostrar las diferencias antes de guardar

Mostrá los cambios en lenguaje simple y claro, agrupados en **Se agrega**, **Se modifica** (con "antes" y "ahora") y **Se quita** (si corresponde), por ejemplo:

```
Se agrega:
  · Experiencia nueva: Analista de datos, Empresa X (2024-05 – actual)
      - Armó un tablero de ventas que usa todo el equipo comercial
Se modifica:
  · Logro E2.L1
      antes: Redujo el tiempo de entrega
      ahora: Redujo el tiempo de entrega un 20%
Se quita:
  · (nada)
```

Preguntá: "¿Lo guardo así?". **No escribas nada hasta recibir un sí claro.** Si pide ajustes, corregí y mostrá otra vez lo que cambió.

## 5. Guardar

1. Antes de modificar, guardá una copia del perfil vigente como `CV/perfil.anterior.md` (si ya existe una copia, preguntá antes de reemplazarla).
2. Escribí `CV/perfil.md` con los cambios, respetando el esquema.
3. Releé el archivo y verificá que refleja exactamente lo confirmado.

## 6. Cierre

Resumí en una o dos frases qué quedó guardado y ofrecé el siguiente paso: adaptar un CV a una oferta (`/cv:tune`). Si quedan pendientes, mencioná cuántos.
