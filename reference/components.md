# Components (extracted from templates/example-aparat-deck.html — the canonical source)

Copy from the template rather than retyping. Layout classes: `.reveal` (staggered by nth-child 1–8), `.stagger > *` (children cascade, delays for 1–8), `.dark`/`.red` slide variants, `.acc` accent span, `.kicker`, `.hero`, `ol.num` (+ `.compact`), `.two`/`.grid-3`/`.grid-4`, `.trait`, `.col.marked`, `.ledger`, `.timeline`, `.authors`, `.card` (+ `.red`/`.ink`).

Slide switching: crossfade only (`.slide { transition: opacity .9s ease-in-out, visibility .9s }`). `showSlide()` toggles `.active/.visible`, sets `#progress` width, calls `onChange` for the nav.


## Stage skeleton (HTML)

```html
<div class="deck-viewport">
<main class="deck-stage" id="deckStage">
<div class="progress" id="progress"></div>
<nav class="side-nav" id="sideNav"></nav>
<section class="slide active" data-title="Титул"> ...chrome-head / slide-content / chrome-foot... </section>
</main></div>
<!-- bottom of body: const editor = new InlineEditor(); const deck = new SlidePresentation(); buildSideNav(deck); -->
```


## Slide chrome (HTML)

```html
<div class="chrome-head"><span>Форма № 02 · Реєстр питань</span><span class="red">Опис справи</span></div>
<div class="slide-content"> ... </div>
<div class="chrome-foot"><span>Deck title</span><span>02 / 14</span></div>
```


## Stamp (HTML)

```html
<div class="stamp reveal" data-ring="Зареєстровано · Вхідний № 0001 · Розглянуто · " data-center="Погоджено" data-sub="10.09.2026" style="right: 640px; top: 130px; width: 290px; height: 290px; rotate: -12deg;"></div>
<!-- variants: class "ink" (black), "paper" (for dark/red slides), "mini" (small monogram on a photo) -->
```


## Band (HTML)

```html
<div class="band reveal" style="top: 705px; rotate: -4deg;"><span>TEXT · TEXT · TEXT · TEXT · </span></div>
<!-- put the text TWICE inside the span; class "red"/"paper" for colour -->
```


## Disc (HTML)

```html
<div class="disc reveal" style="width: 760px; height: 760px; right: -140px; top: -120px;"></div>  <!-- class "ink"/"paper" -->
```


## Image with placeholder (HTML)

```html
<figure class="kafka small"><img src="assets/kafka.jpg" alt="" onerror="this.parentNode.classList.add('missing')"></figure>
```


## Decorative devices: band marquee, disc, giant numeral, hard-shadow card (CSS)

```css
DECORATIVE DEVICES — the deck's poster vocabulary
   =========================================== */
/* Diagonal black band with mono text */
.band {
    position: absolute;
    left: -200px;
    width: 2400px;
    padding: 18px 0;
    background: var(--ink);
    color: var(--paper);
    font-family: var(--font-mono);
    font-size: 20px;
    letter-spacing: 0.32em;
    text-transform: uppercase;
    white-space: nowrap;
    overflow: hidden;
    z-index: 1;
}
.band.red { background: var(--vermilion); color: var(--paper); }
.band.paper { background: var(--paper); color: var(--ink); }
.band span { display: inline-block; animation: marquee 40s linear infinite; }
@keyframes marquee { from { transform: translateX(0); } to { transform: translateX(-50%); } }

/* Big vermilion circle */
.disc {
    position: absolute;
    border-radius: 50%;
    background: var(--vermilion);
    z-index: 0;
}
.disc.ink { background: var(--ink); }
.disc.paper { background: var(--paper); }

/* Giant numeral */
.giant {
    font-family: var(--font-display);
    font-weight: 900;
    font-size: var(--size-num);
    line-height: 0.85;
    letter-spacing: -0.06em;
}

/* Hard-shadow card */
.card {
    border: 3px solid var(--ink);
    background: var(--white);
    padding: 36px 36px 32px;
    box-shadow: 14px 14px 0 var(--ink);
    color: var(--ink);
}
.card.red { background: var(--vermilion); color: var(--paper); box-shadow: 14px 14px 0 var(--ink); border-color: var(--ink); }
.card.ink { background: var(--ink); color: var(--paper); box-shadow: 14px 14px 0 var(--vermilion); border-color: var(--ink); }

/* Hatched fill */
.hatch { background: repeating-linear-gradient(45deg, var(--ink) 0 8px, transparent 8px 20px); }
```


## Reveal animations (CSS)

```css
ANIMATIONS — bold poster reveals
   =========================================== */
.reveal { opacity: 0; transform: translateY(40px); transition: opacity var(--dur) var(--ease), transform var(--dur) var(--ease); }
.slide.visible .reveal { opacity: 1; transform: none; }
.slide.visible .reveal:nth-child(1) { transition-delay: .05s; }
.slide.visible .reveal:nth-child(2) { transition-delay: .18s; }
.slide.visible .reveal:nth-child(3) { transition-delay: .31s; }
.slide.visible .reveal:nth-child(4) { transition-delay: .44s; }
.slide.visible .reveal:nth-child(5) { transition-delay: .57s; }
.slide.visible .reveal:nth-child(6) { transition-delay: .70s; }

/* Discs pop in with a spring */
.disc.reveal { transform: scale(0.2); transition: transform 1s cubic-bezier(0.34, 1.4, 0.64, 1), opacity .4s; }
.slide.visible .disc.reveal { transform: scale(1); }

/* Bands slide in from the left */
.band.reveal { transform: translateX(-120px); transition: transform .9s var(--ease) .3s, opacity .4s .3s; }
.slide.visible .band.reveal { transform: none; }

/* Giant numerals rise heavy */
.giant.reveal { transform: translateY(120px); transition: transform 1s var(--ease), opacity .6s; }
.slide.visible .giant.reveal { transform: none; }

/* Stagger inside grids */
.stagger > * { opacity: 0; transform: translateY(30px); transition: opacity .6s var(--ease), transform .6s var(--ease); }
.slide.visible .stagger > * { opacity: 1; transform: none; }
.slide.visible .stagger > *:nth-child(1) { transition-delay: .35s; }
.slide.visible .stagger > *:nth-child(2) { transition-delay: .45s; }
.slide.visible .stagger > *:nth-child(3) { transition-delay: .55s; }
.slide.visible .stagger > *:nth-child(4) { transition-delay: .65s; }
.slide.visible .stagger > *:nth-child(5) { transition-delay: .75s; }
.slide.visible .stagger > *:nth-child(6) { transition-delay: .85s; }
.slide.visible .stagger > *:nth-child(7) { transition-delay: .95s; }
.slide.visible .stagger > *:nth-child(8) { transition-delay: 1.05s; }
```


## Stamp (CSS)

```css
STAMP — circular ink stamp, slams in and slowly turns
   Built from data-ring / data-center / data-sub by JS.
   =========================================== */
.stamp { position: absolute; z-index: 3; color: var(--vermilion); mix-blend-mode: multiply; pointer-events: none; }
.stamp.ink { color: var(--ink); }
.stamp.paper { color: var(--paper); mix-blend-mode: normal; }
.dark .stamp { mix-blend-mode: normal; }
.stamp svg { width: 100%; height: 100%; overflow: visible; display: block; }
.stamp circle { fill: none; stroke: currentColor; }
.stamp .ring text { font-family: var(--font-mono); font-size: 21px; letter-spacing: 0.24em; text-transform: uppercase; fill: currentColor; font-weight: 500; }
.stamp .center { font-family: var(--font-display); font-weight: 900; font-size: 40px; letter-spacing: -0.02em; fill: currentColor; text-anchor: middle; }
.stamp .sub { font-family: var(--font-mono); font-size: 18px; letter-spacing: 0.18em; text-transform: uppercase; fill: currentColor; text-anchor: middle; }
.stamp .ring { transform-origin: 150px 150px; animation: ring-turn 36s linear infinite; }
@keyframes ring-turn { to { transform: rotate(360deg); } }
/* slam: from big and faint to pressed */
.stamp.reveal { opacity: 0; transform: scale(2.4); filter: blur(6px); transition: opacity .35s ease, transform .55s cubic-bezier(.2,1.6,.4,1), filter .5s ease; }
.slide.visible .stamp.reveal { opacity: .92; transform: scale(1); filter: blur(0); transition-delay: .9s; }
.stamp::after { content: ""; position: absolute; inset: 0; border-radius: 50%; background: repeating-radial-gradient(circle at 40% 30%, transparent 0 3px, rgba(255,255,255,.35) 3px 4px); mix-blend-mode: screen; opacity: .35; }
```


## Ambient motion, draw-in rules, tilt, progress (CSS)

```css
AMBIENT MOTION — discs drift, rules draw, bands pulse
   =========================================== */
@keyframes drift { from { translate: 0 0; } to { translate: 0 -34px; } }
.slide.visible .disc { animation: drift 7s ease-in-out 1.2s infinite alternate; }
.chrome-head, .chrome-foot { border-color: transparent !important; }
.chrome-head::after, .chrome-foot::after { content: ""; position: absolute; left: 0; right: 0; height: 2px; background: currentColor; transform: scaleX(0); transform-origin: left; transition: transform 1.1s var(--ease) .2s; }
.chrome-head::after { bottom: -2px; }
.chrome-foot::after { top: -2px; }
.slide.visible .chrome-head::after, .slide.visible .chrome-foot::after { transform: scaleX(1); }
.trait { border-top-color: transparent; position: relative; }
.trait::before { content: ""; position: absolute; left: 0; right: 0; top: -4px; height: 4px; background: var(--ink); transform: scaleX(0); transform-origin: left; transition: transform .9s var(--ease) .5s; }
.slide.visible .trait::before { transform: scaleX(1); }
.timeline .track { transform: scaleX(0); transform-origin: left; transition: transform 1.4s var(--ease) .4s; }
.slide.visible .timeline .track { transform: scaleX(1); }
.timeline .step::before { transform: scale(0); transition: transform .5s cubic-bezier(.34,1.5,.64,1); }
.slide.visible .timeline .step::before { transform: scale(1); }
.slide.visible .timeline .step:nth-child(1)::before { transition-delay: .6s; }
.slide.visible .timeline .step:nth-child(2)::before { transition-delay: .85s; }
.slide.visible .timeline .step:nth-child(3)::before { transition-delay: 1.1s; }
.slide.visible .timeline .step:nth-child(4)::before { transition-delay: 1.35s; }
.hero, h1 { transform-origin: left bottom; }
.hero.reveal { transform: translateY(40px) skewY(2deg); }
.slide.visible .hero.reveal { transform: none; }
.card { transition: transform .25s ease, box-shadow .25s ease; will-change: transform; }
.card:hover { transform: translate(-4px, -4px); box-shadow: 18px 18px 0 var(--ink); }
.card.ink:hover { box-shadow: 18px 18px 0 var(--vermilion); }
.kicker::before { transform: scaleX(0); transform-origin: left; transition: transform .8s var(--ease) .25s; }
.slide.visible .kicker::before { transform: scaleX(1); }
.ledger h3 .dot { animation: pulse 2.4s ease-in-out infinite; }
@keyframes pulse { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.25); } }

/* progress bar along the bottom edge of the stage */
.progress { position: absolute; left: 0; bottom: 0; height: 6px; background: var(--vermilion); z-index: 50; transition: width .6s var(--ease); }
```


## Side nav (CSS)

```css
SIDE NAV — vertical ticks, left middle of the stage
   Hover: tick stretches, label slides out; active tick is red.
   =========================================== */
.side-nav { position: absolute; left: 34px; top: 50%; transform: translateY(-50%); z-index: 60; display: flex; flex-direction: column; gap: 14px; }
.side-nav button { all: unset; cursor: pointer; display: flex; align-items: center; gap: 14px; height: 22px; position: relative; }
.side-nav .tick { width: 22px; height: 3px; background: currentColor; opacity: .35; transition: width .35s var(--ease), opacity .3s, background .3s, transform .35s var(--ease); transform-origin: left; }
.side-nav .lbl { display: flex; align-items: center; gap: 10px; background: var(--ink); color: var(--paper); font-family: var(--font-mono); font-size: 13px; letter-spacing: .18em; text-transform: uppercase; padding: 8px 14px 8px 12px; white-space: nowrap; opacity: 0; transform: translateX(-14px) skewX(-6deg); transition: opacity .3s var(--ease), transform .4s var(--ease); pointer-events: none; box-shadow: 5px 5px 0 var(--vermilion); }
.side-nav .lbl b { font-family: var(--font-display); font-weight: 900; color: var(--vermilion); font-size: 13px; letter-spacing: 0; }
.side-nav button:hover .tick { width: 44px; opacity: 1; }
.side-nav button:hover .lbl { opacity: 1; transform: translateX(0) skewX(0); }
.side-nav button.active .tick { width: 44px; opacity: 1; background: var(--vermilion); box-shadow: 0 0 0 3px color-mix(in srgb, var(--vermilion) 25%, transparent); }
.side-nav button:active .tick { transform: scaleX(.85); }
.slide.dark .side-nav, .slide.red .side-nav { color: var(--paper); }
.red .side-nav .lbl { box-shadow: 5px 5px 0 var(--paper); }
.red .side-nav button.active .tick { background: var(--ink); box-shadow: 0 0 0 3px rgba(18,17,16,.25); }
/* nav lives in the stage, above slides */
.deck-stage > .side-nav { color: var(--ink); }
.deck-stage > .side-nav.on-dark, .deck-stage > .side-nav.on-red { color: var(--paper); }
.deck-stage > .side-nav.on-red .lbl { box-shadow: 5px 5px 0 var(--paper); }
.deck-stage > .side-nav.on-red button.active .tick { background: var(--ink); box-shadow: 0 0 0 3px rgba(18,17,16,.25); }
/* ripple pulse when a tick becomes active */
@keyframes tick-pop { 0% { transform: scaleX(.4); } 60% { transform: scaleX(1.15); } 100% { transform: scaleX(1); } }
.side-nav button.active .tick { animation: tick-pop .5s var(--ease); }
```


## Dossier / filed card with clip + image placeholder (CSS)

```css
KAFKA FIGURE — hard-shadow frame; hatched placeholder until the image lands
   =========================================== */
.kafka { position: relative; width: 560px; aspect-ratio: 4 / 5; border: 3px solid var(--paper); background: var(--ink); box-shadow: 16px 16px 0 var(--vermilion); margin: 0; }
.kafka img { width: 100%; height: 100%; object-fit: cover; display: block; filter: grayscale(1) contrast(1.15); transition: filter .6s ease, transform .8s var(--ease); }
.kafka:hover img { filter: grayscale(0) contrast(1.05); transform: scale(1.03); }
.kafka::before { content: ""; position: absolute; inset: 0; background: linear-gradient(160deg, transparent 55%, rgba(228,57,27,.55)); mix-blend-mode: multiply; pointer-events: none; }
.kafka figcaption { position: absolute; left: -3px; bottom: -3px; background: var(--paper); color: var(--ink); font-family: var(--font-mono); font-size: 13px; letter-spacing: .16em; text-transform: uppercase; padding: 10px 14px; display: flex; gap: 12px; align-items: center; }
.kafka figcaption b { white-space: nowrap; font-family: var(--font-display); font-weight: 900; color: var(--vermilion); font-size: 14px; letter-spacing: 0; }
.kafka.missing img { display: none; }
.kafka.missing { background: repeating-linear-gradient(45deg, var(--ink) 0 10px, #2A2724 10px 20px); }
.kafka.missing::after { content: "Зображення: assets/kafka.png"; position: absolute; inset: 0; display: grid; place-items: center; font-family: var(--font-mono); font-size: 14px; letter-spacing: .18em; text-transform: uppercase; color: var(--paper); background: rgba(18,17,16,.6); text-align: center; padding: 40px; }


/* epigraph on the contents slide: small portrait + Kafka line */
.epigraph { display: grid; grid-template-columns: 150px 1fr; gap: 28px; align-items: center; margin-top: 56px; max-width: 700px; }
.kafka.small { width: 150px; box-shadow: 8px 8px 0 var(--vermilion); border-color: var(--ink); background: var(--paper-2); }
.kafka.small.missing::after { content: "kafka.png"; font-size: 11px; padding: 10px; }
.kafka.small.missing { background: repeating-linear-gradient(45deg, var(--paper-2) 0 8px, var(--paper) 8px 16px); }
.kafka.small.missing::after { background: transparent; color: var(--ink); }
.dossier .q { font-family: var(--font-display); font-weight: 700; font-size: 22px; line-height: 1.3; letter-spacing: -0.01em; }
.dossier .who { font-family: var(--font-mono); font-size: 13px; letter-spacing: .12em; text-transform: uppercase; color: var(--steel); margin-top: 12px; line-height: 1.6; }
.dossier .who b { color: var(--vermilion); font-weight: 500; }


/* dossier card: the Kafka note "filed" into the register */
.dossier { position: relative; display: grid; grid-template-columns: 150px 1fr; gap: 30px; align-items: center; margin-top: 52px; max-width: 720px; background: var(--white); border: 3px solid var(--ink); padding: 26px 30px 26px 26px; box-shadow: 12px 12px 0 var(--ink); rotate: -1.5deg; transform-origin: left center; transition: rotate .5s var(--ease), box-shadow .3s; }
.dossier:hover { rotate: 0deg; box-shadow: 16px 16px 0 var(--vermilion); }
.dossier .clip { position: absolute; width: 36px; height: 82px; left: 40px; top: -40px; rotate: 8deg; }
.dossier .kafka.small { box-shadow: none; border: 3px solid var(--ink); }
.dossier .kafka.small::before { display: none; }
.dossier .kafka.small img { filter: none; object-position: center 20%; }
.dossier:hover .kafka.small img { transform: scale(1.06); }
.stamp.mini .ring text { font-size: 30px; letter-spacing: .3em; }
.stamp.mini .center { font-size: 96px; }
.dossier .stamp.mini { z-index: 3; }
.slide.visible .dossier .stamp.reveal { transition-delay: 1.3s; opacity: .85; }
```


## Presentation controller (JS)

```js
SLIDE PRESENTATION CONTROLLER
   =========================================== */
class SlidePresentation {
    constructor() {
        this.slides = Array.from(document.querySelectorAll('.slide'));
        this.stage = document.getElementById('deckStage');
        this.current = 0;
        this.setupStageScale();
        this.setupKeyboardNav();
        this.setupTouchNav();
        this.setupWheelNav();
        const fromHash = parseInt(location.hash.replace('#', ''), 10);
        this.showSlide(Number.isFinite(fromHash) ? fromHash - 1 : 0, true);
    }
    setupStageScale() {
        const scale = () => {
            const f = Math.min(window.innerWidth / 1920, window.innerHeight / 1080);
            const x = (window.innerWidth - 1920 * f) / 2;
            const y = (window.innerHeight - 1080 * f) / 2;
            this.stage.style.transform = `translate(${x}px, ${y}px) scale(${f})`;
        };
        scale();
        window.addEventListener('resize', scale);
    }
    setupKeyboardNav() {
        document.addEventListener('keydown', (e) => {
            if (e.target.getAttribute && e.target.getAttribute('contenteditable') === 'true') return;
            switch (e.key) {
                case 'ArrowRight': case 'ArrowDown': case ' ': case 'PageDown': e.preventDefault(); this.next(); break;
                case 'ArrowLeft': case 'ArrowUp': case 'PageUp': e.preventDefault(); this.prev(); break;
                case 'Home': e.preventDefault(); this.showSlide(0); break;
                case 'End': e.preventDefault(); this.showSlide(this.slides.length - 1); break;
            }
        });
    }
    setupTouchNav() {
        let sx = 0, sy = 0;
        document.addEventListener('touchstart', (e) => { sx = e.touches[0].clientX; sy = e.touches[0].clientY; }, { passive: true });
        document.addEventListener('touchend', (e) => {
            const dx = e.changedTouches[0].clientX - sx, dy = e.changedTouches[0].clientY - sy;
            if (Math.abs(dx) > 50 && Math.abs(dx) > Math.abs(dy)) dx < 0 ? this.next() : this.prev();
        }, { passive: true });
    }
    setupWheelNav() {
        let locked = false;
        document.addEventListener('wheel', (e) => {
            if (document.body.classList.contains('editing') || locked || Math.abs(e.deltaY) < 20) return;
            locked = true; e.deltaY > 0 ? this.next() : this.prev();
            setTimeout(() => { locked = false; }, 700);
        }, { passive: true });
    }
    next() { this.showSlide(this.current + 1); }
    prev() { this.showSlide(this.current - 1); }
    showSlide(i, instant) {
        const target = Math.max(0, Math.min(i, this.slides.length - 1));
        if (target === this.current && this.slides[target].classList.contains('visible')) return;
        const apply = () => {
            this.current = target;
            this.slides.forEach((s, k) => { const on = k === this.current; s.classList.toggle('active', on); s.classList.toggle('visible', on); });
            history.replaceState(null, '', `#${this.current + 1}`);
            document.getElementById('progress').style.width = ((this.current + 1) / this.slides.length * 1920) + 'px';
            if (this.onChange) this.onChange(this.current);
        };
        apply();
    }
}
```


## Inline editor with BUILD versioning (JS)

```js
INLINE EDITOR — hover top-left corner or press E; Ctrl+S saves
   =========================================== */
const BUILD = '1789031378'; // bump on every file change: stale browser edits are dropped
class InlineEditor {
    constructor() {
        this.isActive = false;
        this.toggle = document.getElementById('editToggle');
        this.hotzone = document.querySelector('.edit-hotzone');
        this.editable = 'h1, h2, h3, p, li > span, .hero, .kicker, .chrome-head span, .chrome-foot span, .authors div, .tag, .band span, .giant';
        this.restore(); this.bind();
    }
    bind() {
        let t = null;
        const hideLater = () => { t = setTimeout(() => { if (!this.isActive) this.toggle.classList.remove('show'); }, 400); };
        this.hotzone.addEventListener('mouseenter', () => { clearTimeout(t); this.toggle.classList.add('show'); });
        this.hotzone.addEventListener('mouseleave', hideLater);
        this.toggle.addEventListener('mouseenter', () => clearTimeout(t));
        this.toggle.addEventListener('mouseleave', hideLater);
        this.hotzone.addEventListener('click', () => this.toggleEditMode());
        this.toggle.addEventListener('click', () => this.toggleEditMode());
        document.addEventListener('keydown', (e) => {
            if ((e.key === 'e' || e.key === 'E') && e.target.getAttribute('contenteditable') !== 'true') this.toggleEditMode();
            if ((e.ctrlKey || e.metaKey) && e.key === 's' && this.isActive) { e.preventDefault(); this.save(); this.download(); }
        });
        document.addEventListener('input', () => { if (this.isActive) this.save(); });
    }
    toggleEditMode() {
        this.isActive = !this.isActive;
        document.body.classList.toggle('editing', this.isActive);
        this.toggle.classList.toggle('active', this.isActive);
        document.querySelectorAll(this.editable).forEach((el) => el.setAttribute('contenteditable', this.isActive ? 'true' : 'false'));
        if (!this.isActive) this.save();
    }
    save() { try { localStorage.setItem('aparat-deck', JSON.stringify({ build: BUILD, html: Array.from(document.querySelectorAll('.slide')).map(el => el.outerHTML).join('') })); } catch (_) {} }
    restore() { try { const raw = localStorage.getItem('aparat-deck'); if (!raw) return; let d = null; try { d = JSON.parse(raw); } catch (_) {} if (!d || d.build !== BUILD) { localStorage.removeItem('aparat-deck'); return; } document.querySelectorAll('.slide').forEach(el => el.remove()); document.getElementById('deckStage').insertAdjacentHTML('afterbegin', d.html); } catch (_) {} }
    download() {
        const c = document.documentElement.cloneNode(true);
        c.querySelectorAll('[contenteditable]').forEach((el) => el.removeAttribute('contenteditable'));
        c.querySelector('body').classList.remove('editing');
        const blob = new Blob(['<!DOCTYPE html>\n' + c.outerHTML], { type: 'text/html' });
        const a = document.createElement('a'); a.href = URL.createObjectURL(blob); a.download = 'burokratiya-aparat.html'; a.click();
    }
}
```


## Stamp builder + tilt (JS)

```js
STAMP BUILDER — turns <div class="stamp" data-*> into SVG
   =========================================== */
function buildStamps() {
    document.querySelectorAll('.stamp').forEach((el, i) => {
        if (el.querySelector('svg')) return;
        const ring = el.dataset.ring || '';
        const center = el.dataset.center || '';
        const sub = el.dataset.sub || '';
        const id = 'ring' + i;
        el.innerHTML = `<svg viewBox="0 0 300 300">
  <defs><path id="${id}" d="M150,150 m-116,0 a116,116 0 1,1 232,0 a116,116 0 1,1 -232,0"/></defs>
  <circle cx="150" cy="150" r="142" stroke-width="5"/>
  <circle cx="150" cy="150" r="131" stroke-width="2"/>
  <circle cx="150" cy="150" r="96" stroke-width="2"/>
  <g class="ring"><text><textPath href="#${id}">${ring}${ring}</textPath></text></g>
  <text class="center" x="150" y="${sub ? 150 : 164}">${center}</text>
  ${sub ? `<text class="sub" x="150" y="186">${sub}</text>` : ''}
</svg>`;
    });
}
buildStamps();

/* ===========================================
   TILT — cards lean toward the cursor
   =========================================== */
document.querySelectorAll('.card').forEach((card) => {
    card.addEventListener('mousemove', (e) => {
        const r = card.getBoundingClientRect();
        const x = (e.clientX - r.left) / r.width - 0.5;
        const y = (e.clientY - r.top) / r.height - 0.5;
        card.style.transform = `translate(-4px,-4px) perspective(1200px) rotateY(${x * 6}deg) rotateX(${-y * 6}deg)`;
    });
    card.addEventListener('mouseleave', () => { card.style.transform = ''; });
});
```


## Side nav builder (JS)

```js
SIDE NAV BUILDER — one tick per slide, labels from data-title
   =========================================== */
function buildSideNav(deck) {
    const nav = document.getElementById('sideNav');
    nav.innerHTML = '';
    deck.slides.forEach((sl, k) => {
        const b = document.createElement('button');
        b.type = 'button';
        b.setAttribute('aria-label', `Слайд ${k + 1}: ${sl.dataset.title || ''}`);
        b.innerHTML = `<span class="tick"></span><span class="lbl"><b>${String(k + 1).padStart(2, '0')}</b>${sl.dataset.title || ''}</span>`;
        b.addEventListener('click', () => deck.showSlide(k));
        nav.appendChild(b);
    });
    deck.onChange = (idx) => {
        nav.querySelectorAll('button').forEach((b, k) => b.classList.toggle('active', k === idx));
        const sl = deck.slides[idx];
        nav.classList.toggle('on-dark', sl.classList.contains('dark'));
        nav.classList.toggle('on-red', sl.classList.contains('red'));
    };
    deck.onChange(deck.current);
}
```


## Self-drawing SVG diagrams (from qed.html) — data-feyn JSON → SVG

```html
<svg class="fd" viewBox="0 0 400 300" data-feyn='[{"t":"f","x1":60,"y1":280,"x2":140,"y2":170,"lbl":"e⁻","lx":30,"ly":290},{"t":"p","x1":140,"y1":170,"x2":260,"y2":170,"n":7,"a":10,"lbl":"γ","lx":193,"ly":150},{"t":"loop","cx":200,"cy":150,"r":70},{"t":"arc","x1":130,"y1":150,"x2":270,"y2":150,"n":8,"a":10,"down":true},{"t":"v","x":140,"y":170},{"t":"lbl","x":200,"y":60,"s":"e⁻"}]'></svg>
<!-- primitives: f fermion (arrow at midpoint), p photon wave (n half-waves, a amplitude), arc photon semicircle, loop fermion circle, v vertex dot, lbl label -->
```
CSS: every path gets `--len` from `getTotalLength()`; `stroke-dasharray/offset: var(--len)` → `.slide.visible .fd path { stroke-dashoffset: 0 }` (1.3 s expo-out); vertices/arrows/labels pop with delays 0.9/1.1/1.3 s. Class `big` = 5 px strokes + shimmer on the photon; `on-gold` recolours photon/vertices for a gold background; `chalk-lbl` for chalk labels. Generator functions `wavePath`, `arcWavePath`, `arrow`, `buildFeyn` live in qed.html — copy verbatim.

## Formulas — KaTeX from cdnjs
```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.16.11/katex.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.16.11/katex.min.js"></script>
<div class="tex disp big" data-tex="\mathcal{L} = \bar\psi(i\gamma^\mu D_\mu - m)\psi - \tfrac14 F_{\mu\nu}F^{\mu\nu}"></div>
```
`renderTex()` renders every `.tex[data-tex]` (`displayMode` for `.disp`), falls back to raw text in mono if KaTeX failed to load. Size via `.tex.big .katex { font-size: 64px }` etc. `\underbrace{...}_{\text{label}}` annotates terms nicely.

## Glossary table (qed.html)
`table.gloss.stagger` — rows cascade in (delays for up to 12 children). Columns: `td.t` term (display 24 px), `td.s` pronunciation (mono, accent), `td.u` translation, `td.n` usage note with `<i>` for collocations. 11–12 rows fit at 19–24 px in the 780 px content area.

## Graph-paper background
```css
.slide { background-image: linear-gradient(rgba(62,111,209,.11) 1px, transparent 1px), linear-gradient(90deg, rgba(62,111,209,.11) 1px, transparent 1px); background-size: 40px 40px; }
```


## v3 additions (from templates/example-qed-v3-deck.html)
- `.scene.title` — the title background: image at .72 under a left-and-bottom gradient so the hero, authors and band stay legible.
- `.letters` / `buildLetters()` — letter-by-letter blur-in (title and closing heroes only).
- `.words` / `buildWords()` — word builds for 2–3 headings; child spans (accents) animate as one word; `--w0` sets the start delay.
- `.stamp.hero` — blur + spring entrance for the two hero stamps.
- `.wall-viewport` / `.wall` / `.tile` + `gallery.init()` — the non-interactive 3D wall as a background: tiles ripple in by distance from the centre, then pan; scrims in `::before/::after`; no panels on top.
- `data-feyn` primitive `h` — heavy line (nucleus) for Bremsstrahlung / pair production / Delbrück tiles.
- Cyanotype duotone for an off-palette portrait on a blue deck: `img { filter: grayscale(1) contrast(1.15) }` + `::before { background: <pale>; mix-blend-mode: multiply }` + `::after { background: <blue>; mix-blend-mode: lighten }` (see Бюрократія v2).
- Title block (`.tblock`) — a technical-drawing signature table used as the authors block (Бюрократія v2).

## Blueprint additions (from templates/example-blueprint-deck.html — the second standard)
- **The sheet** — one global material layer above every slide, as three siblings of the slides in the stage: `.sheet-fx.mottle` (SVG feTurbulence rect, `mix-blend-mode: multiply`, opacity `var(--mottle)`), `.sheet-fx.grain` (fine noise, `soft-light`), `.sheet` (1 px frame inset 26 px via `::before`, radial vignette via `::after`, registration crosses as `<use href="#regmark">` in the corners). Colours and strengths are CSS variables on the stage, switched by `on-paper`/`on-yellow` classes in `deck.onChange` and transitioned 1.2 s so they crossfade with the slide. Reinvent per style: chalk edge + board vignette, film-scan edge + gate weave, kraft fibres + tape.
- **Sheet tab** (`buildTabs()`) — for each `.slide.paper` a vertical `writing-mode: vertical-rl` tab «Арк. NN» on the frame, text taken from the footer; slides in from the right at .9 s.
- **Section watermark** `.wm` — a 240–300 px display numeral with `color: transparent; -webkit-text-stroke: 2px rgba(line,.17)`, blur 8 → 0, on the quiet slides only, in the empty corner (measure the column above it first).
- **Mechanism diagrams** `svg.mech` — every `rect/line/path/circle/polyline` draws with `stroke-dashoffset` from `--len` (set by `measureDraw()`), delayed by `calc(.7s + var(--lv) * .15s)` where `--lv` is the element's level; `.fill` rects fade their fill after the stroke; `.mark` arrowheads pop with the snappy spring (wrap them in a positioned `<g>`); `text` fades at `1.2s + lv × .15s`. Org chart: levels 0–8 (nodes, elbows, dimension lines, caption). Loop: three arcs ending 5° before the next station drawn as one continuous plotter stroke (`--d`/`--t` per arc, `linear`), station squares and tangent arrowheads popping when the pen arrives, side labels anchored with inline `text-anchor`, an `.orbit` group rotating about the centre (`ring-turn 16s`) with a dot as the ambient starting after the loop closes, gated by `.slide.visible`.
- **Portrait in a line frame** `.fig.portrait` — 3 px line border, no mount, cyanotype duotone (`.cyan`), figcaption strip in the line colour, `reveal` with a 2° settle; the stamp overlaps its left edge (`right: 344px; bottom: 132px` next to a 236 px portrait at `right: 130px`).
- **Dimension lines that measure a word** — `svg.draw[data-dim]` is generated by `buildDims()` to the exact width of the element before it (or `data-for`), measured with a `Range` after `document.fonts.ready`: end ticks and arrows exactly under the first and last letter, the label centred below (left-aligned if wider than the word) or, with `data-gap`, inside a gap of the line (the title: `10 літер · масштаб 1 : 1 · без скорочень`). `svg.draw { overflow: visible }`.
- **Loud row in a bar table** `.bar.hot` — tinted row gradient, 60 px value on the yellow marker, bold label, taller track; only one row per table.
- **Glossary cascade** — `.gloss.stagger > tbody` neutralised, each `tr` gets `--r` (1–12) → `transition-delay: calc(.31s + var(--r) * .13s)`.
