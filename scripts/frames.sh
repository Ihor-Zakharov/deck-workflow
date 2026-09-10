#!/usr/bin/env bash
# Capture one slide at several moments of its entrance and tile them into one strip — proves cascades and sequences.
# Usage: frames.sh <deck.html> <slide-number> [budget-ms ...]      (default 900 1400 1900 2400 3000 6000)
#        → <deck-dir>/frames_<n>.png (needs python3 + Pillow; otherwise the single f_<n>_<t>.png files stay). Delete when done.
#        frames.sh <deck.html> <slide-number> --gif [step-ms] [end-ms]   → <deck-dir>/entrance_<n>.gif (640×360, one frame per step from 300 ms; default step 200, end 3500)
set -euo pipefail
DECK="$1"; N="$2"; shift 2; GIF=0
if [ "${1:-}" = "--gif" ]; then GIF=1; STEP="${2:-200}"; END="${3:-3500}"; BUDGETS=$(seq 300 "$STEP" "$END" | tr '\n' ' '); else BUDGETS="${*:-900 1400 1900 2400 3000 6000}"; fi
DIR="$(cd "$(dirname "$DECK")" && pwd)"; BASE="$(basename "$DECK")"
detect_chrome() {
  if [ -n "${CHROME:-}" ]; then echo "$CHROME"; return; fi
  for c in "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" \
           "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "$(command -v google-chrome || true)" "$(command -v google-chrome-stable || true)" \
           "$(command -v chromium || true)" "$(command -v chromium-browser || true)"; do
    [ -n "$c" ] && [ -x "$c" ] && { echo "$c"; return; }
  done
  echo "frames.sh: Chrome not found — set CHROME=/path/to/chrome" >&2; exit 1
}
CH="$(detect_chrome)"
if [[ "$CH" == /mnt/c/* ]] && command -v wslpath >/dev/null; then WIN_DIR="$(wslpath -w "$DIR")"; URL="file:///$(echo "$WIN_DIR\\$BASE" | sed 's#\\#/#g')"; OUT="$WIN_DIR\\f_"; else URL="file://$DIR/$BASE"; OUT="$DIR/f_"; fi
for t in $BUDGETS; do
  "$CH" --headless=new --disable-gpu --hide-scrollbars --window-size=1920,1080 --virtual-time-budget="$t" --screenshot="${OUT}${N}_${t}.png" "$URL#$N" 2>/dev/null || true
done
python3 - "$DIR" "$N" "$GIF" $BUDGETS <<'PY' || { echo "frames: single files f_${N}_*.png kept (Pillow missing)"; exit 0; }
import sys, os
from PIL import Image, ImageDraw
d, n, gif, ts = sys.argv[1], sys.argv[2], sys.argv[3] == '1', sys.argv[4:]
if gif:
    frames = []
    for t in ts:
        p = os.path.join(d, 'f_%s_%s.png' % (n, t))
        if not os.path.exists(p): continue
        frames.append(Image.open(p).convert('RGB').resize((640, 360), Image.LANCZOS).quantize(colors=128, method=Image.Quantize.MEDIANCUT)); os.remove(p)
    out = os.path.join(d, 'entrance_%s.gif' % n)
    if frames: frames[0].save(out, save_all=True, append_images=frames[1:], duration=[int(ts[1]) - int(ts[0]) if len(ts) > 1 else 200] * (len(frames) - 1) + [1500], loop=0, optimize=True); print(out, os.path.getsize(out))
    sys.exit(0)
W, H, cols = 640, 360, 3
rows = (len(ts) + cols - 1) // cols
sheet = Image.new('RGB', (cols * W + (cols + 1) * 10, rows * H + (rows + 1) * 10), (24, 24, 24)); dr = ImageDraw.Draw(sheet)
for i, t in enumerate(ts):
    p = os.path.join(d, 'f_%s_%s.png' % (n, t))
    if not os.path.exists(p): continue
    im = Image.open(p).convert('RGB').resize((W, H), Image.LANCZOS); x = 10 + (i % cols) * (W + 10); y = 10 + (i // cols) * (H + 10)
    sheet.paste(im, (x, y)); dr.text((x + 8, y + 8), t + ' ms (label drifts ~0.3 s; read the order)', fill=(255, 90, 90)); os.remove(p)
out = os.path.join(d, 'frames_%s.png' % n); sheet.save(out); print(out)
PY
