# Set up Claude API access

Before class on Tuesday, October 13, 2026

On October 13 we start building Job Scout, and its evaluate step asks a model
whether each posting fits you. Your code makes that call through the Claude
API, so you need an API account and a key before class. Plan on about 15
minutes and $5.

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

Leave auto-reload off. With it off, the most you can ever spend is what you
bought. If a bug sends your agent into an endless loop, it stops when the
credits run out, and your card isn't charged again. We'll break an agent
this way on purpose later in the semester.

## 3. Create an API key

Open Settings, then API keys, and create a key named `job-scout`. Copy it
right away. The Console shows the full key only once, and if you lose it you
delete it and make a new one.

Treat the key like a password. Anyone who has it can spend your credits.

## 4. Store the key where Git can't see it

In your `career-platform` repository on your laptop, ask your agent:

```text
Add ANTHROPIC_API_KEY to a .env file at the root of this repository, and
make sure .gitignore lists .env. I'll paste the key into the file myself.
Then run git check-ignore .env and show me the result.
```

Paste the key into `.env` yourself rather than into the chat. The check
should print `.env`, which means Git ignores the file. If it prints nothing,
stop and fix `.gitignore` before you commit anything.

## 5. Check that the key works

Ask your agent:

```text
Read ANTHROPIC_API_KEY from .env without printing it. Call
GET https://api.anthropic.com/v1/models with the headers x-api-key and
anthropic-version: 2023-06-01. Show me the HTTP status code and the list of
model IDs, and nothing else from the response.
```

You should see status 200 and a list of model IDs. A 401 means the key is
wrong or incomplete, so copy it again. Listing models doesn't use credits, so
you can run this check as often as you like.

## Which model you'll use

We'll choose on October 13, in class. Models and prices change often enough
that a choice made now could be out of date by then. Keep the model list from
step 5, and look at the current prices before class:
https://platform.claude.com/docs/en/about-claude/pricing

You'll explain the choice in your engineering record, so think about what
matters for Job Scout. One run scores dozens of postings, and you'll rerun it
many times while you debug. A cheaper model gives you more runs, and a more
capable one may judge a borderline posting better.

## If something goes wrong

Send me a Teams message before October 13 if your card is declined, the
Billing page doesn't appear, or step 5 keeps failing. Don't switch
to a different paid plan to get around it. Include what you tried, so we can
fix it before class.
