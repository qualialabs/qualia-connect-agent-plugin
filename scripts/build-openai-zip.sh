#!/usr/bin/env bash
# Builds the ZIP that is uploaded to OpenAI's plugin portal.
#
# OpenAI reads the Agent Plugins files (plugin.json, mcp.json, skills/, assets/)
# and wants exactly one plugin root with no sibling entries, so the archive holds
# the contents of plugin/ at its root. The Anthropic-only files are left out:
# .claude-plugin/ is a manifest location OpenAI's portal also recognizes, and
# .mcp.json uses a transport type the Agent Plugins schema does not accept.
#
# The archived plugin.json is plugin/plugin.json with the `license` field
# removed. The repository file keeps it; the OpenAI listing should not carry one.
#
# This script lives outside plugin/ on purpose: the Anthropic directory scans
# everything in the plugin folder and holds a version for review when a script
# in it can reach an image file.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
plugin="$root/plugin"

version="$(python3 -c 'import json, sys; print(json.load(open(sys.argv[1]))["version"])' "$plugin/plugin.json")"
out="$root/dist/qualia-connect-${version}.zip"

mkdir -p "$root/dist"
rm -f "$out"

(
  cd "$plugin"
  zip -r -X "$out" . \
    -x '.claude-plugin/*' \
    -x '.mcp.json' \
    -x 'plugin.json' \
    -x '*/.DS_Store' -x '.DS_Store'
)

# Add the manifest from a staging directory so it lands at the archive root
# without touching the repository copy.
stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
python3 - "$plugin/plugin.json" "$stage/plugin.json" <<'PY'
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
