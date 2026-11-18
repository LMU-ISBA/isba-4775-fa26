# Redo the workflow

Session 23 · Thursday, November 19, 2026 · first 20 minutes

On Tuesday, `workflow.py` sent all your records to one model call, so the
model did the math. That skipped the steps you designed. In a workflow, code
does every step it can, and the model does only what code can't. Today you
rebuild `workflow.py` from your own steps.

## 1. Write your steps

With your laptop closed, write your workflow's steps for Tuesday's question
on paper. Number them and label each one code or model call. Use the same
question and hand-worked answer as Tuesday.

## 2. Rebuild it

Keep Tuesday's version for comparison:

```text
Rename workflow.py to workflow-v1.py and keep its runs in runs/. Then
stop.
```

Then follow [section 3 of Tuesday's guide](workflow-and-agent.md#3-build-the-workflow),
starting at "Your agent writes the skeleton." You write the code steps
yourself.

## 3. Compare

Ask:

```text
Add the --model option to workflow.py, the same way agent.py has it.
Run workflow.py with my question on both of my models. Save the
outputs in runs/. Add both runs to my workflow-vs-agent wiki page as
workflow v2 rows. Don't remove the existing rows. Then stop.
```

Answer these yourself:

- Did v2 match the answer you worked out by hand? Did v1?
- How many input tokens did v2 use compared with v1, and why?
- Which step would you still give the model, and why?

Then ask:

```text
Commit and push.
```
