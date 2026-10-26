#!/bin/bash
# Añade arriba de cada página el aviso de que es una copia estática de archivo. Uso: banner.sh <carpeta_del_mirror>
set -euo pipefail
cd "$1"
BANNER='<div id="aviso-archivo" role="note" style="background:#fbe9e9;color:#8a1f1f;border-bottom:1px solid #f0c4c4;padding:8px 16px;text-align:center;font:14px/1.4 system-ui,-apple-system,sans-serif;position:relative;z-index:10000">Copia estática de la web de Fiduero 2019, guardada como archivo histórico del Ayuntamiento de Aranda de Duero.</div>'
find . -name '*.html' -not -path './wp-content/*' | while read -r f; do
  grep -q 'id="aviso-archivo"' "$f" && continue
  B="$BANNER" perl -0pi -e 's#(<body[^>]*>)#$1\n$ENV{B}#' "$f"
done
