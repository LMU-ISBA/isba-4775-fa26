# Exercise 02: The AI-assisted workflow

**Due** Tue 9/15, before class · **15 points** · **Type:** Build ·
**Submit** as `ex02/` in your public portfolio repository

## Why this one matters

Every exercise after this one asks for a plan written before the work. This is
the exercise where you learn to write one, so it is worth more of your attention
than the thing you end up building.

You are going to build a sales dashboard from a product requirements document
somebody else wrote. The dashboard is the least interesting artifact of the
semester. What you are actually practicing is the loop: read requirements, argue
with them until you understand the shape of the thing, write down what you are
going to build, then build it in pieces you can name. That loop is what makes
an AI coding agent useful instead of fast and wrong.

ISBA 4796 teaches the same workflow, on purpose. The program should teach one
method, not three.

## Before you start

Exercise 01 has to be done, and Claude Pro has to be active.

Set up your portfolio repository before anything else. One public repository
named `isba-4775-portfolio`, one folder per exercise, `ex02` through `ex10`,
following [portfolio-repository.md](../guides/portfolio-repository.md). This
exercise is the first thing that goes in it, and its drop box on Brightspace
is where you post the repository URL.

Part 1 of the tutorial is the first step of this exercise, and it's the setup:
Git, Python, Claude Code, Cursor, the Superpowers plugin, and a fork of the
tutorial repository. Budget 70 to 100 minutes and do it first, on the weekend,
because Part 2 can't start until it's done. If a step fails, post in the
course Teams channel on Saturday rather than Monday.

Part 2 runs on three Superpowers skills, `brainstorming`, `writing-plans`, and
`executing-plans`, and none of the guide works without them, so check Part 1's
final checklist before moving on.

Part 1 also sets up Granola and Wispr Flow. They're capstone tools, and you
don't need them for this course, so skipping them costs you nothing here. If
you do set them up, both have student offers: apply to
[Granola](https://www.granola.ai/students) and sign in to
[Wispr Flow](https://wisprflow.ai/students) with your lion.lmu.edu address.

The tutorial's Section 7 asks where your finished work goes and leaves the
answer to your course. Here that is your portfolio repository, under `ex02/`,
by the due date at the top of this brief. Nothing in this exercise is submitted
through Brightspace. Exercise 01 was the only one that is.

## The work

Finish [Part 1: Setup](https://github.com/LMU-ISBA/ai-dev-workflow-tutorial/blob/main/pre-work-setup.md)
first, then work through [Part 2: Build and Deploy](https://github.com/LMU-ISBA/ai-dev-workflow-tutorial/blob/main/workshop-build-deploy.md).
Budget about three hours for Part 2 and do not do it in one sitting the night
before.

The guide walks you through the whole loop:

| Stage | What comes out of it |
|---|---|
| Read the PRD, build the board | `TASKS.md` with 4 to 8 milestones, each with acceptance criteria |
| `brainstorming` | A design document in `docs/superpowers/specs/` |
| `writing-plans` | An implementation plan in `docs/superpowers/plans/` |
| `executing-plans` | Code, on a feature branch, one milestone per commit |
| Merge and deploy | A live dashboard on Streamlit Cloud |

Two things in there are easy to skip and are most of the point. Write the design
document and the plan **before** any code exists, and put the milestone ID in
every commit message. The first is the habit. The second is what makes your git
history readable later, including by you in the whiteboard interview.

## How this maps to the three credit requirements

Every exercise this semester needs the same three things. Here is where each one
lives for this exercise, because they are spread across two repositories.

**A working system, verified live.** Your deployed dashboard, at its public
Streamlit URL. Not a screenshot of it running on your laptop.

**A specification and implementation plan, written before the work.** The design
document and implementation plan the Superpowers skills produced, in your fork.
Your git history is the proof they came first, which is why the commit order
matters.

**An evidence README.** `ex02/README.md` in your portfolio repository, described
below.

## What to commit

One file, `ex02/README.md`, in your portfolio repository. It is short and it is
an index as much as a writeup.

Link to all four of these:

- Your fork of the tutorial repository
- Your live dashboard URL
- Your design document
- Your implementation plan

Use permanent links for the last two, not links to a branch. On GitHub, open the
file and press `y`, and the URL rewrites itself to point at a specific commit. A
link to `main` shows whatever `main` says next March. A permalink shows what you
actually submitted. Getting this right once, here, saves you an argument later.

Then write the evidence part. What broke, and how you worked it out. Something
will break. Streamlit Cloud deployments fail on dependency versions, plans meet
reality and turn out to be wrong in the third milestone, and Claude Code
confidently builds something adjacent to what you asked for. Any of those is
worth writing down.

One more paragraph, and it is the one I will actually read closely: **where did
the plan turn out to be wrong, and what did you do about it?** A plan that
survived contact with the work unchanged usually means the plan was vague. Being
specific about where yours broke is worth more than a clean story.

End with "The change," below.

## The change

Answer in two or three sentences: what breaks, what you would do about it, what
it costs.

> ShopSmart replaces `sales-data.csv` every night with a fresh export from their
> order system. Management expects to open the dashboard at 8 AM and see
> yesterday's numbers.

## Done means

- [ ] Tutorial Part 1 complete, with every tool on its final checklist running
- [ ] `TASKS.md` on `main` in your fork, every milestone in Done, criteria
      checked, commit hash recorded on each
- [ ] Design document and implementation plan committed **before** the code that
      implements them
- [ ] Commits carry milestone IDs
- [ ] `CLAUDE.md` generated with `/init` and committed
- [ ] Feature branch merged to `main`
- [ ] Dashboard live and publicly reachable on Streamlit Cloud
- [ ] `ex02/README.md` in your portfolio repository with four permalinks, what
      broke, where the plan was wrong, and "The change" answered
- [ ] Pushed before class Tue 9/15

## If you get stuck

Read the error before you paste it anywhere. Most of them name the problem, and
the habit of reading first is the one this course is trying to build.

A Streamlit Cloud deploy that works locally and fails in the cloud is almost
always `requirements.txt`. The cloud installs only what that file lists.

If Claude Code builds the wrong thing, the usual cause is upstream. Go back to
the plan and check whether the plan actually said what you meant. Fixing the
plan and re-running beats arguing with the agent about the code.

Still stuck, post in the course Teams channel with what you were doing, the
exact error, and what you already tried. Three hours of work does not fit into
Wednesday night, and I would much rather answer you on Monday.
