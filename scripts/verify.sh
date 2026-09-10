#!/usr/bin/env bash
# Verify the deck-workflow install: every manifest file exists and is non-empty.
# Usage: bash scripts/verify.sh            → OK / MISSING per file, exit 1 if anything is missing
#        bash scripts/verify.sh --print    → also print sizes and the workflow md5 (compare two installs)
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MANIFEST=$(awk '/^```/{n++; next} n==1' "$ROOT/CHECKSUM.md" | tr ' ' '\n' | grep -E '^[A-Za-z].*\.[A-Za-z0-9]+$' | sort -u)
missing=0
for f in $MANIFEST; do
  if [ -s "$ROOT/$f" ]; then
    if [ "${1:-}" = "--print" ]; then printf 'OK       %8d  %s\n' "$(stat -c %s "$ROOT/$f" 2>/dev/null || stat -f %z "$ROOT/$f")" "$f"; else echo "OK       $f"; fi
  else echo "MISSING  $f"; missing=$((missing+1)); fi
done
[ -f "$ROOT/LOCAL.md" ] && echo "OK       LOCAL.md (machine settings present)" || echo "NOTE     LOCAL.md missing — copy LOCAL.example.md → LOCAL.md and set your paths"
if [ "${1:-}" = "--print" ]; then
  echo "workflow md5: $(cat "$ROOT/SKILL.md" "$ROOT/CHECKSUM.md" "$ROOT"/reference/*.md 2>/dev/null | md5sum | cut -c1-12)"
fi
if [ "$missing" -gt 0 ]; then echo "verify: $missing file(s) missing"; exit 1; else echo "verify: all $(echo "$MANIFEST" | wc -l) manifest files present"; fi
