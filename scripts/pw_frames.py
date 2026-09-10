#!/usr/bin/env python3
"""Exact-time entrance frames (and an optional video) of one slide with Playwright — the precise version of frames.sh.
Usage: .venv/bin/python scripts/pw_frames.py <deck.html> <slide-number> [--step 150] [--end 3600] [--gif] [--video]
Opens the deck in Playwright's Chromium, shows slide 1 until fonts and layout settle, then switches to slide <n> and captures
a frame every <step> ms of real time (the label on each frame is the measured time since the switch, not a nominal budget;
a capture costs ~250 ms, so steps below that are skipped and the labels tell the truth).
Output: <deck-dir>/pwframes_<n>.png (strip), optionally pwentrance_<n>.gif and pwvideo_<n>.webm. Needs scripts/setup-playwright.sh once.
"""
import sys, os, time, pathlib, shutil
args = sys.argv[1:]
if len(args) < 2: sys.exit(__doc__)
deck = pathlib.Path(args[0]).resolve(); n = int(args[1])
opt = lambda k, d: (int(args[args.index(k) + 1]) if k in args else d)
step, end, gif, video = opt('--step', 150), opt('--end', 3600), '--gif' in args, '--video' in args
from playwright.sync_api import sync_playwright
from PIL import Image, ImageDraw
out_dir = deck.parent; frames = []
with sync_playwright() as p:
    b = p.chromium.launch()
    ctx_kw = dict(viewport={'width': 1920, 'height': 1080}, device_scale_factor=1)
    if video: ctx_kw.update(record_video_dir=str(out_dir / '.pwvideo'), record_video_size={'width': 1280, 'height': 720})
    ctx = b.new_context(**ctx_kw); pg = ctx.new_page()
    pg.goto(deck.as_uri() + '#1'); pg.evaluate('document.fonts.ready'); pg.wait_for_timeout(2500)
    switched = pg.evaluate('(i) => { if (typeof deck !== "undefined" && deck.showSlide) { deck.showSlide(i); return true; } return false; }', n - 1)
    if not switched:  # decks without the house controller: reload on the hash and time from the load
        pg.goto(deck.as_uri() + '#' + str(n)); pg.evaluate('document.fonts.ready')
    t0 = time.perf_counter(); k = 1
    while True:
        target = k * step / 1000
        while time.perf_counter() - t0 < target: time.sleep(0.004)
        t = time.perf_counter() - t0
        png = pg.screenshot(type='jpeg', quality=82); frames.append((round(t * 1000), png))
        if t * 1000 >= end: break
        k += 1
    pg.wait_for_timeout(600); ctx.close(); b.close()
    if video:
        vids = sorted((out_dir / '.pwvideo').glob('*.webm'), key=os.path.getmtime)
        if vids: shutil.move(str(vids[-1]), str(out_dir / f'pwvideo_{n}.webm')); print(out_dir / f'pwvideo_{n}.webm')
        shutil.rmtree(out_dir / '.pwvideo', ignore_errors=True)
import io as _io
ims = [(t, Image.open(_io.BytesIO(png)).convert('RGB')) for t, png in frames]
W, H, cols = 640, 360, 4; rows = (len(ims) + cols - 1) // cols
sheet = Image.new('RGB', (cols * W + (cols + 1) * 8, rows * H + (rows + 1) * 8), (24, 24, 24)); dr = ImageDraw.Draw(sheet)
for i, (t, im) in enumerate(ims):
    x = 8 + (i % cols) * (W + 8); y = 8 + (i // cols) * (H + 8); sheet.paste(im.resize((W, H), Image.LANCZOS), (x, y)); dr.text((x + 8, y + 8), f'{t} ms', fill=(255, 90, 90))
strip = out_dir / f'pwframes_{n}.png'; sheet.save(strip); print(strip, f'{len(ims)} frames, step {step} ms')
if gif:
    g = [im.resize((640, 360), Image.LANCZOS).quantize(colors=128, method=Image.Quantize.MEDIANCUT) for _, im in ims]
    durs = [max(20, ims[i + 1][0] - ims[i][0]) for i in range(len(ims) - 1)] + [1500]
    path = out_dir / f'pwentrance_{n}.gif'; g[0].save(path, save_all=True, append_images=g[1:], duration=durs, loop=0, optimize=True); print(path, os.path.getsize(path))
