#!/usr/bin/env bash
# Render every slide of a deck to PNG with headless Chrome (WSL→Windows Chrome, Linux, macOS).
# Usage: render.sh <deck.html> [first] [last]      → s_N.png next to the deck; delete them when done.
#        CHROME=/path/to/chrome render.sh …        → override auto-detection.
#        SCALE=2 render.sh …                      → device scale factor 2 (3840×2160 PNGs) to judge small text and hairlines.
set -euo pipefail
DECK="$1"; FIRST="${2:-1}"; LAST="${3:-}"
DIR="$(cd "$(dirname "$DECK")" && pwd)"; BASE="$(basename "$DECK")"

detect_chrome() {
  if [ -n "${CHROME:-}" ]; then echo "$CHROME"; return; fi
  for c in "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" \
           "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" \
           "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
           "$(command -v google-chrome || true)" "$(command -v google-chrome-stable || true)" \
           "$(command -v chromium || true)" "$(command -v chromium-browser || true)"; do
    [ -n "$c" ] && [ -x "$c" ] && { echo "$c"; return; }
  done
  echo "render.sh: Chrome not found — set CHROME=/path/to/chrome" >&2; exit 1
}
CH="$(detect_chrome)"

# WSL + Windows Chrome: arguments must be Windows paths.
if [[ "$CH" == /mnt/c/* ]] && command -v wslpath >/dev/null; then
  WIN_DIR="$(wslpath -w "$DIR")"; URL="file:///$(echo "$WIN_DIR\\$BASE" | sed 's#\\#/#g')"; OUT_PREFIX="$WIN_DIR\\s_"
else
  URL="file://$DIR/$BASE"; OUT_PREFIX="$DIR/s_"
fi

if [ -z "$LAST" ]; then LAST=$(grep -c '<section class="slide' "$DECK"); fi
for i in $(seq "$FIRST" "$LAST"); do
  "$CH" --headless=new --disable-gpu --hide-scrollbars --window-size=1920,1080 --force-device-scale-factor="${SCALE:-1}" \
    --virtual-time-budget=6000 --screenshot="${OUT_PREFIX}${i}.png" "$URL#$i" 2>/dev/null || true
done
ls "$DIR"/s_*.png
