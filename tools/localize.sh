#!/bin/bash
# Localize leftover absolute asset URLs in the wget mirror. Usage: localize.sh <mirror_dir>
set -euo pipefail
cd "$1"
B=https://fiduero.arandadeduero.es
JS=wp-content/plugins/revslider/public/assets/js/jquery.themepunch.tools.min.js
curl -sSf "$B/$JS?ver=5.4.7.4" -o "$JS" || echo "warn: $JS is 404 on live site too, left missing"
for u in 2015/07/home_digital_pattern_1.png 2015/07/home_digital_pattern_2.png 2018/06/fondo-1.jpg 2018/06/icono-fiduero-1.png 2018/06/SLIDE1.jpg; do
  [ -f "wp-content/uploads/$u" ] || curl -sSf --create-dirs "$B/wp-content/uploads/$u" -o "wp-content/uploads/$u"
done
find . -name '*.html' -not -path './wp-content/*' | while read -r f; do
  d=$(dirname "${f#./}"); [ "$d" = . ] && P= || P=$(echo "$d" | sed -E 's#[^/]+#..#g')/
  P="$P" perl -pi -e '
    s#(https?:)?//(www\.)?traduccionesaranda\.com/FIDUERO/wp-content/#$ENV{P}wp-content/#g;
    s#https?://fiduero\.arandadeduero\.es/(wp-content/[^"\x27\s?)]+)(\?ver=[\d.]+)?#$ENV{P}$1#g;
  ' "$f"
done
