# The image loop — slots, prompts, generator priority, treatment

Images are part of the deliverable. Plan them in Phase 2, send prompts immediately (message 1 of 2), wire placeholders, integrate when they arrive, and make sure the deck looks finished at every rung of the fallback ladder.

## 0. Timing
Send the prompts **right after the storyline is fixed**, each in its own code block with the exact save path (`<root>/<slug>/assets/<name>.jpg`), aspect ratio and the slide it serves, plus one line: "the build continues meanwhile". Repeat them at delivery if the images have not arrived. Never deliver placeholders silently.

## 1. Slot types — the standard is three or four: 2 backgrounds (title + STAR/audience slide) + 1 portrait/artefact + an optional fourth
The title slide always gets a custom generated background; the second background sits under the STAR/quote or the audience slide. Reuse the portrait twice (dossier thumbnail + framed on the quote slide). The optional fourth image is a third background (a mid-deck statement or the closing) or a **title plate** — a square hero artefact (the deck's icon drawn in the deck's technique) framed at the right of the title hero when the background alone reads flat. Ask for 3–4 prompts in message 1; never more.

| Slot | What | Where it lives | Treatment |
|---|---|---|---|
| **Portrait** | the protagonist with recognisable features from a well-known photo | dossier/filed card on the contents slide; large framed portrait on the quote slide | frame in the deck's language (chalk + gold shadow, hard-shadow riso, gallery mount), caption strip, mini stamp/label on a corner, `object-position` to keep the face |
| **Metaphor scene** | the core idea as a scene with 3–5 concrete objects | a statement or section slide | wide frame or full-bleed; text over the empty third |
| **Era / instrument** | the audience's world (lab, antenna, city, machine) | the audience-specific section | full-bleed behind the content |
| **Generated background** (the user's favourite from QED) | a full-bleed atmosphere image *composed for text*: one third nearly empty, detail on the other side, the deck's palette, subtle grain | title, quote, section and closing slides — at most 3–4 backgrounds per deck, never on dense slides | `.scene`: image opacity .5–.9 under a directional gradient that darkens only where text sits (e.g. `linear-gradient(90deg, rgba(bg,.92) 0%, rgba(bg,.8) 50%, rgba(bg,.3) 100%)`) plus a vignette; slow camera `scale 1.02→1.06` over 12 s; chrome stays crisp on top; text ≥ 4.5:1 contrast at the darkest gradient stop |
| **Texture** | paper, board, kraft, film grain | the whole deck as a background tile | seamless 1:1 tile, or fffuel/`feTurbulence`; alpha ≤ .06 |

A background prompt must say: "composed for a slide with text on the left/right third — leave that third nearly empty", the palette hex codes, "no text, letters, numbers, watermarks", 16:9, and one unmistakable subject (a blackboard dense with diagrams; a dish antenna at night; an empty lecture hall).

## 2. Prompt formula
```
<Subject, precise: person + recognisable features from a well-known photo / scene with 3–5 concrete objects>.
<Technique matching the deck: chalk on blackboard / linocut / risograph / halftone / engraving / cyanotype / long-exposure photo / clay render>.
Palette with hex: surface <#…>, ink <#…>, one accent <#…>.
Composition: crop; centered or diagonal; which third stays empty for text.
Texture: grain, misregistration, chalk dust, halftone size.
"No text, letters, numbers, watermarks or signatures."
Aspect ratio: 4:5 portrait / 16:9 scene or background / 1:1 tile.
```
Patterns per palette: `reference/image-prompts.md`. Gemini follows hex codes well — results are usually on-palette.

## 3. Generator priority (universal — the deck never depends on one tool)
1. **Gemini** (default): the user generates from the prompts and pastes the images. Prompts are written so they work verbatim in any generator.
2. **Any other generator the user has when Gemini tokens run out**: ChatGPT/DALL·E, Ideogram, Midjourney, Flux/Leonardo/Recraft free tiers, Bing Image Creator, a local Stable Diffusion. Same prompt; if off-palette apply the off-palette treatment (§6).
3. **Public-domain archives** when the subject is real (people, instruments, places): Met Open Access, Rijksmuseum, Smithsonian Open Access, Library of Congress, NASA, Wellcome Collection, Europeana, Public Domain Review, Internet Archive Book Images — download, credit in the chrome, treat to palette (duotone/halftone via CSS filters + `mix-blend-mode`).
4. **Procedural fallback** (no generator at all): the slot becomes a designed graphic, not a placeholder — an SVG scene drawn in the deck's stroke (diagram, instrument outline, map), a grain gradient (fffuel gggrain / `feTurbulence`), layered shapes (Haikei), one canvas ambient from `library/html-ppt-skill/animations/fx/` (constellation, starfield, gradient-blob — max one per deck), or p5 generative art via the `algorithmic-art` skill for a title background.
At delivery say which rung each slot is on; a deck delivered on rung 4 must still pass the screenshot gate as *finished*.

## 4. Placeholders during the build
```html
<figure class="fig" data-file="assets/name.jpg"><img src="assets/name.jpg" alt="" onerror="this.parentNode.classList.add('missing')"></figure>
<div class="scene" data-file="assets/bg.jpg"><img src="assets/bg.jpg" alt="" onerror="this.parentNode.classList.add('missing')"></div>
```
`.missing` shows a hatched box (or a plain dark surface for scenes) with the file name so the deck is presentable meanwhile. The placeholder and the final image share the same box (fixed width, `aspect-ratio`, `object-fit: cover`).

## 5. Import when the user pastes
Images land in `~/.claude/image-cache/<session-id>/N.png|jpeg`, or arrive with a `source:` path (e.g. `~/Downloads/Gemini_Generated_Image_*.jpg`). Identify which is which by dimensions (`file -b`; same size → make thumbnails and look), then **crop the generator's inset border**: Gemini draws a thin frame ≈ 2 % inside the edge (measure the bright edge rows/columns with PIL, crop ~66 px on a 2752×1536 render, then trim the *empty* side to exact 16:9 — the frame would otherwise drift against the deck's own frame during the camera move). Save to `assets/` under the planned name (JPEG q92). The user may also drop files straight into `assets/`.

## 6. Treatment
- Lay the slide out **around** the image: text over its empty third; never cover a good image with opaque cards (QED v1 slide 13 was rebuilt for this).
- On-palette (hex codes followed): no colour filters; keep the slow camera and the hover scale only. Image at .9 under a gradient that is dense (≥ .8) only under the text column; captions on scene slides in the text colour at .88, never in the muted grey (unreadable over line art — user's note on Бюрократія v2).
- Off-palette: `filter: grayscale(1) contrast(1.15)` + an accent gradient overlay via `::before` with `mix-blend-mode: multiply` (paper decks) or `screen` (dark decks); or duotone via `mix-blend-mode: color` over a flat accent.
- Frames carry the style; captions in mono; a mini stamp/label on one corner when the world has verdicts.
- Re-render every slide that got an image and look at it.

## 7. Verification
Text never sits on a busy part of the image; contrast ≥ 4.5:1 at the darkest gradient stop; the placeholder and final image fit the same box; the file is ≤ 6 MB (re-encode JPEG q85 if larger); `alt` describes the subject.
