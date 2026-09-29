# Exercise 03: Build it, then move it

**Due** Thu 10/1, 1:45 PM, before class · **15 points** · **Type:** Build ·
**Submit** your public `career-platform` repository URL in Brightspace

## Why this one matters

Over three weeks you built your resume site with a coding agent and moved it
from a Codespace to a server you rent. Each step started from a document you
could check: a spec for what to build, a plan for how, and a migration plan for
how to move it. This exercise asks you to show those documents and what
happened when you followed them.

The documents matter more than the site. Anyone can get an agent to produce a
website. What an employer can't see from the site is whether you knew what you
were building, checked the agent's work, and could tell when the migration
actually worked. Your repository shows that.

## The work

Most of it is done if you followed the classes on 9/15, 9/17, 9/22, 9/24, and
9/29. What's left is committing the migration plan and writing a short
evidence file.

If you didn't finish the migration, you can still get credit. Commit the
migration plan with results up to where it stopped, and explain the blocker in
your evidence file.

### 1. Check that your documents are on GitHub

Open your `career-platform` repository on github.com, not on your laptop, and
find these three files:

| Document | Where | Written in class |
| --- | --- | --- |
| Spec | `docs/superpowers/specs/` | Tue 9/15 |
| Implementation plan | `docs/superpowers/plans/`, dated 2026-09-15 | Tue 9/15 |
| Migration plan | `docs/superpowers/plans/2026-09-24-azure-vm-migration.md` | Thu 9/24, run Tue 9/29 |

The spec and implementation plan should appear in your commit history before
the app code they describe. The migration plan should have its steps ticked,
the Verify results table at the end, and no laptop IP address or Azure
subscription ID. Section 6 of the [migration guide](../guides/azure-vm-migration.md)
has the prompt that removes them and pushes the plan.

If any of the three is missing from GitHub, it's probably committed on your
laptop but not pushed, or not committed at all. Ask your agent:

```text
Which files in docs/superpowers aren't on GitHub yet? Commit and push them,
and show me the result.
```

Your repository has to be public, so I can read it without an invitation.

### 2. Write your evidence file

Create `docs/evidence/ex03.md`. Your agent can help draft it, but the
explanations should be in your own words, since you'll defend this system in
the midterm interview. It has four parts.

1. Your VM's name, resource group, region, size, and public IP address. The
   VM's IP is fine to publish, since it belongs to a public server. Your
   laptop's IP isn't, so leave it out.
2. One screenshot of your own site at `http://PUBLIC-IP:8000`, taken during
   the two-lock step in section 6 of the guide, while the `Temp-HTTP-8000`
   rule was open. Save it as `docs/evidence/ex03-site.png` and show it in the
   file. If you've already closed the port, open it again the same way, take
   the screenshot, and close it.
3. What went wrong during the build or the migration, how you investigated
   it, and what confirmed the fix. That might be a region your subscription
   couldn't use, a database file the app couldn't find, or a step the agent
   changed without asking. If nothing broke, describe the checks you ran and
   what they showed.
4. Your answer to "The change," below.

Exercises normally require a live check instead of a screenshot. This one is
an exception, because your site isn't meant to stay public yet. On Thursday
it goes live on port 80, and Exercise 04 checks it there.

Then commit and push both files.

## The change

Answer in two or three sentences: what breaks, what you would do about it,
and what it costs.

> You're at a coffee shop and try to SSH into your VM to fix a typo. The
> command hangs.

## Done means

- [ ] `career-platform` is public on GitHub
- [ ] Spec and implementation plan on GitHub, committed before the code they
      describe
- [ ] Migration plan on GitHub with its results and Verify table, and without
      your laptop IP or subscription ID
- [ ] `docs/evidence/ex03.md` with VM details, the screenshot, what broke, and
      "The change" answered
- [ ] `docs/evidence/ex03-site.png` showing your own site at your VM's public IP
- [ ] Repository URL submitted in the Exercise 03 drop box on Brightspace by
      Thu 10/1, 1:45 PM
