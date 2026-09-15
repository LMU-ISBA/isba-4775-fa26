# Exercises

Ten exercises, 15 points each, 150 points total. Each brief is published here
ahead of its due date. Read course materials on GitHub, and use the relevant
class guide to open the course Codespace or your portfolio Codespace.

Starting with Exercise 03, your work goes in your own public portfolio repository,
one folder per exercise, `ex03` through `ex10`. Set it up following
[portfolio-repository.md](../guides/portfolio-repository.md).

Exercise 01 is submitted entirely through Brightspace: the
[self-discovery interview](self-discovery-interview.md) and the photo of your
home network drawing. They go there because your portfolio repository is
public and both files are about you rather than about a system. Anything that
goes to Brightspace is named with what it is, then your first name, then your
last name: `home-network-firstname-lastname.jpg`, `self-discovery-firstname-lastname.md`.

Exercise 02 is also submitted through Brightspace as two separate files:
`service-diagram-firstname-lastname.jpg` and
`service-investigation-firstname-lastname.pdf`. Write the report in Google Docs
and download it as a PDF. Follow the [Exercise 02 brief](ex02-troubleshoot-a-cloud-service.md)
for the full instructions.

## Sequence

| # | Exercise | Type | Due | Brief |
|---|---|---|---|---|
| 01 | Accounts, your home network, and the self-discovery interview | Config | Tue 9/8 | [published](ex01-accounts-and-dev-env.md) |
| 02 | Troubleshoot a cloud service: Nginx and MySQL | Troubleshoot | See Brightspace | [published](ex02-troubleshoot-a-cloud-service.md) |
| 03 | The AI-assisted workflow: scope being revised | Build | To be announced | [earlier draft](ex03-ai-assisted-workflow-draft.md) |
| 04 | Domain delegated to Route 53, live with TLS | Config | Thu 9/24 | |
| 05 | **Broken DNS/TLS: diagnose and fix** | Troubleshoot | Thu 10/1 | |
| 06 | Mailbox email with SPF, DKIM, DMARC; Resend verified | Config | Thu 10/8 | |
| 07 | First orchestration: trigger, API call, notification | Build | Thu 10/15 | |
| 08 | **Broken integration: expired credential, changed schema** | Troubleshoot | Tue 10/20 | |
| 09 | Raw agent loop in Python, three tools, evals, trace read | Build | Thu 11/5 | |
| 10 | **Broken agent: bad tool schema, runaway loop, cost blowup** | Troubleshoot | Thu 11/12 | |

Ex03's final scope and deadline are being revised. Session 5 builds the first
version of your Project 1 personal site, a resume page read from MySQL, in
`site/` of your portfolio. Follow the
[build-along](../guides/database-to-application.md), with setup in the
[portfolio guide](../guides/portfolio-repository.md). This doesn't assign the
earlier dashboard tutorial. Railway deployment and GA4 remain Project 1
requirements. Confirm deadlines in Brightspace.

## What every exercise needs

1. A working system, verified live rather than by screenshot.
2. A specification and implementation plan, scaled to the exercise, written
   before the work.
3. An evidence README recording what broke, how you fixed it, and your answer to
   that exercise's "The change" prompt.

"The change" is a scenario handed to you after your work is done. You answer it
in two or three sentences rather than build for it: what breaks, what you would
do about it, and what that costs.

Missing any one of the three means no credit. Exercise 01 is the exception. It
has no plan, no system, and no README, because nothing gets built yet, and its
two files go to Brightspace.

Section "Exercises, 150 points" of the [syllabus](../syllabus.md) has the full
rules.
