# Your first model call

Session 21 · Thursday, November 12, 2026

Your Project 02 agent will ask a model to do the job's repeated work. Today
you'll get real data for your posting and send one record to a model by hand.
You'll see what a model call is before your code makes one. Today doesn't use
AWS.

## Today's objectives

By the end of class, you'll have:

- About 20 real records for your posting, saved with their source and date.
- A working model API key.
- Three calls on one of your records: a default question, your own question,
  and your question answered as JSON.

## Learning objectives

By the end of this lesson, you should be able to:

- Name the parts of a request to a model API: the address, the headers, and
  the body.
- Find the answer, the token counts, and the stop reason in a response.
- Work out what one call cost.
- Explain how asking for JSON changes the request and the response.
- Say what your own question found that a default question missed.

## 1. Check your posting

Open your comparison page in `research/wiki/`. Your choice and your reason
should be at the top. If you haven't chosen, choose now. You can switch among
your three postings until Tuesday, November 17.

## 2. Get real data

Your agent needs real records to work on. The
[Project 02 requirements](../projects/project-02.md#data) give the order to
look in: an API or open data first, then public pages whose terms allow
scraping. A CSV you can download counts. An employer's private data doesn't.

Ask your agent:

```text
Find real data for my chosen posting. Look for an API, open data, or a
CSV I can download first. Show me three sources with the row count and
why each fits. Then stop.
```

Pick one and check that the records are real and not generated. Then ask:

```text
Collect about 20 real records from that source and leave out personal
data. Save them with the source and today's date, add the source to the
wiki, and stop.
```

Open the file and read three records. Each one should be real, and it should
be something the job's repeated question could be asked about.

If the source doesn't work, try these in order:

1. Another of the three sources, or the one named in your comparison page.
2. An open data portal for the posting's industry, such as data.gov, BLS,
   Census, SEC EDGAR, FRED, CMS, or LA Open Data.
3. A dataset on Kaggle or Hugging Face. Skip teaching sets such as Titanic
   and Iris.
4. Real records from the same industry, if the company's own aren't public.
5. Another of your three postings.

Commit and push.

## 3. Set up your API key

Follow the [Claude API setup](claude-api-access.md), sections 1 through 5.
You're done when step 5 lists the available models. Keep that list.

The key goes in `.env` and never in chat. If you chose another provider, set
up its key the same way and give your agent that provider's docs in section 4.

## 4. Send one record to the model

The posting makes you responsible for one job. Write the question that
person would ask of a record, as one sentence. Your comparison page names it.
Pick a model from your list in step 5. If your data is a CSV, one record is
the header line and one row.

Start with the rules for today's calls:

```text
Today I'm sending model calls with curl to see how they work. Load my
key from .env in the shell. Never open .env, print the key, or use
verbose mode. Save each request body and each raw response as a file,
and show each command with one flag per line.
```

Send a default question first. It's the one anyone could ask:

```text
Read the API docs first:
https://platform.claude.com/docs/en/api/messages/create

Send one record from my data to [model] and ask: What do you see in
this record? Show me the command you ran, then stop.
```

Read the files yourself. Your agent's summary of the call isn't the call.

In the command, find:

- The address the request went to.
- The header that carries your key. It should show a variable name and not
  the key.
- The version header. Its date sets the format of the request and the
  response. It isn't the model, and it isn't today's date.

In the request file, find:

- The model.
- The question.
- Your record.

In the response file, find:

- The answer.
- `input_tokens` and `output_tokens`.
- `stop_reason`.

If your key appears anywhere outside `.env`, delete it in the Console and
make a new one. Section 3 of the [Claude API setup](claude-api-access.md)
shows where.

Now ask your own question:

```text
Send the same record again and ask: [your question]. Save the request
and response beside the first ones.
```

Compare the two answers. The first is what anyone gets from this record.
What did your question find that the first one missed?

Now work out what each call cost. Prices are per million tokens:
https://platform.claude.com/docs/en/about-claude/pricing

```text
cost = input tokens  x input price  / 1,000,000
     + output tokens x output price / 1,000,000
```

## 5. Ask for JSON

A sentence is easy for you to read and hard for code to use. Name the fields
a good answer has, such as `product` and `issue`. Then ask:

```text
Read the structured outputs docs first:
https://platform.claude.com/docs/en/build-with-claude/structured-outputs

Send the same record and my question again, and ask for JSON with
these fields: [your fields]. Save the new request and response beside
the others.
```

Compare this request and response with the ones for your question. What did
the request add? How did the answer change?

Check each field against the record yourself. Then work out this call's cost
and compare it with the others.

Is this an agent yet? Say why in your own words. We'll come back to it on
Tuesday, when the model chooses a tool.

Check that no file holds your key, then commit and push.

## 6. Due Tuesday, November 17, at 1:45 PM

M1 is due, and the
[Project 02 requirements](../projects/project-02.md#dates) list it in full.
It's graded when it's due, and it counts for 60 of the project's 300 points.

- Your PRD, your data source, and your next-step posting.
- Two architectures with cost estimates, your choice, and your reason.
- A diagram of the design you chose.
- Your repository renamed for your system, with me invited as a collaborator.
- Your repository URL, submitted in the Project 02 M1 assignment in Brightspace.

Keep building after you submit. I'll read your design and tell you by
Thursday, November 19, if something has to change.

Sections 2 through 5 are Exercise 08, due at the same time. It's credit/no
credit, and I check it in your Project 02 repository: your records, and the
request and response files for all three calls. If you didn't get a record or a
call in class, finish those sections first.

Start the PRD with an interview:

```text
Interview me to write a PRD for my Project 02 system: who uses it, what
it does, and what it leaves out. Ask one question at a time.
```

Then ask for two designs:

```text
Design two AWS architectures for this PRD that differ in a way that
matters. For each, give a diagram, a monthly cost estimate, what it
makes easy, and what it makes hard.
```

Write the choice and the reason yourself. Say what you gave up.

The idea behind today's first two calls comes from Dan Shipper's talk on
human work after automation. It's optional, and the part to watch runs from
10:18 to 19:30: https://www.youtube.com/watch?v=WstNofgQF5Q
