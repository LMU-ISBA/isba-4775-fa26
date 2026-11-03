# Exercise 07: Migrate your site from Railway to AWS

Due Tuesday, November 10, 2026, at 1:45 PM. 15 points. Submit your public `career-platform` repository URL and a direct GitHub link to `docs/evidence/ex07.md` in Brightspace.

Move your site from Railway to an EC2 instance with a Single-AZ RDS PostgreSQL database, verify the AWS copy on a test subdomain, and cut your domain over before your Railway trial ends. Keep Railway serving the site until your checks pass.

## Complete the migration and checks

Follow the [AWS migration guide](../guides/aws-migration.md). Sections 1 through 8 were class work on October 29 and November 3. Sections 9 through 12 are the deploy, the test subdomain, the cutover, and the diagram.

- Backup: an export of the Railway database, restored and checked before anything moved.
- Infrastructure: one t3.micro or t3.small instance and one Single-AZ micro database in Northern Virginia, the database not publicly accessible.
- Verification: the AWS copy tested on your test subdomain over HTTPS, with evidence.
- Cutover: your domain pointing at AWS, or a written list of what's left if your checks haven't passed.
- Diagram: the section 12 architecture diagram in your README.

If your account or budget blocks a step, record the restriction and ask the instructor before paying for anything.

## Submit a short results sheet

Use one file, `docs/evidence/ex07.md`. Include only these five items:

1. Your architecture decision in one sentence: what you chose, what you rejected, and the tradeoff you accepted.
2. Your backup record: backup date, restore test result, and the data loss and recovery time you decided to accept.
3. A verification table for the test subdomain: what you tested, the evidence, and pass, fail, or not verified.
4. Cutover status: the date your domain moved to AWS, or what's left and when you'll finish. Include a screenshot of the DNS record.
5. Cost: the estimate from section 6 and what the account owner's billing page shows now, in one screenshot.

Link to the README diagram rather than pasting it again. If a check failed, briefly note what you tried, what happened, and your next step.

Keep passwords, keys, account IDs, and database exports out of the public file. Commit and push the file, then open its direct GitHub link.

## How credit works

This exercise is credit/no credit: 15 points or 0 points. Credit reflects a meaningful attempt to migrate, verify, and document the move. Honest failed checks and technical mistakes can earn credit with feedback. Absent work or a submission without a meaningful attempt receives no credit.
