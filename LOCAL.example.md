# LOCAL.md — machine-specific settings (copy to LOCAL.md, edit, never share)

- **Output root**: `~/presentations` — each deck in `<root>/<slug>/` (`deck.html`, `brief.md`, `design/`, `assets/`, `lib/`).
- **Chrome** (headless screenshots/PDF): auto-detected by `scripts/render.sh` (`google-chrome`, `chromium`, macOS `/Applications/Google Chrome.app`, or the Windows binary from WSL). Override with `CHROME=/path/to/chrome`.
- **Open a file for the user**: Linux `xdg-open`, macOS `open`, WSL `cmd.exe /c start "" "C:\path\file.html"`.
- **Pasted images** land in `~/.claude/image-cache/<session>/N.(png|jpeg)`; files the user saved themselves usually arrive with a `source:` path (e.g. `~/Downloads/...`).
- **Fonts**: online (Google Fonts). For offline shows embed woff2 as data URIs.

## Example (Windows 11 + WSL2)

- Output root: `/mnt/c/Users/<name>/presentations` = `C:\Users\<name>\presentations`.
- Chrome: `/mnt/c/Program Files/Google/Chrome/Application/chrome.exe` (Windows paths in arguments; Edge headless hangs).
- Open: `cmd.exe /c start "" "C:\Users\<name>\presentations\<slug>\<deck>.html"`.
- Images: `~/.claude/image-cache/<session>/` or `/mnt/c/Users/<name>/Downloads/Gemini_Generated_Image_*.jpg`.
