#!/usr/bin/env bash
# Audit the visibility and motion of one slide (or every slide) in headless Chrome:
#   1. every text element must have an entrance (transition/animation on itself or an ancestor inside the slide);
#   2. every child of a .stagger group (table rows included) must get its own, later delay;
#   3. text on a flat background must reach 4.5:1 (3:1 at ≥ 24 px); text over an image or the 3D wall is listed for a visual check.
# Usage: audit.sh <deck.html> <slide-number|all>      → report on stdout, exit 1 on FAIL
#        CHROME=/path/to/chrome audit.sh …            → override auto-detection
set -uo pipefail
DECK="$1"; WHICH="${2:-all}"
DIR="$(cd "$(dirname "$DECK")" && pwd)"; BASE="$(basename "$DECK")"
detect_chrome() {
  if [ -n "${CHROME:-}" ]; then echo "$CHROME"; return; fi
  for c in "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" \
           "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "$(command -v google-chrome || true)" "$(command -v google-chrome-stable || true)" \
           "$(command -v chromium || true)" "$(command -v chromium-browser || true)"; do
    [ -n "$c" ] && [ -x "$c" ] && { echo "$c"; return; }
  done
  echo "audit.sh: Chrome not found — set CHROME=/path/to/chrome" >&2; exit 1
}
CH="$(detect_chrome)"
PROBE="$DIR/.audit-$BASE"
python3 - "$DIR/$BASE" "$PROBE" <<'PY'
import io, sys
src, dst = sys.argv[1], sys.argv[2]
s = io.open(src, encoding='utf-8').read()
js = r"""<script>
setTimeout(function () {
  var S = document.querySelector('.slide.visible') || document.querySelector('.slide.active'); if (!S) return;
  var isChrome = function (el) { return !!el.closest('.chrome-head, .chrome-foot, .side-nav, .sheet, .sheet-fx, .progress, .edit-toggle, .edit-hint, .deck-controls, .wall-viewport, .scene, [aria-hidden="true"]'); };
  var isSplit = function (el) { return !!el.closest('.letters, .words') && !el.matches('.letters, .words'); };
  var probeOf = function (el) { return el.matches('.letters, .words') ? (el.querySelector('.l, .w > *') || el) : el; };
  var ownText = function (el) { return Array.prototype.some.call(el.childNodes, function (n) { return n.nodeType === 3 && n.textContent.trim().length > 0; }); };
  var label = function (el) { var cls = typeof el.className === 'string' ? el.className : (el.className && el.className.baseVal) || ''; return el.tagName.toLowerCase() + (cls ? '.' + cls.trim().split(/\s+/).join('.') : '') + ' «' + el.textContent.trim().replace(/\s+/g, ' ').slice(0, 42) + '»'; };
  var hasEntrance = function (el) { for (var e = el; e && e !== S.parentElement; e = e.parentElement) { var cs = getComputedStyle(e); if (cs.animationName && cs.animationName !== 'none') return true; var durs = cs.transitionDuration.split(',').map(parseFloat); var props = cs.transitionProperty.split(',').map(function (p) { return p.trim(); }); if (props.some(function (p, i) { return /^(opacity|transform|filter|clip-path|stroke-dashoffset|fill-opacity|rotate|translate|scale|all)$/.test(p) && (isNaN(durs[i]) ? durs[0] : durs[i]) > 0; })) return true; if (e === S) break; } return false; };
  var els = Array.prototype.filter.call(S.querySelectorAll('*'), function (el) { var cs = getComputedStyle(el); return !isChrome(el) && !isSplit(el) && (ownText(el) || el.matches('.letters, .words')) && cs.display !== 'none' && cs.visibility !== 'hidden' && el.textContent.trim().length > 0; });
  var instant = els.filter(function (el) { return !hasEntrance(probeOf(el)); });
  var gaps = [];
  S.querySelectorAll('.stagger').forEach(function (g) { var kids = g.tagName === 'TABLE' ? Array.prototype.slice.call(g.querySelectorAll(':scope > tbody > tr, :scope > tr')) : Array.prototype.slice.call(g.children); var prev = -1; kids.forEach(function (k, i) { var d = parseFloat(getComputedStyle(k).transitionDelay) || 0; if (i > 0 && d <= prev) gaps.push(label(g).slice(0, 60) + ' → child ' + (i + 1) + ' delay ' + d + 's ≤ previous ' + prev + 's'); prev = d; }); });
  var parse = function (c) { var m = c && c.match(/rgba?\(([^)]+)\)/); if (!m) return null; var v = m[1].split(',').map(parseFloat); return { r: v[0], g: v[1], b: v[2], a: isNaN(v[3]) ? 1 : v[3] }; };
  var lum = function (c) { var f = function (v) { v /= 255; return v <= .03928 ? v / 12.92 : Math.pow((v + .055) / 1.055, 2.4); }; return .2126 * f(c.r) + .7152 * f(c.g) + .0722 * f(c.b); };
  var ratio = function (a, b) { var l1 = lum(a), l2 = lum(b); return (Math.max(l1, l2) + .05) / (Math.min(l1, l2) + .05); };
  var overScene = !!S.querySelector('.scene img, .wall-viewport, video, canvas');
  var bgOf = function (el) { for (var e = el; e && e !== S.parentElement; e = e.parentElement) { var c = parse(getComputedStyle(e).backgroundColor); if (c && c.a >= .8) return { c: c, solid: e === S ? 'slide' : 'box' }; if (e === S) break; } return null; };
  var low = [], visual = [];
  var stampsSeen = [];
  els.forEach(function (el) { var cs = getComputedStyle(probeOf(el)); var col = parse(cs.color); var bg = bgOf(el); if (!col || col.a === 0 || !bg) return; var size = parseFloat(cs.fontSize); var stamp = el.closest('.stamp'); if (stamp) { if (stampsSeen.indexOf(stamp) < 0) { stampsSeen.push(stamp); visual.push('stamp «' + (stamp.dataset.center || '') + '» — placed over a photo, disc or empty corner? never over text or a same-colour shape'); } return; } if (bg.solid === 'slide' && overScene) { visual.push(label(el) + ' (' + Math.round(size) + 'px)'); return; } var r = ratio(col, bg.c); var min = size >= 24 ? 3 : 4.5; if (r < min) low.push(label(el) + ' → ' + r.toFixed(2) + ':1 at ' + Math.round(size) + 'px'); });
  var n = Array.prototype.indexOf.call(document.querySelectorAll('.slide'), S) + 1;
  var lines = ['SLIDE ' + n + ' · ' + (S.dataset.title || '')];
  lines.push('instant text (no entrance): ' + (instant.length ? '\n  ' + instant.map(label).join('\n  ') : 'none'));
  lines.push('stagger gaps: ' + (gaps.length ? '\n  ' + gaps.join('\n  ') : 'none'));
  lines.push('low contrast on a flat background: ' + (low.length ? '\n  ' + low.join('\n  ') : 'none'));
  lines.push('text over image/wall — check visually: ' + (visual.length ? '\n  ' + visual.join('\n  ') : 'none'));
  lines.push('RESULT: ' + ((instant.length || gaps.length || low.length) ? 'FAIL' : 'OK'));
  var pre = document.createElement('pre'); pre.id = 'audit'; pre.textContent = lines.join('\n'); document.body.appendChild(pre);
}, 400);
</script>"""
io.open(dst, 'w', encoding='utf-8').write(s.replace('</body>', js + '\n</body>'))
PY
if [[ "$CH" == /mnt/c/* ]] && command -v wslpath >/dev/null; then WIN_DIR="$(wslpath -w "$DIR")"; URL="file:///$(echo "$WIN_DIR\\$(basename "$PROBE")" | sed 's#\\#/#g')"; else URL="file://$PROBE"; fi
if [ "$WHICH" = "all" ]; then LAST=$(grep -c '<section class="slide' "$DECK"); LIST=$(seq 1 "$LAST"); else LIST="$WHICH"; fi
fail=0
for i in $LIST; do
  REPORT=$("$CH" --headless=new --disable-gpu --virtual-time-budget=1500 --dump-dom "$URL#$i" 2>/dev/null | awk '/<pre id="audit">/{p=1} p{print} /<\/pre>/{if(p){exit}}' | sed -e 's#<pre id="audit">##' -e 's#</pre>.*##' -e 's/&quot;/"/g' -e 's/&lt;/</g' -e 's/&gt;/>/g' -e 's/&amp;/\&/g')
  [ -z "$REPORT" ] && REPORT="SLIDE $i · (no report — did the page load?)
RESULT: FAIL"
  echo "$REPORT"; echo "----"
  echo "$REPORT" | grep -q 'RESULT: FAIL' && fail=1
done
rm -f "$PROBE"
[ "$fail" = 1 ] && { echo "audit: FAIL — fix the lines above, then re-run"; exit 1; } || echo "audit: OK"
