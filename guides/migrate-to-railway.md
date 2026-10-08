# Migrate your resume site to Railway

Session 12 · Thursday, October 8, 2026

Move your Azure resume site and its current data to a Railway web service and Railway PostgreSQL. Keep Azure running until the app, data, domain, and HTTPS all work. Finish what's left for homework.

## 0. Before you start

1. Your VM is running, auto-shutdown is off, and your SSH rule has today's IP from ifconfig.me.
2. VS Code is open on `career-platform` with a new Claude Code session, renamed with `/rename` to something like `railway-migration`.
3. You're signed in to Railway with GitHub, and https://railway.com/verify says Full Trial. If it says Limited, tell the instructor.
4. This guide is open on github.com, so you see fixes as they're pushed.

Sections 4 and 5 happen in the Railway and Cloudflare dashboards on purpose, so you see what a service, a variable, a deploy log, and a DNS record look like. Each one then gets a CLI, once you know what it's abstracting. That's the pattern from here on: dashboard first, then the CLI, because the CLI is what your agent uses.

## 1. Check your starting point

Ask your agent:

> SSH to my VM and tell me which commit the running site is on.

If it isn't on main, deploy main first: pull, restart the service, and check the site. The migration starts from the commit your site actually runs.

Choose one hostname, `yourdomain.com` or `www.yourdomain.com`. Railway's trial allows one custom domain, and those count as two. Write down the current Cloudflare record for it, so you can put it back. Trial terms: https://docs.railway.com/pricing/free-trial.

## 2. Plan and back up

Ask your agent, from inside your repository:

> Inspect my app and plan its move to Railway and PostgreSQL.

That triggers the Superpowers brainstorming skill, the same one that started your app. Answer its questions from what you know about your site, and let it write the spec and then the plan before anything changes.

Three things to say no to:

- If it asks about Codespaces or local PostgreSQL, say local development stays on SQLite.
- If its design seeds the database on deploy, say the current rows move from the VM and the seed stays out of deploy. A reseed is not a migration.
- If it plans a proxied Cloudflare record, SSL mode changes, or redirects, say the record stays DNS only and Railway issues the certificate.

One thing to add: tell it the app will sit behind Railway's proxy, so Uvicorn has to trust the forwarded protocol header. Without that the page builds `http://` links on an `https://` page and loads unstyled.

Then one more prompt:

> Back up the database on the VM and confirm you can read the backup.

Note where the backup went and the row counts. Keep exports, `.env`, passwords, and keys out of Git.

## 3. Make the same app work with PostgreSQL

> Do the plan's code tasks: PostgreSQL support, the Railway start command, and the transfer script. Commit and push. Stop before creating anything on Railway.

That triggers the Superpowers executing-plans skill. Read the diff. The connection URL comes from an environment variable, the app binds to `0.0.0.0` and Railway's `PORT`, and a page still loads when the database is down. Don't let it invent sample projects to make an empty site look full.

While the agent works, start section 4 in the Railway dashboard. The two don't depend on each other until the deploy.

## 4. Build the target and move data

Create a Railway project with a PostgreSQL service and a web service from your GitHub repo.

- Your repo won't be in the "Deploy from GitHub repo" list at first. Click "Configure GitHub App," which takes you to GitHub. Have your passkey ready. Add only `career-platform`, save, and come back. Now it's listed.
- On the web service, set the variable `DATABASE_URL` with Railway's picker to the Postgres service's `DATABASE_URL`. It looks like `${{Postgres.DATABASE_URL}}`.
- Nothing runs until you click Deploy at the top left. An error before that click is only the staged state.
- Under the web service's Settings, Networking, click Generate Domain. Open it exactly as shown, with no port. With empty tables it shows a default name, which is what you want before the transfer. If it loads without styles, the proxy fix from section 2 is missing. Tell the agent the stylesheet links come out as `http://` behind Railway's proxy and let it fix the start command.
- Confirm the migrations ran. Look for `alembic upgrade head` in the deploy log, or ask the agent to check the migration version on Railway. If the log says `relation "profiles" does not exist`, ask the agent to run the migrations against `RAILWAY_DATABASE_URL`.

That `DATABASE_URL` is private to the project, so your laptop can't use it for the transfer. On the Postgres service, Settings, Networking, enable TCP Proxy and click Deploy. Then in its Variables tab, copy `DATABASE_PUBLIC_URL` into your local `.env` as `RAILWAY_DATABASE_URL`. It contains the password, so it goes in `.env` and nowhere else: not in chat, not in Git. Tell the agent to read it from there. Leave the public address on. Your laptop needs it again in section 6.

Now move the rows. Ask the agent:

> Transfer the backup into the Railway database, then compare row counts and content between my VM database and the Railway database, table by table.

Keep its output. Check `git status` before anything is committed. The backup copy and comparison file on your laptop stay out of Git, so add their folder to `.gitignore` if it isn't already. Then open the Railway URL and read the page. Your profile, experiences, and skills should be the ones from your VM. A matching count alone doesn't prove it, so read the page.

## 5. Point your domain at Railway

This step replaces Tuesday's A record with a CNAME. An A record says "this name is this IP address." A CNAME says "this name is another name, look that one up." The VM had one fixed IP, so an A record fit. Railway's edge is many machines whose addresses change, so it gives you a name like `abc123.up.railway.app` and your domain points at that. When Railway moves things, the name still resolves and you change nothing.

You do this part yourself, in the two dashboards. The agent doesn't touch Railway or Cloudflare here. If its plan has a task for the domain, tell it you're doing that step by hand.

1. In Railway, open the web service, Settings, Networking, and under Public Networking click Custom Domain. Enter only your hostname. Railway shows a CNAME target and a verification TXT name and value. Copy both.
2. In Cloudflare, change that hostname's A record to a CNAME at Railway's target, DNS only, grey cloud. Add the TXT record. Leave every other record alone. Note the time you save.

While Railway waits for the record, ask the agent:

> Install the Cloudflare CLI from https://developers.cloudflare.com/cf/, log me in, and list the DNS records for my domain.

It installs `cf` with npm, and `cf auth login` opens a browser for you to approve. The list is the Cloudflare DNS page as a script sees it, and your new CNAME and TXT should be in it. From now on, that command is how you and the agent check a record.

In rehearsal the padlock came three minutes after the Cloudflare save. Visit `https://yourdomain.com`, click the padlock, and check the certificate is for your hostname and the page shows your data. Pending DNS or TLS is pending work, not success. If you see a redirect loop, find the instructor before changing anything in Cloudflare.

## 6. Prove it works, then write it down

Same pattern as Cloudflare: you've done the Railway dashboard by hand, now give your agent the same controls.

> Install the Railway CLI from https://docs.railway.com/cli, log me in, and link this repo to my Railway project.

It installs with npm, `railway login` opens a browser, and `railway link` asks which project. Pick the one you just built.

Prove the new database takes writes:

> Add one new skill to my Railway database and show me it on the live site.

Ask for a skill you actually have. When it appears at your domain, the site is reading and writing PostgreSQL on Railway, not the old SQLite file.

Prove an update. Make one small change, commit, and push. Find the same commit SHA in Railway's deployment history, wait for it to succeed, and see the change at your domain. On Azure that same update was pull, sync, and restart over SSH. Here it was a push.

Compare Tuesday with today. On Azure, HTTPS took a firewall rule, `server_name`, Certbot, domain validation, and a renewal timer. On Railway it took one hostname and two DNS records. The work didn't disappear. The platform took it on, and you pay for that. Railway now owns the host, routing, and the certificate. You still own code, runtime versions, settings, secrets, data, schema, DNS, testing, and recovery. Railway hosts the PostgreSQL service but calls it unmanaged, so backups and restores are yours too.

Then update the README before you stop Azure, because after cutover it describes a system that no longer exists:

> Update the README so it matches how the site runs on Railway now.

Review what it writes against what you did. The README needs the Railway and PostgreSQL setup and update path, the responsibility split above, two sentences on which of Tuesday's tasks moved to Railway, and how the migration kept your current data. Keep the Azure section as history and link your plan and comparison instead of pasting them. The project brief lists everything the README covers: [Keep a concise engineering record](../projects/own-your-corner-of-the-internet.md#8-keep-a-concise-engineering-record).

One of the README's decisions is this migration. Write it as a recommendation: you're the CTO of a three-developer startup on an Azure VM, and Railway offers to take the infrastructure. Should you move? Argue it with what you saw today: cost, your own hours, control, reliability, and what would change your answer.

Rollback is two different things. Reverting code is a push. Reverting data is not, because once Railway takes writes, pointing DNS back at Azure loses them. If you have to go back, pause writes and compare both databases first.

Only after the app, your data, your domain, and HTTPS all pass should you stop Azure. Confirm the VM says `Stopped (deallocated)`, and keep its disk for now. Deallocation stops compute billing, but the disk and IP still cost money, so write down what remains and when you'll remove it.

If Railway access is blocked, record the exact message and stop there. Finish the plan, backup, and code changes, and label the Railway steps **pending** in your README.

Before Tuesday, finish pending cutover checks and the README update. Link your plan, redacted comparison, results, rollback notes, and cost notes from `docs/project-1-submission.md`. Bring blockers to the instructor before choosing a paid plan.
