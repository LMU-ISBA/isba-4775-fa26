# Migrate your resume site to Railway

Session 12 · Thursday, October 8, 2026

Move your Azure resume site and its current data to a Railway web service and Railway PostgreSQL. Keep Azure running until the app, data, domain, and HTTPS all work. Finish what's left for homework.

## 0. Before you start

1. Your VM is running, auto-shutdown is off, and your SSH rule has today's IP from ifconfig.me.
2. VS Code is open on `career-platform` with a new Claude Code session, renamed with `/rename` to something like `railway-migration`.
3. You're signed in to Railway with GitHub, and https://railway.com/verify says Full Trial. If it says Limited, tell the instructor.
4. This guide is open on github.com, so you see fixes as they're pushed.

Sections 2 and 5 happen in the Railway and Cloudflare dashboards on purpose, so you see what a service, a variable, a deploy log, and a DNS record look like. Each one then gets a CLI, once you know what it's abstracting. That's the pattern from here on: dashboard first, then the CLI, because the CLI is what your agent uses.

## 1. Check your starting point

Ask your agent:

> SSH to my VM and tell me which commit the running site is on.

If it isn't on main, deploy main first: pull, restart the service, and check the site. The migration starts from the commit your site actually runs.

You'll move the root domain only, `yourdomain.com`, not `www`. Railway's trial allows one custom domain, and those count as two. The trial lasts 30 days or $5 of usage, and the Free plan after it allows no custom domain, so your site has a clock on Railway. That is why Azure stays running through this guide. Write down the current Cloudflare A record for `@`, so you can put it back. Trial terms: https://railway.com/pricing.

## 2. Build the empty target

This section is all in the Railway dashboard, by hand. Create a project with a PostgreSQL service first.

1. New Project, then Deploy PostgreSQL. Click Deploy at the top left.
2. On the Postgres service, Settings, Networking, enable TCP Proxy, and click Deploy again. That gives the database a public address, which your laptop needs for the transfer. It comes off at the end of section 6.
3. In the Postgres service's Variables tab, copy `DATABASE_PUBLIC_URL` into your local `.env` as `RAILWAY_DATABASE_URL`. It contains the password, so it goes in `.env` and nowhere else: not in chat, not in Git.

Now add the web service, but don't deploy it yet. Your code can't run on Railway until section 4.

4. Click Add at the top right of the canvas, then GitHub Repo. Your repo won't be in the list at first. Click "Configure GitHub App," which takes you to GitHub. Have your passkey ready. Add only `career-platform`, save, and come back. Now it's listed. Pick it.
5. On the new web service, Variables, add `DATABASE_URL` with Railway's picker, pointing at the Postgres service's `DATABASE_URL`. It looks like `${{Postgres.DATABASE_URL}}`.
6. Stop here. The web service and its variable stay staged until section 4. If you click Deploy now, Railway builds a repo that has no start command and no PostgreSQL support, and the deploy fails. Not harmful, just confusing. Wait for section 4 and deploy then.

You should see two services on the canvas: Postgres online, and the web service waiting.

## 3. Plan and back up

Ask your agent, from inside your repository:

> Inspect my app and plan its move to Railway and PostgreSQL. The Railway project already exists with Postgres and a web service.

That triggers the Superpowers brainstorming skill, the same one that started your app. Answer its questions from what you know about your site, and let it write the spec and then the plan before anything changes.

Two things to say:

- If its design seeds the database on deploy, say the current rows move from the VM and the seed stays out of deploy.
- Tell it the app will sit behind Railway's proxy, so Uvicorn has to trust the forwarded protocol header. Without that the page loads unstyled.

If it asks about Codespaces or local PostgreSQL, say no. Local development stays on SQLite.

Then one more prompt:

> Back up the database on the VM and confirm you can read the backup.

Note where the backup went and the row counts. Keep exports, `.env`, passwords, and keys out of Git.

## 4. Code, deploy, and move data

> Do the plan's code tasks. Commit and push. Don't create or change anything on Railway.

That triggers the Superpowers executing-plans skill. Read the diff. The connection URL comes from an environment variable, the app binds to `0.0.0.0` and Railway's `PORT`, and a page still loads when the database is down. Don't let it invent sample projects to make an empty site look full.

Once the push is on GitHub, go back to the Railway dashboard.

- Click Deploy at the top left. Watch the build and deploy logs on the web service.
- Confirm the migrations ran. Look for `alembic upgrade head` in the deploy log, or ask the agent to check the migration version on Railway. If the log says `relation "profiles" does not exist`, ask the agent to run the migrations against `RAILWAY_DATABASE_URL`.
- Under the web service's Settings, Networking, click Generate Domain. Open it exactly as shown, with no port. The 8080 in the logs is inside the container. With empty tables it shows a default name, which is what you want before the transfer.
- If the page loads without styles, the proxy fix from section 3 is missing. Tell the agent the stylesheet links come out as `http://` behind Railway's proxy and let it fix the start command and push. Railway redeploys on the push.

Now move the rows. Ask the agent:

> Transfer the backup into the Railway database, then compare row counts and content between my VM database and the Railway database, table by table.

Open the Railway URL and read the page. Your profile, experiences, and skills should be the ones from your VM. A matching count alone doesn't prove it, so read the page.

## 5. Point your domain at Railway

This step replaces Tuesday's A record with a CNAME. An A record says "this name is this IP address." A CNAME says "this name is another name, look that one up." The VM had one fixed IP, so an A record fit. Railway's edge is many machines whose addresses change, so it gives you a name like `abc123.up.railway.app` and your domain points at that. When Railway moves things, the name still resolves and you change nothing.

You do this part yourself, in the two dashboards. The agent doesn't touch Railway or Cloudflare here. If its plan has a task for the domain, tell it you're doing that step by hand.

1. In Railway, open the web service, Settings, Networking, and under Public Networking click Custom Domain. Enter your root domain, `yourdomain.com`, and nothing else. Railway shows a CNAME target and a verification TXT name and value. Copy both.
2. In Cloudflare, change the A record for `@` to a CNAME at Railway's target, DNS only, grey cloud. Add the TXT record. Leave every other record alone. Note the time you save.

While Railway waits for the record, ask the agent:

> Install the Cloudflare CLI from https://developers.cloudflare.com/cf/, log me in, and list the DNS records for my domain.

It installs `cf` with npm, and `cf auth login` opens a browser for you to approve. The list is the Cloudflare DNS page as a script sees it, and your new CNAME and TXT should be in it. From now on, that command is how you and the agent check a record.

In rehearsal the padlock came three minutes after the Cloudflare save. Visit `https://yourdomain.com`, click the padlock, and check the certificate is for your domain and the page shows your data. Pending DNS or TLS is pending work, not success. If you see a redirect loop, find the instructor before changing anything in Cloudflare.

## 6. Prove it works, then write it down

Same pattern as Cloudflare: you've done the Railway dashboard by hand, now give your agent the same controls.

> Install the Railway CLI from https://docs.railway.com/cli, log me in, and link this repo to my Railway project.

It installs with npm, `railway login` opens a browser, and `railway link` asks which project. Pick the one you just built. Then read back what you clicked through in section 2:

> Using the Railway CLI, show me the latest deployment, its logs, and my domains.

Everything in the dashboard has a command. That's what the agent will use from now on.

Prove the new database takes writes:

> Connect to my Railway database with the Railway CLI and add one new skill. Show me it on the live site.

Ask for a skill you actually have. When it appears at your domain, the site is reading and writing PostgreSQL on Railway, not the old SQLite file.

Prove an update. Make one small change, commit, and push. Find the same commit SHA in Railway's deployment history, wait for it to succeed, and see the change at your domain. On Azure that same update was pull, sync, and restart over SSH. Here it was a push.

Compare Tuesday with today. On Azure, HTTPS took a firewall rule, `server_name`, Certbot, domain validation, and a renewal timer. On Railway it took one hostname and two DNS records. The work didn't disappear. The platform took it on, and you pay for that. Railway now owns the host, routing, and the certificate. You still own code, runtime versions, settings, secrets, data, schema, DNS, testing, and recovery. Railway hosts the PostgreSQL service but calls it unmanaged, so backups and restores are yours too.

Then update the README, because after cutover it describes a system that no longer exists:

> Update the README so it matches how the site runs on Railway now.

Review what it writes against what you did. The README needs the Railway and PostgreSQL setup and update path, the responsibility split above, two sentences on which of Tuesday's tasks moved to Railway, and how the migration kept your current data. Keep the Azure section as history and link your plan and comparison instead of pasting them. The project brief lists everything the README covers: [Keep a concise engineering record](../projects/own-your-corner-of-the-internet.md#8-keep-a-concise-engineering-record).

One of the README's decisions is this migration. Write it as a recommendation: you're the CTO of a three-developer startup on an Azure VM, and Railway offers to take the infrastructure. Should you move? Argue it with what you saw today: cost, your own hours, control, reliability, and what would change your answer.

Rollback is two different things. Reverting code is a push. Reverting data is not, because once Railway takes writes, pointing DNS back at Azure loses them. If you have to go back, pause writes and compare both databases first.

Leave Azure running. Railway's trial ends in 30 days or at $5 of usage, and the Free plan after it drops your custom domain, so the VM is where your site goes back to. Note the trial end date in your README. The instructor will say when the VM can stop.

If Railway access is blocked, record the exact message and stop there. Finish the plan, backup, and code changes, and label the Railway steps **pending** in your README.

Last, on the Postgres service, Settings, Networking, remove the TCP Proxy and click Deploy. Your laptop doesn't need the database anymore, and the password-protected address is one less thing on the internet.

Before you leave, commit and push everything: the code changes, the plan, and the README. If you worked on a branch, merge it to main, since main is what Railway deploys.

Before Tuesday, finish pending cutover checks and the README update. Link your plan, redacted comparison, results, rollback notes, and cost notes from `docs/project-1-submission.md`. Bring blockers to the instructor before choosing a paid plan.
