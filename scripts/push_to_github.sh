#!/usr/bin/env bash
# Create github.com/sukoji/vocast (public) and push main.
# Requires: GH_TOKEN env var with repo scope, or `gh auth login` first.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

GH_BIN="${GH_BIN:-gh}"
if ! command -v "$GH_BIN" >/dev/null 2>&1; then
  GH_BIN="/tmp/gh-install/gh_2.63.2_linux_amd64/bin/gh"
fi

if ! "$GH_BIN" auth status >/dev/null 2>&1; then
  if [[ -z "${GH_TOKEN:-}" ]]; then
    echo "[!] Not logged in. Run one of:"
    echo "    export GH_TOKEN=github_pat_..."
    echo "    $GH_BIN auth login"
    exit 1
  fi
  export GH_TOKEN
fi

"$GH_BIN" repo create sukoji/vocast --public --source=. --remote=origin --push --description "Dialect complaint TTS + RVC dataset pipeline"

echo "[+] https://github.com/sukoji/vocast"
