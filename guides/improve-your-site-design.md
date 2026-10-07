# Improve your site's design before Railway

Complete this required 30–45 minute activity in `career-platform` before Thursday, October 8, 2026, at 1:45 PM Pacific, alongside Exercise 04. It has no separate grade item or points. Ex04's HTTPS requirements stay the same.

## Before you start

Start a new Claude Code session in your `career-platform` folder.

## Steps

1. Install Impeccable. In the Claude Code chat, add the marketplace:

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

4. Commit, push, and deploy. Ask the agent:

   ```text
   Commit and push to main, then deploy to my VM.
   ```

   Confirm the live site shows the new design over HTTPS with current data, and that the VM is on the commit you pushed. Stop at 45 minutes. If time runs out, keep the VM working and bring your notes to class.

Use this verified commit, or the earlier working one, for the Railway migration. Azure work alone doesn't satisfy Project 1's later Railway auto-deploy requirement.
