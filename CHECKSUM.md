# CHECKSUM — is everything here, and does the deck have everything?

Two checks: a deterministic file manifest (`bash scripts/verify.sh`) and two LLM prompts (paste them into Claude Code). A colleague who receives this skill runs both once; Claude runs the second one before every delivery.

## A. Manifest (verify.sh checks these exist and are non-empty)

```
SKILL.md README.md LOCAL.example.md CHECKSUM.md
reference/taste.md reference/motion-system.md reference/springs.css reference/perception.md reference/deck-ledger.md
reference/components.md reference/luxury-type-motion.md reference/images.md reference/image-prompts.md reference/pitfalls.md reference/sources.md
scripts/render.sh scripts/spring.py scripts/verify.sh
templates/example-qed-v3-deck.html templates/example-blueprint-deck.html templates/example-qed-deck.html templates/example-keynote-noir-deck.html templates/example-aparat-deck.html
templates/example-blueprint-design-system.html templates/example-blueprint-brand-book-a4.html
templates/example-qed-design-system.html templates/example-qed-brand-book-a4.html templates/example-design-system.html templates/example-brand-book-a4.html
library/INDEX.md library/vendor/gsap.min.js library/vendor/motion.js library/vendor/rough-notation.iife.js library/vendor/vivus.min.js library/vendor/splitting.min.js
library/huashu-design/animation-best-practices.md library/huashu-design/apple-gallery-showcase.md library/next-slide/STYLE_PRESETS.md library/next-slide/styles/keynote-noir.html
library/html-ppt-skill/animations.md library/html-ppt-skill/animations/animations.css library/visual-cognition-slides/PEDAGOGY.md
library/skills-slides/references/anti-slop-checklist.md library/skills-slides/tokens/aesthetics.csv library/claude-slides/components.md library/claude-design/style-gallery/01-swiss-editorial.html
```

## B. Session checksum (paste at the start of a session or after installing)

```
You are about to use the deck-workflow skill. Before anything else, verify the install:
1. Run `bash ~/.claude/skills/deck-workflow/scripts/verify.sh` and report any MISSING line.
2. Open SKILL.md and confirm it contains: the Contract paragraph, House rules 1–10 (including 3a "The standards are QED v3 and Бюрократія v2", 4a "A deck is not a website", 4b "No dark rounded hairline cards", 5 "Three or four images, two of them backgrounds"), the Session-start protocol, Phases 0–9, the Maximum-squeeze table, Quality gates G1–G5, and the Checksum-and-sharing section.
3. Confirm reference/deck-ledger.md has ≥ 6 rows and that rows 5 (QED v3) and 6 (Бюрократія v2, blueprint) are marked as the standards.
4. Confirm reference/motion-system.md has recipes 5.1–5.15 and that §1 forbids click-driven states.
5. Confirm LOCAL.md exists (if not, say so and copy LOCAL.example.md → LOCAL.md with the user's paths).
Answer with a table: item · OK/MISSING · note. Do not start a deck until every row is OK.
```

## C. Delivery checksum (Claude runs this before Phase 8 of every deck)

```
Check the deck I am about to deliver against the standard and answer OK/FAIL per line with the slide numbers:
- Facts: brief.md lists sources; every quote is verbatim with author/year; numbers carry uncertainty where they have one.
- Uniqueness: the ledger row for this deck differs from the previous two rows in ≥ 5 of 8 axes; a minimal thematic touch exists.
- Palette: one palette; 2–4 slides in another gamut (dark or accent-dominant); accent used on ≤ 3 element types per slide; no #000.
- Images: three or four — 2 generated backgrounds (the title always has one), 1 portrait/artefact, an optional fourth; text sits over the empty third; generator borders cropped; placeholders show the file name if an image is missing and the 3–4 prompts were given early and are repeated in the delivery message.
- Surface: not flat — a material layer above the slides (frame/marks, mottling, grain, vignette, or the style's equivalent); captions ≥ 4.5:1 also over images; every cascade row (tables included) has its own delay.
- Devices: stamps ≤ 6 (two with the hero entrance), bands 2–3, no stamp on every slide, no dark rounded hairline cards.
- Motion: letter blur-in on 1–2 slides; word builds on 2–3 headings; one non-interactive animated 3D wall (mid or closing); springs for objects; crossfade only; everything settles ≤ 2.2 s; one ambient per slide; ≥ 3 quiet slides; no click-driven states anywhere (grep for addEventListener('click' outside nav/editor).
- Layout: one-line headings (or a composed two-line break), body ≥ 24 px, contrast ≥ 4.5:1, no 3 consecutive same layouts, ≤ 5 items per slide, no template headings.
- Files: deck.html, brief.md, design/design-system.html, design/brand-book-a4.html + .pdf, assets/, lib/springs.css; BUILD bumped; localStorage key unique; every <section> has data-title; footer NN / total.
- Verification: every slide screenshotted and looked at; s_*.png deleted; ledger row appended; pitfalls appended if any.
```

## D. Regenerating the manifest

`bash scripts/verify.sh --print` prints the manifest with sizes and an md5 of the concatenated skill text (reference + SKILL + CHECKSUM) so two installs can be compared: the same md5 = the same workflow version.
