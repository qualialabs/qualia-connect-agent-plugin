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

## Data

The plugin runs nothing on your computer and bundles no code. It declares one connection, the Qualia Connect MCP server at https://connect.qualia.com/mcp, which signs you in with OAuth to your own Connect account and asks your consent for each permission it uses. Requests carry the identifiers of the order, conversation or document you are asking about, the text of a message you confirmed, the details of an order you confirmed, and, only when the assistant reports something Connect cannot do, your request in your own words. Connect returns order details, tasks, messages and shared documents as your account is permitted to see them. The plugin stores nothing itself.

Qualia's [privacy policy](https://www.qualia.com/privacy-policy/) and the [Connect terms of service](https://www.qualia.com/connect-tos/) apply.

## Install in Claude Code

```
/plugin install qualia-connect --marketplace qualialabs/qualia-connect-agent-plugin
```

## Availability

Connect's assistant connection is in beta. Your Connect account must be enabled for it. Contact your Qualia representative or support@qualia.com.

## Support

The [Qualia knowledge base](https://login.qualia.com/?return_to=knowledge-%2F) covers Connect itself. For the plugin, contact support@qualia.com.
