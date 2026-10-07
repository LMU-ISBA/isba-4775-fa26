# Improve your site's design before Railway

Complete this required 30–45 minute activity in `career-platform` before Thursday, October 8, 2026, at 1:45 PM Pacific, alongside Exercise 04. It has no separate grade item or points. Ex04's HTTPS requirements stay the same.

## Before you start

You need Claude Code. If it isn't installed yet, open a terminal and run the command for your system.

macOS, Linux, or WSL:

```text
curl -fsSL https://claude.ai/install.sh | bash
```

Windows PowerShell:

```text
irm https://claude.ai/install.ps1 | iex
```

Open a new terminal and run `claude --version`. If it prints a version number, you're set. For other install options and fixes, see the setup guide: https://code.claude.com/docs/en/setup

## Steps

1. Install Impeccable. Start Claude Code in your `career-platform` folder. In the Claude Code chat, add the marketplace:

   ```text
   /plugin marketplace add pbakaus/impeccable
   ```

   Then open `/plugin`, choose Discover, and install Impeccable. Type `/impeccable` to check that it appears. If it doesn't, type `/exit`, then run `claude --continue` to resume the session. Impeccable's setup guide is at https://impeccable.style/tutorials/getting-started/

2. Get a critique. Run these in order, or skip the first one and go straight to the critique:

   ```text
   /impeccable init
   /impeccable critique my website
   ```

   `init` asks about your site and writes `PRODUCT.md` so the critique has context. Correct anything it gets wrong. It's tool context, not a README replacement. The critique only reports findings and doesn't change the site. Choose **two or three** findings yourself. More on critique: https://impeccable.style/docs/critique/

   If setup is blocked after ten minutes, record the error and ask Claude Code, "Critique my website." No new API account or image generation is required.

3. Make and review the changes. Tell the agent which findings you chose: "Make these changes." Review the diff. Preserve real content, backend, database, routes, environment, Azure service setup, DNS, and HTTPS. Check the local result at desktop and phone widths, try links with the keyboard, and confirm current data. Record anything you couldn't verify.

4. Commit, push, and deploy. In `docs/evidence/design-refresh.md`, record the findings you chose, what changed, your checks, and any blockers. When local checks pass, commit and push to `main`. Then ask the agent:

   ```text
   Deploy the latest main to my VM.
   ```

   Confirm the live site shows the new design over HTTPS with current data, and that the VM is on the commit you pushed. Stop at 45 minutes. If time runs out, keep the VM working and bring your notes to class.

Use this verified commit, or the earlier working one, for the Railway migration. Azure work alone doesn't satisfy Project 1's later Railway auto-deploy requirement.
