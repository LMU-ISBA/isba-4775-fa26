# Exercises

Ten exercises, 15 points each, 150 points total. Each brief is published here
ahead of its due date. Read course materials on GitHub, and use the relevant
class guide for each lab.

Starting with Exercise 03, your work goes in your public `career-platform`
repository, the one you've built since September 15. Each exercise adds an
evidence file, `docs/evidence/ex03.md` through `docs/evidence/ex10.md`, and you
submit the repository URL in Brightspace.

Exercise 01 is submitted entirely through Brightspace: the
[self-discovery interview](self-discovery-interview.md) and the photo of your
home network drawing. They go there because your `career-platform` repository is
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
| 02 | Troubleshoot a cloud service: Nginx and MySQL | Troubleshoot | Tue 9/15 | [published](ex02-troubleshoot-a-cloud-service.md) |
| 03 | Build it, then move it: spec, plan, and migration plan | Build | Thu 10/1, 1:45 PM | [published](ex03-build-and-migrate.md) |
| 04 | Domain delegated to Cloudflare DNS, live with HTTPS | Config | Thu 10/8 | |
| 05 | **Broken DNS/TLS: diagnose and fix** | Troubleshoot | Thu 10/15 | |
| 06 | Email DNS: Email Routing MX, and SPF, DKIM, and DMARC for Resend | Config | Tue 10/13 | |
| 07 | Job Scout's first loop: tools, state, stop conditions, and a real run | Build | Tue 10/20 | |
| 08 | **Broken integration: an expired credential and a changed schema in Job Scout** | Troubleshoot | Tue 10/20 | |
| 09 | Raw agent loop in Python, three tools, evals, trace read | Build | Thu 11/5 | |
| 10 | **Broken agent: bad tool schema, runaway loop, cost blowup** | Troubleshoot | Thu 11/12 | |

Exercise 03 collects the spec, implementation plan, and migration plan from
the resume-site build and the Azure migration. The Railway migration is a
Project 1 requirement, and GA4 is an optional extension. Confirm deadlines in
Brightspace.

## What every exercise needs

1. A working system, verified live rather than by screenshot.
2. A specification and implementation plan, scaled to the exercise, written
   before the work.
3. An evidence file, `docs/evidence/exNN.md`, recording what broke, how you
   fixed it, and your answer to that exercise's "The change" prompt.

"The change" is a scenario handed to you after your work is done. You answer it
in two or three sentences rather than build for it: what breaks, what you would
do about it, and what that costs.

Missing any one of the three means no credit. Exercise 01 is the exception. It
has no plan, no system, and no README, because nothing gets built yet, and its
two files go to Brightspace.

Section "Exercises, 150 points" of the [syllabus](../syllabus.md) has the full
rules.
