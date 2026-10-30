#!/usr/bin/env bash
# Builds the ZIP that is uploaded to OpenAI's plugin portal.
#
# OpenAI reads the Agent Plugins files (plugin.json, mcp.json, skills/, assets/)
# and wants exactly one plugin root with no sibling entries, so the archive holds
# the repository contents at its root. The Anthropic-only files are left out:
# .claude-plugin/ is a manifest location OpenAI's portal also recognizes, and
# .mcp.json uses a transport type the Agent Plugins schema does not accept.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

version="$(python3 -c 'import json; print(json.load(open("plugin.json"))["version"])')"
out="dist/qualia-connect-${version}.zip"

mkdir -p dist
rm -f "$out"

zip -r -X "$out" . \
  -x '.git/*' \
  -x '.claude/*' \
  -x '.claude-plugin/*' \
  -x '.mcp.json' \
  -x 'dist/*' \
  -x '.gitignore' \
  -x 'scripts/*' \
  -x '*/.DS_Store' -x '.DS_Store'

echo
echo "Built $out"
unzip -l "$out"
