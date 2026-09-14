# ISBA 4775-01 - Networking & Cloud Computing | Fall 2026

Course materials for ISBA 4775 at Loyola Marymount University, Fall 2026.

**Syllabus:** [syllabus.md](syllabus.md) ([PDF](isba-4775-syllabus-fa26.pdf))

**Session 04 in-class lab:** [Running and Troubleshooting Services](guides/running-and-troubleshooting-services.md).
We will create the Codespace and work through the guide together during class.

**Session 05:** [Your portfolio repository](guides/portfolio-repository.md)
and [From a database to a working application](guides/database-to-application.md).
Start from the [portfolio template](https://github.com/LMU-ISBA/isba-4775-portfolio-template)
to create your own repository, then open a Codespace from your repository.

Tue/Thu 1:45-3:25 PM, Hilton 115. Instruction Sep 1 - Dec 10, 2026.

## Semester at a glance

| Weeks | | |
|---|---|---|
| 1-8 | Networking foundations, then the cloud arc | Exercises 01-08; Project 1 due Thu 10/22 |
| 9 | Midterm whiteboard interviews | Tue 10/27 - Thu 10/29 |
| 10-15 | Project 2, the JD-driven build | Exercises 09-10; milestones M1-M4 |
| Finals | Final whiteboard interview | Thu 12/17, 11:00 AM |

## Repository structure

    syllabus.md    Course syllabus, with a PDF copy beside it
    exercises/     Exercise briefs, published ahead of each due date, plus the
                   self-discovery interview you run with Claude for Exercise 01
    guides/        In-class lab instructions and portfolio repository setup
    starters/      Source files for student starter repositories
    README.md      This file

Exercises are published here as the semester progresses. Read course materials
on GitHub. For Session 04, create a Codespace directly from this repository;
GitHub clones it automatically. Keep course materials unchanged. Ex01 and Ex02
are submitted as files in Brightspace; later builds use your portfolio
repository as specified in each brief. Session 05 creates a fresh
Codespace from your own portfolio using the guide above. See the [exercise index](exercises/README.md)
for the current sequence and draft status.

## Regenerating the syllabus PDF

After editing `syllabus.md`, rebuild the PDF with the repository script:

    uv run scripts/render-syllabus.py

## Office hours

By appointment: https://calendly.com/greg-lontok
