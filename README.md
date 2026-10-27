# ISBA 4775-01: Networking and Cloud Computing, Fall 2026

This repository holds the course materials for ISBA 4775 at Loyola Marymount
University. Class meets Tuesdays and Thursdays, 1:45 to 3:25 PM, in Hilton 113.
Read everything here on GitHub and leave this repository unchanged. Your own
work goes in your `career-platform` repository or in Brightspace, as each exercise's
requirements tell you.

Start with the [syllabus](syllabus.md), which also comes as a
[PDF](isba-4775-syllabus-fa26.pdf).

## Where we are now

Midterm whiteboard interviews run October 26 to 28 in Hilton 114.
We return to regular class on Thursday, October 29, to migrate your site
from Railway to AWS before the Railway trial ends. Job Scout begins November 3.

- [Project 1 requirements and the 125-point rubric](projects/own-your-corner-of-the-internet.md)
- [Exercise requirements and deadlines](exercises/README.md)
- [Accounts to set up before class](syllabus.md#prepare-before-class)

| Date | Lesson and guide |
| --- | --- |
| October 6 | [Secure your site with HTTPS](guides/secure-your-site-with-https.md) |
| Before October 8, 1:45 PM | [Website design activity with Impeccable](guides/improve-your-site-design.md), required and done on your own alongside Exercise 04 |
| October 8 | [Migrate to Railway and PostgreSQL](guides/migrate-to-railway.md) |
| October 13 | [Send and receive domain email with Zoho](guides/domain-email-with-zoho.md) |
| October 15 | [Connect Coding Agent to Zoho Mail](guides/connect-coding-agent-to-zoho-mail.md), then [Measure your website with GA4](guides/google-analytics.md) |
| October 20 | [Practice your whiteboard interview](guides/whiteboard-interview-practice.md) |
| October 22 | Submit Project 1 before class. Guest speakers Cian O'Brien and Timothy Cherpes, ISBA alumni at ServiceNow. Post two questions in the Brightspace discussion by Wednesday, October 21, at 11:59 PM |
| October 26 to 28 | Midterm whiteboard interviews in Hilton 114. Interviews replace class on October 27 |
| October 29 | Migrate your site from Railway to AWS |
| November 3 | Job Scout 1: LLM calls, structured output, retrieval tools, and the first loop |
| November 5 | Professor Ken Summers: Troubleshooting Road Show, during our regular class in Hilton 113. Job Scout 2 continues with tools, state, stop conditions, a human approval step, a Resend digest, and integration failures |

On November 5, Brandon Kulik from Deloitte will speak on "Consulting in the
Age of AI." The evening event runs from 6:00 to 7:00 PM in Hilton 107.
RSVP at https://lmu.campuslabs.com/engage/event/12919719.

Choose your Project 2 posting by November 5, using the vetted feed if needed.
Job Scout's first complete run and Project 2 milestone M1 are due November 10.
GitHub Actions and tests follow on November 17.

## Earlier guides

You can go back to these at any time:

- [Running and troubleshooting services](guides/running-and-troubleshooting-services.md)
- [Build your resume site in Codespaces](guides/resume-site-in-codespaces.md)
- [Migrate your site to an Azure VM](guides/azure-vm-migration.md)
- [Operate your site on the VM](guides/operate-the-vm.md)
- [Register a domain](guides/register-a-domain.md)

## Semester at a glance

Instruction runs September 1 to December 10, 2026.

| Weeks | Focus | Graded work |
| --- | --- | --- |
| 1-8 | Networking foundations, then the cloud arc | Exercises 01-06, Project 1 due Thu 10/22 at 1:45 PM |
| 9 | Midterm whiteboard interviews, then AWS migration on Thu 10/29 | Interviews Mon 10/26 to Wed 10/28 |
| 10-15 | Job Scout, then Project 2, the job-description-driven build | Exercises 07-10 and milestones M1-M4 |
| Finals | Final whiteboard interview | Thu 12/17, 11:00 AM |

## What's in this repository

    syllabus.md    The syllabus, with a PDF copy beside it
    exercises/     Exercise requirements, posted ahead of each due date, and the
                   Exercise 01 self-discovery interview
    guides/        Lesson guides and interview prep
    projects/      Project requirements and rubrics

You can ignore `scripts/` and `starters/`. They aren't part of your current
work. New exercise requirements appear in `exercises/` as the semester goes on, so
check the [exercise index](exercises/README.md) for the current list.

When a guide asks you to open a Codespace, open it from your own
`career-platform` repository, not from this one.

## Getting help

Book office hours by appointment at https://calendly.com/greg-lontok.

## Regenerate the syllabus PDF

After editing [syllabus.md](syllabus.md), regenerate its
[PDF](isba-4775-syllabus-fa26.pdf) with the shared renderer:

```bash
uv run ~/.claude/skills/pdf-generation/generate_pdf.py syllabus.md -o isba-4775-syllabus-fa26.pdf --preview /tmp/isba-4775-syllabus-preview
```

Inspect every preview page before publishing the PDF.
