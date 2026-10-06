# Midterm whiteboard interview study guide

The midterm is a separate 125-point interview, scheduled October 27 through 29 through the instructor's Calendly. It lasts 20 minutes. In the first 15 minutes, draw and explain your own Project 1 system from memory, without notes or your repository. In the last five minutes, the instructor changes one constraint and asks you to adapt your design. The categories are known, but the specific change is not.

Study the system you built and the evidence you saved. This guide covers the material through the October 8 Railway migration, October 13 Zoho Mail lesson, and October 15 GA4 lesson. It does not add a new project deliverable or a new grading rubric. Job Scout, Resend, GitHub Actions, and later agent topics are outside this midterm scope.

## Draw the system from memory

Start with a visitor's browser and your chosen domain. Draw its DNS lookup through a resolver to Cloudflare's authoritative DNS and the answer returned. Then draw the browser's HTTPS connection to Railway's web entry and TLS certificate, the application, and Railway-hosted PostgreSQL. Label protocols, public and private paths, and the database content that appears on the page. Show where the browser sends GA4 events. In another color, draw incoming and outgoing mail through Zoho. Then draw the former Azure path: public address and firewall, Nginx, app service, database, and certificate renewal.

You should be able to trace a request one step at a time. What happens when the browser asks for your hostname? Which system answers DNS? When does TLS begin, what name must the certificate cover, and where does encryption end? What returns HTTP 200? What does your app show and return when the database fails? How does it recover when the database returns?

## Explain the changes you made

Describe why you chose the original database and how the Azure VM ran the app after a restart. Explain its workers, service manager, SSH restriction, and private app and database listeners. Show what changed when you moved to Railway-hosted PostgreSQL. Which files moved through Git, and which data and secrets did not? How did you check PostgreSQL compatibility, move today's edited row, and prove it was not seed data? When did you change DNS? What did you check before and after cutover? What could make a rollback lose data? Compare who manages the OS, runtime, web entry, TLS, code, configuration, database software, data, and DNS. Explain your maintenance and backup responsibilities for the Railway-hosted database.

Connect a reviewed commit to a Railway deployment and a visible live change. Explain how you checked the diff, tested locally, and verified the deployed behavior. Know which settings and secrets live outside Git. If a code release fails, explain how you would restore it. If a database migration fails, explain why a code revert alone might not restore the data.

Trace an email sent from Zoho webmail to an external mailbox, and a reply coming back. Explain what MX, SPF, DKIM, and DMARC each do and what their DNS records show. Distinguish record publication from a message's actual delivery and authentication result. Trace a page view and one useful interaction from the browser to GA4. Explain what you observed in Realtime or DebugView and what the event measures. A larger event count is not a better answer.

## Practice diagnosis from evidence

Try these questions without looking at your notes. Then open your actual evidence and correct your answer.

1. Your domain resolves to an old Azure address, and `curl` reports a certificate name mismatch. Which check locates the first wrong step? What would you change, and what would you repeat?
2. DNS points to Railway, and TLS succeeds, but the page shows "Projects temporarily unavailable" with HTTP 503. Which logs and database checks would you use? What result shows recovery?
3. Railway says a deployment succeeded, but the edited project row is absent. Which source and target records would you compare before moving the domain?
4. Zoho receives outside mail, but an external mailbox never gets a new outgoing message. Which DNS records, Zoho status, and receiver results would you inspect? What can you conclude from a Sent-folder entry alone?
5. Your GA4 tag is in the page source, but Realtime shows no test event. Which browser action, network or consent setting, measurement ID, and GA4 view would you check?
6. The site worked yesterday, then a new commit changed the database schema. How do you separate an app rollback from a data rollback?

For each answer, name the failed observation, the next check, what different results would mean, and the repeated check after a repair. Use your own incident records as examples. An honest "I didn't verify that yet" is better than inventing a result.

## Prepare for a changed constraint

The last five minutes may change traffic, budget, or a service you depend on. Practice one change at a time:

- Traffic grows tenfold. Which part would you measure first: web service, database, or outside service? What could you scale or cache, and what new cost follows?
- The budget drops by eighty percent. Which services and retained resources cost money? What can you reduce while keeping the site and its evidence available?
- A vendor has an outage or ends a service. What fails for visitors or mail? What data, DNS records, configuration, and verification would a replacement need?
- The site must accept writes after cutover. How does that change your backup, migration freeze, and rollback plan?

State your assumptions, draw the changed path, and test the part most likely to fail. Explain the tradeoff rather than naming a new vendor without a migration or cost plan. You can change your mind as you reason.

## A practical rehearsal

Give yourself 15 minutes with a blank board or paper. Draw the paths, explain two decisions and two investigated failures, then connect them to actual checks. Spend five more minutes on one constraint change. Ask a partner to interrupt where a line has no owner, a test has no result, or a cost has no date. Review your Project 1 README and evidence afterward, then rehearse once more from memory.
