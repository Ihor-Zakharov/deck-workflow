# Where to get what (map of sources and tools) — updated 10.09.2026

Vendored material is listed in `library/INDEX.md`. This file is the outward map.

## Typography
- Pairings with vibe keywords: `library/skills-slides/tokens/font-pairings.csv`; 10 open pairings + modular scale rules: `library/huashu-design/typography.md`; 36 preset pairings: `library/next-slide/STYLE_PRESETS.md`.
- Craft rules: `reference/luxury-type-motion.md` (scale, tracking, leading, measure, details).
- Sources: Google Fonts (variable faces: Fraunces, Onest, Manrope, Unbounded, Bricolage Grotesque, Instrument Serif/Sans, Newsreader, Geist/Geist Mono, IBM Plex, JetBrains Mono); Fontshare/ITF (Clash Display, Satoshi, Cabinet Grotesk, General Sans — mostly **no Cyrillic**); Velvetyne (libre, weird & wonderful), Collletttivo (Italian open-source), Open Foundry (curated open faces), Uncut.wtf (163 contemporary free faces), League of Moveable Type. Check Cyrillic before committing: safe = Raleway, Manrope, Unbounded, Lora, Golos, Onest, Commissioner, Cormorant, Playfair, Oswald, Bebas Neue, IBM Plex family, JetBrains Mono; never Jost; Fraunces has no Cyrillic.
- Inspiration: Typewolf, Fonts In Use, Book Cover Archive; pairing tools: Fontjoy; identification: WhatTheFont.
- Math: KaTeX from cdnjs (`katex.min.css` + `katex.min.js`).

## Motion
- Our system: `reference/motion-system.md` + `reference/springs.css` (Apple-style springs as CSS `linear()`, regenerate with `scripts/spring.py duration bounce`).
- Principles: emilkowal.ski (Sonner/Vaul author; "great animations"), the 40 rules of tasteful animation (gist by corysimmons), animations.dev course notes, NN/g "The role of animation and motion in UX", easing.dev / easings.co, Josh Comeau on `linear()` springs, kvin.me CSS spring generator (presets "based on Apple defaults").
- Corpora: `library/huashu-design/animation-best-practices.md`, `animation-pitfalls.md`, `apple-gallery-showcase.md`, `gsap-recipes.md`, `camera-language.md`; `library/html-ppt-skill/animations.md` + `animations/animations.css` + `fx/*.js`; `library/visual-cognition-slides/ANIMATIONS.md` (explanatory animations); `library/claude-slides/animations.md`; `library/skills-slides/references/css-effects-cookbook.md`.
- Libraries (vendored in `library/vendor/`): GSAP 3.12 (100 % free since April 2025 incl. SplitText, MorphSVG, DrawSVG, ScrollTrigger), Motion (motion.dev; springs `type:'spring', duration, bounce`), rough-notation, rough.js, vivus, Splitting.js. CDN fallback: cdnjs.

## Perception / pedagogy
- `reference/perception.md` (our synthesis). Primary: Mayer's 12 principles; Alley's assertion–evidence (assertion-evidence.com, Penn State studies); Laws of UX (lawsofux.com); Tversky & Morrison 2002; NN/g dark-mode and serif/sans studies; Duarte *Resonate* (sparkline, STAR moment); Reynolds *Presentation Zen*; `library/visual-cognition-slides/PEDAGOGY.md`.

## Artefacts (paper, stamps, grain, textures, icons)
- Stamps, bands, discs, dossier card: `reference/components.md`; self-drawing diagrams + KaTeX + glossary table + graph paper: same file (QED section).
- Grain/noise/gradients: SVG `feTurbulence` (snippet in components), fffuel.co (gggrain, nnnoise, ffflux, ssscales), Haikei (waves, blobs, layered shapes), Hero Patterns (SVG tiling), transparent textures.
- Icons (MIT): Lucide (1.5k), Phosphor (1.2k × 6 weights), Tabler (5.6k), Heroicons. Illustrations (CC0): Open Peeps, Open Doodles; unDraw (free but no bundling).
- Device frames/mockups: `library/claude-design/assets/device-frames.md`, `library/claude-slides/components.md`.

## Images
- Generated: Gemini from our prompts (`reference/images.md`, `reference/image-prompts.md`); give prompts right after the storyline.
- Public domain / open access (credit in chrome): Met Open Access (492k images + API), Rijksmuseum (Rijksstudio), Smithsonian Open Access (3M+), Library of Congress, NASA Image Library, Wellcome Collection, Europeana, Getty Open Content, Public Domain Review, Internet Archive Book Images, Old Book Illustrations, Biodiversity Heritage Library.

## Design directions
- `reference/deck-ledger.md` (axes + unused seeds) → then: `library/next-slide/styles/*.html` (56 live demos), `library/next-slide/STYLE_PRESETS.md`, `library/claude-design/style-gallery/` (10), `library/huashu-design/design-styles.md` (60 styles + colour derivation), `~/.claude/skills/frontend-slides/bold-template-pack/` (34 recipes), `library/skills-slides/tokens/*.csv`, `library/anthropic-theme-factory/themes/`.
- Galleries for taste calibration: SiteInspire (editorial, typographic), Godly (motion-rich), Land-book, Minimal Gallery, Awwwards; Are.na for research boards.

## Quality gates
- `library/skills-slides/references/anti-slop-checklist.md`; `library/huashu-design/critique-guide.md` (scoring rubric, top-10 problems); slide-creator design-quality rules (summarised in `reference/perception.md` §7 and `reference/taste.md`): 65 % fill rule, column balance ≥ 60 %, 90/8/2 colour, no 3 same layouts, title ≤ 3 lines, no nested cards, no `#000`, no bounce on text, letter-spacing ≤ 0.05em on body, no all-caps body, no mono body.

## Skills and repositories
- Installed: `deck-workflow` (this), `frontend-slides`, `design-system`, `frontend-design`, `pptx`.
- Anthropic: anthropics/skills — frontend-design, theme-factory, canvas-design (poster art), algorithmic-art (p5 generative backgrounds), pptx, pdf.
- Ecosystem catalogue: github.com/ToseaAI/awesome-html-slide-skills (23 skills ranked; re-check monthly), BehiSecc/travisvn/ComposioHQ awesome-claude-skills.
- Vendored (MIT): alchaincyf/huashu-design, codesstar/next-slide, lewislulu/html-ppt-skill, edu-ai-builders/visual-cognition-slides, nghiahsgs/skills-slides, marcogalluccio/claude-slides, jiji262/claude-design-skill, photino/jquery-feyn.
- Online only: op7418/guizang-ppt-skill (AGPL; WebGL shader backgrounds, Swiss layout lock, 634-line checklist), kaisersong/slide-creator (no licence; 16 quality checkpoints, 22 presets), software-ai-life/Awesome-PPT-Design-Skills (6 style packs), zarazhangrui/beautiful-html-templates (66 MB), emilkowalski/skills (design-engineering skill), nicobailon/visual-explainer (diagram pages for code), 1weiho/open-slide (React framework), archlizheng/frontend-slides-editable (drag-resize editor).

## Templates of ours
- `templates/example-aparat-deck.html` (+ design system, brand book) — constructivist, Ukrainian.
- `templates/example-qed-deck.html` (+ `example-qed-design-system.html`, `example-qed-brand-book-a4.html`) — lecture notes, English, diagrams + KaTeX + glossary.
- `templates/example-keynote-noir-deck.html` — QED v2: keynote family (near-black stage, word builds, wordmark morph, 3D gallery wall with focus pulls, springs via `lib/springs.css`, light handout appendix).
- Rule: never ship two decks that look alike (ledger).
