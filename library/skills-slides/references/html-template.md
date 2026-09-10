# HTML Architecture Reference

Complete reference for generating zero-dependency slide presentations.

---

## Full HTML Skeleton

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="[PRESENTATION DESCRIPTION]">
    <!-- Open Graph for sharing -->
    <meta property="og:title"       content="[TITLE]">
    <meta property="og:description" content="[DESCRIPTION]">
    <meta property="og:type"        content="website">
    <title>[PRESENTATION TITLE]</title>

    <!-- Google Fonts — chosen from font token (2 families max) -->
    <!-- Example: <link rel="preconnect" href="https://fonts.googleapis.com"> -->
    <!-- <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&family=Space+Mono&display=swap" rel="stylesheet"> -->

    <style>
        /* ── 1. Viewport base (copy full content of viewport-base.css) ── */

        /* ── 2. Design tokens from chosen palette + aesthetic ── */
        :root {
            /* Colors */
            --bg:        #0a0a0f;
            --surface:   #12121a;
            --surface-2: #1a1a26;
            --border:    rgba(255,255,255,0.08);
            --text:      #f0f0f5;
            --text-muted:#8888aa;
            --accent:    #7c6aff;
            --accent-2:  #ff6ab0;
            --success:   #3ddc84;
            --warning:   #ffb347;

            /* Typography from font token */
            --font-display: 'Space Grotesk', sans-serif;
            --font-body:    'Space Grotesk', sans-serif;
            --font-mono:    'Space Mono', monospace;

            /* Effects */
            --glow: 0 0 40px rgba(124, 106, 255, 0.35);
            --shadow-card: 0 8px 32px rgba(0,0,0,0.4);
        }

        /* ── 3. Global resets ── */
        body {
            background: var(--bg);
            color: var(--text);
            font-family: var(--font-body);
            overflow: hidden; /* outer; individual slides handle their own */
        }

        /* ── 4. Slide-specific styles ── */
        /* ... generated per aesthetic ... */

        /* ── 5. Entrance animations (see animation-patterns.md) ── */

        /* ── 6. Navigation chrome ── */
        /* nav-dots, progress-bar, keyboard-hint */
    </style>
</head>
<body>

    <!-- Progress bar -->
    <div class="progress-bar" id="progressBar" role="progressbar"
         aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
         aria-label="Presentation progress"></div>

    <!-- Navigation dots -->
    <nav class="nav-dots" id="navDots" aria-label="Slide navigation">
        <!-- JS populates: <button class="nav-dot" data-index="0" aria-label="Slide 1"></button> -->
    </nav>

    <!-- Keyboard hint -->
    <p class="keyboard-hint" aria-hidden="true">↑↓ or Space to navigate · ESC for overview</p>

    <!-- ═══════════════ SLIDES ═══════════════ -->

    <!-- SLIDE 1: Title -->
    <section class="slide slide-title" id="slide-1"
             role="region" aria-label="Slide 1: Title"
             data-slide-index="0">
        <div class="slide-content">
            <div class="enter-fade-up">
                <p class="label" aria-label="Event or context label">[LABEL / TAGLINE]</p>
                <h1 class="title">[MAIN TITLE]</h1>
                <p class="subtitle">[SUBTITLE]</p>
            </div>
            <footer class="slide-footer" aria-label="Presenter info">
                <span class="presenter">[PRESENTER NAME]</span>
                <span class="divider" aria-hidden="true">·</span>
                <span class="date">[DATE]</span>
            </footer>
        </div>
        <!-- Decorative background layer (aesthetic-specific) -->
        <div class="slide-bg" aria-hidden="true"></div>
    </section>

    <!-- SLIDE 2: Content / Bullet -->
    <section class="slide" id="slide-2"
             role="region" aria-label="Slide 2: [HEADING]"
             data-slide-index="1">
        <div class="slide-content">
            <h2 class="heading enter-fade-up">[SLIDE HEADING]</h2>
            <ul class="bullet-list" role="list">
                <li class="enter-fade-up" style="--delay:0.1s"><span class="bullet-icon" aria-hidden="true">→</span>[POINT 1]</li>
                <li class="enter-fade-up" style="--delay:0.2s"><span class="bullet-icon" aria-hidden="true">→</span>[POINT 2]</li>
                <li class="enter-fade-up" style="--delay:0.3s"><span class="bullet-icon" aria-hidden="true">→</span>[POINT 3]</li>
                <li class="enter-fade-up" style="--delay:0.4s"><span class="bullet-icon" aria-hidden="true">→</span>[POINT 4]</li>
            </ul>
        </div>
    </section>

    <!-- SLIDE 3: Feature Grid -->
    <section class="slide" id="slide-3"
             role="region" aria-label="Slide 3: [HEADING]"
             data-slide-index="2">
        <div class="slide-content">
            <h2 class="heading enter-fade-up">[FEATURE HEADING]</h2>
            <div class="grid grid-3" role="list">
                <article class="card enter-scale-in" style="--delay:0.1s" role="listitem">
                    <span class="card-icon" aria-hidden="true">[ICON or EMOJI]</span>
                    <h3 class="card-title">[FEATURE NAME]</h3>
                    <p class="card-body">[DESCRIPTION]</p>
                </article>
                <!-- repeat up to 6 cards -->
            </div>
        </div>
    </section>

    <!-- SLIDE 4: Quote -->
    <section class="slide slide-quote" id="slide-4"
             role="region" aria-label="Slide 4: Quote"
             data-slide-index="3">
        <div class="slide-content" style="align-items:center; text-align:center;">
            <figure class="quote-block enter-fade-up">
                <blockquote>
                    <p class="quote-text">[QUOTE TEXT — max 3 lines]</p>
                </blockquote>
                <figcaption class="quote-attribution">
                    <span class="attribution-name">[PERSON NAME]</span>
                    <span class="attribution-title">[TITLE / COMPANY]</span>
                </figcaption>
            </figure>
        </div>
    </section>

    <!-- SLIDE 5: Code -->
    <section class="slide slide-code" id="slide-5"
             role="region" aria-label="Slide 5: Code example"
             data-slide-index="4">
        <div class="slide-content">
            <h2 class="heading enter-fade-up">[CODE HEADING]</h2>
            <div class="code-window enter-scale-in" style="--delay:0.15s">
                <div class="code-titlebar" aria-hidden="true">
                    <span class="dot dot-red"></span>
                    <span class="dot dot-yellow"></span>
                    <span class="dot dot-green"></span>
                    <span class="code-filename">[filename.ext]</span>
                </div>
                <pre><code class="code-block" role="img" aria-label="Code example">[CODE — 8-10 lines max]</code></pre>
            </div>
        </div>
    </section>

    <!-- SLIDE N: Closing / CTA -->
    <section class="slide slide-closing" id="slide-closing"
             role="region" aria-label="Final slide"
             data-slide-index="[N]">
        <div class="slide-content" style="align-items:center; text-align:center;">
            <div class="enter-fade-up">
                <h2 class="heading">[CLOSING HEADLINE]</h2>
                <p class="body">[CALL TO ACTION or NEXT STEPS]</p>
                <div class="cta-links" role="list">
                    <a href="[URL]" class="cta-button" role="listitem">[PRIMARY ACTION]</a>
                </div>
            </div>
        </div>
    </section>

    <!-- ════════════ JS ════════════ -->
    <script>
    /* SlidePresentation — injected inline below */
    </script>
</body>
</html>
```

---

## SlidePresentation JS Class

Complete class. Copy-paste into `<script>` at end of `<body>`.

```javascript
class SlidePresentation {
    constructor(options = {}) {
        this.slides = Array.from(document.querySelectorAll('.slide'));
        this.current = 0;
        this.isAnimating = false;
        this.touchStartY = 0;
        this.touchStartX = 0;

        // Options
        this.dotColor    = options.dotColor    || 'var(--accent)';
        this.accentColor = options.accentColor || 'var(--accent)';

        this.init();
    }

    init() {
        if (!this.slides.length) return;
        this.buildNavDots();
        this.buildProgressBar();
        this.bindKeyboard();
        this.bindTouch();
        this.bindWheel();
        this.bindHash();
        this.observeSlides();
        this.goTo(this.getInitialSlide(), false);
    }

    // ── Navigation Dots ──────────────────────────────────────────────────────
    buildNavDots() {
        const nav = document.getElementById('navDots');
        if (!nav) return;
        this.slides.forEach((_, i) => {
            const btn = document.createElement('button');
            btn.className = 'nav-dot';
            btn.dataset.index = i;
            btn.setAttribute('aria-label', `Go to slide ${i + 1}`);
            btn.addEventListener('click', () => this.goTo(i));
            nav.appendChild(btn);
        });
        this.dots = Array.from(nav.querySelectorAll('.nav-dot'));
    }

    // ── Progress Bar ─────────────────────────────────────────────────────────
    buildProgressBar() {
        this.progressBar = document.getElementById('progressBar');
    }

    updateProgress() {
        if (!this.progressBar) return;
        const pct = this.slides.length > 1
            ? (this.current / (this.slides.length - 1)) * 100
            : 100;
        this.progressBar.style.width = `${pct}%`;
        this.progressBar.setAttribute('aria-valuenow', Math.round(pct));

        if (this.dots) {
            this.dots.forEach((d, i) => d.classList.toggle('active', i === this.current));
        }
    }

    // ── Navigation ───────────────────────────────────────────────────────────
    goTo(index, animate = true) {
        const target = Math.max(0, Math.min(index, this.slides.length - 1));
        if (target === this.current && animate) return;

        this.current = target;
        const slide = this.slides[target];
        slide.scrollIntoView({ behavior: animate ? 'smooth' : 'instant' });
        this.updateProgress();
        this.triggerEntranceAnimations(slide);

        // Update URL hash without triggering scroll
        history.replaceState(null, '', `#slide-${target + 1}`);

        // Announce to screen readers
        const region = slide.getAttribute('aria-label') || `Slide ${target + 1}`;
        this.announce(region);
    }

    next() { this.goTo(this.current + 1); }
    prev() { this.goTo(this.current - 1); }

    getInitialSlide() {
        const hash = window.location.hash;
        const match = hash.match(/#slide-(\d+)/);
        return match ? parseInt(match[1], 10) - 1 : 0;
    }

    // ── Keyboard ─────────────────────────────────────────────────────────────
    bindKeyboard() {
        document.addEventListener('keydown', (e) => {
            // Don't intercept if user is editing
            if (e.target.matches('[contenteditable]') || e.target.matches('input, textarea')) return;

            switch (e.key) {
                case 'ArrowDown': case 'ArrowRight': case ' ': case 'PageDown':
                    e.preventDefault(); this.next(); break;
                case 'ArrowUp': case 'ArrowLeft': case 'PageUp':
                    e.preventDefault(); this.prev(); break;
                case 'Home':
                    e.preventDefault(); this.goTo(0); break;
                case 'End':
                    e.preventDefault(); this.goTo(this.slides.length - 1); break;
                case 'Escape':
                    this.toggleOverview(); break;
                case 'f': case 'F':
                    if (!e.ctrlKey && !e.metaKey) this.toggleFullscreen(); break;
            }
        });
    }

    // ── Touch / Swipe ─────────────────────────────────────────────────────────
    bindTouch() {
        document.addEventListener('touchstart', (e) => {
            this.touchStartY = e.touches[0].clientY;
            this.touchStartX = e.touches[0].clientX;
        }, { passive: true });

        document.addEventListener('touchend', (e) => {
            const dy = this.touchStartY - e.changedTouches[0].clientY;
            const dx = this.touchStartX - e.changedTouches[0].clientX;

            // Only trigger on predominantly vertical swipe
            if (Math.abs(dy) > Math.abs(dx) && Math.abs(dy) > 40) {
                dy > 0 ? this.next() : this.prev();
            }
        }, { passive: true });
    }

    // ── Wheel ─────────────────────────────────────────────────────────────────
    bindWheel() {
        let wheelTimeout;
        document.addEventListener('wheel', (e) => {
            e.preventDefault();
            clearTimeout(wheelTimeout);
            wheelTimeout = setTimeout(() => {
                e.deltaY > 0 ? this.next() : this.prev();
            }, 50);
        }, { passive: false });
    }

    // ── Intersection Observer ──────────────────────────────────────────────────
    observeSlides() {
        const opts = { threshold: 0.6 };
        const obs = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const idx = this.slides.indexOf(entry.target);
                    if (idx !== -1 && idx !== this.current) {
                        this.current = idx;
                        this.updateProgress();
                        this.triggerEntranceAnimations(entry.target);
                    }
                }
            });
        }, opts);
        this.slides.forEach(s => obs.observe(s));
    }

    // ── Entrance Animations ───────────────────────────────────────────────────
    triggerEntranceAnimations(slide) {
        // Reset elements that should re-animate on revisit
        const animated = slide.querySelectorAll('[class*="enter-"]');
        animated.forEach(el => {
            el.style.animation = 'none';
            el.offsetHeight; // reflow
            el.style.animation = '';
        });
    }

    // ── Hash navigation ───────────────────────────────────────────────────────
    bindHash() {
        window.addEventListener('hashchange', () => {
            const idx = this.getInitialSlide();
            this.goTo(idx);
        });
    }

    // ── Overview mode (ESC) ──────────────────────────────────────────────────
    toggleOverview() {
        document.body.classList.toggle('overview-mode');
        if (document.body.classList.contains('overview-mode')) {
            document.querySelectorAll('.slide').forEach(s => {
                s.style.scrollSnapAlign = 'none';
                s.style.height = '20vh';
                s.style.cursor = 'pointer';
                s.onclick = () => {
                    const idx = parseInt(s.dataset.slideIndex || 0);
                    this.exitOverview();
                    setTimeout(() => this.goTo(idx), 50);
                };
            });
            document.documentElement.style.scrollSnapType = 'none';
        } else {
            this.exitOverview();
        }
    }

    exitOverview() {
        document.body.classList.remove('overview-mode');
        document.querySelectorAll('.slide').forEach(s => {
            s.style.scrollSnapAlign = '';
            s.style.height = '';
            s.style.cursor = '';
            s.onclick = null;
        });
        document.documentElement.style.scrollSnapType = '';
    }

    // ── Fullscreen ────────────────────────────────────────────────────────────
    toggleFullscreen() {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen?.();
        } else {
            document.exitFullscreen?.();
        }
    }

    // ── Screen reader live region ─────────────────────────────────────────────
    announce(message) {
        let region = document.getElementById('sr-live');
        if (!region) {
            region = document.createElement('div');
            region.id = 'sr-live';
            region.setAttribute('aria-live', 'polite');
            region.setAttribute('aria-atomic', 'true');
            region.style.cssText = 'position:absolute;left:-9999px;width:1px;height:1px;overflow:hidden;';
            document.body.appendChild(region);
        }
        region.textContent = '';
        requestAnimationFrame(() => { region.textContent = message; });
    }
}

// Auto-init
document.addEventListener('DOMContentLoaded', () => {
    window.presentation = new SlidePresentation();
});
```

---

## Inline Editing System (Opt-In)

Add `data-editable` to the `<body>` tag to enable live content editing.

```javascript
// Add after SlidePresentation init
if (document.body.dataset.editable !== undefined) {
    enableInlineEditing();
}

function enableInlineEditing() {
    // Make text nodes editable on double-click
    const editables = document.querySelectorAll('h1, h2, h3, p:not(.keyboard-hint), li, blockquote p');
    editables.forEach(el => {
        el.title = 'Double-click to edit';
        el.addEventListener('dblclick', function() {
            this.contentEditable = 'true';
            this.focus();
            // Select all text
            const range = document.createRange();
            range.selectNodeContents(this);
            window.getSelection().removeAllRanges();
            window.getSelection().addRange(range);
        });
        el.addEventListener('blur', function() {
            this.contentEditable = 'false';
        });
        el.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                this.contentEditable = 'false';
                this.blur();
            }
            // Prevent slide navigation when editing
            e.stopPropagation();
        });
    });

    // Show edit indicator
    const indicator = document.createElement('div');
    indicator.style.cssText = 'position:fixed;top:8px;left:8px;font-size:11px;opacity:0.5;z-index:999;';
    indicator.textContent = '✏ Edit mode';
    document.body.appendChild(indicator);
}
```

---

## Image Pipeline Notes

### Local images (recommended for offline presentations)
- Embed as base64 inline in `<img src="data:image/...">` for truly self-contained HTML
- Or place images adjacent to the HTML file and use relative paths

### External CDN images
- Always include `loading="lazy"` and `width`/`height` attributes to prevent layout shift
- Add `onerror="this.style.display='none'"` for graceful fallback

### Generated placeholder images (when no real image available)
```html
<!-- SVG placeholder — inline, zero requests -->
<svg class="image-placeholder" viewBox="0 0 800 450" xmlns="http://www.w3.org/2000/svg"
     role="img" aria-label="[Description]">
    <rect width="800" height="450" fill="var(--surface-2)"/>
    <text x="400" y="225" text-anchor="middle" dominant-baseline="middle"
          fill="var(--text-muted)" font-size="18" font-family="var(--font-body)">
        [Image description]
    </text>
</svg>
```

### Background images
```css
/* Positioned absolutely, never causes overflow */
.slide-bg-image {
    position: absolute;
    inset: 0;
    background-image: url('[PATH]');
    background-size: cover;
    background-position: center;
    z-index: 0;
    opacity: 0.3; /* dim for text readability */
}
.slide-content { position: relative; z-index: 1; }
```

---

## Code Quality Standards

### Comments
- Comment **why**, not what
- Mark each major section with a divider: `/* ── Section Name ── */`
- Note any intentional hacks: `/* Intentional: reflow trigger for animation reset */`
- Do not comment every property — only non-obvious choices

### Accessibility (ARIA)
- Every `<section class="slide">` must have `role="region"` and `aria-label="Slide N: [topic]"`
- All decorative elements: `aria-hidden="true"`
- Navigation controls: `aria-label` on every `<button>`
- Progress bar: `role="progressbar"` with `aria-valuenow/min/max`
- Images: meaningful `alt` text or `aria-label` if SVG
- Interactive cards: `role="button"` and `tabindex="0"` if clickable
- Color must not be the **only** means of conveying information

### Performance
- No external JS libraries — everything inline
- Fonts loaded via `<link rel="preconnect">` + `display=swap`
- Animations use `transform` and `opacity` only (no layout triggers)
- Heavy backgrounds (canvas, SVG filters) should `will-change: transform` sparingly

### HTML Validity
- Use semantic elements: `<section>`, `<article>`, `<figure>`, `<blockquote>`, `<nav>`
- Validate: no unclosed tags, no duplicate IDs
- `lang` attribute on `<html>` matches presentation language
