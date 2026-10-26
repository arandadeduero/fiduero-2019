#!/bin/bash
# Quita el «?ver=…» que wget dejó en los nombres de fichero (jquery.min.js?ver=3.7.1 -> jquery.min.js).
# Sin extensión real, GitHub Pages los sirve como application/octet-stream con nosniff y el navegador no ejecuta los JS.
# Uso: fix-querynames.sh <carpeta_del_mirror>
set -euo pipefail
cd "$1"
find . -name '*\?*' -type f | while read -r f; do
  dest="${f%%\?*}"
  if [ -e "$dest" ]; then rm "$f"; else mv "$f" "$dest"; fi # x.eot? y x.eot?v=4.7.0 son el mismo fichero
done
find . \( -name '*.html' -o -name '*.css' \) -type f -print0 | xargs -0 perl -pi -e 's/(\.(?:js|css|eot|svg|ttf|woff2?))%3F[^"\x27)\s#]*/$1/g'
