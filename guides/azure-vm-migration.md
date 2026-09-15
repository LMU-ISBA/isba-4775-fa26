# Migrate your resume site to an Azure VM

Session 06 · September 17, 2026

Draft status: student-facing draft. The Azure procedure, subscription checks,
region, VM size, image, prices, quotas, and timing require instructor rehearsal.

Today you will make the first migration of your resume application. You will
discover and map the source, then review a target plan. You will create one
Azure VM, move code and live data, and compare the two systems. On September
22, we will finish the public Nginx and systemd operations.

Use Claude Code (preferred) or Codex CLI with Superpowers in your existing
`career-platform` Codespace. The agent uses the Azure CLI and SSH from there. Keep the source Codespace available as the
rollback system until the migration evidence is complete.

## Before class

Complete [Prepare for the Azure VM lesson](azure-vm-preparation.md) before
Thursday. It covers your saved application, Azure for Students activation,
agent sign-in, Superpowers installation, and Azure CLI authentication.

The instructor must rehearse the available regions, sizes, quotas, images,
estimated costs, and source-IP behavior on the class subscription. No guide can
promise that a particular region or SKU will be available to every account.

Bring your working `career-platform` repository and its stopped Codespace.
Start the Codespace when class begins.

## Our route through class

| Minutes | Work | Checkpoint |
| --- | --- | --- |
| 0–10 | Sign in with Azure CLI and select the student subscription | Correct account and subscription are visible |
| 10–25 | Discover the source and map the request path | Source inventory records code, runtime, data, and secrets |
| 25–40 | Discover Azure choices and review the target plan | Actual region, SKU, image, cost, and network rules are approved |
| 40–55 | Build the target and connect by SSH | VM identity and restricted SSH access are verified |
| 55–70 | Install dependencies and transfer the application | Target has runtime files but no secret in Git |
| 70–85 | Export, transfer, restore, and compare live data | Source and target SQL content match |
| 85–95 | Run locally on the VM and compare HTTP responses | SSH curl works and browser uses a private tunnel |
| 95–100 | Record evidence, deallocate the VM, and stop Codespace | VM shows deallocated and retained costs are noted |

If provisioning is blocked, record the failed check honestly and continue with
the plan and documentation. Do not claim that a target check passed.

## Know the two systems

Keep the shell location visible in your notes:

| Prompt in this guide | Where commands run | Main purpose |
| --- | --- | --- |
| `[codespace]$` | Portfolio Codespace | Coding agent, Git, Azure CLI, source MySQL, and SSH client |
| `[vm]$` | Azure Ubuntu VM through SSH | Target packages, target MySQL, and target application |
| `mysql>` | MySQL client on the named host | SQL inspection or a deliberate data change |

The bracketed prompts are location labels. Do not type `[codespace]$`, `[vm]$`,
or `mysql>` as part of a command. Each command block below contains only the
text you type.

The preliminary public request path will eventually be:

```text
Browser → Azure public IP and NSG → Nginx :80 → Gunicorn → app → MySQL
```

Thursday's minimum is smaller. The application may run locally on the VM and
answer `curl` through SSH. For browser viewing, use an SSH tunnel. Do not expose
Flask's development server on public port 5000.

The intended network rules are:

| Port | Exposure | When |
| --- | --- | --- |
| SSH 22 | Only the actual public source address used by the Codespace | Today |
| HTTP 80 | Public only when Nginx is ready | Today if completed, otherwise September 22 |
| HTTPS 443 | Public later, with TLS configuration | Later |
| MySQL 3306 | Loopback or private only | Always |
| Application 5000 | Loopback only | Always |

## 1. Sign in and select the subscription

First check whether the Azure CLI is already available:

```bash
az --version
```

If it is missing, use the current Ubuntu instructions at:
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux

Use Microsoft's Ubuntu/Debian installation steps, then repeat the version
check. If installation is blocked, show the instructor the failed step.

Sign in from the Codespace and complete browser authentication:

```bash
az login --use-device-code
az account list --output table
```

Select the Azure for Students subscription by its actual ID, then verify it:

```bash
az account set --subscription "ACTUAL-SUBSCRIPTION-ID"
az account show --output table
```

Do not save a subscription ID copied from another student. It is an identifier,
but it still belongs in your local migration notes rather than source code.

Checkpoint: show the instructor the subscription name and state. Do not create
resources until the target plan has been reviewed.

## 2. Discover the source before planning the target

Start Claude Code or Codex from the repository. Ask it to read `AGENTS.md` and
the saved spec and plan in `docs/superpowers/` before continuing. Keep the same
design, spec, and plan review gates when changing agents.

This guide uses MySQL as its worked example. Tuesday's interview may have
produced a different database engine, database names, or file paths.
This guide uses `portfolio.projects`, `portfolio_reader`, and `application/app.py`
as examples. Have the agent adapt SQL, setup scripts, and startup commands to
your actual implementation, and explain each change before you run it.

Ask your agent to perform read-only discovery:

```text
Use Superpowers to help me migrate this resume application from its Codespace to
one Azure Ubuntu VM. Begin with read-only discovery. Do not install packages,
edit files, stop services, create Azure resources, or expose ports.

Inspect the repository, git status, docs, application requirements, startup
command, environment variable names, listening ports, service status, schema,
and safe row counts. Never display DB_PASSWORD or other credentials. Do not read
private keys. Save a proposed source inventory in docs/migration.md only after I
review it. Separate repository files from runtime state and live MySQL data.
Mark every command with [codespace], [vm], or mysql>.
```

Review each proposed command. The discovery should answer these questions:

- Which commit will be cloned on the target?
- Which Python and package versions does the application need?
- Which services are installed, running, and listening?
- Which database, table, and reader grants must be recreated?
- Which ordinary configuration can be documented?
- Which secrets must be entered privately on the target?
- Which content exists in live MySQL but not in Git?

The Codespace was stopped after Tuesday's lesson. Restart its services before
the read-only checks, then verify the source baseline:

```bash
sudo service nginx start
sudo service mysql start
curl -I http://127.0.0.1/
curl -i http://127.0.0.1:5000/
```

Start the Flask application first if port 5000 is not listening. Record actual
output without credentials. Do not migrate until the source page returns HTTP
200 with the expected MySQL project data.

Before the backup, make one deliberate project edit in source MySQL. Use an
honest project description you wrote, or label it clearly as a migration test
record. Do not present a test record as experience. For example, connect with
the application reader to inspect data, then use the local administrator for the
reviewed `UPDATE` or `INSERT` statement:

```bash
mysql -h 127.0.0.1 -P 3306 -u portfolio_reader -p
```

At `mysql>`, inspect the current rows, then leave the reader session:

```sql
SELECT id, title, description FROM portfolio.projects ORDER BY id;
exit
```

Now open the local administrator client:

```bash
sudo mysql
```

At `mysql>`, run the reviewed `UPDATE` or `INSERT`, select the changed row, and
then run `exit`. Save the chosen title and description in your private evidence.
Do not rerun the seed file. Reseeding would recreate starting data rather than
prove migration of the current data.

Checkpoint: explain the difference among `git clone`, package installation,
secret configuration, schema creation, and live data migration.

## 3. Discover Azure choices and approve a concrete plan

Use read-only Azure CLI commands before choosing a target. Ask your agent:

```text
Propose read-only Azure CLI discovery commands for my selected subscription.
Show the regions available to the subscription, relevant VM SKUs and their
restrictions or quota, and current Canonical Ubuntu images. Do not assume a
region, SKU, image alias, quota, or price. Do not create resources.

After I run the commands, compare only the actual results I provide. Help me
select one region, one small VM SKU, and one exact image URN. Include the current
estimated hourly cost and its source or pricing-calculator evidence. State what
is and is not covered by my student credit. Mark unknowns as unknown.
```

Typical discovery starts with commands such as these. The agent must adjust the
queries to the current CLI output and your subscription:

```bash
az account list-locations --output table
az vm list-skus --location "CANDIDATE-REGION" --resource-type virtualMachines --all --output table
az vm image list --location "CANDIDATE-REGION" --publisher Canonical --all --output table
az vm list-usage --location "CANDIDATE-REGION" --output table
```

The Azure for Students page may list free service quantities, but availability,
quota, and your remaining credit still need account-specific checks.

Ask your agent to produce two reviewed scripts, without running them:

```text
Using my selected values, create scripts/azure-create-target.sh and
scripts/azure-deallocate-target.sh. Use explicit variables for the exact resource
group, VM name, region, SKU, image URN, administrator username, tags, network
names, and SSH public-key path. Do not repurpose HOME.

The create script must stop on error. It must create one tagged resource group
and the reviewed VM and networking resources. It must not use a default rule
that opens SSH to the world. Create SSH access for only the /32 public egress
address actually used by this Codespace. Do not open ports 80 or 443 unless the
plan says Nginx is ready. Never open 3306 or 5000 publicly.

Generate or reference an SSH key outside the repository. Never commit private or
public keys. Show the exact az commands, selected values, estimated cost, and
network rules for my review. Include read-only verification commands. Do not run
either script.

The deallocate script must use az vm deallocate and then query instance view to
show the power state. It must not delete the resource group.
```

Use a dedicated SSH key stored outside the repository, for example
`~/.ssh/isba4775_azure` in the Codespace. Confirm `.ssh` is not inside
`/workspaces/career-platform`.

Find the Codespace's current public egress address with an instructor-approved
public IP check. Use that address with a `/32` suffix in the SSH rule. Your home
IP is wrong when SSH originates in the Codespace. Codespace egress can change,
so a later connection may require a reviewed SSH rule update.

Checkpoint: read the entire create script. Approve only when resource names,
region, SKU, image, cost, tags, SSH key, and every network rule are explicit.

## 4. Build the target and connect

Run the reviewed create script from the Codespace:

```bash
bash scripts/azure-create-target.sh
```

Use its read-only verification commands to record the VM identity, image, size,
public IP, tags, provisioning state, power state, and NSG rules. Compare the
results with the approved plan.

Connect with your named key. Do not disable host-key checking. On the first
connection, compare the displayed fingerprint with Azure's host information or
the instructor's reviewed evidence before accepting it:

```bash
ssh -i ~/.ssh/isba4775_azure AZURE-USER@ACTUAL-PUBLIC-IP
```

If SSH times out, check the current Codespace egress address and the NSG rule.
Do not replace the rule with `0.0.0.0/0`.

On the VM, identify the target before making changes:

```bash
whoami
hostname
pwd
cat /etc/os-release
```

Checkpoint: your notes connect the approved Azure resource identity to the VM
shell. Keep the SSH session open.

## 5. Install the target runtime and clone the code

Ask your agent to prepare a reviewed target setup sequence. It should install the
required Ubuntu packages, start local MySQL, clone the repository, create
`application/.venv/`, and install `application/requirements.txt` for the Flask
example. Adapt the packages to your application and chosen database engine.
Keep the same database engine during this migration.

Run the reviewed commands in the VM shell. The sequence should use the actual
repository URL and a directory owned by the Azure user. Confirm the checked-out
commit matches the source:

```bash
git clone ACTUAL-PUBLIC-REPOSITORY-URL
cd career-platform
git rev-parse HEAD
```

A clone transfers committed files. It does not transfer the source virtual
environment, installed services, environment variables, secrets, or MySQL data.

Create the target schema and read-only account with reviewed copies of the
repository setup files. In the VM's Bash shell, read and export the password
without displaying it, then run the reviewed account script:

```bash
read -rsp 'DB password: ' DB_PASSWORD
printf '\n'
export DB_PASSWORD
python3 scripts/configure-reader.py
```

Do not transmit the value through agent chat or place it in shell history, a
command argument, or a repository file.

For repeated starts, you may use a private runtime configuration outside the
repository. Ask your agent to propose its exact path, owner, `chmod 600` permissions,
and safe loading command without showing the value. Review its Git separation
and access before creating it. Do not use a world-readable file or add it to Git.

Checkpoint: the target has code and dependencies, but its project data should
still differ until the export is restored.

## 6. Export and restore live MySQL data

Back up from the source Codespace after the deliberate project edit. Use an
instructor-reviewed `mysqldump` command that prompts for a password or uses
local administrator access. Never put a password after `-p` or in an argument.
Write the dump outside the repository:

```bash
umask 077
mkdir -p /tmp/isba4775-migration
sudo mysqldump --no-tablespaces --skip-triggers portfolio projects > /tmp/isba4775-migration/portfolio-projects.sql
ls -l /tmp/isba4775-migration/portfolio-projects.sql
```

Inspect the dump without publishing private content. Confirm that it names the
expected database objects and contains the deliberate edit. Do not add the dump
to Git.

Create a private transfer directory on the VM before copying the file:

```bash
mkdir -p ~/migration-private
chmod 700 ~/migration-private
```

In a Codespace terminal, transfer it over the restricted SSH connection:

```bash
scp -i ~/.ssh/isba4775_azure /tmp/isba4775-migration/portfolio-projects.sql AZURE-USER@ACTUAL-PUBLIC-IP:~/migration-private/
```

On the VM, restore into the fresh target and inspect the rows:

```bash
sudo mysql portfolio < ~/migration-private/portfolio-projects.sql
sudo mysql -e 'SELECT id, title, description FROM portfolio.projects ORDER BY id;'
```

The target reader grant remains `SELECT` only on `portfolio.projects`. Recheck
it after restore. Compare source and target row count, IDs, titles, and
descriptions. A matching count alone is not enough.

After evidence is recorded, remove the source dump and target private copy.
They may contain private resume content and are not course deliverables.

Checkpoint: the deliberate source edit appears on the target. Explain why this
proves movement of live data rather than recreation from `schema.sql`.

## 7. Validate the application without public port 5000

Set the ordinary environment variables in the VM shell. Enter `DB_PASSWORD`
privately without displaying it, or load the reviewed permission-restricted
runtime configuration. A new SSH session does not inherit the earlier export,
so repeat the private `read` and `export` sequence when needed. Then run the
reviewed application command with debug and reloader off, bound only to loopback:

```bash
cd ~/career-platform/application
.venv/bin/python -m flask --app app run --host=127.0.0.1 --port=5000 --no-debugger --no-reload
```

From a second SSH session, test on the VM:

```bash
curl -i http://127.0.0.1:5000/
ss -lnt
```

Expect HTTP 200 with the migrated project content. Port 5000 must listen on
`127.0.0.1`, not `0.0.0.0` or the public address.

For browser viewing, create a tunnel from the Codespace to the VM:

```bash
ssh -i ~/.ssh/isba4775_azure -N -L 5001:127.0.0.1:5000 AZURE-USER@ACTUAL-PUBLIC-IP
```

Forward Codespace port 5001 as **Private**, then open its forwarded URL. This
does not create a public Azure rule for port 5000.

Compare these four pieces of evidence:

1. Source SQL rows and target SQL rows.
2. Source HTTP status and target HTTP status.
3. Source page content and target page content.
4. The deliberate project edit on both pages.

Record blocked checks as blocked. Do not rewrite the notes to make a partial
migration appear complete. The source remains available for rollback.

Checkpoint: state which target checks passed and which public path remains for
September 22. Nginx and Gunicorn can be completed then.

## 8. Document, deallocate, and stop

Update `docs/migration.md` with the source inventory and approved target plan.
Include the selected resources, cost estimate, network rules, commands, and
evidence. Record failures, the rollback source, and September 22 work. Keep
secrets, SSH keys, dumps, and private resume content out of Git.

Commit and push the reviewed documentation and scripts from the Codespace. Do
not commit generated credentials, SSH material, or a database dump.

Run the reviewed deallocation script:

```bash
bash scripts/azure-deallocate-target.sh
```

It must run `az vm deallocate`, then query the VM's instance view. Confirm the
power state is `VM deallocated`, not merely `VM stopped`. A stopped, allocated
VM still incurs compute charges. A deallocated VM releases compute allocation,
but retained disks and some networking resources can still cost money:
https://learn.microsoft.com/en-us/azure/virtual-machines/states-billing

Do not delete the resource group at the end of class. The deallocated VM will
not serve the site until you start it again. Final public availability follows
the later Nginx, Gunicorn, systemd, and TLS work.

Stop the portfolio Codespace after recording and pushing the work. Your next
step is to bring `docs/migration.md` to the September 22 operations lab and
start the VM only when you are ready to continue.

## Draft sources and rehearsal note

These sources were checked on September 15, 2026:

- https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-cli
- https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux
- https://azure.microsoft.com/en-us/free/students/
- https://learn.microsoft.com/en-us/azure/virtual-machines/states-billing

No Azure resource was created while drafting this guide. The instructor must
rehearse CLI installation, authentication, discovery, and pricing evidence. The
rehearsal must cover resource creation, exact NSG construction, Codespace egress,
and SSH host verification. It must finish with packages, dump and restore,
tunneling, deallocation, retained costs, and the full 100-minute route.
