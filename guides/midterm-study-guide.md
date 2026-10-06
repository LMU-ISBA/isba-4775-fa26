# Midterm whiteboard interview study guide

The midterm is a separate 125-point interview, scheduled October 27 to 29 through the instructor's Calendly. It lasts 20 minutes. For the first 15, draw and explain your own Project 1 system from memory, without notes or your repository. In the last five, adapt it to one changed constraint. You know the categories, but not the specific change.

Study the system and evidence you built through the October 8 Railway migration, October 13 Zoho lesson, and October 15 GA4 lesson. This guide adds no deliverable or rubric. Job Scout, Resend, GitHub Actions, and later agent topics are outside this midterm.

## Draw and trace your system

Start with the visitor's browser and domain. Draw the DNS lookup and answer, then the HTTPS connection to Railway's web entry, application, and Railway-hosted PostgreSQL. Label protocols, public and private paths, the certificate, and the content read from the database. Add the browser-to-GA4 path and incoming and outgoing Zoho mail. Draw the former Azure path too: public address, firewall, Nginx, app service, database, and certificate renewal.

Explain what DNS resolves and where the browser sends its HTTPS request. Say when TLS begins, what hostname the certificate covers, and where encryption ends. Describe the normal page, the empty-project state, and the database-failure page with HTTP 503. Explain how the projects return after the database recovers.

## Explain your choices and evidence

Be ready to explain your original database choice, Azure restart, app workers, service manager, SSH restriction, and private listeners. Then explain the move to Railway-hosted PostgreSQL. What moved through Git? What happened to current data and secrets? How did you check compatibility and prove the edited source row arrived? Describe the cutover, write handling, and a rollback that accounts for later writes.

Compare who handles the OS, runtime, web entry, TLS, code, configuration, database software, data, and DNS in each setup. You remain responsible for your Railway-hosted database's schema, data, maintenance decisions, and backup and recovery plan. Connect a reviewed commit to its local check, Railway deployment, and visible result. Explain why a code revert alone may not undo a schema or data change.

Trace a Zoho message out and a reply back. Explain MX, SPF, DKIM, and DMARC, and distinguish published records from actual receipt and authentication. Trace a page view and useful click from the browser to GA4. Say what you saw in Realtime or DebugView and what the event cannot tell you about a person. More events do not earn a better answer.

## Practice diagnosis

Answer these from memory, then compare with your dated evidence:

1. DNS still resolves to Azure, and the browser reports a certificate name mismatch. What is the first wrong step, and what do you retest?
2. DNS and TLS work, but the page says "Projects temporarily unavailable" with HTTP 503. Which app and database checks distinguish the cause? What shows recovery?
3. Railway deployed successfully, but the edited project row is missing. Which source and target records do you compare?
4. Zoho receives mail, but a new outbound message never arrives. Which records, Zoho status, and receiver results do you inspect? What does Sent prove?
5. The GA4 tag appears in page source, but Realtime shows no event. Which action, Measurement ID, property, consent setting, and DebugView result do you check?
6. A code update changed the database schema. How do app and data rollback differ?

For each, state what you observed, the next check, what its result means, and the retest after repair. Say when something remains unverified.

## Adapt to a changed constraint

Practice one change at a time. Traffic may grow, the budget may fall, a service may fail, or the site may need writes after cutover. State your assumption, redraw the affected path, name the first measurement or test, and explain cost and rollback effects. A replacement service needs a data, DNS, and configuration plan.

Rehearse with a blank board for 15 minutes. Explain two decisions and two investigated failures using your own checks. Spend five more minutes on a changed constraint. Review the README and evidence afterward, then try once more from memory.
