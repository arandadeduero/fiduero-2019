# Fiduero 2019

Archivo estático de la web de **Fiduero 2019, Feria de la Ribera del Duero**, que estaba en WordPress en `fiduero.arandadeduero.es`.

Se publica en <https://fiduero.arandadeduero.dev/>.

## Contenido

- `site/`: la web tal cual se veía, descargada con `wget --mirror` el 26 de octubre de 2026. Se sirve sin servidor ni base de datos.
- `tools/localize.sh`: cambia por rutas relativas las URLs absolutas que `wget` no convirtió, y recupera las imágenes de fondo que apuntaban al dominio antiguo `traduccionesaranda.com`.
- `tools/selfhost.sh`: aloja las fuentes de Google en `site/fonts/` y quita Google Analytics y html5shiv.
- `tools/fix-querynames.sh`: quita el `?ver=…` que `wget` dejó en los nombres de fichero (`jquery.min.js?ver=3.7.1`). Sin la extensión real, GitHub Pages sirve los JS como `application/octet-stream` con `nosniff` y el navegador no los ejecuta.
- `tools/banner.sh`: añade arriba de cada página el aviso de que es una copia estática de archivo, fijo aunque se haga scroll.

Los scripts se pueden volver a ejecutar sin problema: `tools/localize.sh site && tools/selfhost.sh site && tools/fix-querynames.sh site && tools/banner.sh site`.

## Recursos externos que quedan

- Vídeos de YouTube incrustados (inicio y vídeos).
- Mapa de Google Maps (localización).
- reCAPTCHA en el formulario de contacto.

Los formularios (contacto, inscripción) no funcionan, porque necesitaban el WordPress original.

Se han quitado los scripts de Revolution Slider: ninguna página tiene un slider de ese plugin y `jquery.themepunch.tools.min.js` ya daba 404 en la web original.
