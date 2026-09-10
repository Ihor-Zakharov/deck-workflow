---
name: slides
description: Create stunning HTML presentations with 50,000+ unique design combinations. 50 aesthetics, 20 palettes, 10 fonts, 30+ effects. Zero dependencies, anti-AI-slop.
---

# Slides Skill

Create beautiful, self-contained HTML presentation files. Zero external dependencies. Works offline. Opens directly in any browser.

**Token system:** 50 aesthetics × 20 palettes × 10 fonts × 5 layouts × 30+ effects = 50,000+ unique combinations.
**Search tool:** `python scripts/search.py` — look up tokens by vibe keyword.

---

## Supporting Files

| File | Purpose | When to Load |
|------|---------|-------------|
| `references/viewport-base.css` | Mandatory CSS foundation for viewport fitting | Always — copy into every presentation |
| `references/html-template.md` | Full HTML skeleton + SlidePresentation JS class | Always — use as structural template |
| `references/animation-patterns.md` | Effect-to-feeling table, entrance/bg CSS, tilt/magnetic JS | When adding motion effects |
| `references/anti-slop-checklist.md` | 10-point quality gate | Always — run before delivery |
| `references/css-effects-cookbook.md` | Complete copy-paste CSS/JS for backgrounds, cards, text, motion | When implementing specific effects |
| `tokens/aesthetics.csv` | 50 aesthetic styles with vibe keywords | Via search.py |
| `tokens/color-palettes.csv` | 20 color systems with full hex values + WCAG ratios | Via search.py |
| `tokens/font-pairings.csv` | 10 font pairs with Google Fonts URLs | Via search.py |
| `tokens/layout-patterns.csv` | 5 layout grids with CSS templates | Via search.py |
| `tokens/effects-library.csv` | 30+ effects with complete CSS snippets | Via search.py |

---

## Content Density Rules

| Slide Type | Maximum Content |
|-----------|----------------|
| Title | 1 heading + 1 subtitle + optional tagline |
| Content | 1 heading + 4–6 bullets OR 1 heading + 2 paragraphs |
| Feature grid | 1 heading + 6 cards max (2×3 or 3×2) |
| Code | 1 heading + 8–10 lines of code |
| Quote | 1 quote (max 3 lines) + attribution |
| Image | 1 heading + 1 image (max 60vh height) |
| Data / chart | 1 heading + 1 visualization + 1-line insight |
| Section divider | 1 label + 1 statement (no bullets) |

**Override rule:** When in doubt, use fewer elements. White space is a design feature.

### Viewport Fill Rule (NON-NEGOTIABLE)

Every slide MUST visually fill the viewport — no awkward empty space. When content is sparse:

1. **Scale up text** — If a slide has only 3-4 bullets, increase `font-size` to `clamp(0.9rem, 2vw, 1.4rem)` and `gap` to `clamp(0.8rem, 2vh, 1.5rem)`
2. **Scale up heading** — Content slides with few items: use `clamp(1.5rem, 4.5vw, 3rem)` for h2
3. **Add vertical padding** — Use `padding-top/bottom: clamp(3rem, 10vh, 8rem)` to center content with breathing room
4. **Expand cards** — If grid has only 3 cards, increase `card-padding` and `gap`; consider `grid-template-columns: repeat(3, 1fr)` with fixed sizing
5. **Never leave >30% of viewport empty** on any edge — if content doesn't fill, enlarge it

**Quick reference by bullet count:**
| Bullets | Body font-size | Bullet gap | H2 size |
|---------|---------------|------------|---------|
| 1-2 | `clamp(1rem, 2.2vw, 1.5rem)` | `clamp(1rem, 2.5vh, 2rem)` | `clamp(1.6rem, 5vw, 3.2rem)` |
| 3-4 | `clamp(0.9rem, 2vw, 1.35rem)` | `clamp(0.8rem, 2vh, 1.5rem)` | `clamp(1.5rem, 4.5vw, 3rem)` |
| 5-6 | `clamp(0.8rem, 1.6vw, 1.15rem)` | `clamp(0.5rem, 1.2vh, 1rem)` | `clamp(1.3rem, 3.5vw, 2.5rem)` |

**Centering rule:** These slide types MUST use `align-items: center; text-align: center` on `.slide-content`:
- Stats / metrics / data slides
- Quote slides
- AMA / Q&A slides
- Thank you / closing slides
- Any slide with a single focal element (1 big number, 1 emoji, 1 image)

---

## Phase 0: Detect Mode

Identify which workflow applies before asking anything else.

- **New presentation** → proceed to Phase 1
- **PPTX/PDF/images to convert** → read content first, then Phase 1 (pre-fill answers from existing content)
- **Enhance existing HTML** → read the file, identify what to improve, skip Phase 1 unless aesthetic change needed

---

## Phase 1: Content Discovery

Ask these questions. Accept answers in any format (bullet list, paragraph, paste of notes).

```
1. What is this presentation for? (conference talk, internal demo, sales pitch, teaching, portfolio...)
2. How many slides? (rough estimate or exact)
3. Do you have content ready? (paste it, upload a file, or describe topics)
4. Any images to include? (file paths, URLs, or "generate placeholders")
5. Should slides be editable in-browser? (adds contenteditable double-click system)
6. Anything to avoid? (colors, styles, competitors' look, overused patterns)
```

If the user has provided enough context to proceed without asking, skip directly to Phase 2.

---

## Phase 2: Style Discovery

### Step 1 — User describes vibe
Ask: *"Describe how you want this to feel. Any words, references, vibes, colors, or examples."*

Examples of good vibe inputs: "dark and techy like a cyberpunk UI", "clean and minimal like a Swiss poster", "warm and editorial like a magazine", "bold startup energy"

### Step 2 — Search aesthetics
```bash
python scripts/search.py "[vibe keywords]" --domain aesthetic -n 5
```
Present top 3–5 matches with names and vibe keywords. Ask user to pick one (or combine elements).

### Step 3 — Load matching tokens
```bash
python scripts/search.py --compatible [aesthetic_id]
```
This returns compatible palettes, fonts, layouts, and effects for the chosen aesthetic.

### Step 4 — Generate 3 visual previews
Create 3 minimal HTML snippets (title slide only, ~30 lines each) showing distinct directions within the chosen aesthetic — different palette or layout variation. Present as code blocks the user can mentally compare. Ask: *"Which direction feels right? Or mix elements from multiple?"*

### Step 5 — Confirm selections
Lock in: aesthetic ID, palette ID, font ID, layout ID, 2–3 effects.

---

## Phase 3: Generate Presentation

### 3a. Load foundation
1. Read full `references/viewport-base.css` — paste verbatim into `<style>`
2. Read `references/html-template.md` — use skeleton and JS class
3. Check `references/animation-patterns.md` for chosen effect CSS

### 3b. Apply tokens
From search.py results:
- **Palette:** map `bg_primary → --bg`, `bg_secondary → --surface`, `text_primary → --text`, `text_secondary → --text-muted`, `accent_1 → --accent`, `accent_2 → --accent-2`, `glow_color → --glow`
- **Font:** paste the `css_import` value at top of `<style>`, set `--font-display` and `--font-body`
- **Effects:** paste `css_code_snippet` from effects-library.csv tokens; add required JS if `js_required: true`

### 3c. Build slides

Generate slides sequentially. Apply content density rules strictly.

**Slide structure pattern:**
```html
<section class="slide [aesthetic-class]" id="slide-N"
         role="region" aria-label="Slide N: [topic]"
         data-slide-index="[N-1]">
    <!-- Background layer (decorative, aria-hidden) -->
    <div class="slide-bg" aria-hidden="true">
        <!-- Signature effect elements here -->
    </div>
    <!-- Content layer -->
    <div class="slide-content">
        <!-- Entrance-animated elements with --delay stagger -->
    </div>
</section>
```

**Stagger pattern for lists:**
```html
<li class="enter-fade-up" style="--delay:0.1s">First item</li>
<li class="enter-fade-up" style="--delay:0.2s">Second item</li>
```

### 3d. Run anti-slop checklist
Read `references/anti-slop-checklist.md`. Verify all 10 points pass before continuing.

Checklist (verify each before output):
- [ ] Display font is NOT Inter/Roboto/Arial/system-ui
- [ ] NO purple gradient on white background
- [ ] Shadows use sm/md/lg hierarchy tokens, not one value everywhere
- [ ] All colors reference CSS variables
- [ ] All font sizes use `clamp()` or `var(--*-size)` variables
- [ ] At least 1 signature visual effect matches chosen aesthetic
- [ ] Background has texture/gradient/depth (not flat solid)
- [ ] 3+ distinct text sizes with clear visual order
- [ ] All text passes WCAG AA 4.5:1 contrast
- [ ] `prefers-reduced-motion` media query present and correct

### 3e. Output
Deliver as a single `.html` file. File name format: `[topic-slug]-slides.html`

---

## Phase 4: PPTX Conversion (if applicable)

When converting from PowerPoint/PDF:

1. Extract content structure — do not rewrite it; preserve all text, data, and speaker context
2. Map slide types: title → `slide-title`, bullets → `slide-content`, images → `slide-image`, charts → `slide-data`
3. Recreate charts/graphs as CSS or SVG (no chart.js or external libs)
4. For images: use `<img>` with relative path if file is available, or SVG placeholder if not
5. Apply the same design system from Phase 2/3 — the content is theirs, the design is new

---

## Phase 5: Delivery

After generating the file:

1. **Confirm file path** — state the absolute path to the generated `.html` file
2. **Open in browser** — run: `open [filepath]` (macOS) or `start [filepath]` (Windows)
3. **Summarize:**
   - Number of slides
   - Aesthetic chosen + palette + font
   - Key effects applied
   - Any content decisions made (e.g., condensed long bullet lists)

---

## Phase 6: Share & Export

Offer these options after delivery:

### Deploy to Vercel (instant public URL)
```bash
# Requires Vercel CLI: npm i -g vercel
cd [directory-containing-html]
vercel --name [presentation-name]
# Follow prompts — public URL in ~30 seconds
```

### Export to PDF
```bash
# Using Chrome headless (prints each slide as a page)
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --headless --print-to-pdf="slides.pdf" \
  --print-to-pdf-no-header \
  --no-pdf-header-footer \
  "file:///[absolute-path-to-html]"
```

### Convert to PPTX (best-effort)
Note: HTML → PPTX conversion loses animations. For fidelity, recommend PDF export instead. If PPTX is required, suggest LibreOffice Impress as the conversion tool.

---

## Error Handling

| Issue | Resolution |
|-------|-----------|
| Content overflows slide | Cut bullets to max 6; reduce font-size token; remove one element |
| Font not loading | Add `<link rel="preconnect" href="https://fonts.googleapis.com">` before font link; verify URL from `font-pairings.csv` |
| Backdrop-filter not working | Add `-webkit-backdrop-filter` duplicate; check browser support note in html-template.md |
| Snap scroll jumpy on mobile | Ensure `overscroll-behavior: none` on `body`; check `scroll-snap-stop: always` on `.slide` |
| Canvas particle system laggy | Reduce particle count to 40; add `will-change: transform` to canvas |
| PPTX images not found | Use base64 inline encoding or SVG placeholder; note the missing asset in delivery summary |

---

## Quick Reference: search.py

```bash
# Find aesthetics by vibe
python scripts/search.py "dark futuristic" --domain aesthetic -n 5

# Find palettes by color/mood
python scripts/search.py "warm gold luxury" --domain palette -n 3

# Get full compatible design system for an aesthetic
python scripts/search.py --compatible startup-pitch

# Fetch a specific token by ID
python scripts/search.py --get palette midnight-aurora
python scripts/search.py --get font clash-satoshi
python scripts/search.py --get effect gradient-mesh
```

Domains: `aesthetic` | `palette` | `font` | `layout` | `effect`
