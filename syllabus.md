# ISBA 4775-01: Networking & Cloud Computing

**Loyola Marymount University | Fall 2026**

| | |
|---|---|
| Course | ISBA 4775-01, Networking & Cloud Computing |
| Credit hours | 4 |
| Meets | Tuesday and Thursday, 1:45 PM to 3:25 PM |
| Location | Hilton 115 |
| Instruction | September 1 to December 10, 2026 |
| Final interview | Thursday, December 17, 11:00 AM, in the scheduled exam slot |

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

You can already code. This course is about what happens after that: getting
something you built to run somewhere other than your laptop, keeping it running,
and being able to explain how it works to someone who asks hard questions.

By the end you should be able to walk into an unfamiliar system and make sense of
it. Not because you have memorized this one, but because you know the questions
to ask of any of them.

It differentiates a student who can code from a student who can code and actually
host and deploy that code.

## What you own

You will use AI throughout this course, heavily, and that is expected.

What stays yours is the system. You know how it works, how it talks to other
systems, what its purpose is, how to build it, and how to deliver value
appropriate to the stakeholder's needs. The system has to be fit for purpose: not
only that you can build one, but that it caters to the right environment and
constraints.

Two whiteboard interviews, together worth 42.5 percent of your grade, are where
that gets observed. You diagram your own system from memory, with no notes and no
repository open, and then answer for it.

## Learning outcomes

By the end of this course you can:

1. **Read an unfamiliar system.** Identify its components, dependencies, and
   boundaries, and ask the questions that reveal purpose, alternatives, cost, and
   where the pieces are isolated or coupled.
2. **Design a system fit for purpose.** Select and justify infrastructure against
   a stakeholder's real environment, constraints, and budget, and defend why that
   choice differs for a hobby project, a startup, and an enterprise.
3. **Build and deploy an application on cloud infrastructure,** moving it
   deliberately through local development, staging, and production.
4. **Troubleshoot a system under failure.** Form and test hypotheses, isolate the
   fault along the dependency chain, and describe what went wrong in the language
   practitioners use.
5. **Operate a deployed system responsibly** for access, security, performance,
   and cost, and produce evidence it is working as intended.
6. **Explain and defend the system to a stakeholder.** What it does, why it was
   built this way, which alternatives were rejected, where its limits are, and
   what should happen next.

## Grading

A 1000-point scheme. Every point is a tenth of a percent.

| Component | Points | % |
|---|---:|---:|
| Exercises (10 × 15) | 150 | 15.0 |
| Project 1, Own Your Corner of the Internet | 125 | 12.5 |
| Midterm whiteboard interview | 125 | 12.5 |
| Project 2, the JD-driven build | 300 | 30.0 |
| Final whiteboard interview | 300 | 30.0 |
| **Total** | **1000** | **100** |

Projects are 42.5 percent and interviews are 42.5 percent. This course grades
whether you can explain what you built about as heavily as the artifact itself.

### Letter grades

| Grade | Range | | Grade | Range |
|---|---|---|---|---|
| A | 93-100 | | C+ | 77-79 |
| A- | 90-92 | | C | 73-76 |
| B+ | 87-89 | | C- | 70-72 |
| B | 83-86 | | D | 60-69 |
| B- | 80-82 | | F | below 60 |

## Exercises, 150 points

Ten exercises, 15 points each. You keep one public portfolio repository with one
folder per exercise. The course repository is separate and read-only: you clone
it in week 1 and pull before class, and never edit it.

Due before the class that uses them. Any student may be called on to walk the
class through their work.

**Credit requires all three:**

1. **A working system**, verified live rather than by screenshot.
2. **A specification and implementation plan**, scaled to the exercise, written
   before the work. This is the same PRD-driven workflow as ISBA 4796.
3. **An evidence README** recording what broke, how you fixed it, and your answer
   to that exercise's "The change" prompt.

Three exercises are troubleshooting exercises. You get a broken system and a
hypothesis log is required *before* the fix: what you think is wrong, how you
will test it, what you expect.

**Exercise 01 carries one extra piece: the self-discovery interview.** You run it
with Claude, it takes about twenty minutes, and it writes a file at the end. The
instrument is in the course repository as `self-discovery-interview.md`.

Nothing in it is graded. Exercise 01 gives credit for having done it, not for what
is in it, and there is no bar to clear. The variance in this course is enormous:
two people with the same prerequisite arrive having deployed nothing and having
run a side project on AWS for a year. Both are normal. This is how I find out
where you are actually starting from, so that pairing, support, and the interview
study guides are built around the room rather than around an average.

**It is submitted on Brightspace, and it is the only thing in this course that
is.** Everything else goes in your public portfolio repository. This one does not,
because that repository is public and this file is about you rather than about a
system.

### Schedule

| # | Exercise | Type | Due |
|---|---|---|---|
| 01 | Accounts and development environment, and the self-discovery interview | Config | Thu 9/3 |
| 02 | The AI-assisted workflow: PRD, plan, ship | Build | Thu 9/10 |
| 03 | Personal site deployed on Railway, GA4 installed | Build | Tue 9/15 |
| 04 | Domain delegated to Route 53, live with TLS | Config | Thu 9/24 |
| 05 | **Broken DNS/TLS: diagnose and fix** | Troubleshoot | Thu 10/1 |
| 06 | Mailbox email with SPF, DKIM, DMARC; Resend verified | Config | Thu 10/8 |
| 07 | First orchestration: trigger, API call, notification | Build | Thu 10/15 |
| 08 | **Broken integration: expired credential, changed schema** | Troubleshoot | Tue 10/20 |
| 09 | Raw agent loop in Python, three tools, evals, trace read | Build | Thu 11/5 |
| 10 | **Broken agent: bad tool schema, runaway loop, cost blowup** | Troubleshoot | Thu 11/12 |

### "The change"

Every exercise README ends with one constraint that shifts, answered in two or
three sentences: what breaks, what you would do about it, what it costs.

By the midterm you will have answered eight of these in writing. The interview
asks for one more out loud, about your own system, with someone watching. That is
the only difference.

## Project 1: Own Your Corner of the Internet, 125 points

Weeks 1 to 8. **Due Thu 10/22.**

The exercises build the pieces. Project 1 is the integrated, documented,
portfolio-grade assembly of them.

| Deliverable | |
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

**Grading is against a portfolio bar.** The question is not whether you completed
the steps but whether you would show this repository to an employer. Every
deliverable is publicly verifiable, so the rubric checks live systems.

**The handoff.** Your Job Scout must surface at least five real postings you would
actually want. You pick one, and it becomes Project 2's brief. If your scout
underperforms, there is a vetted feed of postings so you are not blocked.

## Midterm whiteboard interview, 125 points

Twenty minutes, in person, one-on-one, scheduled through Calendly. Slots run
**Tue 10/27 through Thu 10/29**. A study guide is published in advance.

**Fifteen minutes on your own system.** You diagram it from memory, with no notes
and no repository open. Then it is interrogated: why this service, what did you
reject, what does it cost, how do you know it works, what breaks first under
load, what would you do differently.

**Five minutes of curveball.** One constraint changes, drawn from a deck whose
categories you have seen but whose specifics you have not. Traffic increases
tenfold. The budget is cut by eighty percent. A vendor sunsets. You redesign live.

Most students have never done a whiteboard interview. Failing one in October,
when there is a 300-point version coming, is the most useful feedback this course
offers. It lands before the November 13 withdrawal deadline for that reason.

## Project 2: the JD-driven build, 300 points

Weeks 10 to 15. You pick one posting your Job Scout surfaced, read the system
that job implies, and build it. Fixed architecture, problem domain chosen by the
job description.

| Deliverable | |
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

Same skeleton, different problem. A logistics posting yields a shipment-status
copilot. A marketing posting yields a campaign analyzer. A healthcare-operations
posting yields an intake triage assistant.

**The orchestration requirement is a capability, not a tool.** n8n, Make, Zapier,
Power Automate, and code all count.

**Deterministic and agentic.** Your system must include both, and you must defend
where the line falls. Knowing which parts of a system should be a fixed workflow
and which should be agentic is a design judgment, and it is the obvious
curveball: your API costs tripled, what moves out of the agent?

### Milestones

Gates inside the Project 2 grade, not separate line items.

| | Bar | Due |
|---|---|---|
| M1 | Posting selected, PRD written, architecture diagram approved | Tue 11/10 |
| M2 | App scaffolded and deployed to production on your subdomain | Tue 11/17 |
| M3 | Agent responding with tools, grounded in domain data via S3 and IAM | Tue 11/24 |
| M4 | Orchestration integrated, staging environment live and promoting to production | Thu 12/3 |
| Final | Full system, operations hardened, evals, decision record, blog post | Tue 12/8 |

M4 fails without a working staging environment. The application runs fine without
one, which makes it the first thing skipped under deadline pressure.

**Demo Day Thu 12/10.** Public demos, guest judges, and a live look at the
analytics.

## Final whiteboard interview, 300 points

**Thursday, December 17, 11:00 AM**, in the scheduled exam slot. Thirty minutes.

Same format as the midterm: twenty-five minutes on your own system from memory,
five minutes of curveball. The system you defend is the one you built for a job
you chose, so this is a simulated interview for that job.

## Semester at a glance

| Weeks | | |
|---|---|---|
| 1-8 | Networking foundations, then the cloud arc | Exercises 01-08, Project 1 due Thu 10/22 |
| 9 | Midterm whiteboard interviews | Tue 10/27 to Thu 10/29 |
| 10-15 | Project 2, the JD-driven build | Exercises 09-10, milestones M1-M4 |
| 15 | Demo Day | Thu 12/10 |
| Finals | Final whiteboard interview | Thu 12/17, 11:00 AM |

One class meeting is cancelled all semester: Thursday, November 26, during
Thanksgiving break. Labor Day and Autumn Day fall on days this course doesn't
meet.

### Key dates

| | |
|---|---|
| Add/drop without a W | Fri Sep 4 |
| Project 1 due | Thu 10/22 |
| Midterm interviews | Tue 10/27 to Thu 10/29 |
| Last day to withdraw | Fri Nov 13 |
| Demo Day | Thu 12/10 |
| Instruction ends | Fri Dec 11 |
| Final interview | Thu Dec 17, 11:00 AM |

## Work load expectations

LMU follows the Carnegie Unit standard: one semester credit hour represents at
least three hours of student engagement per week. See
https://academics.lmu.edu/aprc/lmucredithourpolicy/

For this four-credit course that is an average of **12 hours per week** across the
semester, including class meetings, exercises, project work, and preparation.

Expect this to be uneven. Weeks with a troubleshooting exercise and weeks around
a Project 2 milestone run heavier than the middle of a build.

## Required materials

There is no textbook.

This course uses real infrastructure, which costs real money. You will buy a
domain and use cloud services, most of which have free tiers sufficient for this
course. A cost guide is published in week 1 with expected spend and how to stay
inside free tiers. Bring cost questions early rather than discovering a bill.

## Required lab fees

None.

## Instructional methods

In-person meetings twice a week combining instruction, live work, and student
walkthroughs of their own exercises. Hands-on configuration and build work
throughout. Two one-on-one whiteboard interviews. A public Demo Day.

## Assignments and feedback

Exercises are submitted in your public portfolio repository and are due before
the class that uses them. Projects are submitted the same way, as live systems
plus their repositories. The one exception is the self-discovery interview in
Exercise 01, which goes to Brightspace.

Due dates are announced in Brightspace and stated in this syllabus.

Feedback on exercises is given in class and in the repository. Interview feedback
is given verbally at the end of the interview and in writing within one week.

Assignments are submitted through your portfolio repository by the posted
deadline. Deadlines are hard.

Late work loses 10% per day, down to a floor of 50%. A late assignment is worth
less, but it's never worth nothing, so finish it and turn it in.

If you know you're going to miss a deadline, send me a Teams message before it
passes. I may move it. That's case by case, and there's no bank of late days to
spend. If I move a deadline, the new date is the deadline, and the 10% per day
runs from there.

No message before the deadline means no conversation after it. The 10% per day
runs from the original date.

Some assignments are delivered in person at a fixed time. Everything above
applies to them, and the meeting time is the deadline. If this syllabus says an
event can't be rescheduled, missing it scores zero.

Emergencies sit outside this one too. Tell me when you're able and we'll make a
plan.

## Attendance and participation

Your scheduled commitments are class sessions, your midterm interview slot, Demo
Day, and the final interview.

If you feel ill, stay home. Rest, and keep everyone else healthy.

When you can't make a scheduled commitment, send me a Teams message. Before the
commitment is best, and as soon as you can if something happens that morning.
Late still beats silent.

Your first three absences cost you nothing if you told me. You don't owe me a
reason and I won't ask for documentation. What matters is that I know.

An absence you never tell me about costs 2% of your total grade from the first
one, and it still uses up one of the three. From the fourth absence on, each
absence costs 2% whether you told me or not.

That 2% comes off your final course grade after everything else is totaled.
Attendance is not a line in the grading table.

If you reach four absences I'll reach out. At six we'll sit down and talk
honestly about whether finishing the term is realistic, and whether withdrawing
is the better call. I would rather have that conversation in October than write
it into your grade in December.

Some of your scheduled commitments are also graded work. Missing one of those
costs you twice. The absence counts here like any other, and what happens to the
grade is in the assignment submission policy, because those points are for the
work rather than for showing up.

Emergencies sit outside all of this. Serious illness, hospitalization, a death in
the family: the three-absence count doesn't apply. Tell me when you're able and
we'll work out a plan for the rest of the term.

The midterm interview, Demo Day, and the final interview are not reschedulable
except in genuine emergencies. Missing one scores zero on it. These are the
three points in the semester where the whole course is being assessed at once,
and there is no second sitting to move you to. If something genuine happens,
tell me and we will work it out.

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

Use AI. Use it for everything it is good at: planning, writing code, debugging,
reading unfamiliar documentation, explaining errors, and drafting your specs.

There is no restriction on how much you use it and no requirement to log prompts.

What matters is what remains yours:

**You defend the system.** Twice, from memory, with no notes and no repository
open, for 42.5 percent of your grade. An AI can build a system you cannot
explain. This course finds that out.

**You validate your own work.** Live systems, evals, traces, and an honest
account of what you have not verified.

**You own the decisions.** Which service, which alternative you rejected, where
the deterministic/agentic line falls, and why. If AI recommended something and
you took it, you should be able to say why it was right.

**You own what you ship,** including its limits and what you would do next.

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

AI use is expected and encouraged here. Honesty means something specific: the
system you submit must be a system you can explain, justify, validate, and adapt.
Submitting something you cannot account for is a violation regardless of what
produced it, and the whiteboard interviews will find it.

Two things specific to this course are serious violations:

**Presenting a system as working when it is not.** Every deliverable in this
course is publicly verifiable and checked live rather than by screenshot.

**Presenting someone else's system as your own.** Your portfolio repository is
public and permanent, and it carries your name.

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
