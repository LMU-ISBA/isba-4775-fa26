# From a database to your resume site

Session 05 · September 15, 2026

Last class, you installed MySQL and created a table containing five sales.
Today you'll recreate that environment in your portfolio, build the first
version of your Project 1 personal site as a resume page that reads from
MySQL, and save two working versions on GitHub.

The resume data is a placeholder. Replacing it with your own is homework.
If you don't have a resume yet, the placeholder shows you the shape of one.

Build alongside the instructor. Keep this guide in one browser tab and your
portfolio Codespace in another. We'll pause together at each checkpoint.

## Our route through class

| Minutes | Work |
| --- | --- |
| 0–20 | Create the portfolio, configure its secret, and recreate the database |
| 20–30 | Install Claude Code in the Codespace and sign in |
| 30–45 | Explain configuration and agree on the site plan |
| 45–65 | Build the resume page and trace a request |
| 65–75 | Stop MySQL, investigate, and verify recovery |
| 75–85 | Review, commit, and push the working site |
| 85–95 | Add the skills section, verify, and commit and push again |
| 95–100 | Explain what must change for deployment, and stop the Codespace |

## 1. Recreate a system from files

Complete Sections 1–4 of the [portfolio guide](portfolio-repository.md) together.
Keep Thursday's Codespace stopped and available for Ex02. Today's Codespace
must belong to your own `isba-4775-portfolio` repository.

Before moving on, confirm that:

- The repository remote points to your portfolio.
- `DB_PASSWORD` is available without displaying its value.
- Nginx answers a local request with HTTP 200.
- A new `lab_reader` connection succeeds.
- The resume table has eight rows in four sections.

Explain what would happen if you pushed the repository but never ran its setup
files in the new Codespace. Which parts would exist, and which would be missing?

## 2. Give Python its configuration

The site will run in the Codespace. Its database is in that same
environment, so `127.0.0.1` points to the correct place for this lab.

From the portfolio root, set the ordinary configuration in your terminal.
Use your own name and a headline you'd put at the top of a resume:

```bash
export DB_HOST=127.0.0.1
export DB_PORT=3306
export DB_NAME=portfolio
export DB_USER=lab_reader
export SITE_NAME="Your Name"
export SITE_HEADLINE="ISBA student at Loyola Marymount University"
```

`export` makes a value available to programs launched from this terminal.
These commands don't configure other open terminals or survive every restart.
The site will use the database values as defaults, which you'll inspect in
its code. The password must always come from `DB_PASSWORD` with no default.

Read one ordinary value with Python:

```bash
python3 -c 'import os; print(os.environ["SITE_NAME"])'
```

The password check in the portfolio guide reports only whether a value exists.
Use that check for `DB_PASSWORD`, and don't print the entire environment.

Discuss two different failures: a missing `DB_PASSWORD`, and a present value
that doesn't match the MySQL account's password. What evidence would distinguish
them? Adding a secret doesn't create or change a database account by itself.

## 3. Install your coding agent in the Codespace

Claude Code runs in the terminal. It reads and edits files in the repository
and runs commands, asking you before each one. Install it inside the
Codespace, not on your laptop, from the portfolio root:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

If the terminal then says `claude: command not found`, open a new terminal
and try again. Start it from the portfolio root:

```bash
claude
```

The first run asks whether to trust this folder. Accept. Then sign in:

1. Claude Code shows a sign-in link. If it doesn't open, press `c` to copy it.
2. Open the link in your browser and sign in with the Claude Pro account from Ex01.
3. The browser shows a code. Paste it back into the terminal when prompted.

If you chose Codex in Ex01, install it with `npm install -g @openai/codex`,
start it with `codex`, and sign in with your ChatGPT account. The prompts
below work the same way.

Pause here. Everyone should see the agent's prompt before we continue.
The agent inherits this terminal's environment, including `DB_PASSWORD`.
Every prompt below tells it never to print that value. Read what the agent
asks to run before you approve it, every time.

## 4. Agree on the site before building

Paste this prompt into Claude Code:

```text
Help me design the first version of my personal site: a resume page that
reads from the existing MySQL database in my portfolio Codespace. Read
site/README.md and the setup files first.

Ask me one question at a time, with multiple-choice options. Explain terms
I don't know. Do not build until I approve the plan.

Use Python with Flask and PyMySQL. We are practicing how a browser request
reaches an application and a database. Keep the application small enough
that I can trace those steps in the code.

Read DB_PASSWORD from the environment. Never print it, request it in chat,
save it in a file, or include it in a command argument. Tell me only whether
it is set if you need to check. Keep course setup files unchanged.
```

Read the questions together. Discuss who reads a resume, what they look for
first, and how the page should behave when data isn't available. Copy the
following table into the same chat so the agent receives every shared
constraint:

| Part | Agreed behavior |
| --- | --- |
| Files | Python code in `site/app.py`, HTML in `site/templates/`, and dependencies in `site/requirements.txt` |
| Python environment | Use `site/.venv/`, which Git ignores |
| Server | Flask on port 5000, with debug mode and the reloader off |
| Database | Read `DB_HOST`, `DB_PORT`, `DB_NAME`, and `DB_USER`, using the lab defaults above |
| Password | Require `DB_PASSWORD` from the environment, with a clear startup error if missing |
| Header | Show `SITE_NAME` and `SITE_HEADLINE` from the environment, with defaults `Your Name` and `ISBA student`, on every response, even when the database is down |
| Data | Query `portfolio.resume_entries` on every request, ordered by ID |
| Healthy page | Sections Experience, Education, and Projects in that order, each entry showing title, organization, dates, and description, returning HTTP 200 |
| Empty section | Show the heading and `Nothing here yet`, returning HTTP 200 |
| Skills | Rows with section `skills` exist in the table but are not shown in this version |
| Database failure | Keep Python running, show the header and `Resume unavailable`, and return HTTP 503 |
| Recovery | Refresh after MySQL restarts, without restarting Python |
| Connections | Use a short connection/read timeout and close the database connection after each request |
| Nginx | Keep its independent welcome page on port 80 |

PyMySQL is the Python package that connects to MySQL. Flask handles HTTP requests
and returns responses. Ask the agent to explain how each is used.

Keep the first version focused on three sections. We'll add skills after
saving a working version.

Ask the agent to finish the plan:

```text
Summarize our agreed design and checks in site/plan.md. Include the files,
request path, environment variables, and a short implementation sequence.
Do not build yet. Explain how we will prove the page reads actual MySQL data.
```

Read the plan before approving it. You should be able to predict the page and
HTTP status when MySQL works, stops, and starts again.

## 5. Build and inspect the first version

When the class is ready, tell the agent:

```text
Build the plan we agreed on in site/. Create a Python virtual environment,
install Flask and PyMySQL[rsa], including its RSA authentication dependencies, and
record the package versions in requirements.txt. Use server-rendered HTML
with Jinja templates. Keep the styling minimal and readable.

Keep the application read-only. Use the existing database and reader account.
Do not recreate data, repair services automatically, or substitute cached
or sample results when a query fails. Show a short database error category
in the server log without credentials or full connection details.

Explain each file and the startup command. Check your work, but leave the
database-failure demonstration, Git commits, and pushes for me to perform.
```

Approve the commands the agent asks to run as you read them. If agent
access is blocked, tell the instructor and follow the demonstration while
access is resolved. Don't start a different tool setup during the lab.

Run the site yourself in a second terminal. Open **Terminal → New Terminal**,
set the same six `export` values from Section 2 there, then from the
repository root:

```bash
cd site
.venv/bin/python -m flask --app app run --host=0.0.0.0 --port=5000 --no-debugger --no-reload
```

Flask's server is suitable for this development lab. We'll choose a production
server when we deploy. The command's terminal stays occupied until you stop
the application with Ctrl+C.

Open a third terminal for requests and service commands. Confirm its location
with `pwd`, and return to the portfolio root if needed:

```bash
cd /workspaces/isba-4775-portfolio
curl -i http://127.0.0.1:5000/
```

Lowercase `-i` shows the response headers and body. Expect HTTP 200, your
name in the header, and the placeholder entries in three sections.

In the Ports panel, forward port 5000 and keep its visibility **Private**.
Open its HTTPS address in your browser signed into your GitHub account. Also
open port 80 privately for Nginx's welcome page. Leave MySQL port 3306 unforwarded.

Pause here. Compare the browser's sections and entries with your SQL query.
Find these parts in the code and explain them to a neighbor:

1. The function called when `/` receives a request.
2. The environment-variable reads and database connection.
3. The SQL query that returns the resume entries.
4. The HTML response and database-error response.

Draw the two paths separately:

```text
Laptop browser → GitHub HTTPS forwarding :443 → Python HTTP :5000
                                                    ↓
                                          MySQL protocol :3306

Laptop browser → GitHub HTTPS forwarding :443 → Nginx HTTP :80
```

Python, Nginx, and MySQL run inside the portfolio Codespace. Python acts as
an HTTP server to the browser and as a database client to MySQL. Nginx isn't
forwarding requests to Python in this setup.

## 6. Investigate a failed dependency

Predict what should keep working when MySQL stops. Should a visitor still
see your name? In the third terminal, run one command at a time:

```bash
sudo service mysql stop
curl -I http://127.0.0.1
curl -i http://127.0.0.1:5000/
ss -lnt
```

Expect Nginx to return 200 and the resume page to return 503 with your name
in the header and `Resume unavailable` in the body. The listeners on ports
80 and 5000 should remain, while MySQL's listener on port 3306 is absent.

Refresh both browser pages and inspect the Python terminal's log. Explain
why the Python application can answer HTTP while failing to provide the resume.
The application produces this 503. It isn't the forwarding service's 502
from the earlier stopped-Nginx demonstration.

Discuss the choice. The header comes from the environment and the body comes
from the database, so the page degrades instead of disappearing. What would
a visitor prefer, and what would a monitoring tool want to see?

Restore MySQL and repeat the failed request:

```bash
sudo service mysql start
curl -i http://127.0.0.1:5000/
```

Expect HTTP 200 and the resume again. Refresh the browser too.
If recovery requires restarting Python, ask the agent to compare its
connection handling with the plan, fix it, and repeat this test.

Record the actual baseline, failure, and recovery results in `site/README.md`.
Keep the explanation short and identify any unresolved problem.

## 7. Commit and push the working site

Use Section 5 of the [portfolio guide](portfolio-repository.md) to inspect,
stage, commit, and push your first working version. The message is:

```text
Build and verify the resume site
```

Open your portfolio on GitHub and find the commit and files. Don't move on
until you can explain where the code runs and where the commit is stored.
The GitHub repository page isn't hosting your running site.

## 8. Make a small change and preserve it

The new requirement is a Skills section after Projects. The rows already
exist in the table. Before using AI, run the query and predict what the
section will show:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

At the MySQL prompt:

```sql
SELECT title FROM portfolio.resume_entries WHERE section = 'skills' ORDER BY id;
exit
```

Give the agent this change request:

```text
Add a Skills section after Projects to the existing page. First update
site/plan.md with the requirement and checks. Preserve the existing sections,
header, database-failure behavior, and recovery behavior.

Show skills as a simple list of titles from rows whose section is "skills",
ordered by ID. If there are none, show the heading and "Nothing here yet".

Show me the changed files and explain the change. Do not commit or push.
```

The reloader is off, so code changes won't automatically replace the running
application. Stop Python with Ctrl+C in its terminal, then run the same
startup command again. Keep MySQL running.

Verify that the three skills from your query appear, and that the three
earlier sections are unchanged.

Repeat the MySQL stop/start test from Section 6. Confirm that the new version
still returns 503 during failure and recovers to 200 with all four sections.

Open Source Control and click each changed file. Explain which lines implement the new
requirement and why the other behavior should still work. Update the evidence
README, then stage, commit, and push using the portfolio guide. Use the message:

```text
Add the skills section
```

On GitHub, open this commit and inspect its diff. Find the earlier working
site commit too. Explain what each version contains.

## 9. Connect this work to Project 1

This page is the start of your Project 1 personal site. Thursday it goes to
Railway, a platform as a service, and gets a public address. The week after,
it gets your own domain. Discuss what another environment needs to run it:

- The code and dependency file from GitHub.
- A Python environment and a process running the web server.
- A reachable database with the expected table and data.
- Configuration and credentials appropriate to that environment.

If MySQL moved to a different server, would `127.0.0.1` still reach it?
Which setting would change, and how would you test the new connection?
Codespaces secrets do not automatically become Railway variables.

Your homework is the content. Replace the placeholder experience and education
rows with your own, using the reader's SQL as a model and the administrator
client to write. Add real projects and skills. This repository is public, so
your resume belongs on it and your phone number and street address don't.
Add an email address once Ex06 gives you one at your own domain.

AI helped build today's site. The running site uses Python and MySQL to
produce its page, with no model call required for each request.

## 10. Finish the session

1. Record the startup command and your verification results in `site/README.md`.
2. Review Source Control. If you changed documentation, repeat the three save-cycle
   commands in the portfolio guide with a message describing those changes.
3. Confirm the files and both site commits are visible on GitHub.
4. Stop the portfolio Codespace at https://github.com/codespaces.
5. Confirm both this Codespace and Thursday's Codespace are stopped.

Explain these three things without the guide: how the request reaches MySQL,
how the password reaches Python, and what a commit and push preserve.

## If time permits: change the data without changing the code

Follow this only when instructed. Check that ID 9 is unused before
inserting it. If it exists, stop and ask the instructor.

```bash
sudo mysql
```

At the MySQL prompt, inspect first:

```sql
SELECT * FROM portfolio.resume_entries WHERE id = 9;
```

If no row exists, insert a temporary skill:

```sql
INSERT INTO portfolio.resume_entries (id, section, title) VALUES (9, 'skills', 'Git');
```

Predict the new Skills list, then refresh the page without restarting Python.
Expect four skills ending in **Git**. Explain why neither a code change nor a
Git commit was needed for the page to change. This is also how you'll replace
the placeholders tonight.

Remove only the temporary row you just inserted and verify the original data:

```sql
DELETE FROM portfolio.resume_entries WHERE id = 9 AND title = 'Git';
SELECT section, COUNT(*) FROM portfolio.resume_entries GROUP BY section;
exit
```

Refresh and confirm the baseline is restored. Rerunning the seed file would
preserve the extra row, so it wouldn't perform this cleanup.

## References

- https://code.claude.com/docs/en/setup
- https://flask.palletsprojects.com/en/stable/quickstart/
- https://pymysql.readthedocs.io/en/latest/user/examples.html
