#!/usr/bin/env bash
# 用法：bash scripts/new-deck.sh [名字]
# 从 decks/demo.md 复制一份新幻灯片，例如：
#   bash scripts/new-deck.sh lab-intro
set -euo pipefail
cd "$(dirname "$0")/.."

NAME="${1:-my-talk}"
NAME="${NAME%.md}"
DEST="decks/${NAME}.md"

if [ -e "$DEST" ]; then
  echo "$DEST 已经存在，换一个名字，或直接编辑它。" >&2
  exit 1
fi

cp decks/demo.md "$DEST"

echo "已创建 $DEST"
echo
echo "接下来："
echo "  1. 编辑 $DEST"
echo "  2. bash scripts/build.sh $DEST"
echo "  3. bash scripts/serve.sh        # http://localhost:8000"
echo "  4. bash scripts/deploy.sh $DEST  # 发布到线上"
