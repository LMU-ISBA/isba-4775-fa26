# Audit your Project 1 submission

On Tuesday, October 20, check your work before Project 1 is due Thursday, October 22, at 1:45 PM Pacific. The [project brief](../projects/own-your-corner-of-the-internet.md) defines the 125-point requirements. Open your public repository, live HTTPS site, and the service dashboards. Use dated observations from the system you built.

## Check the live site and Azure evidence

Open the final hostname from a network that reaches it. Check the DNS answer, Railway certificate, page status, profile, links, and current database-backed projects. Confirm the edited Azure project record appears on Railway. If campus filtering blocks the site, try another network and record both results. A blocked browser page does not by itself prove TLS failed.

Find evidence for each application state:

- With no project rows, the page shows no invented projects.
- When the database fails, the profile remains visible, the page says "Projects temporarily unavailable," and HTTP status is 503.
- When the database returns, a refresh restores projects without restarting the app.

Use dated safe tests or an isolated setting. Do not break production to fill a gap. Your Azure record should show HTTP, the database-backed page, a controlled VM restart, and later custom-domain HTTPS with certificate renewal. Check multiple app workers, service management, restricted SSH, public web ports, and private app and database listeners. Ex04 covers some HTTPS evidence, but the controlled restart is still a Project 1 requirement. If an old test was never recorded, date a safe new test and state what remains unverified. Do not backdate it.

Check the Railway-provided URL, DNS cutover, and final HTTPS hostname separately. The final certificate must cover that hostname. Keep the chosen trial hostname and Cloudflare DNS-only settings consistent with your migration plan.

## Check migration and services

Find the pre-migration inventory of code, runtime, packages, configuration, secrets, schema, and current data. Explain what Git moved and how data moved. Show your PostgreSQL compatibility check and any code or data adjustment. Compare source and target schema and constraints, row counts, selected row content, and the rendered page. The edited source row must be present in the target. A seed row or count alone is insufficient. Find the write-freeze or write-handling plan, cutover decision, and rollback steps for both code and data. Account for any writes after cutover before suggesting a DNS rollback.

Compare Azure and Railway responsibilities for the OS, runtime, web entry, TLS, app code, configuration, database software, data, and DNS. Railway hosts PostgreSQL. You still own schema, data, maintenance decisions, and backup and recovery planning. Do not assume its database template supplies managed backups.

Find a reviewed post-migration code change. Match its local check, commit SHA, Railway deployment, and visible result at your domain. Know how to restore working code and what a schema change may require. GitHub Actions is not required.

Check Zoho webmail and Ex06 evidence. Confirm actual incoming mail, a reply received externally, and a new outgoing message received externally with your custom From address. Check MX, SPF, DKIM, DMARC, and available receiver authentication results. Check GA4 Realtime or DebugView for a live page view and useful interaction. Record the action, event, time, and what it means. These are actual delivery and measurement checks, not DNS records or target counts alone.

## Check the engineering record

Your README should map the site, address, setup, and update path. Include Azure and Railway diagrams with locations, protocols, ports, and data flow. Show separate Zoho and GA4 paths. Link existing plans and evidence instead of copying them.

Document two decisions with alternatives and reasons. Investigate two failures, one in the app or database dependency and one in network, DNS, or TLS. For each, show the symptom, checks, diagnosis, repair, and retest. Label simulated failures, including Ex05, honestly. Add unresolved issues, a short reflection, costs or credits, expiration dates, and cleanup plans.

Use `docs/project-1-submission.md` as an index. Link the README, original spec and plans, `AGENTS.md`, diagrams, migration and responsibility comparison, cutover, Azure and final HTTPS results, Railway update, Zoho, GA4, decisions, failures, costs, and reflection. Open every link on GitHub. An agent can help assemble the index, but verify its claims. Code alone cannot prove a message arrived or a live test passed. Record a new test or mark the claim unverified. Label explanations written afterward as retrospective, not plans made before the work. Write the Ex04 HTTPS explanation yourself.

## Submit and rehearse

Check Railway trial usage and credit dates, domain renewal, and Zoho plan limits. Stop Azure only after the Railway app, data, domain, and HTTPS pass. Confirm the VM says "Stopped (deallocated)." Retained disks may still cost money. Keep earlier evidence and the site available through your interview.

Put the repository URL, live HTTPS URL, and final commit SHA in both the index and Brightspace Project 1 submission. Check the pushed SHA and links from outside your workspace. State any blocker plainly. Project 1 has its own 125-point rubric. Exercises are separate 15-point credit/no-credit work.

For practice, draw the system from memory. Explain a web request, data migration, an email path, one failure, and one responsibility that moved. Use the [midterm study guide](midterm-study-guide.md) for the separate interview.
