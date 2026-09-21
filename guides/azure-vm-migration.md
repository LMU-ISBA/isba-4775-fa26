# Migrate your resume site to an Azure VM

Session 06 · September 22, 2026

This guide is a draft. If a screen or an output doesn't match what you see,
write down what you saw and tell the instructor.

On Thursday, your resume site ran inside your Codespace. Today we'll move it to
a virtual machine in Azure. A working copy isn't the whole goal. You should be
able to explain what has to move when an application changes computers, and
prove that it moved.

You won't type the commands today. Your coding agent will propose them, and
you'll review each one before it runs. You don't need to memorize syntax, but
you do need the vocabulary: clone, branch, merge, SSH, port, backup. Those
words are how you tell the agent what you want and how you check that its
command does that. Each step below gives you a prompt and a short list of
what to look for before you approve.

Our worked example is the FastAPI, Uvicorn, and SQLite app our class built.
Your file names may differ a little, and the agent will adapt.

## Before we start

### Set up your agent

We'll use Claude Code. Installing it is the one command you'll type yourself,
since an agent can't install itself. In your Codespace terminal:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Open a new terminal, run `claude` from your `career-platform` folder, and
follow the sign-in steps. Claude Code needs an eligible plan. Tell the
instructor if access is blocked before buying anything. Copilot CLI works for
every prompt below too.

Source: https://code.claude.com/docs/en/quickstart

### Use the same loop for every step

```text
ASK → UNDERSTAND → REVIEW → EXECUTE → VERIFY
```

Every prompt in this guide ends by asking the agent to wait for your review.
When it proposes a command, ask about any part you can't explain. Approve it
only when you can say what it will change and where it will run. Then check
the result yourself.

Don't prompt "deploy my application." Your agent may have written a
`deploy/README.md` that sets up Nginx, HTTPS, and systemd and opens public
ports. That's a later lesson. Today every port stays closed except SSH from
one address.

### Merge Thursday's work

The VM will copy your code from the `main` branch on GitHub, and Thursday's
work is still on a feature branch.

```text
My work is on a feature branch that was pushed to GitHub but never merged.
Open a pull request into main, show me the changed files, and merge it after
I approve. Then switch this Codespace to main and pull the latest changes.
Also find my SQLite database file and tell me its full path.
Propose each command and wait for my review.
```

Look for these before you approve:

| Term | What it means | What the command looks like |
| --- | --- | --- |
| Pull request | A request to review a branch and merge it | `gh pr create` |
| Merge | Bring a branch's commits into `main` | `gh pr merge` |
| Switch | Move this folder to another branch | `git switch main` |
| Pull | Download commits from GitHub into this folder | `git pull` |

The database probably lives inside `.worktrees/`, since the agent built the
app in a separate worktree. Write down the path, because this file is your
live data. If the agent can't reach GitHub, merge the pull request on
github.com with Compare & pull request instead.

If your page looked unstyled on Thursday or its links pointed to
`localhost:8000`, fix that before merging:

```text
My page links and stylesheet use absolute URLs built from the request host,
so they break behind a forwarded port. Change them to relative paths.
Show me the diff before committing.
```

## 1. Understand the migration

```text
SOURCE                              TARGET

GitHub Codespace                    Azure VM (Ubuntu Linux)
├── Uvicorn :8000 running FastAPI   ├── Uvicorn :8000   (not yet)
└── data/resume.db (SQLite file)    └── data/resume.db  (not yet)
```

Before touching Azure, answer this: what actually has to move?

| Part of the system | Example in our project | How it gets to the VM |
| --- | --- | --- |
| Application code | `app/`, templates, `pyproject.toml`, `uv.lock` | Clone from GitHub |
| Operating system packages | `git`, `sqlite3` | Install with Ubuntu's package manager |
| Python and its packages | The `.venv` folder built from `uv.lock` | Rebuild with `uv` |
| Configuration | `.env` with `DATABASE_URL` | Recreate from `.env.example` |
| Secrets | None yet, but API keys come later | Enter privately on the VM, never in Git |
| Live data | `data/resume.db` | Back up, copy over SSH, and check |
| Running process | Uvicorn | Start it on the VM |

Git moves one row of that table. Everything else gets rebuilt, recreated, or
copied another way, which is why migrating an application isn't the same as
cloning its repository.

There's no database server to install. SQLite isn't a service listening on a
port. It's a library inside Python that reads and writes one file, so the
whole database travels as that file. Your repository ignores `*.db` on
purpose. The file changes whenever content changes, and it can hold private
information.

Ask your agent to check your understanding against your actual project:

```text
Read my repository and explain what would have to move for this app to run
on a new Ubuntu server. Separate what Git carries from what it doesn't.
Don't change anything.
```

Checkpoint: in your own words, what does Git move, and what doesn't it move?
Where did the agent's answer differ from the table?

## 2. Create the destination

```text
Azure subscription (your student credit)
└── Resource group: rg-career-platform
    └── Virtual machine: vm-career-platform
        ├── Ubuntu Linux disk
        ├── Network interface with a private IP
        ├── Public IP
        └── Network security group (the firewall rules)
```

Every cloud provider has these pieces under different names:

| Azure name | General idea | Elsewhere |
| --- | --- | --- |
| Virtual machine | A computer made from a slice of a physical server | AWS EC2, Google Compute Engine |
| Resource group | A folder for related resources, useful for cleanup | AWS tags, Google Cloud projects |
| Public IP | An address reachable from the Internet | Any cloud or home router |
| Network security group | A cloud firewall with allow and deny rules | AWS security groups |
| SSH | Remote administration of a Linux server | Every Linux server |

### Activate your student credit

Redeem Microsoft Azure in the
[GitHub Student Developer Pack](https://education.github.com/pack). Azure for
Students includes $100 of credit for 12 months with no credit card. Sign in at
https://portal.azure.com, open Subscriptions, and confirm yours is Active. If
you only see a paid offer, tell the instructor and don't upgrade.

### Make an SSH key and find your address

An SSH key has two halves. The public half goes to the server, and the private
half stays with you to prove who you are. The agent will run SSH from the
Codespace, so the key belongs there.

```text
Create an SSH key pair for my Azure VM at ~/.ssh/isba4775_azure, outside
this repository, with no passphrase for today. Show me only the public key.
Then tell me this Codespace's public IPv4 address. Wait for my review.
```

Look for these before you approve:

| Term | What it means | What the command looks like |
| --- | --- | --- |
| Key pair | A private file and a matching `.pub` file | `ssh-keygen -t rsa -b 4096 -f ~/.ssh/isba4775_azure` |
| Public IP check | Ask an outside service what address you came from | `curl -4 -s https://api.ipify.org` |

The agent should never display the private key, only the `.pub` line. Copy
that line and the address for the portal. Don't use the portal's My IP
address option. It reports your laptop's address, because the browser runs
on your laptop, but SSH will come from the Codespace.

### Create the VM in the portal

This part happens in the browser, so you'll click through it yourself.
Choosing a size and region is real work in a job. The instructor has picked
a combination that deployed on a student subscription, so today we can focus
on the migration.

| Portal field | Value |
| --- | --- |
| Resource group | Create new: `rg-career-platform` |
| Virtual machine name | `vm-career-platform` |
| Region | (US) West US 2 |
| Availability options | No infrastructure redundancy required |
| Image | Ubuntu Server 24.04 LTS, x64 Gen2 |
| Size | `Standard_B2ts_v2`, 2 vCPUs, 1 GiB memory |
| Authentication type | SSH public key, username `azureuser` |
| SSH public key source | Use existing public key, and paste your `.pub` line |
| Public inbound ports | None |
| OS disk type, on the Disks tab | Standard HDD |
| Delete public IP and NIC when VM is deleted, on the Networking tab | Checked |

Leave the other tabs alone, then select Review + create and Create. If the
size is unavailable or deployment fails with `AllocationFailed`, tell the
instructor rather than trying other sizes. While Azure works, ask your agent
what each resource in the diagram does, and check its answer against the table.

### Open SSH for one address

We chose None for inbound ports so Azure wouldn't create a rule allowing SSH
from anywhere. Now add the one rule we want. Open the VM, select Networking,
and add an inbound port rule:

| Field | Value |
| --- | --- |
| Source | IP Addresses, with your Codespace address followed by `/32` |
| Source port ranges | `*` |
| Destination port ranges | `22` |
| Protocol and action | TCP, Allow |
| Priority and name | `300`, `Allow-SSH-Codespace` |

`/32` means exactly one address. The source port is `*` because the SSH
client picks a random port each time, and 22 is the service you're reaching.

| Port | Service | Reachable from | When |
| --- | --- | --- | --- |
| 22 | SSH | Your Codespace address only | Today |
| 8000 | Uvicorn | Only the VM itself, at `127.0.0.1` | Always |
| None | SQLite | Nothing, since it's a file | Always |
| 80 and 443 | HTTP and HTTPS through Nginx | The Internet | Later |

Checkpoint: why isn't a resource group a network boundary? Does allowing port
22 start an SSH server?

## 3. Connect to the VM

```text
Agent in the Codespace
      │  SSH, TCP port 22
      ▼
Public IP ─▶ network security group: is this source allowed?
      │
      ▼
Azure VM ─▶ sshd ─▶ runs the command as azureuser
```

Copy the public IP from the VM's Overview page, then:

```text
My Azure VM's public IP is PUBLIC-IP and the user is azureuser. Using the key
at ~/.ssh/isba4775_azure, connect over SSH and run whoami, hostname, pwd, and
show the operating system version. Explain which parts of your command run in
the Codespace and which run on the VM. Wait for my review.
```

Look for these before you approve:

| Term | What it means | What the command looks like |
| --- | --- | --- |
| SSH | Run commands on a remote computer over port 22 | `ssh -i ~/.ssh/isba4775_azure azureuser@PUBLIC-IP` |
| Remote command | The part in quotes runs on the VM, not here | `'whoami; hostname'` |
| Host key | The server's identity, saved on first connection | `-o StrictHostKeyChecking=accept-new` |

The host-key option is the agent's way of answering "yes, trust this server"
the first time. If SSH ever warns that a known server's key changed, stop and
ask the instructor.

The hostname should be `vm-career-platform`. From here on, three computers are
involved:

| Location | What runs there today |
| --- | --- |
| Your laptop | Only the browser |
| Your Codespace | The source app, your agent, Git, and the SSH client |
| The Azure VM | The target app and its copy of the data |

Checkpoint: the agent ran `hostname` and got `vm-career-platform`. Where did
that command actually run, and how do you know?

If SSH times out, the firewall is probably dropping the connection. Check that
the VM is running, that the agent used its current public IP, and that your
Codespace address still matches the `/32` rule. A restarted Codespace can get
a new address, so update the rule to the new `/32`. Never widen it to Any. If
SSH says `Permission denied`, the connection reached the server, so the
username or key is wrong instead.

## 4. Rebuild the application environment

```text
install Linux packages ─▶ clone ─▶ install uv and packages ─▶ recreate .env
```

Why can't we just clone the repository and be finished? Look back at the
phase 1 table before you continue.

```text
On the VM, over SSH: install git and sqlite3, clone my career-platform
repository from GitHub, install uv, and build the Python environment from the
lock file without dev dependencies. Create .env from .env.example and create
the data folder. Don't run alembic or the seed script, since the real data is
coming from the Codespace. Then show me the commit ID on the VM and on main in
this Codespace. Propose the commands and wait for my review.
```

Look for these before you approve:

| Term | What it means | What the command looks like |
| --- | --- | --- |
| Package manager | Ubuntu's app store for the command line | `sudo apt-get install -y git sqlite3` |
| `sudo` | Run as administrator, needed to install software | `sudo ...` |
| Clone | Copy a repository and its history from GitHub | `git clone https://github.com/...` |
| Lock file | The exact package versions the Codespace tested | `uv sync --locked --no-dev` |
| Commit ID | A fingerprint for one exact version of the code | `git rev-parse HEAD` |

Check that the two commit IDs match. Matching IDs prove the code is the same.

Checkpoint: what arrived with the clone, and what's still missing? Did your
database come with it? Why wasn't the `.venv` folder stored in Git? Its files
were built for one specific machine.

`.env` is ignored by Git, so it never left the Codespace. Today it only holds
the database path. Later, secrets like API keys go in the same kind of file,
entered on the server by hand.

The prompt tells the agent to skip `alembic` and the seed script because they
would build a fresh database from the seed content in your code. We want the
real one, including anything that changed after seeding. If the agent tries
to run them anyway, stop it.

## 5. Move application state

```text
Codespace: data/resume.db
      │  backup makes a consistent copy
      ▼
/tmp/migration/resume.db
      │  scp copies it over SSH
      ▼
VM: ~/career-platform/data/resume.db
      │  integrity check and a query
      ▼
Same data, new computer
```

### Change something first

If we copy the database unchanged, a real migration and a fresh seed look the
same. So change one row in the source first:

```text
In my SQLite database in this Codespace, show me my projects. Then change one
project's summary to "Migration test, September 22" so I can prove the data
moved. Show me the SQL before running it.
```

The agent should propose a `SELECT` to read rows and an `UPDATE` to change one.
Check that the `UPDATE` has a `WHERE` clause naming a single project. Without
one, it changes every row. Reload your Codespace site and confirm the change
shows. The label makes clear it's a test, not experience.

### Back up, copy, and check

```text
Make a consistent backup of my SQLite database in /tmp/migration, outside the
repository, and check its integrity. Copy it over SSH to
~/career-platform/data/resume.db on the VM, restrict it to my user, check its
integrity there, and show my projects from the VM's copy. Then delete the
Codespace copy. Wait for my review.
```

Look for these before you approve:

| Term | What it means | What the command looks like |
| --- | --- | --- |
| Backup | A complete copy, even if the app is writing | `sqlite3 data/resume.db ".backup '/tmp/migration/resume.db'"` |
| Integrity check | SQLite verifies the file isn't damaged | `PRAGMA integrity_check`, which prints `ok` |
| `scp` | Copy a file over SSH | `scp -i ~/.ssh/isba4775_azure ... azureuser@PUBLIC-IP:...` |
| Permissions | Only your user can read the file | `chmod 600` |

A plain `cp` could catch the file halfway through a write. `.backup` can't.
Your test summary should appear in the VM's copy.

Checkpoint: give two reasons Git couldn't move this data.

## 6. Verify the migration

```text
On the VM, start Uvicorn for my app on 127.0.0.1 port 8000 so it keeps
running after your command returns. Then, over SSH, check /health, search
the projects page for "Migration test", and show which address port 8000 is
listening on. Wait for my review.
```

Look for these before you approve:

| Term | What it means | What the command looks like |
| --- | --- | --- |
| Loopback | `127.0.0.1`, reachable only from the VM itself | `--host 127.0.0.1 --port 8000` |
| Background process | Keeps running after SSH disconnects | `nohup ... &` |
| Listening sockets | Which ports are open, and on which address | `ss -lnt` |

On Thursday the app used `--host 0.0.0.0` so Codespaces could forward the
port. Here, `127.0.0.1` means only programs on the VM can connect. The
listening address should show `127.0.0.1:8000`, not `0.0.0.0:8000`. Running
the app in the background with `nohup` is a stopgap. On Thursday, systemd
takes over that job.

Now test from outside the VM:

```text
From this Codespace, not over SSH, try to reach port 8000 on the VM's public
IP with a 5-second timeout. Tell me what happened and why.
```

It should time out.

```text
Internet
   │
Public IP
   │
Network security group: port 22 only, from your Codespace only
   │
Ubuntu VM
   ├── sshd :22
   └── Uvicorn on 127.0.0.1:8000 ─▶ data/resume.db
```

Checkpoint: why does the request work from inside the VM and fail from the
Codespace? Name both things blocking it.

### See it in the browser

```text
Open an SSH tunnel in the background from Codespace port 8001 to port 8000
on the VM, so I can view the app without opening a public port.
Wait for my review.
```

The agent should propose `ssh -f -N -L 8001:127.0.0.1:8000 ...`. The `-L`
connects a port here to a port there, inside the SSH connection. Open the
Ports tab, forward `8001` if it isn't listed, keep it Private, and open it.
You're looking at the VM's app.

### Prove it

```text
Start my app in this Codespace from the folder that holds the source
database. Then compare source and target: commit ID, database integrity,
the migration test row, the /health response, and the projects page content.
Show the results as a table.
```

| Check | Source (Codespace) | Target (VM) |
| --- | --- | --- |
| Commit ID | Recorded | Same ID |
| Database integrity | `ok` | `ok` |
| Test row | The migration test summary | Same summary |
| Health check | `{"status":"ok"}` | Same |
| Page content | Projects page | Same content on port 8001 |

Compare the agent's table with what you see in the browser. If any row doesn't
match, the migration isn't done. Record the difference rather than guessing
why.

### Record your evidence and shut down

```text
Write docs/migration.md with the resource names, region, and size, my "what
moves" table, the comparison results, and anything that failed. Leave out my
IP address, keys, and database contents. Show it to me before committing,
then commit and push.
```

Read the file before you approve the commit. Then:

```text
Stop Uvicorn on the VM and close the SSH tunnel.
```

Closing SSH doesn't stop the VM. In the portal, select Stop and wait for
Stopped (deallocated). That means Azure released the CPU and memory, so
compute billing stops. The disk and public IP still cost a little each month.
Keep the resource group, since we'll use this VM on Thursday. Then stop your
Codespace. It stays saved as the rollback copy of your site.

## If something goes wrong

Give the agent the exact error and ask it to explain before it fixes anything.

| Symptom | What it tells you | Check first |
| --- | --- | --- |
| SSH hangs, then times out | Traffic isn't reaching sshd | VM running, current public IP, `/32` source rule |
| `Permission denied (publickey)` | You reached sshd, and the login failed | Username `azureuser` and the key path |
| `uv: command not found` | The installer's PATH change isn't loaded | Open a new SSH session or load `~/.local/bin/env` |
| `no such table: projects` | The app is reading an empty or wrong file | `DATABASE_URL` in `.env`, and the file you copied |
| `curl` to 127.0.0.1:8000 is refused | Nothing is listening | Is Uvicorn still running on the VM? |
| Tunnel page doesn't load | The tunnel or port forward is down | The background tunnel and the Ports tab |

If the agent suggests opening port 8000, allowing SSH from Any, or turning off
the firewall to test a guess, say no. Write down the symptom, the evidence,
and your next check instead.

## Sources

- https://code.claude.com/docs/en/quickstart
- https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal
- https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview
- https://learn.microsoft.com/en-us/azure/virtual-machines/states-billing
- https://azure.microsoft.com/en-us/free/students/
- https://docs.astral.sh/uv/getting-started/installation/
- https://sqlite.org/cli.html
