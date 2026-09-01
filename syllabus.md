# ISBA 4775-01: Networking & Cloud Computing

**Loyola Marymount University | Fall 2026**

| | |
|---|---|
| Course | ISBA 4775-01, Networking & Cloud Computing |
| Credit hours | 4 |
| Meets | Tuesday and Thursday, 1:45 PM to 3:25 PM |
| Location | Hilton 115 |

## Instructor

| | |
|---|---|
| Instructor | Greg Lontok, Clinical Associate Professor |
| Office | Hilton 114 |
| Preferred contact | Microsoft Teams message, for the fastest response |
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
repository open, and then answer for it. "Working with AI" below is the full
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
| Project 2, the job-description-driven build | 300 |
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

There are ten exercises, worth 15 points each. You keep one public portfolio
repository with one folder per exercise.

### Exercise schedule

| # | Exercise | Type | Due |
|---|---|---|---|
| 01 | Accounts and development environment, and the self-discovery interview | Config | Tue 9/8 |
| 02 | The AI-assisted workflow: PRD, plan, ship | Build | Tue 9/15 |
| 03 | Personal site deployed on Railway, GA4 installed | Build | Thu 9/17 |
| 04 | Domain delegated to Route 53, live with TLS | Config | Thu 9/24 |
| 05 | **Broken DNS/TLS: diagnose and fix** | Troubleshoot | Thu 10/1 |
| 06 | Mailbox email with SPF, DKIM, DMARC; Resend verified | Config | Thu 10/8 |
| 07 | First orchestration: trigger, API call, notification | Build | Thu 10/15 |
| 08 | **Broken integration: expired credential, changed schema** | Troubleshoot | Tue 10/20 |
| 09 | Raw agent loop in Python, three tools, evals, trace read | Build | Thu 11/5 |
| 10 | **Broken agent: bad tool schema, runaway loop, cost blowup** | Troubleshoot | Thu 11/12 |

## Project 1: Own Your Corner of the Internet, 125 points

Project 1 runs from week 1 through week 8, and it is **due Thu 10/22.**

The exercises build the pieces. Project 1 is the integrated, documented,
portfolio-grade assembly of them.

| Deliverable | Requirement |
|---|---|
| Domain | Purchased, delegated to Route 53, hosted zone under your control |
| Site | Personal site on Railway, live at your domain with valid TLS |
| CI/CD | GitHub Actions, push to main deploys |
| Mailbox email | Zoho at your domain; SPF, DKIM, DMARC published and passing |
| Transactional email | Resend verified on your domain |
| Analytics | GA4 installed and reporting |
| Job Scout | An orchestration that finds local companies, reads their careers pages, scores openings against your resume, and emails you a digest from your own domain |
| Architecture diagram | One page, labeled, every service and the data flow between them |
| README | Configuration guide, an FAQ of at least five questions drawn from real failures, and a retrospective |

The question is not whether you completed the steps but whether you would show
this repository to an employer.

Your Job Scout must surface at least five real postings you would actually want.
You pick one, and it becomes Project 2's brief. If your scout underperforms,
there is a vetted feed of postings so you are not blocked.

## Midterm whiteboard interview, 125 points

The midterm is twenty minutes, in person and one-on-one, scheduled through
Calendly. Slots run **Tue 10/27 through Thu 10/29**, and a study guide is
published in advance.

You spend the first fifteen minutes on your own system. You diagram it from
memory, with no notes and no repository open, and then you answer for it: why
this service, what you rejected, what it costs, how you know it works, what
breaks first under load, and what you would do differently.

The last five minutes are a curveball. I change one constraint, drawn from a deck
whose categories you have seen but whose specifics you have not. Traffic might
increase tenfold, the budget might be cut by eighty percent, or a vendor might
sunset a service you depend on. You redesign on the spot.

Most students have never done a whiteboard interview. The October one is where
you find out what that is like while it still costs 125 points instead of 300,
and that is why it sits before the November 13 withdrawal deadline.

## Project 2: the job-description-driven build, 300 points

Project 2 runs from week 10 through week 15. You pick one posting your Job Scout
surfaced, read the system that job implies, and build it. The architecture is
fixed, and the job description chooses the problem domain.

| Deliverable | Requirement |
|---|---|
| Web app | On a subdomain of the domain you already own |
| Agent | Custom-built: tools, memory, structured outputs, guardrails, embedded as an endpoint |
| Grounding | Domain data in S3, reached with least-privilege IAM credentials |
| Orchestration | A layer connecting two systems on a trigger, doing real work in the job's domain |
| Environments | Local, staging, production, with promotion through CI/CD |
| CI/CD | GitHub Actions, secrets managed properly, deploy on merge |
| Operations | Auth, rate limiting, analytics, cost controls, a monitoring story |
| Evidence | An eval set for the agent and an inspectable trace |
| Decision record | Your most important decision, the evidence, how AI contributed, what you accepted or rejected or changed, how you validated it, your biggest remaining uncertainty, and what is next |
| Blog post | The writeup |

Everyone builds the same skeleton onto a different problem. A logistics posting
might yield a shipment-status copilot, a marketing posting a campaign analyzer,
and a healthcare-operations posting an intake triage assistant.

The orchestration requirement is a capability, not a tool. n8n, Make, Zapier,
Power Automate, and code all count.

Your system has to be both deterministic and agentic, and you have to defend
where the line between them falls. Knowing which parts should be a fixed workflow
and which should be agentic is a design judgment, and it is the obvious
curveball: your API costs tripled, so what moves out of the agent?

### Milestones

These are gates inside the Project 2 grade rather than separate line items.

| Milestone | Bar | Due |
|---|---|---|
| M1 | Posting selected, PRD written, architecture diagram approved | Tue 11/10 |
| M2 | App scaffolded and deployed to production on your subdomain | Tue 11/17 |
| M3 | Agent responding with tools, grounded in domain data via S3 and IAM | Tue 11/24 |
| M4 | Orchestration integrated, staging environment live and promoting to production | Thu 12/3 |
| Final | Full system, operations hardened, evals, decision record, blog post | Tue 12/8 |

M4 fails without a working staging environment. The application runs fine without
one, which makes it the first thing skipped under deadline pressure.

## Final whiteboard interview, 300 points

**Thursday, December 17, 11:00 AM**, in the scheduled exam slot, for thirty
minutes.

Same format as the midterm: twenty-five minutes on your own system from memory,
five minutes of curveball. The system you defend is the one you built for a job
you chose, so this is a simulated interview for that job.

## Semester at a glance

| Weeks | What happens |
|---|---|
| 1-8 | Networking foundations, then the cloud arc. Exercises 01-08, Project 1 |
| 9 | Midterm whiteboard interviews |
| 10-15 | Project 2, the job-description-driven build. Exercises 09-10, milestones M1-M4 |
| Finals | Final whiteboard interview |

Thanksgiving week meets once, on Zoom. Tuesday, November 24 is remote, and you
join from the Zoom tool in Brightspace rather than coming to Hilton 115.
Thursday, November 26 is Thanksgiving Day, and it is the only cancelled meeting
all semester.

Labor Day and Autumn Day fall on days this course doesn't meet.

### Key dates

| Event | Date |
|---|---|
| Add/drop without a W | Fri Sep 4 |
| Project 1 due | Thu 10/22 |
| Midterm interviews | Tue 10/27 to Thu 10/29 |
| Last day to withdraw | Fri Nov 13 |
| Instruction ends | Fri Dec 11 |
| Final interview | Thu Dec 17, 11:00 AM |

## Class schedule

| Date | Session | Due |
|---|---|---|
| Tue 9/1 | The map: where a request goes, and the devices it passes through | |
| Thu 9/3 | Finding things: host names, IP and MAC addresses, the default gateway, DNS, and what your own machine will tell you | |
| Tue 9/8 | Moving data: packets, frames, switches, routers, and then OSI and TCP/IP as the framework that organizes all of it | Ex01 |
| Thu 9/10 | Specs before code: the PRD, the implementation plan, and why AI amplifies a bad plan | |
| Tue 9/15 | Where code runs: IaaS, PaaS, serverless, and managed databases. Containers, build versus runtime, and why this course uses Railway | Ex02 |
| Thu 9/17 | DNS from the root down: zones, records, TTL, delegation, and nameservers | Ex03 |
| Tue 9/22 | TLS: what a certificate claims, how a browser decides it is valid, the four ways it goes invalid, and how ACME gets you one | |
| Thu 9/24 | Reading a system when it breaks: dig, curl, openssl, and the hypothesis log | Ex04 |
| Tue 9/29 | Failures that depend on who is asking: DNS propagation and TTL, cached answers, and why an incomplete chain passes in a browser but fails in curl | |
| Thu 10/1 | Diagnosis walkthroughs, then how mail routes: MX records and the envelope | Ex05 |
| Tue 10/6 | Email authentication: SPF, DKIM, DMARC, and deliverability as a DNS problem | |
| Thu 10/8 | APIs: REST, JSON, status codes, authentication, rate limits, and idempotency | Ex06 |
| Tue 10/13 | Orchestration: triggers, webhooks, polling, and joining two systems | |
| Thu 10/15 | How integrations break: expired credentials, changed schemas, and reading 401, 403, 429, and 5xx | Ex07 |
| Tue 10/20 | CI/CD with GitHub Actions, secrets, deploy on merge, and architecture diagrams | Ex08 |
| Thu 10/22 | Project 1 walkthroughs, the midterm study guide, and what a whiteboard interview is | Project 1 |
| Tue 10/27 | Midterm whiteboard interviews, no class session | |
| Thu 10/29 | LLM calls: tokens, context windows, cost, and structured outputs | |
| Tue 11/3 | The agent loop: tools, schemas, memory, and reading a trace | |
| Thu 11/5 | Evals: what to measure, building a small eval set, and finding why a run failed | Ex09 |
| Tue 11/10 | Reading a job description as a system spec, and architecture review one by one | M1 |
| Thu 11/12 | Guardrails: loop limits, schema validation, token budgets, and cost controls | Ex10 |
| Tue 11/17 | Environments: local, staging, production, and promotion through CI/CD | M2 |
| Thu 11/19 | Cloud storage and databases: object versus relational, S3, and least-privilege IAM | |
| Tue 11/24 | Grounding review, retrieval, chunking, and what the agent must not see. On Zoom | M3 |
| Thu 11/26 | No class, Thanksgiving | |
| Tue 12/1 | Operating a deployed system: auth, rate limiting, monitoring, and cost controls | |
| Thu 12/3 | Staging in practice, then the decision record | M4 |
| Tue 12/8 | Blog post workshop and final interview prep | Project 2 |
| Thu 12/10 | Final interview practice in pairs, and a course retrospective | |

## Work load expectations

LMU follows the Carnegie Unit standard: one semester credit hour represents at
least three hours of student engagement per week. See
https://academics.lmu.edu/aprc/lmucredithourpolicy/

For this four-credit course that is an average of **12 hours per week** across the
semester, including class meetings, exercises, project work, and preparation.

Expect this to be uneven. Weeks with a troubleshooting exercise and weeks around
a Project 2 milestone run heavier than the middle of a build.

## Required materials

There is no textbook. This course runs on real infrastructure, which costs real
money, and most of the spending starts in Exercise 01.

| What | Cost | When |
|---|---|---|
| Claude Pro | $20 a month | Exercise 01, and you keep it all semester |
| Railway | Free for 30 days, then $5 a month | Exercise 03, and the trial runs out in mid-October |
| Domain name | Free for a year through the GitHub Student Developer Pack, otherwise $10 to $15 | Exercise 04, and it stays yours after the course |
| Route 53 hosted zone | $0.50 a month | Exercise 04 |
| GitHub and AWS | Free tier | Exercise 01 |
| Zoho and Resend | Free tier | Exercise 06 |
| Google Cloud and Firecrawl | Free tier | Exercise 07 |

Budget roughly $100 for the semester, and most of that is Claude Pro.

Apply for the GitHub Student Developer Pack in week 1 at
https://education.github.com/pack. It's free, verification takes a few days, and
it covers a .me domain for a year plus credits on Railway. Anthropic doesn't
offer a student rate, so Claude Pro is full price either way.

Bring cost questions to me early rather than discovering a bill.

## Required lab fees

None.

## Instructional methods

We meet in person twice a week, and each session combines instruction, live work,
and student walkthroughs of their own exercises. Configuration and build work
runs throughout the semester. There are also two one-on-one whiteboard
interviews.

## Assignments and feedback

Exercises are submitted in your public portfolio repository and are due before
the class that uses them. Projects are submitted the same way, as live systems
plus their repositories. The one exception is the self-discovery interview in
Exercise 01, which goes to Brightspace. Due dates are announced in Brightspace
and stated in this syllabus.

Feedback on exercises is given in class and in the repository. Interview feedback
is given verbally at the end of the interview.

Deadlines are hard. Late work loses 10% per day, down to a floor of 50%. A late
assignment is worth less, but it's never worth nothing, so finish it and turn it
in.

If you know you're going to miss a deadline, send me a Teams message before it
passes. I may move it. That's case by case, and there's no bank of late days to
spend. If I move a deadline, the new date is the deadline, and the 10% per day
runs from there. No message before the deadline means no conversation after it,
and the 10% per day runs from the original date.

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

You will use a code editor, Git and GitHub, an AI coding assistant, a terminal,
AWS, Railway, and an orchestration tool of your choice. These are set up in
exercise 01.

See "Working with AI" below for how AI use is expected and assessed here.

For technology assistance, contact the ITS Service Desk:

- Phone: 310-338-7777 or 213-736-1097
- Email: servicedesk@lmu.edu
- Self-service: https://its.lmu.edu/servicedesk

## Working with AI

Use AI for everything it is good at: planning, writing code, debugging, reading
unfamiliar documentation, explaining errors, and drafting your PRDs.

There is no restriction on how much you use it and no requirement to log prompts.

What matters is what remains yours:

- You defend the system. An AI can build a system you cannot explain. The
  whiteboard interviews find that out.
- You validate your own work. Live systems, evals, traces, and an honest account
  of what you have not verified.
- You own the decisions. Which service, which alternative you rejected, where the
  deterministic/agentic line falls, and why. If AI recommended something and you
  took it, you should be able to say why it was right.
- You own what you ship, including its limits and what you would do next.

Independent work is not the same as independent thinking. You can use AI heavily
and demonstrate excellent ownership. You can also work entirely alone and
demonstrate very little.

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

AI use is expected and encouraged here, on the terms in "Working with AI" above.
Submitting a system you cannot account for is a violation regardless of what
produced it.

Two more violations are specific to this course. The first is presenting a system
as working when it is not. Every deliverable is publicly verifiable and gets
checked live. The second is presenting someone else's system as your own. Your
portfolio repository is public and permanent, and it carries your name.

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
syllabus was distributed. The version in this repository is always current, and
its revision history is visible in git.

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
