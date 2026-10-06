# Project 1: Own Your Corner of the Internet

Updated October 6, 2026. Website, domain email, and basic analytics, with the
Azure-to-Railway/PostgreSQL migration retained.

**125 points. Due Thursday, October 22, 2026, at 1:45 PM Pacific, before class.**

## What you are building

Build a personal website that you can explain and operate. Start in Codespaces,
deploy it on an Azure Linux VM, then migrate the same application to Railway.
Connect your own domain with HTTPS, use Zoho Mail to send and receive from
that domain, and add Google Analytics to understand activity on your site.

Your site becomes the starting point for the career platform you will develop
throughout the semester. Use one repository for the application, infrastructure,
and engineering record. Each migration should preserve the useful work already
in that repository.

By the deadline, your custom domain should reach the Railway deployment. Keep
evidence of the earlier Azure deployment. Once the migration is verified,
follow the instructor's cleanup directions for Azure resources.

Job Scout, Resend, and GitHub Actions will be taught after the midterm.
For this project, Railway handles deployment from your GitHub repository.

## What the system must do

### 1. Present your profile and read project data

Include your name, a short introduction, education, and professional links.
Use information you are comfortable publishing. Experience and project sections
may contain clearly labeled placeholders while you develop real content.
Do not invent qualifications or experience.

Store project entries in a database and read them when the page is requested.
Choose the initial database engine during design and explain your choice. Use
Railway-hosted PostgreSQL for the later Railway deployment. A useful initial entry is
a clearly labeled description of this website as a project in progress.

Handle an empty table and a failed database connection deliberately. For our
initial page, database failure leaves the profile visible, shows "Projects
temporarily unavailable," and returns HTTP 503. A healthy request returns 200.
After the database recovers, refresh should restore the projects without an
application restart. Do not substitute sample content to hide a failed query.

### 2. Deploy and operate the application on Azure

Use an Ubuntu VM, an application server, Nginx, and your chosen database. Keep
the same database engine for this first migration. By the completed Azure milestone, Nginx forwards public web requests to the application, and the
application accesses its database locally. Run the application server with
multiple workers, such as Uvicorn with `--workers`, under service management
that survives a VM restart.

Document SSH access, the public/private addresses, and the network rules.
Restrict SSH to the intended source. Keep the database and application listener
off public ports, with Nginx providing the public web entry point.

Show that the site responds, reads its database, and returns after a controlled
VM restart. Explain which parts needed configuration to make that happen.

### 3. Connect a domain and HTTPS

Use a domain you control. Configure its authoritative DNS and records, then
verify that the name reaches your application with a valid certificate.
The course DNS lab uses Cloudflare DNS, with every record set to DNS only so
traffic and TLS reach your own server. An instructor-approved alternative must
allow you to demonstrate the same delegation and record-management concepts.

Record the relevant DNS records, their purpose, and your verification results.
Explain the certificate's hostname, validity, and renewal arrangement. Update
the domain during the Railway migration and verify HTTPS at the new destination.
Railway's trial allows one custom domain, so choose either the bare domain or
www as your site's address before the cutover.

### 4. Migrate to Railway and PostgreSQL

Write the migration plan before changing the working deployment. Identify the
code, runtime, packages, configuration, secrets, schema, and current data that
the target needs. Explain what Git moves and what requires another method.

Validate PostgreSQL compatibility before cutover, converting engine-specific
code and data where needed. Include at least one real change you made to the original project data
so that restoring seed data cannot pass as transferring the current database.
Compare source and target records, their content, and the rendered page.

Deploy the target, configure its secrets, and test it before moving the domain.
Record the cutover, post-cutover checks, and a usable rollback procedure. The
rollback plan must account for data written after cutover, if writes are allowed.
You do not need to roll back a successful migration just to produce evidence.

Compare who manages the OS, runtime, web entry point, TLS, application code,
configuration, database software, data, and DNS on Azure versus Railway. Explain
remaining student responsibilities rather than treating PaaS as maintenance-free.

### 5. Publish a reviewed change through Railway

Connect your GitHub repository to Railway and configure deployment from your
chosen branch. Review the diff and verify the change locally before committing
and pushing. Keep credentials in the appropriate secret or environment-variable
settings, outside your public repository.

Demonstrate one change reaching the live site. Connect the commit SHA to the
Railway deployment and the behavior you observed at your domain. Explain how
you would restore a previous working version. Consider database changes as
well as application code when explaining recovery.

Railway can deploy directly from GitHub. The separate GitHub Actions workflow
comes later in the course.
https://docs.railway.com/deployments/github-autodeploys

### 6. Send and receive email at your domain

Set up Zoho Mail with an address such as `hello@yourdomain.com`. Use Zoho
webmail to send, receive, and reply from that same address. Mobile setup is optional.
Cloudflare remains your DNS provider. Use Zoho's MX records for incoming mail.

Configure and explain MX, SPF, DKIM, and DMARC. Use the values provided for your
account, and verify the resulting records and authentication results.
https://www.zoho.com/mail/help/adminconsole/cloudflare.html

Show that a message from an external account reaches your custom address.
Reply from Zoho, then check that the external account receives the reply and
sees your custom address as the sender. Also verify a new outgoing message.
Save dated, redacted evidence of delivery and sender authentication. Explain
any failed or unresolved check. Keep private message contents and credentials
out of the public repository.

### 7. Measure activity with Google Analytics

Add GA4 to the deployed website. Verify a page view and one useful interaction,
such as a click on an external project link. Record the action you performed,
the event you observed, and why that event is useful for your website.

Use Realtime or DebugView to verify collection. Explain how activity in the
visitor's browser reaches Google Analytics and what your checks demonstrate.
Your grade depends on configuration, verification, and explanation. You do
not need a particular number of visitors.
https://developers.google.com/analytics/devguides/collection/ga4/troubleshoot

### 8. Keep a concise engineering record

Keep one README that explains your system and one submission index at
`docs/project-1-submission.md` that links to the evidence. Reuse the plans,
exercise explanations, diagrams, and checks already in your repository.
The engineering record is this README, the submission index, and the evidence
they link to. It isn't an additional report. The technical categories score
whether the systems work. The engineering-record category scores whether
someone can understand your work, follow your setup, and find its evidence.

Your README should cover:

- What the site does, its live address, and how to set up and update it.
- Azure and Railway architecture diagrams showing locations, protocols,
  ports, and data flow. Include the email and analytics paths.
- How the migration preserved current data and which responsibilities moved
  to Railway.
- At least two decisions, the alternatives considered, and your reasons.
- Investigated failures, what you checked, what fixed them, and the results
  when you repeated the check. Include remaining limitations.
- A short reflection on what you understand better and what you would change.
- Your service costs or credits, expiration dates, and cleanup plans.

You can link from the README to an existing file rather than copy its contents.
Keep your `AGENTS.md`, original spec and plans, and meaningful commit history.
Include two investigated failures: one application or database-dependency
failure and one network, DNS, or TLS failure. You may reuse your build,
migration, or exercise records. Identify a deliberate lab failure as such.
For each, show the symptom, checks, diagnosis, repair, and repeated verification.
No Job Scout integration incident is required for Project 1.

You may use your coding agent to help reconstruct this record. Ask it to read
the repository, Git history, plans, configuration, and saved evidence. Have it
link claims to the files, commits, or observations that support them. It can
help assemble diagrams, summarize decisions, and draft the README and index.

Review and correct its account. Code shows what was implemented, but doesn't
by itself prove a deployment worked, an email arrived, or a test passed.
If evidence is missing, rerun the check and record its actual date and result,
or identify it as unverified. A retrospective explanation should be identified
as written afterward, rather than presented as a plan made before the work.
Keep the requirement to write the migration plan before changing the deployment.

You remain responsible for explaining the system at the interview. Existing
exercise instructions still apply, including Ex04's requirement to write your
own HTTPS explanation. Link to that file instead of replacing it with an
agent-generated version.

## Checkpoints before submission

These progress targets follow the class schedule. Exercise 05 is due October
13, and Exercise 06 is due October 15. Both are due at 1:45 PM Pacific. Their
records can also support the project, without copying evidence into another report.

| Target | Evidence to have ready |
| --- | --- |
| Before the Railway cutover | Azure HTTP, restart, DNS, HTTPS, and renewal evidence retained |
| October 8 | Railway/PostgreSQL target, current-data comparison, and a verified cutover or documented remaining steps |
| October 13 | Ex05 investigation submitted before class; begin Zoho mail setup and delivery checks |
| October 15 | Migration and email completion, GA4 verification, and troubleshooting evidence |
| October 20 | Completed technical work and evidence ready for the submission audit and practice explanation |
| October 22, 1:45 PM | Final project submission before class |

## Organize your repository

Use your existing public `career-platform` repository. Keep the application in
one place as environments change. Retain your current folder structure and
add the README sections and submission index around the work already there.

The submission index is a list of links to evidence. It can point to files,
README sections, commits, and redacted screenshots or command output. Azure
and Railway diagrams can share a file. Decisions and reflections can be
README sections. A separate FAQ or repeated copies of exercise evidence
aren't required.

Track your documentation in Git, including `docs/` in the student repository.
Keep passwords, private keys, local environments, and sensitive database
exports out of Git. Redact private information from email and analytics evidence.

## Submit

Submit your repository URL, live HTTPS URL, and final commit SHA through the
Project 1 submission in Brightspace. Put the same information in
`docs/project-1-submission.md`, with links to:

1. The README, original application spec and plans, and `AGENTS.md`.
2. Azure and Railway diagrams, including email and analytics data flow.
3. Migration plans, source/target data comparisons, cutover results, and rollback.
4. Azure HTTP/restart evidence and final DNS/HTTPS verification.
5. A reviewed commit, its Railway deployment, and verification of the live change.
6. Zoho sending, receiving, replying, and DNS authentication evidence.
7. GA4 page-view and interaction evidence, with an explanation.
8. The README sections or existing records covering failures, decisions,
   reflection, costs, and remaining limitations.

Date your observations and record commands with their actual results. Redacted
output, screenshots, and short explanations can support a check. Screenshots
alone do not replace the working final system. Mark anything unverified rather
than filling in the expected result.

Keep the final site available through your midterm interview. Follow the
instructor's cleanup directions after that checkpoint. You do not need to
keep Azure running after the migration is verified, but retain its evidence
and follow the instructions for keeping its disk.

## How the 125 points are earned

Each area is scored separately. Full credit requires the behavior and evidence
described in this brief. Partial credit reflects what you can demonstrate.
Identify missing or unverified work honestly.

| Area | Points | What is assessed |
| --- | --- | --- |
| Personal application | 15 | Profile and project content, actual database reads, and empty/failure/recovery behavior |
| Azure deployment | 20 | Public Nginx/application/database path, explained SSH and network rules, service management, and restart evidence |
| Domain and HTTPS | 15 | Domain control and DNS explanation, working final HTTPS, and certificate and renewal explanation |
| Railway/PostgreSQL migration | 25 | Plan and dependency inventory, database compatibility, preservation and comparison of current data, verified cutover, rollback, and operating responsibilities |
| Verified website update | 5 | A reviewed and checked change connected to its commit, Railway deployment, and live result, with a recovery explanation |
| Zoho email | 15 | Custom-domain sending, receiving, and replies, plus MX/SPF/DKIM/DMARC configuration, verification, and explanation |
| GA4 | 10 | Verified page views and one useful interaction, with an explanation of collection and meaning; visitor counts do not affect the score |
| Engineering record | 20 | A clear README covering setup, diagrams, decisions, troubleshooting, reflection, costs, and limitations; a submission index and links to existing evidence and history |
| Total | 125 | |

The engineering record is assessed through your README, submission index,
and their linked records. It does not require another report or duplicated
screenshots. This category scores clarity, reproducibility, and traceability.
The technical categories score the working behavior and its verification.

You may use an agent to help assemble the documentation. You remain
responsible for checking its claims and explaining your system.

## Prepare to explain it at the midterm

Your interview is a separate 125-point assessment, scheduled October 27-29.
For the first 15 minutes, draw and explain your system from memory, without
notes or the repository. The final five minutes change one constraint.

Be ready to trace a web request and an email, explain a migration and an
analytics event, diagnose a failure, compare provider responsibilities, and
discuss costs and remaining limits. Explain
what the coding agent created, what you changed, and how you verified it. A working
artifact and an explanation of that artifact are assessed separately.

## Choose and budget for services

Prefer student offers when they meet the learning goals. Verify eligibility,
limits, costs, and expiration before relying on an offer.

For Railway, follow the assigned October 3-7 sign-in window and check your
account's verification and remaining credits. Plan to keep the site available
through your midterm interview. Check the current terms before provisioning:
https://docs.railway.com/pricing/free-trial

Use Zoho's Forever Free plan where available and follow the course signup
instructions. Free-plan availability depends on the data center.
Bring account restrictions to the instructor before selecting a paid plan.
https://www.zoho.com/mail/zohomail-pricing.html

Cloudflare remains the DNS provider. Keep proxy-capable records set to DNS
only unless instructed otherwise. The email setup uses Zoho's MX records.

Keep a service inventory. Distinguish compute from retained storage and other
billable resources, and record renewal dates and cleanup plans.

## Start here

Begin with [Build your resume site in Codespaces](../guides/resume-site-in-codespaces.md).
Then use [Migrate your site to an Azure VM](../guides/azure-vm-migration.md).
Continue with the Railway, Zoho, analytics, and project-audit guides linked
from the course README as those lessons are introduced.
