# Animation Patterns Reference

Choose effects to match the emotional tone of the presentation.

---

## Effect-to-Feeling Table

| Effect | Dramatic | Techy | Playful | Professional | Calm | Editorial |
|--------|----------|-------|---------|--------------|------|-----------|
| fade-up | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| scale-in | ✓ | | ✓ | ✓ | | |
| slide-left | | ✓ | ✓ | ✓ | | ✓ |
| blur-in | ✓ | ✓ | | | ✓ | ✓ |
| glitch-in | | ✓ | | | | |
| typewriter | | ✓ | | | | |
| text scramble | | ✓ | ✓ | | | |
| gradient mesh | ✓ | | ✓ | | ✓ | ✓ |
| noise overlay | ✓ | | | | ✓ | ✓ |
| grid pattern | | ✓ | | ✓ | | |
| particle canvas | ✓ | ✓ | | | | |
| aurora | ✓ | | ✓ | | ✓ | |
| 3D tilt | ✓ | ✓ | ✓ | | | |
| magnetic hover | | ✓ | ✓ | | | |
| pulsing ring | ✓ | ✓ | | | | |
| stagger reveal | | | ✓ | ✓ | ✓ | ✓ |
| parallax scroll | ✓ | | ✓ | | ✓ | ✓ |

---

## Entrance Animations CSS

These classes are added to elements. The `--delay` CSS variable controls stagger.

```css
/* ── Shared entrance base ── */
/* All enter- classes start invisible and transition in when slide is active */
[class*="enter-"] {
    animation-fill-mode: both;
    animation-duration: 0.7s;
    animation-delay: var(--delay, 0s);
    animation-timing-function: cubic-bezier(0.16, 1, 0.3, 1);
}

/* ── fade-up: universal, versatile ── */
@keyframes fadeUp {
    from { opacity: 0; transform: translateY(clamp(16px, 3vh, 32px)); }
    to   { opacity: 1; transform: translateY(0); }
}
.enter-fade-up { animation-name: fadeUp; }

/* ── fade-down ── */
@keyframes fadeDown {
    from { opacity: 0; transform: translateY(clamp(-16px, -3vh, -32px)); }
    to   { opacity: 1; transform: translateY(0); }
}
.enter-fade-down { animation-name: fadeDown; }

/* ── scale-in: punchy, cards and icons ── */
@keyframes scaleIn {
    from { opacity: 0; transform: scale(0.88); }
    to   { opacity: 1; transform: scale(1); }
}
.enter-scale-in { animation-name: scaleIn; }

/* ── slide-left: directional, content panels ── */
@keyframes slideLeft {
    from { opacity: 0; transform: translateX(clamp(24px, 5vw, 60px)); }
    to   { opacity: 1; transform: translateX(0); }
}
.enter-slide-left { animation-name: slideLeft; }

/* ── slide-right ── */
@keyframes slideRight {
    from { opacity: 0; transform: translateX(clamp(-24px, -5vw, -60px)); }
    to   { opacity: 1; transform: translateX(0); }
}
.enter-slide-right { animation-name: slideRight; }

/* ── blur-in: cinematic, hero moments ── */
@keyframes blurIn {
    from { opacity: 0; filter: blur(clamp(8px, 1.5vw, 20px)); transform: scale(1.03); }
    to   { opacity: 1; filter: blur(0);                        transform: scale(1); }
}
.enter-blur-in { animation-name: blurIn; }

/* ── glitch-in: tech / hacker aesthetic only ── */
@keyframes glitchIn {
    0%   { opacity: 0; clip-path: inset(40% 0 61% 0); transform: translate(-4px, 2px); }
    10%  { clip-path: inset(92% 0 1%  0); transform: translate(4px, -3px); }
    20%  { clip-path: inset(43% 0 1%  0); transform: translate(-2px, 1px); }
    30%  { clip-path: inset(25% 0 58% 0); transform: translate(2px, -2px); }
    40%  { clip-path: inset(54% 0 7%  0); transform: translate(-4px, 3px); }
    55%  { opacity: 0.7; clip-path: inset(58% 0 43% 0); transform: translate(0); }
    70%  { opacity: 1;   clip-path: inset(0 0 0 0);     transform: translate(0); }
    100% { opacity: 1;   clip-path: none;                transform: translate(0); }
}
.enter-glitch-in {
    animation-name: glitchIn;
    animation-duration: 0.8s;
    animation-timing-function: steps(1);
}

/* ── Stagger helper — apply to list items ── */
/* Usage: <ul class="stagger-list"><li>...</li></ul> */
.stagger-list > *    { animation-name: fadeUp; animation-fill-mode: both; animation-duration: 0.6s; animation-timing-function: cubic-bezier(0.16, 1, 0.3, 1); }
.stagger-list > *:nth-child(1)  { animation-delay: 0.05s; }
.stagger-list > *:nth-child(2)  { animation-delay: 0.15s; }
.stagger-list > *:nth-child(3)  { animation-delay: 0.25s; }
.stagger-list > *:nth-child(4)  { animation-delay: 0.35s; }
.stagger-list > *:nth-child(5)  { animation-delay: 0.45s; }
.stagger-list > *:nth-child(6)  { animation-delay: 0.55s; }
.stagger-list > *:nth-child(n+7){ animation-delay: 0.65s; }
```

---

## Background Effects CSS

### Gradient Mesh

```css
/* Organic, color-shifting background — great for title slides */
.bg-mesh {
    background-color: var(--bg);
    background-image:
        radial-gradient(ellipse 80% 60% at 20%  10%, var(--mesh-1, rgba(124,106,255,0.35)) 0%, transparent 60%),
        radial-gradient(ellipse 60% 80% at 80%  90%, var(--mesh-2, rgba(255,106,176,0.25)) 0%, transparent 60%),
        radial-gradient(ellipse 40% 40% at 60%  30%, var(--mesh-3, rgba(61,220,132,0.15))  0%, transparent 50%);
}

/* Animated version — use sparingly, only on title slide */
@keyframes meshShift {
    0%, 100% { background-position: 0% 0%, 100% 100%, 50% 50%; }
    33%       { background-position: 30% 10%, 70% 80%, 60% 40%; }
    66%       { background-position: 10% 80%, 90% 20%, 40% 70%; }
}
.bg-mesh-animated {
    background-color: var(--bg);
    background-image:
        radial-gradient(ellipse 80% 60%, var(--mesh-1, rgba(124,106,255,0.35)) 0%, transparent 60%),
        radial-gradient(ellipse 60% 80%, var(--mesh-2, rgba(255,106,176,0.25)) 0%, transparent 60%),
        radial-gradient(ellipse 40% 40%, var(--mesh-3, rgba(61,220,132,0.15))  0%, transparent 50%);
    background-size: 200% 200%, 200% 200%, 150% 150%;
    animation: meshShift 12s ease-in-out infinite;
}
```

### Noise Texture Overlay

```css
/* Adds film-grain texture — apply as ::after pseudo-element */
.bg-noise::after {
    content: '';
    position: absolute;
    inset: 0;
    pointer-events: none;
    opacity: 0.04;
    /* SVG turbulence filter as data URI */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='300'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.75' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='300' height='300' filter='url(%23n)' opacity='1'/%3E%3C/svg%3E");
    background-size: 300px 300px;
    mix-blend-mode: overlay;
    z-index: 1;
}
```

### Grid Pattern

```css
/* Blueprint / technical grid — use with dark backgrounds */
.bg-grid {
    background-color: var(--bg);
    background-image:
        linear-gradient(var(--grid-color, rgba(255,255,255,0.04)) 1px, transparent 1px),
        linear-gradient(90deg, var(--grid-color, rgba(255,255,255,0.04)) 1px, transparent 1px);
    background-size: clamp(24px, 4vw, 48px) clamp(24px, 4vw, 48px);
}

/* With accent dot at intersections */
.bg-grid-dot {
    background-color: var(--bg);
    background-image:
        radial-gradient(circle, var(--dot-color, rgba(255,255,255,0.12)) 1px, transparent 1px);
    background-size: clamp(20px, 3vw, 40px) clamp(20px, 3vw, 40px);
}
```

### Aurora Animation

```css
/* Northern lights effect — dramatic title slides */
@keyframes aurora1 {
    0%, 100% { transform: translate(0,    0)    scale(1); }
    33%       { transform: translate(30px, -50px) scale(1.1); }
    66%       { transform: translate(-20px, 30px) scale(0.95); }
}
@keyframes aurora2 {
    0%, 100% { transform: translate(0,    0)     scale(1); }
    33%       { transform: translate(-40px, 20px) scale(1.05); }
    66%       { transform: translate(20px, -40px) scale(1.1); }
}
@keyframes aurora3 {
    0%, 100% { transform: translate(0,    0)    scale(1); }
    50%       { transform: translate(20px, 30px) scale(1.08); }
}

.bg-aurora {
    background: var(--bg);
    overflow: hidden;
}
.bg-aurora::before,
.bg-aurora::after,
.bg-aurora .aurora-3 {
    content: '';
    position: absolute;
    border-radius: 50%;
    filter: blur(80px);
    mix-blend-mode: screen;
    pointer-events: none;
}
.bg-aurora::before {
    width: 60vw; height: 60vw;
    top: -20%; left: -10%;
    background: var(--aurora-1, rgba(124,106,255,0.5));
    animation: aurora1 10s ease-in-out infinite;
}
.bg-aurora::after {
    width: 50vw; height: 50vw;
    bottom: -20%; right: -10%;
    background: var(--aurora-2, rgba(255,106,176,0.4));
    animation: aurora2 13s ease-in-out infinite;
}
.bg-aurora .aurora-3 {
    width: 40vw; height: 40vw;
    top: 40%; left: 40%;
    background: var(--aurora-3, rgba(61,220,132,0.3));
    animation: aurora3 8s ease-in-out infinite;
}
/* HTML: <div class="slide bg-aurora"><div class="aurora-3" aria-hidden="true"></div>...</div> */
```

---

## Interactive Effects JS

### 3D Tilt on Hover

```javascript
// Apply to cards, feature boxes, image containers
function enableTilt(selector = '.card', maxTilt = 12) {
    document.querySelectorAll(selector).forEach(el => {
        el.style.transformStyle = 'preserve-3d';
        el.style.transition = 'transform 0.1s ease';
        el.style.willChange = 'transform';

        el.addEventListener('mousemove', (e) => {
            const rect = el.getBoundingClientRect();
            const cx = rect.left + rect.width  / 2;
            const cy = rect.top  + rect.height / 2;
            const dx = (e.clientX - cx) / (rect.width  / 2);
            const dy = (e.clientY - cy) / (rect.height / 2);

            el.style.transform = `
                perspective(800px)
                rotateX(${-dy * maxTilt}deg)
                rotateY(${dx  * maxTilt}deg)
                translateZ(8px)
            `;
        });

        el.addEventListener('mouseleave', () => {
            el.style.transition = 'transform 0.5s cubic-bezier(0.16,1,0.3,1)';
            el.style.transform  = 'perspective(800px) rotateX(0) rotateY(0) translateZ(0)';
        });

        el.addEventListener('mouseenter', () => {
            el.style.transition = 'transform 0.1s ease';
        });
    });
}
// Call after DOM ready: enableTilt('.card');
```

### Magnetic Hover

```javascript
// Buttons that subtly follow the cursor — premium feel
function enableMagnetic(selector = '.cta-button', strength = 0.4) {
    document.querySelectorAll(selector).forEach(el => {
        el.style.transition = 'transform 0.3s cubic-bezier(0.16,1,0.3,1)';
        el.style.display     = 'inline-block';

        el.addEventListener('mousemove', (e) => {
            const rect = el.getBoundingClientRect();
            const cx = rect.left + rect.width  / 2;
            const cy = rect.top  + rect.height / 2;
            const dx = (e.clientX - cx) * strength;
            const dy = (e.clientY - cy) * strength;
            el.style.transform = `translate(${dx}px, ${dy}px)`;
        });

        el.addEventListener('mouseleave', () => {
            el.style.transform = 'translate(0, 0)';
        });
    });
}
// Call after DOM ready: enableMagnetic('.cta-button');
```

---

## Troubleshooting Table

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| Slides don't snap on scroll | Missing `scroll-snap-type: y mandatory` on `html` | Add to `html {}` rule |
| Content clips at bottom | Slide height less than content height | Reduce font sizes; use `clamp()`; remove excess elements |
| Animation plays on wrong slide | Observer threshold too low | Increase to 0.6; or use scroll-driven animations |
| Flicker on slide enter | GPU layer not promoted | Add `will-change: transform` to animated elements |
| Keyboard nav fights with browser shortcuts | Space / arrow keys default behavior | Use `e.preventDefault()` in keydown handler |
| Touch swipe triggers browser back | Horizontal swipe detected as nav | Check `Math.abs(dy) > Math.abs(dx)` guard |
| Nav dots not updating | IntersectionObserver not bound | Ensure `observeSlides()` is called after DOM ready |
| Reduced-motion ignored | Animation set via JS style, not CSS | Apply `animation-duration: 0.01ms` via CSS `!important` |
| Fonts flash / FOUT | No `font-display: swap` | Add `display=swap` to Google Fonts URL |
| Overflow on mobile landscape | `100vh` not accounting for browser chrome | Use `100dvh` with `100vh` fallback |
