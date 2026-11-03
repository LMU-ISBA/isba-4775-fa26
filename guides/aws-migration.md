# Migrate your site from Railway to AWS

Session 17 · Thursday, October 29, 2026

Move your code, data, configuration, and domain. Keep Railway working until the AWS copy passes your checks. Today's goal is a tested backup and verified progress, even if the migration isn't finished.

The shared path is EC2 for the app with a Single-AZ RDS PostgreSQL database. You've already run PostgreSQL yourself on a VM, so this time AWS runs it. We'll compare alternatives before deploying.

Open your career-platform project in VS Code and start a new Claude Code session named with:

```text
/rename aws-migration
```

Share this guide with your agent before starting. Work through one section at a time, using the prompts as starting points. Let your agent inspect your project and ask for missing information.

## 1. Set a budget and choose the architecture

Open your application repository, Railway, and Cloudflare. Complete account setup and check your plan, credits, and expiry:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/aws-account-setup.md

https://console.aws.amazon.com/costmanagement/

Eligible resources consume credits. Don't upgrade to Paid or create or join AWS Organizations for this lesson. An existing account without the Free plan shows no plan or credits here and bills real usage, so keep to the instance sizes in section 7 and terminate the instance when you're done.

AWS Budgets tracks what your account spends and emails you when cost passes an amount you set.

https://aws.amazon.com/aws-cost-management/aws-budgets/

Set a budget so AWS emails you before a surprise bill. Alerts aren't spending caps.

https://console.aws.amazon.com/costmanagement/home#/budgets

1. Choose Create budget.
2. Under Budget setup, choose Use a template (simplified), then Zero spend budget.
3. Keep the default name, enter your email, and choose Create budget. AWS emails you the first time a charge isn't covered by credits.

Budgets count cost after credits, so watch the Credits page for how fast credits drain. On an existing account without the Free plan, zero-spend fires right away, so choose Monthly cost budget with an amount of 10 instead.

Now compare where the app could run. Each option combines these services:

- Amazon EC2 rents you virtual machines, called instances, that you set up and manage like your Azure VM. https://aws.amazon.com/ec2/
- Amazon RDS runs a database for you, with AWS handling the server, patching, and backups. https://aws.amazon.com/rds/
- AWS Lambda runs your code only when a request arrives, so there's no server for you to keep running. https://aws.amazon.com/lambda/
- Amazon API Gateway gives Lambda functions a public web address and passes each request to them. https://aws.amazon.com/api-gateway/

| Option | Main tradeoff |
| --- | --- |
| EC2 + local PostgreSQL | Familiar setup, but you manage backups and both services share one failure point |
| EC2 + Single-AZ RDS | Managed database operations, with another service and additional costs |
| Lambda + API Gateway + Single-AZ RDS | Serverless app compute, with application changes, database connections, and external API access to resolve |

Let your agent compare the options against your actual app:

```text
Look at my app and compare three ways to run it on AWS: EC2 with local
PostgreSQL, EC2 with RDS, and Lambda with API Gateway and RDS. Tell me
which you'd pick if my top priority is cost, which if it's speed to
deploy, and which if it's least to operate. Name the tradeoff each time.
```

Tell the agent which priority is yours. Check its recommendation against four requirements before accepting it: the app runs with changes you understand, your data moves intact, PostgreSQL stays private, and every service is on your plan. Then write your decision and draw the request path:

```text
I chose [architecture] over [alternative] because [priority], and I accept [tradeoff].
```

Review a different architecture with me before provisioning, including every dependency's Free-plan eligibility.

## 2. Back up before an outage

GitHub holds code, not your live PostgreSQL rows. If the database becomes unreachable, you'll need an existing backup outside Railway.

```text
We're migrating this app from Railway to AWS. Back up the Railway
database and test restoring the backup.
```

Use compatible PostgreSQL tools and a supported tunnel or export route:

https://docs.railway.com/guides/postgres-backups-restores

Include the database and uploaded files. Restore into a new local database without changing Railway. Check counts, representative records, and the restored app without querying Railway. Keep protected copies outside the repository and on independent storage. Keep secrets out of chat and Git. Remove temporary public database exposure afterward.

Record the backup date, restore time, backup frequency, and retention. Decide acceptable data loss (RPO) and recovery time (RTO). RDS keeps automated backups, but keep an independent export outside AWS too.

## 3. Create your IAM user

AWS Identity and Access Management (IAM) controls who can sign in to your account and what each user is allowed to do.

https://aws.amazon.com/iam/

Use the account owner's browser session for setup. Your agent won't use root.

https://console.aws.amazon.com/iam/

1. Open Users → Create user and enter:

```text
isba-student
```

2. Enable console access and choose the IAM-user option.
3. At Set permissions, choose Attach policies directly, not a group. Search for and tick both policies, then continue to Create user.

The first lets the AWS CLI on your laptop sign in through the browser as this user:

```text
SignInLocalDevelopmentAccess
```

The second lets the user and your agent look at EC2 without changing anything:

```text
AmazonEC2ReadOnlyAccess
```

4. Privately save the password and sign-in URL from the final page.
5. Open the user → Security credentials → Assign MFA device while still in the owner's session.
6. Sign out and sign in as the new IAM user with MFA.

If console access wasn't offered during creation, look under Security credentials → Console sign-in. Ask me if unavailable. These policies allow login and inspection, with deployment permissions added after review.

## 4. Connect your agent through the CLI

The AWS Command Line Interface (CLI) lets you and your agent manage AWS by typing commands instead of clicking through the console.

https://aws.amazon.com/cli/

Install the latest AWS CLI v2 on your laptop, where your agent runs:

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

```text
Help me install the latest AWS CLI.
```

Open a new terminal and print the installed version. You need 2.35.0 or later.

```bash
aws --version
```

Sign in locally. This opens your browser, you sign in as the IAM user with MFA, and the CLI stores a temporary session under a new named profile, isba-4775, with Northern Virginia as its region. No access keys are created.

```bash
aws login --profile isba-4775 --region us-east-1
```

Complete browser login yourself as the IAM user. If your agent runs somewhere without a browser, like Codespaces, ask me.

Login doesn't save a region on the profile, so set it once. Without it, EC2 and RDS commands fail with "You must specify a region."

```bash
aws configure set region us-east-1 --profile isba-4775
```

When the CLI asks "Configure AWS skills and the AWS MCP server for your AI coding agent(s)?", answer n. We migrate with the CLI alone first, so you see what the agent does with plain commands. The toolkit comes after the migration, at the end of section 11.

Ask AWS who you are through that profile. It prints the account ID and the user's ARN:

```bash
aws sts get-caller-identity --profile isba-4775
```

The output opens in a viewer that ends with `(END)`. Press q to get your prompt back. Confirm your account and IAM user. Stop if the ARN ends in `:root`. Every later command, including your agent's, passes the same profile flag to use this session.

```text
Check my AWS connection using the isba-4775 profile.
```

Have the agent confirm your identity and list EC2 instances in Northern Virginia without changing resources or reading credential files. An empty list is fine. If the agent probes RDS or IAM and gets access denied, that's expected: this user can't deploy yet, and section 6 adds those permissions. Resolve any other access error before continuing, and keep credentials out of chat and Git.

## 5. Plan the move

Before planning, find what you don't know yet. Ask your agent for a blind spot pass, a tactic from Anthropic's field guide on finding your unknowns:

https://claude.com/resources/articles/a-field-guide-to-claude-fable-finding-your-unknowns

```text
I've never deployed to AWS. Before we plan, do a blind spot pass on
moving this app to EC2 and RDS: what are my unknown unknowns, and
what should I decide before you write the plan?
```

Then have the agent interview you, so you make those decisions instead of the agent guessing:

```text
Interview me one question at a time about those decisions, up to
five, starting with the ones that would change the plan.
```

Answer each question yourself. If you don't know, ask the agent to explain the options, then choose. Then ask for the plan:

```text
Look at my app and help me plan its move to AWS. Use EC2 for the app
and a Single-AZ RDS PostgreSQL database. Work on a new branch so
Railway doesn't redeploy from main. Don't create anything yet.
```

Northern Virginia, the us-east-1 region, has six availability zones, us-east-1a through 1f. Section 8 explains what Single-AZ means for the database. If we've reviewed a different architecture, say so in the prompt.

Review how the plan handles data, uploads, secrets, HTTPS, testing, and rollback. Keep Railway running and approve the plan before creating resources.

AWS Pricing Calculator estimates the monthly cost of the services and sizes you pick, and it's the place to check your agent's numbers.

https://calculator.aws/

```text
Estimate the monthly cost of this plan: EC2, RDS, storage, public IPv4,
backups, and data transfer. Use current us-east-1 pricing, not memory.
Compare the total to my credits and my budget.
```

Expect roughly $35 a month with RDS as the largest line. That means the $100 in credits covers the rest of the semester but not six months, so delete the resources when the course ends.

## 6. Give your IAM user deployment permissions

An IAM policy is a list of actions a user is allowed or denied, and it does nothing until it's attached to a user.

https://aws.amazon.com/iam/

Add a deployment policy so your IAM user can create EC2 and RDS resources. Sign out and sign back in as the root user, since your IAM user can't change its own permissions. Copy the policy JSON:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/aws-ec2-deployment-policy.json

Open IAM → Policies → Create policy → JSON. Paste it, resolve validation errors, and choose Next. Name it:

```text
ISBA4775EC2Migration
```

Before choosing Create policy, check the permissions summary on Review and create:

- Allow lists EC2, IAM, and RDS. EC2 and RDS show `aws:RequestedRegion = us-east-1`.
- IAM shows `iam:AWSServiceName = rds.amazonaws.com`, which only lets RDS set up its own service role.
- Explicit deny lists EC2 and RDS. These block instances other than t3.micro or t3.small, instances without IMDSv2, and databases that aren't Single-AZ micro with 20 GB of encrypted storage.

The policy allows EC2 and RDS changes and deletion in Northern Virginia, including resources that aren't for this course. Have me narrow it if your account contains other work. It doesn't enforce a budget or Free-plan eligibility.

Attach it to your course user, then sign out and sign back in as isba-student. Don't use AdministratorAccess to bypass errors.

To have each action explained, ask your agent:

```text
Review this deployment policy with me:
https://raw.githubusercontent.com/LMU-ISBA/isba-4775-fa26/main/guides/aws-ec2-deployment-policy.json
```

## 7. Create the EC2 instance

Amazon EC2 is where your app will run, on one virtual machine in Northern Virginia.

https://aws.amazon.com/ec2/

Open EC2 → Northern Virginia → Launch instance to review these choices before the agent creates anything:

| Setting | Starting choice |
| --- | --- |
| Image and compute | Official eligible Ubuntu LTS, x86_64, one t3.small, On-Demand, Standard CPU credits |
| Storage and metadata | Encrypted gp3 sized for your app and data, IMDSv2 required |
| Network | Existing default VPC, public subnet with internet access, one public IPv4 |
| Access | SSH key, port 22 restricted to your IP, public ports 80 and 443 |
| Private services | No public app-server port, and no PostgreSQL on the instance |

Approve the configuration, then let the agent launch it once. Find the instance in the console and verify its ID, address, security group, and storage. Connect through SSH after checking its host identity. Keep private keys outside Git.

Ask me if the default VPC is missing. Don't add NAT gateways or load balancers to bypass a blocker.

## 8. Create the RDS database

Amazon RDS for PostgreSQL runs your database on a server AWS manages, so you don't install or patch PostgreSQL yourself.

https://aws.amazon.com/rds/postgresql/

Single-AZ means the database runs in one availability zone, a separate data center with its own power and network, so it goes down if that zone has an outage. Multi-AZ keeps a standby copy in a second zone for failover, costs about double, and isn't on the Free plan.

Open RDS → Northern Virginia → Create database and review these choices before the agent creates the database:

| Setting | Starting choice |
| --- | --- |
| Engine and version | PostgreSQL, same major version as Railway or newer |
| Template and availability | Free tier or Dev/Test, Single-AZ, one db.t3.micro or db.t4g.micro |
| Storage | 20 GB encrypted gp3, autoscaling off |
| Credentials | Self managed, a generated password the agent writes to the server's environment file without printing it |
| Network | Default VPC, not publicly accessible, its own security group allowing port 5432 only from the EC2 instance's security group |
| Backups | Automated backups on, seven days |

Approve it, then let the agent create it once. Creation takes five to ten minutes, so start setting up the app in section 9 while it runs. Find the database in the console and verify its endpoint, class, Single-AZ, and that Publicly accessible is No.

https://us-east-1.console.aws.amazon.com/rds/home?region=us-east-1#databases:

## 9. Deploy and restore

```text
Help me deploy my app to AWS using our plan. Use the Nginx and service
files in deploy/ from my Azure VM as the reference. Keep a
migration-notes.md file and log any deviation from the plan.
```

Work one phase at a time. Deploy the intended commit and restore into a new AWS database. Keep Railway running and leave production DNS unchanged.

Check that Nginx forwards to a non-root app service and the app's database URL points at the RDS endpoint over the private network. Restore your backup from the EC2 instance, since RDS isn't reachable from your laptop. Keep secrets outside Git and restore uploads. Before restoring, check that the instance's pg_restore is the same major version as Railway's PostgreSQL or newer, since an older client can't read the dump. Railway ran version 18 in October. Don't replace existing data with seed records.

Enable services to start after reboot. Use the VM guide for service and log checks:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/operate-the-vm.md

## 10. Verify on a test subdomain

Create a separate Cloudflare A record pointing to AWS. Keep the live Railway and mail records. Configure Nginx and HTTPS using the existing guide:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/secure-your-site-with-https.md

If Cloudflare proxies the site, use Full (strict) with a valid origin certificate.

```text
Help me test that my app works on AWS.
```

- Confirm the deployed commit and compare records with the backup.
- Create a target-only record and confirm it survives an app restart.
- Reboot the VM and confirm the app, database, and web server return.
- Test required pages, uploads, redirects, assets, integrations, and certificate renewal.
- Verify restricted SSH, that RDS isn't publicly accessible and only accepts the EC2 security group, and actual resource costs.

Record evidence for each check and mark anything you haven't verified.

## 11. Cut over when ready and record the result

If checks are incomplete, leave Railway serving the site. DNS cutover isn't required during class.

1. Review address stability: an automatic EC2 public IP can change after stop/start. Use a reviewed stable address or update procedure.
2. Prepare HTTPS for the production hostname. DNS-01 validation can issue its certificate before traffic moves.
3. Save the existing DNS record, pause Railway writes, and take a final backup.
4. Restore and compare the final data, then reconcile target-only test records.
5. Change only the application's DNS record. Preserve mail and unrelated records.
6. Verify the production site before enabling AWS writes. Keep Railway from accepting competing writes during DNS propagation.

For issuing the production certificate before cutover:

https://letsencrypt.org/docs/challenge-types/#dns-01-challenge

If you roll back after AWS accepts writes, reconcile the databases first. Changing DNS doesn't move those new records.

Update your README with the decision, backup and recovery process, verification results, costs, and next step. Commit reviewed code and notes without secrets or exports. Check Railway's connected branch before pushing.

Keep Railway until verification passes. Remove temporary database exposure and review unused resources for cleanup. Stopped VMs can still incur storage and address costs. A stopped RDS instance restarts itself after seven days, so delete it with a final snapshot when you're done with it.

Repeat CLI login when the session expires. To clear its cached credentials when finished:

```bash
aws logout --profile isba-4775
```

Once the app runs on AWS, add the Agent Toolkit for AWS so your agent has AWS-written instructions for the questions and operations that come next:

```bash
aws configure agent-toolkit
```

Answer Y to both questions. It installs 24 AWS skills into every coding agent it finds on your laptop and adds an MCP server named aws-mcp. Restart your agent afterward so it loads the new configuration.

The CLI is the tool: your agent types commands and AWS answers. The toolkit adds two things. Skills are AWS-written instructions that give your agent the documented way to do a task instead of guessing from memory. The AWS MCP Server is a second way for the agent to call AWS, using your same IAM user, and AWS records which calls came from the agent rather than from you.

https://docs.aws.amazon.com/agent-toolkit/latest/userguide/aws-cli.html

## 12. Diagram what you built

```text
Add an architecture diagram of my app to the README.
```

Use Mermaid so the diagram displays on GitHub. Show the request path, hosting boundaries, ports, the RDS database as its own box inside the VPC, backups, and administrative access. Mark unfinished parts clearly.

Review every arrow against your deployment. Distinguish Cloudflare DNS from proxying, show where HTTPS ends, and identify where data persists. Include Railway if it still serves traffic. Explain the diagram to a classmate and correct anything you can't verify.
