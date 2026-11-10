# Qualia Connect

Work your real estate closings from a conversation. Qualia Connect is where agents, lenders and other parties to a closing work with their title company. This plugin connects your assistant to your Connect account and teaches it how to use that connection well: checking on your orders, reading what the title company shared, messaging the people on an order, and placing new orders.

## What you can ask

Sign in to Connect through the plugin's connector, then ask in plain words:

- "Which of my closings need attention today?"
- "What is left to do on the Smith purchase?"
- "Who is the lender on 123 Main St, and when do we close?"
- "Summarize the title commitment on the Oak Avenue order."
- "Reply to the escrow officer that the buyer's insurance binder is on its way."
- "Place a purchase order on 456 Oak Avenue with the title company I used on the Smith closing."

## What it does and does not do

The assistant sees only the orders, tasks, messages and documents you can see in Connect, no more. Before sending any message it shows you the full draft, including who will receive it, and waits for your yes. Before placing an order it shows you everything it will send to the title company (the property, the parties, the price and loan details) and waits for your yes; the order then goes to the title company exactly as the Place Order button in Connect would send it. It cannot complete tasks, upload documents, change order data, cancel or change an order once placed, or move money; for those it sends you to the order in Connect or to your title company. Wire instructions and payoff changes always go through your title company's verification process, never through a message the assistant drafts.

When you ask for something Connect cannot do through an assistant yet, it tells you so and passes your request, in your words, to Qualia so Connect can add it. Nothing on your orders changes.

## What it runs, sends and fetches

The plugin is text: two manifests, this README and one skill. It bundles no code, defines no hooks, commands or agents, runs nothing on your computer and fetches nothing from the web. (`plugin.json` and `mcp.json` are the same plugin in the Agent Plugins format for the OpenAI directory; they declare the same server.)

It declares one connection, the Qualia Connect MCP server at https://connect.qualia.com/mcp, operated by Qualia. Everything the plugin sends goes to connect.qualia.com and nowhere else:

| When | What is sent | What comes back |
| --- | --- | --- |
| Signing in | You sign in on Qualia's own pages at connect.qualia.com (the `/mcp/authorize` consent page and the `/mcp/oauth/token` endpoint). The assistant never sees your password. The consent page lists each permission and you choose which to grant. | A token for your account, held by your assistant |
| Looking at your orders (`get_current_user`, `list_orders`, `get_order_details`, `list_title_companies`) | The identifier of the order you ask about and, for lists, paging and filter values such as whether to include closed orders or which state the property is in | Order details, parties, tasks, messages and the list of shared documents, as your account is permitted to see them |
| Reading a document (`get_document`) | The document's identifier | The document's text |
| Sending a message (`send_message`) | The message text you confirmed and the conversation or recipients you chose | Confirmation and a link to the order |
| Placing an order (`place_order`) | The order details you confirmed: title company, property, your role, the parties, price and loan details, and a memo if you wrote one | The new order's number and a link to it |
| Reporting something Connect cannot do (`missing_functionality`) | Your request in your own words and a one-line description of what Connect would need to do. This is the only call that carries your request text, and it goes to Qualia, not to anyone on your orders. | A sentence for the assistant to tell you |

Links the server returns (`connect_url`, `complete_url`) point to pages on connect.qualia.com for you to open yourself; the assistant never fetches them. The other links in this README (qualia.com, login.qualia.com) are for you to read; the plugin sends nothing to them.

Connect keeps a record of each call and its arguments, as it does for actions taken in the Connect app, under Qualia's [privacy policy](https://www.qualia.com/privacy-policy/). The plugin itself stores nothing. The [Connect terms of service](https://www.qualia.com/connect-tos/) apply.

## Install in Claude Code

```
/plugin install qualia-connect --marketplace qualialabs/qualia-connect-agent-plugin
```

## Availability

Connect's assistant connection is in beta. Your Connect account must be enabled for it. Contact your Qualia representative or support@qualia.com.

## Support

The [Qualia knowledge base](https://login.qualia.com/?return_to=knowledge-%2F) covers Connect itself. For the plugin, contact support@qualia.com.
