# Exercises

Ten exercises, 15 points each, 150 points total. Each brief is published here
ahead of its due date. Read course materials on GitHub, and use the relevant
class guide for each lab.

Starting with Exercise 03, your work goes in your public `career-platform`
repository, the one you've built since September 15. Each exercise adds an
evidence file as specified in its brief, and you submit the repository URL
in Brightspace. Exercise 04 uses `docs/how-this-site-is-secured.md` and also
asks for your live site URL and a direct link to that explanation.

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
| 04 | Domain delegated to Cloudflare DNS, live with HTTPS | Config | Thu 10/8, 1:45 PM | [published](ex04-secure-your-site.md) |
| 05 | **Broken DNS/TLS: diagnose and fix** | Troubleshoot | Thu 10/15, 1:45 PM | [instructions](ex05-troubleshoot-dns-tls.md) |
| 06 | Email DNS: Zoho Mail, MX, SPF, DKIM, and DMARC, with a send/receive/reply test | Config | Thu 10/15, 1:45 PM | [instructions](ex06-domain-email.md) |
| 07 | Job Scout's first loop: tools, state, stop conditions, and a real run | Build | Tue 11/10, 1:45 PM | |
| 08 | **Broken integration: an expired credential and a changed schema in Job Scout** | Troubleshoot | Thu 11/12, 1:45 PM | |
| 09 | Raw agent loop in Python, three tools, evals, trace read | Build | Tue 11/17, 1:45 PM | |
| 10 | **Broken agent: bad tool schema, runaway loop, cost blowup** | Troubleshoot | Tue 11/24, 1:45 PM | |

Exercise 03 collects the spec, implementation plan, and migration plan from
the resume-site build and the Azure migration. The Railway migration is a
Project 1 requirement, and basic GA4 is also required. Exercises 05 and 06
are both due Thursday, October 15, after their lessons. Job Scout and its
integration exercise move after the midterm. Job Scout lessons are November 3
and 5. Choose the Project 2 posting by November 5, with the instructor's vetted
feed available if needed. All listed November deadlines are at 1:45 PM Pacific.

## What every exercise needs

Follow each exercise's brief for its required evidence and grading.
Exercise 04 uses the live HTTPS site and `docs/how-this-site-is-secured.md`;
it doesn't require a separate spec, plan, `docs/evidence/ex04.md`, or
"The change" response. Its brief explains credit/no-credit grading.

Exercises 05 and 06 use `docs/evidence/ex05.md` and `docs/evidence/ex06.md`,
with direct GitHub evidence links submitted in Brightspace. Follow their
briefs. They do not require an extra spec, plan, or "The change" response.

When an exercise brief calls for the general format, use:

1. A working system, verified live rather than by screenshot.
2. A specification and implementation plan, scaled to the exercise, written
   before the work.
3. An evidence file, `docs/evidence/exNN.md`, recording what broke, how you
   fixed it, and your answer to that exercise's "The change" prompt.

"The change" is a scenario handed to you after your work is done. You answer it
in two or three sentences rather than build for it: what breaks, what you would
do about it, and what that costs.

Exercises are credit/no credit: 15 or 0 points. Meaningful attempts, recorded
investigation, and honest explanations can earn credit even when checks are
incomplete or conclusions need correction. Missing work or no meaningful
attempt earns no credit. Follow the individual brief for its required work.
Exercise 01 has no plan, system, or README, and its two files go to Brightspace.

Section "Exercises, 150 points" of the [syllabus](../syllabus.md) has the full
rules.
