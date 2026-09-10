#!/usr/bin/env bash
# Optional: a private Python environment with Playwright + Chromium for exact-time frames and entrance videos (scripts/pw_frames.py).
# Everything in the workflow also works without it (Chrome CLI). Usage: bash scripts/setup-playwright.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"; V="$ROOT/.venv"
python3 -m venv --without-pip "$V" 2>/dev/null || python3 -m venv "$V"
if [ ! -x "$V/bin/pip" ] && [ ! -x "$V/Scripts/pip.exe" ]; then curl -sS https://bootstrap.pypa.io/get-pip.py | "$V/bin/python" - --quiet; fi
PY="$V/bin/python"; [ -x "$PY" ] || PY="$V/Scripts/python.exe"
"$PY" -m pip install --quiet --upgrade playwright pillow
"$PY" -m playwright install chromium
"$PY" - <<'PY' || { echo "Chromium launched but failed — on Linux/WSL run: sudo $PY -m playwright install-deps chromium"; exit 1; }
from playwright.sync_api import sync_playwright
with sync_playwright() as p:
    b = p.chromium.launch(); pg = b.new_page(); pg.set_content('<title>ok</title>'); print('playwright:', pg.title()); b.close()
PY
echo "playwright ready: $PY"
