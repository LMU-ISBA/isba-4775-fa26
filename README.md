# ISBA 4775-01 - Networking & Cloud Computing | Fall 2026

Course materials for ISBA 4775 at Loyola Marymount University, Fall 2026.

**Syllabus:** [syllabus.md](syllabus.md) ([PDF](isba-4775-syllabus-fa26.pdf))

## Project 1 and the remaining lessons

Build your personal website in `career-platform`, deploy it on Azure, then
migrate the app and current data to Railway-hosted PostgreSQL. Add your domain,
Zoho email, and basic GA4. Project 1 is due October 22 at 1:45 PM Pacific.

- [Project 1 requirements and 125-point rubric](projects/own-your-corner-of-the-internet.md).
- [Exercise index and deadlines](exercises/README.md).
- [Before-class account preparation](syllabus.md#prepare-before-class).

| Date | Lesson and guide |
| --- | --- |
| October 6 | [Secure your site with HTTPS](guides/secure-your-site-with-https.md) |
| Before October 8, 1:45 PM | Required independent [website design activity with Impeccable](guides/improve-your-site-design.md), alongside Exercise 04 |
| October 8 | [Migrate to Railway and PostgreSQL](guides/migrate-to-railway.md) |
| October 13 | [Send and receive domain email with Zoho](guides/domain-email-with-zoho.md) |
| October 15 | [Measure your website with GA4](guides/google-analytics.md), then troubleshooting and completion |
| October 20 | [Project audit](guides/project-1-audit.md) and [midterm practice](guides/midterm-study-guide.md) |
| October 22 | Submit before class, then project walkthroughs |

Exercise 05 is due October 13 at 1:45 PM. Exercise 06 is due October 15 at
the same time. Job Scout and Resend begin after the October 27-29 midterm,
on November 3 and 5. GitHub Actions
follows on November 17, alongside tests for the more complex application.

Earlier work remains available:

- [Running and Troubleshooting Services](guides/running-and-troubleshooting-services.md).
- [Build your resume site in Codespaces](guides/resume-site-in-codespaces.md).
- [Migrate your site to an Azure VM](guides/azure-vm-migration.md).
- [Operate your site on the VM](guides/operate-the-vm.md).
- [Register a domain](guides/register-a-domain.md).

Tue/Thu 1:45-3:25 PM, Hilton 115. Instruction Sep 1 - Dec 10, 2026.

## Semester at a glance

| Weeks | | |
|---|---|---|
| 1-8 | Networking foundations, then the cloud arc | Exercises 01-06; Project 1 due Thu 10/22 at 1:45 PM |
| 9 | Midterm whiteboard interviews | Tue 10/27 - Thu 10/29 |
| 10-15 | Job Scout, then Project 2, the JD-driven build | Exercises 07-10; milestones M1-M4 |
| Finals | Final whiteboard interview | Thu 12/17, 11:00 AM |

## Repository structure

    syllabus.md    Course syllabus, with a PDF copy beside it
    exercises/     Exercise briefs, published ahead of each due date, plus the
                   self-discovery interview you run with Claude for Exercise 01
    guides/        Lesson, project audit, and interview preparation guides
    projects/      Project requirements and grading rubrics
    scripts/       Syllabus PDF renderer
    starters/      Archived sales-lab starter, not used by the current project
    README.md      This file

Exercises are published here as the semester progresses. Read course materials
on GitHub. For Session 04, create a Codespace directly from this repository;
GitHub clones it automatically. Keep course materials unchanged. Ex01 and Ex02
are submitted as files in Brightspace; later builds use your portfolio
repository as specified in each brief. Session 05 creates a
Codespace from your own `career-platform` repository. See the
[exercise index](exercises/README.md) for the current sequence.

## Regenerating the syllabus PDF

After editing `syllabus.md`, rebuild the PDF with the repository script:

    uv run scripts/render-syllabus.py

## Office hours

By appointment: https://calendly.com/greg-lontok
