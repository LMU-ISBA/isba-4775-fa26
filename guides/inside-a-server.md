# Inside a server: in-class lab

**Session 04 · September 10, 2026 · 100 minutes**

**What makes a computer serve an application?** By the end of class, you will
start a web server and a database, inspect their processes and ports, and use
evidence to explain a failure and repair.

We will do all setup together during class. Bring your laptop and sign into
the GitHub account you set up for Exercise 01 when instructed. You do not need
to install VS Code, Nginx, MySQL, or a coding agent on your laptop for this lab.

Keep this guide in one browser tab and your Codespace in another. Follow the
instructor one section at a time. **Pause at each checkpoint.**

## Where our lab runs

Your laptop's browser connects to a development environment running in the
cloud. GitHub Codespaces provides a virtual machine and a Docker container
inside it. This diagram shows where the tools and services we use in this
lab fit. ([How Codespaces works](https://docs.github.com/en/codespaces/about-codespaces/deep-dive))

```text
┌──────────────────────────────────────────────┐
│               PHYSICAL SERVER                │
│                                              │
│   Real CPU • RAM • SSD • Network Card        │
│                                              │
│   ┌──────────────────────────────────────┐   │
│   │         VIRTUAL MACHINE (VM)         │   │
│   │                                      │   │
│   │ Virtual CPU • RAM • Disk • Network   │   │
│   │ Linux OS                             │   │
│   │                                      │   │
│   │   ┌──────────────────────────────┐   │   │
│   │   │       DOCKER CONTAINER       │   │   │
│   │   │                              │   │   │
│   │   │  Nginx                       │   │   │
│   │   │  MySQL                       │   │   │
│   │   │  Python                      │   │   │
│   │   │  Git                         │   │   │
│   │   │  Your code                   │   │   │
│   │   │                              │   │   │
│   │   └──────────────────────────────┘   │   │
│   │                                      │   │
│   └──────────────────────────────────────┘   │
│                                              │
└──────────────────────────────────────────────┘
```

- **Physical server:** the real computer that supplies the hardware.
- **Virtual machine:** a computer created in software, with allocated
resources and its own Linux operating system.
- **Container:** the isolated environment where our terminal commands,
services, and code run. It shares the VM's Linux kernel, the core of the
operating system.

Python and Git are already available in our Codespace. We will install
Nginx and MySQL during the lab. Your laptop displays the editor and pages;
the server programs run inside the container.

Jump to a section:

1. [Open your Linux environment](#01--open-your-linux-environment)
2. [Find your place and install software](#02--find-your-place-and-install-software)
3. [Start the web service and test it](#03--start-the-web-service-and-test-it)
4. [Open the web page and read its evidence](#04--open-the-web-page-and-read-its-evidence)
5. [Stop, investigate, and repair Nginx](#05--stop-investigate-and-repair-nginx)
6. [Start MySQL and query two sales](#06--start-mysql-and-query-two-sales)
7. [Stop MySQL while the web page still works](#07--stop-mysql-while-the-web-page-still-works)
8. [Build a sales page with the coding agent](#08--build-a-sales-page-with-the-coding-agent)
9. [Keep the work and prepare for Ex02](#09--keep-the-work-and-prepare-for-ex02)
10. [Explain the system and stop your Codespace](#10--explain-the-system-and-stop-your-codespace)



## 01 · Open your Linux environment

First, observe the instructor's failed web page. What would you check inside
the server? The failed page is in the instructor's prepared environment; your
new environment will get its services later in this lesson.

### Create your Codespace together

1. Sign into GitHub and open the [course repository](https://github.com/LMU-ISBA/isba-4775-fa26).
2. Click **Code**, then the **Codespaces** tab. Read the message showing who
  will pay for this environment. Check it with the instructor before creating.
3. Open the **…** menu in the Codespaces tab and choose **New with options**.
4. Confirm repository `LMU-ISBA/isba-4775-fa26`, branch **main**, and machine
  type **2-core**. Follow the instructor's demonstration to check your
   remaining included usage in GitHub's **Settings → Billing & licensing**.
   Return to the creation tab after checking.
5. Click **Create codespace** once and wait for the browser editor to load.
  If it is still loading, leave that tab open and tell the instructor.
6. If prompted to trust the folder, confirm it is the course repository, then
  choose **Trust Folder & Continue**. Wording may vary.
7. In the browser editor, choose **Terminal → New Terminal**. The menu may be
  inside the **☰** button at the upper left. You should see a terminal prompt.

If you already have a Codespace for this course, open
[Your Codespaces](https://github.com/codespaces), find the entry labeled
`LMU-ISBA/isba-4775-fa26`, and choose **… → Open in Browser**. Resume that
environment instead of creating another. Tell the instructor if you have
already installed the lab services or created its database.

If the repository is unavailable, Codespaces is missing, or GitHub blocks
creation because of access or usage, raise your hand. Do not add a payment
method or enable paid usage to get past the screen. The instructor will help
you or arrange temporary pairing and record the access problem.

**Checkpoint:** You have the course folder and a terminal open in the browser
editor. Where will commands run: your laptop or the remote Linux environment?
Pause here.

## 02 · Find your place and install software

Use the terminal **inside your Codespace** for the commands below. Run one line
at a time and wait for the prompt to return. Do not type the `$` prompt itself.

```bash
whoami
pwd
ls
cd /etc
pwd
ls
cd /workspaces/isba-4775-fa26
```

`whoami` identifies your Linux user, `pwd` prints your current directory, `ls`
lists its contents, and `cd` changes directories. Expect user `codespace` and
an initial directory of `/workspaces/isba-4775-fa26`. Tell the instructor if
your output differs. `/etc` contains system configuration files.

### Try updating the package catalog

Run this command first:

```bash
apt-get update
```

`apt-get update` downloads the latest list of available software packages and
versions so Linux knows what it can install; it does not install or upgrade
anything yet.

Expect a permission error: your regular Linux user cannot update the system's
package lists. Read the error with the instructor. What permission is missing?

Add `sudo` and try again:

```bash
sudo apt-get update
```

`sudo` runs the command with administrator permission inside your Codespace's
Linux container. The package-list update should now proceed. Wait for the
terminal prompt to return before continuing.

### Build the installation command

Read these versions with the instructor first. **Run the commands under
“Install Nginx, then MySQL” below**, after we have explained the additions.

Start with the basic request:

```text
apt-get install nginx
```

`apt-get` is the package-management program, `install` is the action, and
`nginx` is the package to install. The action and package name are arguments
passed to the program. This says what we want, but installing system software
also requires administrator permission.

Add `sudo` for administrator permission, just as we did for `apt-get update`:

```text
sudo apt-get install nginx
```

The permission error from the update command explains why we need `sudo`
here too.

### Install Nginx, then MySQL

We are installing two services to see how a server delivers web content and
stores data:

- `nginx` **provides a web server.** It receives HTTP requests and serves web
content, such as HTML pages. We will use its welcome page to test whether
the web service is answering requests.
- `mysql-server` **provides a database server.** It stores data in tables and
answers SQL queries. We will store two fictional sales and query their total.

These services work independently in this lab. Application code would be
needed to connect a web page to the database.

With the package catalog updated, install Nginx first:

```bash
sudo apt-get install nginx
```

**Pause at the installation summary.** Find the additional packages APT plans
to install, the download size, and the additional disk space it will use.
Additional packages are dependencies: software Nginx needs to work.

When you see `Do you want to continue? [Y/n]`, read it with the instructor,
then type `Y` and press Enter to approve the installation. `n` would cancel
before installation begins. If Nginx is already installed and no changes are
needed, APT may finish without asking; read its output before continuing.

Wait for installation to finish and the terminal prompt to return. Then use
the same command structure, replacing `nginx` with `mysql-server`, to install
MySQL:

```bash
sudo apt-get install mysql-server
```

Review MySQL's package list, download size, and disk-space summary too. When
prompted, type `Y` and press Enter, then wait for installation to finish.

`mysql-server` is the package name; later, we will control its service using
the name `mysql`.

If a package configuration screen or another unfamiliar question appears,
pause and read it with the instructor before answering. Prompts can vary with
the package version and what is already installed; you may not see any extra
configuration questions.

Each installation can take several minutes. If you see
`policy-rc.d denied execution of start`, wait for the installation to finish;
the container may prevent services from starting automatically. Do not start
another installation while one is running or delete package-manager lock files.

**Checkpoint:** Both packages have finished installing and the terminal prompt
has returned. Does that prove a service can answer a request? Pause here.

## 03 · Start the web service and test it



### Check the installed packages and process

First, check whether the packages are installed:

```bash
dpkg-query -W nginx mysql-server
```

Expect the package names and versions. This does not tell us whether either
service is running.

Start with the basic process command:

```bash
ps
```

`ps` shows a snapshot of processes. By default, it shows processes belonging
to your user and associated with the current terminal, typically including
your shell and `ps` itself. Look at `PID` for the process ID and `CMD` for the
command name. This is not a list of every process running in the Codespace.

**Predict:** Does seeing only a few rows mean only a few processes are running?

Add `-e` to show all processes visible inside your Codespace, including those
owned by other users and those without a controlling terminal:

```bash
ps -e
```

Compare the number of rows with plain `ps`. In the `TTY` column, a value such
as `pts/0` identifies a terminal; `?` means the process has no controlling
terminal. Background services can run without being attached to your terminal.

Add `-f` for a fuller listing that includes the process owner:

```bash
ps -e -f
```

Look at `UID` to see which account owns each process. Do all processes belong
to your user? `-e` selects all processes; `-f` changes the details displayed.

You do not need `sudo` for these checks. Adding `sudo` changes which user runs
`ps`, but it does not remove the default terminal filter. Here we need to
change the selection with an option, not request administrator permission.

Now replace `-e -f` with `-C nginx` to narrow the view to processes named
`nginx`, including those outside your current terminal:

```bash
ps -C nginx
```

Compare this focused view with the full list. If you see only the column
headings, no matching process was found. If Nginx is already running, tell
the instructor; everyone may not have the same starting state. A `?` in its
TTY column explains why it was absent from plain `ps`.

Start Nginx:

```bash
sudo service nginx start
```

`service` controls the named service, `nginx` selects it, and `start` tells it
what to do. Repeat the process check:

```bash
ps -C nginx
```

Expect one or more Nginx processes. What changed after starting the service?

### Find the listening port

Start by asking `ss` to show listening sockets:

```bash
ss -l
```

`-l` selects sockets waiting for connections. The list may include several
types of sockets. Add `-t` to select TCP:

```bash
ss -l -t
```

Now add `-n` to display numeric addresses and port numbers instead of names:

```bash
ss -l -t -n
```

Look for `:80` in the local address column. That is the HTTP port Nginx uses
in this lab. These options can also be combined as `ss -lnt`; it means the
same thing. We will use this shorter form for the remaining checks.

### Make a web request

Request the page with `curl`:

```bash
curl http://127.0.0.1
```

Expect the welcome page's HTML in your terminal. `curl` retrieves the page's
content; it does not draw the page like a browser. In this terminal,
`127.0.0.1` means your Codespace, and HTTP uses port 80 by default.

Add `-I` to request just the response headers using HTTP HEAD:

```bash
curl -I http://127.0.0.1
```

Look for HTTP `200` in the first line. The headers let us check the response
status without reading the page's HTML.

Use `curl -I http://127.0.0.1` for every failure and retest below so the
checks remain comparable. If a request hangs, press **Ctrl+C** to interrupt it
and return to the terminal prompt.

**Checkpoint:** Point to evidence for each claim: package installed, process
running, port listening, request successful. Pause here.

## 04 · Open the web page and read its evidence

1. In the Codespace, open the **Ports** tab beside the terminal. If hidden,
  use **View → Open View…**, search for **Ports**, and select it.
2. Choose **Forward a Port** (or **Add port**) and enter `80`, then press
  Enter. If port 80 is already listed,
   use that row.
3. Verify **Port Visibility** is **Private**. You can inspect or change it
  from the port row's context menu.
4. On the **port 80 row**, open the **HTTPS link** in the **Forwarded Address**
  column using **Open in Browser**. Use a browser session already signed into
   the **same GitHub account that owns your Codespace**.

Because the port is **Private**, the link requires your GitHub authentication.
A private/incognito window without that sign-in, or another student's browser
signed into their own account, cannot access your page. An incognito window
can work after you sign into your own GitHub account there. Each student
should open the HTTPS link from their own Codespace.

Expect **Welcome to nginx!** Use the forwarded address for the browser;
`127.0.0.1` in your laptop's browser refers to your laptop. Keep database ports
3306 and 33060 unforwarded.

The browser uses GitHub's HTTPS forwarding on port 443. Nginx still listens
for HTTP on port 80 inside the Codespace.

Follow the instructor's short demonstration of web content and logs:

```bash
cd /var/www/html
ls
```

This is Nginx's web-content directory. Find the welcome-page file, then read
its beginning:

```bash
head index.nginx-debian.html
```

`head` shows the first ten lines by default. Recognize any HTML from the
earlier `curl` request?

Read the end of the request log:

```bash
sudo tail /var/log/nginx/access.log
```

`tail` shows the last ten lines by default. Look for a record of a request.

### Watch requests arrive with `tail -f`

Add `-f` to follow the log as new lines are written:

```bash
sudo tail -f /var/log/nginx/access.log
```

You will see the last ten lines again, then the command stays running and
displays new entries as requests arrive. The terminal prompt will not return
while `tail -f` is watching the file.

Leave this terminal watching the log. Choose **Terminal → New Terminal** to
open a second terminal in the same Codespace. In that **second terminal**,
request the welcome page's headers:

```bash
curl -I http://127.0.0.1
```

Expect HTTP `200`. Switch back to the terminal running `tail -f` and find the
new entry containing `HEAD / HTTP/1.1` followed by `200`. `-I` makes curl send
HEAD, so the log records HEAD rather than GET. You can also refresh your
forwarded page in the browser and watch for a new `GET /` entry.

### Request a missing page and observe 404

Keep `tail -f` running. In the **second terminal**, request a path we have not
created:

```bash
curl -I http://127.0.0.1/missing.html
```

Expect HTTP `404 Not Found`. In the live-log terminal, find the new entry
containing `/missing.html` and status `404`. Compare it with
the earlier `200` entry: the server answered both requests, but it could not
find the page requested by the second one.

**Observe:** A `404` is evidence of an HTTP response from the web server.
It does not mean Nginx has stopped. Watching new log entries while making
requests helps connect a troubleshooting action to what the server observed.

When finished, return to the terminal running `tail -f` and press **Ctrl+C**.
This stops watching the log and returns to Bash; it does not stop Nginx.

Now inspect the error log:

```bash
sudo tail /var/log/nginx/error.log
```

The error log may include a missing-file message from the 404 request. Read
the path and message before deciding what failed. You can revisit these
inspection commands after the demonstration; keep pace with the instructor.

**Checkpoint:** Your private forwarded page loads, and you have matched a
successful request and a 404 response to new log entries. Explain why a 404
does not mean the service is stopped, and why HTTPS in the browser does not
mean Nginx is listening on port 443. Pause here.

## 05 · Stop, investigate, and repair Nginx

Discuss your predictions and observations as you work through the failure,
investigation, repair, and retest.

**Predict:** If you stop Nginx, will its installed package and web file disappear?

When instructed, stop Nginx and make a request:

```bash
sudo service nginx stop
curl -I http://127.0.0.1
```

Expect a connection failure, typically curl error `7`. This request goes
directly to Nginx inside the Codespace. With Nginx stopped, it cannot return
an HTTP response.

Now reload the same **HTTPS forwarded URL** in your browser, using the
GitHub-authenticated session from Section 04. You may see **HTTP ERROR 502
(Bad Gateway)**, as observed during our lab test.

The browser reaches GitHub's forwarding service, which cannot connect to
Nginx on port 80. In this stopped-service test, the 502 comes from the
forwarding layer. Compare the two paths: the direct request fails to connect;
the browser receives an HTTP error from the intermediary.

Investigate before repairing:

```bash
dpkg-query -W nginx
ps -C nginx
ss -lnt
```

Expect the package to remain while the Nginx process and port 80 listener are
absent. What is the smallest repair that evidence supports?

```bash
sudo service nginx start
curl -I http://127.0.0.1
```

Expect HTTP `200` again. Reload the same HTTPS forwarded URL in your browser
and confirm that **Welcome to nginx!** returns. Check recovery through both
the direct request and the browser.

**Checkpoint — pause and discuss:** What evidence pointed to a stopped service?
Explain why you chose this repair and how the identical retest shows recovery.

## 06 · Start MySQL and query two sales

MySQL is a second service with its own client and protocol. Predict whether
an HTTP request would be the right way to ask it for database rows.

Start the database service at your Codespace's Bash terminal prompt:

```bash
sudo service mysql start
```

Check its process:

```bash
ps -C mysqld
```

The service is named `mysql`, while the server process is named `mysqld`.
Check its listening port using the command we built earlier:

```bash
ss -lnt
```

Look for port 3306; port 33060 may also appear. Leave both unforwarded.

Open the MySQL client for local administration:

```bash
sudo mysql
```

The client program is named `mysql`. This command connects to the MySQL
server inside your Codespace as an administrator so you can set up the
database. Your prompt should now say `mysql>`. The commands in the next
steps go at that prompt, inside the database client.

### Run once at the MySQL prompt

Follow each step with the instructor. If you already created the database,
table, or account during an earlier attempt, ask before repeating that step.
Semicolons finish SQL statements; do not type the `mysql>` prompt itself.

**Create the database.** A database holds the tables for this activity:

```sql
CREATE DATABASE session04;
```

Expect `Query OK`. You have created the database, but it has no sales table yet.

**Create the sales table.** Give each sale an integer ID and an amount with
two decimal places:

```sql
CREATE TABLE session04.sales (id INT PRIMARY KEY, amount DECIMAL(10,2));
```

`session04.sales` means the `sales` table inside the `session04` database.
`PRIMARY KEY` makes each ID unique. Expect `Query OK`; the table is empty.

**Select the database.** Set the default database for this connection:

```sql
USE session04;
```

Expect `Database changed`. You can now refer to the table as `sales` without
the `session04.` prefix. This selection lasts until you switch databases or
close the connection.

**Inspect the table's structure.** See its columns and their data types:

```sql
DESCRIBE sales;
```

Look for `id` with type `int` and `amount` with type `decimal(10,2)`.
`PRI` identifies the primary key. The two rows here describe the two columns;
they are not sales records.

**Insert two fictional sales.** Each pair contains an ID and an amount:

```sql
INSERT INTO session04.sales VALUES (1,120.00),(2,80.00);
```

Expect two rows affected.

**View the sales you inserted.** `SELECT` reads data, and `*` requests all columns:

```sql
SELECT * FROM sales;
```

Because you ran `USE session04;`, `sales` refers to the table in that database.
Expect these two rows; their display order may vary:


| id  | amount |
| --- | ------ |
| 1   | 120.00 |
| 2   | 80.00  |


We will query these rows again and calculate their total after connecting
as a reader.

**Create a reader account.** Our Python application will use this account to
read sales data and display it on a web page. We’ll give it permission to read
the data, but not change or delete it. First, we’ll test the account ourselves
using the MySQL client; then we’ll use it in the application in Section 08.
This follows a useful rule: give an application only the permissions it needs.

This account will connect from inside the same Codespace, using `127.0.0.1`:

```sql
CREATE USER 'lab_reader'@'127.0.0.1' IDENTIFIED BY 'Session04-local-only';
```

The password is for this disposable lab only; do not reuse it elsewhere.
Creating an account does not yet give it permission to read our table.

**Grant permission to read.** `SELECT` allows this account to query tables in
`session04` without changing their data:

```sql
GRANT SELECT ON session04.* TO 'lab_reader'@'127.0.0.1';
```

Expect `Query OK`. The `*` applies to all tables in this database.

**Return to Bash.** Leave the administrator's database client:

```sql
exit
```

`exit` closes the client; it does not stop MySQL. Confirm that the `mysql>`
prompt has been replaced by your Bash prompt before continuing.

### Return to Bash and test the reader account

At the **Bash prompt**, connect as the reader:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

Read the connection options one at a time:

- `-h 127.0.0.1` selects the database server inside this Codespace. Use this
address to match the reader account we created.
- Uppercase `-P 3306` selects the database port.
- `-u lab_reader` selects the database account.
- Lowercase `-p` asks for the password.

At **Enter password:** type `Session04-local-only` and press Enter. Your
typing will not appear onscreen. Expect a `mysql>` prompt when connected.

At `mysql>`, view the rows first:

```sql
SELECT * FROM session04.sales;
```

`SELECT` reads data, and `*` requests all columns. Expect these two sales;
their display order may vary:


| id  | amount |
| --- | ------ |
| 1   | 120.00 |
| 2   | 80.00  |


Now ask MySQL to add the amounts:

```sql
SELECT SUM(amount) FROM session04.sales;
```

Expect a column labeled `SUM(amount)` with the value `200.00`. This is a
sales amount; the earlier HTTP `200` was a response status.

Leave the client before the next service-control command:

```sql
exit
```

Confirm you are back at **Bash**. We will repeat the same connection command
and sum query to verify recovery after the database failure.

**Checkpoint:** Explain which client contacted which service, over which
protocol and port. Pause here.

## 07 · Stop MySQL while the web page still works

**Predict:** If MySQL stops, will the Nginx welcome page still load? Why?

Confirm you are at the **Bash prompt**, then stop MySQL:

```bash
sudo service mysql stop
```

Repeat the web request:

```bash
curl -I http://127.0.0.1
```

Expect HTTP `200` from Nginx. Try the same database connection as before:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

Enter the lab password when prompted. Expect MySQL connection error `2003`
and a return to the **Bash prompt**. You cannot run the SQL query because
the connection failed before you reached `mysql>`. Compare the database
connection error with the successful web response. What does each tell you?

Investigate:

```bash
ps -C mysqld
ss -lnt
sudo tail /var/log/mysql/error.log
```

Look for the missing MySQL process and port 3306 listener. The last command
reads the last ten lines of the database's diagnostic log. Explain why the
web page still works before repairing MySQL.

Start MySQL again at the **Bash prompt**:

```bash
sudo service mysql start
```

Repeat the identical failed connection command:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

Enter the lab password again. This time, expect the `mysql>` prompt.
Repeat the same sum query from Section 06:

```sql
SELECT SUM(amount) FROM session04.sales;
```

Expect `200.00`, then return to Bash:

```sql
exit
```

**Checkpoint — pause and discuss:** Explain both pieces of recovery evidence:
the connection succeeded and the query returned the expected total. Why did
the welcome page survive the database failure? What would application code
have to do to make a page depend on MySQL?

## 08 · Build a sales page with the coding agent

So far, Nginx's welcome page has worked independently of MySQL. Now we will
use the coding agent built into Codespaces to create a Python application
that reads our sales table and displays it on a web page. This is a preview
of the AI-assisted workflow in Ex03.

Build along with the instructor in your own Codespace. Everyone starts with
the same interview prompt and pauses at each check. The follow-up questions
may differ between conversations. If chat is unavailable or reports a
usage limit, tell the instructor and follow the demonstration while access
is resolved.

### Start with an interview

Open **Chat** in your Codespace and select **Agent** from the mode selector
beside the message box. Use the built-in agent shown by the instructor;
you do not need to install another coding tool. Start with:

```text
Help me design a sales reporting page. Ask me one question at a time.
Give me multiple-choice options. Do not build until I'm ready.
```

This prompt gives AI a goal, tells it how to ask for information, and sets a
boundary on when it can start building. You do not need to know every
requirement before starting the conversation.

### Answer and refine the design together

Read each question with the instructor. Choose an option or write your own
answer if none fits. Ask the agent to explain an unfamiliar term before you
decide. If it asks several questions at once or starts writing code, remind
it: “One question at a time. We are still designing.”

As the interview develops, explain who the page is for, what they need to
see, and what should happen when the data is unavailable. For this lab, we
want to see our two sales and their total, then observe an error when MySQL
stops. Tell the agent that our database and reader account already exist.

Share the relevant setup details as they come up. These keep everyone's app
compatible with the startup commands and checks below:


| Topic                | Our lab setup                                                                                                                                                                    |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Existing data        | MySQL at `127.0.0.1:3306`, database `session04`, table `sales`, columns `id` and `amount`. Read the actual rows on every request.                                                |
| Database account     | `lab_reader`, with the password read from environment variable `DB_PASSWORD`. Keep passwords out of source files and browser errors.                                             |
| Application          | Python Flask with MySQL Connector/Python, serving `/` on port **8080**. Keep Nginx separate on port **80**.                                                                      |
| Files and startup    | `/workspaces/session04-demo/app.py` and `requirements.txt`. `python app.py` starts the server on `0.0.0.0:8080`, with debug mode and the reloader off.                           |
| Healthy page         | Show sale IDs, amounts, and total with two decimal places; return HTTP **200**.                                                                                                  |
| Database unavailable | Keep Python running, show **Database unavailable**, and return HTTP **503**, including for HEAD checks. Use a short database connection timeout and close connections after use. |
| Recovery             | Try the database again on each request so refreshing works after MySQL restarts. Do not substitute sample or cached sales, recreate data, or restart services automatically.     |


When the design seems clear, ask:

```text
Summarize the design we agreed on and how we will test it.
Do not build yet.
```

**Checkpoint:** Compare the summary with our lab setup. Can you explain what
the page will show while MySQL is working, stopped, and restarted? Correct
anything missing or misunderstood before moving on.

### Give the agent permission to build

When the instructor says the class is ready, tell the agent:

```text
I'm ready. Build the design we agreed on. Create the files and explain
what each does.
```

Read the agent's proposed file changes and any tool requests with the
instructor. Confirm it created `app.py` and `requirements.txt` in the demo
folder. The generated code still needs testing.

**Checkpoint:** Everyone has both files. Wait for the instructor before
starting the application.

### Start the Python application

At a **Bash prompt**, enter the demo folder:

```bash
cd /workspaces/session04-demo
```

Create a Python environment for this application's packages, then activate it:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Install the packages listed by the agent. Flask serves the page;
MySQL Connector/Python lets Python read the database:

```bash
pip install -r requirements.txt
```

Set the disposable lab password for the application in this terminal:

```bash
export DB_PASSWORD='Session04-local-only'
```

The app reads this environment variable when connecting as `lab_reader`.
Use only this lab password here.

Start the app and leave this terminal running:

```bash
python app.py
```

Wait for the startup message showing port **8080**. Use a **second Bash
terminal** for the checks below. If startup fails, show the instructor the
error before continuing.

### Open the sales page and check the baseline

In **Ports**, add **8080**, keep its visibility **Private**, and open that
row's **HTTPS forwarded address** in your GitHub-authenticated browser
session. Keep the Nginx page on port **80** open in a separate tab. Leave
MySQL ports **3306** and **33060** unforwarded.

The sales page should show IDs **1** and **2**, amounts **120.00** and
**80.00**, and total **200.00**. Compare them with your SQL results.

In the second terminal, check both web responses:

```bash
curl -I http://127.0.0.1
curl -I http://127.0.0.1:8080
```

Expect HTTP **200** from each. The browser reaches the Python application
through GitHub's forwarding, and Python reads MySQL on port 3306. Nginx
still serves its separate welcome page on port 80; it does not serve or
forward the Python page in this setup.

**Checkpoint:** Both pages work and the sales match your SQL results. Pause
here until the class is ready.

**Predict:** If MySQL stops, will Python still be able to respond to a web
request? Will it be able to display the sales?

### Stop the database and observe the application error

At the second terminal's **Bash prompt**, stop only MySQL:

```bash
sudo service mysql stop
```

Refresh both browser tabs. Expect the Nginx welcome page to keep loading,
while the sales page displays **Database unavailable**. Repeat both checks:

```bash
curl -I http://127.0.0.1
curl -I http://127.0.0.1:8080
```

Expect Nginx to return **200** and the Python application to return **503**.
The Python web server is still responding, but it cannot complete the sales
request because its database is unavailable. The application code produces
this 503; it differs from the forwarding layer's 502 when Nginx was stopped.

Check the listeners:

```bash
ss -lnt
```

Expect ports **80** and **8080** to remain, with **3306** absent. The app's
terminal should still be running. If the sales page keeps showing data or
returns 200 with an error message, compare the generated code with the
agreed design; that is not the intended behavior.

### Restore the database and repeat the request

```bash
sudo service mysql start
curl -I http://127.0.0.1
curl -I http://127.0.0.1:8080
```

Expect both responses to return **200**. Refresh the sales page and confirm
the actual rows and total **200.00** return without restarting Python.

**Checkpoint — pause and discuss:** What evidence shows that the Python web
server stayed up while its database was down? Why was a running web server
not enough to display the sales?

Press **Ctrl+C in the application's terminal** to stop Python after the
checks. Nginx and MySQL should remain running. Keep the demo files; to run it
again after resuming the Codespace, start MySQL, enter the demo folder,
activate `.venv`, set `DB_PASSWORD`, and run `python app.py` again.

## 09 · Keep the work and prepare for Ex02

We will use this environment again for **Ex02: Troubleshoot a cloud service**.
Follow the Ex02 brief provided by the instructor for graded submission
requirements. Collect your report evidence independently at home. The sales
page is a preview; **the full AI-assisted workflow is in Ex03**.

Stopping and resuming the same Codespace preserved the installed packages and
database rows in the instructor's rehearsal. Both services needed to be
started again. Rebuilding the container can remove manually installed
packages and database data outside `/workspaces`; deleting it removes the
environment. Do not rebuild or delete this lab to troubleshoot a service.

When you return, open [Your Codespaces](https://github.com/codespaces), find
your course environment, and choose **… → Open in Browser**. In its terminal:

```bash
sudo service nginx start
sudo service mysql start
```

Then repeat Section 03's final web check,
`curl -I http://127.0.0.1`, and Section 06's reader connection
and sum query to check the baseline. Use `exit` to return to Bash after the
query. Do not repeat the database, table, or account creation steps.

**Checkpoint:** Explain the difference between stopping a service and stopping
the whole Codespace. Leave Nginx and MySQL working until Section 10.

## 10 · Explain the system and stop your Codespace

**Individual exit check:** Be ready to briefly explain one failure you observed,
the evidence you used to investigate it, and how you verified recovery.

You will independently collect evidence and create the detailed incident
report and system drawing in Ex02. Follow its brief for submission requirements.

Then stop your Codespace:

1. Open [Your Codespaces](https://github.com/codespaces).
2. Find your course environment and open its **…** menu.
3. Choose **Stop codespace** and verify it no longer says **Active**.

Closing the browser tab does not immediately stop the Codespace. Stopping it
ends active compute use, but retained storage still counts toward usage. Keep
the environment for Ex02 and follow the instructor's later cleanup directions.

**Final checkpoint:** You can explain your troubleshooting evidence, and your
course environment is stopped.

## If you get stuck


| What you see                                           | What to do                                                                                                                       |
| ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| Repository or Codespace access blocked                 | Raise your hand; keep the message visible. Do not create extra environments or change billing to bypass it.                      |
| Codespace still loading                                | Keep its tab open and tell the instructor. If temporarily paired, discuss what you observe on your partner's environment.        |
| Package installation still running                     | Wait for the prompt. Do not run another package manager or delete lock files.                                                    |
| `mysql>` when you need Bash                            | Type `exit` and press Enter. Confirm the Bash prompt before running shell commands.                                              |
| MySQL shows a continuation prompt after incomplete SQL | Type `\c` and press Enter to cancel the unfinished statement, then ask for help.                                                 |
| Database, table, or account already exists             | Stop and ask the instructor to check what already succeeded. Do not delete it or rerun the seed block repeatedly.                |
| A result differs from the guide                        | Keep the exact command and output visible and ask for help. Expected output is a comparison, not a substitute for your evidence. |




## Reference

- [Create a Codespace](https://docs.github.com/en/codespaces/developing-in-a-codespace/creating-a-codespace-for-a-repository?tool=webui)
- [Reopen a Codespace](https://docs.github.com/en/codespaces/developing-in-a-codespace/opening-an-existing-codespace?tool=webui)
- [View Codespaces usage](https://docs.github.com/en/billing/how-tos/products/view-productlicense-use)
- [Forward ports](https://docs.github.com/en/codespaces/developing-in-a-codespace/forwarding-ports-in-your-codespace)
- [Use chat in VS Code](https://code.visualstudio.com/docs/chat/chat-overview)
- [Flask quickstart](https://flask.palletsprojects.com/en/stable/quickstart/)
- [MySQL client basics](https://dev.mysql.com/doc/mysql-getting-started/en/)
