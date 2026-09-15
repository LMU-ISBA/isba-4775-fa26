# Personal Resume Site PRD

**Personalize before you start.** This PRD describes a site everyone builds
the same way, with content only you can supply. Before Section 1 of the
workshop, edit two things: your name and headline in the Expected Output
section, and the placeholder rows in `data/seed.sql`. If you don't have a
resume yet, keep the placeholders and replace them after the site is live.

## Executive Summary

You need a personal site at an address you control. It starts as your resume:
a single page that a recruiter can read in thirty seconds, served by a small
Python application that reads the resume from a database. Later in the
semester it gets your own domain, email, analytics, and an automated job
search. This document covers the first version only.

## Terminology

| Term | Meaning |
|---|---|
| PRD | Product requirements document. What to build and how to know it's done, written before the work. |
| Flask | A small Python web framework. It receives an HTTP request and returns an HTML page. |
| Jinja | The template language Flask uses to fill HTML with data. |
| SQLite | A database that lives in one file and ships with Python. No server to install. |
| Seed file | A SQL file that creates the table and inserts the rows. It is the source of truth for your resume. |
| Railway | A platform as a service. It builds your code from GitHub and runs it at a public address. |
| Environment variable | A named value the running program reads at startup, such as your name or a file path. |

## Problem Statement

A PDF resume is a dead end. It can't be linked from a profile, it doesn't
show up in a search, and every edit means re-sending a file. A site built on
a page builder isn't yours either: you can't explain how it works, and you
can't take it with you.

The site you build here is the one you'll defend in the midterm interview.
You need to be able to draw it from memory: where the request goes, where the
data lives, and what breaks when a piece stops.

The desired outcome is a live page at a public address, built from code and
data in a repository you own, that you can change with a commit.

## Goals and Success Metrics

1. A recruiter can read your name, headline, and resume sections on one page.
2. You can update the resume by editing one file and pushing.
3. The site keeps answering, with an honest message, when the database is unreadable.
4. The site runs with one command locally and deploys from `main` on Railway.

| Metric | Target | How it's measured |
|---|---|---|
| Page load | Under 2 seconds | Browser developer tools, network tab |
| Update path | One commit to change content | Edit the seed, push, see the change live |
| Failure behavior | Header visible, HTTP 503 | Make the database unreadable, request the page |
| Deploy | Live on a public Railway address | Open the URL from a phone off Wi-Fi |

## User Stories

- **Recruiter, thirty seconds.** "I want to see who this person is and what they've done without scrolling through a portfolio."
- **You, next month.** "I got a new role. I want to add one row and have the site update without touching the code."
- **You, in the midterm.** "I need to explain what happens between the browser and the database, and what a visitor sees when the database is gone."
- **Instructor.** "I want to open the repository and see a plan, tests, tagged commits, and a live URL."

## Requirements

### Phase 1: Functional requirements

**FR-1: Header**
- Show the site owner's name and a one-line headline at the top of the page
- Read both from environment variables `SITE_NAME` and `SITE_HEADLINE`
- Default to `Your Name` and `ISBA student` when the variables are missing
- Render the header on every response, including error responses

**FR-2: Resume sections**
- Show three sections in this order: Experience, Education, Projects
- Each entry shows title, organization, dates, and description
- Entries within a section appear in ascending `id` order
- Return HTTP 200 for a healthy page

**FR-3: Skills**
- Show a Skills section after Projects
- List the `title` of each row whose `section` is `skills`, in ascending `id` order
- Skills have no organization, dates, or description

**FR-4: Empty section**
- When a section has no rows, show its heading and the text `Nothing here yet`
- Return HTTP 200

**FR-5: Data source**
- Read all entries from a SQLite database file on every request
- Read the file path from environment variable `DATABASE_PATH`, defaulting to `resume.db`
- If the database file doesn't exist at startup, create it by running `data/seed.sql`
- Never write to the database while handling a request. The site is read-only.
- The seed file is the source of truth. Updating the resume means editing the seed, committing, and pushing.

**FR-6: Database failure**
- When the database can't be opened or queried, keep the application running
- Show the header and the text `Resume unavailable`
- Return HTTP 503
- Log a short error category without file contents or full paths
- Recover on the next request once the database is readable again, without a restart

### Phase 2: Future enhancements (out of scope)

These come later in the course and are not part of this build:

- Custom domain with TLS (Exercise 04)
- Contact email address at your own domain (Exercise 06)
- Google Analytics (Project 1)
- GitHub Actions deploy workflow (Exercise 08)
- The Job Scout digest (Project 1)
- Any page that writes data: contact form, visitor counter, admin editor
- A managed database that survives a redeploy

### Non-functional requirements

- **Runs locally with one command.** Document it in the README.
- **Runs on Railway from `main`.** Use a production server, gunicorn, and read the listening port from the `PORT` environment variable Railway sets.
- **Readable on a phone.** One column, no horizontal scrolling, no JavaScript required.
- **No secrets in the repository.** This site has none. Keep it that way.
- **No personal data beyond the resume.** No phone number, no street address.
- **Small enough to trace.** One request handler, one query, one template. You will explain every line.

## Data Specification

One table, `resume_entries`, created by `data/seed.sql`.

| Column | Type | Meaning |
|---|---|---|
| `id` | INTEGER, primary key | Display order within a section |
| `section` | TEXT | One of `experience`, `education`, `projects`, `skills` |
| `title` | TEXT | Role, degree, project name, or skill |
| `organization` | TEXT, nullable | Employer, school, or course |
| `dates` | TEXT, nullable | Free text, such as `2024 - present` |
| `description` | TEXT, nullable | One line |

The starter seed has eight rows: two experience, one education, two projects,
three skills. The experience and education rows are placeholders and say so.

## Technical Approach

- Python 3.12 or newer
- Flask for HTTP, Jinja templates for HTML
- `sqlite3` from the Python standard library. No ORM.
- gunicorn as the production server
- Railway, deploying from the `main` branch of your public repository

```text
Browser ──HTTPS──▶ Railway edge ──HTTP :PORT──▶ gunicorn ──▶ Flask app.py
                                                                │
                                                                ▼
                                                         resume.db (SQLite)
                                                                ▲
                                                 built at startup from data/seed.sql
```

Locally, the same application runs on port 5000 and the browser talks to it
directly. The database is a file next to the code in both places.

## Expected Output

Replace the name and headline before you start.

```text
┌──────────────────────────────────────────────┐
│ Your Name                                    │
│ ISBA student at Loyola Marymount University  │
├──────────────────────────────────────────────┤
│ Experience                                   │
│   Sales Associate · Example Retail Co.       │
│   2024 - present                             │
│   Placeholder. Replace with a real role...   │
│   Summer Intern · Example Nonprofit          │
│   Summer 2023                                │
│   Placeholder. Replace with a real role...   │
├──────────────────────────────────────────────┤
│ Education                                    │
│   B.S. Information Systems and Business      │
│   Analytics · Loyola Marymount University    │
│   Expected 2027                              │
├──────────────────────────────────────────────┤
│ Projects                                     │
│   Home network diagram · ISBA 4775           │
│   Web server and database troubleshooting    │
├──────────────────────────────────────────────┤
│ Skills                                       │
│   Python · SQL · Linux command line          │
└──────────────────────────────────────────────┘
```

With the database unreadable, the page shows the header, then
`Resume unavailable`, with HTTP status 503.

## Acceptance Criteria

- [ ] Name and headline come from environment variables and fall back to the defaults
- [ ] Experience, Education, Projects, and Skills appear in that order with the seed's eight rows
- [ ] Removing every row from a section shows `Nothing here yet` for that section
- [ ] Deleting `resume.db` and restarting recreates it from `data/seed.sql`
- [ ] Making the database unreadable returns 503 with the header visible, and the next request after restoring it returns 200 without a restart
- [ ] Data functions have tests that run with `pytest`
- [ ] One documented command starts the site locally
- [ ] The site is live at a Railway URL and loads from a phone off Wi-Fi
- [ ] No phone number or street address anywhere in the repository

## Timeline and Milestones

| Milestone | Done means |
|---|---|
| M1 Setup and data | Virtual environment, dependencies recorded, seed loads into a fresh `resume.db` |
| M2 Header and one section | Page returns 200 with the header and Experience |
| M3 All sections | Education, Projects, and empty-section behavior |
| M4 Failure behavior | 503 with header when the database is unreadable, recovery without restart |
| M5 Skills | Skills section rendered as a list |
| M6 Deployed | Live on Railway from `main`, README records the URL |

## Stakeholders

| Role | Responsibility |
|---|---|
| You | Owner. Content, decisions, and the explanation in the interview |
| Recruiter or hiring manager | Reader. Thirty seconds, on a phone |
| Instructor | Reviews the plan, the commits, and the live site |

## Risks and Mitigations

| Risk | Likelihood | Mitigation |
|---|---|---|
| Placeholder text ships to the live site | High | The placeholders say "Placeholder" so it's obvious. Replace them the same week |
| Personal data in a public repository | Medium | The seed carries no phone or address. Email arrives later at your own domain |
| Edits made directly in `resume.db` vanish on redeploy | High, by design | The seed is the source of truth. Edit the seed, not the database |
| Railway billing surprises | Low | Check the plan's included usage before deploying. One small service is within the Hobby minimum |
| The application grows past what you can explain | Medium | One handler, one query, one template. Anything more is Phase 2 |

## Appendix

- Flask quickstart: https://flask.palletsprojects.com/en/stable/quickstart/
- Python `sqlite3` module: https://docs.python.org/3/library/sqlite3.html
- Railway: deploying from GitHub: https://docs.railway.com/guides/github-autodeploys
- gunicorn: https://docs.gunicorn.org/en/stable/run.html
