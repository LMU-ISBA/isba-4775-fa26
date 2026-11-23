# ISBA 4775-01: Networking & Cloud Computing

**Loyola Marymount University | Fall 2026**

| | |
|---|---|
| Course | ISBA 4775-01, Networking & Cloud Computing |
| Credit hours | 4 |
| Meets | Tuesday and Thursday, 1:45 PM to 3:25 PM |
| Location | Hilton 113 |

## Instructor

| | |
|---|---|
| Instructor | Greg Lontok, Clinical Associate Professor |
| Office | Hilton 114 |
| Preferred contact | Microsoft Teams message, for the fastest response |
| Course Teams channel | https://r.isba.co/networking-cloud-teams-fa26 |
| Email | gregory.lontok@lmu.edu |
| Office hours | By appointment. Book at https://calendly.com/greg-lontok |

## Course description

This course will introduce students to the fundamentals of networking and cloud
computing. Students will configure networks and cloud computing services to
address common information systems and business analytics needs through
hands-on exercises. The course will start with networking fundamentals covering
topics such as networking hardware, the OSI Model, TCP/IP, and various network
protocols, while addressing each topic's security considerations. The second
half of the course will leverage the student's networking foundation to explore
and deploy the most commonly used cloud services, including compute, storage,
databases, and serverless. Students will be able to host cloud-based
applications and know the difference between the various cloud services
available. This course may not be repeated for degree credit.

## Prerequisites

ISBA 3710 with a minimum grade of C-.

## What this course is for

You already know how to code, and this course is about what happens after that:
getting something you built to run somewhere other than your laptop, keeping it
running, and being able to explain how it works to someone who asks hard
questions.

By the end you should be able to walk into an unfamiliar system and make sense of
it.

## What you own

You will use AI throughout this course, heavily, and that is expected.

What stays yours is the system. You know how it works, how it talks to other
systems, what it is for, and how it delivers value to the stakeholder. It has to
be fit for purpose: not only that you can build one, but that it suits the
environment and constraints it has to live in.

Two whiteboard interviews, together worth 42.5% of your grade, are where that
gets observed. You diagram your own system from memory, with no notes and no
repository open, and then answer for it. "AI Policy" below is the full
policy.

## Learning outcomes

By the end of this course you can:

1. Read an unfamiliar system. Identify its components, dependencies, and
   boundaries, and ask the questions that reveal purpose, alternatives, cost, and
   where the pieces are isolated or coupled.
2. Design a system fit for purpose. Select and justify infrastructure against
   a stakeholder's real environment, constraints, and budget, and defend why that
   choice differs for a hobby project, a startup, and an enterprise.
3. Build and deploy an application on cloud infrastructure, moving it
   deliberately through local development, staging, and production.
4. Troubleshoot a system under failure. Form and test hypotheses, isolate the
   fault along the dependency chain, and describe what went wrong in the language
   practitioners use.
5. Operate a deployed system responsibly for access, security, performance,
   and cost, and produce evidence it is working as intended.
6. Explain and defend the system to a stakeholder. What it does, why it was
   built this way, which alternatives were rejected, where its limits are, and
   what should happen next.

## Grading

| Component | Points |
|---|---:|
| Exercises (10 × 15) | 150 |
| Project 1, Own Your Corner of the Internet | 125 |
| Midterm whiteboard interview | 125 |
| Project 02, the job-description-driven build | 300 |
| Final whiteboard interview | 300 |
| **Total** | **1000** |

Projects are 42.5% and interviews are 42.5%. This course grades whether you can
explain what you built about as heavily as the artifact itself.

### Letter grades

| Grade | Range | | Grade | Range |
|---|---|---|---|---|
| A | 93-100 | | C+ | 77-79 |
| A- | 90-92 | | C | 73-76 |
| B+ | 87-89 | | C- | 70-72 |
| B | 83-86 | | D | 60-69 |
| B- | 80-82 | | F | below 60 |

## Exercises, 150 points

There are ten exercises, worth 15 points each. Exercise 01 and Exercise 02
are submitted as files through Brightspace. Exercises 03 through 07 go in
your public `career-platform` repository. From Exercise 08 on, the work is in
your private Project 02 repository. Each one defines its required evidence
and grading. Exercises are credit/no credit: credit earns
15 points and no credit earns 0. Meaningful attempts and honest investigation
can earn credit even when a result needs correction.

Exercise 02 extends the in-class server lab: independently investigate a
stopped Nginx service and a stopped MySQL service, explain your evidence,
repair each service, and repeat the failed test. Submit a hand-drawn system
diagram as a JPG and a short investigation report as a PDF. The two
investigations, diagram and explanation, healthy baseline, and verified
Codespace shutdown guide feedback within the credit/no-credit assessment.

### Exercise schedule

| # | Exercise | Type | Due |
|---|---|---|---|
| 01 | Accounts, your home network, and the self-discovery interview | Config | Tue 9/8 |
| 02 | Troubleshoot a cloud service: Nginx and MySQL | Troubleshoot | Tue 9/15 |
| 03 | Build it, then move it: spec, plan, and migration plan | Build | Thu 10/1 |
| 04 | Domain delegated to Cloudflare DNS, live with HTTPS | Config | Thu 10/8 |
| 05 | **Broken DNS/TLS: diagnose and fix** | Troubleshoot | Tue 10/13 |
| 06 | Domain email and GA4: mail delivery, a page view, and an outbound click | Config | Tue 10/20 |
| 07 | Migrate your site from Railway to AWS: EC2, RDS, verified cutover, and a diagram | Build | Tue 11/10, 1:45 PM |
| 08 | Real data and your first model calls: about 20 records for your posting, then one record sent to a model three ways | Build | Tue 11/17, 1:45 PM |
| 09 | A workflow and an agent: one question answered two ways in Python, from steps you write first, with one tool, a step limit, and a comparison of the runs | Build | Tue 11/24, 1:45 PM |
| 10 | **One real failure from your Project 02 work: what you saw, the cause, and the fix, in your own words** | Troubleshoot | Tue 12/8, 1:45 PM |

Ex01 and Ex02 were due at 1:45 PM, before class, and Ex03 is due at the same
time on Thu 10/1. The Railway migration is a Project 1 requirement, taught on
Thu 10/8. Exercise 05 is due Tue 10/13, after the DNS/TLS lesson. Exercise 06
is due Tue 10/20, covering the Zoho and GA4 lessons. Both are due at 1:45 PM.
Basic GA4 is required for Project 1 and taught on Thu 10/15. Exercise 07 is
the AWS migration, taught Thu 10/29 and Tue 11/3 and due Tue 11/10. Exercises
08 through 10 follow the Project 02 lessons, which started Tue 11/10.
Exercise 08 is sections 2 through 6 of
[Your first model call](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/first-model-call.md).
Exercise 09 is sections 3 through 5 of
[A workflow and an agent](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/workflow-and-agent.md).
Exercise 10 has its own
[requirements](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/exercises/ex10-a-real-failure.md).

## Project 1: Own Your Corner of the Internet, 125 points

Project 1 runs from week 1 through week 8, and it is **due Thu 10/22 at
1:45 PM, before class.**

The exercises build the pieces. Project 1 is the integrated, documented,
portfolio-grade assembly of them.

| Deliverable | Requirement |
|---|---|
| Domain | Purchased, delegated to Cloudflare DNS, zone under your control |
| Site | Personal site on an Azure VM, then migrated to Railway with Railway-hosted PostgreSQL, live at your domain with valid TLS |
| Website update | Railway's GitHub autodeploy, with a reviewed and locally checked change, its commit and deployment, and verification of the live result |
| Domain email | Zoho Mail with MX, SPF, DKIM, and DMARC configured, plus verified sending, receiving, and replying from your domain |
| Analytics | GA4 with a verified page view and one useful interaction, plus an explanation of what each measures |
| Architecture diagram | Labeled services and data flow, including the migration and current system |
| Engineering record | A concise README and `docs/project-1-submission.md` linking configuration, plans, checks, and troubleshooting evidence already in the repository |

The question is not whether you completed the steps but whether you would show
this repository to an employer.

You may use your agent to reconstruct the engineering record from your files
and Git history. Verify its account and link the supporting evidence. Rerun
missing checks or mark them unverified, and identify accounts written afterward.
The engineering record does not require a separate report.

GitHub Actions moves after the midterm. Exercise 07 is the AWS migration,
taught October 29 and November 3 and due November 10. Project 02 starts
November 10, when you find your own postings and choose one.

## Midterm whiteboard interview, 125 points

The midterm is twenty minutes, in person and one-on-one, in Hilton 114.
Slots run Monday, October 26, through Wednesday, October 28. Tuesday's
interviews use our October 27 class period, and we meet for regular class on
Thursday, October 29. Book one appointment:

https://calendly.com/greg-lontok/4775-midterm-interview-fa26

The interview is fifteen minutes of drawing, explanation, and follow-up
questions, then a five-minute debrief. It covers our first-half class
material, Exercises 01 through 06, and Project 1, from memory, without notes
or your repository.

Draw how data travels from a device through network hardware to an application
and back, including your original Azure setup and current Railway setup. Be
ready to explain your choices, costs, troubleshooting checks, and evidence
that the system works. The study guide has the scoring table, the
minute-by-minute shape, and practice questions.

The changed constraint takes no more than three minutes. You'll know the
categories beforehand, but the interview uses a different specific change:
more traffic, a smaller budget, or a provider you must leave. Revise the
affected part of your drawing and explain the tradeoff, verification, and
recovery.

Most students have never done a whiteboard interview. The October one is where
you find out what that is like while it still costs 125 points instead of 300,
and that is why it sits before the November 13 withdrawal deadline.

## Project 02: the job-description-driven build, 300 points

Project 02 runs from week 11 through week 15, and it is **due Thu 12/10 at
1:45 PM, before class.** You choose one real job posting, read the system
that job implies, and build it on AWS, with an agent you built doing the
job's repeated work.

The [Project 02 requirements](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/projects/project-02.md)
are the full statement. Where this summary and the requirements differ, the
requirements govern.

| Deliverable | Requirement |
|---|---|
| Posting and PRD | One posting that passes the four tests, one next-step posting, and a PRD |
| System on AWS | Your app, agent, and data in your AWS account, live over HTTPS at a subdomain of the domain you already own |
| Agent | Built or extended by you: at least one tool, a step limit, and refusals outside its job |
| Data | Real data first, stored on AWS in S3 or RDS, reached with access to only what the agent needs |
| Schedule | Something other than you starts your workflow, on a schedule or on an event |
| Environments | Local, staging, and production, with GitHub Actions deploying and secrets kept out of the repository |
| Operations | An access gate, cost controls, and an outside monitor that tells you when the system is down |
| Evals | At least five cases you write, with expected answers, and one readable trace |
| Architecture decision | Two designs compared, one chosen, and a decision record |
| Blog post and LinkedIn draft | Both written for a reader who isn't technical |
| Engineering record | A README and `docs/project-02-submission.md` |

You design the architecture. Class lessons build one design on AWS, and you
can follow it, change it, or design your own. A logistics posting might yield
a shipment-status copilot, a marketing posting a campaign analyzer, and a
healthcare-operations posting an intake triage assistant.

Something other than you has to start your workflow. A cron schedule is
enough, and an event from a second system counts too, through n8n, Make,
Zapier, Power Automate, or code.

Your system has to be both deterministic and agentic, and you have to defend
where the line between them falls. Knowing which parts should be a fixed workflow
and which should be agentic is a design judgment, and it is the obvious
curveball: your API costs tripled, so what moves out of the agent?

### Milestones

Each milestone is graded when it's due, and its points are part of the 300.
The late policy for projects applies to each one.

| Milestone | Bar | Due | Points |
|---|---|---|---:|
| M1 | PRD, data source, two architectures with cost estimates, your choice and reason, and a diagram | Tue 11/17 | 60 |
| | Your AWS site is working, for the staging and production lesson | Tue 11/24 | |
| M2 | App live at your production subdomain behind a password, and one change moved from staging to production | Tue 12/1, 1:45 PM | 75 |
| M3 | Agent answering a grounded question with a tool, from your data on AWS, shown live in class | Tue 12/8 | 75 |
| Final | The submitted project, with the areas no milestone covers | Thu 12/10, 1:45 PM | 90 |

M2 needs a working staging environment. The application runs fine without
one, which makes it the first thing skipped under deadline pressure.

## Final whiteboard interview, 300 points

**Monday, December 14, through Thursday, December 17**, by appointment, for
25 minutes.

Same format as the midterm: twenty minutes on your own system from memory,
including a changed constraint, then a five-minute debrief. The system you
defend is the one you built for a job you chose, so this is a simulated
interview for that job. When you book, you'll give a link to your updated
resume, which links to your GitHub portfolio and your project. The booking
link and the study guide come out by December 10.

## Semester at a glance

| Weeks | What happens |
|---|---|
| 1-8 | Networking foundations, then the cloud arc. Exercises 01-06, Project 1 |
| 9 | Midterm whiteboard interviews Monday through Wednesday, then AWS migration Thursday |
| 10-15 | The AWS migration, then Project 02, the job-description-driven build. Exercises 07-10, milestones M1-M3 |
| Finals | Final whiteboard interview |

Thanksgiving week meets once, on Zoom. Tuesday, November 24 is remote, and you
join with the Zoom link in Brightspace's Week 13 module rather than coming to
Hilton 113.
Thursday, November 26 is Thanksgiving Day, and it is the only cancelled meeting
all semester.

Labor Day and Autumn Day fall on days this course doesn't meet.

### Key dates

| Event | Date |
|---|---|
| Add/drop without a W | Fri Sep 4 |
| Project 1 due | Thu 10/22 |
| Midterm interviews | Mon 10/26 to Wed 10/28 |
| Last day to withdraw | Fri Nov 13 |
| Instruction ends | Fri Dec 11 |
| Final interviews | Mon Dec 14 to Thu Dec 17, by appointment |

## Class schedule

| Date | Session | Before class | Due |
|---|---|---|---|
| Tue 9/1 | The map: where a request goes, and the devices it passes through | | |
| Thu 9/3 | Finding things: host names, IP and MAC addresses, the default gateway, DNS, and what your own machine will tell you | | |
| Tue 9/8 | Ports and web services: requests, responses, HTTP status codes, and investigating a service failure | | Ex01 |
| Thu 9/10 | Running and Troubleshooting Services: physical server, VM, container; Nginx and MySQL; processes, ports, logs; database creation, tables, and sample data | | |
| Tue 9/15 | Build your resume site: your own repository and Codespace, a specification and plan, a database-backed application, failure/recovery, and verified changes saved in Git | | Ex02 |
| Thu 9/17 | Building with an agent and Git: executing the implementation plan, the request path through Nginx, the app server, and SQLite, and clone, add, commit, push, and pull | | |
| Tue 9/22 | Migrating to a VM: feature branches and pull requests, what Git moves and what it doesn't, IaaS, PaaS, and SaaS, and Azure resource groups | | |
| Thu 9/24 | Creating the VM: SSH keys, an Azure VM, a cloud firewall rule for SSH, and a written migration plan | | |
| Tue 9/29 | Finishing the migration: rebuilding the environment, moving live SQLite data, and verifying the app on the VM | | |
| Thu 10/1 | Operating the VM: Uvicorn workers and systemd, Nginx as a reverse proxy, recovering after a restart, and delegating your domain to Cloudflare DNS | Register your domain with [the domain guide](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/register-a-domain.md), a free .me or a $6.79 .com. Create a [free Cloudflare account](https://dash.cloudflare.com/sign-up). | Ex03 |
| Tue 10/6 | HTTPS for your domain: certificates, the request path, renewal, and troubleshooting DNS/TLS | Run `nslookup -type=NS yourdomain` and confirm Cloudflare's name servers. Confirm your site loads over HTTP. No Resend signup is needed. | |
| Thu 10/8 | Migrating to a PaaS: PostgreSQL on Railway, comparing source and target data, cutting the domain over, and who manages what | By 10/7, finish Railway signup. Before class, complete Ex04 and the required [Impeccable design activity](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/improve-your-site-design.md). Keep Azure running until migration is verified. | Ex04 |
| Tue 10/13 | Zoho Mail at your domain: MX, SPF, DKIM, and DMARC, then sending, receiving, and replying | By 10/12, finish the Zoho account preparation below. Bring access to your domain's Cloudflare zone. | Ex05 |
| Thu 10/15 | What an MCP server is, and connecting your coding agent to Zoho Mail. Then GA4: page views, one useful interaction, and event verification | By 10/14, create your Analytics account, GA4 property, and web stream using the preparation below. Bring the measurement ID and access to your site repository. | |
| Tue 10/20 | Project requirements review, practice interviews in pairs, and what a whiteboard interview is | Finish the site, migration, domain email, and GA4 checks. Bring your README and submission index. Draw the system from memory once. | Ex06 |
| Thu 10/22 | Guest speakers Cian O'Brien and Timothy Cherpes, ISBA alumni at ServiceNow | Submit Project 1 before class at 1:45 PM. By Wed 10/21 at 11:59 PM, read both LinkedIn profiles and post two questions in the Brightspace discussion. | Project 1 |
| Tue 10/27 | Midterm interviews replace class. More slots run Mon 10/26 and Wed 10/28. | Book one Calendly appointment and practice with the study guide. | |
| Thu 10/29 | Migrate your site from Railway to AWS: code, data, configuration, and the domain | Bring access to your repository, Railway database, and Cloudflare zone. | |
| Tue 11/3 | Migrate your site from Railway to AWS, continued: the AWS CLI, the deployment policy, the plan, RDS, and EC2 | Install the AWS CLI and confirm you can sign in as your IAM user with MFA. Know where your Railway backup is. | |
| Thu 11/5 | Professor Ken Summers: Troubleshooting Road Show, the full session | Keep working on Exercise 07. | |
| Tue 11/10 | Finding your Project 02 postings: a new repository and research wiki, Indeed and Firecrawl connected to your coding agent, and your first saved posting | | Ex07 |
| Thu 11/12 | Real data and your first model call: data for your posting, a model API key set up in class, and one record sent to a model three ways | Save and compare three postings, choose one, and save one next-step posting. | |
| Tue 11/17 | A workflow and an agent: sorting your posting's duties, then one question answered two ways in Python and compared | Submit M1 and Exercise 08 before class at 1:45 PM. | Ex08, M1 |
| Thu 11/19 | A workflow and an agent, continued: the workflow rebuilt from steps you write first, then the agent with one tool and a step limit, and the comparison | Bring Tuesday's `workflow.py` run and your `my-workflow-and-agent` wiki page. | |
| Tue 11/24 | Staging and production: your agent behind a page, checks in GitHub Actions, a staging deploy, and promotion to production. CI/CD and DevOps. On Zoom | Have your AWS site working, and do section 0 of the [guide](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/staging-and-production.md) from the network you'll use for class. Join with the Zoom link in Brightspace's Week 13 module. | Ex09 |
| Thu 11/26 | No class, Thanksgiving | | |
| Tue 12/1 | LMU Data Center tour with [Jeff Solomon](https://its.lmu.edu/whoweare/staff/infrastructureservices/) | Submit M2 by 1:45 PM. Meet in University Hall in front of Einstein Bros. Bagels. | M2 |
| Thu 12/3 | Data access: your data in S3 or RDS with least privilege, the agent's refusal, and a schedule for your workflow | Have M2 working. Know whether your data goes to S3 or RDS. | |
| Tue 12/8 | M3 shown live in class, then evals: five cases you write and one trace. Then the blog post and LinkedIn draft workshop, and an outside monitor | Bring three questions your data can answer, with the answers you expect. | Ex10, M3 |
| Thu 12/10 | Final interview practice in pairs, and a course retrospective | Submit Project 02 before class at 1:45 PM. | Project 02 |

Professor Ken Summers leads the full class session on November 5, in Hilton
113, with his Troubleshooting Road Show. That evening, Brandon Kulik from Deloitte will
speak on "Consulting in the Age of AI." The event runs from 6:00 to 7:00 PM
in Hilton 107. RSVP at https://lmu.campuslabs.com/engage/event/12919719.

The October 6 revision keeps the Railway/PostgreSQL migration and focuses
Project 1 on your website, domain, Zoho email, and basic GA4. October 20 is
reserved for the project requirements review and interview practice. GitHub
Actions moves after the midterm. No Claude API credit purchase is needed for
Project 1.

The November 17 revision replaces Job Scout with Project 02's own lessons.
Starting November 10, you find your postings with your coding agent, get real
data, and build a workflow and an agent in Python. Exercises 08 and 09 come
from those lessons, and tested deployment comes next. Resend isn't used.

The November 18 revision gives the workflow and the agent a second class on
November 19, so you write the workflow's steps before your agent writes the
code. Tested deployment moves to November 24, and Exercise 09 is due that
day.

The November 19 revision moves M2 to December 1, so you can deploy with what
the November 24 class teaches.

The November 23 revision makes Project 02 one small system you own. M4 is
removed, M3 moves to December 8, and Exercise 10 becomes one real failure
from your own project. Final interviews run by appointment from December 14
to December 17. The Project 02 requirements list every change.

### Prepare before class

Complete account setup ahead of the lesson so we can use class time to
configure and verify the system.

- **Before Thursday, October 8, at 1:45 PM:** complete the required
  [website design activity with Impeccable](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/improve-your-site-design.md)
  alongside Ex04. Spend 30-45 minutes making two or three focused improvements
  in your existing repository, with before/after screenshots and checks.
  Follow the guide's fallback if installation or deployment is blocked. Bring
  the branch and honest results. This preparation adds no separate grade item
  or points, and Ex04's HTTPS requirements remain in effect.

- **By Wednesday, October 7, for Thursday's migration:**
  [sign in to Railway](https://railway.com/login) with GitHub and
  [check your trial](https://railway.com/verify). The sign-in window is
  October 3-7, and the trial starts when you sign in. Create nothing yet.
  Finish Ex04, save your HTTPS and certificate-renewal evidence, and have
  the current Azure database ready to migrate. Keep the VM running until
  the app, data, and domain work over HTTPS on Railway.
- **By Monday, October 12, for Tuesday's email lesson:** create your own
  Zoho account using the Forever Free option on the
  [Zoho Mail pricing page](https://www.zoho.com/mail/zohomail-pricing.html).
  Have your domain name and Cloudflare login ready. If Forever Free isn't
  offered in your signup region, contact me before choosing a paid plan
  or trial. Leave the mail DNS records for class, when we'll configure
  the mailbox and test delivery and replies together.
- **By Wednesday, October 14, for Thursday's analytics lesson:** sign in
  with a Google account and follow Google's
  [Analytics setup instructions](https://support.google.com/analytics/answer/9304153?hl=en)
  to create an Analytics account, a GA4 property, and a web data stream for
  your site's HTTPS URL. Bring the stream's measurement ID. Stop before
  installing the tag, which we'll do and verify together in class.
- **By Tuesday, November 24, at 1:45 PM:** have your AWS site working,
  because the lesson deploys to it. If it isn't, finish the
  [AWS migration guide](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/aws-migration.md)
  or come to office hours.

## Work load expectations

LMU follows the Carnegie Unit standard: one semester credit hour represents at
least three hours of student engagement per week. See
https://academics.lmu.edu/aprc/lmucredithourpolicy/

For this four-credit course that is an average of **12 hours per week** across the
semester, including class meetings, exercises, project work, and preparation.

Expect this to be uneven. Weeks with a troubleshooting exercise and weeks around
a Project 02 milestone run heavier than the middle of a build.

## Required materials

There is no textbook. This course runs on real infrastructure, which costs real
money, and most of the spending starts in Exercise 01.

| What | Cost | When |
|---|---|---|
| Claude Pro or an accepted ChatGPT subscription | Claude Pro is $20/month on monthly billing; alternative plan pricing varies | Choose one in Ex01; follow the relevant assignment for coding-agent setup |
| Railway | The 30-day trial includes a one-time $5 credit and needs no card. After it ends, the Free plan's $1 a month may not keep your site running | Sign in between 10/3 and 10/7 for the Thu 10/8 migration |
| Domain name | Free for a year through the GitHub Student Developer Pack, otherwise $10 to $15 | Before Thu 10/1, and it stays yours after the course |
| Cloudflare DNS | Free | Before Thu 10/1 |
| GitHub | Free tier | Exercise 01 |
| GitHub Codespaces | Personal-account compute/storage allowance; additional usage can cost money | Course Codespace in Session 04 for Ex02; new portfolio Codespace in Session 05 |
| AWS | Free tier | Migration on Thu 10/29, then Project 02 |
| Zoho Mail | Forever Free where offered; contact me if unavailable | Create your account by Mon 10/12 for Tue 10/13 |
| Google Analytics 4 | Standard account is free | Create the account, property, and web stream by Wed 10/14 for Thu 10/15 |
| Model API | Billed separately from your subscription. Class demos use the Claude API with about $5 of credits, and any provider counts | Set up in class on Thu 11/12 |
| Indeed and Firecrawl connectors | Free tiers were enough for class | Set up in class on Tue 11/10 |

Plan your budget around the AI subscription you choose, domain registration,
and the services you actually run. Prices, credits, and eligibility can
change. Check [Claude pricing](https://support.claude.com/en/articles/11049762-choose-a-claude-plan),
[Railway plans](https://docs.railway.com/pricing/plans), and
[Codespaces billing](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces)
before enabling paid usage. A free tier does not mean all usage is free.

Apply for the [GitHub Student Developer Pack](https://education.github.com/pack)
in week 1 and check the current offers and verification status in your account.
Do not plan on a particular benefit until you have confirmed eligibility.

For the Codespaces lab, check your allowance with the instructor, keep forwarded
ports private, and stop the environment when finished. Contact me if access is
blocked or a billing change is requested. Bring cost questions to me early.

## Required lab fees

None.

## Instructional methods

We meet in person twice a week, and each session combines instruction, live work,
and student walkthroughs of their own exercises. Guided setup and build-alongs
include predictions, live troubleshooting, and brief discussion. Detailed
incident reports and diagrams are completed independently in the assigned
homework. There are also two one-on-one whiteboard interviews.

## Assignments and feedback

Follow each assignment's submission instructions. Ex01 and Ex02 go to
Brightspace as separate files. Later builds use repositories and live systems
as specified in their requirements; projects include their repositories and deployed
systems. Due dates are announced in Brightspace and reflected in this syllabus.
A date marked proposed or to be announced is not a confirmed deadline.

For Ex02, Google Docs saves your report automatically. Confirm it is saved to
Drive, stop the Codespace, add your shutdown note, and download the report as
a PDF for submission. Your diagram is a separate JPG. The Codespace should
be stopped after testing; it does not need to remain running for grading.

Feedback is given in class, in Brightspace, or in the repository, depending on
the assignment. Interview feedback is given verbally at the end of the interview.

Projects lose 10% per day when late, down to a floor of 50%. Percentage late
penalties apply only to projects. Exercises remain credit/no credit, 15 or 0
points, including late work. Finish and submit the work even when it is late.

If you know you're going to miss a deadline, send me a Teams message before it
passes. I may move it. That's case by case, and there's no bank of late days to
spend. For projects, the 10% per day runs from the new date if I move it.
Otherwise it runs from the original project deadline. Exercises retain their
15-or-0 grading without a percentage late deduction.

Some assignments are delivered in person at a fixed time, and the meeting time is
the deadline. The two whiteboard interviews can't be rescheduled, so missing one
scores zero on it.

Emergencies sit outside all of this. Tell me when you're able and we'll make a
plan.

## Attendance

Your scheduled commitments are class sessions, your midterm interview slot, and
the final interview.

If you feel ill, stay home. Rest, and keep everyone else healthy.

When you can't make one, send me a Teams message. Beforehand is best, and as soon
as you can if something happens that morning. Late still beats silent.

Your first three absences cost you nothing if you told me. You don't owe me a
reason and I won't ask for documentation.

An absence you never tell me about costs 2% of your total grade, and it still
uses up one of the three. From the fourth on, each absence costs 2% whether you
told me or not. That 2% comes off your final grade after everything else is
totaled, so attendance is not a line in the grading table.

Emergencies sit outside all of this. Serious illness, hospitalization, a death in
the family: the three-absence count doesn't apply. Tell me when you're able and
we'll work out a plan for the rest of the term.

## Use of technology

We introduce tools when the relevant lesson or assignment needs them. In
Session 04, students create a Codespace directly from the course repository.
They install services and create a MySQL database with sample data.

In Session 05, students create a public `career-platform` repository and open
their own Codespace using the [resume-site guide](https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/resume-site-in-codespaces.md).
They start with a README and Python `.gitignore`, then use the coding agent
to develop their specification and implementation plan before building.

The coding agent interviews students, then helps build a Python application
after plan approval. Students verify database reads, failure, and recovery.
They commit and push a working version, then make and verify a small change
before committing and pushing again.

The early server lab does not require a local editor, database, or coding-agent
installation. Follow each later lesson guide for its workflow setup.
Cloudflare, Railway, Zoho Mail, and GA4 support Project 1. AWS, a model API,
and orchestration tools follow after the midterm. The class schedule's Before
class column and preparation checklist list what to set up ahead of each
meeting.

For technology assistance, contact the ITS Service Desk:

- Phone: 310-338-7777 or 213-736-1097
- Email: servicedesk@lmu.edu
- Self-service: https://its.lmu.edu/servicedesk

## AI Policy

Use AI for planning, coding, debugging, research, and writing. There is no
limit on AI use, and you do not need to log your prompts. Every assignment
assumes you have a capable AI tool available.

What stays yours is the judgment and understanding. You must be able to
explain what your system does, why you built it that way, and what works or
doesn't, without notes or AI. You'll demonstrate this twice at the whiteboard.

Practice four habits:

1. Understand before building. Have AI examine the actual requirements,
   documentation, code, or data. Ask questions instead of guessing.
2. Review the plan. Question assumptions, evaluate tradeoffs, and approve the
   approach before AI builds.
3. Verify the results. Test the actual system yourself. AI claiming success
   is not evidence.
4. Document decisions and evidence. Record what you chose, rejected, tested,
   and haven't verified. You don't need prompt logs; you need evidence of
   your reasoning.

Protect sensitive information. Never share passwords, API keys, account
numbers, or another person's private information with AI. Keep secrets out
of Git.

I grade understanding, evidence, and honesty, not polish alone. An incomplete
result with a thoughtful investigation can earn credit. A polished result you
cannot explain does not. AI use is encouraged; misrepresenting your work or
evidence is not. LMU's academic honesty policy still applies.

Independent work is not the same as independent thinking. You can use AI
extensively and demonstrate excellent judgment, or work alone and demonstrate
very little. What matters is what you understand, can defend, and take
responsibility for.

## Student support

- Academic Resource Center: https://academics.lmu.edu/arc/
- Student Psychological Services: https://studentaffairs.lmu.edu/wellness/studentpsychologicalservices/
- Disability Support Services: https://academics.lmu.edu/dss/
- Community of Care: https://studentaffairs.lmu.edu/lmucares/

If something outside this course is affecting your ability to do the work, tell
me.

## University policies

### Academic honesty

Loyola Marymount University is a community dedicated to academic excellence,
student-centered education, and the Jesuit and Marymount traditions. As such, the
University expects all members of its community to act with honesty and integrity
at all times, especially in their academic work. Academic honesty requires that
all members of the LMU community act with integrity, respect their own
intellectual and creative work as well as that of others, acknowledge sources
consistently and completely, act honestly during exams and on assignments, and
report results accurately. As an LMU Lion, by the Lion's Code, you are pledged to
join the discourse of the academy with honesty of voice and integrity of
scholarship.

Academic dishonesty will be treated as an extremely serious matter, with serious
consequences that can range from receiving no credit for assignments/tests to
expulsion. It is never permissible to turn in any work that has been copied from
another student or copied from a source (including Internet) without properly
acknowledging/citing the source. It is never permissible to work on an
assignment, exam, quiz or any project with another person unless your instructor
has indicated so in the written instructions/guidelines. It is your
responsibility to make sure that your work meets the standard of academic honesty
set forth in the "Academic Honesty Policy" found at:
https://academics.lmu.edu/honesty/ For an additional resource, see and the "LMU
Honor Code and Process" found at:
https://bulletin.lmu.edu/content.php?catoid=1&navoid=18#LMU_Honor_Code_and_Process

#### What this means in this course

AI use is expected and encouraged here, on the terms in "AI Policy" above.
Submitting a system you cannot account for is a violation regardless of what
produced it.

Two more violations are specific to this course. The first is presenting a system
as working without evidence that it works. Report actual observations,
including failed checks and unresolved problems; do not fabricate output.
Evidence may be a private report, a repository, or a live demonstration, as
specified in the assignment. The second is presenting someone else's system,
drawing, or evidence as your own. You must be able to explain what you submit.

### Special accommodations

The DSS Office offers resources to enable students with physical, learning,
ADD/ADHD, psychiatric disabilities and those on the autism spectrum to achieve
maximum independence while pursuing their educational goals. Staff specialists
interact with all areas of the University to eliminate physical and attitudinal
barriers. Students must provide documentation for their disability from an
appropriate licensed professional. Services are offered to students who have
established disabilities under state and federal laws. We also advise students,
faculty and staff regarding disability issues. Students who need reasonable
modifications, special assistance, academic accommodations or housing
accommodations should direct their request to the DSS Office as soon as possible.
All discussions will remain confidential. The DSS Office is located on the 2nd
floor of Daum Hall and may be reached by email at dsslmu@lmu.edu or phone at
(310) 338-4216. Please visit http://www.lmu.edu/dss for additional information.

The whiteboard interviews can be accommodated. The earlier I know, the better I
can plan them.

### Tentative nature of the syllabus

This syllabus and its contents are subject to revision; students are responsible
for any changes or modifications announced or distributed in class or posted on
LMU's course management system.

Exercise scope and dates may shift as the semester develops. Any revision will be
announced in class and through Brightspace, the same channels through which this
syllabus was distributed. The version at
https://r.isba.co/networking-cloud-syllabus-fa26 is always current, and its
revision history is visible in git.

## Classroom conduct and communication

Treat your classmates with professional respect, particularly when walking
through each other's work. Much of this course involves showing something broken
in front of the room, which only works if that is a safe thing to do.

Check your lion.lmu.edu email and Microsoft Teams regularly. Those are the
channels I use and you are responsible for what is sent through them.

LMU's expectations for classroom behavior are at
https://lmu.box.com/s/v2x89uspgbx3l23egcz7mjd6dbekcn60

Reporting requirements for sexual or interpersonal misconduct:
https://studentaffairs.lmu.edu/lmucares/

Emergency preparedness information: https://www.lmu.edu/emergency

## College of Business Administration mission

We advance knowledge and develop business leaders with moral courage and creative
confidence to be a force for good in the global community.

https://cba.lmu.edu/about/mission/
