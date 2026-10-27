#!/usr/bin/env bash
# 第一次使用：创建虚拟环境并安装依赖
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v python3 >/dev/null 2>&1; then
  echo "找不到 python3，请先安装 Python 3.10+。" >&2
  exit 1
fi

python3 -m venv .venv
# shellcheck disable=SC1091
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt

echo
echo "完成。接下来："
echo "  bash scripts/build.sh"
echo "  bash scripts/serve.sh"
