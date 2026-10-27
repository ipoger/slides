#!/usr/bin/env bash
# 把 decks/dist 发布到 gh-pages 分支。
# 这样不需要 GitHub Actions，也不需要 workflow scope。
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT="$PWD"

bash scripts/build.sh

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

cp -R decks/dist/. "$TMP"/
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

echo "已更新 gh-pages：$REMOTE"
