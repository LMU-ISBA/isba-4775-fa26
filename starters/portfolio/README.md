# ISBA 4775 portfolio

This starter becomes your portfolio for Networking & Cloud Computing, Fall 2026.

## Create your portfolio

1. Open [the instructor's template](https://github.com/LMU-ISBA/isba-4775-portfolio-template).
2. Choose **Use this template → Create a new repository**.
3. Set the owner to your personal account, the name to `isba-4775-portfolio`,
   and visibility to **Public**.
4. Add your `DB_PASSWORD` Codespaces secret with access to your new repository.
5. Create a Codespace from **your portfolio repository**. GitHub clones it for you.

You don't need to create an empty repository, manually clone the template,
or mark your portfolio as a template. If you're already in your own portfolio,
continue with the setup guide below.

## Work

- [Exercise 03 workspace](ex03/README.md): Session 5 setup and Python application.

Ex01 and Ex02 are submitted through Brightspace. Later exercise folders are
added when their briefs are published.

## Start here

Follow the [portfolio guide](guides/portfolio-repository.md)
to create your Codespace and configure `DB_PASSWORD` as a Codespaces secret.
Then follow the [Session 5 build-along](guides/database-to-application.md).

The scripts run inside the new Linux Codespace. Open each file and read it
with the instructor before running these commands from the repository root:

```bash
bash ex03/scripts/install-services.sh
sudo mysql < ex03/database/seed.sql
python3 ex03/scripts/configure-reader.py
```

The seed recreates the five fictional sales from Session 4. Rerunning it
fills missing sample IDs without replacing existing rows. This is sample-data
setup, not a backup of a database you have changed.

After stopping and reopening this Codespace, start the services again:

```bash
sudo service nginx start
sudo service mysql start
```

Restart your Python application separately using the command in `ex03/README.md`
after you have built it. Don't rerun the seed just to restart services.

## What belongs in Git

Commit source code, setup SQL, dependency files, plans, and explanations.
Keep passwords in Codespaces secrets. The `.gitignore` file excludes local
`.env` files, Python environments, and generated files. It doesn't remove
anything that was already committed.

Database files and installed software aren't saved by a Git commit. The setup
files describe how to recreate the lab in another environment.
