# Project 1: Own Your Corner of the Internet

Project requirements, updated September 15, 2026.

**125 points. Due Thursday, October 22, 2026.** Check Brightspace for the
submission cutoff time. These requirements reflect the revised course direction.
The syllabus and exercise schedule are being aligned with this project brief.

## What you are building

Build a personal website that you can explain and operate. Start in Codespaces,
deploy it on an Azure Linux VM, then migrate the same application to Heroku.
Add a small Job Scout that finds relevant opportunities and emails a digest.

Your site becomes the starting point for the career platform you will develop
throughout the semester. Use one repository for the application, infrastructure,
and engineering record. Each migration should preserve the useful work already
in that repository.

By the deadline, your custom domain should reach the Heroku deployment. Keep
evidence of the earlier Azure deployment. Once the migration is verified,
follow the instructor's cleanup directions for Azure resources.

## What the system must do

### 1. Present your profile and read project data

Include your name, a short introduction, education, and professional links.
Use information you are comfortable publishing. Experience and project sections
may contain clearly labeled placeholders while you develop real content.
Do not invent qualifications or experience.

Store project entries in a database and read them when the page is requested.
Choose the initial database engine during design and explain your choice. Use
managed PostgreSQL for the later Heroku deployment. A useful initial entry is
a clearly labeled description of this website as a project in progress.

Handle an empty table and a failed database connection deliberately. For our
initial page, database failure leaves the profile visible, shows "Projects
temporarily unavailable," and returns HTTP 503. A healthy request returns 200.
After the database recovers, refresh should restore the projects without an
application restart. Do not substitute sample content to hide a failed query.

### 2. Deploy and operate the application on Azure

Use an Ubuntu VM, an application server, Nginx, and your chosen database. Keep
the same database engine for this first migration. By the completed Azure milestone, Nginx forwards public web requests to the application, and the
application accesses its database locally. Use a production application server
such as Gunicorn, with service management that survives a VM restart.

Document SSH access, the public/private addresses, and the network rules.
Restrict SSH to the intended source. Keep the database and application listener
off public ports, with Nginx providing the public web entry point.

Show that the site responds, reads its database, and returns after a controlled
VM restart. Explain which parts needed configuration to make that happen.

### 3. Connect a domain and HTTPS

Use a domain you control. Configure its authoritative DNS and records, then
verify that the name reaches your application with a valid certificate.
The course DNS lab uses Route 53; an instructor-approved alternative must allow
you to demonstrate the same delegation and record-management concepts.

Record the relevant DNS records, their purpose, and your verification results.
Explain the certificate's hostname, validity, and renewal arrangement. Update
the domain during the Heroku migration and verify HTTPS at the new destination.

### 4. Migrate to Heroku and managed PostgreSQL

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
configuration, database software, data, and DNS on Azure versus Heroku. Explain
remaining student responsibilities rather than treating PaaS as maintenance-free.

### 5. Deploy a reviewed change through GitHub Actions

Create a workflow that deploys the application when a reviewed change reaches
the deployment branch. For an individual repository, review the diff and verify
the change before committing and pushing to `main`.

Keep deployment credentials in GitHub Actions secrets. Include a check that
can fail the workflow when required application behavior is broken. Demonstrate
one successful deployment by connecting the commit, workflow run, and resulting
live behavior. Explain how you would restore a previous working version.

### 6. Build Job Scout version 1

Use a reliable posting source, such as a supported API or the instructor's vetted
feed. Gather real job postings and compare them with your profile, interests,
and constraints. Matching can use explicit rules or a bounded model call, but
you must explain the criteria and inspect the output.

Save useful results and send yourself an email digest from a verified sender
on your domain. Configure and explain the provider's required DNS authentication,
including SPF and DKIM as applicable, and your domain's DMARC policy. Explain
how this differs from setting up an inbound mailbox with MX records.

Show at least five distinct real postings you would consider, with source links,
retrieval dates, and reasons they match. Keep credentials and personal email
addresses out of public logs. A manual trigger is sufficient for this version.
Record retrieval, matching, and delivery steps so someone can inspect one run.

Demonstrate a controlled external-service failure and explain its result. A
failed request must not be reported as a successful retrieval or delivery.

If your chosen source becomes unavailable, use the instructor's vetted feed
and document the substitution. Clearly label sample or mock runs; they do not
replace the required run using real postings.

### 7. Keep an engineering record

Maintain an `AGENTS.md` with your working rules. Begin with GitHub Copilot CLI
and Superpowers in Codespaces, then use Claude Code (preferred) or Codex for
the Azure lesson. Use the same project rules to clarify requirements, approve
a spec and plan, review changes, debug, and verify the system. Every agent
choice must preserve those review and explanation practices.

Save architecture diagrams for Azure and Heroku, with component locations,
protocols, ports, and data flow. Explain at least two decisions, including an
alternative you considered and why you chose the final approach.

Document at least three investigated failures. Cover an application dependency,
networking or TLS, and an external integration. For each, record the symptom,
evidence, hypothesis, root cause, fix, and repeated verification. Write an FAQ
with at least five questions drawn from those actual investigations.

Your README should explain setup, operation, migration evidence, and remaining
limitations. Include a short retrospective about what you understand better
and what you would change next. Meaningful commits should identify working
milestones, configuration changes, and repairs.

## Checkpoints before submission

These are progress targets during the lessons, not additional point categories.
Exercise briefs and their Brightspace deadlines remain separate.

| Target | Evidence to have ready |
| --- | --- |
| September 15 | Working Codespaces site, database reads, failure/recovery, and first application commit |
| September 17 | Application migrated and checked on the Azure VM, with incomplete public-service work recorded |
| September 22 | Public Azure HTTP service and restart verification |
| September 24 | Custom domain and HTTPS on Azure |
| September 29 | Networking/TLS investigation with verified repair |
| October 1 | PostgreSQL-compatible application, validated data, and migration plan |
| October 6 | Heroku deployment, custom-domain cutover, HTTPS, and responsibility comparison |
| October 8 | Verified transactional test email and sender DNS |
| October 13 | Job Scout end-to-end run and relevant postings |
| October 15 | GitHub Actions deployment and integration-failure evidence |
| October 20 | Submission audit and practice explanation |
| October 22 | Final project submission |

## Organize your repository

Use `career-platform` throughout the semester, under your own GitHub account:
`https://github.com/YOUR-USERNAME/career-platform`. Keep the application in one
place as environments change. A suggested structure is:

```text
career-platform/
  AGENTS.md
  README.md
  application/
    database/
  infrastructure/
  scripts/
  docs/
    architecture.md
    decisions/
    migrations/
    troubleshooting/
    project-1-submission.md
  evidence/
  .github/workflows/
```

In your student repository, `docs/` should be tracked. Store safe configuration
examples and setup scripts, but keep passwords, private keys, local environments,
and sensitive database exports out of Git. Existing exercise folders may stay;
do not create a separate copy of the application for every exercise.

## Submit

Submit your repository URL, live HTTPS URL, and final commit SHA through the
Project 1 submission in Brightspace. Put the same information in
`docs/project-1-submission.md`, with links to:

1. The application spec, plan, and setup instructions.
2. Azure and Heroku architecture diagrams.
3. Migration plans, source/target data checks, cutover results, and rollback plans.
4. Azure HTTP/restart evidence and final DNS/HTTPS verification.
5. A GitHub Actions run and the deployed change it produced.
6. The five relevant postings and a redacted Job Scout delivery record.
7. The incident records, FAQ, decision records, and retrospective.
8. A cost/credit inventory, including expiration dates and cleanup plans.

Date your observations and record commands with their actual results. Redacted
terminal output, screenshots, and short explanations can support a check.
Screenshots alone do not replace the working final system. Identify anything
you could not verify rather than filling in the expected result.

Keep the final site available through your midterm interview. Follow the
instructor's resource cleanup directions after that checkpoint. Do not assume
you must keep both Azure and Heroku running for grading.

## How the 125 points are earned

Each row lists separately scored parts. Full credit on a part requires working
behavior and the specified evidence. Partial credit reflects the portions you
can demonstrate. Missing or unverified portions earn no credit for that part.
Documentation points assess explanation and reproducibility, separately from
the technical behavior scored in the other rows.

| Area | Points | Scored parts |
| --- | ---: | --- |
| Personal application | 15 | Profile and clear content (3); actual database reads and rendered projects (6); empty, failure, and recovery behavior (6) |
| Azure deployment | 20 | Running application/database and public Nginx path (8); explained SSH/network rules and private dependency listeners (6); service management and restart evidence (6) |
| Domain and HTTPS | 15 | Domain control, delegation, and accurate record explanation (5); working final DNS and HTTPS with hostname/validity checks (7); renewal explanation (3) |
| Migration to Heroku | 25 | Dependency inventory and plan (5); PostgreSQL compatibility and current-data comparison (8); working target and cutover validation (6); rollback and responsibility comparison (6) |
| GitHub Actions deployment | 10 | Workflow and protected credentials with a meaningful failing check (4); traceable successful deployment (4); recovery explanation (2) |
| Job Scout and email | 20 | Five real relevant postings and explainable matching (8); verified sender, DNS authentication, and delivered digest (7); inspectable run and controlled failure evidence (5) |
| Engineering record | 20 | Spec, plan, agent rules, and meaningful Git history (4); diagrams and reproducible setup (5); three incident records and five-question FAQ (5); decisions, retrospective, cost inventory, and submission index (6) |
| Total | 125 | |

A separate domain mailbox and GA4 are optional extensions, with no extra points
in this rubric. Prioritize the required system and evidence before extensions.
AWS hosting, a custom agent loop, and the AI project builder come after Project 1.

## Prepare to explain it at the midterm

Your interview is a separate 125-point assessment, scheduled October 27-29.
For the first 15 minutes, draw and explain your system from memory, without
notes or the repository. The final five minutes change one constraint.

Be ready to trace a request, explain a migration, diagnose a failure, compare
provider responsibilities, and discuss costs and remaining limits. Explain
what the coding agent created, what you changed, and how you verified it. A working
artifact and an explanation of that artifact are assessed separately.

## Choose and budget for services

Prefer GitHub Student Developer Pack offers when they meet the learning goals,
but compare alternatives with the instructor. Verify activation, eligibility,
limits, and expiration before relying on any benefit.

Heroku's student offer currently provides eligible students $13/month for 24
months. It includes Heroku products such as Postgres, excludes paid third-party
add-ons, requires a payment card, and charges usage beyond the monthly credit.
Check the current terms before provisioning: https://www.heroku.com/github-students/

Keep a service inventory and distinguish compute from retained storage and
other billable resources. Bring blocked access or unexpected costs to the
instructor before changing subscriptions.

## Start here

Begin with [Build your resume site in Codespaces](../guides/resume-site-in-codespaces.md).
Then use [Migrate your site to an Azure VM](../guides/azure-vm-migration.md).
Both are lesson drafts pending the instructor's environment rehearsal.
