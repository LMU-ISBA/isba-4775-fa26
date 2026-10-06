# Set up Claude API access

For Job Scout on Tuesday, November 3, 2026. Complete setup by Monday, November 2.

Project 1 doesn't require Claude API access or an API credit purchase.

Job Scout's evaluate step asks a model whether each posting fits you. Your
code makes that call through the Claude API, so you'll need an API account
and a key for that lesson. Plan on about 15 minutes and $5.

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
purchase. Check your remaining balance while developing Job Scout.

## 3. Create an API key

Open Settings, then API keys, and create a key named `job-scout`. Copy it
right away. The Console shows the full key only once, and if you lose it you
delete it and make a new one.

Treat the key like a password. Anyone who has it can spend your credits.

## 4. Store the key where Git can't see it

In your `career-platform` repository on your laptop, ask your agent:

```text
Prepare a local .env file for my Claude API key and keep it out of Git.
```

Paste the key into `.env` yourself as `ANTHROPIC_API_KEY`, never into chat.
Run `git check-ignore .env`, which should print `.env`. Also confirm
`git ls-files .env` prints nothing: the file must not already be tracked.
Fix either failed check before committing.

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

We'll choose on November 3, in class. Models and prices change often enough
that a choice made now could be out of date by then. Keep the model list from
step 5, and look at the current prices before class:
https://platform.claude.com/docs/en/about-claude/pricing

You'll explain the choice in your engineering record, so think about what
matters for Job Scout. One run scores dozens of postings, and you'll rerun it
many times while you debug. A cheaper model gives you more runs, and a more
capable one may judge a borderline posting better.

## If something goes wrong

Send me a Teams message by November 2 if your card is declined, the
Billing page doesn't appear, or step 5 keeps failing. Don't switch
to a different paid plan to get around it. Include what you tried, so we can
fix it before class.
