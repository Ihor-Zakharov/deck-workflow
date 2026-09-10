---
name: deck-workflow
description: Universal, autonomous, AI-native workflow for maximally beautiful and fully unique HTML presentations on ANY topic and language. Input = a topic and a short description; output = a finished deck (fixed 1920×1080 stage, tasteful Apple-grade motion, design system + A4 brand book, Gemini image slots with prompts, screenshot-verified). Use for any "презентация / презентація / deck / slides / talk / keynote" request. Self-contained; works after a context clear; shareable with colleagues.
---

# Deck Workflow — from a one-paragraph brief to a reference-quality deck

**Contract.** The user writes what the presentation is about (topic, a description, maybe audience/language/length/authors). You deliver, without questionnaires, a finished deck that is (a) maximally beautiful, (b) fully unique versus every previous deck, (c) made with taste: animations with purpose, bands/stamps/assets used competently, real facts and real quotes, one soul. You talk to the user exactly twice: once early with 3–4 image prompts, two of them full-bleed backgrounds (so they can generate in Gemini while you build), once at delivery. Ask a question only if the language or audience cannot be inferred at all.

Everything reusable lives in this folder. Read this file fully first, then the files in the order given in §1. Do not re-derive what is written here.

## 0. House rules (non-negotiable)

1. **Squeeze the maximum every time.** Mine every asset in this folder and the installed skills (see §1 and `library/INDEX.md`): style demos, token CSVs, motion corpora, vendored libraries, fonts, archives, generators. A deck that used only its own CSS is under-built.
2. **Beauty → motion → artefacts, in that order.** Bold display type, a committed palette, one signature graphic system, a design system page and an A4 brand book, 2–3 images, a glossary/appendix when the audience benefits.
3. **Fully unique per deck, with a minimal thematic touch.** New surface, polarity, type voice, device, chrome language, motion signature, image treatment, layout grammar — differ from the last two decks in ≥ 5 of the 8 axes in `reference/deck-ledger.md`. The style is not the topic, but it winks at it (graph paper + blackboard for physics, blueprint forms for bureaucracy). Never reuse the previous look wholesale; the only constants are the skeleton (stage, crossfade, side nav, progress bar, BUILD-versioned editor).
3a. **The standards are QED v3 and Бюрократія v2 «Креслення апарату»** (`templates/example-qed-v3-deck.html`, `templates/example-blueprint-deck.html`; ledger rows 5–6). They are quarries of *universal* features, never looks to copy — the design of every new deck is unique, but its devices come from these two: one palette with 2–4 slides in another gamut (dark or accent-dominant); the deck's own device family used sparingly (stamps ≤ 6 with two hero entrances, 2–3 animated bands, discs/shapes); a custom generated background on the title and one more mid-deck; one portrait or artefact; one non-interactive animated 3D wall used purely as a background (mid-deck or closing — no panels or pop-ups on it); letter-by-letter blur-in on 1–2 slides; word builds on 2–3 headings; self-drawing diagrams for mechanisms; springs for objects. Boldness from «Апарат», restraint from QED v1 — never "too much". From the blueprint deck: a **global material layer** above every slide (frame with registration marks, mottling, grain, vignette — the surface is never flat), **mechanisms that draw themselves level by level** (org chart, vicious circle), drafted section numerals as watermarks on the quiet slides, sheet tabs on the paper slides, the portrait in a line frame with the stamp on its corner, one dimension line under the title. Reinvent each device in the new deck's material (a chalk frame, a film slate, a customs stamp…), never paste it.
4. **Taste over quantity.** One reveal cascade per slide + at most one ambient device; 2–4 signature moments per deck; ≥ 3 quiet slides; crossfade only between slides — **never** wipes or flashes. Default motion is deliberately unhurried (`reference/motion-system.md` §3). Stamps, marquee bands, discs and the "expensive" editorial look are recommended tools when the style calls for them, not requirements; no stamp on every slide.
4a. **A deck is not a website.** Interactivity = navigation + hover only. No click-to-focus, toggles, tabs, drag or pop-up panels; the only sequences are entrance choreographies that play by themselves.
4b. **No dark rounded hairline cards** (the QED v2 look was rejected). Prefer typographic blocks with a drawn top rule, paper index cards / forms with ink borders, or solid slabs; frames only when the style's world has them.
5. **Three or four images, two of them backgrounds.** Two full-bleed generated backgrounds composed for text (the **title always gets one**; the second sits under the STAR/quote or the audience slide), one portrait or artefact (dossier card + framed on the quote slide), and optionally a fourth: a mid-deck/closing background or a title plate. Wire placeholders; send the 3–4 prompts with exact save paths **immediately after the storyline is fixed**; integrate when the user pastes them (crop the generator's inset border first); lay the slide out around the image (`reference/images.md`).
6. **Facts are real.** 2–6 web searches for any real subject; quotes verbatim with source; numbers with uncertainty; formulas canonical (KaTeX). Sources listed in `brief.md`.
7. **Perception first.** Headings are assertions; one idea per slide; body ≥ 24 px; contrast ≥ 4.5:1; dense content on light surfaces; the peak and the ending get the most craft (`reference/perception.md`).
8. **Verify with screenshots, every slide, every time.** Fix, re-render, delete the PNGs. No delivery without it.
9. **One-line headings, no syllable hyphenation, no template headings ("Overview"), no emoji icons, no `#000`, no `transition: all`.**
10. **Portability.** No machine-specific paths in the deck or in this skill's shared files; machine settings live in `LOCAL.md` (see `LOCAL.example.md`). Decks open from `file://` on any machine: relative asset paths, fonts from Google Fonts with real fallbacks, libraries copied into `<deck>/lib/`.

## 1. Session-start protocol (reading order, ~5 minutes)

1. `SKILL.md` (this) → 2. `LOCAL.md` if present (output root, Chrome path, image-cache path; defaults: `~/presentations`, auto-detected Chrome) → 3. `library/INDEX.md` → 4. `reference/deck-ledger.md` (last two rows + unused seeds) → 5. `reference/taste.md` → 6. `reference/motion-system.md` → 7. `reference/perception.md` → 8. `reference/components.md` and `reference/pitfalls.md` → then per phase: `reference/images.md`, `reference/image-prompts.md`, `reference/luxury-type-motion.md`, `reference/sources.md`, and the library files named in each phase below.

## 2. Pipeline

### Phase 0 — Brief (≤ 3 min)
Create `<root>/<slug>/` with `brief.md`: topic, audience, language, purpose, length (default 14–20 slides for a talk; 20+ when an appendix/glossary adds value), density (speaker-led), tone, must-include names/facts, authors, deadline. Fill gaps with sensible defaults and *state* them in the brief. Decide the deck's language from the request; decide script coverage (Cyrillic ⇒ font shortlist restrictions).

### Phase 1 — Research (facts before design)
`WebSearch`/`WebFetch` 2–6 calls: canonical facts, dates, the latest numbers (with year and uncertainty), 2–3 real quotes, one anecdote for an easter egg, one fact that ties the topic to the audience's world. Write them into `brief.md` with URLs. For teaching decks read `library/visual-cognition-slides/PEDAGOGY.md` and label each section with its knowledge type (concept / procedure / story / relation / data) and explanation pattern (analogy / mechanism / contrast / scale / history / framework).

### Phase 2 — Storyline + image slots + signature moments
In `brief.md`: title → contents (with the easter-egg card) → 3–5 sections × 2–4 slides → one quote/statement slide → an audience-specific section → conclusions → appendix (glossary/reference tables when useful) → closing. Each slide: one assertion heading + ≤ 5 items + its visual. Mark: the STAR moment; 2–4 signature motion moments (menu in `motion-system.md` §7, no repeats); 3–4 image slots (two **generated full-bleed backgrounds** composed for text — title + STAR/audience — one portrait/artefact, optionally a metaphor scene, a third background or a title plate — `reference/images.md` §1) with file names; 3–6 chrome-language strings (stamps, bands, tabs — whatever the style uses). Pacing check: no 3 consecutive same layouts; a reset (image/quote/humour) every ≤ 8 slides.
**→ Send message 1 to the user now**: 3–4 Gemini prompts in code blocks — two full-bleed backgrounds, one portrait/artefact, optionally a fourth (formula in `reference/images.md`: subject with recognisable specifics, technique, hex palette, composition with an empty third for text, "no text/letters/watermarks", aspect ratio) + exact save paths + one line saying the build continues meanwhile.

### Phase 3 — Design direction (decide, don't ask)
1. Read the last two ledger rows; choose values for the 8 axes that differ in ≥ 5. 2. Pick a seed from the ledger's unused list or from: `library/next-slide/styles/*.html` (open 2–3 demos matching the vibe), `library/next-slide/STYLE_PRESETS.md`, `library/claude-design/style-gallery/`, `library/huashu-design/design-styles.md` (+ its colour-derivation protocol: sample → converge → justify; print-like desaturation reads expensive), `~/.claude/skills/frontend-slides/bold-template-pack/selection-index.json`, `library/skills-slides/tokens/*.csv`. 3. Fix tokens: palette (90/8/2), three faces (display with character / neutral text / mono chrome; Cyrillic-safe list in `reference/sources.md`), type scale (hero 150–190, h1 96–112, h2 66–72, body 24–26, caption 17, label 13–15), the signature graphic system, the chrome language, the motion easing family (expo-out or springs from `reference/springs.css`). 4. Write the "style thesis" (two sentences) into `brief.md`. Optional: render three title-slide variants and pick the best yourself — do not ask.

### Phase 4 — Design system + A4 brand book
`design/design-system.html` and `design/brand-book-a4.html` in the `design-system` skill format (examples: `templates/example-*-design-system.html`, `templates/example-*-brand-book-a4.html`): colours with usage, type specimens and ladder, 6 principles, components, icons (inline SVG, one stroke weight), wordmarks, poster band, counters. Render the PDF with Chrome (`reference/pitfalls.md`). This step is what makes the deck coherent — never skip it.

### Phase 5 — Build the deck
Start from the closest template (`templates/example-qed-v3-deck.html` — standard — for lecture/editorial decks with self-drawing diagrams, stamps, bands and the wall; `templates/example-blueprint-deck.html` — standard — for technical/poster decks with a global sheet layer, level-staged mechanisms, forms and tabs; `templates/example-keynote-noir-deck.html` for keynote/statement decks with a gallery wall; `templates/example-qed-deck.html` for editorial/science on paper; `templates/example-aparat-deck.html` for poster/constructivist) — keep the fixed 1920×1080 stage + full `viewport-base.css`, controller, side nav, BUILD-versioned inline editor (unique localStorage key per deck), progress bar; replace every token, font, device and line of content. Use: `reference/components.md` (house components incl. self-drawing SVG diagrams, KaTeX, glossary tables, graph paper), `reference/motion-system.md` recipes (blur-in, word builds, mask reveals, focus pull, count-up, draw-in, slow camera, gallery wall, springs), `library/html-ppt-skill/animations/animations.css` + `fx/` (ready effects, one canvas ambient max per deck), `library/claude-slides/components.md` (mockups, pipelines, terminals), `library/huashu-design/apple-gallery-showcase.md` (Apple-style cards and walls), vendored libraries when a recipe needs them (copy into `<deck>/lib/`). Every `<section>` has `data-title`; footer `NN / total`; `BUILD` bumped on every edit; images wired with `onerror` placeholders; fonts preconnected; measurements after `document.fonts.ready`.
Build order: title → closing → the STAR slide → the rest. After the first 4 slides, render them and correct the system before continuing (huashu: "2-page showcase fixes the grammar before batch").

### Phase 6 — Images
Generator priority is universal (`reference/images.md` §3): Gemini → any other generator the user has → public-domain archives for real subjects → a procedural, designed fallback (SVG scene, grain gradient, one canvas ambient, p5). The deck must look finished on every rung. When the user pastes images (image-cache path or a Downloads path with `source:`), identify by dimensions (same size → look at them), crop the generator's inset border (Gemini draws a frame ≈ 2 % in — measure the bright edge lines, crop to a clean 16:9, keep the empty third), copy to `assets/<planned-name>.<ext>`, drop desaturation if on-palette, lay the slide out around the image (text over its empty third), re-render those slides. Until then the placeholders are presentable.

### Phase 7 — Verify (mandatory)
`bash scripts/render.sh <deck.html>` → look at **every** PNG. Fix: overflow, overlaps (bands/discs/stamps vs text/footer), same-colour collisions (gold on gold), headings > 1 line, wrapped card titles, contrast, glyph coverage (і/ї/є/ґ, IPA, math), marquee visibility, empty > 35 % of a content slide without design intent, column imbalance, 3-in-a-row layouts. Then run the three gates: `library/skills-slides/references/anti-slop-checklist.md`, `reference/perception.md` §7, `reference/motion-system.md` §8. Re-render only changed slides; delete `s_*.png`.

### Phase 8 — Deliver (message 2)
Open the deck (`LOCAL.md` open command; default `xdg-open`/`open`/`cmd.exe /c start`). Message: paths (deck, design system, brand book PDF, brief); the style thesis; slide list in one line each; signature moments; image status (placeholders awaiting `assets/...` — repeat the prompts if not yet generated); how to edit (E / top-left hotzone / Ctrl+S; edits versioned by BUILD); offers: PDF (Chrome print), PPTX (`pptx` skill), deploy (frontend-slides `scripts/deploy.sh`).

### Phase 9 — Learn and checksum
Run `bash scripts/verify.sh` (files) and the LLM checksum prompt in `CHECKSUM.md` (properties) before delivery; append the deck's row to `reference/deck-ledger.md`; new pitfalls → `reference/pitfalls.md`; new reusable pieces → `reference/components.md`; a new direction seed if you invented one; update the user's memory if their taste changed. Copy the deck into `templates/` only if it is a new *family* (poster, editorial, keynote, terminal…).

## 3. Maximum-squeeze protocol (what "выжать максимум" means, per phase)

| Phase | Must actually open/use |
|---|---|
| Research | WebSearch ×2–6; PEDAGOGY.md for teaching decks; one audience-specific fact |
| Direction | ledger axes; ≥ 2 live style demos; colour-derivation protocol; Cyrillic check; springs or expo-out decided |
| Design system | full page + A4 PDF; icons drawn in the deck's stroke |
| Build | ≥ 1 component from `components.md`, ≥ 2 recipes from `motion-system.md` §5, ≥ 1 device from the style's world, KaTeX for any formula, SVG diagrams that draw themselves for any mechanism, an appendix when the audience learns |
| Images | 3–4 prompts sent early (2 backgrounds); inset borders cropped; real archives when history is the subject |
| Verify | every slide screenshotted; three gates run; PNGs deleted |
| Deliver | full message with prompts and edit instructions |

## 4. Quality gates (summary — details in the referenced files)

- **G1 Direction**: ≥ 5/8 axes differ from the last two decks; display face is not Inter/Roboto/Arial/system; palette committed; no purple-gradient-on-white; fonts cover the script.
- **G2 Content**: assertion headings; one idea/slide; real facts with sources; no template headings; glossary/appendix where useful; STAR moment named.
- **G3 Motion**: crossfade only; settle ≤ 2.2 s; one ambient; 2–4 signatures; springs/expo-out only; reduced-motion honoured; slow-motion test passed.
- **G4 Render**: every slide screenshot-checked; no overlaps/overflow; one-line headings; contrast (captions ≥ 4.5:1 also over images); glyphs; the surface is not flat (material layer); every table row of a cascade gets its own delay (mid-animation frame checked).
- **G5 Delivery**: two messages only; prompts given early and repeated; edit instructions; files in place; ledger updated.

## 5. Checksum and sharing

`CHECKSUM.md` holds the manifest of this skill and a verification prompt: run it at the start of a session ("is everything here?") and before delivery ("does this deck have everything the standard requires?"). `scripts/verify.sh` checks the files deterministically. To share: zip the folder without `LOCAL.md` (`README.md` → Share) or publish the folder as a GitHub repository — `.gitignore` already excludes `LOCAL.md`, zips and screenshots, `LICENSE` (MIT) covers the workflow's own files and vendored material keeps its own licences; a colleague clones it into `~/.claude/skills/deck-workflow/`, copies `LOCAL.example.md` to `LOCAL.md` and runs `/deck-workflow <topic and description>`.

## 6. Files
- `CHECKSUM.md` — manifest + LLM verification prompts; `scripts/verify.sh` — deterministic file check.

- `README.md` — how to install and use this skill (for colleagues), requirements, credits.
- `LOCAL.example.md` → copy to `LOCAL.md` — machine paths (output root, Chrome, image cache, open command).
- `reference/taste.md` — judgement: bands, stamps, shapes, assets, soul, uniqueness.
- `reference/motion-system.md` + `reference/springs.css` — Apple-grade motion system and recipes; `scripts/spring.py` regenerates springs.
- `reference/perception.md` — design psychology (Mayer, assertion–evidence, Gestalt, Laws of UX, Tversky, readability) and the content checklist.
- `reference/deck-ledger.md` — the 8 variation axes, every deck made, unused direction seeds.
- `reference/components.md` — house components (stamp, side nav, bands, discs, dossier card, editor, controller, self-drawing diagrams, KaTeX, glossary table).
- `reference/luxury-type-motion.md` — typography and motion craft standard.
- `reference/images.md`, `reference/image-prompts.md` — the Gemini loop and prompt patterns.
- `reference/pitfalls.md` — everything that broke and the fix.
- `reference/sources.md` — outward map of fonts, motion, archives, generators, repos.
- `scripts/render.sh` — screenshots (Windows Chrome from WSL, or Linux/macOS Chrome).
- `templates/` — complete verified decks + design systems + brand books: the two standards (QED v3 «Lecture Notes», Бюрократія v2 «Креслення апарату» blueprint) plus Апарат, QED v1 and QED v2 «Keynote Noir».
- `.gitignore`, `LICENSE` — the folder is a publishable GitHub repository as is.
- `library/` — vendored open-source corpora and libraries; start at `library/INDEX.md`.
