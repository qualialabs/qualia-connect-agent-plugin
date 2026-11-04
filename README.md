# Qualia Connect agent plugin

Source for the Qualia Connect plugin in the Anthropic plugin directory and the OpenAI plugin directory. What the plugin does, and what users see in both listings, is in [plugin/README.md](plugin/README.md).

## Layout

Everything that ships lives in `plugin/`. The Anthropic directory scans the whole plugin folder and holds a version for review when a script inside it can reach an image file, so build tooling stays out here at the repository root.

- `plugin/` is the plugin folder, the one the directories list. Shared by both: `skills/`, `assets/` (the Qualia mark on a dark square, plus the reversed version OpenAI shows in dark mode) and the README, which the Anthropic directory uses as the listing text. Each directory has its own manifests:
  - Anthropic reads the repository on GitHub: `plugin/.claude-plugin/plugin.json` and `plugin/.mcp.json`.
  - OpenAI takes a ZIP upload: `plugin/plugin.json` and `plugin/mcp.json`, in the Agent Plugins format. The Anthropic directory recognizes `plugin.json` as an agent-plugins manifest and ignores it.
- `.claude-plugin/marketplace.json` makes this repository a one-plugin Claude Code marketplace pointing at `./plugin`.
- `scripts/build-openai-zip.sh` builds the OpenAI upload. `dist/` holds its output and is ignored by git.

Keep the two manifests in step: `name`, `version` and `description` should match, and `version` is bumped in both for every release.

## Install in Claude Code

```
/plugin marketplace add qualialabs/qualia-connect-agent-plugin
/plugin install qualia-connect@qualia
```

While this repository is private, your GitHub account needs read access to it.

## Develop

The plugin is markdown and JSON with no build step. From a clone:

```
claude plugin validate --profile directory --strict plugin
claude --plugin-dir plugin
```

The first command runs the checks the Anthropic directory runs. The second starts a Claude Code session with the plugin loaded without installing it. Run `/mcp` to connect to Connect, then try the prompts in the plugin README. To point at a dev stack, change the URL in `plugin/.mcp.json` to `https://connect.qli5.dev/mcp` locally and do not commit it.

## Build the OpenAI ZIP

```
scripts/build-openai-zip.sh
```

It writes `dist/qualia-connect-<version>.zip` with the contents of `plugin/` at the archive root, leaving out the Anthropic-only files (`.claude-plugin/`, `.mcp.json`). The archived `plugin.json` is the repository's with the `license` field removed, since the OpenAI listing should not carry one. OpenAI's review test cases, release notes and commerce declaration live in `plugin/plugin.json` under `extensions.com.openai` and are imported with each upload.

## Server

The MCP server this plugin connects to lives in the `qualialabs/qualia` monorepo under `services/connect/app/imports/server/mcp-api/`.
