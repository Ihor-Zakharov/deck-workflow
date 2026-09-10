#!/usr/bin/env python3
"""Generate the deck's images from the prompts in brief.md with the Gemini API — the last manual step becomes automatic.
Usage: python3 scripts/gen-images.py <deck-dir> [--dry-run]
Reads every fenced/backticked prompt line of the form `assets/<name>.jpg` (...): <prompt> from <deck-dir>/brief.md,
generates each image with Google's image model and saves it to <deck-dir>/assets/<name>.jpg.
Needs: pip install google-genai, and GEMINI_API_KEY in the environment (or in LOCAL.md as `GEMINI_API_KEY=…`).
Without a key it prints the prompts so the user can generate them by hand — the workflow never depends on the API.
"""
import os, re, sys, io, pathlib
deck = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else '.').resolve(); dry = '--dry-run' in sys.argv
brief = deck / 'brief.md'
if not brief.exists(): sys.exit('no brief.md in ' + str(deck))
text = brief.read_text(encoding='utf-8')
# `assets/name.jpg` (16:9): prompt…   — one prompt per line, as written by the workflow's message 1
prompts = [(m.group(1), m.group(2).strip()) for m in re.finditer(r'`assets/([A-Za-z0-9_.-]+)`\s*(?:\([^)]*\))?\s*:\s*(.+)', text)]
if not prompts: sys.exit('no prompts of the form `assets/<name>.jpg`: <prompt> found in brief.md')
key = os.environ.get('GEMINI_API_KEY', '')
if not key:
    local = pathlib.Path(__file__).resolve().parent.parent / 'LOCAL.md'
    if local.exists():
        m = re.search(r'GEMINI_API_KEY\s*[=:]\s*`?([A-Za-z0-9_\-]+)`?', local.read_text(encoding='utf-8'))
        if m: key = m.group(1)
(deck / 'assets').mkdir(exist_ok=True)
todo = [(n, p) for n, p in prompts if not (deck / 'assets' / n).exists()]
print('%d prompt(s) in brief.md, %d image(s) missing' % (len(prompts), len(todo)))
if not todo: sys.exit(0)
if dry or not key:
    print('\n' + ('DRY RUN — ' if dry else 'no GEMINI_API_KEY — ') + 'generate these by hand and save under assets/:\n')
    for n, p in todo: print('assets/%s\n%s\n' % (n, p))
    sys.exit(0)
try:
    from google import genai
    from google.genai import types
except ImportError:
    sys.exit('pip install google-genai  (then re-run)')
client = genai.Client(api_key=key)
MODEL = os.environ.get('GEMINI_IMAGE_MODEL', 'gemini-2.5-flash-image')
for name, prompt in todo:
    ar = '16:9' if re.search(r'16\s*:\s*9', prompt) or name in ('archive.jpg', 'desk.jpg') else ('4:5' if '4:5' in prompt else '1:1')
    print('generating', name, '(%s) …' % ar, flush=True)
    try:
        resp = client.models.generate_content(model=MODEL, contents=prompt, config=types.GenerateContentConfig(response_modalities=['IMAGE'], image_config=types.ImageConfig(aspect_ratio=ar)))
        part = next((p for p in resp.candidates[0].content.parts if getattr(p, 'inline_data', None)), None)
        if not part: print('  no image in the response — try again or generate by hand'); continue
        out = deck / 'assets' / name
        from PIL import Image
        Image.open(io.BytesIO(part.inline_data.data)).convert('RGB').save(out, quality=92, optimize=True)
        print('  saved', out)
    except Exception as e:
        print('  failed:', str(e)[:300], '— generate this one by hand')
