# Improve your site's design before Railway

Complete this required 30–45 minute activity in `career-platform` before Thursday, October 8, 2026, at 1:45 PM Pacific, alongside Exercise 04. It has no separate grade item or points. Ex04's HTTPS requirements stay the same.

1. Save a baseline. Check Azure HTTPS and current data. Record its deployed commit (`git rev-parse HEAD`). On your laptop, save unfinished work and branch from a working commit. Take a local before screenshot. Use the same data and viewport afterward. Note any difference from Azure.

2. Get a critique. In the project folder, check for Node.js 22.18 or later, then run `npx impeccable install`. Choose your coding tool (Claude Code or Copilot) and project scope, then reload the tool. Run `/impeccable init` and correct its `PRODUCT.md` if needed. This is tool context, not a README replacement. Then ask `/impeccable critique my website`. Follow different syntax if your tool shows it. Provide the local page or screenshot if needed. Choose **two or three** findings yourself. The critique does not change the site. See [setup](https://impeccable.style/tutorials/getting-started/) and [critique](https://impeccable.style/docs/critique/).

   If setup is blocked after ten minutes, record the error and ask your coding agent, “Critique my website.” No new API account or image generation is required.

3. Make and review the changes. Tell the agent which findings you chose: “Make these changes.” Review the diff. Preserve real content, backend, database, routes, environment, Azure service setup, DNS, and HTTPS. Check the local result at desktop and phone widths. Try links with the keyboard and confirm current data. Check empty-data and graceful-error behavior with safe tests or prior evidence. Never disrupt production to create a failure. Record anything unverified.

4. Save evidence and stop at 45 minutes. Take the after screenshot. In `docs/evidence/design-refresh.md`, record the baseline and changed commits, findings, screenshots, checks, and blockers. Commit and push the reviewed branch when safe. If time runs out, keep Azure working and bring the branch and notes to class.

Publish to Azure only after local checks pass. Review and merge into the VM's deployment branch using the [Azure workflow](azure-vm-migration.md#merge-thursdays-work). Pull into a clean VM checkout and confirm its commit, live design, HTTPS, and data. Record the deployed commit. Use that verified baseline, or the earlier working one, for Railway migration. Azure work alone does not satisfy Project 1's later Railway auto-deploy requirement.
