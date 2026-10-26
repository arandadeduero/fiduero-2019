#!/bin/bash
# Self-host Google Fonts and strip analytics/html5shiv from the mirror. Usage: selfhost.sh <mirror_dir>
set -euo pipefail
cd "$1"
mkdir -p fonts
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36' # modern UA => woff2
n=0
# re-runs: links are already rewritten, so keep the existing map.txt
if grep -rqE "fonts.googleapis.com/css" --include='*.html' --exclude-dir=wp-content .; then
grep -rhoE "href='https://fonts.googleapis.com/css[^']*'" --include='*.html' --exclude-dir=wp-content . | sort -u | while read -r h; do
  n=$((n+1)); raw=${h#href=\'}; raw=${raw%\'}
  url=$(echo "$raw" | sed -e 's/&#038;/\&/g' -e 's/&amp;/\&/g')
  curl -sSf -A "$UA" "$url" -o fonts/gf-$n.css
  grep -oE 'https://fonts.gstatic.com/[^)]+' fonts/gf-$n.css | sort -u | while read -r f; do
    out=fonts/$(echo "${f#https://fonts.gstatic.com/s/}" | tr / _)
    [ -f "$out" ] || curl -sSf "$f" -o "$out"
  done
  perl -pi -e 's#https://fonts\.gstatic\.com/s/([^)]+)#($a=$1)=~tr{/}{_}; $a#ge' fonts/gf-$n.css
  echo "$raw|gf-$n.css"
done > fonts/map.txt
fi
find . -name '*.html' -not -path './wp-content/*' | while read -r f; do
  d=$(dirname "${f#./}"); [ "$d" = . ] && P= || P=$(echo "$d" | sed -E 's#[^/]+#..#g')/
  while IFS='|' read -r raw css; do
    R="$raw" C="${P}fonts/$css" perl -pi -e 's/\Q$ENV{R}\E/$ENV{C}/g' "$f"
  done < fonts/map.txt
  perl -0pi -e '
    s#<!-- Global site tag \(gtag\.js\).*?</script>\s*<script>.*?</script>\s*##s;
    s#<!--\[if lt IE 9\]>\s*<script id="mfn-html5"[^<]*</script>\s*<!\[endif\]-->\s*##s;
    s#<link rel=.dns-prefetch. href=.(https:)?//fonts\.googleapis\.com/?. />\s*##g;
  ' "$f"
done
