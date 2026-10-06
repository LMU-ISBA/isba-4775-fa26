# Improve your site's design before Railway

Complete this 30-45 minute activity before Thursday, October 8, 2026, at 1:45 PM Pacific, alongside Exercise 04. Work in your existing `career-platform` repository. This is required preparation, with no separate Brightspace grade item or extra points. Exercise 04's HTTPS checks and deadline still apply.

Your goal is to make two or three focused improvements to the resume site's page. Use a critique to choose them, then show the same page before and after. Keep your real profile and project content. Do not invent experience, qualifications, or projects to make the page look full. Leave the backend, database, current data, routes, environment variables, service setup, DNS, and HTTPS alone.

## 1. Save a working baseline, about five minutes

Open the current Azure page and confirm it shows the expected database-backed project content. Record whether HTTPS is working yet, since Exercise 04 still requires it. On the VM, run `git rev-parse HEAD` in the deployed app repository and record that SHA. Compare it with your laptop's `git rev-parse HEAD`. If they differ, find which code is running before choosing a design baseline. Do not reset either checkout just to make the numbers match. In your local repository, check `git status` and save or commit unfinished work safely, without putting credentials or a database export in Git.

Once the working version is committed and the status is clean, record its SHA and create a branch:

```text
git rev-parse --short HEAD
git switch -c design-refresh
```

If the branch name already exists, choose a new name. Record the branch, Azure SHA, and local baseline SHA in `docs/evidence/design-refresh.md`. Open the page locally using that baseline and its current local data. Save a before screenshot there. Use the same local data and viewport for the after screenshot, so the comparison shows the design change. Keep the Azure observation separate for Exercise 04. If local data or code differs from Azure, describe that difference. This gives you a clear way to compare or set aside the design change if it affects the working site.

## 2. Ask for a critique, about ten minutes

Impeccable works with Claude Code and other coding tools, including GitHub Copilot. Use Claude Code if that is your current class tool, or Copilot if that is what you have used for this project. Its terminal installer requires Node.js 22.18 or later. In the project folder, check `node --version`, then run:

```text
npx impeccable install
```

Choose your current coding tool and the option for this project when prompted. Reload the coding tool afterward. In Claude Code, ask `/impeccable init` to record who the site serves and what visitors should find. Check the generated `PRODUCT.md` for mistakes. It is tool context, not a replacement for your README or Project 1 engineering record. Then ask:

```text
/impeccable critique my resume homepage. Visitors should quickly find my
introduction, projects, and professional links. Keep my real content and all
working behavior. Give me the two or three highest-priority design fixes.
```

If your coding tool uses different Impeccable syntax, follow the prompts it shows. Give the agent the local page or your before screenshot if it cannot inspect the rendered site. The critique reviews the page and suggests changes. It does not make every suggested change for you. Read the findings and choose two or three that help visitors. The official setup and improvement instructions are at https://impeccable.style/tutorials/getting-started/ and https://impeccable.style/docs/improve-design/.

If setup is still blocked after ten minutes, record the exact error and move on. Ask your current coding agent in ordinary language to critique the homepage for hierarchy, readability, spacing, and mobile use. Use the same review steps below. You do not need a new API account or image generation for this activity.

## 3. Make two or three changes, about 15 minutes

Choose a narrow set, such as clearer heading order, more readable type, better spacing, stronger link labels, or a layout that fits a phone. Tell your agent which findings you chose and what must remain unchanged. For example:

```text
Improve the homepage in this branch only. Make the heading and project sections
easier to scan, improve spacing on a phone, and make professional links easier
to recognize. Keep my real words and data, database queries, routes, error
state, environment settings, Azure service setup, DNS, and HTTPS unchanged.
Show me the diff before you commit or deploy anything.
```

Review the changed files and the full diff. Keep the work in templates, styles, or other presentation files. Ask why if the agent changes application logic, dependency files, database code, deployment settings, or security configuration. Reject changes you cannot explain. Do not replace your current project data with sample rows.

## 4. Check and record the result, then stop at 45 minutes

Run the app locally using your existing project instructions. Compare it with your local before screenshot using the same data and viewport, then save an after screenshot. Check a desktop and a narrow phone width. Use the keyboard to reach and open links, and confirm the link destinations. Check that the profile and current project data still appear. Use existing safe tests or an isolated setting to confirm the empty-table and graceful database-error behavior remain intact. Do not break the production database just to test an error. If you cannot safely repeat that check, inspect the diff, cite prior evidence, and mark the behavior unverified for this change.

Commit the reviewed design change and note its SHA. Save the before and after images in `docs/evidence/` without private browser details. Write a short `docs/evidence/design-refresh.md` entry with the Azure, baseline, and design-change SHAs, critique findings you chose, two or three changes, screenshot links, checks and actual results, and any blocker. Commit the evidence and images, then push the branch so the record is available. You may link this entry from your Project 1 submission index later.

Stop the activity at 45 minutes. If installation, checks, or documentation need more time, record what passed and what remains open, push the reviewed branch when safe, and bring it to class. Plan a separate window for any unfinished checks or deployment. Do not skip verification to make the time estimate.

Publish the design to the current Azure site only after the diff and local checks pass. Open a pull request from `design-refresh` into the branch your VM deploys, normally `main`. Review its files and merge it, following [the Azure migration workflow](azure-vm-migration.md#merge-thursdays-work). Record the merged deployment SHA separately from the design commit. Before pulling on the VM, confirm it is on the expected branch and `git status --short` shows no unexpected tracked changes. Stop and ask for help if it does. Do not use a hard reset. If the VM deploys `main`, run `git pull --ff-only origin main`. Verify the VM's `git rev-parse HEAD` matches the merged SHA, then restart the service and check the live page. Confirm the deployed design, HTTPS, and current database content. Add the deployed SHA and live result to your evidence when you next update it, labeling any later documentation commit separately. If any check is blocked by Thursday's deadline, keep the working Azure site, bring the branch and honest notes, and finish the design after resolving the blocker. Do not trade away Exercise 04's working HTTPS site for a design change.

Before the Railway migration, decide which tested commit is the source: the verified Azure design update or the earlier working commit. Record the deployed code SHA in the migration plan, distinct from any later documentation-only commit, so the code baseline and source data refer to the same starting system. A design change deployed only on Azure does not meet Project 1's separate verified Railway update requirement. After migration, you still need a reviewed commit, Railway deployment, and observed change at your domain.
