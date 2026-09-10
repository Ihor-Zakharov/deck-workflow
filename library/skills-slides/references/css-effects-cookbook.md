# CSS Effects Cookbook

Premium, production-ready CSS/JS techniques. Every snippet is complete and copy-paste ready.

---

## Backgrounds

### Glassmorphism (Dark Mode)

```css
/* Frosted glass panel — requires a colorful/blurred background behind it */
.glass {
    background: rgba(255, 255, 255, 0.06);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: var(--radius-lg);
    box-shadow:
        0 8px 32px rgba(0, 0, 0, 0.4),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
}

/* Stronger tint for readability on busy backgrounds */
.glass-strong {
    background: rgba(10, 10, 20, 0.55);
    backdrop-filter: blur(24px) saturate(200%);
    -webkit-backdrop-filter: blur(24px) saturate(200%);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: var(--radius-lg);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.5);
}

/* Glass with accent border tint */
.glass-accent {
    background: rgba(124, 106, 255, 0.08);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border: 1px solid rgba(124, 106, 255, 0.25);
    border-radius: var(--radius-lg);
    box-shadow:
        0 4px 24px rgba(124, 106, 255, 0.15),
        inset 0 1px 0 rgba(255, 255, 255, 0.08);
}
```

### Aurora Gradient Animation

```css
/* Full-slide animated aurora — for title/hero slides */
.bg-aurora {
    background: var(--bg, #050510);
    position: relative;
    overflow: hidden;
}

.bg-aurora .aurora-layer {
    position: absolute;
    border-radius: 50%;
    filter: blur(80px);
    mix-blend-mode: screen;
    pointer-events: none;
    will-change: transform;
}

.bg-aurora .aurora-1 {
    width: 70vw; height: 70vw;
    background: radial-gradient(circle, rgba(100, 80, 255, 0.6), transparent 70%);
    top: -20%; left: -15%;
    animation: auroraDrift1 14s ease-in-out infinite;
}
.bg-aurora .aurora-2 {
    width: 55vw; height: 55vw;
    background: radial-gradient(circle, rgba(240, 80, 180, 0.5), transparent 70%);
    bottom: -20%; right: -10%;
    animation: auroraDrift2 17s ease-in-out infinite;
}
.bg-aurora .aurora-3 {
    width: 45vw; height: 45vw;
    background: radial-gradient(circle, rgba(40, 200, 160, 0.4), transparent 70%);
    top: 35%; left: 35%;
    animation: auroraDrift3 11s ease-in-out infinite;
}

@keyframes auroraDrift1 {
    0%, 100% { transform: translate(0,   0)    scale(1);    }
    33%       { transform: translate(5vw, -6vh) scale(1.12); }
    66%       { transform: translate(-4vw, 5vh) scale(0.93); }
}
@keyframes auroraDrift2 {
    0%, 100% { transform: translate(0,    0)    scale(1);    }
    40%       { transform: translate(-6vw, 4vh)  scale(1.08); }
    70%       { transform: translate(4vw, -5vh)  scale(1.14); }
}
@keyframes auroraDrift3 {
    0%, 100% { transform: translate(0,   0)   scale(1);    }
    50%       { transform: translate(4vw, 4vh) scale(1.1);  }
}

/* HTML:
<section class="slide bg-aurora">
    <div class="aurora-layer aurora-1" aria-hidden="true"></div>
    <div class="aurora-layer aurora-2" aria-hidden="true"></div>
    <div class="aurora-layer aurora-3" aria-hidden="true"></div>
    <div class="slide-content">...</div>
</section>
*/
```

### Particle Canvas (JS)

```javascript
// Self-contained particle system — call initParticles('#canvas-id')
function initParticles(canvasId, options = {}) {
    const canvas = document.getElementById(canvasId);
    if (!canvas) return;
    const ctx = canvas.getContext('2d');

    const cfg = {
        count:       options.count       || 60,
        color:       options.color       || '124, 106, 255',
        maxRadius:   options.maxRadius   || 2.5,
        speed:       options.speed       || 0.4,
        connectDist: options.connectDist || 120,
        opacity:     options.opacity     || 0.6,
    };

    let particles = [];
    let raf;

    function resize() {
        canvas.width  = canvas.offsetWidth;
        canvas.height = canvas.offsetHeight;
    }

    function createParticle() {
        return {
            x:  Math.random() * canvas.width,
            y:  Math.random() * canvas.height,
            r:  Math.random() * cfg.maxRadius + 0.5,
            vx: (Math.random() - 0.5) * cfg.speed,
            vy: (Math.random() - 0.5) * cfg.speed,
        };
    }

    function draw() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        particles.forEach(p => {
            p.x += p.vx;
            p.y += p.vy;

            if (p.x < 0 || p.x > canvas.width)  p.vx *= -1;
            if (p.y < 0 || p.y > canvas.height) p.vy *= -1;

            ctx.beginPath();
            ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
            ctx.fillStyle = `rgba(${cfg.color}, ${cfg.opacity})`;
            ctx.fill();
        });

        // Connect nearby particles
        for (let i = 0; i < particles.length; i++) {
            for (let j = i + 1; j < particles.length; j++) {
                const dx = particles[i].x - particles[j].x;
                const dy = particles[i].y - particles[j].y;
                const dist = Math.sqrt(dx * dx + dy * dy);
                if (dist < cfg.connectDist) {
                    const alpha = (1 - dist / cfg.connectDist) * 0.4;
                    ctx.beginPath();
                    ctx.moveTo(particles[i].x, particles[i].y);
                    ctx.lineTo(particles[j].x, particles[j].y);
                    ctx.strokeStyle = `rgba(${cfg.color}, ${alpha})`;
                    ctx.lineWidth = 0.5;
                    ctx.stroke();
                }
            }
        }

        raf = requestAnimationFrame(draw);
    }

    resize();
    particles = Array.from({ length: cfg.count }, createParticle);
    draw();

    window.addEventListener('resize', () => {
        resize();
        particles = Array.from({ length: cfg.count }, createParticle);
    });

    // Respect reduced motion
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
        cancelAnimationFrame(raf);
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    }

    return { stop: () => cancelAnimationFrame(raf) };
}

/* HTML:
<section class="slide" style="position:relative;">
    <canvas id="particles" style="position:absolute;inset:0;width:100%;height:100%;z-index:0;" aria-hidden="true"></canvas>
    <div class="slide-content" style="position:relative;z-index:1;">...</div>
</section>

<script>
document.addEventListener('DOMContentLoaded', () => initParticles('particles'));
</script>
*/
```

### Grid Overlay Pattern

```css
/* Blueprint grid — layered over colored/dark background */
.bg-grid-overlay {
    background-color: var(--bg);
    background-image:
        linear-gradient(rgba(255,255,255,0.04) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255,255,255,0.04) 1px, transparent 1px);
    background-size: 40px 40px;
}

/* With axis lines for a more precise look */
.bg-grid-axis {
    background-color: var(--bg);
    background-image:
        /* Major gridlines */
        linear-gradient(rgba(255,255,255,0.07) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255,255,255,0.07) 1px, transparent 1px),
        /* Minor gridlines */
        linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
    background-size: 100px 100px, 100px 100px, 20px 20px, 20px 20px;
}

/* Perspective grid (converging) — dramatic effect */
.bg-grid-perspective {
    background-color: var(--bg);
    background-image:
        linear-gradient(rgba(255,255,255,0.05) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255,255,255,0.05) 1px, transparent 1px);
    background-size: 40px 40px;
    transform-origin: center top;
    /* Apply this on an inner ::after element for perspective effect */
}
.bg-grid-perspective::after {
    content: '';
    position: absolute;
    inset: -50% -100% 0;
    background: inherit;
    transform: perspective(400px) rotateX(55deg);
    transform-origin: center top;
    opacity: 0.6;
}
```

### Noise Texture SVG

```css
/* SVG fractal noise overlay — adds premium film-grain quality */
.noise-overlay {
    position: relative;
}
.noise-overlay::after {
    content: '';
    position: absolute;
    inset: 0;
    pointer-events: none;
    z-index: 10;
    opacity: 0.035;
    mix-blend-mode: overlay;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='300'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3CfeColorMatrix type='saturate' values='0'/%3E%3C/filter%3E%3Crect width='300' height='300' filter='url(%23noise)'/%3E%3C/svg%3E");
    background-size: 300px 300px;
}

/* Stronger grain for paper/editorial aesthetics */
.noise-heavy::after {
    opacity: 0.08;
    mix-blend-mode: multiply;
}
```

### Dot Grid Pattern

```css
/* Subtle dot field — versatile, works on light and dark */
.bg-dots {
    background-color: var(--bg);
    background-image: radial-gradient(
        circle,
        rgba(255,255,255,0.15) 1px,
        transparent 1px
    );
    background-size: 28px 28px;
}

/* Larger, more visible dots */
.bg-dots-bold {
    background-color: var(--bg);
    background-image: radial-gradient(
        circle,
        var(--dot-color, rgba(255,255,255,0.2)) 1.5px,
        transparent 1.5px
    );
    background-size: 36px 36px;
}

/* Dots with fade-out toward edges */
.bg-dots-vignette {
    background-color: var(--bg);
    background-image:
        radial-gradient(ellipse at center, transparent 40%, var(--bg) 80%),
        radial-gradient(circle, rgba(255,255,255,0.15) 1px, transparent 1px);
    background-size: 100% 100%, 28px 28px;
}
```

---

## Text Effects

### Neon Glow (text-shadow)

```css
/* Single-color neon — solid felt-tip glow */
.text-neon {
    color: var(--neon-color, #7c6aff);
    text-shadow:
        0 0  6px var(--neon-color, #7c6aff),
        0 0 20px var(--neon-color, #7c6aff),
        0 0 40px var(--neon-color, #7c6aff),
        0 0 80px color-mix(in oklch, var(--neon-color, #7c6aff), transparent 50%);
}

/* Pulsing neon — use on title elements only */
@keyframes neonPulse {
    0%, 100% {
        text-shadow:
            0 0  6px var(--neon-color),
            0 0 20px var(--neon-color),
            0 0 40px var(--neon-color);
    }
    50% {
        text-shadow:
            0 0  4px var(--neon-color),
            0 0 12px var(--neon-color),
            0 0 24px var(--neon-color);
    }
}
.text-neon-pulse {
    color: var(--neon-color, #7c6aff);
    animation: neonPulse 2.5s ease-in-out infinite;
}

/* White neon — sci-fi / terminal */
.text-neon-white {
    color: #ffffff;
    text-shadow:
        0 0  4px rgba(255,255,255,0.9),
        0 0 12px rgba(255,255,255,0.7),
        0 0 30px rgba(200,200,255,0.5),
        0 0 60px rgba(150,150,255,0.3);
}
```

### Gradient Clip Text

```css
/* Gradient applied only to text — requires transparent color */
.text-gradient {
    background: var(--text-gradient,
        linear-gradient(135deg, #7c6aff 0%, #ff6ab0 50%, #ffd166 100%)
    );
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    color: transparent; /* fallback */
}

/* Animated gradient text */
.text-gradient-animate {
    background: linear-gradient(
        270deg,
        var(--accent),
        var(--accent-2),
        var(--accent)
    );
    background-size: 200% auto;
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    color: transparent;
    animation: gradientFlow 4s linear infinite;
}
@keyframes gradientFlow {
    from { background-position: 0% center; }
    to   { background-position: 200% center; }
}

/* Metallic/gold gradient */
.text-gold {
    background: linear-gradient(135deg, #d4a853 0%, #f5e08a 40%, #b8891e 70%, #f5e08a 100%);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    color: transparent;
}
```

### Typewriter Animation

```css
/* Pure CSS typewriter — needs known text length */
/* Formula: steps = number of characters in text */
.typewriter {
    width: 0;
    overflow: hidden;
    white-space: nowrap;
    border-right: 2px solid var(--accent);
    font-family: var(--font-mono);
    animation:
        typeReveal 2s steps(30, end) forwards,
        cursorBlink 0.75s step-end infinite;
    animation-delay: var(--delay, 0s);
}
@keyframes typeReveal {
    from { width: 0; }
    to   { width: 100%; }
}
@keyframes cursorBlink {
    0%, 100% { border-color: var(--accent); }
    50%       { border-color: transparent;  }
}
/* Remove cursor after typing completes */
.typewriter.done {
    border-right: none;
    width: 100%;
}
```

### Text Scramble Reveal (JS)

```javascript
// Characters cycle randomly before resolving to actual text
// Usage: new TextScramble(element).setText('Hello World')
class TextScramble {
    constructor(el) {
        this.el = el;
        this.chars = '!<>-_\/[]{}—=+*^?#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        this.update = this.update.bind(this);
    }

    setText(newText) {
        const length   = newText.length;
        const oldText  = this.el.innerText;
        const promise  = new Promise(resolve => this.resolve = resolve);
        this.queue = [];
        for (let i = 0; i < Math.max(length, oldText.length); i++) {
            const from  = oldText[i]  || '';
            const to    = newText[i]  || '';
            const start = Math.floor(Math.random() * 10);
            const end   = start + Math.floor(Math.random() * 10) + 5;
            this.queue.push({ from, to, start, end });
        }
        cancelAnimationFrame(this.frameRequest);
        this.frame = 0;
        this.update();
        return promise;
    }

    update() {
        let output = '';
        let complete = 0;
        for (let i = 0, n = this.queue.length; i < n; i++) {
            const { from, to, start, end } = this.queue[i];
            let char = this.queue[i].char;
            if (this.frame >= end) {
                complete++;
                output += to;
            } else if (this.frame >= start) {
                if (!char || Math.random() < 0.28) {
                    char = this.chars[Math.floor(Math.random() * this.chars.length)];
                    this.queue[i].char = char;
                }
                output += `<span class="scramble-char" aria-hidden="true">${char}</span>`;
            } else {
                output += from;
            }
        }
        this.el.innerHTML = output;
        if (complete === this.queue.length) {
            this.resolve();
        } else {
            this.frameRequest = requestAnimationFrame(this.update);
            this.frame++;
        }
    }
}

/* Usage example:
const el = document.querySelector('.scramble-title');
const fx = new TextScramble(el);
// Trigger on slide enter:
fx.setText('Welcome to the Future');
*/
```

---

## Card Styles

### Glass Card (backdrop-filter)

```css
.card-glass {
    background: rgba(255, 255, 255, 0.06);
    backdrop-filter: blur(20px) saturate(1.6);
    -webkit-backdrop-filter: blur(20px) saturate(1.6);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: var(--radius-lg);
    padding: var(--card-padding);
    box-shadow:
        0 8px 32px rgba(0, 0, 0, 0.35),
        inset 0 1px 0 rgba(255, 255, 255, 0.08);
    transition: transform var(--transition-base), box-shadow var(--transition-base);
}
.card-glass:hover {
    transform: translateY(-3px);
    box-shadow:
        0 16px 48px rgba(0, 0, 0, 0.4),
        inset 0 1px 0 rgba(255, 255, 255, 0.12);
}
```

### Neo-Brutalist Card

```css
.card-neobrutalist {
    background: var(--nb-bg, #f5f0e8);
    color: var(--nb-text, #1a1a1a);
    border: 3px solid var(--nb-border, #1a1a1a);
    border-radius: var(--radius-sm);
    padding: var(--card-padding);
    box-shadow: 4px 4px 0 var(--nb-shadow, #1a1a1a);
    transition: transform var(--transition-fast), box-shadow var(--transition-fast);
}
.card-neobrutalist:hover {
    transform: translate(-2px, -2px);
    box-shadow: 6px 6px 0 var(--nb-shadow, #1a1a1a);
}
.card-neobrutalist:active {
    transform: translate(2px, 2px);
    box-shadow: 2px 2px 0 var(--nb-shadow, #1a1a1a);
}

/* Accent variant */
.card-neobrutalist.accent {
    background: var(--accent);
    color: white;
    border-color: #1a1a1a;
}
```

### Claymorphism Card

```css
.card-clay {
    background: var(--clay-bg, #6c63ff);
    border-radius: clamp(16px, 3vw, 32px);
    padding: var(--card-padding);
    color: white;
    box-shadow:
        /* Outer raised shadow */
        0 10px 30px rgba(108, 99, 255, 0.35),
        /* Inner light edge — creates 3D inflated look */
        inset 0 -4px 12px rgba(0, 0, 0, 0.15),
        inset 0  3px  8px rgba(255, 255, 255, 0.25);
    transition: transform var(--transition-spring), box-shadow var(--transition-spring);
}
.card-clay:hover {
    transform: scale(1.03) translateY(-4px);
    box-shadow:
        0 20px 50px rgba(108, 99, 255, 0.4),
        inset 0 -4px 12px rgba(0, 0, 0, 0.15),
        inset 0  3px  8px rgba(255, 255, 255, 0.25);
}
```

### Holographic Border (animated gradient)

```css
/* Animated rainbow border — standout card highlight */
@property --holo-angle {
    syntax: '<angle>';
    inherits: false;
    initial-value: 0deg;
}
@keyframes holoRotate {
    to { --holo-angle: 360deg; }
}

.card-holographic {
    position: relative;
    background: var(--surface);
    border-radius: var(--radius-lg);
    padding: var(--card-padding);
    /* Fallback for browsers without @property */
    border: 1px solid var(--accent);
}
.card-holographic::before {
    content: '';
    position: absolute;
    inset: -2px;
    border-radius: inherit;
    background: conic-gradient(
        from var(--holo-angle),
        #ff6ab0, #7c6aff, #3ddc84, #ffd166, #ff6ab0
    );
    animation: holoRotate 3s linear infinite;
    z-index: -1;
}
.card-holographic::after {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: calc(var(--radius-lg) - 2px);
    background: var(--surface);
    z-index: -1;
}
```

### Neumorphic Card

```css
/* Neumorphism — works ONLY on mid-tone backgrounds, not dark/white */
:root {
    --neu-bg:      #e8e4f0;
    --neu-shadow-dark:  rgba(180, 170, 200, 0.7);
    --neu-shadow-light: rgba(255, 255, 255, 0.9);
}

.card-neumorphic {
    background: var(--neu-bg);
    border-radius: var(--radius-xl);
    padding: var(--card-padding);
    box-shadow:
         8px  8px 20px var(--neu-shadow-dark),
        -8px -8px 20px var(--neu-shadow-light);
    color: #4a4060;
}

/* Pressed/inset state */
.card-neumorphic.pressed {
    box-shadow:
        inset  6px  6px 14px var(--neu-shadow-dark),
        inset -6px -6px 14px var(--neu-shadow-light);
}

/* Icon container within neumorphic card */
.neu-icon {
    width: 56px; height: 56px;
    border-radius: 50%;
    background: var(--neu-bg);
    display: flex; align-items: center; justify-content: center;
    box-shadow:
         4px  4px 10px var(--neu-shadow-dark),
        -4px -4px 10px var(--neu-shadow-light);
}
```

---

## Motion

### Staggered Reveal with nth-child Delays

```css
/* Apply .stagger-parent to the container */
/* Each child gets progressively later animation delay */
.stagger-parent > * {
    opacity: 0;
    animation: fadeUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

/* Generate delays for up to 8 children */
.stagger-parent > *:nth-child(1) { animation-delay: 0.05s; }
.stagger-parent > *:nth-child(2) { animation-delay: 0.15s; }
.stagger-parent > *:nth-child(3) { animation-delay: 0.25s; }
.stagger-parent > *:nth-child(4) { animation-delay: 0.35s; }
.stagger-parent > *:nth-child(5) { animation-delay: 0.45s; }
.stagger-parent > *:nth-child(6) { animation-delay: 0.55s; }
.stagger-parent > *:nth-child(7) { animation-delay: 0.65s; }
.stagger-parent > *:nth-child(8) { animation-delay: 0.75s; }
```

### Parallax Scroll Effect

```javascript
// Layered parallax on background elements within each slide
// Different speeds create depth illusion as slide enters/exits viewport
function initParallax(options = {}) {
    const cfg = {
        selector: options.selector || '[data-parallax]',
        maxOffset: options.maxOffset || 40,
    };

    const elements = document.querySelectorAll(cfg.selector);
    if (!elements.length) return;

    // Don't run if reduced motion is preferred
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

    const obs = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            const slide = entry.target.closest('.slide');
            if (!entry.isIntersecting || !slide) return;

            const parallaxEls = slide.querySelectorAll(cfg.selector);
            const onScroll = () => {
                const rect = slide.getBoundingClientRect();
                const progress = -rect.top / window.innerHeight; // -1 to 1

                parallaxEls.forEach(el => {
                    const speed  = parseFloat(el.dataset.parallax || '0.3');
                    const offset = progress * cfg.maxOffset * speed;
                    el.style.transform = `translateY(${offset}px)`;
                });
            };

            window.addEventListener('scroll', onScroll, { passive: true });
            // Clean up when slide leaves
            const cleanup = new IntersectionObserver(([e]) => {
                if (!e.isIntersecting) window.removeEventListener('scroll', onScroll);
            }, { threshold: 0 });
            cleanup.observe(slide);
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.slide').forEach(s => obs.observe(s));
}

/* HTML usage:
<div data-parallax="0.2" style="position:absolute;top:0;left:0;...">Background layer</div>
<div data-parallax="0.5" style="position:absolute;...">Mid layer</div>
<div data-parallax="1.0" class="slide-content">Foreground (max speed)</div>
*/
```

### 3D Tilt on Hover (JS)

```javascript
// Smooth perspective tilt effect on cards and interactive elements
function enableTilt(selector = '.card', options = {}) {
    const cfg = {
        maxTilt:     options.maxTilt     || 12,    // degrees
        perspective: options.perspective || 800,   // px
        scale:       options.scale       || 1.02,  // zoom on hover
        speed:       options.speed       || 400,   // ms for reset
    };

    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

    document.querySelectorAll(selector).forEach(el => {
        el.style.transformStyle = 'preserve-3d';
        el.style.willChange = 'transform';

        const transitionIn  = `transform 0.08s ease`;
        const transitionOut = `transform ${cfg.speed}ms cubic-bezier(0.16,1,0.3,1)`;

        el.addEventListener('mouseenter', () => {
            el.style.transition = transitionIn;
        });

        el.addEventListener('mousemove', e => {
            const rect = el.getBoundingClientRect();
            const cx = rect.left + rect.width  / 2;
            const cy = rect.top  + rect.height / 2;
            const dx = (e.clientX - cx) / (rect.width  / 2);
            const dy = (e.clientY - cy) / (rect.height / 2);

            el.style.transform = `
                perspective(${cfg.perspective}px)
                rotateX(${-dy * cfg.maxTilt}deg)
                rotateY(${dx  * cfg.maxTilt}deg)
                scale3d(${cfg.scale}, ${cfg.scale}, ${cfg.scale})
            `;
        });

        el.addEventListener('mouseleave', () => {
            el.style.transition = transitionOut;
            el.style.transform  = `perspective(${cfg.perspective}px) rotateX(0) rotateY(0) scale3d(1,1,1)`;
        });
    });
}
```

### Magnetic Button Hover (JS)

```javascript
// Buttons that follow the cursor within a radius — premium interaction
function enableMagnetic(selector = '.cta-button', options = {}) {
    const cfg = {
        strength: options.strength || 0.35, // 0-1, how much the button moves
        radius:   options.radius   || 60,   // px — activation distance from center
    };

    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

    document.querySelectorAll(selector).forEach(el => {
        el.style.transition = 'transform 0.3s cubic-bezier(0.16,1,0.3,1)';
        el.style.display    = 'inline-block';

        const onMove = (e) => {
            const rect = el.getBoundingClientRect();
            const cx = rect.left + rect.width  / 2;
            const cy = rect.top  + rect.height / 2;
            const dx = e.clientX - cx;
            const dy = e.clientY - cy;
            const dist = Math.sqrt(dx * dx + dy * dy);

            if (dist < cfg.radius + rect.width / 2) {
                el.style.transform = `translate(${dx * cfg.strength}px, ${dy * cfg.strength}px)`;
            } else {
                el.style.transform = 'translate(0, 0)';
            }
        };

        document.addEventListener('mousemove', onMove, { passive: true });

        el.addEventListener('mouseleave', () => {
            el.style.transform = 'translate(0, 0)';
        });
    });
}
```

### Pulsing Ring Animation

```css
/* Expanding ring pulse — good for icons, feature highlights, CTAs */
.pulse-ring {
    position: relative;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.pulse-ring::before,
.pulse-ring::after {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: 50%;
    border: 2px solid var(--accent);
    animation: ringPulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}
.pulse-ring::after {
    animation-delay: 0.75s;
}

@keyframes ringPulse {
    0%   { transform: scale(1);    opacity: 0.8; }
    100% { transform: scale(2.2);  opacity: 0;   }
}

/* Dot with pulsing ring — for status indicators */
.status-dot {
    width: 10px; height: 10px;
    border-radius: 50%;
    background: var(--success, #3ddc84);
    position: relative;
}
.status-dot.pulse::before {
    content: '';
    position: absolute;
    inset: -4px;
    border-radius: 50%;
    background: var(--success, #3ddc84);
    animation: statusPulse 1.5s ease-out infinite;
}
@keyframes statusPulse {
    0%   { transform: scale(1); opacity: 0.5; }
    100% { transform: scale(2.5); opacity: 0; }
}
```
