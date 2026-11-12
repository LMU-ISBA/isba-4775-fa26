# Set up Claude API access

For Project 02's first model call on Thursday, November 12, 2026. We set
this up together in class.

Your Project 02 agent asks a model to do the job's repeated work. Your code
makes that call through a model API, so you'll need an API account and a key.
Class demos use the Claude API, and this guide sets that up. Plan on about 15
minutes and $5.

You can choose another provider for your project. If you already have, set up
its key the same way and follow sections 4 and 5 with its names.

Your Claude Pro subscription doesn't cover this. Pro pays for the Claude app
and Claude Code, and the API is billed separately through prepaid credits:
https://support.claude.com/en/articles/9876003

## 1. Create a Console account

Go to https://platform.claude.com and sign up. Using the same email as your
Claude Pro account is fine, but the Console keeps its own billing.

## 2. Buy credits and leave auto-reload off

Open Settings, then Billing, and click "Buy credits." Buy $5, or the smallest
amount the page allows if that's higher. Credits are available right away,
they expire a year after purchase, and they can't be refunded.

Leave auto-reload off so an accidental loop cannot trigger another credit
purchase. Check your remaining balance while you build your agent.

## 3. Create an API key

Open Settings, then API keys, and create a key named `project-02`. Copy it
right away. The Console shows the full key only once, and if you lose it you
delete it and make a new one.

Treat the key like a password. Anyone who has it can spend your credits.

## 4. Store the key where Git can't see it

In your `project-02` repository on your laptop, ask your agent:

```text
Prepare a local .env file for my Claude API key and keep it out of Git.
```

Paste the key into `.env` yourself as `ANTHROPIC_API_KEY`, never into chat.
Run `git check-ignore .env`, which should print `.env`. Also confirm
`git ls-files .env` prints nothing: the file must not already be tracked.
Fix either failed check before committing.

Keep the key in `.env` only. If you export it in your shell profile, Claude
Code can switch from your subscription to API billing, and the Indeed
connector stops loading.

## 5. Check that the key works

Ask your agent:

```text
List the available Claude models using my local key. Never print the key.
```

Use the [Models API](https://platform.claude.com/docs/en/api/models/list),
which lists models without generating a paid response. You should see status
200 and model IDs. A 401 means authentication failed. Recheck the saved key
and request setup without exposing the key in output or screenshots.

## Which model you'll use

You'll choose in class, when you send your first call. Keep the model list
from step 5, and look at the current prices:
https://platform.claude.com/docs/en/about-claude/pricing

You'll explain the choice in your decision record, so think about what
matters for your agent. You'll run it many times while you debug, and again
for every eval case. A cheaper model gives you more runs, and a more capable
one may handle a borderline case better.

## If something goes wrong

Tell me in class if your card is declined, the Billing page doesn't appear,
or step 5 keeps failing. Don't switch to a different paid plan to get around
it. If you're finishing at home, send me a Teams message with what you
tried.
