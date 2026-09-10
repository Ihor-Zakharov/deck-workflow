---
name: claude-slides
description: |
  Genera deck di slide HTML — workshop, talk, pitch, demo, recap evento. Architettura deck-stage 1920×1080 con keyboard navigation (←/→/space), perfetta per live presentations su proiettore. Branding neutro di default (blu/viola/carta), personalizzabile via CSS variables. Output: file HTML autonomo con viewer chrome (progress bar + fullscreen) e supporto per slide statiche o animate (in-slide step reveal).

  MANDATORY TRIGGERS: crea slide, crea slide per X, presentazione su X, presentazione per X, deck per X, slide per workshop, slide per talk, slide per pitch, slide per demo, slide per evento, slide per recap, slide deck, fai un deck, fammi le slide, prepara presentazione, build slides, crea presentazione.
---

# Claude Slides

Genera deck HTML: deck-stage 1920×1080 keyboard-driven, self-contained, viewer integrato (progress bar + fullscreen + tap zones mobile + print-to-PDF).

## File della skill

| File | Uso |
|---|---|
| `template.html` | Boilerplate: deck-stage paradigma, CSS tokens + reveal system + viewer chrome inline. Punto di partenza di ogni nuovo deck. ~850 righe (includes deck-stage IIFE + step controller). |
| `components.md` | Catalogo dei layout pattern (cards, grids, mockups, diagrams, terminals). HTML+CSS pronti da copiare. |
| `animations.md` | Catalogo delle tecniche di animazione (path drawing, popup, packets, pulse, magic-move) + critical gotchas. Solo per deck animati. |
| `icons.md` | Libreria SVG icons (mail, folder, robot, arrows, ecc) con stile coerente. |
| `examples/demo-deck.html` | Demo deck di 6 slide (animation level LIGHT): reference end-to-end di template + pattern. |

## Quando triggerare

Quando l'utente chiede slide o presentazioni. Ignora la skill solo se l'utente sta lavorando su un deliverable già esistente che non sia HTML (es. PowerPoint da modificare, Canva). Per qualsiasi creazione da zero o conversione → questa skill.

## Workflow (8 fasi + 1 sotto-fase)

### 1. Trigger riconosciuto
Conferma a voce: *"Ti faccio le slide. Prima un brief veloce."*

### 2. Brief
Raccogli in un round veloce. Se l'utente specifica già qualcosa, non richiederlo.

| Input | Esempio | Quando chiederlo |
|---|---|---|
| **Argomento** | "Knowledge base con AI agent" | Sempre (se non specificato) |
| **Pubblico target** | "Direttori di associazioni di categoria, no expertise tecnica" | Sempre |
| **Tipologia** | workshop / pitch / talk / demo / recap evento | Sempre |
| **Durata indicativa** | "3 ore" → ~18 slide; "30 min talk" → ~10 slide; "5 min pitch" → ~6 slide | Sempre |
| **Animation level** | none / light / heavy (default per tipologia, vedi Phase 4.5) | Opzionale (la skill propone) |
| **Outcome desiderato** | convincere · insegnare · celebrare · informare | Opzionale |
| **Branding override** | "palette #abc #def, font Space Grotesk" oppure "default" | Default neutro se non specificato |

**Importante:** se l'utente dice *"il contesto sta nella cartella X"* o *"leggi il file Y"*, leggi quei file prima di procedere. Il brief può anche essere "estratto" da materiali esistenti.

### 3. Brainstorm narrative arc
Proponi 1-3 possibili archi narrativi adatti alla tipologia:

- **Workshop**: setup → problema → soluzione → applicazione → transizione (didattico)
- **Pitch**: hook → problema → soluzione → traction → ask (persuasivo)
- **Talk**: storia → svolta → insight → invito (riflessivo)
- **Demo**: contesto → "cosa fa" → "come funziona" → call-to-action
- **Recap evento**: numeri → momenti → relazioni → next

Presenta le opzioni in modo conciso. Aspetta che l'utente scelga (o adatti).

### 4. Wireframe ASCII (sintetico)
Una volta scelto l'arco, presenta un wireframe slide-per-slide in formato compatto:

```
SLIDE 01 · Cover · cover-gradient
   [Titolo principale + subtitle]

SLIDE 02 · Setup del problema · tools-split
   [Strumenti che usate vs limiti]

SLIDE 03 · Tre modi di usarle · card-grid-3col-numbered
   [Chat singola · Memoria · Projects, ognuno con badge limite]
```

Una riga per slide: numero · titolo · `pattern usato` (da `components.md`). Una riga di descrizione sotto.

**Per slide complesse o nuovi pattern**: aggiungi ASCII layout completo (15-20 righe).

**Aspetta conferma** prima di passare alla 4.5.

### 4.5. Decide animation level
Una volta approvato il wireframe, dichiara la tua proposta di animation level e chiedi conferma:

> *"Proposta animazioni: **LIGHT** per il workshop. Cards rivelate uno-per-uno, niente SVG signature pesanti. Vuoi confermare LIGHT, upgradare slide N a HEAVY (popup/wrap arrow), o downgrade a NONE (tutto statico)?"*

**3 livelli:**

| Livello | Cosa include | Token cost |
|---|---|---|
| **NONE** | Niente `.reveal`, tutto visibile subito. Ogni section = `data-steps="1" data-current-step="1"` | Basso |
| **LIGHT** | Step controller + `.reveal` su cards/elementi (fade-in stagger). NO SVG signature. | Medio |
| **HEAVY** | LIGHT + SVG signature animations da `animations.md` (popup, wrap arrow, packets, magic-move, pulse, mockup) | Alto |

**Default per tipologia (proponi):**

| Tipologia | Default | Logica |
|---|---|---|
| Workshop > 1h live | **LIGHT** | Cards uno-per-uno, niente signature pesante |
| Pitch < 10 slide | **HEAVY** | Pochi slide, ogni momento conta — 1-2 signature WOW |
| Talk live | **LIGHT** | Stesso del workshop, evita affaticamento |
| Demo | **LIGHT** | Reveal step-by-step, no SVG signature (la demo dal vivo è già il WOW) |
| Recap evento | **NONE** | Sarà condiviso async, lettura statica |
| Internal report | **NONE** | Lettura asincrona |

**Heuristic aggiuntive:**
- **Mai HEAVY su deck > 18 slide** salvo richiesta esplicita (token cost esplode)
- **Cover slides sempre static** (`data-steps="1" data-current-step="1"`, niente reveal su titolo/eyebrow)
- **Transition slides (cream + ts-title) sempre static**
- Se utente dice *"questa slide deve essere WOW"* → upgrade quella sola a HEAVY signature
- Se utente non risponde, applica default per tipologia

### 5. Generate il deck
Quando confermati wireframe + animation level:

0. **Asset prep (se servono):**
   - **Foto profilo** (slide speakers, recap people): chiedi i path o gli url, copia in `assets/people/[name].jpeg`.
   - **QR codes** (slide speakers con LinkedIn, contatti, link evento): genera con `qrencode`. Installa una volta con `brew install qrencode`. Comando per ogni QR:
     ```bash
     qrencode -o assets/qr/[name].png -s 20 -m 2 -l H "https://www.linkedin.com/in/[handle]/"
     ```
     Flags: `-s 20` modulo size, `-m 2` margine, `-l H` error correction High (più resiliente alla scansione).
   - **Logo organization** (slide org-hero, sponsor): chiedi i path, copia in `assets/logos/`.
1. Copia `template.html` nella **cartella corrente di lavoro** con nome basato sull'argomento (es. `workshop-ai-agents.html`).
2. Per ogni slide del wireframe:
   - Apri `components.md`, copia HTML+CSS del pattern scelto, popola con contenuto.
   - Se animation level è LIGHT, aggiungi `.reveal data-step="K"` agli elementi che vuoi rivelare progressivamente (e `data-steps="N"` sulla section).
   - Se HEAVY su una slide, apri `animations.md`, copia la tecnica scelta (popup, wrap arrow, packets, ecc) e includi snippet HTML+CSS+JS necessari.
3. Inserisci tutte le `<section>` al posto del commento `INSERT SLIDES HERE` in template.html.
4. Aggiorna `<title>` con il nome del deck.
5. Aggiorna i footer di ogni slide: `Speaker · Org · NN`.
6. Applica il **branding**: di default la palette neutra (CSS già in template). Se l'utente ha chiesto override, sostituisci le CSS variables in `:root` (`--cs-primary`, `--cs-secondary`, `--cs-cream`, font-family).

### 6. Speaker notes (on demand)
Genera `[deck-name]-notes.md` **solo se l'utente le chiede esplicitamente** ("voglio anche le note", "speaker notes", "mi servono le note per parlare").

Convenzione: un blocco per slide, con heading `## Slide NN — Titolo` seguito dal discorso completo in paragrafi (quello che lo speaker dice davvero, non bullet).

### 7. Open in browser
Apri il file generato con `open [path]`. Conferma all'utente: *"Aperto. Cmd+R per ricaricare se serve. ←/→ per navigare slide, ←/→ avanza anche dentro la slide se ci sono step animati."*

### 8. Iter loop
L'utente rivede e chiede modifiche. Pattern tipici:
- *"cambia slide N con [contenuto]"* → edit puntuale
- *"slide N: titolo su una riga"* → rimuovi `<br>` o spacchetta titolo
- *"riscrivi 5-7"* → batch edit
- *"applica X a tutto"* → sed/replace globale (cambiare terminologia, palette ecc)
- *"elimina slide N"* → rimuovi sezione + renumera footer (CRITICAL: usa Python sequential, non sed cascade — vedi `animations.md` gotchas)
- *"aggiungi slide tra X e Y su Z"* → inserisci sezione + renumera

Dopo ogni edit: l'utente fa Cmd+R nel browser per vedere. Non serve riaprire.

## Voice rules — sempre applicare

1. **Sintetico on-screen, speaker parla.** Niente paragrafi lunghi nelle slide. Bullet brevi, frasi taglienti. Le speaker notes (separate) contengono il discorso completo.
2. **Niente trailing periods** su:
   - Titoli (h1, h2, h3) di slide e card
   - Subtitle, eyebrow, payoff in titolo
   - Card heading (`.pq-card h3`, `.card h3`, ecc)

   **Mantieni il punto** su body paragrafi, payoff descrittivi, quotes, captions.
3. **Single-line titles dove possibile.** Rimuovi `<br>` salvo per ragioni di equilibrio visivo (titolo lunghissimo che non sta orizzontalmente).
4. **Numerazione 01/02/03** per sequenze. NON A/B/C (più astratto).
5. **Niente em-dash** (`—` o `--`). Usa virgole, due punti, punti, parentesi.
6. **Niente emoji nelle slide** (salvo se esplicitamente richiesto). Usa SVG outline da `icons.md` o lucide via `<i data-lucide="name">`.
7. **Italiano, voi-plural, verbi attivi.** "Lavorate" non "si lavora". Tono diretto. (Override se brief richiede EN o IT-tu.)
8. **Bridge tra slide** (lo speaker lo dice). Le slide non si reggono in isolamento; sono cornice.
9. **Cover gradient brand** per apertura e chiusura. Le slide intermedie sono chiare.
10. **Cover e transition slides STATICHE** — `data-steps="1" data-current-step="1"`, niente `.reveal` sugli elementi.
11. **Hard cut tra slide** (transizione 120ms barely-visible fade già nel template). NIENTE sweep gradient on enter.
12. **Footer leggero:** `Speaker · Org · NN` (numero slide). Sempre presente sulle slide intermedie.

## Quality checklist (auto-applicare prima di consegnare)

- [ ] Em-dash check: nessun `—` o `--` nelle slide
- [ ] No trailing periods su h1/h2/h3 titoli e subtitle
- [ ] Single-line titles dove sensato
- [ ] Footer numerati progressivamente, niente buchi/duplicati
- [ ] Progress bar + fullscreen button presenti (auto da template)
- [ ] Speaker e Org corretti nei footer
- [ ] `<title>` aggiornato col nome del deck
- [ ] Eyebrow + titolo + body coerenti per ogni slide
- [ ] Cover iniziale + cover transizione finale presenti se workshop/pitch
- [ ] Cover/transition slides static (`data-steps="1" data-current-step="1"`)
- [ ] CSS variables di branding corrette (default neutro o override esplicito)
- [ ] Animation level coerente con tipologia (no HEAVY > 18 slide)
- [ ] Bilanciamento HTML: sections aperte = chiuse, divs aperti = chiusi (verifica con Python regex)

## Branding

### Default neutro (incluso in template.html)
```css
--cs-primary:   #2563EB;
--cs-secondary: #7C3AED;
--cs-cream:     #F7F6F2;
--cs-black:     #000000;
--cs-body:      #454545;
--cs-grad-radial: radial-gradient(112% 150% at 0% 100%, #2563EB 0%, #7C3AED 100%);
--cs-grad-linear: linear-gradient(135deg, #2563EB 0%, #7C3AED 100%);
font-family: 'Inter', sans-serif;
```

### Override inline
Se l'utente specifica un altro brand:
*"crea slide su X, palette #abc #def, font Space Grotesk"*

→ Sostituisci le CSS variables in `:root` con i nuovi valori. Aggiorna `font-family` in body. Tutto il resto del CSS resta identico (le classi sono parametriche).

### Firma e lingua
Default: italiano, voi-plural; chiedi firma footer (Speaker, Org) e lingua se non specificati.

## Tipologie e struttura tipica

### Workshop didattico (~15-20 slide)
Cover · Strumenti che usate · Stato dell'arte AI · Due/più problemi · Approfondimento problemi · Soluzione · Demo capacity · Tour della cartella · Skill/asset · Sintesi · Modello mentale · Possibili problematiche · Lavorano CON voi · Transizione demo

### Talk / Pitch (~8-12 slide)
Hook · Storia · Problema concreto · Insight · Soluzione · Esempio · Implication · Call to action · Closing

### Demo (~6-10 slide)
Setup · Cosa fa · Come funziona · Esempio aperto · Behind the scenes · Adopt how · Q&A

### Recap evento (~6-10 slide)
Cover · Numeri · Momenti chiave · Voci dei partecipanti · Relazioni nate · What's next · Thank you

Adatta in base a tipologia + durata.

## Esempi di invocazione

**Esempio 1 — Workshop completo da brief:**
> "Devo fare un workshop di 3 ore su come usare Claude per la P.A. Pubblico di 15 funzionari pubblici, no expertise tecnica."

→ Trigger riconosciuto. Brief già completo (argomento, pubblico, tipologia=workshop, durata=3h). Salto a brainstorm narrative arc → wireframe → propongo LIGHT animation level (workshop default) → conferma → genera.

**Esempio 2 — Pitch da contesto esistente:**
> "Pitch di 5 minuti sul nostro prodotto per investitori. Le info stanno in `docs/contesto.md`."

→ Leggo il file di contesto. Brief: argomento=prodotto, pubblico=investitori, tipologia=pitch, durata=5min ~ 6 slide. Brainstorm hook→problema→soluzione→traction→ask. Wireframe. Propongo HEAVY (pitch corto, ogni momento WOW). Conferma. Genera.

**Esempio 3 — Recap evento:**
> "Recap del meetup di marzo. I dati stanno in `eventi/meetup-marzo/`."

→ Leggo i materiali. Brief: tipologia=recap, scelgo durata 8 slide. Wireframe (numeri, momenti, voci, next). Propongo NONE (recap async, lettura statica). Genera.

## Note finali

- **Il template è il punto di partenza, non un dogma.** Se serve un layout nuovo, aggiungilo come pattern in `components.md` dopo averlo creato.
- **Components.md è una reference, non una bibbia.** Mixa pattern, adatta, sperimenta.
- **Animations.md ha le ricette per le animazioni.** Ogni gotcha è derivato da un bug realmente incontrato — leggile prima di animare.
- **Le slide vanno provate.** Apri sempre nel browser, controlla che il messaggio passi. Itera.
- **Speaker notes sono opzionali ma utili.** Se l'utente sta preparando un workshop importante, suggeriscile proattivamente: *"Vuoi che genero anche le speaker notes?"*
- **Animare costa token.** Rispetta l'animation level scelto. Se l'utente chiede una signature animation su una slide specifica → upgrade quella sola, non tutto il deck.
