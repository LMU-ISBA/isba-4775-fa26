# Exercise 01: Accounts and development environment

**Due** Tue 9/8, before class · **15 points** · **Type:** Config ·
**Submit** as `ex01/` in your public portfolio repository, plus one file on Brightspace

## Why this one is first

Everything you build this semester sits on the accounts and tools you set up
here. The site in Exercise 03, the domain in Exercise 04, the orchestration in
Exercise 07, the agent in Exercise 09, and both projects all assume this
exercise worked. A step you skip now is a step you debug in week five, in the
middle of something else.

This is also a Config exercise, which means the plan matters as much as the
result. You write down what you are going to set up and why before you open a
console. That habit is the whole point of the type.

## Before you start

Read the budget table under Required materials in the
[syllabus](../syllabus.md). This is the week most of the semester's costs land,
so know what is coming before you subscribe to anything.

Set up your portfolio repository first if you have not already. One public
repository, one folder per exercise, named `ex01` through `ex10`.

## The work

**1. Write the plan before you touch a console.**

A Config plan is short. List every account you are about to create, what each
one is for later in the course, and which of them costs money. Two or three
sentences on the AWS decision specifically: why you are creating an IAM user
instead of working as root.

One thing to know before you sign up for AWS. Accounts created since July 2025
choose between a Free plan and a Paid plan. The Free plan gives you credits for
six months and then closes the account, which would take your hosted zone and
your domain's DNS with it. Choose the Paid plan. You still get the signup
credits, and the free tier limits still apply, so the practical difference is
that the account survives past March and stays on your resume.

**2. Create or verify these accounts.**

| Account | Notes |
|---|---|
| GitHub | Your portfolio repository lives here |
| GitHub Student Developer Pack | Apply on day one. Verification takes a few days, and it covers a .me domain for a year and credits on Railway |
| Railway | Start the 30-day trial |
| AWS | Choose the Paid plan, not the Free plan. Turn on MFA for the root user, then create an IAM user for daily work |
| Google Cloud | Create a project and attach billing. You enable the Places API later |
| Claude Pro | Subscribe |
| Zoho Mail | Free plan |
| Resend | Free tier |
| Firecrawl | Free tier, 500 credits |

**3. Complete Tutorial Part 1.**

[LMU-ISBA/ai-dev-workflow-tutorial](https://github.com/LMU-ISBA/ai-dev-workflow-tutorial)
installs Python 3.11+, Git, VS Code, uv, and Claude Code, and walks you through
authenticating Claude Code.

**4. Verify every tool actually runs.**

Not that it installed. That it runs, on your machine, from your terminal.

**5. Run the self-discovery interview.**

[`self-discovery-interview.md`](../self-discovery-interview.md) in this repository is a
prompt you paste into Claude. It interviews you, one question at a time, for about twenty
minutes, and writes a Markdown file at the end. Answer honestly rather than impressively;
nothing in it is graded and nothing in it is compared against anyone else.

Two people with the same prerequisite walk into this course having deployed nothing and
having run a side project on AWS for a year. Both are normal. This is how I find out which
one you are, so I can teach you rather than the room's average.

**The file goes on Brightspace, not in your portfolio repository.** Your portfolio
repository is public. This file has your career plans in it. Those two facts do not belong
together, and noticing that is itself the kind of judgment this course is about.

## What to commit

Three files in `ex01/`, matching the three things every exercise needs for
credit.

`plan.md` holds the plan from step 1, committed before the work. Push it as its
own commit so the timestamps show it came first. This is the part people skip,
and it is the part the course is actually teaching.

`verify.txt` holds pasted terminal output, as text, not screenshots. Nothing in
this course is verified by screenshot, because you cannot diff a screenshot.
Include:

- `python --version`, `git --version`, `uv --version`, `claude --version`
- `git config user.name` and `git config user.email`
- Your AWS IAM user ARN and account alias, copied from the console
- Your Google Cloud project ID
- Your Railway project URL
- Your GitHub profile URL

`README.md` is your evidence README: what broke while you were doing this and
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

- [ ] `ex01/plan.md` committed before the account work, in its own commit
- [ ] All eight accounts created, MFA on the AWS root user, an IAM user for daily work
- [ ] Tutorial Part 1 complete, every tool running on your machine
- [ ] `ex01/verify.txt` with real terminal output and your account identifiers
- [ ] `ex01/README.md` with what broke, how you fixed it, and "The change" answered
- [ ] Self-discovery interview completed and the Markdown file submitted **on Brightspace**
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
