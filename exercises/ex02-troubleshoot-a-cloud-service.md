# Exercise 02: Troubleshoot a cloud service

**Due date: See Brightspace.**

**15 points · Individual exercise · Allow 60–90 minutes, including the report and drawing**

Use your Session 04 Codespace to investigate two controlled failures: a stopped web server and a stopped database. Show what failed, what kept working, and how you verified recovery. Collect your own evidence at home.

Write your report in Google Docs, then export it to a PDF. You can paste screenshots or copy and paste text.

## Before you start

Resume your existing environment from [Your Codespaces](https://github.com/codespaces). It should contain Nginx, MySQL, the five sales in `session04.sales`, and the `lab_reader` account from the [class guide](../guides/running-and-troubleshooting-services.md). Get help if setup is incomplete or access is blocked; do not rebuild the container or change billing settings to proceed.

Run commands in the Codespace's terminal. Keep port **80 Private** and open its **HTTPS forwarded address** in a browser signed into the GitHub account that owns the Codespace. Leave database ports **3306** and **33060** unforwarded.

This exercise tests the Nginx welcome page and MySQL directly. You do not need to build or run the agent-generated application.

## 1. Confirm a healthy baseline

Start Nginx and MySQL if needed. Before stopping either service, confirm:

- The local web request returns HTTP **200**, and the browser displays the Nginx welcome page.
- The reader account connects, and the sum query returns **500.00**.

Include the web response and database connection/query output in your report, plus one sentence about the browser result. Resolve any baseline problem before introducing a failure.

## 2. Investigate Nginx

For **Incident A**, stop only Nginx and test the local web request. Investigate using a process or listener check, and check that the reader can still connect and query MySQL. After repairing Nginx, repeat the identical web request and refresh its browser page.

Restore Nginx before starting the next incident. Use the Session 04 guide for commands.

## 3. Investigate MySQL

For **Incident B**, exit the MySQL client before stopping only MySQL. Test a new reader connection, investigate using a process or listener check, and check that Nginx still answers. A failed connection leaves you at Bash, so you cannot submit SQL yet. After repair, repeat the identical connection command and run the sum query to verify **500.00**.

## 4. Draw and explain the system

Make one hand-drawn diagram on paper, a whiteboard, or a tablet. Include:

- Your laptop's browser and a boundary around the remote Codespace.
- GitHub's forwarding, Nginx, the MySQL client, and the MySQL server.
- Request arrows labeled with HTTP/HTTPS or database traffic and ports **443**, **80**, and **3306**. Show where terminal commands run and what `127.0.0.1` refers to there.

Draw the connections you tested. Photograph or export your own drawing as a readable JPG.

Answer this question in a short paragraph in your report:

> Why did the Nginx welcome page keep working when MySQL stopped? How would a page that reads sales from MySQL behave differently?

## 5. Finish your report and stop the Codespace

Check that your Google Doc says **Saved to Drive** and your diagram photo is on your laptop or in Drive. In [Your Codespaces](https://github.com/codespaces), choose **… → Stop codespace** and verify it no longer shows as active. Under **Shutdown** in your report, confirm that you verified this and note any unresolved issue. Closing the browser tab does not stop the environment.

## Your report

Use these headings in Google Docs:

- **Baseline**
- **Incident A: Nginx**
- **Incident B: MySQL**
- **System explanation**
- **Shutdown**

For each incident, answer:

1. **Predict:** What will fail, and what should keep working?
2. **Observe:** What command failed? Include its actual output.
3. **Investigate:** Show one process or listener check and explain what it tells you.
4. **Compare:** Show whether the other service still works.
5. **Repair and verify:** Show the repair and repeat the identical failed test. Explain the recovery evidence.

Under **System explanation**, answer the question in Task 4 about the Nginx welcome page and a page that reads sales from MySQL.

Brief explanations and selected command output are enough. Use your own results and drawing, and be prepared to explain them.

## Submit two files

1. `service-diagram-firstname-lastname.jpg` — a readable photo or export of your hand-drawn diagram.
2. `service-investigation-firstname-lastname.pdf` — your report. Choose **File → Download → PDF Document (.pdf)** in Google Docs.

Replace `firstname-lastname` with your name. Open both files to check readability, then upload them separately to Brightspace. Submit the files rather than a sharing link.

AI may help explain commands under the course policy. Your evidence and drawing must be your own, and you must be able to explain them. Remove passwords and tokens from submitted output. If a repair is incomplete, report what remains unresolved rather than claiming success.

## Compact command reference

Use the class guide for detailed explanations. Commands below run at the **Bash prompt** unless labeled SQL.

| Purpose | Command |
| --- | --- |
| Start Nginx | `sudo service nginx start` |
| Stop Nginx | `sudo service nginx stop` |
| Start MySQL | `sudo service mysql start` |
| Stop MySQL | `sudo service mysql stop` |
| Test Nginx | `curl -I http://127.0.0.1` |
| Check Nginx processes | `ps -C nginx` |
| Check the MySQL server process | `ps -C mysqld` |
| Check listening ports | `ss -lnt` |

Connect as the reader at **Bash**:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

Enter the class password `Session04-local-only` when prompted; typing is hidden. Once the prompt says **`mysql>`**, run this **SQL**:

```sql
SELECT SUM(amount) FROM session04.sales;
```

Expect **500.00**. Then return to Bash:

```sql
exit
```

Use the same reader account for every database check. If a command hangs, press Ctrl+C. If a result differs from expectations, keep the output and ask for help.

## Grading

| Criterion | Points | Evidence |
| --- | --- | --- |
| Two investigations | 8 | Four per incident: prediction and actual failure; diagnostic check with interpretation; other-service check; repair and identical retest. MySQL recovery includes the sum query. |
| Diagram and explanation | 4 | Accurate components, boundaries, arrows, and ports; a clear explanation of the database dependency. |
| Baseline and shutdown | 3 | Healthy web and database evidence (2); verified shutdown or a clearly documented shutdown problem (1). |
| **Total** | **15** | |
