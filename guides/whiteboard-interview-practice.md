# Practice your whiteboard interview

Practice explaining your system aloud, from the browser through the network
and back. Bring your
[README](../projects/own-your-corner-of-the-internet.md#8-keep-a-concise-engineering-record)
and
[submission index](../projects/own-your-corner-of-the-internet.md#organize-your-repository).

## 1. Audit your repository

We do this together against the
[Project 1 requirements](../projects/own-your-corner-of-the-internet.md#what-the-system-must-do).
Open your `career-platform` repository in VS Code and start a new Claude Code
or Codex session. In Claude Code, name it:

```text
/rename project-audit
```

Save any open files, then commit and push, so the audit sees your latest work.
Then paste:

```text
Read the Project 1 requirements at
https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/projects/own-your-corner-of-the-internet.md
For each of the eight requirements, tell me what this repository already has,
with file paths and commits, what is missing, and what you can't verify from
the repository alone. Don't write or change anything.
```

Read the answer against what you know. The agent can't verify a live check
from the repository alone, so tests such as an email delivery stay on your
list until you run them. Then paste:

```text
Save those gaps as a checklist in TASKS.md, one line each, with the file or
check that closes it. Don't change anything else.
```

Commit and push `TASKS.md`. The list is today's deliverable. The agent will
offer to start on it. Say no, close the laptop for the drawing, and work the
list after class. The submission counts only what's in the repository on
GitHub, so commit and push as you close each task.

## 2. Draw the request path

On paper, without notes or a coding agent, draw your answer to:

```text
What happens when you enter a domain in a browser and press Enter?
Show how the request travels and how the response reaches the browser.
```

Include network equipment and the services handling each exchange. Mark
uncertain connections with a question mark.

## 3. Build the class diagram

Add a piece when called on. Explain your addition, correct your own sketch,
and say what changes between Azure and Railway.

## 4. Watch the Mermaid demonstration

Mermaid turns text into diagrams you can keep in your repository. It's
optional for your project diagrams.

## 5. Practice with a partner

Use the study guide's
[questions](midterm-study-guide.md#1-draw-the-whole-request-path) and
[scoring table](midterm-study-guide.md#how-the-20-minutes-run-and-how-youre-scored).
Explain aloud, answer follow-ups, and troubleshoot a problem. Give feedback,
retry an unclear answer, and swap roles.

## After class

Work your `TASKS.md` list, then follow the project requirements'
[submission instructions](../projects/own-your-corner-of-the-internet.md#submit).

Before the interview, practice with a classmate, friend, family member, or
roommate. Use the study guide's
[Claude Code or Codex prompts](midterm-study-guide.md#use-claude-code-or-codex-to-study)
to check your understanding after answering aloud.
