# Migrate your site from Railway to AWS

Sessions 17 and 18 · October 29 and November 3, 2026

Move your code, data, configuration, and domain. Keep Railway working until the AWS copy passes your checks. Today's goal is a tested backup and verified progress, even if the migration isn't finished.

The shared path is EC2 for the app with a Single-AZ RDS PostgreSQL database. You've already run PostgreSQL yourself on a VM, so this time AWS runs it. We'll compare alternatives before deploying.

Open your career-platform project in VS Code and start a new Claude Code session named with:

```text
/rename aws-migration
```

Give your agent the guide, so later prompts can point at sections by number:

```text
Read this guide and keep it handy. We'll work through it one section
at a time:
https://raw.githubusercontent.com/LMU-ISBA/isba-4775-fa26/main/guides/aws-migration.md
```

Work through one section at a time, using the prompts as starting points. Let your agent inspect your project and ask for missing information.

## 1. Set a budget and choose the architecture

Open your application repository, Railway, and Cloudflare. Complete account setup and check your plan, credits, and expiry:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/aws-account-setup.md

https://console.aws.amazon.com/costmanagement/

Eligible resources consume credits. Don't upgrade to Paid or create or join AWS Organizations for this lesson. An existing account without the Free plan shows no plan or credits here and bills real usage, so keep to the instance sizes in section 8 and terminate the instance when you're done.

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

Include the database, and uploaded files if your app stores any. Restore into a new local database without changing Railway. Check counts, representative records, and the restored app without querying Railway. Keep protected copies outside the repository and on independent storage. Keep secrets out of chat and Git. Remove temporary public database exposure afterward.

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

If you're resuming a session from October 29, give your agent the current guide first, with the "Read this guide" prompt at the top of this page. The guide has changed since then.

The AWS Command Line Interface (CLI) lets you and your agent manage AWS by typing commands instead of clicking through the console.

https://aws.amazon.com/cli/

Install the latest AWS CLI v2 on your laptop, where your agent runs:

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

```text
Help me install the latest AWS CLI.
```

Open a new terminal and print the installed version. You need 2.35.0 or later. Restart Claude Code too, so its shell sees the new command.

```bash
aws --version
```

Sign in locally. This opens your browser, you sign in as the IAM user with MFA, and the CLI stores a temporary session under a new named profile, isba-4775. No access keys are created. The session refreshes itself for up to 12 hours, then you run the command again.

```bash
aws login --profile isba-4775 --region us-east-1
```

Complete browser login yourself as the IAM user. If your agent runs somewhere without a browser, like Codespaces, ask me.

When the CLI asks "Configure AWS skills and the AWS MCP server for your AI coding agent(s)?", answer y to both questions. That installs the Agent Toolkit for AWS: 24 AWS-written skills for your coding agents and an MCP server named aws-mcp. If the question didn't appear, install it yourself:

```bash
aws configure agent-toolkit
```

The CLI is the tool: your agent types commands and AWS answers. The toolkit adds two things. Skills give your agent the documented way to do a task instead of guessing from memory. The AWS MCP Server is a second way for the agent to call AWS, using your same IAM user, which it uses for lookups like current prices. Restart Claude Code after the install so it loads both.

https://docs.aws.amazon.com/agent-toolkit/latest/userguide/what-is-agent-toolkit.html

Login doesn't save a region on the profile, so set it once. Without it, EC2 and RDS commands fail with "You must specify a region." We use Northern Virginia because it's AWS's oldest and largest region, so new services arrive there first and prices are among the lowest.

```bash
aws configure set region us-east-1 --profile isba-4775
```

Ask AWS who you are through that profile. It prints the account ID and the user's ARN:

```bash
aws sts get-caller-identity --profile isba-4775
```

The output opens in a viewer that ends with `(END)`. Press q to get your prompt back. Confirm your account and IAM user. Stop if the ARN ends in `:root`. Every later command, including your agent's, passes the same profile flag to use this session.

```text
Check my AWS connection using the isba-4775 profile.
```

The agent should report the same account and user you saw. An empty instance list is fine, and an RDS or IAM denial is expected until section 5. Keep credentials out of chat and Git.

## 5. Give your IAM user deployment permissions

An IAM policy is a list of actions a user is allowed or denied, and it does nothing until it's attached to a user.

https://aws.amazon.com/iam/

Add a deployment policy so your IAM user can create EC2 and RDS resources. Sign out and sign back in as the root user, since your IAM user can't change its own permissions. Copy the policy JSON:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/aws-ec2-deployment-policy.json

Open Policies, choose Create policy, then JSON. Paste it, resolve validation errors, and choose Next.

https://console.aws.amazon.com/iam/home#/policies

Name it:

```text
ISBA4775EC2Migration
```

Before choosing Create policy, check the permissions summary on Review and create:

- Allow lists EC2, IAM, RDS, Systems Manager, and STS. EC2 and RDS show `aws:RequestedRegion = us-east-1`. Systems Manager is AWS's toolbox for looking after servers, and here it only lets the agent look up which Ubuntu image to use. STS is the service that hands out temporary sign-ins like your CLI session, and here it only lets the agent read why a request was refused.
- IAM shows `iam:AWSServiceName = rds.amazonaws.com`, which only lets RDS set up its own service role.
- Explicit deny lists EC2 and RDS. These block instances other than t3.micro or t3.small, instances without IMDSv2, and databases that aren't Single-AZ micro with 20 GB of encrypted storage, or that are reachable from the internet.

The allows are the grant and the denies are fences around it, because a deny always wins. The policy allows EC2 and RDS changes and deletion in Northern Virginia, including resources that aren't for this course. It doesn't enforce a budget or Free-plan eligibility.

Now attach it to your user:

https://console.aws.amazon.com/iam/home#/users

1. Open Users and choose isba-student.
2. Under Permissions, choose Add permissions, then Attach policies directly.
3. Search for ISBA4775EC2Migration, tick it, and choose Add permissions.
4. Sign out and sign back in as isba-student.

Don't use AdministratorAccess to bypass errors.

Your CLI session keeps working and picks up the new permissions on its own. Don't run aws login while the browser is signed in as root, since the CLI picks up the browser's current sign-in. If get-caller-identity ever ends in `:root`, sign in to the console as isba-student, then:

```bash
aws logout --profile isba-4775
aws login --profile isba-4775 --region us-east-1
```

To have each action explained, ask your agent:

```text
Review this deployment policy with me:
https://raw.githubusercontent.com/LMU-ISBA/isba-4775-fa26/main/guides/aws-ec2-deployment-policy.json
```

## 6. Plan the move

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
three, starting with the ones that would change the plan.
```

Answer each question yourself. If you don't know, ask the agent to explain the options, then choose. Then ask for the plan:

```text
Look at my app and help me plan its move to AWS. Use EC2 for the app
and a Single-AZ RDS PostgreSQL database. Work on a new branch so
Railway doesn't redeploy from main. Don't create anything yet.
```

Northern Virginia, the us-east-1 region, has six availability zones, us-east-1a through 1f. Section 7 explains what Single-AZ means for the database. If we've reviewed a different architecture, say so in the prompt.

The agent writes the plan to a file in your repository and tells you where, often under docs/. Open that file and read it before you answer. Tell the agent what to change, then approve the plan. Don't let it create anything yet.

AWS Pricing Calculator estimates the monthly cost of the services and sizes you pick, and it's the place to check your agent's numbers.

https://calculator.aws/

```text
Estimate the monthly cost of this plan: EC2, RDS, storage, public IPv4,
backups, and data transfer. Use current us-east-1 pricing, not memory.
Compare the total to my budget.
```

Expect about $26 a month: the database about $12, the instance about $8, and the rest storage and the public address. Your IAM user can't see credits or bills, so the agent's number is an estimate, and the account owner's session shows what credits remain. The $100 in credits covers the rest of the semester. When the semester ends, decide whether to keep paying, move the site to a cheaper host, or delete it. You'll know how to do all three. If class time is short, run the estimate at home.

## 7. Create the RDS database

Amazon RDS for PostgreSQL runs your database on a server AWS manages, so you don't install or patch PostgreSQL yourself.

https://aws.amazon.com/rds/postgresql/

Single-AZ means the database runs in one availability zone, a separate data center with its own power and network, so it goes down if that zone has an outage. Multi-AZ keeps a standby copy in a second zone for failover, costs about double, and isn't on the Free plan.

Open RDS → Northern Virginia → Create database and review these choices before the agent creates the database:

https://us-east-1.console.aws.amazon.com/rds/home?region=us-east-1#databases:

| Setting | Starting choice |
| --- | --- |
| Engine and version | PostgreSQL 18, the same major version as Railway |
| Template and availability | Free tier, Single-AZ, one db.t3.micro or db.t4g.micro |
| Storage | 20 GB encrypted gp3, autoscaling off |
| Credentials | Self managed, a generated password the agent keeps in a local file outside the repository, without printing it, until the server exists |
| Network | Default VPC, not publicly accessible, its own security group allowing port 5432 only from the EC2 instance's security group |
| Backups | Automated backups on, seven days |

On an account without the Free plan, the Free tier template doesn't appear. Choose Dev/Test, then change the class, Single-AZ, and 20 GB to match the table.

The database's security group refers to the instance's security group, so the agent creates both groups now and launches the instance into its group in section 8.

```text
Create the RDS database from our plan with the settings in section 7
of the guide, and the two security groups it needs. Don't wait for
the database to become available.
```

Approve the commands, then let the agent create it once. Creation takes five to ten minutes, so continue to section 8 while it runs. Find the database in the console and verify its endpoint, class, Single-AZ, and that Publicly accessible is No.

Ask me if the default VPC is missing. Don't add NAT gateways or load balancers to bypass a blocker.

## 8. Create the EC2 instance

Amazon EC2 is where your app will run, on one virtual machine in Northern Virginia.

https://aws.amazon.com/ec2/

Open EC2 → Northern Virginia → Launch instance to review these choices before the agent creates anything:

https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#Instances:

| Setting | Starting choice |
| --- | --- |
| Image and compute | Ubuntu Server 26.04 LTS from Canonical, x86_64, one t3.micro, On-Demand, Standard CPU credits |
| Storage and metadata | 20 GB encrypted gp3, IMDSv2 required |
| Network | Existing default VPC, public subnet with internet access, one public IPv4 |
| Access | SSH key, port 22 restricted to your IP, public ports 80 and 443 |
| Private services | No public app-server port, and no PostgreSQL on the instance |

Ubuntu 26.04 ships the PostgreSQL 18 client that section 9's restore needs. Ubuntu Pro images bill by the hour, so the image name says "server," not "pro-server."

```text
Launch the EC2 instance from our plan with the settings in section 8
of the guide, into the security group from section 7. Generate the
SSH key on my laptop and import the public key. Attach an Elastic IP
after launch.
```

Three things the policy expects. It doesn't let AWS create the key, on purpose, so the private key never leaves your laptop. The launch command must set IMDSv2 to required itself, or the policy denies it. If a launch is denied, the agent can decode the error message to see which rule fired.

An Elastic IP is a public address that stays yours through stop and start, so the test record in section 10 keeps working. It costs the same as the automatic address while attached, and bills while idle, so release it when you terminate the instance.

Approve the commands, then let the agent launch it once. Find the instance in the console and verify its ID, address, security group, and storage. Have the agent compare the SSH host key with the instance's console output before you connect. Keep private keys outside Git.

## 9. Deploy and restore

```text
Help me deploy my app to AWS using our plan. Use how this repo set up
my Azure VM as the reference. Keep a migration-notes.md file and log
any deviation from the plan.
```

Work one phase at a time. Deploy the intended commit and restore into the new AWS database. Keep Railway running and leave production DNS unchanged.

Check that Nginx forwards to a non-root app service and the app's database URL points at the RDS endpoint over the private network. SSH in as the ubuntu user with your new key. RDS requires TLS, and the default sslmode=prefer handles it, so don't add sslmode=disable or verify-full.

Restore your backup from the EC2 instance, since RDS isn't reachable from your laptop. Restore into the empty database first, then run the migrations, which should change nothing. Don't run your Azure deploy script or any seed script on AWS. Seed scripts can overwrite or unpublish restored records, and migrating before the restore makes it fail with "already exists." Before restoring, check that the instance's pg_restore is the same major version as Railway's PostgreSQL or newer, since an older client can't read the dump. Railway ran version 18 in October. Keep secrets outside Git. If your app stores uploaded files, copy those too.

Enable services to start after reboot. Use sections 4 and 6 of the VM guide for service and log checks, with the EC2 security group in place of the Azure rule:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/operate-the-vm.md

## 10. Verify on a test subdomain

Add a separate A record in Cloudflare for the AWS copy, named aws, so it answers at aws.yourname.com. Point it at the Elastic IP, set it to DNS only with the grey cloud, and leave the Railway and mail records alone.

https://dash.cloudflare.com

Configure Nginx and HTTPS for that name using sections 3 through 6 of the HTTPS guide, with aws.yourname.com in place of both names it uses:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/secure-your-site-with-https.md

```text
Help me test that my app works on AWS at aws.yourname.com.
```

- Confirm the deployed commit and compare records with the backup.
- Add a test record through the AWS copy, restart the app service, and confirm it's still there. It exists only on AWS, so note it for cleanup before cutover.
- Reboot the VM and confirm the app, database, and web server return.
- Test required pages, redirects, assets, integrations, and certificate renewal.
- Verify restricted SSH, that RDS isn't publicly accessible and only accepts the EC2 security group, and that the instance and database match the sizes in sections 7 and 8.

Record evidence for each check and mark anything you haven't verified.

## 11. Cut over when ready and record the result

If checks are incomplete, leave Railway serving the site. DNS cutover isn't required during class.

1. Confirm the Elastic IP from section 8 is attached, so the address survives stop and start.
2. Prepare HTTPS for the production hostname. DNS-01 validation can issue its certificate before traffic moves.
3. Save the existing DNS record and take a final backup. Then stop the Railway deployment so it can't accept new records, and restart it only if you roll back.
4. Restore and compare the final data, then delete the test record from section 10.
5. Change only the application's DNS record. Preserve mail and unrelated records.
6. Verify the production site at your domain.

For issuing the production certificate before cutover:

https://letsencrypt.org/docs/challenge-types/#dns-01-challenge

If you roll back after AWS accepts writes, reconcile the databases first. Changing DNS doesn't move those new records.

Update your README with the decision, backup and recovery process, verification results, costs, and next step. Commit reviewed code and notes without secrets or exports. Check Railway's connected branch before pushing.

Keep Railway until verification passes. Remove temporary database exposure and review unused resources for cleanup. Stopped VMs can still incur storage and address costs, and an Elastic IP bills while it isn't attached to a running instance. A stopped RDS instance restarts itself after seven days, so delete it with a final snapshot when you're done with it.

Repeat CLI login when the session expires. To clear its cached credentials when finished:

```bash
aws logout --profile isba-4775
```

## 12. Diagram what you built

```text
Add an architecture diagram of my app to the README.
```

Use Mermaid so the diagram displays on GitHub. Show the request path, hosting boundaries, ports, the RDS database as its own box inside the VPC, backups, and administrative access. Mark unfinished parts clearly.

Review every arrow against your deployment. Distinguish Cloudflare DNS from proxying, show where HTTPS ends, and identify where data persists. Include Railway if it still serves traffic. Explain the diagram to a classmate and correct anything you can't verify.
