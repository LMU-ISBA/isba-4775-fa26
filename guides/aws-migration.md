# Migrate your site from Railway to AWS

Session 17 · Thursday, October 29, 2026

Move your code, data, configuration, and domain. Keep Railway working until the AWS copy passes your checks. Today's goal is a tested backup and verified progress, even if the migration isn't finished.

This draft uses EC2 with local PostgreSQL as the proposed shared path. We'll compare alternatives before deploying.

Share this guide with your agent before starting. Work through one section at a time, using the prompts as starting points. Let your agent inspect your project and ask for missing information.

## 1. Choose the architecture

Open your application repository, Railway, and Cloudflare. Complete account setup and check your Free plan, credits, and expiry:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/aws-account-setup.md

https://console.aws.amazon.com/costmanagement/

Eligible resources consume credits. Don't upgrade to Paid or create or join AWS Organizations for this lesson.

| Option | Main tradeoff |
| --- | --- |
| EC2 + local PostgreSQL | Familiar setup, but you manage backups and both services share one failure point |
| EC2 + Single-AZ RDS | Managed database operations, with another service and additional costs |
| Lambda + API Gateway + Single-AZ RDS | Serverless app compute, with application changes, database connections, and external API access to resolve |

Require compatibility, preserved data, security, required functionality, and Free-plan eligibility before scoring. Compare cost, speed, complexity, reliability, security, scalability, maintainability, and portability. Separate deployment speed from runtime performance.

Choose weights totaling 100, score options from 1 to 5, and compare weighted totals. Draw the request path and explain:

```text
I chose [architecture] over [alternative] because [priority], and I accept [tradeoff].
```

Review a different architecture with me before provisioning, including every dependency's Free-plan eligibility.

## 2. Back up before an outage

GitHub holds code, not your live PostgreSQL rows. If the database becomes unreachable, you'll need an existing backup outside Railway.

```text
Help me back up my Railway app and test restoring it.
```

Use compatible PostgreSQL tools and a supported tunnel or export route:

https://docs.railway.com/guides/postgres-backups-restores

Include the database and uploaded files. Restore into a new local database without changing Railway. Check counts, representative records, and the restored app without querying Railway. Keep protected copies outside the repository and on independent storage. Keep secrets out of chat and Git. Remove temporary public database exposure afterward.

Record the backup date, restore time, backup frequency, and retention. Decide acceptable data loss (RPO) and recovery time (RTO). Continue independent backups after moving to EC2.

## 3. Create your IAM user

Use the account owner's browser session for setup. Your agent won't use root.

https://console.aws.amazon.com/iam/

1. Open Users → Create user and enter:

```text
isba-student
```

2. Enable console access, choose the IAM-user option, and privately save the password and sign-in URL.
3. Open Permissions → Add permissions → Attach policies directly. Add both policies:

```text
SignInLocalDevelopmentAccess
```

```text
AmazonEC2ReadOnlyAccess
```

4. Open Security credentials → Assign MFA device while still in the owner's session.
5. Sign out and sign in as the new IAM user with MFA.

If console access wasn't offered during creation, look under Security credentials → Console sign-in. Ask me if unavailable. These policies allow login and inspection, with deployment permissions added after review.

## 4. Connect your agent through the CLI

Install the latest AWS CLI v2 where your agent runs, including inside WSL or Codespaces when applicable:

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

```text
Help me install the latest AWS CLI.
```

Open a new terminal and check the version. Browser login needs 2.32.0 or later.

```bash
aws --version
```

Sign in locally:

```bash
aws login --profile isba-4775 --region us-east-1
```

For a remote terminal, use this instead:

```bash
aws login --profile isba-4775 --region us-east-1 --remote
```

Complete browser login yourself as the IAM user. Paste remote authorization codes only into the waiting terminal.

```bash
aws sts get-caller-identity --profile isba-4775
```

Confirm your account and IAM user. Stop if the ARN ends in `:root`.

```text
Check my AWS connection using the isba-4775 profile.
```

Have the agent confirm your identity and list EC2 instances in Northern Virginia without changing resources or reading credential files. An empty list is fine. Resolve access errors before continuing, and keep credentials out of chat and Git.

## 5. Plan and create EC2

Use a migration branch to avoid unexpectedly redeploying Railway.

```text
Look at my app and help me plan its move to AWS.
```

Use EC2 with local PostgreSQL unless we've reviewed another option. Review how the plan handles data, uploads, secrets, HTTPS, testing, and rollback. Keep Railway running and approve the plan before creating resources.

Estimate compute, storage, public IPv4, backup, and transfer costs against your credits. Set a cost budget excluding credits and email alerts in Billing. Alerts aren't spending caps.

Review this deployment policy with me before attaching it:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/aws-ec2-deployment-policy.json

It permits specified EC2 changes and deletion in Northern Virginia, including unrelated resources. Have me narrow it if your account contains other work. It doesn't enforce a budget or Free-plan eligibility.

As account owner, open IAM → Policies → Create policy → JSON. Paste the reviewed policy, resolve validation errors, and name it:

```text
ISBA4775EC2Migration
```

Attach it to your course user, then return to that identity. Don't use AdministratorAccess to bypass errors.

Open EC2 → Northern Virginia → Launch instance to review these choices before the agent creates anything:

| Setting | Starting choice |
| --- | --- |
| Image and compute | Official eligible Ubuntu LTS, x86_64, one t3.small, On-Demand, Standard CPU credits |
| Storage and metadata | Encrypted gp3 sized for your app and data, IMDSv2 required |
| Network | Existing default VPC, public subnet with internet access, one public IPv4 |
| Access | SSH key, port 22 restricted to your IP, public ports 80 and 443 |
| Private services | No public PostgreSQL or app-server port |

Approve the configuration, then let the agent launch it once. Find the instance in the console and verify its ID, address, security group, and storage. Connect through SSH after checking its host identity. Keep private keys outside Git.

Ask me if the default VPC is missing. Don't add NAT gateways or load balancers to bypass a blocker.

## 6. Deploy and restore

```text
Help me deploy my app to AWS using our plan.
```

Work one phase at a time. Deploy the intended commit and restore into a new AWS database. Keep Railway running and leave production DNS unchanged.

Check that Nginx forwards to a non-root app service, PostgreSQL stays local, and the app uses the AWS database. Keep secrets outside Git, restore uploads, and use compatible PostgreSQL versions. Don't replace existing data with seed records.

Enable services to start after reboot. Use the VM guide for service and log checks:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/operate-the-vm.md

## 7. Verify on a test subdomain

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
- Verify restricted SSH, private database access, and actual resource costs.

Record evidence for each check and mark anything you haven't verified.

## 8. Cut over when ready and record the result

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

Keep Railway until verification passes. Remove temporary database exposure and review unused resources for cleanup. Stopped VMs can still incur storage and address costs.

Repeat CLI login when the session expires. To clear its cached credentials when finished:

```bash
aws logout --profile isba-4775
```

## 9. Diagram what you built

```text
Add an architecture diagram of my app to the README.
```

Use Mermaid so the diagram displays on GitHub. Show the request path, hosting boundaries, ports, database, backups, and administrative access. Mark unfinished parts clearly.

Review every arrow against your deployment. Distinguish Cloudflare DNS from proxying, show where HTTPS ends, and identify where data persists. Include Railway if it still serves traffic. Explain the diagram to a classmate and correct anything you can't verify.
