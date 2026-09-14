# From a database to a working application

Session 05 · September 15, 2026

Last class, you installed MySQL and created a table containing five sales.
Today you'll recreate that environment in your portfolio, build a Python page
that reads the table, and save two working versions on GitHub.

Build alongside the instructor. Keep this guide in one browser tab and your
portfolio Codespace in another. We'll pause together at each checkpoint.
This lab uses `ex03/`, but the final Ex03 assignment and deadline remain separate.

## Our route through class

| Minutes | Work |
| --- | --- |
| 0–25 | Create the portfolio, configure its secret, and recreate the database |
| 25–35 | Explain configuration and agree on the application plan |
| 35–55 | Build the Python page and trace a request |
| 55–65 | Stop MySQL, investigate, and verify recovery |
| 65–75 | Review, commit, and push the working application |
| 75–90 | Add count and average, verify, and commit and push again |
| 90–95 | Explain what must change for deployment |
| 95–100 | Record the checks and stop the Codespace |

## 1. Recreate a system from files

Complete Sections 1–4 of the [portfolio guide](portfolio-repository.md) together.
Keep Thursday's Codespace stopped and available for Ex02. Today's Codespace
must belong to your own `isba-4775-portfolio` repository.

Before moving on, confirm that:

- The repository remote points to your portfolio.
- `DB_PASSWORD` is available without displaying its value.
- Nginx answers a local request with HTTP 200.
- A new `lab_reader` connection succeeds.
- The sales table has five rows totaling 500.00.

Explain what would happen if you pushed the repository but never ran its setup
files in the new Codespace. Which parts would exist, and which would be missing?

## 2. Give Python its configuration

The application will run in the Codespace. Its database is in that same
environment, so `127.0.0.1` points to the correct place for this lab.

From the portfolio root, set the ordinary configuration in your terminal:

```bash
export DB_HOST=127.0.0.1
export DB_PORT=3306
export DB_NAME=session04
export DB_USER=lab_reader
```

`export` makes a value available to programs launched from this terminal.
These commands don't configure other open terminals or survive every restart.
The application will use these same values as defaults, which you'll inspect
in its code. The password must always come from `DB_PASSWORD` with no default.

Read one ordinary value with Python:

```bash
python3 -c 'import os; print(os.environ["DB_HOST"])'
```

The password check in the portfolio guide reports only whether a value exists.
Use that check for `DB_PASSWORD`, and don't print the entire environment.

Discuss two different failures: a missing `DB_PASSWORD`, and a present value
that doesn't match the MySQL account's password. What evidence would distinguish
them? Adding a secret doesn't create or change a database account by itself.

## 3. Agree on the application before building

Open Chat in the Codespace and select Agent mode, as shown by the instructor.
Start the conversation with this prompt:

```text
Help me design a sales reporting page using the existing database in my
portfolio Codespace. Read ex03/README.md and the setup files first.

Ask me one question at a time, with multiple-choice options. Explain terms
I don't know. Do not build until I approve the plan.

Use Python with Flask and PyMySQL. We are practicing how a browser request
reaches an application and a database. Keep the application small enough
that I can trace those steps in the code.

Read DB_PASSWORD from the environment. Never print it, request it in chat,
save it in a file, or include it in a command argument. Tell me only whether
it is set if you need to check. Keep course setup files unchanged.
```

Read the questions together. Discuss the audience, what the page should show,
and how it should behave when data isn't available. Copy the following table
into the same chat so the agent receives every shared constraint:

| Part | Agreed behavior |
| --- | --- |
| Files | Python code in `ex03/app.py`, HTML in `ex03/templates/`, and dependencies in `ex03/requirements.txt` |
| Python environment | Use `ex03/.venv/`, which Git ignores |
| Server | Flask on port 5000, with debug mode and the reloader off |
| Database | Read `DB_HOST`, `DB_PORT`, `DB_NAME`, and `DB_USER`, using the lab defaults above |
| Password | Require `DB_PASSWORD` from the environment, with a clear startup error if missing |
| Data | Query `session04.sales` on every request, ordered by ID |
| Healthy page | Show the IDs, amounts, and total with two decimal places, returning HTTP 200 |
| Empty table | Show no sales and total 0.00, returning HTTP 200 |
| Database failure | Keep Python running, show `Database unavailable`, and return HTTP 503 |
| Recovery | Refresh after MySQL restarts, without restarting Python |
| Connections | Use a short connection/read timeout and close the database connection after each request |
| Nginx | Keep its independent welcome page on port 80 |

PyMySQL is the Python package that connects to MySQL. Flask handles HTTP requests
and returns responses. Ask the agent to explain how each is used.

Keep the first version focused on rows and total. We'll add count and average
after saving a working version.

Ask the agent to finish the plan:

```text
Summarize our agreed design and checks in ex03/plan.md. Include the files,
request path, environment variables, and a short implementation sequence.
Do not build yet. Explain how we will prove the page reads actual MySQL data.
```

Read the plan before approving it. You should be able to predict the page and
HTTP status when MySQL works, stops, and starts again.

## 4. Build and inspect the first version

When the class is ready, tell the agent:

```text
Build the plan we agreed on in ex03/. Create a Python virtual environment,
install Flask and PyMySQL[rsa], including its RSA authentication dependencies, and
record the package versions in requirements.txt. Use server-rendered HTML
with Jinja templates and decimal arithmetic for money.

Keep the application read-only. Use the existing database and reader account.
Do not recreate data, repair services automatically, or substitute cached
or sample results when a query fails. Show a short database error category
in the server log without credentials or full connection details.

Explain each file and the startup command. Check your work, but leave the
database-failure demonstration, Git commits, and pushes for me to perform.
```

If agent access is blocked, tell the instructor and follow the demonstration
while access is resolved. Don't start a different tool setup during the lab.

Run the application yourself in the terminal. From the repository root:

```bash
cd ex03
.venv/bin/python -m flask --app app run --host=0.0.0.0 --port=5000 --no-debugger --no-reload
```

Flask's server is suitable for this development lab. We'll choose a production
server when we deploy. The command's terminal stays occupied until you stop
the application with Ctrl+C.

Open a second terminal for requests and service commands. Confirm its location
with `pwd`, and return to the portfolio root if needed:

```bash
cd /workspaces/isba-4775-portfolio
curl -i http://127.0.0.1:5000/
```

Lowercase `-i` shows the response headers and body. Expect HTTP 200 and the
actual five rows totaling 500.00.

In the Ports panel, forward port 5000 and keep its visibility **Private**.
Open its HTTPS address in your browser signed into your GitHub account. Also
open port 80 privately for Nginx's welcome page. Leave MySQL port 3306 unforwarded.

Pause here. Compare the browser's rows and total with your SQL query.
Find these parts in the code and explain them to a neighbor:

1. The function called when `/` receives a request.
2. The environment-variable reads and database connection.
3. The SQL query that returns the sales.
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

## 5. Investigate a failed dependency

Predict what should keep working when MySQL stops. In the second terminal,
run one command at a time:

```bash
sudo service mysql stop
curl -I http://127.0.0.1
curl -i http://127.0.0.1:5000/
ss -lnt
```

Expect Nginx to return 200 and the Python page to return 503 with
`Database unavailable`. The listeners on ports 80 and 5000 should remain,
while MySQL's listener on port 3306 is absent.

Refresh both browser pages and inspect the Python terminal's log. Explain
why the Python application can answer HTTP while failing to provide sales.
The application produces this 503. It isn't the forwarding service's 502
from the earlier stopped-Nginx demonstration.

Restore MySQL and repeat the failed request:

```bash
sudo service mysql start
curl -i http://127.0.0.1:5000/
```

Expect HTTP 200 and the original sales again. Refresh the browser too.
If recovery requires restarting Python, ask the agent to compare its
connection handling with the plan, fix it, and repeat this test.

Record the actual baseline, failure, and recovery results in `ex03/README.md`.
Keep the explanation short and identify any unresolved problem.

## 6. Commit and push the working application

Use Section 5 of the [portfolio guide](portfolio-repository.md) to inspect,
stage, commit, and push your first working version. The message is:

```text
Build and verify the Python sales page
```

Open your portfolio on GitHub and find the commit and files. Don't move on
until you can explain where the code runs and where the commit is stored.
The GitHub repository page isn't hosting your running Python application.

## 7. Make a small change and preserve it

The new requirement is to show the number of sales and the average sale.
Before using AI, predict the count and average from the database rows.

Give the agent this change request:

```text
Add the sale count and average sale to the existing page. First update
ex03/plan.md with the requirement and checks. Preserve the existing rows,
total, database-failure behavior, and recovery behavior.

Calculate from the actual query results. Display the average with two
decimal places. If there are no sales, show count 0 and "No sales" for
the average so we don't divide by zero.

Show me the changed files and explain the calculation. Do not commit or push.
```

The reloader is off, so code changes won't automatically replace the running
application. Stop Python with Ctrl+C in its terminal, then run the same
startup command again. Keep MySQL running.

Verify count **5**, total **500.00**, and average **100.00** against SQL:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

At the MySQL prompt:

```sql
SELECT COUNT(*), SUM(amount), AVG(amount) FROM session04.sales;
exit
```

Repeat the MySQL stop/start test from Section 5. Confirm that the new version
still returns 503 during failure and recovers to 200 with the correct values.

Open Source Control and click each changed file. Explain which lines implement the new
requirement and why the other behavior should still work. Update the evidence
README, then stage, commit, and push using the portfolio guide. Use the message:

```text
Add sale count and average
```

On GitHub, open this commit and inspect its diff. Find the earlier working
application commit too. Explain what each version contains.

## 8. Connect this work to the projects

Discuss what another environment would need to run your application:

- The code and dependency file from GitHub.
- A Python environment and a process running the web server.
- A reachable database with the expected table and data.
- Configuration and credentials appropriate to that environment.

If MySQL moved to a different server, would `127.0.0.1` still reach it?
Which setting would change, and how would you test the new connection?

If time permits, the instructor will show this application on Railway, a
platform as a service (PaaS). Watch GitHub code become a build and a running
service. Compare its database address, variables, logs, and public URL with
the Codespace. Codespaces secrets do not automatically become Railway variables.
The deployed application should keep working after the development Codespace stops.

You do not need to create a Railway service today. Student deployment will
follow in the personal-site work, with setup instructions provided then.

Project 1's personal site will use this planning, verification, and Git workflow.
Its requirements will determine whether it needs a database. Project 2 will
add more services, including an agent endpoint and domain data.

AI helped build today's application. The running application uses Python and
MySQL to produce its results, with no model call required for each request.

## 9. Finish the session

1. Record the startup command and your verification results in `ex03/README.md`.
2. Review Source Control. If you changed documentation, repeat the three save-cycle
   commands in the portfolio guide with a message describing those changes.
3. Confirm the files and application commits are visible on GitHub.
4. Stop the portfolio Codespace at https://github.com/codespaces.
5. Confirm both this Codespace and Thursday's Codespace are stopped.

Explain these three things without the guide: how the request reaches MySQL,
how the password reaches Python, and what a commit and push preserve.

## If time permits: change the data without changing the code

Follow this only when instructed. In your disposable portfolio database, check
that ID 6 is unused before inserting it. If it exists, stop and ask the instructor.

```bash
sudo mysql
```

At the MySQL prompt, inspect first:

```sql
SELECT * FROM session04.sales WHERE id = 6;
```

If no row exists, insert a temporary sixth sale:

```sql
INSERT INTO session04.sales (id, amount) VALUES (6, 60.00);
```

Predict the new count, total, and average, then refresh the page without
restarting Python. Expect **6**, **560.00**, and **93.33**. Explain why neither
a code change nor a Git commit was needed for the page to change.

Remove only the temporary row you just inserted and verify the original data:

```sql
DELETE FROM session04.sales WHERE id = 6 AND amount = 60.00;
SELECT COUNT(*), SUM(amount) FROM session04.sales;
exit
```

Refresh and confirm the baseline is restored. Rerunning the seed file would
preserve the extra row, so it wouldn't perform this cleanup.

## References

- https://flask.palletsprojects.com/en/stable/quickstart/
- https://pymysql.readthedocs.io/en/latest/user/examples.html
- https://www.youtube.com/watch?v=XN3xNJvWXsc&t=155s
