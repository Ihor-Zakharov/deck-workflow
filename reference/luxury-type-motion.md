# Expensive typography and elite motion — the rules

The user's brief: decks must look "дорого и элитно". Cheap = default fonts, loose tracking, bouncy easing, everything moving. Expensive = restraint with precision.

## Typography (what makes it look expensive)

1. **Pairing with contrast, not variety.** One display face with character + one neutral text face + one mono for chrome. Never four fonts.
   - Editorial luxury: Cormorant Garamond / Playfair Display / Fraunces / Instrument Serif (display) + Manrope / Work Sans / Golos (text).
   - Modern luxury: Unbounded 300–500, Syne, Cabinet Grotesk, Clash Display (Fontshare), Space Grotesk only if nothing else fits.
   - Ultra-light weight (200–300) at huge size reads as premium; ultra-bold (900) reads as poster. Choose one voice per deck.
   - Ukrainian/Cyrillic: Cormorant, Lora, Playfair, Raleway, Manrope, Unbounded, Golos, Onest, Commissioner, JetBrains Mono. Never Jost.
2. **Scale with drama.** Display 140–180px, headline 72–104px, body 24–26px, captions 16–17px, labels 13–15px mono. The jump between levels should be ≥2× — that jump is the luxury.
3. **Tracking.** Display: −0.02…−0.04em. Uppercase mono labels: +0.16…+0.24em, 13–15px. Body: 0. Never track lowercase text.
4. **Leading.** Display 0.92–1.0, headline 1.0–1.15, body 1.5–1.6. Tight display leading is the single fastest "expensive" signal.
5. **Measure.** Body lines 55–75 characters (max-width ≈ 1100px at 25px). Lead paragraphs one idea, 2–3 lines.
6. **Whitespace is the ornament.** Side padding ≥120px, content in the middle 60–70%. If a slide feels empty, that is correct; if it feels full, split it.
7. **Hierarchy through weight/italic, not color.** One accent color for ≤2 words per slide. Mono label + 36–44px accent rule as the eyebrow.
8. **Details that read as craft**: hanging punctuation for quotes («, "), real dashes, thin spaces around ×, small numerals in mono, `font-feature-settings: "ss01","liga","kern"`, `text-wrap: balance` on headings, `hyphens: none`, `font-variant-numeric: tabular-nums` for numbers.
9. **No** text-shadows, glows, gradient-clip text, outlined text, drop caps in sans, all-caps body, emoji.

## Motion (elite, not busy)

1. **Easing is the brand.** Use only `cubic-bezier(0.16, 1, 0.3, 1)` (expo-out) for entrances and `cubic-bezier(0.7, 0, 0.2, 1)` for movement; never `ease-in-out` bounce or spring on text. Springs are allowed only for one physical object (a stamp landing).
2. **Durations.** Entrance 0.7–0.9s, stagger step 0.10–0.13s, ambient loops 6–12s, hover 0.25–0.35s, crossfade between slides 0.8–1.0s. Nothing under 0.2s, nothing that loops faster than 4s except a marquee.
3. **One choreography per slide**: elements enter in reading order, top-left → bottom-right, offsets 24–40px, opacity 0→1, no scale on text (scale only on shapes/images 0.96→1). Everything settles within 1.5s.
4. **Ambient budget: max one moving thing at rest** (a drifting disc, a slow marquee, a rotating stamp ring). If two exist, one must be barely perceptible (≤30px drift over 7s).
5. **Reveal on demand.** Long lists: `.step` reveals on arrow key (claude-slides animations model) instead of dumping 8 items at once.
6. **Signature moments (2–3 per deck, not per slide)**: stamp slam, a hairline that draws across the slide, a number counting up, an SVG path drawing itself, a photo un-desaturating on hover.
7. **Hover** only on real objects (cards, images, nav): translate −4px + shadow grow, or image scale 1.04. No tilt on text blocks.
8. **Transitions between slides**: crossfade only. No wipes, flashes, zooms.
9. **Reduced motion** honoured; the deck must still look designed with motion off.

## Quick self-check before delivery
- Can you name the deck's display face and why it fits the topic? (If not, it's generic.)
- Does any slide have more than one thing moving after 1.5s? (Cut it.)
- Are there at least 3 slides with almost nothing on them? (Luxury needs silence.)
- Is the biggest type on the deck ≥140px and the smallest ≥13px?
- Do the mono labels, rules and stamps use the same vocabulary across every slide?
