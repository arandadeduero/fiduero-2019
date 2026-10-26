#!/bin/bash
# Añade arriba de cada página el aviso de que es una copia estática de archivo, fijo al hacer scroll.
# Si ya está, lo sustituye por la versión actual. Uso: banner.sh <carpeta_del_mirror>
set -euo pipefail
cd "$1"
# fixed y no sticky: el tema pone overflow en html y body (nice-scroll) y eso anula sticky. El hueco de debajo evita que tape la página.
# La cabecera del tema (#Top_bar.is-sticky) se fija con top:0 al hacer scroll; se baja la altura del aviso, que en móvil ocupa varias líneas
BANNER='<!-- aviso-archivo -->
<style>#aviso-archivo{position:fixed;top:0;left:0;right:0;z-index:10000;background:#fbe9e9;color:#8a1f1f;border-bottom:1px solid #f0c4c4;padding:8px 16px;text-align:center;font:14px/1.4 system-ui,-apple-system,sans-serif}#aviso-archivo-hueco{height:var(--aviso-h,38px)}#Top_bar.is-sticky{top:var(--aviso-h,38px)!important}</style>
<div id="aviso-archivo" role="note">Copia estática de la web de Fiduero 2019, guardada como archivo histórico del Ayuntamiento de Aranda de Duero.</div>
<div id="aviso-archivo-hueco"></div>
<script>(function(){var a=document.getElementById("aviso-archivo");function h(){document.documentElement.style.setProperty("--aviso-h",a.offsetHeight+"px")}h();addEventListener("resize",h)})();</script>
<!-- /aviso-archivo -->'
find . -name '*.html' -not -path './wp-content/*' | while read -r f; do
  B="$BANNER" perl -0pi -e '
    s#<!-- aviso-archivo -->.*?<!-- /aviso-archivo -->\n?##s;
    s#<div id="aviso-archivo"[^>]*>[^<]*</div>\n?##;
    s#(<body[^>]*>)#$1\n$ENV{B}\n#;
  ' "$f"
done
