# Connect Coding Agent to Zoho Mail

Session 14 · Thursday, October 15, 2026

On Tuesday you set up `you@yourdomain.com` and proved it works. Today your agent
gets to read that mailbox and send from it, through an MCP server. The goal is
one message, `Test 04`, sent by the agent from your domain address and received
in your outside mailbox. It takes about 20 minutes and goes before the Google
Analytics work.

## What an MCP server is

Your Railway web service is a program at a URL that answers HTTPS requests with
pages. An MCP server is the same shape, a program at a URL answering HTTPS
requests, but it serves a menu of actions instead of pages. Zoho's lists actions
like "list emails," "search emails," and "send email." Each action is called a
tool. The agent is the client. It asks the server what tools it has, picks one,
and calls it with JSON. MCP is the Model Context Protocol, the shared format for
that conversation, so any agent can talk to any server without a custom
integration.

You've already given your agent three tools this semester: the Azure,
Cloudflare, and Railway CLIs. Those run on your laptop, signed in as you, and
the agent calls them through the terminal. An MCP server runs on the vendor's
side. You sign in to Zoho in your browser once, and Zoho asks whether this
client may act on your mailbox. From then on the agent sends requests to the
server with a token. Your password never reaches the agent or the repo.

Which of the two models would you choose for a service the agent talks to every
day, and why?

## 0. Before you start

- Open your own `career-platform` repository in VS Code, with a new Claude Code
  or Codex session. This is the website project you'll update today. In Claude
  Code, name the session with:

  ```text
  /rename zoho-mcp
  ```

- https://mcp.zoho.com in a tab. Sign in with the same login you use for Zoho
  Mail at your domain.
- [Zoho webmail](https://mail.zoho.com/) and your outside mailbox, Gmail or LMU
  Outlook, in two more tabs.

Start with this guide. When we move to
[Google Analytics](google-analytics.md#start-here-for-class), keep the same
repository open and follow its starting checklist.

If Tuesday's mailbox doesn't receive yet, finish
[sections 2 and 3 of the Zoho guide](domain-email-with-zoho.md#2-prove-you-own-the-domain)
first. The server needs a working mailbox to act on.

## 1. Create the server and choose its tools

1. At https://mcp.zoho.com, click Create MCP Server. Name it
   `coding-agent-mail`. If you already created a server with a different name,
   keep it.
2. Under Add Tools, choose Zoho Mail, then All Tools. Select `getMailAccounts`,
   `getAccountDetails`, `getAllFolders`, `listEmails`, `SearchEmails`,
   `getMessageContent`, and `sendEmail`. Choose individual tools, not whole
   groups, then click Add Now. Skip delete, move, and admin tools.
3. Save, then open the Connect tab. Copy the MCP URL. It has your API key
   embedded in it, so treat it the way you treat a password: it never goes in a
   commit, a chat, or a screenshot.

Zoho lists both account lookup tools as required in its
[tool reference](https://www.zoho.com/mail/help/mcp/zoho-mail-mcp-tools.html).
We include `getAllFolders` to find the Inbox's folder ID, following its
[list emails API guide](https://www.zoho.com/mail/help/api/get-emails-list.html).

## 2. Connect your agent

Choose the client you use. These connections apply across projects for your user
account.

### Claude Code

In a terminal, in your `career-platform` folder, paste the URL into this
command:

```bash
claude mcp add --scope user --transport http zoho-mail "<your MCP URL>"
```

`--scope user` stores the connection in your home folder, outside the repo. In
Claude Code, run:

```text
/mcp
```

Choose `zoho-mail` and authenticate. "Needs authentication" means this step is
still pending.

Zoho first asks you to Allow the MCP connection and its redirect back to your
computer. It then asks for permission to view account information, mail, and
folders, and to create mail. Check the consent box and click Accept. After
"Authentication successful," return to Claude Code and check `/mcp`.

### Codex

With the Codex CLI installed, run:

```bash
codex mcp add zoho-mail --url "<your MCP URL>"
```

Complete browser authentication if it opens. If authentication is still needed,
run:

```bash
codex mcp login zoho-mail
```

Review Zoho's consent screens. The connection is saved in
`~/.codex/config.toml`, shared by Codex clients. Keep it outside the repo.
Restart the Codex extension after adding the server, then check its MCP server
settings. In the terminal version of Codex, use `/mcp` to inspect active
servers.

[OpenAI's MCP guide](https://developers.openai.com/codex/mcp) covers
configuration and authentication. The commands are documentation-checked; the
Zoho connection still needs a live Codex test.

What did you just hand over, and what did you keep? Say it in your own words
before the next step.

## 3. Use it

Two prompts. The first reads, the second writes.

```text
List the subjects and senders of the five most recent messages in my Zoho inbox.
```

Check it against webmail. The agent should see the same five.

```text
Send Test 04 from my domain address to my outside mailbox. Include your agent name, the time, and that you sent it through the Zoho MCP server.
```

Replace "my outside mailbox" with the actual address. Open the outside mailbox
and confirm the message arrived with your domain in From. A reply in the chat
saying it was sent isn't the evidence. The message in the other inbox is.

## 4. Write it down

You may use the Zoho MCP server for the email tests and available authentication
details in [Exercise 06](../exercises/ex06-domain-email.md), due Tuesday,
October 20. Test 04 can serve as your new outgoing message test once you confirm
external receipt. No extra row or written explanation is required. For outgoing
authentication, use results from the outside mailbox, supplying its header to
the agent if needed.

## If something goes wrong

If connection fails, check the copied URL and its quotes. For authentication,
use Claude Code's `/mcp` menu or `codex mcp login zoho-mail`. Zoho may request
Mail authorization on the first tool call. If the URL was exposed publicly,
regenerate its API key in Zoho's Connect tab and update your client.

To disconnect Claude Code:

```bash
claude mcp remove --scope user zoho-mail
```

For Codex, clear its saved OAuth credentials before removing the server:

```bash
codex mcp logout zoho-mail
```

Then remove the server:

```bash
codex mcp remove zoho-mail
```

Restart the client and check that `zoho-mail` is absent. These commands remove
the local connection; review Zoho's account authorizations separately if you
need to revoke provider-side access.
