# Practice your whiteboard interview

Practice explaining your system aloud, from the browser through the network and back.
Bring your [README](../projects/own-your-corner-of-the-internet.md#8-keep-a-concise-engineering-record) and [submission index](../projects/own-your-corner-of-the-internet.md#organize-your-repository).

1. Audit your repository against the [Project 1 requirements](../projects/own-your-corner-of-the-internet.md#what-the-system-must-do) with the class. Open your `career-platform` repository in VS Code, start a new Claude Code or Codex session, and run the audit below. Read its answer against what you know. Note anything you still need to test or document, such as an email delivery result. The agent can't verify a live check from the repository alone, so those stay on your list until you run them.
2. Draw your own answer to the question below on paper, without notes or a coding agent. Include network equipment and the services handling each exchange. Mark uncertain connections.
3. Help build the class diagram when called on. Explain your addition, correct your sketch, and compare Azure with Railway.
4. Watch the short Mermaid demonstration. Mermaid turns text into diagrams you can keep in your repository. It's optional for your project diagrams.
5. Practice with a partner using the study guide's [questions](midterm-study-guide.md#1-draw-the-whole-request-path) and [scoring table](midterm-study-guide.md#how-the-20-minutes-run-and-how-youre-scored). Explain aloud, answer follow-ups, and troubleshoot a problem. Give feedback, retry an unclear answer, and swap roles.

## Audit your repository

In Claude Code, name the session:

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

As you fill each gap, save the file, then commit and push it. The audit, and
the submission, count only what's in the repository on GitHub.

## Draw the request path

```text
What happens when you enter a domain in a browser and press Enter?
Show how the request travels and how the response reaches the browser.
```

Follow the project requirements' [submission instructions](../projects/own-your-corner-of-the-internet.md#submit) when you're ready to submit.

Before the interview, practice with a classmate, friend, family member, or roommate.
Use the study guide's [Claude Code or Codex prompts](midterm-study-guide.md#use-claude-code-or-codex-to-study) to check your understanding after answering aloud.
