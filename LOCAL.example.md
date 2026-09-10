# LOCAL.md — machine-specific settings (copy to LOCAL.md, edit, never share)

- **Output root**: `~/presentations` — each deck in `<root>/<slug>/` (`deck.html`, `brief.md`, `design/`, `assets/`, `lib/`).
- **Chrome** (headless screenshots/PDF): auto-detected by `scripts/render.sh` (`google-chrome`, `chromium`, macOS `/Applications/Google Chrome.app`, or the Windows binary from WSL). Override with `CHROME=/path/to/chrome`.
- **Open a file for the user**: Linux `xdg-open`, macOS `open`, WSL `cmd.exe /c start "" "C:\path\file.html"`.
- **Pasted images** land in `~/.claude/image-cache/<session>/N.(png|jpeg)`; files the user saved themselves usually arrive with a `source:` path (e.g. `~/Downloads/...`).
- **Fonts**: online (Google Fonts). For offline shows embed woff2 as data URIs.
- **Live preview** while a deck is being built: `python3 scripts/serve.py <deck-dir>` → open `http://localhost:8765/<deck>.html`; the tab reloads itself on every save and keeps the slide number.
- **Images by API (optional)**: `GEMINI_API_KEY=…` (Google AI Studio) lets `scripts/gen-images.py <deck-dir>` generate the 3–4 images from the prompts in brief.md; without a key the prompts are printed for manual generation. `pip install google-genai`.
- **Playwright (optional)**: `bash scripts/setup-playwright.sh` creates `.venv` with Playwright + a Linux/macOS/Windows Chromium for exact-time frames and entrance videos; everything works without it through the Chrome CLI.

## Example (Windows 11 + WSL2)

- Output root: `/mnt/c/Users/<name>/presentations` = `C:\Users\<name>\presentations`.
- Chrome: `/mnt/c/Program Files/Google/Chrome/Application/chrome.exe` (Windows paths in arguments; Edge headless hangs).
- Open: `cmd.exe /c start "" "C:\Users\<name>\presentations\<slug>\<deck>.html"`.
- Images: `~/.claude/image-cache/<session>/` or `/mnt/c/Users/<name>/Downloads/Gemini_Generated_Image_*.jpg`.
