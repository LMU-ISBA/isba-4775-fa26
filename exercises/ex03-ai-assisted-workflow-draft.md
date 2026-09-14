# Exercise 03: The AI-assisted workflow

**Due** To be announced · **15 points** · **Type:** Build ·
**Submit** as `ex03/` in your public portfolio repository

**Draft: scope and deadline pending.** This preserves the sales-dashboard
tutorial while the instructor decides whether Ex03 will instead combine the
workflow with the Project 1 personal-site build. Wait for the finalized brief
before beginning the tutorial.

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

Finish Exercise 01 first. Use the Claude Pro or ChatGPT subscription you chose
there. You only need one coding agent for this exercise.

The tutorial is written for Claude Code, and Codex is an accepted alternative.
If you're using Codex, keep its companion open beside both tutorial parts:

https://github.com/LMU-ISBA/ai-dev-workflow-tutorial/blob/main/codex-companion.md

Follow the companion's replacements for installation, sign-in, plugin setup,
and commands. The requirements, dashboard, and submission are the same for
both paths. Your project-memory file will be `CLAUDE.md` for Claude Code or
`AGENTS.md` for Codex.

## The work

Complete both tutorial parts. Setup alone doesn't complete this exercise.
Budget about four to four and a half hours altogether, with extra time if you
need help troubleshooting.

### Part 1: Set up and verify your tools

https://github.com/LMU-ISBA/ai-dev-workflow-tutorial/blob/main/pre-work-setup.md

Part 1 sets up VS Code, Git, Python 3.11 or newer, your coding agent, and
Superpowers. It also walks you through forking and cloning the tutorial
repository, where you'll build the dashboard.

The guide estimates 55 to 80 minutes. Complete this part early in the weekend,
and use its final checklist to verify your setup. Codex users should apply the
companion's checklist replacements. Check that the `brainstorming`,
`writing-plans`, and `executing-plans` skills are available before starting
Part 2. If a step fails, post in the course Teams channel early rather
than waiting until the deadline.

Granola and Wispr Flow are optional tools in the tutorial's capstone appendix.
You don't need either for this exercise.

Once Git is working, create and clone your public `isba-4775-portfolio`
repository using the [portfolio guide](../guides/portfolio-repository.md).
This is separate from your tutorial fork. The fork holds
the dashboard code, and the portfolio holds your `ex03/README.md` evidence.
Post your portfolio repository URL in the Exercise 03 drop box on Brightspace
so I can find your work.

### Part 2: Plan, build, review, and deploy

https://github.com/LMU-ISBA/ai-dev-workflow-tutorial/blob/main/workshop-build-deploy.md

Budget about three hours for Part 2, and split the work across sessions if
needed. Your commits let you save progress and return to it later.

The guide walks you through the whole loop:

| Stage | What comes out of it |
|---|---|
| Read the PRD, build the board | `TASKS.md` with 4 to 8 milestones, acceptance criteria, and a shared Definition of Done |
| `brainstorming` | A design document in `docs/superpowers/specs/` |
| `writing-plans` | An implementation plan in `docs/superpowers/plans/` |
| `executing-plans` | Tested code on a feature branch, with milestone IDs in implementation commits |
| Capture project memory | `CLAUDE.md` or `AGENTS.md`, including a Lessons section |
| Review, merge, and deploy | Reviewed code on `main` and a live dashboard on Streamlit Cloud |

Commit the design document and the plan **before** implementing the dashboard.
Put the milestone ID in every implementation commit message. These records
connect your requirements to the changes you made, so you can explain that
connection in the whiteboard interview.

## How this maps to the three credit requirements

For this build exercise, the three required artifacts are a working system,
a specification and implementation plan, and an evidence README. Here is where each one
lives for this exercise, because they are spread across two repositories.

Your working system is the deployed dashboard at its public Streamlit URL.
Open that URL and check the dashboard against your acceptance criteria. A
screenshot of it running on your laptop doesn't show that the deployment works.

Your specification and implementation plan are the Superpowers documents in
your tutorial fork. Commit them before the code that implements them, so your
git history shows the order of the work.

Your evidence README is `ex03/README.md` in your portfolio repository, described
below. The tutorial's Section 7 leaves submission details to each course.
For this course, the files stay in your repositories. Brightspace receives
only the portfolio repository URL, not duplicate files.

## What to commit

One file, `ex03/README.md`, in your portfolio repository. It is short and it is
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

Then explain what broke, how you investigated it, and what confirmed the fix.
That might be a dependency problem, an incorrect calculation, or a requirement
the coding agent missed. If nothing failed, describe the checks you ran and
their results instead of inventing a problem.

Add a paragraph about where the plan needed revision and what you changed.
If it didn't need revision, explain which checks gave you confidence that it
still matched the requirements.

End with "The change," below.

## The change

Answer in two or three sentences: what breaks, what you would do about it, and
what it costs. This is a written response, not an extra feature to implement.

> ShopSmart replaces `sales-data.csv` every night with a fresh export from their
> order system. Management expects to open the dashboard at 8 AM and see
> yesterday's numbers.

## Done means

- [ ] Tutorial Part 1 complete, with the final checks passing for your chosen agent
- [ ] Portfolio repository URL posted in the Exercise 03 drop box on Brightspace
- [ ] `TASKS.md` on `main` in your fork, every milestone in Done, criteria
      checked, commit hash recorded on each, and the live URL recorded
- [ ] Design document and implementation plan committed **before** the code that
      implements them
- [ ] Implementation commits carry milestone IDs
- [ ] `CLAUDE.md` or `AGENTS.md` generated with `/init`, including a Lessons
      section, and committed
- [ ] Branch reviewed before merging, with any chosen fixes committed
- [ ] Feature branch merged to `main` with a merge commit, as the tutorial explains
- [ ] Dashboard checked locally and at its public Streamlit Cloud URL
- [ ] Live URL also recorded near the top of the tutorial fork's `README.md`
- [ ] `ex03/README.md` in your portfolio repository with four links, including
      permalinks for the design and plan, your evidence, your plan reflection,
      and "The change" answered
- [ ] Pushed by the announced Ex03 deadline

## If you get stuck

Read the error before you paste it anywhere. Most of them name the problem, and
the habit of reading first is the one this course is trying to build.

If the dashboard runs locally but deployment fails, read the deployment logs.
Check the tutorial's dependency-file guidance against the error before changing
packages or files.

If the coding agent builds the wrong thing, compare the result with the
requirement and acceptance criteria. Clarify the plan if it's ambiguous, or
correct the implementation if it doesn't follow the plan. Then rerun the check
that exposed the problem.

Still stuck, post in the course Teams channel with what you were doing, the
exact error, and what you already tried. Start early enough that you can get
help before the Tuesday deadline.
