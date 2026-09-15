# Personal site

This folder holds your Project 1 personal site. It starts as your resume,
built during the Session 5 build-along, and grows through the semester.

## Setup

From the repository root, run the three commands in the portfolio README.
The database is `portfolio`, the table is `resume_entries`, and the reader
account is `lab_reader` at `127.0.0.1`. Supply its password through
`DB_PASSWORD`.

Verify the data using the reader account:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

Enter your own lab password when prompted. At the MySQL prompt, run:

```sql
SELECT id, section, title FROM portfolio.resume_entries ORDER BY id;
SELECT section, COUNT(*) FROM portfolio.resume_entries GROUP BY section ORDER BY section;
exit
```

The fresh seed contains eight entries: two experience, one education, two
projects, and three skills. The experience and education rows are
placeholders. Replace them with your own resume after class.

## Application

During the build-along, record the Python packages, startup command, and local
URL here. Explain which code handles the request, queries MySQL, and returns
the page. Keep the forwarded web port private.

## Verification

Record your actual baseline result, database-failure result, and recovery
result. After the small change, record the sections and counts you observed.
State any checks you couldn't finish.

## What changed

After the second push, describe the change and identify the two application
commits. Explain how you checked that the original behavior still worked.

## What stays out of this repository

This repository is public. Your resume is meant to be read, but keep your
phone number and street address out of it. Add an email address once you
have one at your own domain.
