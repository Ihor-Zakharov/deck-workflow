# Deck ledger — what has been made, and how the next one must differ

Append one row per delivered deck. Before choosing a direction for a new deck, read the last two rows and pick values that differ in **at least 5 of the 8 axes**. The skeleton (1920×1080 stage, crossfade, side nav, progress bar, BUILD-versioned editor) never changes; everything visible does.

## Axes

1. **Surface** — cream paper · graph paper · blackboard · newsprint · photo full-bleed · gradient/mesh · solid colour block · blueprint · risograph paper · glass/dark UI
2. **Polarity** — light-dominant with dark accents · dark-dominant with light accents · accent-colour-dominant · alternating by section
3. **Type voice** — serif display with character (Fraunces, Cormorant, Playfair, Instrument Serif, Newsreader) · tight grotesk (Onest, Manrope, Unbounded, Syne, Bricolage, Cabinet) · slab/condensed poster (Bebas, Oswald, Anton) · mono-led (JetBrains, Plex Mono, Geist Mono) · humanist/warm (Golos, Commissioner, Lora) — Cyrillic required for Ukrainian decks
4. **Graphic device** — stamps · marquee bands · discs · hard-shadow cards · hairlines/crop marks · tabs/index cards · brackets/hand-drawn notation · 3D tilted gallery · halftone/duotone · tape/paper-clip collage · tickets/passport stamps · terminal cursor/ASCII field
5. **Chrome language** — bureaucratic forms · lecture notes/journal · museum labels · film slate/keynote · passport/customs · ledger/accounting · blueprint title block · terminal/log · newspaper masthead · field notebook · liner notes · court record
6. **Motion signature** — stamp slam + band · diagrams draw themselves · keynote word builds + blur-in · gallery ripple + focus pull · counters + bar growth · mask reveals + slow camera · weight morph wordmark · typewriter/chunk reveal
7. **Image treatment** — constructivist riso portrait · chalk on board · engraving/plate · halftone photo · duotone · full-colour editorial photo · cyanotype · watercolour · 3D clay render · pixel/arcade
8. **Layout grammar** — poster (giant type + one shape) · editorial two-column · Swiss modular grid · centered keynote statements · bento boxes · magazine spread with gutters · ledger/table-led · scrapbook asymmetry

## Ledger

| # | Date | Deck (path) | Surface | Polarity | Type voice | Graphic device | Chrome language | Motion signature | Image treatment | Layout grammar | Verdict |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 2026-09-09 | Бюрократія — `presentations/burokratiya.html` (Monochrome Ledger, Ukrainian) | cream paper | light | humanist (Raleway) | hairlines, ledger rules | ledger/accounting | reveal cascades | none | ledger/table-led | good; superseded by Апарат |
| 2 | 2026-09-10 | «Апарат» — `presentations/aparat/burokratiya-aparat.html` (constructivist, Ukrainian) | warm paper + solid vermilion/ink slides | alternating | tight grotesk 900 (Unbounded) + Manrope | stamps, bands, discs, hard-shadow cards, dossier card | bureaucratic forms (Форма № 01…14) | stamp slam + band marquee + disc drift | riso/linocut portrait (Kafka) | poster | "отличная" — reference density for motion |
| 3 | 2026-09-10 | QED «Lecture Notes» — `presentations/qed/qed.html` (English) | graph paper + blackboard | alternating (paper / board / one gold) | serif display (Fraunces 900 + 400 italic) + IBM Plex | stamps, one band, discs, index cards, chalk frames | lecture notes / journal (§, Fig., Eq.) | self-drawing SVG Feynman diagrams + stamps | chalk on board (Feynman, blackboard, antenna) | editorial two-column + glossary tables | "супер, очень красивая" — reference; animations slowed ×1.35 on request |
| 4 | 2026-09-10 | QED v2 «Keynote Noir» — `presentations/qed-v2/qed-v2.html` (English; same Gemini assets as v1) | warm near-black stage + full-bleed chalk images; off-white handout appendix | dark-dominant, light appendix | tight grotesk (Onest 100–900 variable) + Instrument Serif italic accents + Geist Mono | Apple gallery cards (hairline, 14 px radius, soft double shadows), gold photon line, α ring, 3D tilted gallery wall of 12 diagrams | keynote/film (chip top-right, "07 — 20", no stamps/bands) | wordmark weight morph, word-by-word blur builds, gallery ripple + focus pull, mask reveal + slow camera, count-up, springs via linear() | chalk on board (same assets) | centred keynote statements + bento + spec rows | mixed: wall-as-background, text builds, springs and some graphics loved; dark hairline cards, flat stage, click-to-focus, white-mount portrait and no gamut change rejected — v1 stays better |
| 5 | 2026-09-10 | **QED v3 «Lecture Notes, improved» — `presentations/qed-v3/qed-v3.html` — THE STANDARD** | graph paper + blackboard, blackboard photo behind the title | alternating paper / board / one gold | serif display (Fraunces) + IBM Plex | stamps (6, two hero entrances), bands (2), discs, index cards, chalk frames, the 3D wall | lecture notes / journal | letter blur-in (title, closing), word builds (3 headings), self-drawing diagrams, the dim 3D wall behind the closing, hero stamps, springs | chalk on board | editorial two-column + glossary | v1 + v2's best; reference for every next deck |
| 6 | 2026-09-10 | **Бюрократія v2 «Креслення апарату» — `presentations/burokratiya-v2/burokratiya-v2.html` (Ukrainian) — THE SECOND STANDARD** (`templates/example-blueprint-deck.html`) | blueprint cyanotype with a global sheet layer (frame + registration marks, feTurbulence mottling, grain, vignette) + archive/desk Gemini backgrounds; paper and one yellow | alternating blue / paper / two yellow | condensed poster caps (Fira Sans Extra Condensed 800) + Cormorant italic + IBM Plex Sans + JetBrains Mono | sheet frame, dimension lines, inspection stamps (6, two hero), title block, tape bands (3), wall of forms, sheet tabs «Арк. NN», drafted § watermarks, portrait in a line frame | technical-drawing title block (Розроб. · Перевір. · Затв. · Арк.) | letter blur-in hero, hero stamps, dimension lines and mechanisms that draw themselves level by level (org chart Рис. 1, vicious circle Рис. 2 with an orbiting dot), wall of forms, word builds, bars, count-up | cyanotype duotone (Kafka) + on-palette cyanotype backgrounds | poster + specification blocks + forms + 2×2 slabs | reference-quality after the 10.09 evening pass; quarry of universal devices next to QED v3 |

## Direction seeds not yet used (pick, then adapt — never copy a demo wholesale)

- **Newsprint broadsheet** — masthead, columns, drop caps, halftone photos, ink-bleed hover (`newsprint-broadsheet.html`)
- **Museum wall labels** — off-white walls, small mono labels, huge negative space, one artefact per slide, mask reveals
- **Passport / customs** — visa stamps, perforated tickets, security patterns, "admitted/denied" verdicts
- **Terminal phosphor** — green/amber on black, chunk-reveal typing, ASCII fields, cursor blink as the only ambient (`terminal-green.html`)
- **Risograph overprint** — two-ink misregistration, fluorescent pink + blue, grain, zine collage (`risograph-overprint.html`, claude-design zine)
- **Swiss IKB** — International Klein Blue full bleeds, Helvetica-class grotesk (Inter Tight/Archivo), strict grid, kicker above title (guizang Swiss rules)
- **Bauhaus primary** — circle/triangle/square, red/yellow/blue on cream, rotated type (claude-design Bauhaus, next-slide `bauhaus-primary.html`)
- **Field notebook** — kraft paper, pencil rules, taped photos, hand-drawn rough-notation underlines
- **Wabi-sabi / Kenya Hara** — vast emptiness, one object, gentle springs, paper grain (claude-design Kenya Hara, next-slide `wabi-sabi-zen.html`)
- **Art deco / Gatsby** — gold geometry on deep green/black, stepped frames, Cormorant + Josefin caps (`art-deco-gatsby.html`)
- **Film slate** — clapperboard chrome, timecode footers, 2.39 letterbox images, weight-morph titles (`cinema-scope.html`, `dark-cinema.html`)
- **Clay 3D / soft** — pastel claymorphism, soft double shadows, bouncy springs (Awesome-PPT clay pack, `claymorphism-3d.html`)
