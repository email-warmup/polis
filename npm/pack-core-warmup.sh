#!/usr/bin/env bash
# Сборка tarball форка для Core Warmup. Повторяет шаг из .github/workflows/main.yml
# (публикация upstream): main/types указывают на dist, а не на src.
set -euo pipefail
cd "$(dirname "$0")"
npm install --no-audit --no-fund
npm run build
cp package.json package.json.bak
trap 'mv package.json.bak package.json' EXIT
npm pkg set main=dist/index.js types=dist/index.d.ts
npm pack --pack-destination "${1:-..}"
