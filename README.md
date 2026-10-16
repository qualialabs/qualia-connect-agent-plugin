# Qualia Connect

Work your real estate closings from a conversation. Qualia Connect is where agents, lenders and other parties to a closing work with their title company. This plugin connects your assistant to your Connect account and teaches it how to use that connection well.

## Use it

Sign in to Connect through the plugin's connector, then ask in plain words:

- "Which of my closings need attention today?"
- "What is left to do on the Smith purchase?"
- "Who is the lender on 123 Main St, and when do we close?"
- "Summarize the title commitment on the Oak Avenue order."
- "Reply to the escrow officer that the buyer's insurance binder is on its way."

The assistant sees only the orders, tasks, messages and documents you can see in Connect. It shows you a full draft and asks before sending any message, and it cannot complete tasks, upload documents, change order data or move money.

## Data

The connector at `connect.qualia.com/mcp` authenticates you with OAuth against your own Connect account. Each request carries your request text and the order, thread or document identifiers it refers to. Connect returns order details, task and message content, and shared documents as your account is permitted to see them. The plugin stores nothing itself.

## Availability

Connect's assistant connection is in beta. Your Connect account must be enabled for it. Contact your Qualia representative or support@qualia.com.

## Install

In Claude Code:

```
/plugin marketplace add qualialabs/qualia-connect-plugin
/plugin install qualia-connect@qualia
```

While this repository is private, your GitHub account needs read access to it.

## Develop

The plugin is markdown and JSON with no build step. From a clone:

```
claude plugin validate --strict .
claude --plugin-dir .
```

The second command starts a Claude Code session with the plugin loaded without installing it. Run `/mcp` to connect to Connect, then try the prompts above. To point at a dev stack, change the URL in `.mcp.json` to `https://connect.qli5.dev/mcp` locally and do not commit it.

`plugin.json` and `mcp.json` at the root are the OpenAI plugin manifests for the same server; `.claude-plugin/` and `.mcp.json` are Anthropic's. Both read `skills/`.

The server this plugin connects to lives in the `qualialabs/qualia` monorepo under `services/connect/app/imports/server/mcp-api/`.
