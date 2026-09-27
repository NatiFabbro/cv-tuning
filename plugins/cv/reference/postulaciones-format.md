# Formato de `CV/postulaciones/`

Cada ejecución de `tune` deja **un registro** en `CV/postulaciones/AAAA-MM-DD_empresa_puesto.md` (nombre según `workspace-layout.md`). Sirve para acordarse a qué puesto se mandó qué CV y con qué cambios.

## Plantilla

```markdown
---
fecha: 2026-09-26
empresa: Acme
puesto: Diseñadora UX
idioma-cv: es
plantilla: ats-clean
cv: CV/cvs/2026-09-26_acme_disenadora-ux/CV_Nombre-Apellido_Acme.pdf
posting: <URL si hubo, o "texto pegado" / "archivo adjunto">
estado: generado
---
# Acme · Diseñadora UX

## Lo que pide el puesto
- Requisitos clave y keywords detectadas (breve)

## Qué se destacó
- [E2.L1] Logro que se puso primero, y por qué
- ...

## Qué se dejó afuera
- [E1] Motivo (irrelevante para el puesto / No mostrar)

## Gaps
- Requisito del posting que el perfil no respalda, y qué se decidió (no incluir / la persona aportó un dato → guardado en el perfil)

## Changelog del CV
- Orden de secciones: habitual (o "cambiado a pedido: Educación y Proyectos antes de Experiencia")
- Resumen reescrito en base a: E2, E3
- Keywords incluidas (con respaldo): X, Y
- Keywords no incluidas (sin respaldo): Z

## Verificación
- Todas las afirmaciones trazadas a IDs del perfil: sí / no (detalle)
```

## Reglas

- `cv:` es una **ruta relativa** a la carpeta de trabajo, nunca absoluta.
- `estado`: arranca en `generado`. La persona puede cambiarlo a mano (`enviado`, `entrevista`, `descartado`…); el plugin no lo pisa.
- No copies el texto completo del posting si es largo; alcanza con los requisitos clave y el link.
- No pises registros existentes.
