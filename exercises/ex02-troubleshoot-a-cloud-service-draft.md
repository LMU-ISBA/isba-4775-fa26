# Exercise 02: Troubleshoot a cloud service

**Draft for instructor review.** Proposed due date: Tuesday, September 15, 2026, before class at 1:45 p.m. The date and related September schedule changes have not been published.

**15 points** · **Individual exercise** · **Allow 60-90 minutes after Session 04 setup, including the report and drawing**

Upload exactly two separate files to the Exercise 02 assignment on Brightspace:

1. `service-diagram-firstname-lastname.jpg`
2. `service-investigation-firstname-lastname.md`

Use your own first and last names. Nothing from this exercise goes in a repository. Keep the drawing separate from the report; do not combine them into a PDF or submit a shared-document link instead of the files.

## What you are practicing

In Session 03, you used requests and responses to investigate a service from outside the server. In Session 04, you looked inside a Linux environment at its installed software, running processes, listening ports, and logs.

You will stop one service at a time, choose checks that show what changed, and repair it. Repeat the failed test after the repair. Use your drawing and actual output to explain why you consider the service restored.

Complete these investigations independently at home and collect fresh output. The in-class discussions do not require a saved notes document; your report and drawing are part of this exercise.

These are controlled practice failures. You already know which service you stopped. The work is to show evidence for the failure and recovery, including what continued to work.

## Before you start

Use your own course Codespace from the [Session 04 lab guide](../guides/inside-a-server.md). It should already have Nginx, MySQL, the `session04.sales` table, and the read-only `lab_reader` account. Resume that same environment from [Your Codespaces](https://github.com/codespaces), rather than creating another one.

You do not need AWS access, a local database, an installed coding agent, or a portfolio repository. The lab commands run in the Codespace's Linux terminal on both Mac and Windows. They do not run in your laptop's Terminal or PowerShell.

Check your account's remaining Codespaces allowance. If GitHub blocks access or requests a billing change, contact me before adding a payment method or enabling paid usage. If you did not finish Session 04 setup, arrange help before starting this exercise. Do not rebuild the container or recreate the database as a troubleshooting shortcut.

Keep web port 80 forwarded with visibility set to **Private**. Open its **HTTPS forwarded address** in a browser session signed into the GitHub account that owns your Codespace. An incognito window needs that same sign-in; another student’s account cannot access your private preview. Leave database ports 3306 and 33060 unforwarded. Work only on your own course environment.

The class sales-page build-along previews Ex03. Building an application or using the coding agent is not required for these two Ex02 incidents; test the Nginx welcome page and MySQL directly.

You may use AI under the course policy to understand commands or question your reasoning. You must run the checks, record your actual results, and be able to explain the drawing and report. Do not replace missing results with AI-generated output. No prompt log is required.

## 1. Establish your baseline and write a short plan

Open your report before changing anything; the [report-writing instructions](#how-to-create-the-report-file) explain your options. Record where the commands will run and what you expect a healthy system to do. List the checks you intend to use for each failure and why. A few sentences are enough. If you change the plan, say what evidence changed your mind.

Use the [command reference](#command-reference) to start the services if needed. Confirm that:

- Your local HTTP request receives HTTP 200, and your private browser preview displays the Nginx welcome page.
- The reader account connects successfully, and the SQL sum query returns the fictional sales total `200.00`.

Save the web response, successful database connection and query output, and a brief note about the browser result. A successful service-start message alone is not the baseline. If these checks do not work, resolve that starting problem before introducing either deliberate failure.

## 2. Investigate the web-service failure

Before stopping Nginx, predict what will happen to the web request, the installed package, and the database query. Then use the service controls below to stop only Nginx.

Choose the checks you need. Your evidence should include the failed web request and at least one process or listener check. Reload the same HTTPS forwarded URL in your browser while Nginx is stopped. A 502 was observed in class: the forwarding service responds because it cannot reach Nginx, while the direct local request fails to connect. Record what you actually see. Check whether the database still answers. Explain what each result tells you, then choose a repair and repeat the identical failed web request. Reopen or reload the private browser preview too.

For this incident, record:

- Your prediction and what you actually observed.
- The command and selected output for each check you used to support your explanation.
- Why you chose those checks, including one thing the evidence does not establish.
- Your repair command and the result of the identical retest.

If you inspect several things, keep the useful evidence rather than pasting the entire terminal session. Restore a healthy baseline before starting the next incident.

## 3. Investigate the database-service failure

Exit the MySQL client to return to Bash. Predict what will happen to a new database connection and the Nginx welcome page when you stop only MySQL. Introduce that failure using the service controls.

Choose your checks again. Include the failed reader connection, a process or listener check, and the web request while the database is unavailable. Expect a connection error such as MySQL error `2003`; without a `mysql>` prompt, you cannot submit the SQL query. Explain the results before repairing the service. Repeat the identical connection command after your repair, then run the same sum query. Show both the restored connection and the expected total `200.00`.

Use the same incident-record structure as above. Compare the two incidents: what changed, what continued to work, and what does that tell you about the connections in this lab? Distinguish an HTTP response status from a database client's error message.

## 4. Draw the system you tested

Draw by hand on paper or a whiteboard. You may also draw with a stylus on a tablet, as in Exercise 01. Make your own drawing of your environment; do not submit a screenshot of the instructor's board or an automatically generated diagram.

Use one drawing to show the healthy system. Include:

- Your laptop's browser and the remote Linux environment, with a clear boundary between them.
- GitHub's private web forwarding, Nginx, the MySQL client, and the MySQL server.
- Labeled request arrows, the relevant protocols, and ports 443, 80, and 3306. Show where `127.0.0.1` belongs and where your terminal commands run.
- A distinction between installed files and running services. Draw the connections your tests used, rather than inventing a connection between components.

Number the points you tested and use those same numbers in your report. Add a short note labeled "Incident A" at the part affected by the Nginx failure and "Incident B" at the part affected by the MySQL failure. These notes describe separate incidents, not two services failing at the same time.

Photograph the drawing and check that every label is readable. Save or export a real JPG as `service-diagram-firstname-lastname.jpg`; renaming a different image format to `.jpg` does not convert it. I am grading accuracy and the explanation, not artistic polish.

## 5. Connect your evidence to Session 03 and a job

Add these short responses to the report.

First, consider this supplied training example from the kind of dashboard investigation we did in Session 03. It is not a request to revisit the instructor's live EC2 lab or build a dashboard in your Codespace.

| Browser request | Reported result |
| --- | --- |
| `GET /sales` | HTTP 200 |
| `GET /api/sales` | HTTP 500 |

The page says "Sales data unavailable."

In a short paragraph, explain why the successful page request does not settle the problem. What do these two results establish, what do they leave unknown, and what additional evidence would you ask for before choosing a repair? Relate that distinction to your own service tests. Treat these supplied results as a separate example, not as output you collected yourself.

Second, choose three command arguments you used. For each, name the complete command, explain the argument's meaning, and say what would change if you omitted or changed it. Options with values, such as `-P 3306`, count as one choice.

Finally, search Indeed for one of the job titles we discussed, such as [Cloud Support Associate](https://www.indeed.com/jobs?q=Cloud+Support+Associate), [Systems Administrator](https://www.indeed.com/jobs?q=Systems+Administrator), or [Application Support Engineer](https://www.indeed.com/jobs?q=Application+Support+Engineer). Open a job description and record its title, employer, and link. Paraphrase one responsibility, then connect it to a specific check or repair you performed. If a posting disappears, identify the posting and the date you read it; do not invent a responsibility.

## 6. Save your evidence and stop the Codespace

After both retests pass, save the report outside the Codespace. Go to [Your Codespaces](https://github.com/codespaces), find your course environment, open its three-dot menu, and choose **Stop codespace**. Verify that it no longer shows as active, then add the stop time and any unresolved issue to your report.

Closing the browser tab does not stop the Codespace. Retained storage can still count toward usage after compute stops. You do not need to leave the environment running for grading, and you should not delete it for this exercise. [GitHub's stop/start instructions](https://docs.github.com/en/codespaces/developing-in-a-codespace/stopping-and-starting-a-codespace) explain the difference.

## How to create the report file

The report is a Markdown file, but you do not have to know Markdown syntax to write it. Use headings, short paragraphs, and selected command outputs. Keep the diagram in its separate JPG.

### Google Docs, recommended

1. Write your report normally in Google Docs. Use the report headings below if helpful.
2. Paste selected command outputs as text, preserving the important lines, numbers, and errors. Use a monospace font for commands and output if it helps readability. Do not add screenshot images or the drawing to this report.
3. Choose **File > Download > Markdown (.md)**. This exports the document; it is not the same as renaming a Google Doc or another file type. [Google's export instructions](https://support.google.com/docs/answer/12014036?hl=en) show these steps.
4. Name the downloaded file `service-investigation-firstname-lastname.md`. Open it in a text editor, or import a copy back into Google Docs, and check that the headings, explanations, commands, and outputs are present and readable. Confirm that the filename does not end in `.md.txt`.

Your downloaded `.md` file is the report you upload, not the Google Docs sharing link.

### VS Code or Cursor, if you already use one

Create a new text file, write the report, and save it as `service-investigation-firstname-lastname.md`. You may use simple Markdown headings and fenced code blocks for output. Inspect the saved file before uploading it. You do not need to install either editor just for this exercise, and you receive the same credit whichever writing route you use.

Suggested report headings:

- Starting point and plan
- Incident A: Nginx
- Incident B: MySQL
- Diagram notes and Session 03 comparison
- Three command arguments
- Job connection and shutdown

Keep each explanation close to its command output. Preserve actual output; if you remove unrelated lines, mark where you omitted them. Leave passwords, access tokens, recovery codes, and unrelated personal information out of the report.

## Command reference

This is a reference, not a required sequence. Choose commands that answer your question and explain why you chose them. Service controls and diagnostic commands run in the Codespace's Bash terminal. SQL runs at `mysql>`, as labeled below. These commands do not run on your laptop. If you are at `mysql>`, type `exit` to return to Bash first. Do not type the `$` prompt.

### Service controls

| Action available to you | Command |
| --- | --- |
| Start Nginx | `sudo service nginx start` |
| Stop Nginx | `sudo service nginx stop` |
| Start MySQL | `sudo service mysql start` |
| Stop MySQL | `sudo service mysql stop` |

`sudo` gives the following command administrator privileges inside this container. `service` controls the named service; `nginx` or `mysql` chooses which one; `start` or `stop` chooses the action. Stopping a service does not uninstall its package. Change only the one service named in the incident and restore it before the next incident.

### Checks you can choose

| Question | Command | How to read the arguments |
| --- | --- | --- |
| Which user and directory am I using? | `whoami` and `pwd`, on separate lines | Neither command needs an argument here. |
| Are the packages recorded as installed? | `dpkg-query -W nginx mysql-server` | `-W` shows package records, normally names and versions. The two names select packages; the database package is `mysql-server`, although its service is `mysql`. |
| Is the Nginx process present? | `ps -C nginx` | `-C nginx` selects the executable name. A header without process rows means no matching process was found. |
| Is the database-server process present? | `ps -C mysqld` | The server executable is `mysqld`; `mysql` is the client and service name. Use the server name for this process check. |
| Which TCP ports are listening? | `ss -lnt` | `l` selects listeners, `n` shows numbers instead of service names, and `t` selects TCP. These are combined options, equivalent to `-l -n -t`. Numeric display is a convenience; the listener/TCP selection defines this check. |
| Can the local web service answer? | `curl -I http://127.0.0.1` | `-I` sends HEAD for headers without the body. Repeat this same request after repair. If a request hangs, use Ctrl+C to return to the prompt. The URL targets this Codespace using HTTP's default port 80. |
| What does the database log show? | `sudo tail /var/log/mysql/error.log` | Administrator access; `tail` shows the last ten lines by default. The absolute path selects the database log. |
| What does the web request log show? | `sudo tail /var/log/nginx/access.log` | Administrator access; `tail` shows the last ten lines by default. This path selects the web request log. |

For a broader process view, start with `ps`, then `ps -e` for all processes and `ps -e -f` to include their owners. Plain `ps` shows a limited selection associated with your user and terminal; adding `sudo` is not how you select all processes.

For live request observation, run `sudo tail -f /var/log/nginx/access.log`. Leave it running and use a second Bash terminal for `curl -I http://127.0.0.1`. While Nginx is healthy, requesting `curl -I http://127.0.0.1/missing.html` should return 404 and produce a new log entry. A 404 shows that the server answered but could not find the requested page. Press Ctrl+C in the log terminal to stop watching; this does not stop Nginx. These are optional diagnostic choices, not extra incidents to submit.

An option's meaning belongs to its command. Do not assume that a letter means the same thing in another program. Log output may be empty or contain older events; explain what a selected entry supports rather than treating any log line as the cause.

For option details, consult [dpkg-query](https://manpages.ubuntu.com/manpages/noble/man1/dpkg-query.1.html), [ps](https://manpages.ubuntu.com/manpages/noble/man1/ps.1.html), [ss](https://manpages.ubuntu.com/manpages/noble/man8/ss.8.html), [curl](https://curl.se/docs/manpage.html), or [tail](https://manpages.ubuntu.com/manpages/noble/man1/tail.1.html).

### Connect as the reader, then run SQL

The reader account can read the sales data without changing it. A Python
application could use this account to display those sales on a web page;
for this exercise, you test it using the MySQL client.

At the **Bash prompt**, use the same connection command for the baseline,
failed connection, and retest:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

| Part | Meaning |
| --- | --- |
| `-h 127.0.0.1` | Select the database server inside this Codespace, matching the account created in class. |
| `-P 3306` | Select the database port. Uppercase `-P` means port. |
| `-u lab_reader` | Use the read-only database account. |
| `-p` | Prompt for its password. Lowercase `-p` does not mean port. |

Enter the disposable class password `Session04-local-only` when prompted.
Its characters will not appear while you type. Do not put the password in
submitted output or reuse it elsewhere.

Once you reach **`mysql>`**, run:

```sql
SELECT SUM(amount) FROM session04.sales;
```

`SUM(amount)` adds the sales amounts. Expect `200.00`, a sales amount rather
than an HTTP status. If the connection failed and you are still at Bash,
record that error; do not type SQL into Bash.

After a successful query, return to **Bash** before controlling services:

```sql
exit
```

Use this reader connection consistently for your evidence. `sudo mysql`
opens an administrator session and does not test this reader account.

References: [MySQL connection options](https://dev.mysql.com/doc/refman/8.0/en/connecting.html)
and [client options](https://dev.mysql.com/doc/refman/8.0/en/mysql-command-options.html).

## How the 15 points are assigned

| Criterion | Points | What earns the points |
| --- | --- | --- |
| Failure evidence and repairs | 6 | Three per incident: actual failed-request evidence, a supporting process/listener check and repair, and an identical successful retest. Include the other service's result. |
| Reasoning | 4 | Explain the planned checks and what their outputs establish; compare the incidents; answer the Session 03 question; explain three command arguments. |
| Diagram and baseline | 3 | An accurate, readable drawing with boundaries, request paths, protocols, ports, and numbered evidence references, supported by a healthy web response and successful database connection and query. |
| Handoff and responsible operation | 2 | A readable report, a specific job-responsibility connection, and a shutdown note stating the stop time and anything unresolved. |
| **Total** | **15** | |

Your evidence matters more than a polished document. If a repair is incomplete, show what you tested and what remains unresolved; do not claim a successful retest you did not observe.

## Before you upload

- [ ] I completed both incidents in my own course environment and recorded actual results.
- [ ] My drawing is my own, its photo is legible, and its numbered points match my report.
- [ ] My report includes the plan, baseline, selected outputs, explanations, repairs, and identical retests.
- [ ] I answered the Session 03 comparison, explained three command arguments, and included one job connection.
- [ ] I saved my evidence, stopped the Codespace, and recorded its stop time or clearly reported a problem stopping it.
- [ ] I checked both filenames, removed passwords, tokens, and unrelated personal details, and inspected the downloaded files.
- [ ] I uploaded exactly two separate files to Brightspace: the JPG diagram and the Markdown report. I did not combine them or submit a repository or document-sharing link.

## If you get stuck

Read the error and check which prompt you are using. A command intended for Bash will not work as SQL. If the database or account is missing, get help with the class setup rather than repeatedly recreating it. If a service-start script prints a warning, inspect the process and request before deciding whether startup failed.

Post in the course Teams channel with what you were trying to do, the exact command and error with secrets removed, and what you already checked. If access or setup prevents individual work, contact me early. Identify any partner's demonstration as something you observed, not a test you ran yourself.
