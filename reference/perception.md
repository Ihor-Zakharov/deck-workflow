# Perception — how a human actually experiences a slide (design psychology, applied)

Evidence-based rules, then what they mean for our decks. Sources: Mayer's multimedia-learning principles; Alley's assertion–evidence research (Penn State: sentence headline + visual evidence beats topic + bullets on comprehension and one-week recall, p < .01, lower perceived cognitive load); Laws of UX (Hick, Miller, von Restorff, aesthetic-usability, peak-end, serial position, Doherty); Gestalt grouping; Tversky & Morrison on animation; NN/g on dark mode, serif vs sans on HD screens, and motion; Duarte *Resonate*; Reynolds *Presentation Zen*; readability studies (line length ~55 cpl, contrast polarity, 8H rule); huashu-design critique guide; visual-cognition-slides PEDAGOGY.

## 1. Memory and load

- **Working memory holds ~4 chunks** (Miller's 7±2 is the generous upper bound). One idea per slide; ≤ 5 supporting items; tables are fine because they are scanned, not held.
- **Cognitive load theory**: every decorative element competes with the idea. Coherence principle (Mayer): remove extraneous words, pictures, sounds. Our devices (stamps, bands, discs) are allowed because they carry the deck's *world* and rhythm — but each must pass the ownership test: belongs to this slide's idea, or is global chrome; anything else is filler.
- **Redundancy principle**: do not put the spoken script on the slide. Speaker-led decks show the assertion and the evidence; the speaker supplies the prose. Captions repeat nothing said aloud.
- **Signaling**: highlight the organisation — kicker → heading → items; one accent colour for the ≤ 2 words that matter; numbered sections; the side nav.
- **Segmenting**: build complex slides in beats (reveal cascade, or reveal on key). A 12-term glossary appears as a staggered table, not at once.
- **Spatial/temporal contiguity**: label next to the thing (formula annotations under the term, diagram labels at the line), and show the visual when it is spoken, not three slides earlier.
- **Pre-training**: introduce the vocabulary before the mechanism (QED: "two fields, one vertex" before Feynman rules).

## 2. What is remembered

- **Assertion–evidence**: headline = a full sentence stating the point ("Forces are exchanged photons"), body = visual evidence (diagram, number, image), not a bulleted restatement. Never template headings ("Overview", "Conclusion", "Key insights").
- **Picture superiority / dual coding**: a distinctive picture + a word is encoded twice; abstract stock imagery adds nothing. Generated images must depict the *specific* thing (Feynman at 30, the exact antenna), on-palette.
- **Von Restorff (isolation)**: the one different thing is remembered. Hence one accent colour, one signature moment per slide, one dark/gold slide in a run of paper slides.
- **Serial position + peak–end**: the first and last slides and the *peak* are what survive. Spend the most craft on the title, the one "STAR moment" (Duarte: the memorable, quotable, dramatic moment), and the closing line. Middle slides may be quieter.
- **Emotion and story**: a real anecdote (Bohr at Pocono 1948), a real quote, a joke that lands ("Questions accepted to all orders") create emotional tags that make the content retrievable. Easter eggs are memory hooks, not decoration.
- **Curiosity gap + retrieval**: pose the question before the answer ("Where is the photon in your antenna?"), let the audience guess, then reveal — the reveal cascade is the mechanism.

## 3. What the eye does

- **Gestalt**: proximity (gap between groups ≥ 2× gap inside), similarity (same role = same type/colour), common region (cards, frames), figure–ground (one dominant figure; the background image must recede — dim + blur), continuity (align to a grid; rules draw the eye along).
- **Scanning**: mixed text + visual slides read in a Z (top-left kicker → top-right chrome → bottom-left body → bottom-right stamp/CTA); dense text (glossary) reads in an F (strong left column, headers). Put the assertion at the top-left, the payoff bottom-right.
- **Attention capture**: motion in peripheral vision grabs attention automatically (rod photoreceptors) — this is why ambient motion must be slow and small; a fast marquee next to a formula steals the formula's attention. Accelerating motion captures fastest; decelerating (expo-out) settles fastest.
- **Change blindness**: viewers miss changes that happen during a crossfade unless signalled. When a slide *updates* (step reveal), move or highlight the changed element; never swap silently.
- **Perception thresholds**: ~100 ms feels instant; 400 ms (Doherty) is the limit for a responsive nav; motion under ~5 ms is invisible; 60 fps is required for motion to read as motion rather than stutter.
- **Aesthetic-usability effect**: a beautiful deck is judged more credible and more usable — craft buys trust for the content. This is the psychological justification for "beauty first".

## 4. Readability on a stage/projector

- Body ≥ 24 px at 1920×1080 (≈ 24 pt), captions ≥ 17 px, mono labels ≥ 13 px only in chrome; the largest element ≥ 5× the smallest.
- Line length 45–75 characters (55 is the sweet spot) → max-width ≈ 1100 px at 25 px; line-height 1.4–1.6 body, 0.9–1.0 display.
- Contrast ≥ 4.5:1 for text; on dark decks use chalk/cream (#F1ECDD) not pure white and never pure black backgrounds (#000) — use #111–#1B in the deck's temperature. Positive polarity (dark on light) reads ~26 % more accurately for long text — so glossary and dense slides prefer paper backgrounds; dark slides for statements, quotes and images.
- Projectors soften edges and lose contrast: no hairline-thin type (< 300 weight) for anything that must be read; hairline rules are fine as decoration.
- Serif vs sans on HD screens: no measurable speed difference; choose by voice. Sans for tables/labels/IPA; serif display for character.
- 8H rule: the farthest viewer sits ≤ 8× screen height away; our 24 px body assumes that; if the room is bigger, scale up.

## 5. Colour and tone

- **90/8/2**: 90 % neutral surfaces, 8 % structural accent, 2 % precise hits. If the accent appears on > 3 element types on one slide, it stopped being signal.
- Temperature carries mood: warm neutrals = paper/craft/human; cool = technical; a single saturated accent = confidence. Match the accent to the register (research → warm brown/gold; engineering → navy/blue; data → teal; narrative → amber) unless the style has a stronger identity.
- Print-like desaturation reads as expensive; neon and pure primaries read as cheap unless the style is deliberately pop.

## 6. Pacing across the deck

- Alternate dense and quiet slides; never 3 consecutive slides with the same visual signature or the same layout; no 3 bullet slides in a row.
- Attention resets every ~10 minutes: place an image, a quote, a joke or an interactive moment at least every 6–8 slides.
- Duarte's sparkline: oscillate between "what is" and "what could be" (QED: infinities → renormalization; classical radio → quantum limit); end with the "new bliss" (the closing statement).
- Opening: the first slide must be composed and still within 2 s so the speaker can begin; the closing slide must hold a sharp final frame (no fade-out).

## 7. Translate into deck rules (checklist used in Phase 7)

- [ ] Every heading is an assertion (a sentence with a verb or a claim), not a label.
- [ ] Every slide has one idea, ≤ 5 supporting items, one accent hit, one signature at most.
- [ ] Text never repeats what the speaker will say; captions add, not echo.
- [ ] Labels sit next to their objects; formulas are annotated in place.
- [ ] Images depict the specific subject and recede behind text (dim + blur or an empty third).
- [ ] Ambient motion is slow/small; nothing fast moves near text that must be read.
- [ ] Dense slides on light paper; statements and images on dark; contrast ≥ 4.5:1; body ≥ 24 px.
- [ ] First, peak and last slides got the most craft; a STAR moment exists and is named in the brief.
- [ ] No 3-in-a-row repeats of layout; a reset (image/quote/humour) every ≤ 8 slides.
- [ ] Vocabulary introduced before mechanism; question posed before answer.
