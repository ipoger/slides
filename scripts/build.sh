#!/usr/bin/env bash
# 用法：bash scripts/build.sh [decks/xxx.md]
# 不传参数时默认编译 decks/demo.md
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -x .venv/bin/python ]; then
  echo "还没有安装依赖，先运行：bash scripts/setup.sh" >&2
  exit 1
fi

DECK="${1:-decks/demo.md}"
.venv/bin/python main.py "$DECK"

echo "已生成：$(dirname "$DECK")/dist/index.html"
