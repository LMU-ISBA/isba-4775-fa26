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
the brief back to me. Planning starts in Exercise 02 with a PRD, and the first
real Config plan is Exercise 04, where delegating a domain has actual choices in
it.

## Before you start

Read the budget table under Required materials in the
[syllabus](../syllabus.md). This is the week most of the semester's costs land,
so know what is coming before you subscribe to anything.

Set up your portfolio repository first if you have not already. One public
repository named `isba-4775-portfolio`, one folder per exercise, `ex01` through
`ex10`. Step-by-step instructions are in
[portfolio-repository.md](../portfolio-repository.md).

## The work

**1. Install a password manager before you create anything.**

You are about to make eight accounts in one week. Reusing a password across them
turns one breach into eight, and this is exactly the week it would happen,
because inventing a strong password eight times in a row is miserable and nobody
does it.

Bitwarden's free tier covers everything this course needs. 1Password is also
good, and it's worth checking whether it's included in your GitHub Student
Developer Pack. The one built into your browser or operating system counts, as
long as you actually use it.

Three things go into it as you work through the rest of this exercise: your AWS
root password, your IAM user credentials, and your AWS MFA recovery codes.
Losing any of those in November is a real problem, because Exercise 08 is a
troubleshoot exercise and it doesn't care that you can't log in.

You'll name the one you chose in your README.

**2. Create or verify these accounts now.**

One thing to know before you sign up for AWS. Accounts created since July 2025
choose between a Free plan and a Paid plan. Choose the Free plan. You get
credits at signup, the free tier limits apply on top of them, and nothing this
course asks you to build will cost you AWS money.

The catch is a clock. The Free plan runs six months and then the account closes,
which takes your hosted zone and your domain's DNS with it. Sign up in early
September and that lands in early March, months after this course ends and right
when you're using the site to get hired. Upgrading to the Paid plan any time
before then keeps the account and everything in it.

So write the closing date in your `README.md`, and set a calendar reminder for
two weeks before it. Do that today rather than in March, when you won't be
thinking about this course.

| Account | Notes |
|---|---|
| GitHub | Your portfolio repository lives here |
| GitHub Student Developer Pack | Apply on day one. Verification takes a few days, and it covers a .me domain for a year and credits on Railway |
| Claude Pro | Subscribe. You need it for the interview below and for Exercise 02 |
| AWS | Choose the Free plan, and note the date it closes. Turn on MFA for the root user, then create an IAM user for daily work |

**3. Leave these for the exercise that uses them.**

Creating an account starts its clock, and a trial you burn in September is
gone by the time you need it. Note these in your plan, then create them later.

| Account | When | Notes |
|---|---|---|
| Railway | Exercise 03 | The 30-day trial starts on signup, so starting it now wastes two weeks of it |
| Zoho Mail | Exercise 06 | Free plan, and it needs a domain you don't own until Exercise 04 |
| Resend | Exercise 06 | Free tier, and it also needs your domain verified |
| Google Cloud | Exercise 07 | Create a project and attach billing. Places API runs on its own free cap rather than the 90-day trial credit |
| Firecrawl | Exercise 07 | Free tier, 1,000 credits a month |

**4. Complete Tutorial Part 1.**

[LMU-ISBA/ai-dev-workflow-tutorial](https://github.com/LMU-ISBA/ai-dev-workflow-tutorial)
installs Python 3.11+, Git, VS Code, uv, and Claude Code, and walks you through
authenticating Claude Code.

**5. Verify every tool actually runs.**

Not that it installed. That it runs, on your machine, from your terminal.

**6. Run the self-discovery interview.**

[`self-discovery-interview.md`](../self-discovery-interview.md) in this repository is a
prompt you paste into Claude. It interviews you, one question at a time, for about fifteen
minutes, and writes a Markdown file at the end. Answer honestly rather than impressively;
nothing in it is graded and nothing in it is compared against anyone else.

Two people with the same prerequisite walk into this course having deployed nothing and
having run a side project on AWS for a year. Both are normal. This is how I find out which
one you are, so I can teach you rather than the room's average.

**The file goes on Brightspace, not in your portfolio repository.** Your portfolio
repository is public. This file has your career plans in it. Those two facts do not belong
together, and noticing that is itself the kind of judgment this course is about.

## What to commit

Two files in `ex01/`. Most exercises want three, and the missing one is
`plan.md`, for the reason at the top of this brief.

`verify.txt` holds pasted terminal output, as text, not screenshots. Nothing in
this course is verified by screenshot, because you cannot diff a screenshot.
Include:

- `python --version`, `git --version`, `uv --version`, `claude --version`
- `git config user.name` and `git config user.email`
- Your AWS IAM user ARN and account alias, copied from the console
- Your Google Cloud project ID
- Your Railway project URL
- Your GitHub profile URL

`README.md` opens with two lines. Name the password manager you installed, and
confirm that your AWS root password, your IAM user credentials, and your MFA
recovery codes are in it. Then give the date your AWS Free plan closes.

The rest of it is your evidence README: what broke while you were doing this and
how you fixed it. Something will break. Account verification and billing setup
fail in ordinary, annoying ways, and writing down what you did about it is the
beginning of the troubleshooting practice this course grades. If genuinely
nothing broke, say what you expected to break and did not.

End the README with "The change," below.

## The change

Answer in two or three sentences: what breaks, what you would do about it, what
it costs.

> Your AWS account is flagged for identity verification the day after you create
> it and stays unusable for 72 hours. Exercise 04 needs Route 53 in three weeks.

## Done means

- [ ] A password manager installed, holding your AWS root password, IAM credentials, and MFA recovery codes
- [ ] All eight accounts created, MFA on the AWS root user, an IAM user for daily work
- [ ] Tutorial Part 1 complete, every tool running on your machine
- [ ] `ex01/verify.txt` with real terminal output and your account identifiers
- [ ] `ex01/README.md` naming your password manager, the AWS closing date, what broke, and "The change" answered
- [ ] Self-discovery interview completed and the Markdown file submitted **on Brightspace**
- [ ] Your repository URL submitted **on Brightspace**
- [ ] Pushed to your public portfolio repository before class Tue 9/8

## If you get stuck

School and corporate Google accounts often cannot attach a billing account. Use
a personal Google account for the Cloud project.

AWS identity verification can lag account creation by hours, which is the reason
for this exercise's curveball and a reason not to start it at 11 PM on the due
date.

If Claude Code lands in an authentication loop, run `claude logout`, then
`claude login`.

Still stuck, post in the course Teams channel. Being stuck is normal. Being
stuck quietly until the due date is the problem.
