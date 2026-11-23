# Project 02

300 points. Due Thursday, December 10, 2026, at 1:45 PM, before class.

A job posting describes work a company needs done, so you can read it as the
specification for a system. Building that system shows you can do the job,
which a resume can only claim.

Your goal is to run that system on AWS by December 10, with an agent you
built doing the job's repeated work, and to explain every part of it in an
interview.

## At a glance

| Question | Answer |
| --- | --- |
| What do I build? | You build the system a real job posting implies. It runs on AWS and includes an agent you built |
| Which posting? | Choose one for a job you could reach soon after graduation |
| What's the next-step posting for? | It shows how that work progresses in about two years. You don't have to want the role, and you won't build for it |
| Who designs the architecture? | You do. Compare at least two designs, choose one, and explain why |
| Where do I come in? | Your agent can generate options all day. The posting makes you responsible for one job, and you decide what matters in it. A default prompt gives the answer everyone gets, so show where yours differs |
| What's graded? | I grade what the system does and how well you can show it. Your choice of design isn't scored |
| Where do I start? | Start with [Find three postings for Project 02](../guides/find-your-project-02-postings.md) |

## What changed on November 23

The first version asked for more parts than our three remaining classes
could teach. I'd rather you own one small system than assemble a large one,
so the project is now a system you can draw, defend, and fix. These are the
changes:

- M4 is gone. M2 now includes the move from staging to production, and M3
  moved to Tuesday, December 8.
- The agent needs a tool, a step limit, and a refusal. Memory is cut, and
  structured output is optional.
- The trigger can be a schedule, such as cron.
- Operations is the access gate, the cost controls, and an outside monitor.
  The rate limit and the analytics event are cut.
- Evals went from 10 cases to five that you write by hand, and from 15
  points to 40.
- The decision record has three parts.
- Your data can live in S3 or RDS.
- Exercise 10 is one real failure from your own project, due December 8.

If you already built a part that was cut, you can keep it.

## Dates

Each milestone is graded when it's due. Its points are the areas of the
project that should be finished by then, and
[How the 300 points are earned](#how-the-300-points-are-earned) lists them.
The late policy in the [syllabus](../syllabus.md) applies to each milestone:
a late one loses 10% per day, down to a floor of 50%.

| Date | Due | Points |
| --- | --- | --- |
| Thu 11/12, 1:45 PM | Your posting, chosen from your three, and one next-step posting. You can switch among the three until 11/17 | |
| Tue 11/17 | M1: your PRD, your data source, and two architectures with cost estimates. If you don't want to start from scratch, you can look for an open source project to extend. That search is optional. Name your choice and your reason, add a diagram, and rename your repository. Submit your repository URL in Brightspace, then keep building. I'll read your design and tell you by Thu 11/19 if something has to change | 60 |
| Tue 11/24 | Your AWS site is working, for the staging and production lesson, on Zoom | |
| Tue 12/1, 1:45 PM | M2: your app is live at your production subdomain behind a password, and one commit moved from staging to production through GitHub Actions. Submit both addresses and both passwords in Brightspace | 75 |
| Thu 12/3 | In class, your data moves to S3 or RDS, and your agent gets access to only what it needs | |
| Tue 12/8 | M3: your agent answers a grounded question with a tool, from your data on AWS. You'll show it live in class. Exercise 10 is due | 75 |
| Thu 12/10, 1:45 PM | Project 02 is submitted, with the areas no milestone covers | 90 |
| Mon 12/14 to Thu 12/17 | Final whiteboard interview, by appointment, worth a separate 300 points | |

## Requirements

Each row says what the system must do and the evidence you keep. The sections
after the table add detail where a row needs it.

| # | Requirement | What it has to do | Evidence |
| --- | --- | --- | --- |
| 1 | Posting and PRD | Choose one posting that passes the four tests, and save one next-step posting. Write a PRD that says who uses the system, what it does, and what it leaves out. Say what this job is responsible for, and one thing you'd look for that a default answer misses | Your wiki pages and the PRD |
| 2 | Runs on AWS | Your app, agent, and data run in your AWS account. The app is one page with a question box and an `/ask` route that runs your agent. It answers over HTTPS at a subdomain of your domain, and your resume site keeps working | The live address, and a short list of your AWS resources with the monthly cost |
| 3 | Agent | You build it or extend an existing one, and it does the job's repeated work. It uses at least one tool, stops at a step limit, and refuses requests outside its job. It takes one request and returns one answer, so memory isn't required, and structured output is optional | The live agent |
| 4 | Data | Use real data first. Store it on AWS, in S3 or RDS, and give the agent access to only what it needs | Your data card, and the IAM policy or the database user's permissions |
| 5 | Schedule | Something other than you starts your workflow. A cron schedule on your instance counts, and so does an event from a second system. The page shows the latest result | A run you didn't start, with its result on the page |
| 6 | Environments | You keep local, staging, and production environments. GitHub Actions deploys your changes, and secrets stay out of the repository | One commit followed from staging to production |
| 7 | Operations | Put an access gate on the app. Set an AWS budget alert and a spend limit with your model provider. Have an outside monitor tell you when the system is down | Each one demonstrated |
| 8 | Evals | Write at least five cases by hand, with expected answers drawn from your data. One of them is a request the agent should refuse. The set runs from a clean clone with one command | Recorded results, including failures, and one trace a reader can follow |
| 9 | Architecture decision | Design two architectures that differ in a way that matters. Choose one and say what you gave up | The comparison and the decision record |
| 10 | Explain it | Write a blog post and draft a LinkedIn post, both for someone who isn't technical | Both submitted |
| 11 | Engineering record | Keep a README and a submission index. Every system will be different, so the index tells me how to check yours | `docs/project-02-submission.md` |

## Choosing a posting

A posting you can build from passes four tests. Here they are with one
example, a Customer Support Specialist posting at a bank.

| Test | The bank example |
| --- | --- |
| The job works with data you can get | Public complaints from the Consumer Financial Protection Bureau's database |
| A question or decision comes up again and again | "Which product and issue is this complaint about?" |
| You can tell whether the answer is right | The labels in each record |
| Two systems should talk to each other | A complaint form and a ticket queue |

Internships and entry-level roles both count, and you don't have to qualify
yet. Choose a job you'd want to interview for.

## Data

Real data comes first.

- Collect it through an MCP, an API, or a scrape of public pages.
- Use APIs and open data before you scrape, and scrape only pages whose terms
  allow it.
- Leave out personal data. An employer's private data doesn't count.
- Save one snapshot with its source and date, and have the app read it. The
  20 records from Exercise 08 were a sample. Your snapshot needs enough
  records for your workflow and your agent to do their work.

Made-up data is the fallback. If you need it, show that it's realistic for
the company in your posting.

1. Collect about 20 real examples from the same industry.
2. Write down the fields, the categories, and the share of each.
3. Generate your records from that description.
4. Compare a sample against the real examples by hand, and fix what's off.

Your data card says where the data came from, when and how you collected it,
and which parts are real and which are made up.

## Your design

The architecture is yours to design, within these rules.

| Choice | Rule |
| --- | --- |
| AWS | The app, the agent, and the data have to run on AWS. DNS can stay at Cloudflare, and the model API and a hosted tool that connects your two systems can live outside it |
| Model API | Find the right one to get the job done, and compare price and capability for your task. Class demos use the Claude API, and any provider counts |
| Fixed steps or agent | Your system has to be both. Decide which parts are fixed steps and which the agent decides, and be ready to defend where that line falls |
| From scratch or an existing project | You can build from scratch or extend an open source project. Looking for one is optional, and it's here so you don't have to start from scratch. If you look, record what you find in your wiki. Check three things for each: its license allows your use, it runs within your budget, and you can show which changes are yours. Extending one can be one of your two designs. Bring its code into your private repository, because a GitHub fork of a public project stays public. If it already has an agent, I grade the agent work you add |
| What starts the workflow | A schedule is enough, and cron on your instance is the simplest one. If your design has a real event from a second system, through n8n, Make, Zapier, Power Automate, or code, that counts too |
| Access gate | Each call to your agent spends your API credits, so only people you allow should reach it. A shared password or an invite code is enough, and user accounts aren't required |

For each of your two designs, give a diagram, a monthly cost estimate, what
it makes easy, and what it makes hard. A server compared with serverless
counts as a real difference. So does an agent that chooses its tools compared
with fixed steps and one model call.

Your decision record has three parts, in your own words: the decision, what
you gave up, and one check I can repeat, as a command or a request. Your
eval command works as the check.

### The class path

Class lessons build one design, shown below. You can follow it, change it, or
design something else on AWS. If you leave it, you'll adapt the lessons to
your own design. It can be one of the two designs you compare.

Follow the numbers to trace one request. Your posting chooses the two parts
with a dashed border.

```mermaid
flowchart TD
    V["Visitor"]
    DNS["Cloudflare DNS"]
    X["A schedule or an event"]
    GH["GitHub Actions"]
    LLM["Model API"]

    subgraph AWS["Your AWS account"]
        subgraph EC2["EC2 instance"]
            N["Nginx"]
            APP["Project 02 app<br/>page and /ask"]
            AG["Your agent"]:::chosen
            WF["Your workflow"]
            R["Resume site"]
        end
        D[("S3 or RDS<br/>your domain data")]:::chosen
    end

    V -->|"1 · visits your subdomain"| DNS
    DNS -->|"2 · finds your instance"| N
    N -->|"3 · routes by hostname"| APP
    N --> R
    APP -->|"4 · asks"| AG
    AG -->|"5 · reads"| D
    AG -->|"6 · calls"| LLM
    WF --> D
    WF -->|"latest result"| APP
    X -.->|"starts"| WF
    GH -.->|"deploys staging, then production"| APP

    classDef chosen stroke:#222,stroke-width:3px,stroke-dasharray:7 4
```

Your deployment policy from the AWS migration covers the instance and RDS.
S3 needs more permissions, and the December 3 class adds them. A different
design needs different permissions, written with least privilege the same
way.

## Blog post and LinkedIn draft

Both help you explain your project to a general audience: what the job
needed, what you built, and how you know it works. They also prepare you for
the final interview, where you'll explain the same system out loud and
without notes.

You have to draft the LinkedIn post, but publishing it is up to you. We'll
work on both in class on December 8.

## How the 300 points are earned

I run the checks in the last column against your live system, so run them
yourself first. A claim the live system contradicts earns no credit for that
claim.

Each area is graded at the milestone in the second column. The areas marked
Final are graded on the submitted project.

| Area | Graded at | Points | What is assessed | Check I run |
| --- | --- | --- | --- | --- |
| Posting, PRD, and data | M1 | 30 | A posting that passes the tests, a PRD, and a data card showing real data or a documented realism check | I read them against your posting |
| Architecture decision | M1 | 30 | Two designs with costs and tradeoffs, your choice and what it gave up, and the diagram | I read them against your PRD |
| System on AWS | M2 | 40 | The app at your production subdomain over HTTPS, behind the access gate | I open the live address without the password, then with it |
| Environments and deployment | M2 | 35 | Three environments, GitHub Actions deploying, secrets handled, and one change shown moving through | I find one commit in your Actions history that deployed to staging and then to production |
| Agent | M3 | 50 | The job's repeated work, done with a tool, a step limit, and a refusal. You can defend the line between fixed steps and agent decisions | I send three of your eval inputs and one out-of-scope request, then compare the answers with your expected answers |
| Grounding | M3 | 25 | Answers drawn from your data in S3 or RDS, reached with access to only what the agent needs | I ask a question only your data answers, and I read the IAM policy or the database user's permissions |
| Evals and trace | Final | 40 | Five cases you wrote, with recorded results, including failures, and one readable trace | I run the eval set from a clean clone with one command |
| Operations | Final | 15 | The access gate, the cost controls, and an outside monitor | I request the agent without access, and your index shows the budget alert, the spend limit, and the monitor |
| Schedule | Final | 10 | Your workflow runs without you starting it, and the page shows its latest result | I read the time of the latest run on the page |
| Decision record and index | Final | 10 | Your three-part decision record, and a submission index that lets me check the system | I repeat the check your decision record names |
| Blog post and LinkedIn draft | Final | 15 | A general reader can follow what you built, why, and how you know it works | I read both as a general reader |
| Total | | 300 | | |

A simple design that meets every requirement earns full credit, and adding
services doesn't add points. The late policy is in the
[syllabus](../syllabus.md).

## Repository and submission

- Your repository starts as `project-02`. It's private because it holds
  copied postings and your notes on jobs you're considering. By M1, rename
  it for the system you're building, such as `complaint-triage`.
- Invite me as a collaborator by M1, so I can read it.
- Keep your research in `research/` as an LLM wiki. Keep passwords, keys, and
  local environment files out of Git.
- In `docs/project-02-submission.md`, give your architecture diagram, your
  AWS resources with the monthly cost, and your staging and production
  addresses. Say how to run each check above. Link the PRD, data card,
  comparison, decision record, eval results, and trace. Your passwords go
  in Brightspace, not here.
- Date your observations. Mark anything unverified instead of filling in the
  result you expected.

Submit through the Project 02 submission in Brightspace:

1. Your repository URL, your live HTTPS address, and your final commit SHA.
2. Your blog post, as a link or a file.
3. Your LinkedIn post draft. It stays out of the repository because it names
   you.
4. Your staging and production passwords, so I can get past the access gate.

Keep the system running through your final interview.

## The final interview

Final interviews run Monday, December 14, through Thursday, December 17, by
appointment. Each one is 25 minutes: 20 minutes on your own system from
memory, including a changed constraint, then a five-minute debrief. Treat
it as an interview for the job you chose.

When you book, you'll give a link to your updated resume. The resume links
to your GitHub portfolio and to your project. The booking link and the
study guide come out by December 10.

Be ready to:

- Draw your architecture and trace a request through it.
- Explain why you chose it over your other design.
- Show where the agent decides and where fixed steps run.
- Explain where your data came from and how you know the answers are right.
- Show one place where the default answer wasn't good enough, and what you
  did instead.
- Diagnose a failure, and discuss your costs.

## Costs

Stay inside the AWS free tier and your credits where you can. Estimate the
monthly cost of each design before you choose, and ask me before you pick a
service that will cost money.
