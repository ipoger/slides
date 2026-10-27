#!/usr/bin/env bash
# 本地预览：http://localhost:8000
set -euo pipefail
cd "$(dirname "$0")/.."

PORT="${1:-8000}"
if [ ! -f decks/dist/index.html ]; then
  echo "还没有生成幻灯片，先运行：bash scripts/build.sh" >&2
  exit 1
fi

echo "打开 http://localhost:${PORT}/ （Ctrl+C 退出）"
python3 -m http.server "$PORT" --directory decks/dist
