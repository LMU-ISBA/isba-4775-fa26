# Exercise 01: Accounts and development environment

**Due** Tue 9/8, before class · **15 points** · **Type:** Config ·
**Submit** as `ex01/` in your public portfolio repository, plus one file on Brightspace

## Why this one is first

Everything you build this semester sits on the accounts and tools you set up
here. The site in Exercise 03, the domain in Exercise 04, the orchestration in
Exercise 07, the agent in Exercise 09, and both projects all assume this
exercise worked. A step you skip now is a step you debug in week five, in the
middle of something else.

Config exercises normally open with a written plan, and this one doesn't. Steps
2 and 3 already list every account and what it's for, so a plan here would copy
the brief back to me. Planning starts in Exercise 02 with a PRD. The first real Config plan is
Exercise 04, where delegating a domain has actual choices in it.

## Before you start

Read the budget table under Required materials in the
[syllabus](../syllabus.md). This is the week most of the semester's costs land,
so know what's coming before you subscribe to anything.

Set up your portfolio repository first if you haven't already. One public
repository named `isba-4775-portfolio`, one folder per exercise, `ex01` through
`ex10`. Step-by-step instructions are in
[portfolio-repository.md](../portfolio-repository.md).

## The work

### 1. Install a password manager before you create anything.

You'll create eleven accounts across this course, starting with five today.
Reusing one password across them turns a single breach into eleven. This is the
week it would happen, because inventing a strong password eleven times over is
miserable and nobody does it.

Bitwarden's free tier covers everything this course needs. 1Password is also
good, and it's worth checking whether it's included in your GitHub Student
Developer Pack. The one built into your browser or operating system counts, as
long as you actually use it.

Put your GitHub password in it today, along with your GitHub two-factor
recovery codes. Those codes are the thing people lose. Losing them locks you out
of the repository holding every exercise you have submitted.

You'll name the one you chose in your README.

### 2. Create or verify these accounts now.

| Account | Notes |
|---|---|
| GitHub | Your portfolio repository lives here |
| GitHub Student Developer Pack | Apply on day one. Verification takes a few days, and it covers a .me domain for a year and credits on Railway |
| Claude Pro | Subscribe. You need it for the interview below and for Exercise 02 |
| Granola | Part of the tutorial in step 4, and it connects to Claude Code over MCP |
| Wispr Flow | Part of the tutorial in step 4. Dictation, and you configure it during setup |

### 3. Leave these for the exercise that uses them.

Creating an account starts its clock, and a trial you burn in September is
gone by the time you need it. Note these in your plan, then create them later.

| Account | When | Notes |
|---|---|---|
| Railway | Exercise 03 | The 30-day trial starts on signup, so starting it now wastes two weeks of it |
| AWS | Exercise 04 | Choose the Free plan, which runs six months and then closes the account. Note the closing date when you create it. Start the account a few days before you start Exercise 04, because identity verification can lag |
| Zoho Mail | Exercise 06 | Free plan, and it needs a domain you don't own until Exercise 04 |
| Resend | Exercise 06 | Free tier, and it also needs your domain verified |
| Google Cloud | Exercise 07 | Create a project and attach billing. Use a personal Google account, because school and corporate accounts often cannot attach billing. Places API runs on its own free cap rather than the 90-day trial credit |
| Firecrawl | Exercise 07 | Free tier, 1,000 credits a month |

### 4. Complete Tutorial Part 1.

[LMU-ISBA/ai-dev-workflow-tutorial](https://github.com/LMU-ISBA/ai-dev-workflow-tutorial)
installs Git, Python 3.11+, Claude Code, and Cursor. It also sets up the
Superpowers plugin and the Granola connection, and it has you fork and clone the
tutorial repository.

### 5. Verify every tool actually runs.

Installed is not the same as running. Open your terminal and confirm that each
one actually runs on your machine.

### 6. Run the self-discovery interview.

[`self-discovery-interview.md`](../self-discovery-interview.md) in this repository is a
prompt you paste into Claude. It interviews you, one question at a time, for about fifteen
minutes, and writes a Markdown file at the end. Answer honestly rather than impressively.
Nothing in it is graded and nothing in it is compared against anyone else.

Two people with the same prerequisite walk into this course having deployed nothing and
having run a side project on AWS for a year. Both are normal. This is how I find out which
one you are, so I can teach you rather than the room's average.

Your portfolio repository is public, and this file has your career plans in it. So it
goes on Brightspace rather than into your repository. Noticing that those two don't belong
together is itself the kind of judgment this course is about.

## What to commit

Two files in `ex01/`. Most exercises want three, and the missing one is
`plan.md`, for the reason at the top of this brief.

`verify.txt` holds pasted terminal output, as text, not screenshots. Nothing in
this course is verified by screenshot, because you cannot diff a screenshot.
Include:

- `git --version`, `claude --version`, and `python3 --version` on macOS or
  `python --version` on Windows
- `git config --list`, showing your name and email
- `claude mcp list`, showing granola
- Your fork, at `github.com/your-username/ai-dev-workflow-tutorial`

`README.md` opens with two lines. The first names the password manager you
installed and confirms that your GitHub password and your two-factor recovery
codes are in it. The second confirms that Cursor, Granola, Wispr Flow, and the
Superpowers plugin are all installed and working, because none of those four
leave terminal output you can paste.

The rest of it is your evidence README: what broke while you were doing this and
how you fixed it. Something will break. Account verification and billing setup
fail in ordinary, annoying ways, and writing down what you did about it is the
beginning of the troubleshooting practice this course grades. If genuinely
nothing broke, say what you expected to break and did not.

End the README with "The change," below.

## The change

Answer in two or three sentences: what breaks, what you would do about it, what
it costs.

> Your GitHub Student Developer Pack application is rejected because the photo of
> your student ID is unreadable, and reapplying takes another four days.
> Exercise 03 needs the Railway credits in two weeks.

## Done means

- [ ] A password manager installed, holding your GitHub password and two-factor recovery codes
- [ ] All five accounts in step 2 created, with two-factor turned on for GitHub
- [ ] Tutorial Part 1 complete, every tool running on your machine
- [ ] `ex01/verify.txt` with real terminal output and your fork URL
- [ ] `ex01/README.md` naming your password manager, confirming the four tools, what broke, and "The change" answered
- [ ] Self-discovery interview completed and the Markdown file submitted **on Brightspace**
- [ ] Your repository URL submitted **on Brightspace**
- [ ] Pushed to your public portfolio repository before class Tue 9/8

## If you get stuck

Student Developer Pack verification takes several days, and applications get
rejected for an unreadable photo of a student ID. That is the reason to apply on
day one rather than on the due date.

If Claude Code lands in an authentication loop, run `claude logout`, then
`claude login`.

If you're still stuck, post in the course Teams channel. Being stuck is normal,
and being stuck quietly until the due date is the problem.
