#!/usr/bin/env bash
# Builds the ZIP that is uploaded to OpenAI's plugin portal.
#
# OpenAI reads the Agent Plugins files (plugin.json, mcp.json, skills/, assets/)
# and wants exactly one plugin root with no sibling entries, so the archive holds
# the repository contents at its root. The Anthropic-only files are left out:
# .claude-plugin/ is a manifest location OpenAI's portal also recognizes, and
# .mcp.json uses a transport type the Agent Plugins schema does not accept.
#
# The archived plugin.json is the repository's with the `license` field removed.
# The repository file keeps it; the OpenAI listing should not carry one.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

version="$(python3 -c 'import json; print(json.load(open("plugin.json"))["version"])')"
out="$root/dist/qualia-connect-${version}.zip"

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
  -x 'plugin.json' \
  -x '*/.DS_Store' -x '.DS_Store'

# Add the manifest from a staging directory so it lands at the archive root
# without touching the repository copy.
stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
python3 - plugin.json "$stage/plugin.json" <<'PY'
import json, sys
src, dst = sys.argv[1:]
manifest = json.load(open(src))
manifest.pop('license', None)
with open(dst, 'w') as f:
    json.dump(manifest, f, indent=2, ensure_ascii=False)
    f.write('\n')
PY
(cd "$stage" && zip -X "$out" plugin.json)

echo
echo "Built $out"
unzip -l "$out"
