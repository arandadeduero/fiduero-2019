# Fiduero 2019

Archivo estático de la web de **Fiduero 2019, Feria de la Ribera del Duero**, que estaba en WordPress en `fiduero.arandadeduero.es`.

Se publica en <https://fiduero.arandadeduero.dev/>.

## Contenido

- `site/`: la web tal cual se veía, descargada con `wget --mirror` el 26 de octubre de 2026. Se sirve sin servidor ni base de datos.
- `tools/localize.sh`: cambia por rutas relativas las URLs absolutas que `wget` no convirtió, y recupera las imágenes de fondo que apuntaban al dominio antiguo `traduccionesaranda.com`.
- `tools/selfhost.sh`: aloja las fuentes de Google en `site/fonts/` y quita Google Analytics y html5shiv.

Los dos scripts se pueden volver a ejecutar sin problema: `tools/localize.sh site && tools/selfhost.sh site`.

## Recursos externos que quedan

- Vídeos de YouTube incrustados (inicio y vídeos).
- Mapa de Google Maps (localización).
- reCAPTCHA en el formulario de contacto.

Los formularios (contacto, inscripción) no funcionan, porque necesitaban el WordPress original.

`jquery.themepunch.tools.min.js` (Revolution Slider) ya daba 404 en la web original y sigue faltando.
