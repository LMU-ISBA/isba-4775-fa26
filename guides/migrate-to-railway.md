# Migrate your resume site to Railway

Session 12 · Thursday, October 8, 2026

Move your Azure resume site and its current data to a Railway web service and Railway-hosted PostgreSQL. Keep Azure running until the app, data, domain, and HTTPS work. Finish remaining checks for homework.

Our example uses FastAPI, Uvicorn, and SQLite, so inspect your app before choosing commands. A starter app or reloaded seed rows are not a migration.

## 0. Before you start

Tuesday lost half an hour to setup. Have these done before 1:45 PM:

1. Your VM is running, auto-shutdown is off, and your SSH rule has today's IP from ifconfig.me.
2. VS Code is open on `career-platform` with a new Claude Code session, renamed with `/rename` to something like `railway-migration`.
3. You're signed in to Railway with GitHub, and https://railway.com/verify says Full Trial. If it says Limited, tell the instructor.
4. This guide is open on github.com, so you see fixes as they're pushed.

## 1. Check your starting point

Bring the tested branch from the [website design activity](improve-your-site-design.md), and identify the commit Azure actually serves. Ask your agent:

> SSH to my VM and tell me which commit the running site is on.

If it isn't on main, deploy main first: pull, restart the service, and check the site. The migration starts from the commit your site actually runs. Preserve your Exercise 04 evidence: Azure HTTP, controlled restart, domain HTTPS, certificate, and renewal. Exercise 04 is due today at 1:45 PM, so tell the instructor if that baseline is unfinished.

Check Railway's trial status, remaining credit, verification, and Usage page before provisioning. Current trial terms offer a one-time $5 credit for up to 30 days, followed by $1 in monthly Free plan credit. A limited trial can restrict networking, and stateful volumes may be lost after trial credits expire. Record *your* account dates and limits, and ask the instructor about a blocker before choosing a paid plan. See https://docs.railway.com/pricing/free-trial and https://docs.railway.com/pricing/plans.

Choose one hostname: `yourdomain.com` or `www.yourdomain.com`. Railway's trial permits one custom domain, and those names count as two. Keep Cloudflare as DNS provider, and privately record the current Azure record and how to restore it.

## 2. Inventory and back up

Ask your coding agent, from inside your existing repository:

> Inspect my app and plan its move to Railway and PostgreSQL.

That prompt triggers the Superpowers brainstorming skill, the same one that started your app. Answer its questions from what you know about your site, and let it write the spec and then the plan before anything changes. Two things to say no to. If it asks about Codespaces or local PostgreSQL, say local development stays on SQLite. If its design seeds the database on deploy, say the current rows move from the VM and the seed stays out of deploy, because a reseed is not a migration. If it plans a proxied Cloudflare record, SSL mode changes, or redirects, say the record stays DNS only and Railway issues the certificate. Review its findings against your running site. Locate the real entry point, runtime, dependencies, start command, database engine and location, schema, secrets, and local file writes. Git carries tracked code, but it doesn't carry database rows, environment variables, or DNS. Railway's app filesystem must not be the permanent home of your SQLite data.

Before transfer, one more prompt:

> Back up the database on the VM and confirm you can read the backup.

Note where the backup went and the row counts it reports. Keep exports, `.env`, passwords, and keys out of Git.

If you cannot identify the source database, find it before creating a target that only *looks* healthy.

## 3. Make the same app work with PostgreSQL

Have your agent adapt the reviewed app, then inspect the diff. Read the connection URL from an environment variable, and check SQLite-specific SQL, placeholders, IDs, types, transactions, and migrations. Keep a healthy page and useful behavior when the database is unavailable. For the class example, healthy is HTTP 200, while an unavailable database gives HTTP 503 with the profile still visible. Do not invent sample projects to make an empty target look complete.

Railway needs the web process to bind to `0.0.0.0` and its `PORT`. A possible FastAPI command is:

```text
uv run --no-dev uvicorn <actual_module>:<actual_app> --host 0.0.0.0 --port $PORT
```

Replace the placeholders after inspecting your app. A Dockerfile may need an explicit shell to expand `$PORT`, so confirm the real command and logs in Railway. See https://docs.railway.com/deployments/start-command. Run your app's meaningful local tests against disposable PostgreSQL if available, and record what actually passed. A local test does not prove a Railway deployment.

## 4. Build the target and move data

Create a Railway project with a PostgreSQL service and a web service connected to your existing GitHub repository and chosen branch. When you pick "Deploy from GitHub repo," Railway asks to install its GitHub App. Choose only `career-platform`, and have your GitHub passkey or password ready, since GitHub re-authenticates there. Add a Railway-provided web domain for testing, and put secrets in service Variables, not Git. Use Railway's variable picker to set web `DATABASE_URL` to the PostgreSQL service's `DATABASE_URL`. If named `Postgres`, the reference looks like `${{Postgres.DATABASE_URL}}`. Deploy staged changes and inspect build and deploy logs.

That database URL is private to the Railway project, so it will not connect from your laptop. If your reviewed transfer needs an external client, enable temporary public database access only for the transfer, then remove it and check any proxy cost. See https://docs.railway.com/databases/postgresql.

Apply the reviewed schema method to the empty target, then transfer the backed-up rows with an engine-appropriate method and confirm the transaction results. If you insert explicit IDs, check the PostgreSQL identity sequence so the next new row will not collide.

Compare source and target before changing DNS. Ask the agent:

> Compare row counts and content between my VM database and the Railway database, table by table.

Keep its output. Then open the Railway-provided URL and check that your profile, experiences, and skills are the ones from your VM, not seed data. A matching count alone does not prove matching data, so read the page.

## 5. Test the Railway URL, then the domain

At the Railway-provided HTTPS URL, check status, profile, your experiences and skills, links, and layout. Check logs for SQL and connection errors, then test database failure and recovery in a safe isolated setting. For this class app, the expected sequence is:

```text
GET / → 200, profile and your data visible
safe database-failure test → 503, profile and unavailable message visible
recovery, GET / again → 200, your data returns
```

Record actual URLs, times, statuses, and visible text because these lines are expectations, not proof. Never interrupt a live site just to force a 503. If a safe Railway failure test is unavailable, show a local test and mark the Railway check pending.

Keep the network paths distinct:

```text
DNS: browser's resolver ↔ Cloudflare authoritative DNS
HTTPS before: browser → Azure Nginx/TLS → app → source database
HTTPS after:  browser → Railway edge/TLS → app → Railway PostgreSQL
```

DNS gives the destination, while the subsequent HTTPS request goes to the destination rather than through the DNS server. Write down your source snapshot time, write-freeze state, data comparison, Railway URL result, current Azure DNS record, and rollback decision. Keep Azure running until the checks pass.

This step replaces Tuesday's A record with a CNAME. An A record says "this name is this IP address." A CNAME says "this name is another name, look that one up." The VM had one fixed IP, so an A record fit. Railway's edge is many machines whose addresses change, so it gives you a name like `abc123.up.railway.app` instead, and your domain points at that. When Railway moves things, the name still resolves and you change nothing. The cost is one more lookup and trusting Railway's DNS for the last hop.

In Railway, add only your hostname to the web service. Copy the CNAME target and verification TXT name/value shown there. In Cloudflare, replace only that hostname's Azure routing record and add the TXT record. Cloudflare can flatten a CNAME at the apex, and this setup uses DNS-only. Preserve mail records and every unrelated hostname rather than inventing a Railway IP. Follow the actual instructions if they differ: https://docs.railway.com/networking/domains/working-with-domains.

Wait for Railway domain verification and certificate issuance. Check DNS, then visit the chosen `https://` URL and verify certificate hostname and validity, status, links, profile, and your data. Record the date and network. Try another network if caches disagree. Pending DNS or TLS is pending work, not success. Diagnose a redirect loop with the instructor before proceeding. Do not change Cloudflare proxy mode without checking the TLS path.

## 6. Prove an update and plan recovery

First prove the new database takes writes. Ask the agent:

> Add one new skill to my Railway database and show me it on the live site.

Ask for a skill you actually have. When it appears at your domain, the site is reading and writing PostgreSQL on Railway, not the old SQLite file.

Then prove an update. Make one small reviewed change, test locally, commit, and push to the connected branch. Find the same commit SHA in Railway deployment history, wait for success, and see the changed page at your custom domain. On Azure that same update was pull, sync, and restart over SSH. Here it was a push. Record SHA, deployment, URL, time, and observed content. A CLI upload does not prove native GitHub autodeploy. See https://docs.railway.com/deployments/github-autodeploys.

Keep separate code and data rollback steps. Reverting code does not undo a schema change or new database writes. If Railway accepts writes after cutover, switching DNS back to Azure could lose them. Pause writes, compare both databases, and plan reconciliation before any rollback. Keep the private source backup and a target backup plan. Name who decides when writes resume.

Railway manages the host, routing, and custom-domain certificate. You still manage code, runtime and package versions, app settings, secrets, data, schema, DNS, checks, and recovery. Railway hosts the PostgreSQL service template but calls it unmanaged. You choose and verify its configuration, updates, monitoring, backups, and restore procedure. Add this responsibility split to your engineering record. See https://docs.railway.com/databases/postgresql.

Compare Tuesday with today. On Azure, HTTPS took a firewall rule, `server_name`, Certbot, domain validation, and a renewal timer. On Railway it took one hostname and two DNS records. The work didn't disappear. The platform took it on, and you pay for that. Write two sentences in your README on which of Tuesday's tasks moved to Railway and what you still own.

Update your README before you stop Azure. After cutover it describes a system that no longer exists, because the setup, update path, live address, and architecture all changed. Ask your agent:

> Update the README so it matches how the site runs on Railway now.

Review what it writes against what you actually did. The README needs the Railway and PostgreSQL setup and update path, the responsibility split above, and how the migration preserved current data. Keep the Azure section as history, and link your migration plan and comparison instead of pasting them. The project brief lists everything the README covers: [Keep a concise engineering record](../projects/own-your-corner-of-the-internet.md#8-keep-a-concise-engineering-record).

One of the README's decisions is this migration. Write it as a recommendation: you're the CTO of a three-developer startup on an Azure VM, and Railway offers to take the infrastructure. Should you move? Argue it with what you saw today: cost, your own hours, control, reliability, and what would change your answer.

Only after the app, current data, chosen domain, and HTTPS all pass should you stop Azure. Confirm the VM says `Stopped (deallocated)`. Keep its disk and rollback evidence for now. Deallocation stops VM compute billing, but retained resources can still cost money. Record what remains and when you will remove it. See https://learn.microsoft.com/en-us/azure/virtual-machines/states-billing.

If Railway access or setup is blocked, record the exact message and stop provisioning. Complete the source inventory, backup, plan, and local tests. Label your own PostgreSQL import, data match, Railway URL, domain, HTTPS, new skill, and autodeploy **pending** until tested on your system.

Before Tuesday, finish pending cutover checks and the README update. Link your plan, redacted comparison, results, rollback, responsibilities, and cost notes from `docs/project-1-submission.md`. Bring blockers to the instructor before selecting a paid plan.
