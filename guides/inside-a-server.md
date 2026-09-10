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

Jump to a section:

1. [Open your Linux environment](#01--open-your-linux-environment)
2. [Find your place and install software](#02--find-your-place-and-install-software)
3. [Start the web service and test it](#03--start-the-web-service-and-test-it)
4. [Open the web page and read its evidence](#04--open-the-web-page-and-read-its-evidence)
5. [Stop, investigate, and repair Nginx](#05--stop-investigate-and-repair-nginx)
6. [Start MySQL and query two sales](#06--start-mysql-and-query-two-sales)
7. [Stop MySQL while the web page still works](#07--stop-mysql-while-the-web-page-still-works)
8. [Keep the work and prepare for Ex02](#08--keep-the-work-and-prepare-for-ex02)
9. [Explain the system and stop your Codespace](#09--explain-the-system-and-stop-your-codespace)



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

- **`nginx` provides a web server.** It receives HTTP requests and serves web
  content, such as HTML pages. We will use its welcome page to test whether
  the web service is answering requests.
- **`mysql-server` provides a database server.** It stores data in tables and
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
headings, no matching process was found. If Nginx is already running, record
that instead of assuming everyone has the same starting state. A `?` in its
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
in this lab. We will reuse `ss -l -t -n` for the remaining checks. You may see
these same options combined as `ss -lnt` elsewhere; they mean the same thing.

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

Open a notes document outside the Codespace, such as a document on your laptop.
Use this structure for each incident:


| Record        | What to write                                                     |
| ------------- | ----------------------------------------------------------------- |
| Prediction    | What you expect to change and what should remain                  |
| Failed test   | The command and selected actual output                            |
| Investigation | A process or listener check and what it tells you                 |
| Repair        | The action supported by your evidence                             |
| Retest        | The identical failed command, its new output, and your conclusion |


**Predict:** If you stop Nginx, will its installed package and web file disappear?

When instructed, stop Nginx and make a request:

```bash
sudo service nginx stop
curl -I http://127.0.0.1
```

Expect a connection failure, typically curl error `7`. A stopped web service
cannot return an HTTP status such as `500`.

Investigate before repairing:

```bash
dpkg-query -W nginx
ps -C nginx
ss -l -t -n
```

Expect the package to remain while the Nginx process and port 80 listener are
absent. What is the smallest repair that evidence supports?

```bash
sudo service nginx start
curl -I http://127.0.0.1
```

Expect HTTP `200` again. Reload the private forwarded web page too. Record the
failure, your investigation, repair, and identical retest in your notes.

**Checkpoint:** Explain how you know the web service recovered. Pause here.

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
ss -l -t -n
```

Look for port 3306; port 33060 may also appear. Leave both unforwarded.

Open the MySQL client for local administration:

```bash
sudo mysql
```

The client program is also named `mysql`. This command connects through a
local Unix socket. Your prompt should now say **`mysql>`**. The commands in
the next steps go at that prompt, inside the database client.

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

**Insert two fictional sales.** Each pair contains an ID and an amount:

```sql
INSERT INTO session04.sales VALUES (1,120.00),(2,80.00);
```

Expect two rows affected. We will view the rows and calculate their total
after connecting as a reader.

**Create a reader account.** This account will connect from the Codespace's
loopback address, `127.0.0.1`:

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

### Return to Bash and test TCP

At the **Bash prompt**, connect as the reader:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

Read the connection options one at a time:

- `-h 127.0.0.1` selects the host. This address makes the connection use TCP
  in this lab; keep it instead of substituting `localhost`.
- Uppercase `-P 3306` selects the database port.
- `-u lab_reader` selects the database account.
- Lowercase `-p` asks for the password.

At **Enter password:** type `Session04-local-only` and press Enter. Your
typing will not appear onscreen. Expect a **`mysql>`** prompt when connected.

At **`mysql>`**, view the rows first:

```sql
SELECT * FROM session04.sales;
```

`SELECT` reads data, and `*` requests all columns. Expect these two sales;
their display order may vary:

| id | amount |
| --- | --- |
| 1 | 120.00 |
| 2 | 80.00 |

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
the connection failed before you reached `mysql>`. Record the failed
connection command and actual error, along with the successful web response.

Investigate:

```bash
ps -C mysqld
ss -l -t -n
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

Enter the lab password again. This time, expect the **`mysql>`** prompt.
Repeat the same sum query from Section 06:

```sql
SELECT SUM(amount) FROM session04.sales;
```

Expect `200.00`, then return to Bash:

```sql
exit
```

Record both pieces of recovery evidence: the connection succeeded and the
query returned the expected total. Complete the second incident in your
notes using the same structure as Section 05.

**Checkpoint:** Both services work again. Explain why this welcome page
survived the database failure, and what application code would have to do to
make a page depend on MySQL. Pause here.

## 08 · Keep the work and prepare for Ex02

We will use this environment again for **Ex02: Troubleshoot a cloud service**.
Follow the Ex02 brief provided by the instructor for graded submission
requirements. **The AI-assisted workflow moves to Ex03.**

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
the whole Codespace. Leave both services working until Section 09.

## 09 · Explain the system and stop your Codespace

Write your own explanation using your actual observations:

1. Draw your laptop browser, GitHub's private forwarding, Nginx, the MySQL
  client, and MySQL. Label ports 443, 80, and 3306 and where commands run.
2. Explain how an installed package can exist without a running service.
3. Describe one failure, the evidence that narrowed it, your repair, and the
  identical retest.
4. Explain why the welcome page survived the MySQL failure and what an
  application connecting the two services would change.

Save your notes and drawing outside the Codespace. These class notes will
help you with Ex02; use its brief for the required submission files.

1. Open [Your Codespaces](https://github.com/codespaces).
2. Find your course environment and open its **…** menu.
3. Choose **Stop codespace** and verify it no longer says **Active**.

Closing the browser tab does not immediately stop the Codespace. Stopping it
ends active compute use, but retained storage still counts toward usage. Keep
the environment for Ex02 and follow the instructor's later cleanup directions.

**Final checkpoint:** Your notes are saved outside the Codespace and your
course environment is stopped.

## If you get stuck


| What you see                                           | What to do                                                                                                                |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| Repository or Codespace access blocked                 | Raise your hand; keep the message visible. Do not create extra environments or change billing to bypass it.               |
| Codespace still loading                                | Keep its tab open and tell the instructor. If temporarily paired, record what you observed on your partner's environment. |
| Package installation still running                     | Wait for the prompt. Do not run another package manager or delete lock files.                                             |
| `mysql>` when you need Bash                            | Type `exit` and press Enter. Confirm the Bash prompt before running shell commands.                                       |
| MySQL shows a continuation prompt after incomplete SQL | Type `\c` and press Enter to cancel the unfinished statement, then ask for help.                                          |
| Database, table, or account already exists             | Stop and ask the instructor to check what already succeeded. Do not delete it or rerun the seed block repeatedly.         |
| A result differs from the guide                        | Save the exact command and output and ask for help. Expected output is a comparison, not a substitute for your evidence.  |




## Reference

- [Create a Codespace](https://docs.github.com/en/codespaces/developing-in-a-codespace/creating-a-codespace-for-a-repository?tool=webui)
- [Reopen a Codespace](https://docs.github.com/en/codespaces/developing-in-a-codespace/opening-an-existing-codespace?tool=webui)
- [View Codespaces usage](https://docs.github.com/en/billing/how-tos/products/view-productlicense-use)
- [Forward ports](https://docs.github.com/en/codespaces/developing-in-a-codespace/forwarding-ports-in-your-codespace)
- [MySQL client basics](https://dev.mysql.com/doc/mysql-getting-started/en/)
