# Taste — how to use bands, stamps, assets and motion "with soul"

The user's standard (Sept 2026): every deck must be maximally beautiful, fully unique, and made "с душой и вкусом" — bands, animations and assets used *competently*, animations with taste rather than for their own sake. Stamps and an "expensive" look are **recommended tools**, not requirements. This file is the judgement layer above `components.md` (how to build) and `motion-system.md` (how to move).

## 1. The four tests every device must pass

1. **Ownership**: does this element belong to *this slide's idea* or to the deck's global chrome? If neither, it is filler — delete it (huashu pitfall #11).
2. **Cover-the-text**: hide all text; can you still tell which deck this is and what the slide is about? If not, the visual system is generic.
3. **Studio signature**: would a good studio put its name on this frame? If a slide looks "fine", it is not finished.
4. **One 120 % moment**: per deck, one moment is polished to 120 %; the other 80 % is exactly right and quiet. Showing off everywhere is the cheap signal.

## 2. Bands (marquee strips)

Purpose: rhythm + the deck's "chrome language" as a running ticker of real content (formulas, dates, names, form numbers, verdicts). Rules:
- ≤ 3 per deck: usually title, one mid-deck accent, closing. Never on consecutive slides.
- Content is true and specific (the actual Lagrangian, the actual dates), written in the chrome language; repeat the string twice for the seamless loop; 50–70 s per loop.
- Angle ±2–5°; at 1920 wide a 3° tilt shifts the ends ±50 px — leave ≥ 110 px between the band zone and any text or the footer; check both ends in the screenshot.
- Colour = the deck's ink or accent on a contrasting slide; never lower than 0.9 opacity (a faint band looks like a bug).
- A band is an ambient device: on a slide with a band, no other ambient except a stamp ring.

## 3. Stamps (recommended when the world has verdicts)

They were loved in «Апарат» and QED ("QED ∎", "Renorm.", "0.13 ppt", "Shut up and calculate"). Use them when the deck's metaphor issues verdicts, files, approvals, measurements: bureaucracy, journals, labs, passports, customs, archives, courts. Skip them for styles where a seal is foreign (Apple keynote, Swiss grid, wabi-sabi) — invent that style's equivalent instead (a tab, a ticket stub, a museum label, a slate, a plotter mark).
- ≤ 6 per deck; ring text 2–4 short items ending in " · "; centre ≤ 8 characters; one sub-line.
- Slam once after the text lands (delay 1.3–1.6 s, spring `--ease-slam`), ring rotates 45–60 s.
- Ink colour on paper (multiply), chalk/gold on dark. Never on a shape of the same colour, never over text, great on photos and empty corners.
- The stamp's words are the slide's *verdict* — write them as the slide's punchline, not a label.

## 4. Discs, shapes, hairlines, grain

- One big shape per slide at most (disc, block, arc); it anchors a corner and drifts ≤ 30 px over 9–12 s. Stamps must not sit on it unless recoloured.
- Hairlines that draw themselves are the cheapest premium device: chrome rules, kickers, table rules, timeline tracks — all draw-in on entrance (1.3–1.5 s).
- Grain/noise: light surfaces need it (SVG feTurbulence at 0.035–0.05 alpha); it is invisible until removed. Never on dark chalk boards (they have their own texture).
- **The surface is never flat.** A solid colour with a grid still reads as a website: put one global material layer above the slides — a frame in the style's language (drafting sheet, chalk edge, film gate, kraft tape), a little mottling/grain in the material, a vignette to the corners — and let it crossfade its colour with the slide (`components.md` → Blueprint additions). Strength: felt, not seen; if a screenshot looks foggy, halve it.

## 5. Assets (images, icons, illustrations, textures)

- **Images earn their slot** when they show the *specific* subject: the protagonist (portrait), the metaphor scene, the era/instrument. 2–3 per deck; ask the user for Gemini renders **as soon as the storyline is fixed** (prompts in code blocks + exact save paths), keep placeholders until then.
- **Lay the slide out around the image**: text over the empty third, image at 0.75–0.9 opacity under a gradient that darkens only where text sits; never cover a good image with opaque cards. If the render is on-palette (Gemini follows hex codes well) drop desaturation filters.
- **Frames** carry the style: chalk frame + gold hard shadow (QED), hard-shadow constructivist frame (Апарат), gallery card with 6 px "mount" and two soft shadows (Apple), riso misregistration (zine), hairline + crop marks (Swiss).
- **Real archives** beat generated images for history: Met Open Access, Rijksmuseum, Smithsonian Open Access, Library of Congress, NASA, Wellcome Collection, Europeana, Public Domain Review, Internet Archive book scans — public domain, high-res, with credit lines in the deck's chrome.
- **Icons**: inline SVG, one stroke weight (2–2.5 px), from Lucide/Phosphor/Tabler (MIT) or hand-drawn to match the deck; never emoji as icons; never icon tiles above headings.
- **Illustrations**: CC0 sets (Open Peeps, Open Doodles) only when the style is playful/hand-drawn; otherwise none.
- **Textures/patterns**: fffuel (gggrain, nnnoise, ffflux), Haikei, Hero Patterns — one texture per deck, in the deck's colours, at low alpha.

## 6. Typography taste (pointer)

`luxury-type-motion.md` is the craft standard: one display face with character + one neutral text face + one mono for chrome; drama in scale (≥ 2× between levels); tight display leading; tracking only on caps mono; hanging punctuation; tabular numerals; `text-wrap: balance` on headings; no hyphenation; one-line headings. "Expensive" (light weights, serif italics, hairlines, generous margins) is one mood among many — brutalist, riso, playful and academic decks are equally valid as long as the craft is precise.

## 7. Soul

- Real quotes with sources; real numbers with their uncertainty; real dates. Never "lorem", never "Insert image here" in a delivered deck.
- One easter egg in the first three slides (a filed note, a footnote, a stamp text) and one at the end (a pun in the closing line, a misattributed quote corrected in a stamp).
- The chrome language tells a story across the deck (Form № 01 → Form № 14; Vol. I → last page; Lecture notes → register closed).
- Speak to the audience's world: for radiophysicists the photon appears in their antenna; for bureaucrats the file is the protagonist.
- Humour is dry and short; it never replaces the point.

## 8. Uniqueness (pointer)

Each deck must differ from the last two in ≥ 5 of the 8 axes in `deck-ledger.md` (surface, polarity, type voice, graphic device, chrome language, motion signature, image treatment, layout grammar). The skeleton (stage, nav, editor, progress, BUILD) is the only thing that stays.

## 9. Verdicts from the QED v2 experiment (Sept 2026) — what to keep and what to avoid

Keep: the dim, slowly panning 3D wall as a *background* (closing slide), word-by-word and letter-by-letter blur builds on a few slides, the wordmark weight morph, springs for objects, gallery focus pulls as a *timed* sequence.
Avoid: dark rounded hairline cards ("frames"), a plain flat dark stage with no surface texture or gamut change, click-driven interaction on a slide (it is a talk, not a site), a white-mounted portrait card, stamps on every slide, a style with zero thematic reference.
The house standard is therefore QED v3: v1's surfaces, forms, stamps and bands, plus v2's builds and wall. Apple is a source, not the standard — take from everywhere.

## 10. Verdicts from Бюрократія v2 «Креслення апарату» (10.09.2026, evening) — the second standard
Approved as reference-quality after one visual pass. What made the difference (and is now expected of every deck): the global sheet layer (frame, registration marks, cyanotype mottling, vignette) instead of a flat blue; mechanisms that draw themselves level by level (Weber's org chart, Crozier's vicious circle with an orbiting dot) where the content describes a mechanism; drafted section numerals on the quiet slides; tabs on the paper slides; the real backgrounds laid out around (title archive, Kafka desk) with the portrait in a line frame and the stamp on its corner; one loud row in the bar table. User rules confirmed live: captions must stay readable over images; every row of a table cascade must animate (check a mid-animation frame); approved content — including English glossary terms — is not touched. **Each new deck must be visibly different from both standards; their devices are ideas to reinvent in the new material, not parts to reuse.**
