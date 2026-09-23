# Migrate your resume site to an Azure VM

Session 07 · September 22, 2026

On Thursday, your resume site ran inside your Codespace. Today we'll move it to
a virtual machine in Azure. A working copy isn't the whole goal. You should be
able to explain what has to move when an application changes computers, and
prove that it moved.

Today you also move off Codespaces. Your laptop becomes the machine you work
from, with Claude Code installed on it. The Codespace stays as the source
system we're migrating away from, and as your rollback copy.

You'll type a few commands today, in the one place it matters: connecting to
the VM and looking around it yourself. Everything else your agent proposes,
and you review before it runs. You don't
need to memorize syntax, but you do need the vocabulary: clone, branch, merge,
SSH, port, backup. Those words are how you tell the agent what you want and
how you check that its command does that. Each step below gives you a prompt
and a short list of what to look for before you approve.

Our worked example is the FastAPI, Uvicorn, and SQLite app our class built.
Your file names may differ a little, and the agent will adapt.

## Before we start

Start your Azure activation first, under "Activate your student credit" in
phase 2, since Microsoft's student verification can take a while. Work through
this section while that runs.

### Check your laptop

You installed Claude Code after Thursday's class. Confirm it runs on your own
machine, since today it does the work that Copilot CLI did in the Codespace.
Open a terminal, run `claude`, and check that it starts and is signed in.

If it doesn't start, install it now. On macOS, in Terminal:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

On Windows 10 or later, in PowerShell:

```powershell
irm https://claude.ai/install.ps1 | iex
```

Windows also needs [Git for Windows](https://git-scm.com/downloads/win). It
supplies the Bash shell Claude Code expects, plus the `git` and `ssh` commands
we use all afternoon. On macOS, running `git --version` once prompts for
Apple's command line tools if you don't have them.

Tell the instructor if sign-in is blocked, before buying anything.

Why the laptop instead of the Codespace? The laptop is the machine you keep.
Codespaces bill by the hour and delete themselves after 30 days of disuse.
Today the Codespace changes role: it stops being where you work and becomes
the old system you're migrating away from.

Sources: https://code.claude.com/docs/en/overview and
https://code.claude.com/docs/en/terminal-guide

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
work is still on a feature branch. That's the deploy step from Thursday's
board: the first deployment clones `main` onto the server. An empty `main`
deploys nothing, so the merge comes before Azure.

Do this in the browser, on github.com, so it doesn't depend on any local
tooling. Open your `career-platform` repository, select Compare & pull
request, create the pull request, read the list of changed files, and merge it.

| Term | What it means |
| --- | --- |
| Branch | A named line of work that doesn't change `main` |
| Pull request | A request to review a branch and merge it |
| Merge | Bring the branch's commits into `main` |

### Get the code onto your laptop

Until now, Codespaces cloned your repository for you. Do it yourself this time,
in VS Code or Cursor on your laptop:

1. Open VS Code or Cursor with no folder open.
2. In the Source Control panel, select Clone Repository. You can also press
   the Command Palette shortcut and type Git: Clone.
3. Choose Clone from GitHub and sign in if you're asked. Pick your
   `career-platform` repository.
4. Choose where it goes, such as a `GitHub` folder in your home folder. The
   clone creates the project folder inside it.
5. Select Open when the editor offers to open it.

Cloning copies the repository and its whole history onto your laptop. The
buttons run `git clone` for you, which is the same command the VM will run in
phase 4 when it gets your code. This folder is now your development machine,
the role your Codespace played last week.

Check the bottom left of the editor. It shows which branch you're on, and it
should say `main`. If it doesn't, your merge didn't land, so go back to
github.com and check.

Open the built-in terminal in that folder and start Claude Code there, so it
works on this project.

### Get the live data off the Codespace

Your database was created by the app while it ran in the Codespace. It's
ignored by Git, so the clone didn't bring it. Fetch it with the browser, no
commands needed:

1. Open your Codespace.
2. In the file explorer, find your database file. Look for a file ending in
   `.db`, probably in a `data` folder under `.worktrees/<branch>/`. Your app
   named it, so it might be `resume.db`, `career_platform.db`, or something
   else.
3. Right-click it and select Download. It lands in your Downloads folder.

If you can't spot it, ask the agent in your Codespace where it is:

```text
Find the SQLite database file this app uses. Tell me its full path and the
DATABASE_URL value the app reads. Don't change anything.
```

Leave the Codespace running for now. It's the source system we compare
against at the end, and it's your rollback if today goes wrong. If it stopped
overnight, start it again and start the app there, so you have a source page
to compare with.

If you can't find a database file, your app may never have created one on
Thursday. Say so to the instructor and keep going. You'll build a fresh one on
the VM in phase 4 instead, and your evidence will say "seed data, not migrated
data." That's an honest result, and the rest of today still works.

Checkpoint: name the two things you just moved to your laptop and where each
one came from. Why did the code come from GitHub and the database from the
Codespace?

## 1. Understand the migration

```text
SOURCE                              TARGET

GitHub Codespace                    Azure VM (Ubuntu Linux)
├── Uvicorn :8000 running FastAPI   ├── Uvicorn :8000   (not yet)
└── data/<your>.db (SQLite file)    └── data/<your>.db  (not yet)

        your laptop, with Claude Code, runs the migration
```

Before touching Azure, answer this: what actually has to move?

| Part of the system | Example in our project | How it gets to the VM |
| --- | --- | --- |
| Application code | `app/`, templates, `pyproject.toml`, `uv.lock` | Clone from GitHub |
| Operating system packages | `git`, `sqlite3` | Install with Ubuntu's package manager |
| Python and its packages | The `.venv` folder built from `uv.lock` | Rebuild with `uv` |
| Configuration | `.env` with `DATABASE_URL` | Recreate from `.env.example` |
| Secrets | None yet, but API keys come later | Enter privately on the VM, never in Git |
| Live data | The `.db` file your app created | Copy over SSH, then check |
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
Students includes $100 of credit for 12 months with no credit card.

Then sign in at https://portal.azure.com. Type "Subscriptions" in the search
box at the top of the page and open it. Your subscription should be listed
with a status of Active, and opening it shows the credit you have left. If you
only see a paid offer, tell the instructor and don't upgrade.

### Make an SSH key

Our VM has no screen and no keyboard. The only way in is SSH, which is the
standard way to run commands on a remote Linux machine. Before we create the
VM, we need a way for it to recognize us.

Azure won't offer a password for an Ubuntu VM by default, and that's on
purpose. Every public IP running SSH gets scanned and guessed at constantly,
and a password can be guessed. So we use a key pair instead.

A key pair is two matching files. The public half is safe to hand out, and it
goes onto the server. The private half stays on your laptop and never moves.
When you connect, SSH proves you hold the private half without sending it. A
guess can't fake that.

Make it now, before the portal, because the portal asks for the public half
while creating the VM. We give it a name of its own, rather than reusing a key
from another service, so this one key can be replaced later without breaking
anything else.

```text
Create an SSH key pair for my Azure VM at ~/.ssh/isba4775_azure, with no
passphrase for today. Show me only the public key. Then tell me this laptop's
public IPv4 address. Wait for my review.
```

| Term | What it means | What the command looks like |
| --- | --- | --- |
| Key pair | A private file and a matching `.pub` file | `ssh-keygen -t rsa -b 4096 -f ~/.ssh/isba4775_azure` |
| Public IP check | Ask an outside service what address you came from | `curl -4 -s https://api.ipify.org` |

The agent should never display the private key, only the `.pub` line. Copy
that line for the portal.

On Windows, `~/.ssh/` means `C:\Users\YOUR-NAME\.ssh\`, which is where
Windows keeps SSH keys too. Claude Code runs commands through Git Bash there,
so the `~` path in these examples works as written. If you type a command into
PowerShell yourself, spell the path out instead, since PowerShell doesn't
always expand `~` for other programs.

Whatever the path, the private key file stays out of your repository. A key
committed to GitHub is a key you have to replace.

The address the agent reports is the campus network's public address. It
should match what the portal's My IP address option shows, since your browser
and your terminal are now on the same machine.

### Create the VM in the portal

This part happens in the browser, so you'll click through it yourself.
Choosing a size and region is real work in a job. The instructor has picked
a combination that deployed on a student subscription, so today we can focus
on the migration.

To get to the form, from https://portal.azure.com:

1. Type "Virtual machines" in the search box at the top and open it.
2. Select Create, then Azure virtual machine.
3. Fill in the Basics tab with the values below. The tabs run across the top
   of the form, so use them to reach Disks and Networking.

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
| OS disk type, on the Disks tab | Standard SSD |
| Delete public IP and NIC when VM is deleted, on the Networking tab | Checked |

Three more tabs are worth a stop before you create anything. Each one is a
default that either costs money or protects you from a mistake:

| Tab | Setting | Value |
| --- | --- | --- |
| Management | Enable auto-shutdown | On, 6:00 PM, and check the time zone |
| Management | Notification before shutdown | Off |
| Monitoring | Boot diagnostics | Disable |
| Tags | Name and value | `course` = `isba-4775`, and `purpose` = `class` |

Auto-shutdown deallocates the VM on a schedule. It's your safety net for the
night you forget, and forgetting is what drains a student credit. The time
zone box defaults to UTC, which is seven hours ahead of us, so set it to
Pacific or your VM will stop mid-afternoon.

Boot diagnostics stores console screenshots in a storage account, which
carries a small charge. We don't need it today, and turning it off is a
reminder that a default you never chose can still bill you.

Tags don't change how anything runs. They label resources so you can find
them, group them, and see what a project costs. On a real subscription with
hundreds of resources, untagged ones are the ones nobody can account for.

Then select Review + create and Create. If the size is unavailable or
deployment fails with `AllocationFailed`, tell the instructor rather than
trying other sizes.

A few of those choices are worth understanding, because you'll make them
yourself later:

- Ubuntu 24.04 LTS. Long term support means security updates for years, which
  is what you want on a server you don't plan to rebuild monthly.
- The smallest size that runs the app. You pay by the hour for CPU and memory,
  and our site serves one visitor at a time today.
- Standard SSD, the cheapest disk Azure still recommends for new machines.
  Standard HDD costs a little less and is being retired, and Premium SSD is
  built for workloads far busier than ours.
- A username that isn't root. Day-to-day work happens as `azureuser`, and
  anything dangerous needs `sudo`, so a mistake has to be deliberate.
- Auto-shutdown on and boot diagnostics off. Both are about money: one stops
  a VM you forgot, and the other declines a service you won't read.

While Azure works, ask your agent what each resource in the diagram does, and
check its answer against the table.

### Open SSH for one address

We chose None for inbound ports so Azure wouldn't create a rule allowing SSH
from anywhere. Now add the one rule we want.

When deployment finishes, select Go to resource. You can also reach the VM
later by searching "Virtual machines" and selecting `vm-career-platform`. In
the menu down the left side of the VM's page, open Networking, then Network
settings. Select Create port rule, then Inbound port rule, and fill it in:

| Field | Value |
| --- | --- |
| Source | IP Addresses, with your laptop's address followed by `/32` |
| Source port ranges | `*` |
| Destination port ranges | `22` |
| Protocol and action | TCP, Allow |
| Priority and name | `300`, `Allow-SSH-Laptop` |

`/32` means exactly one address, so this rule allows your laptop and nothing
else. The source port is `*` because your SSH client picks a random port each
time it connects, while 22 is the port on the server you're reaching.

Why bother, when we already require a key? Because a port open to the Internet
gets found within minutes and attacked continuously, which fills your logs and
burns CPU you're paying for. The key decides who gets in. The rule decides who
gets to try.

| Port | Service | Reachable from | When |
| --- | --- | --- | --- |
| 22 | SSH | Your laptop's address only | Today |
| 8000 | Uvicorn | Open to the Internet for one demonstration, then closed | Briefly, in phase 6 |
| None | SQLite | Nothing, since it's a file | Always |
| 80 and 443 | HTTP and HTTPS through Nginx | The Internet | Later |

This rule is tied to the network you're on. When you go home tonight, your
public address changes and SSH stops working until you update the rule.

Checkpoint: why isn't a resource group a network boundary? Does allowing port
22 start an SSH server?

## 3. Connect to the VM

```text
Your laptop
      │  SSH, TCP port 22
      ▼
Public IP ─▶ network security group: is this source allowed?
      │
      ▼
Azure VM ─▶ sshd ─▶ runs the command as azureuser
```

The VM's Overview page, the first item in its left menu, lists its public IP
address on the right. Copy it, then:

Type this one yourself, in your own terminal, with your VM's address in place
of `PUBLIC-IP`:

```bash
ssh -i ~/.ssh/isba4775_azure azureuser@PUBLIC-IP
```

| Part | What it means |
| --- | --- |
| `ssh` | Open a session on a remote computer, over port 22 |
| `-i ~/.ssh/isba4775_azure` | Prove who you are with this private key |
| `azureuser@` | The account to log in as |
| `PUBLIC-IP` | Which machine to reach |

The first time, SSH asks whether you trust this server, showing a fingerprint.
Type `yes`. Your key proves who you are to the server. The host key is the
reverse: the server's proof of who it is. SSH records it now, so if something
later answers at that address with a different key, you find out instead of
handing your session to an impostor. If SSH ever warns that a known server's
key changed, stop and ask the instructor.

Look at your prompt. It changed, and it now reads something like
`azureuser@vm-career-platform`. You're typing into a computer in a Microsoft
datacenter. Ask it where you are:

```bash
whoami
hostname
pwd
cat /etc/os-release
```

Four answers, all about the VM and none about your laptop. Then leave:

```bash
exit
```

Watch the prompt change back. That's the whole idea: the same terminal window
can be two different computers, and the prompt is how you tell.

Two things carry forward from this. Your laptop has recorded the host key, so
your agent's SSH commands won't stop to ask about it. And the address, user,
and key file are things you now know and your agent doesn't, so phase 4 starts
by telling it.

Three computers are now involved:

| Location | What runs there today |
| --- | --- |
| Your laptop | Your agent, Git, the SSH client, and the browser |
| Your Codespace | The source app and the original database |
| The Azure VM | The target app and its copy of the data |

Checkpoint: you ran `hostname` and got `vm-career-platform`, then ran it again
after `exit` and got your laptop's name. Explain what changed, and what stayed
the same.

From here on, the agent does the work, because phase 4 is a long sequence of
installs where one typo costs you the afternoon. You can keep a terminal
logged into the VM alongside it, to look at what the agent just changed.

If SSH times out, the firewall is probably dropping the connection. Check that
the VM is running, that the agent used its current public IP, and that your
laptop's address still matches the `/32` rule. Switching Wi-Fi networks or
turning on a VPN changes that address. Never widen the rule to Any. If SSH
says `Permission denied`, the connection reached the server, so the username
or key is wrong instead.

## 4. Plan the migration, then rebuild the environment

```text
your plan ─▶ the agent's plan document ─▶ your review ─▶ execute ─▶ record
```

### Write your plan first

Before you ask the agent for anything, take ninety seconds and write your own
plan on paper. Use the five categories from the board, and for each one, say
how you think it gets to the VM:

```text
Code            clone from GitHub
Packages        ?
Python          ?
Configuration   ?
Data            copy my .db file
Running process start it
```

Question marks are fine. The point is to commit to a guess before you see the
agent's answer, because that's what turns reading its plan into checking it.
Without a guess of your own, you'll approve whatever comes back.

### Why a plan, and why not the whole flow

Last week you used Superpowers to build the app: brainstorm, then a spec, then
a plan, then execution. Today we use one part of that, the plan. Brainstorming
and specs resolve unknowns before you build something new, and there are none
here. Your lock file already names the packages, and every project in the
room installs the same way.

A written plan still matters, for three reasons. A deployment is the thing you
don't improvise. A plan with a check and a rollback per step is what a real
change request looks like, and someone else could run it. And the same file
becomes your evidence, since the results get written into it as you go.

Picking the right weight of process is part of the work. The full flow comes
back when we rebuild this VM from a script, because that one has real
decisions in it.

### Ask for the plan

You connected by hand a minute ago, in your own terminal. Your agent wasn't
watching, so it doesn't know the address, the user, or which key to use. Tell
it once, and hand it your plan:

```text
My Azure VM is azureuser@PUBLIC-IP and the SSH key is ~/.ssh/isba4775_azure.
Use those whenever you connect to it today.

Here is my migration plan:
[paste your five lines]

Use your writing-plans skill to turn it into a plan saved as
docs/superpowers/plans/2026-09-24-azure-vm-migration.md. For every step, give
where it runs (laptop, VM, or portal), the command or click, why it's needed,
how we'll verify it, and how we'd undo it. Cover setup, moving
the database, and verification, including a step that opens port 8000 to the
Internet temporarily and a later step that closes it. Two rules: clone from
GitHub, not from this folder, and don't create or seed a database, because my
real one is coming from my laptop. Don't run anything yet.
```

Replace `PUBLIC-IP` with your VM's address from its Overview page.

### Review the document against your list

Open `docs/superpowers/plans/2026-09-24-azure-vm-migration.md`. It sits beside
the plan the agent wrote last week for the app itself, with the same date
prefix, so the folder reads as a history of what was built and when. In
October you'll migrate again, to a different kind of host, and the two plans
won't collide.

Read it with your paper plan beside it, and work through these:

| Look for | Why |
| --- | --- |
| Every category from your list appears | A missing category is a missing piece of the app |
| Steps you didn't predict | Each one is a question to ask before you approve |
| A reason on every step | "Because the agent said so" isn't a reason |
| A check on every step | Otherwise you'll never know whether it worked |
| A rollback on every step | Yours is mostly "the Codespace still has the original" |
| Nothing that builds a database | See below |
| Portal steps marked as portal | The agent can't click for you, so the plan has to say so |

Roughly, the environment steps should be:

| Category | What you should see | Roughly |
| --- | --- | --- |
| Packages | Ubuntu software the project needs | `sudo apt-get install -y git sqlite3` |
| Code | A clone from your GitHub repository | `git clone https://github.com/...` |
| Python | The tool, then the exact versions from the lock file | `uv sync --locked --no-dev` |
| Configuration | A `.env` made from the example | `cp .env.example .env` |

`sudo` appears on the install lines because changing system software needs
administrator rights, and that's a good reason to read them.

One thing that should look odd: the VM clones from your GitHub account without
logging in anywhere. It works because your repository is public, so reading it
needs no account, the same as a stranger opening it in a browser. That was a
deliberate choice, since employers should be able to see your work.

If it were private, the VM would need its own credential, and you'd give it a
deploy key or a token scoped to that one repository. You'd never put your
personal GitHub password or a full-access token on a server. Servers get
compromised, and a credential on one should open as little as possible.

Note also what the VM can't do. Anonymous access is read-only, so nothing on
that machine can push to your repository. Today's only commit, this plan with
its results, gets made from your laptop.

The second rule in the prompt matters more than it looks. Your project can
build its own database from the migration files and the seed script in your
code, and if the agent does that, the VM ends up with a working site full of
starter content. It would look like success. It would prove nothing, because
none of your real data would have moved. If you see `alembic` or a seed step
in the plan, take it out before approving.

Checkpoint: what did the agent add that you didn't predict? Say what each
addition is for, in your own words, before you go on.

### Execute the environment steps

```text
Use your executing-plans skill on the migration plan you just wrote. Run the
environment setup steps only, up to but not including the database. After each step,
write what actually happened into the plan, under that step. Stop when the
setup is done and show me the commit ID on the VM and the one here.
```

The two commit IDs should match. That's how you know the VM has your code,
and not whatever was on `main` last week.

Checkpoint: what arrived with the clone, and what's still missing? Did your
database come with it? Why wasn't the `.venv` folder stored in Git? Its files
were built for one specific machine.

`.env` is ignored by Git, so it never left the Codespace. Today it only holds
the database path. Later, secrets like API keys go in the same kind of file,
entered on the server by hand.

## 5. Move application state

```text
Codespace (source) ──browser download──▶ laptop: Downloads/<your>.db
                                              │  one row changed
                                              │  scp over SSH
                                              ▼
                        VM: the path your .env's DATABASE_URL names
```

This is the part Git can't do. Your plan has steps for it, and before you run
them, check two things in the document.

First, the test row. If we copy the database unchanged, a real migration and a
fresh seed look the same. So the plan should change one row before the file
travels, with a label that says what it is, such as "Migration test,
September 24." Check that the `UPDATE` has a `WHERE` clause naming a single
project. Without one, it changes every row. If the plan doesn't have this
step, ask the agent to add it, using Python through `uv` rather than a
`sqlite3` command your laptop may not have.

Second, the copy target. The app opens only the path in `DATABASE_URL`, so a
file that lands under a different name leaves the app reading an empty
database. The plan's `scp` line should end in the exact path and filename
your `.env` expects. This is the likeliest mistake of the afternoon.

Then:

```text
Run the database steps of the plan: the test row, the copy, the permissions,
and the checks on the VM. Record what happened under each step. Stop before
starting the app.
```

| Term | What it means | What the command looks like |
| --- | --- | --- |
| `scp` | Copy a file over SSH | `scp -i ~/.ssh/isba4775_azure ... azureuser@PUBLIC-IP:...` |
| Integrity check | SQLite verifies the file isn't damaged | `PRAGMA integrity_check`, which prints `ok` |
| Permissions | Only your user can read the file | `chmod 600` |

Your test summary should appear when the agent reads the VM's copy, and the
integrity check should print `ok`. Your Codespace still holds the unedited
original. That's deliberate. It's the rollback in your plan.

Checkpoint: give two reasons Git couldn't move this data.

## 6. Verify the migration

The verification steps in your plan alternate between the agent and the
portal, so run them one at a time. Tell the agent:

```text
Run the verification steps one at a time. Stop after each one, record what
happened, and wait for me, because some of the steps in between are mine to
do in the portal.
```

### Start the app where anyone could reach it

The first step starts Uvicorn on `0.0.0.0`, port 8000, in the background.
`0.0.0.0` means the app accepts connections arriving on any of the VM's
addresses, rather than only from the VM itself. The listening line should
show `0.0.0.0:8000`.

A program you start over SSH normally belongs to that SSH session and dies
when the session ends. `nohup` and the trailing `&` detach it so it keeps
running. That's a stopgap, and a weak one: it won't restart if the app crashes
or the VM reboots. Next week, systemd takes over that job.

The app reads `DATABASE_URL` as a path relative to where it starts, so the
agent should start it from the repository folder. If the page loads with no
content, that's the first thing to check.

The next step tries port 8000 from your laptop, and it times out, even though
the app is listening on every address. The firewall has no rule for 8000.

### Open port 8000, on purpose, briefly

This step is yours. Go back to the VM's Networking, then Network settings, and
add a second inbound port rule, exactly like the SSH one except:

| Field | Value |
| --- | --- |
| Source | Any |
| Destination port ranges | `8000` |
| Priority and name | `310`, `Temp-HTTP-8000` |

Now open `http://PUBLIC-IP:8000` in your browser. Your site is on the
Internet. Try it on your phone with Wi-Fi off, and it works there too, from
any network in the world.

Stop and look at what that took. The app was already running and already
listening. One firewall rule was the whole difference between private and
public. That's the lesson: reachable and running are two separate facts.

Now look at the address bar. It says `http://`, not `https://`, and there's a
warning near it. Everything on this connection travels as plain text, readable
by anyone between your phone and Azure. The port number is there too, which no
real site asks visitors to type.

### Close it again

Also yours. In Network settings, find `Temp-HTTP-8000` in the inbound rules
list, open it, and select Delete. Then reload the page. It hangs and times
out. Nothing about the app changed, and the firewall is the only difference.

Let the agent take the next step, which restarts the app on `127.0.0.1`. Now
there are two independent reasons the public path fails: no rule for 8000,
and an app that only answers to the VM itself. Either one alone would be
enough.

```text
Internet
   │
Public IP
   │
Network security group: port 22 only, from your laptop only
   │
Ubuntu VM
   ├── sshd :22
   └── Uvicorn on 127.0.0.1:8000 ─▶ the .db file
```

Checkpoint: name both things blocking the public request. Which one would you
remove first, and why not the other?

### See it in the browser, privately

The agent's next step opens an SSH tunnel in the background from port 8001 on
your laptop to port 8000 on the VM. It should look like
`ssh -f -N -L 8001:127.0.0.1:8000 ...`. The `-L` connects a port here to a
port there, inside the SSH connection. Open http://localhost:8001 in your
browser. You're looking at the VM's app.

The tunnel isn't getting around the firewall. It travels through port 22, the
one door your `/32` rule opened, and SSH carries the page requests inside that
connection. This is how people reach internal dashboards and admin pages that
should never be public.

Checkpoint: if you deleted the port 22 rule, would the tunnel still work?

### Prove it

Open your Codespace site in another tab, then:

```text
Finish the plan's verification: compare the commit ID in my local clone
against the VM's, confirm the migration test row on the VM, check /health on
both, and compare the projects page content. Put the results in a table at
the end of the migration plan and show it to me.
```

| Check | Source | Target (VM) |
| --- | --- | --- |
| Commit ID | Your local clone, on `main` | Same ID |
| Database integrity | The file you copied | `ok` on the VM |
| Test row | The summary you changed | Same summary |
| Health check | `{"status":"ok"}` in the Codespace | Same on the VM |
| Page content | Codespace forwarded URL | Same content at `localhost:8001` |

The test row is the one row that differs on purpose. Your Codespace holds the
original, and the VM holds the edited copy, which is how you know the VM's
database came from that file rather than from a fresh seed.

If any other row doesn't match, the migration isn't done. Record the
difference rather than guessing why.

### Save the record and shut down

Your plan is now also your evidence: every step, what it was for, what
happened, and the comparison at the end. Read through it once. Then:

```text
Check the migration plan for anything that shouldn't be public, such as my IP
address, key paths, or database contents, and remove it. Then commit it and
push. Stop Uvicorn on the VM and close the SSH tunnel.
```

Read the diff before you approve the commit. This file is the thing you'd hand
to someone else so they could do what you did.

In Network settings, check the inbound rules once more and confirm
`Temp-HTTP-8000` is gone. Leaving it there leaves your site open on plain HTTP
until you notice.

Closing SSH doesn't stop the VM. Open the VM's Overview page, select Stop at
the top, and wait for the status to read Stopped (deallocated). That means
Azure released the CPU and memory, so compute billing stops. The disk and
public IP still cost a little each month.

Auto-shutdown would have caught this tonight, but don't rely on it. Stopping
it yourself is the habit worth having.

Keep the resource group, since we'll use this VM next week. Then stop your
Codespace. It stays saved as the rollback copy of your site.

## What you should be able to explain now

If someone asks about this project in an interview, these are the answers
worth having:

- Which parts of a system Git carries, and which parts it never does.
- Why a running application is more than its code.
- What a virtual machine is, and what you rent when you rent one.
- How a request reaches a server, and what decides whether it's allowed.
- Why the app listens on `127.0.0.1`, and what changed when it didn't.
- Why one firewall rule was the whole difference between private and public.
- How you proved the migration worked, rather than assuming it.
- Why the plan was written before anything ran, and what someone else could
  do with it.

On Thursday we make it public and durable: Nginx in front on port 80, systemd
so the app restarts by itself, and logs when it doesn't. Check your Azure
credit in the portal before then, so you know what today cost.

## If something goes wrong

Give the agent the exact error and ask it to explain before it fixes anything.

| Symptom | What it tells you | Check first |
| --- | --- | --- |
| Claude Code won't start on Windows | It needs a shell | Install Git for Windows, then open a new terminal |
| `git` or `ssh` not found | Your laptop is missing the tools | Git for Windows, or Apple's command line tools |
| The clone asks for a username and password | The repository isn't public, or the URL is the SSH form | Check the repository's visibility, and use the `https://` URL |
| SSH hangs, then times out | Traffic isn't reaching sshd | VM running, current public IP, `/32` source rule |
| `Permission denied (publickey)` | You reached sshd, and the login failed | Username `azureuser` and the key path |
| `UNPROTECTED PRIVATE KEY FILE` | Other accounts can read your key | On macOS, `chmod 600`. On Windows, ask the agent to fix it with `icacls`. |
| `uv: command not found` on the VM | The installer's PATH change isn't loaded | Open a new SSH session or load `~/.local/bin/env` |
| `no such table: projects` | The app is reading an empty or wrong file | Does the copied filename match `DATABASE_URL` in `.env`? |
| `curl` to 127.0.0.1:8000 is refused | Nothing is listening | Is Uvicorn still running on the VM? |
| `localhost:8001` doesn't load | The tunnel is down | The background tunnel process |

If the agent suggests opening port 8000, allowing SSH from Any, or turning off
the firewall to test a guess, say no. Write down the symptom, the evidence,
and your next check instead.

## Sources

- https://code.claude.com/docs/en/overview
- https://code.claude.com/docs/en/terminal-guide
- https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal
- https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview
- https://learn.microsoft.com/en-us/azure/virtual-machines/states-billing
- https://azure.microsoft.com/en-us/free/students/
- https://docs.astral.sh/uv/getting-started/installation/
- https://sqlite.org/cli.html
