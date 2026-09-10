# Pitfalls (all hit in practice, Sept 2026)

## Fonts
- **Jost has no Ukrainian glyphs** (і, ї, є render in a heavy fallback). Use Raleway, Manrope, Unbounded, Lora, JetBrains Mono, Golos, Onest, Commissioner — all have full Cyrillic incl. Ukrainian. Always screenshot a slide containing і/ї/є/ґ before going further.
- Google Fonts need internet; for offline show, embed woff2 as data URIs.

## Rendering / tooling (WSL2)
- Headless Chrome on Windows works from WSL: `"/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" --headless=new --disable-gpu --hide-scrollbars --window-size=1920,1080 --virtual-time-budget=6000 --screenshot="C:\path\s_N.png" "file:///C:/path/deck.html#N"`. Use Windows-style paths in arguments.
- **Edge headless hangs** for PDF sometimes; Chrome `--print-to-pdf` is reliable.
- No playwright/node in WSL; don't try the frontend-slides export script. PDF of slides: Chrome print of the deck works via `@media print` in viewport-base.css if needed.
- Chrome loop over 14 slides ≈ 1–2 min; run with a generous timeout.

## Layout
- Marquee bands: put the text twice in the span and animate `translateX(0 → -50%)`; the "padding-left:100%" variant shows an empty band at first.
- Bands rotated with `rotate:` cross content: place them in free zones (above kicker at top ~130px, or between subtitle and authors) and check both ends (a 1920-wide band rotated 5° shifts ±85px at the edges).
- Giant quotation glyph («) needs `slide-content` shifted right (≥540px) or it covers the text.
- Stamps are z-index 3 and multiply-blended: keep them off dark discs (red on red disappears) and off text; on photos they look great.
- `ol.num` numeral column: 84px fits "2020"; 64px does not.
- Warm-toned cards on a warm slide vanish: use the lighter paper for cards.
- Hyphenated headings ("розгля-немо") annoyed the user: make the heading one line full-width and move columns below.
- `deck-controls` counter outside the stage overlaps at exact 1920×1080: keep it hidden; footer carries the page number.

## Behaviour
- Inline editor restore from localStorage **overrode newer file versions** (user saw stale slides). Store `{build, html}` with a `BUILD` constant and drop the copy when it differs. Bump BUILD on every edit (the template uses a timestamp string).
- Wipe transitions between slides were rejected as flashing. Crossfade only.
- Stagger delays must cover every child (`nth-child(7)`, `(8)` were missing → items appeared instantly).
- `.disc` uses `translate:` for drift and `transform` for the pop-in so they don't fight.
- Reduced-motion is honoured by viewport-base.css; keep it.

## Process
- Skill installed mid-session isn't in the skill list until restart: read its SKILL.md directly.
- Images the user pastes into chat land in `~/.claude/image-cache/<session>/N.(png|jpeg)` — or arrive with a `source:` path in `/mnt/c/Users/<name>/Downloads/Gemini_Generated_Image_*.jpg`. Identify which is which by dimensions (`file -b`), then copy into `assets/` under the planned names.
- Gemini follows hex palettes well: on-palette images need no grayscale/multiply treatment — drop filters, keep only the overlay gradient and a slow 12 s scale drift. Lay the slide out around the image (text over its empty third), never cover it with opaque cards.

## QED deck (Sept 2026)
- Gold-on-gold: a gold stamp or gold photon line placed over a gold disc disappears. Move the stamp off the disc or recolour (`on-gold` class / chalk stamp on a dark disc).
- Marquee band on the title slide collided with the subtitle: at 1920 wide a ±3° band shifts ±50 px at the edges; leave ≥110 px between subtitle bottom and authors, or use ±2°.
- Fraunces has no Cyrillic — fine for English decks; Ukrainian glossary columns render in IBM Plex Sans (which has full Cyrillic). Check any Cyrillic in display type.
- Card headings in 3-column grids (≈430 px) wrap above ~24 chars at 32 px: set 22–25 px inline or shorten.
- Give the Gemini image prompts early (after the storyline), not only at delivery: the user sees the placeholders and wants to generate in parallel.

## QED v2 «Keynote Noir» (Sept 2026)
- `scripts/render.sh` must be called with an absolute path when the shell has `cd`-ed elsewhere in the same command (a relative `scripts/…` failed once). Always `bash ~/.claude/skills/deck-workflow/scripts/render.sh <abs deck>`.
- `springs.css` must be wrapped in `@supports (animation-timing-function: linear(0,1)) { :root { … } }` — a bare list of custom properties is not valid CSS. Declare cubic-bezier fallbacks in the deck's own `:root` first.
- Big numbers with units (`.spec .v`) need `white-space: nowrap`; "1.5 × 10²⁴ / s" wrapped in a 250 px column — use ≥ 290 px or 42 px.
- A 3D gallery wall behind chrome needs top/bottom scrims (200 px gradients at z-index above the wall) or the head/foot text sits on tiles. Visible scale ≈ .82 shows ~9 of 12 tiles; 1.22 → .82 is the ripple zoom-out.
- Two-line statement headings: place the `<br>` yourself so the italic accent starts the second line; never leave a 3-word orphan.
- Count-ups under `--virtual-time-budget` screenshots may be caught mid-count (12 660 of 12 672); harmless in a real browser, but keep the final frame exact by setting the target value at p = 1.
- The A4 brand book overflows silently (`overflow: hidden`): screenshot it at 1240×1754 and check the footer is visible before printing the PDF; move motion tokens to the design-system page if it does not fit.

## QED v3 + Бюрократія v2 (Sept 2026, evening)
- The user rejected *any* panel over the 3D wall — interactive or timed. The wall is a background only; keep the content of such a slide to a heading + caption.
- "Make it more like v1": when improving a loved deck, change ≤ 4 slides and keep every form; new motion goes on the title, the quote and the closing.
- Fira Sans Extra Condensed 800, Cormorant Garamond italic, IBM Plex Sans and JetBrains Mono all render Ukrainian (і ї є ґ) — a safe bold pairing for condensed poster decks.
- `text-transform: uppercase` on `.hero` with `.letters` builds works (spans inherit); italic accent spans need `text-transform: none`.
- Yellow accent-dominant slides: ink stamps use `mix-blend-mode: multiply`; on a blue disc use a line-coloured stamp instead.
- A count-up inside a `.reveal` parent must be triggered from `deck.onChange`; check the screenshot shows the final value, not 0.

## Бюрократія v2 — the visual pass that made it a standard (10.09.2026, late evening)
- **`mix-blend-mode` layers must be their own stacking-context roots inside the stage.** A z-indexed wrapper (`.sheet { z-index: 40 }`) isolates its children: the mottling SVG blended with the wrapper's empty backdrop, not with the slide → an opaque white/grey fog over the whole deck. Fix: one absolutely positioned div per blend layer, each with its own z-index and `mix-blend-mode`, siblings of the slides.
- **feTurbulence mottling for a dark surface**: `fractalNoise` 0.003–0.005, 4 octaves → `feColorMatrix saturate 0` → `feComponentTransfer` linear slope .34 intercept .74 (so it only darkens ≤ 26 %) → `multiply` at .9 on blue, .3 on paper; grain 0.85, 2 octaves, `soft-light` at .3/.18. Anything stronger reads as fog; soft-light with raw noise reads as grey.
- **`table.stagger` cascades stop at the implicit `<tbody>`**: `.stagger > *` matches the tbody, so rows 1–8 shared one delay and only rows with explicit `nth-child` delays cascaded ("до due process не анимируются"). Give every `tr` its own `--r` delay (`calc(.31s + var(--r) * .13s)`) and neutralise the tbody. Check cascades with a mid-animation frame (`--virtual-time-budget=1400`).
- **Gemini renders carry an inset frame** ≈ 2 % in from every edge (bright rows/cols at ~50–58 px of 2752). Crop it (and trim the empty side to exact 16:9) before wiring, or the frame drifts against the deck's own sheet frame during the 12 s camera move.
- **CSS `transform` on an SVG element overrides its `transform` attribute**: an arrowhead placed with `transform="translate() rotate()"` lost its rotation when `.mark { transform: scale(.4) }` animated. Wrap the positioned element in a `<g transform=…>` and animate the child.
- **Captions in the muted grey over line-art images are unreadable** (user: "текст не читабельный, сливается с фоном"). On scene slides use the text colour at .88 and make the gradient ≥ .8 under the text column; `--muted` on the blueprint raised to #B4C7DE.
- **Foreign terms**: the user first asked to remove "English terms", then reversed — they meant the glossary rows that did not animate. Ask what "remove" refers to before touching approved content; the glossary stays in English by design.
- Arrowheads on a loop must follow the tangent of travel (screen coords: clockwise = increasing angle; tangent at θ is θ + 90°); place the tip 10 px before the station square.
- `getTotalLength()` on `rect`/`line`/`circle`/`polyline` works in Chrome — one `measureDraw()` after `document.fonts.ready` serves dimension lines, mechanisms and the wall.
- Deck-level counters in the design docs (`Арк. 1 / 15`) went stale when the storyline grew to 19 slides — grep the design system and brand book for the sheet count before the PDF.
- **CSS beats SVG presentation attributes**: `svg.mech text { text-anchor: middle }` silently overrode `text-anchor="end"` on the loop's side labels, so they were centred on the station squares and the arrowheads sat on the text. Anchor per element with an inline `style="text-anchor: end"` (or a class), never with the attribute when a stylesheet rule exists.
- **A loop must be one stroke**: three arcs starting at once from three stations read as "animated from the middle". Chain them (`--d`, `--t`: .7→1.4→2.07 s, `linear` like a plotter pen) and pop each station/arrowhead when the pen reaches it; verify the order with frames at several `--virtual-time-budget` values (their labels drift by ~0.3 s, so read the order, not the numbers; a `getComputedStyle` probe via `--dump-dom` gives the exact delays).
- **Base stagger CSS must carry `nth-child(1)`–`(12)` from the first line**: the contents register had nine items and the ninth («Дод.») popped in before §6–§8 because the deck's cascade stopped at eight (user: «во втором слайде анимацию для дод добавь»). Copy the 12-step list from the QED v3 template into every new deck and check any list longer than the delays with a mid-animation frame.
- **`scripts/audit.sh` findings on the finished blueprint deck** (things eyes missed): 12–13 px steel text on paper/white was 3.8–4.1:1 (`--steel` darkened to #4F6480 → ≥ 5.6:1); decorative outline glyphs must carry `aria-hidden="true"` so the audit skips their transparent colour; a stamp over a disc cannot be judged from the DOM — the audit lists stamps for a visual check instead. Run the audit before looking at the PNGs, not after.
