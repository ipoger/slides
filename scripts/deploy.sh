#!/usr/bin/env bash
# 用法：bash scripts/deploy.sh [decks/xxx.md]
# 不传参数时发布 decks/demo.md
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT="$PWD"

DECK="${1:-decks/demo.md}"
bash scripts/build.sh "$DECK"
OUT="$(dirname "$DECK")/dist"

REMOTE="$(git remote get-url origin)"
HELPER="$(git config --get credential.helper || true)"
NAME="$(git config user.name || true)"
EMAIL="$(git config user.email || true)"

TMP="$(mktemp -d)"
cleanup() {
  cd "$ROOT"
  rm -rf "$TMP"
}
trap cleanup EXIT

cp -R "$OUT/." "$TMP"/
cd "$TMP"
git init -q -b gh-pages
if [ -n "$HELPER" ]; then
  git config credential.helper "$HELPER"
fi
git add .
git -c user.name="${NAME:-slides}" -c user.email="${EMAIL:-slides@example.com}" \
  commit -q -m "deploy: $(date '+%Y-%m-%d %H:%M')"
git remote add origin "$REMOTE"
git push -f origin gh-pages

echo "已更新 gh-pages：$REMOTE（$DECK）"
