# Anti-Slop Quality Gate

10 checks Claude MUST pass before delivering any presentation. These exist because AI-generated slides often default to a recognizable "slop aesthetic": purple gradients, Inter font, identical shadows everywhere. This checklist prevents it.

Run through all 10 points after generation, before output.

---

## Point 1: No Generic Display Fonts

**Rule:** Do not use Inter, Roboto, Arial, system-ui, or -apple-system as the **display/heading** font.

**Why it fails:** These are default browser/OS fonts. Using them signals zero design investment. They are fine for body text at small sizes but kill visual identity at heading scale.

**Examples of slop:**
```css
/* BAD */
font-family: 'Inter', sans-serif; /* on h1 */
font-family: system-ui, sans-serif; /* on headings */
```

**Correct approach:** Choose a display font from the font tokens. Every aesthetic has a paired display font.
```css
/* GOOD — examples from different aesthetics */
font-family: 'Syne', sans-serif;           /* editorial / bold */
font-family: 'Space Grotesk', sans-serif;  /* techy / geometric */
font-family: 'DM Serif Display', serif;    /* luxury / calm */
font-family: 'Bebas Neue', sans-serif;     /* dramatic / poster */
font-family: 'Cabinet Grotesk', sans-serif;/* playful / modern */
```

Body text CAN use Inter/Roboto at small sizes if the display font is distinctive.

---

## Point 2: No Purple Gradient on White Background

**Rule:** The combination of `purple → blue` or `purple → pink` gradient text/elements on a plain white `#ffffff` or near-white background is banned.

**Why it fails:** This is the single most overused AI-generated design pattern. It reads as template-generated, not intentional.

**Slop fingerprint:**
```css
/* BAD */
background: linear-gradient(135deg, #667eea, #764ba2);
background: white;
color: #333;
```

**Correct approach:** If you want purple/violet as the accent, pair it with a dark background or a unique color system:
```css
/* GOOD — violet accent on dark bg */
--bg: #0d0d1a;
--accent: #8b5cf6;
--text: #f0f0ff;

/* GOOD — violet in an unexpected palette */
--bg: #1a0a2e;
--surface: #2d1b69;
--accent: #c084fc;
--text: #faf0ff;
```

---

## Point 3: No Identical Shadows on All Elements

**Rule:** Do not apply a single `box-shadow` value uniformly to every card, button, and container on a slide.

**Why it fails:** Real interfaces have depth hierarchy — elements at different elevations have different shadows. Identical shadows flatten the design.

**Slop:**
```css
/* BAD — same shadow everywhere */
.card, .button, .panel, .badge {
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}
```

**Correct approach:** Use an elevation system:
```css
/* Shadow tokens — 3 tiers of depth */
--shadow-sm:  0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.08);
--shadow-md:  0 4px 16px rgba(0,0,0,0.2),  0 2px 4px rgba(0,0,0,0.12);
--shadow-lg:  0 12px 40px rgba(0,0,0,0.3), 0 4px 8px rgba(0,0,0,0.15);

/* Glow shadows for accent elements */
--shadow-glow: 0 0 30px rgba(var(--accent-rgb), 0.4);

/* Elements use appropriate tier */
.badge    { box-shadow: var(--shadow-sm); }
.card     { box-shadow: var(--shadow-md); }
.modal    { box-shadow: var(--shadow-lg); }
.hero-cta { box-shadow: var(--shadow-glow); }
```

---

## Point 4: Colors Use CSS Variables

**Rule:** All colors must be defined as CSS custom properties (variables). No random hex codes scattered through the stylesheet.

**Why it matters:** Variables ensure consistency, enable theming, and signal intentional design. Random hex values in different rules often drift — `#4f46e5` in one place and `#5046e6` in another.

**Slop:**
```css
/* BAD */
.card { background: #1e1e2e; border: 1px solid #3d3d5c; }
.heading { color: #f0f0f5; }
.accent-text { color: #7c6aff; }
```

**Correct approach:**
```css
/* GOOD */
:root {
    --bg: #0a0a0f;
    --surface: #1e1e2e;
    --border: rgba(255,255,255,0.08);
    --text: #f0f0f5;
    --accent: #7c6aff;
}
.card    { background: var(--surface); border: 1px solid var(--border); }
.heading { color: var(--text); }
.accent-text { color: var(--accent); }
```

Exception: one-off decorative values that genuinely should not be reused (e.g., a specific aurora blob color used once) can be inline, but must be commented.

---

## Point 5: Font Sizes Use clamp()

**Rule:** All font sizes must use `clamp(min, preferred, max)` — never fixed `px` or `rem` values on heading elements.

**Why it matters:** Fixed sizes break on different screen sizes. A `48px` title looks great on a 1920px monitor but is enormous on a 320px mobile or overflows on a 768px tablet.

**Slop:**
```css
/* BAD */
h1 { font-size: 64px; }
h2 { font-size: 36px; }
p  { font-size: 18px; }
```

**Correct approach — already defined in viewport-base.css:**
```css
/* GOOD — use variables from viewport-base.css */
h1 { font-size: var(--title-size); }  /* clamp(1.5rem, 5vw, 4rem) */
h2 { font-size: var(--h2-size);   }  /* clamp(1.25rem, 3.5vw, 2.5rem) */
p  { font-size: var(--body-size); }  /* clamp(0.75rem, 1.5vw, 1.125rem) */
```

Custom heading sizes are allowed but must also use clamp:
```css
.hero-title { font-size: clamp(2rem, 8vw, 6rem); } /* GOOD */
.hero-title { font-size: 96px; }                    /* BAD */
```

---

## Point 6: At Least 1 Signature Visual Effect

**Rule:** Every presentation must include at minimum one distinctive visual effect that matches its chosen aesthetic. Generic slides with only flat colors and static text are not acceptable.

**What counts as a signature effect:**
- Animated gradient mesh background (aurora, blob, mesh)
- Custom noise/texture overlay
- Glowing text or border on key elements
- Particle system or geometric animation
- 3D perspective on card grid
- Custom SVG background pattern
- Glassmorphism with real backdrop-filter
- Kinetic typography on title

**What does NOT count:**
- Plain box-shadow
- Simple color transitions
- Basic opacity fade
- Border-radius on cards

**Example — minimum for each aesthetic category:**

| Aesthetic Category | Minimum Signature Effect |
|-------------------|--------------------------|
| Dark / Techy | Grid pattern background + glow on accent elements |
| Luxury / Elegant | Noise texture + gold gradient text on title |
| Playful / Colorful | Aurora background + bouncy scale-in animation |
| Editorial / Minimal | SVG line pattern + blur-in entrance on headlines |
| Corporate / Professional | Subtle dot-grid + staggered reveal animation |

---

## Point 7: Background Has Depth

**Rule:** No slide may have a plain, flat solid color as its background with no texture, gradient, or layering.

**Why it matters:** Flat solid colors read as unfinished. Real premium presentations have backgrounds with at least subtle depth.

**Minimum acceptable backgrounds:**

```css
/* Subtle gradient — absolute minimum */
background: linear-gradient(160deg, var(--bg) 0%, color-mix(in oklch, var(--bg), var(--accent) 8%) 100%);

/* Vignette over solid — adds depth cheaply */
background: radial-gradient(ellipse at center, color-mix(in oklch, var(--bg), white 5%) 0%, var(--bg) 70%);

/* Noise texture — always acceptable */
.slide::before {
    content: '';
    position: absolute; inset: 0;
    background-image: url("data:image/svg+xml,...");
    opacity: 0.04;
    pointer-events: none;
}

/* Grid or dot pattern — acceptable for techy aesthetics */
background-image: linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px), ...;
```

**Exception:** Full-bleed image slides where the image IS the background. Text overlay must still have a scrim/gradient for readability.

---

## Point 8: Text Hierarchy — Minimum 3 Distinct Sizes

**Rule:** Every content slide must use at least 3 visually distinct text sizes with clear visual order.

**Why it matters:** Hierarchy guides the eye. When everything is the same size, nothing is scannable.

**Required tier structure:**
1. **Primary** — slide heading / title (largest, highest contrast)
2. **Secondary** — supporting text, subheadings, card titles
3. **Tertiary** — body copy, labels, captions, metadata

**Checklist:**
- [ ] H1/title is at least 2× larger than body text
- [ ] There is a mid-tier element (h3, label, card title) between title and body
- [ ] Weight variation supports size (bold title, regular body, lighter caption)
- [ ] Color/opacity variation reinforces hierarchy (full opacity title, 70% body, 50% label)

**Example of good hierarchy:**
```html
<h2 style="font-size:var(--h2-size); font-weight:700; color:var(--text);">
    Main Heading
</h2>
<p class="label" style="font-size:var(--label-size); letter-spacing:0.1em; color:var(--accent);">
    CATEGORY LABEL
</p>
<p style="font-size:var(--body-size); color:var(--text-muted); font-weight:400;">
    Supporting body text at lower contrast
</p>
```

---

## Point 9: WCAG AA Contrast (4.5:1) on All Text

**Rule:** All text must meet WCAG 2.1 Level AA contrast ratio (4.5:1 for normal text, 3:1 for large text over 18pt/bold 14pt).

**Why it matters:** Accessibility is non-negotiable. Also, low-contrast text is unreadable on projectors and screens with glare.

**Quick reference — minimum contrast for common patterns:**

| Text color | On dark bg | On light bg |
|-----------|-----------|------------|
| `#ffffff` white | 21:1 on #000 ✓ | Fails on white |
| `#f0f0f5` off-white | 17:1 on #0a0a0f ✓ | |
| `#8888aa` muted | 4.6:1 on #0a0a0f ✓ | Fails on light |
| `#7c6aff` accent | 4.2:1 on #0a0a0f — FAILS | Use brighter tint |
| `#a59fff` lighter accent | 5.8:1 on #0a0a0f ✓ | |

**Accent color pitfall:** Saturated accent colors (neon purple, hot pink) often fail AA against dark backgrounds. Use a lighter tint for text, reserve the saturated color for backgrounds and borders.

**Free checker:** https://webaim.org/resources/contrastchecker/

**CSS solution for muted text that barely passes:**
```css
/* Instead of guessing, use color-mix to ensure readable tints */
--text-muted: color-mix(in oklch, var(--text) 60%, var(--bg) 40%);
```

---

## Point 10: prefers-reduced-motion Support

**Rule:** Every presentation must include the `prefers-reduced-motion` media query that disables or reduces all animations for users who have requested it.

**Why it matters:** Vestibular disorders affect ~35% of adults over 40. Fast animations can cause nausea and dizziness. This is both an accessibility requirement and a legal consideration (ADA / WCAG 2.3).

**Minimum required implementation** (already in viewport-base.css, verify it's included):
```css
@media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
        animation-duration:        0.01ms !important;
        animation-iteration-count: 1      !important;
        transition-duration:       0.2s   !important;
    }
    html { scroll-behavior: auto; }
}
```

**Also check JS animations:**
```javascript
// Before running JS animations, check preference
const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
if (!prefersReduced) {
    enableTilt('.card');
    enableMagnetic('.cta-button');
    enableParticles();
}
```

**Keyboard hint also needs check:** If JS scroll behavior is customized, ensure it respects the preference:
```javascript
const behavior = window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'instant' : 'smooth';
slide.scrollIntoView({ behavior });
```

---

## Checklist Summary (Copy-Paste for Review)

```
Pre-delivery quality gate:

[ ] 1. Display font is NOT Inter/Roboto/Arial/system-ui
[ ] 2. NO purple gradient on white/near-white background
[ ] 3. Shadows have hierarchy (sm/md/lg tokens, not one value everywhere)
[ ] 4. All colors reference CSS variables (no raw hex in rules)
[ ] 5. All font sizes use clamp() via --title-size/--h2-size/--body-size vars
[ ] 6. At least 1 signature visual effect matching chosen aesthetic
[ ] 7. Background has texture/gradient/depth (not flat solid color)
[ ] 8. 3+ distinct text sizes with clear visual hierarchy
[ ] 9. All text passes WCAG AA 4.5:1 contrast ratio
[ ] 10. prefers-reduced-motion media query present and correct
```
