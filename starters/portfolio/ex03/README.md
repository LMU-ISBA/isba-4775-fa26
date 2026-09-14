# Exercise 03 workspace

We use this folder for the Session 5 build-along. The final Ex03 assignment
scope and deadline will be announced separately.

## Setup

From the repository root, run the three commands in the portfolio README.
The database is `session04`, the table is `sales`, and the reader account is
`lab_reader` at `127.0.0.1`. Supply its password through `DB_PASSWORD`.

Verify the data using the reader account:

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

Enter your own lab password when prompted. At the MySQL prompt, run:

```sql
SELECT * FROM session04.sales ORDER BY id;
SELECT COUNT(*), SUM(amount), AVG(amount) FROM session04.sales;
exit
```

The fresh seed contains five sales totaling 500.00, with an average of 100.00.
MySQL may show extra decimal places for the average.

## Application

During the build-along, record the Python packages, startup command, and local
URL here. Explain which code handles the request, queries MySQL, and returns
the page. Keep the forwarded web port private.

## Verification

Record your actual baseline result, database-failure result, and recovery
result. After the small change, record the count and average you observed.
State any checks you couldn't finish.

## What changed

After the second push, describe the change and identify the two application
commits. Explain how you checked that the original behavior still worked.
