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

If you're on a Max, Ultra, or Team plan, it includes monthly API credits. You
can claim those in place of the $5:
https://support.claude.com/en/articles/17154008

## 1. Create a Console account

Go to https://platform.claude.com and sign up. Using the same email as your
Claude Pro account is fine, but the Console keeps its own billing.

## 2. Buy credits and leave auto-reload off

Open Spending, then Billing & payments, and click "Buy credits." The dialog
starts on $100, so choose "Other" and enter 5, which is the minimum. Credits
are available right away, they expire a year after purchase, and they can't
be refunded.

Auto-reload starts off. Leave it off so an accidental loop cannot trigger
another credit purchase. Check your remaining balance while you build your
agent.

## 3. Create an API key

Open Keys & access, then API keys, and click "Create key." When it asks
where your code runs, choose "Somewhere else." That's the option that gives
you a key.

Name the key `project-02`. Change "Expires" from 30 days to "Custom," and
pick a date after December 17. A 30-day key stops working on December 12,
before your final interview.

Copy the key right away. The Console shows the full key only once, and if
you lose it you delete it and make a new one.

Treat the key like a password. Anyone who has it can spend your credits.

## 4. Store the key where Git can't see it

In your `project-02` repository on your laptop, ask your agent:

```text
Prepare a local .env file for my Claude API key and keep it out of Git.
```

Paste the key into `.env` yourself as `ANTHROPIC_API_KEY`, never into chat.
Save the `.env` file. Then ask your agent:

```text
Run git check-ignore .env and git ls-files .env without opening .env.
The first should print .env and the second nothing. Fix either failed
check before committing.
```

Keep the key in `.env`, excluded from Git. You may also save it in your
password manager. Never paste it into chat, source code, or documentation.
If you export it in your shell profile, Claude Code can switch from your
subscription to API billing, and the Indeed connector stops loading.

## 5. Check that the key works

Ask your agent:

```text
Read the Models API docs first:
https://platform.claude.com/docs/en/api/models/list

List the available Claude models using my key from .env. Load it in the
shell. Never open .env, print the key, or use verbose mode.

Show their model IDs and standard input and output prices in USD per
million tokens from this page. Mark any price you can't verify.
https://platform.claude.com/docs/en/about-claude/pricing
```

The Models API lists models without generating a paid response. Prices come
from the separate pricing page. You should see status 200 and model IDs.
A 401 means authentication failed. Recheck the saved key and request setup
without exposing the key in output or screenshots.

## Which model you'll use

You'll choose in class, when you send your first call. Keep the model list
and prices from step 5. Check your chosen model's prices against the linked
pricing page.

You'll explain the choice in your decision record, so think about what
matters for your agent. You'll run it many times while you debug, and again
for every eval case. A cheaper model gives you more runs, and a more capable
one may handle a borderline case better.
