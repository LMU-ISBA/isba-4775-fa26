# Your portfolio repository

Session 05 · September 15, 2026

Your portfolio holds your application code, setup files, and explanations.
You'll create it during class and run it in a new Codespace. The repository
will be public, so keep passwords and personal interview material out of it.

Use the same name as everyone else: `isba-4775-portfolio`. Your address will be
`https://github.com/YOUR-USERNAME/isba-4775-portfolio`.

Ex01 and Ex02 still go to Brightspace. Keep Thursday's course Codespace
available for Ex02, and stop it before starting the new one.

## 1. Create your repository from the starter

Start from the instructor's portfolio template:
https://github.com/LMU-ISBA/isba-4775-portfolio-template

Use it to create a new repository in your own account. You don't need to start
with an empty repository, manually clone the template, or make your portfolio
a template. The instructor has already configured the starting repository.

1. Sign into GitHub and open the template link above.
2. Select **Use this template → Create a new repository**.
3. Choose your personal account as the owner.
4. Name the repository `isba-4775-portfolio` and make it **Public**.
5. Leave **Include all branches** unchecked, if shown. Create the repository.
6. Confirm the address begins with your username. Open its README and `ex03/` folder.

If you already have a portfolio with this name, keep it. Ask the instructor
to help add only the missing starter files without replacing your work.

Your repository starts with this structure:

```text
isba-4775-portfolio/
  README.md
  .gitignore
  guides/
    portfolio-repository.md
    database-to-application.md
  ex03/
    README.md
    plan.md
    database/
      seed.sql
    scripts/
      install-services.sh
      configure-reader.py
```

The setup files will recreate the services and fictional sales. You'll add
the Python application during the [Session 5 lab](database-to-application.md).

Pause here. Confirm that you own this repository and can open its settings.
The course repository remains the place to read course materials.

## 2. Supply the database password with a Codespaces secret

An environment variable is a named value available to a running program.
It lets the same application use different configuration in different places.
Some configuration is public, and some is sensitive:

| Name | Purpose | Lab value |
| --- | --- | --- |
| `DB_HOST` | Address of the database server | `127.0.0.1` |
| `DB_PORT` | Database listening port | `3306` |
| `DB_NAME` | Database to query | `session04` |
| `DB_USER` | Application's database account | `lab_reader` |
| `DB_PASSWORD` | Password for that account | Your own lab password |

A Codespaces secret stores a sensitive value and supplies it as an environment
variable in an authorized Codespace. The program can read that value, so an
environment variable isn't automatically hidden from programs or terminal output.

Create the secret before creating the new Codespace:

1. Open your GitHub profile menu, then **Settings → Codespaces**.
2. Beside **Codespaces secrets**, select **New secret**.
3. Name it `DB_PASSWORD`.
4. Enter a new password for this lab. Keep it in your password manager.
   Don't reuse a personal account password or Thursday's shared lab password.
   Use a single line without tabs or other control characters.
5. Under **Repository access**, select your `isba-4775-portfolio` repository.
6. Select **Add secret**.

Use Codespaces secrets here. GitHub Actions secrets supply CI/CD workflows,
which we'll use later. A secret in Actions doesn't configure this Codespace.

Don't paste the password into chat, source code, screenshots, or your README.
We'll check whether it's present without displaying its value.

GitHub's instructions explain repository access and secret availability:
https://docs.github.com/en/codespaces/managing-your-codespaces/managing-your-account-specific-secrets-for-github-codespaces

## 3. Create your portfolio Codespace

1. Return to your portfolio repository.
2. Select **Code → Codespaces → … → New with options**.
3. Confirm your repository, branch `main`, and the **2-core** machine type.
4. Check the usage and billing information with the instructor.
5. Create the Codespace and wait for the editor to open.
6. Open **Terminal → New Terminal**.

GitHub clones your portfolio automatically. Run these commands inside the
Codespace terminal:

```bash
pwd
ls ex03
```

The directory should be `/workspaces/isba-4775-portfolio`, and `ex03` should
contain the starter files.

This is a fresh environment. Thursday's installed services and MySQL data
belong to the old Codespace. We'll recreate the lab from the files you own.

Check for the secret without printing it:

```bash
python3 -c 'import os; print("DB_PASSWORD is set" if os.environ.get("DB_PASSWORD") else "DB_PASSWORD is missing")'
```

If it's missing, check the secret's name and repository access. Stop and
restart this Codespace if you added the secret after creating it. A container
rebuild isn't needed for that change.

Pause here. Explain how the password reaches Python without being in a file
committed to GitHub.

## 4. Recreate the services and data

Run these commands from the portfolio root. Open each file and read it with
the instructor first. Wait for one command to finish before running the next.

### Install and start the services

```bash
bash ex03/scripts/install-services.sh
```

The script updates the package catalog, installs Nginx, MySQL, and Python's
virtual-environment support, then starts the services. It checks the installed
packages and requests Nginx's response headers.

These are the commands we practiced in Session 4, saved in a file. The `-y`
option accepts the package installation prompt after we've reviewed the script.
Stop and read any error with the instructor before proceeding.

### Load the five sales

```bash
sudo mysql < ex03/database/seed.sql
```

The `<` symbol gives the SQL file to the MySQL client as input. The file
creates `session04.sales` and inserts the five fictional sales from Thursday.
Its final query should show a count of **5** and total of **500.00**.

Rerunning this file fills missing sample IDs without duplicating or replacing
existing rows. Student edits and additional rows remain, so changed data can
produce a different total. The file doesn't reset the database.

We have recreated sample data. A backup would preserve the current contents
of a database, including changes made after the sample was loaded.

### Configure the reader account

```bash
python3 ex03/scripts/configure-reader.py
```

This script reads `DB_PASSWORD`, configures MySQL's `lab_reader` account, and
grants it permission to read the sales table. It doesn't print the password.
Rerunning it also removes extra privileges granted directly to this lab account.
Run it as your regular Codespace user. It handles the administrator command
internally, so don't put `sudo` before `python3`.

Saving a GitHub secret didn't create the MySQL account. This step makes the
database account's password match the value the application will receive.

If you change the secret later, restart the Codespace, start MySQL, and rerun
this account setup. Then restart the application and test a new connection.

### Verify with the reader

```bash
mysql -h 127.0.0.1 -P 3306 -u lab_reader -p
```

Enter your new lab password when prompted. It won't appear as you type.
At the `mysql>` prompt, run:

```sql
SELECT * FROM session04.sales ORDER BY id;
SELECT COUNT(*), SUM(amount), AVG(amount) FROM session04.sales;
exit
```

Expect IDs 1 through 5, count **5**, total **500.00**, and average **100.00**.
MySQL may display additional decimal places for the average.

Pause here. Explain what each setup file contributed. Then continue with the
[Session 5 build-along](database-to-application.md).

## 5. Save, stage, commit, and push

We'll use this sequence for the working application and its follow-up change.

| Action | What it does |
| --- | --- |
| Save | Writes the edited file in this Codespace |
| Stage | Selects the changes for the next commit |
| Commit | Records a version in this Codespace's Git repository |
| Push | Copies the commits to your repository on GitHub |

A push doesn't deploy the application. Installed packages and live MySQL data
also aren't included in a Git commit. We commit the files that recreate them.

Save your files, then open **Source Control** in the left sidebar. Click each
changed file to review it, including new files. Check that no password appears
in the code or documentation. The starter ignores `.env`, `.venv/`, and caches.

From the repository root (`/workspaces/isba-4775-portfolio`), run three commands:

```bash
git add .
git commit -m "Build and verify the Python sales page"
git push
```

`git add .` stages the changes in this folder and its subfolders. `git commit`
records that version. `git push` sends it to your GitHub repository.

Open your portfolio on GitHub. Find the new commit and open `ex03/` to confirm
the files arrived. If a command fails or asks for identity information, stop
and show the instructor the message.

After the small change, save and review the files in Source Control again.
Run the same three commands from the repository root, changing the message:

```bash
git add .
git commit -m "Add sale count and average"
git push
```

Find both application commits on GitHub and compare them. The template's
initial commit will also appear in your history.

## 6. Finish and return later

Record the startup command and your checks in `ex03/README.md`. Submit the
portfolio URL through Brightspace when the instructor opens the Ex03 drop box.
The final Ex03 brief sets the assignment requirements and deadline.

Stop the portfolio Codespace from https://github.com/codespaces and verify its
status. Check that Thursday's Codespace is stopped too. Closing a browser tab
doesn't stop a Codespace.

When you resume this portfolio Codespace, start the services:

```bash
sudo service nginx start
sudo service mysql start
```

Then start the application using the command you recorded. Normal stop/start
preserves saved data. Creating a new Codespace or rebuilding its container
requires recreating software and any database data stored outside `/workspaces`.
Your seed file restores the sample, not later database changes.

If you committed a credential, tell the instructor. Removing it from the latest
file doesn't remove it from Git history. Replace the exposed credential and
work through the repository cleanup together.

## References

- https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template
- https://docs.github.com/en/codespaces/managing-your-codespaces/managing-your-account-specific-secrets-for-github-codespaces
- https://docs.github.com/en/codespaces/about-codespaces/understanding-the-codespace-lifecycle
- https://dev.mysql.com/doc/refman/8.4/en/batch-mode.html
