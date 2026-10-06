# Audit your Project 1 submission

Session 15, Tuesday, October 20, 2026. Project 1 is due Thursday, October 22, at 1:45 PM Pacific, before class. Use this guide to find gaps while there is still time to check the live system and repair links. The project brief is the source for requirements and points: `projects/own-your-corner-of-the-internet.md`.

Open your public `career-platform` repository, the live HTTPS site, Railway, Zoho, GA4, and the private service dashboards you need for verification. Work from the final system and dated evidence. A green deployment or a screenshot from last month does not establish today's behavior.

## 1. Check the live path

From a network that can reach your domain, open the chosen final hostname over HTTPS. Trace the DNS answer, then the browser's connection to Railway's web entry and certificate, your application, and Railway-hosted PostgreSQL. Check the page status, profile, links, and database-backed project entries. Find the recognizable edit made to an existing Azure record before migration. Confirm that this same content appears on Railway. If campus filtering blocks a new domain, record that observation and repeat from another network. Don't label a browser block as a certificate failure without a TLS check.

Find evidence for the application's empty-table, database-failure, and recovery behavior. An empty projects table should not produce invented projects. During a database failure, the profile remains visible, the page says "Projects temporarily unavailable," and the response is HTTP 503. After the database returns, a refresh should restore projects without restarting the app. Use an existing safe test record, or run a controlled test in an isolated setting and date the actual result. Do not interrupt your live site just to fill an evidence gap.

Open your Azure evidence. It should show that the earlier site answered over HTTP, survived a controlled VM restart, read its database, and later served your domain over HTTPS. Find the application server's multiple-worker setting and service management. Check the recorded SSH source restriction, public web ports, and private app and database listeners. The controlled restart is a Project 1 requirement even if the deliberate crashes in the VM guide were optional practice. Keep your Ex04 certificate and renewal results. You do not need to start Azure again if dated evidence already establishes these checks. If a required observation was never recorded, perform a safe current check where possible, date it now, and state what earlier behavior remains unverified. Do not backdate evidence.

Confirm that the final hostname points to Railway and its certificate covers that name. The Railway-provided URL test, domain cutover result, and final HTTPS check are separate observations. Keep your one chosen trial hostname and Cloudflare DNS-only setting consistent with the migration guide.

## 2. Check data, deployment, mail, and analytics

Use your migration plan to explain what Git moved and how current database content moved. Find the pre-change inventory of code, runtime, packages, configuration, secrets, schema, and current data. Show how you checked PostgreSQL compatibility and handled engine-specific code or data. Compare source and target schema or constraints, counts, selected row content, and the rendered page. Find the pre-cutover edit to an existing source row in the target. A count or seed row alone does not prove current data moved. Find your cutover decision, write-freeze or write-handling note, and a rollback procedure that covers both code and data. If new writes occurred after cutover, account for them before proposing a DNS rollback.

Find your Azure-versus-Railway responsibility comparison. Assign the OS, runtime, web entry, TLS, application code, configuration, database software, data, and DNS to the party that handles each. Railway hosts PostgreSQL, but you remain responsible for its schema, data, maintenance decisions, and backup and recovery plan. Do not assume the database template supplies managed backups.

Find one reviewed change after Railway deployment. Match the local check, commit SHA, Railway deployment, and changed behavior at your domain. Know how to return to a working code version and what happens if the database schema changed too. GitHub Actions is not required for this project.

Open the Ex06 mail evidence and check the current Zoho address in webmail. Confirm a new outgoing message, incoming message from an external address, and a reply received externally with your domain address in **From**. Check published MX, SPF, DKIM, and DMARC records and the message authentication result where available. Redact private content in the public evidence. Mobile mail is optional.

Open GA4 Realtime or DebugView. Produce a page view and one useful interaction on the live site, then find the events. Record the action, observation time, event, and what the event tells you. Explain how browser activity reaches GA4. You are showing collection and interpretation, not a visitor-count target.

## 3. Make the engineering record easy to follow

Your README is the short map of the system. It should state what the site does, its address, and how to set up and update it. Use Azure and Railway diagrams with locations, protocols, ports, and data flow. Include the separate Zoho mail and GA4 paths. Link to existing plans and evidence instead of repeating them.

Show two decisions with alternatives and reasons. Show two investigated failures: one application or database-dependency failure and one network, DNS, or TLS failure. For each, identify the symptom, checks, diagnosis, repair, and result when the check was repeated. Ex05 can supply the second investigation. Label a deliberate lab failure. Explain what remains unresolved. Include a brief reflection, service credits or costs, expiration dates, and cleanup plans.

Your `docs/project-1-submission.md` is an index, not another report. Check that its links lead to the README, original spec and plans, `AGENTS.md`, diagrams, migration comparison and cutover, Azure and final HTTPS results, Railway update, Zoho evidence, GA4 evidence, and the decisions, failures, cost notes, and reflection. Open the links in GitHub without relying on local files. Keep the README concise by linking to the files you already have.

An agent may reconstruct an index or draft README sections from repository files, commits, and saved evidence. Verify each claim. Code can show implementation, but cannot prove an email arrived, a restart succeeded, or a live page displayed the migrated row. Rerun a missing check and date the new result, or mark it unverified. Identify a retrospective account as written afterward. Ex04's HTTPS explanation remains your own writing.

## 4. Costs, cleanup, and final submission

Check Railway trial status, usage, and the date your credit changes or expires. Check your domain renewal and any Zoho plan restriction. Confirm Azure is **Stopped (deallocated)** only after Railway app, current data, domain, and HTTPS all passed. A deallocated VM stops compute charges, but its disk and other retained resources can still cost money. Keep the disk and earlier evidence until the instructor's cleanup checkpoint. Plan to keep the final site available through your midterm interview.

Before Thursday, open the final repository and live URL from outside your local workspace. Put the repository URL, live HTTPS URL, and final commit SHA in both `docs/project-1-submission.md` and the Brightspace Project 1 submission. Confirm the pushed SHA and every link. If a test remains blocked, state what you checked and what remains uncertain. Project 1 has its own 125-point rubric in the brief. The 15-point exercises use credit/no credit.

## Practice explanation

Draw the whole system from memory once. Give a partner a two-minute trace of a web request, a one-minute account of current-data migration, and a one-minute trace of an email. Then explain one failed check and one responsibility that moved from Azure to Railway. Your partner should ask where each claim was observed. The separate midterm interview lasts 20 minutes and uses the study guide, with no notes or repository during its first 15 minutes.
