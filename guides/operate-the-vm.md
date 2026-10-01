# Operate your site on the VM

Session 10 · October 1, 2026

On Tuesday your site ran on the VM, and a temporary rule for port 8000 put it
on the Internet. It ran because the agent started it by hand, and nothing
would bring it back after a crash or a restart. Today it becomes a real
service. Nginx becomes the front door on port 80, Uvicorn runs the app behind
it with two workers, and systemd keeps the app running and brings it back
after a restart. You'll also point your domain at the VM through Cloudflare.

By the end of class, `http://yourname.com` shows your site with your own
data, with no port number. It survives a VM restart without anyone logging in.
Your plan file doubles as your evidence, the same as Tuesday.

## 0. Before we start

### Check your domain and Cloudflare account

You had two things to do before class: register a domain and create a
Cloudflare account. Section 1 uses both, so check them first.

1. Sign in to Namecheap and open Domain List. Your domain should be listed,
   with its expiration date about a year from now.
2. Sign in at https://dash.cloudflare.com. You should land on your account's
   home page. Don't add the domain yet, since that's section 1.

If either one is missing, do it now with
[Register your domain](register-a-domain.md). The domain takes about ten
minutes, and the Cloudflare account takes two. If checkout gets stuck, tell
me, start on section 2, and come back to section 1 once the domain shows up in
Namecheap.

### Start your VM

If you didn't finish Tuesday's migration, finish sections 5 and 6 of
[Migrate your site to an Azure VM](azure-vm-migration.md) first. Everything
below assumes your data is on the VM.

1. In the [Azure portal](https://portal.azure.com), open your VM's Overview
   page and check its status. If it says Stopped (deallocated), select Start. If it says Running, it's
   been on since Tuesday and spending your credits. Select Stop, wait for
   Stopped (deallocated), and then select Start. Section 2 needs a VM that
   was fully off.
2. Open your VM's Networking, then Network settings, and delete the
   `Temp-HTTP-8000` rule if it's still there. That rule was for Tuesday's
   test only, and port 8000 stays closed from here on.
3. Open a terminal on your laptop and connect, the same way as Tuesday:

   ```text
   ssh -i ~/.ssh/isba4775_azure azureuser@PUBLIC-IP
   ```

   If it hangs, your laptop's address probably changed since Tuesday, because
   you're on a different network. Update the source address on the SSH rule
   in the portal to your current IP, and try again.
4. Start a new Claude Code session in your `career-platform` folder on your
   laptop. Today's plan is new, and the agent can find your VM on its own.

   If Tuesday's session is still open, name it as you leave it, so you can
   find it later with `/resume`:

   ```text
   /clear azure-vm-migration
   ```

   That saves Tuesday's conversation under the name `azure-vm-migration` and
   starts a new, empty one. If Claude Code isn't open, start it with `claude`
   instead. Either way, name today's session:

   ```text
   /rename operate-the-vm
   ```

   A named session is easy to find in the `/resume` list, the same way a
   named file is easy to find in a folder.

## 1. Start the DNS change first

Changing a domain's name servers can take anywhere from minutes to a day to
spread. Start it now, so it can finish while you work on the VM. The rest of
this section waits in the background until section 7.

```text
Your browser ─▶ resolver ─▶ .me or .com servers: "ask Cloudflare"
                                   │
                                   ▼
                  Cloudflare: "yourname.com is PUBLIC-IP" ─▶ your VM
```

Two companies are involved, and they do different jobs. Namecheap is your
registrar. It records that you own the name, and it tells the .com or .me
servers which name servers answer for it. Cloudflare is your DNS host. Its
name servers are the computers that hold your domain's records and answer
when anyone looks it up. Pointing the registrar at a different DNS host is
called delegation.

### Add the domain to Cloudflare

1. Sign in at https://dash.cloudflare.com, select Domains in the left
   sidebar, and then select Add domain. Skip Buy domain, since yours is
   already registered at Namecheap.
2. Enter your domain without `www`, such as `yourname.com`, and let
   Cloudflare scan for existing records.
3. Choose the Free plan.
4. Review the records Cloudflare imported. Namecheap parks new domains on a
   placeholder page, so you may see records pointing at Namecheap. Delete
   anything you can't explain.
5. Add two records, both with the proxy status set to DNS only, which shows
   a gray cloud:

   | Type | Name | IPv4 address | Proxy status |
   | --- | --- | --- | --- |
   | A | `@` | your VM's public IP | DNS only |
   | A | `www` | your VM's public IP | DNS only |

   An A record points a name at an IPv4 address, the four-number kind your
   VM has. `@` means the domain itself. DNS only means Cloudflare answers
   with your VM's address and stays out of the traffic. With the orange cloud,
   visitors would connect to Cloudflare instead of your VM, and Tuesday's
   HTTPS lesson depends on them reaching your server.
6. Cloudflare shows you two name servers, with names like
   `ada.ns.cloudflare.com`. Leave that page open.

Your public IP has to stay the same for these records to keep working. Azure
gives new VMs a Standard public IP, which is static, meaning it doesn't
change, so it survives a deallocation. Check it on the VM's Overview page,
under the public IP's settings, where the assignment should say Static.

### Point Namecheap at Cloudflare

1. Sign in to Namecheap, select Domain List, and click Manage next to your
   domain.
2. In the Nameservers section, choose Custom DNS from the drop-down.
3. Enter Cloudflare's two name servers exactly as shown, then click the green
   checkmark to save.

DNSSEC is a security feature that signs your domain's answers so nobody can
fake them. Namecheap made those signatures, so if it stays on, Cloudflare's
answers won't match and your domain can stop working. If Namecheap shows
DNSSEC turned on for your domain, turn it off before you switch.

From here on, your DNS records live in Cloudflare. Namecheap's Advanced DNS
tab no longer affects anything.

Cloudflare emails you when the domain is active. Don't wait for it. Go on to
section 2.

Checkpoint: which company would you contact if your domain expired, and which
one if your records were wrong?

## 2. What stopped when the VM did

Your VM was deallocated, and you started it again just now. Before you
look, predict: is your site running on the VM right now? Are your code and
your database still there?

In your SSH terminal, check both:

```text
curl -sS http://127.0.0.1:8000
ls ~/career-platform
```

Use your own folder name if it's different. The files are all there, and the
`curl` is refused, because nothing is listening. The disk kept everything
that was written to it. A process is a program while it's running. Your
app's process lived in memory, which empties when the VM turns off, and
nothing told the VM to start it again. An app started by hand keeps running
only until something stops it. A crash or a restart ends it for good.

That's the problem for today. A program that should always be running, like
your site, is called a service. A service has to start at boot, restart when
it crashes, and keep logs you can read afterward. On Linux, systemd is the
program that manages services. It's the first program Ubuntu starts at boot,
and it starts everything else.

Type `exit` to leave the VM. The agent does the rest.

## 3. Plan it, then read the plan

### Write yours first

Take ninety seconds, like Tuesday, and answer this on paper. What has to be
true for your site to answer at `http://PUBLIC-IP`, with no port number, and
come back on its own after a crash or a restart? List what you think has to
happen, in order. Don't worry about program names yet.

### Ask for the plan

This time you describe what the site has to do, and the agent decides how.
You don't need to give it your VM's details, because it's signed in to the
Azure CLI and can look them up.

```text
My site runs on my Azure VM. Use the Azure CLI to find it and how to SSH in.
If you find more than one VM, ask me which one.

Right now my site runs only when someone starts it by hand, and it's gone
after a crash or a restart. I want it to run like a real website:
- Visitors reach it at http://PUBLIC-IP, with no port number.
- It starts on its own when the VM boots, and comes back if it crashes.
- One crash inside the app doesn't take the whole site down.
- Port 8000 stays closed to the Internet.
- The app doesn't run as root.
I'll change the Azure firewall myself in the portal. Don't change anything
in Azure. If you create a service, name it career-platform.

Use your writing-plans skill to write
docs/superpowers/plans/2026-10-01-operate-the-vm.md. At the top, list the
VM, resource group, public IP, user, and SSH key you found. Then write one
section for each job. Start each section with a short explanation for a
beginner: what the piece is, why my site needs it, and what would break
without it. Then list the steps with where each runs (laptop, VM, or
portal), what to run or click, how we check it worked, and how we undo it.
End with a section that restarts the VM and proves the site comes back. As
each section finishes, write what ran and what the checks showed under it.
Don't run anything yet.
```

The agent will run `az` commands to find your VM. Those only read, so approve
them. If `az` asks you to sign in, run `az login` and try again.

The line about writing results under each section matters today, for a
reason you'll see in section 4.

### Read the plan

Check the top first. The VM, resource group, and public IP should match what
the portal shows. If they don't, tell the agent before anything else.

Then answer these from your plan, in your own words. If the plan doesn't
answer one, ask the agent to add it.

| Question | Why it matters |
| --- | --- |
| Which program faces the Internet, and on which port? | That's the only thing visitors should reach |
| Which address and port does your app listen on? | If it's `0.0.0.0`, anyone who can reach the VM can skip the front door |
| What starts the app when the VM boots? | Without it, you're back to starting it by hand |
| What brings it back after a crash? | Starting at boot and restarting after a crash are two different settings |
| What keeps one crash from taking the whole site down? | Your prompt asked for it, so find where the plan answers it |
| Which user runs the app? | Root is the administrator account that can change anything. If someone broke into your app, you want them stuck with less. |
| Which folder does the app start in? | Your app finds `.env` and your database from there. Tuesday's demo profile comes back if it starts somewhere else. |
| Which steps happen in the portal? | Those are yours. The agent shouldn't touch Azure. |
| How does the last section prove the site came back? | You're proving it, not assuming it |

One check has no room for discussion: no step opens port 8000. If one does,
tell the agent to take it out.

### Compare it with this

Most agents land on something close to this. If yours chose different
programs, that's fine. Say what each of your pieces does and which row below
it matches.

```text
Internet
   │
Public IP
   │
Network security group: 22 from your laptop, 80 from anyone
   │
Ubuntu VM
   ├── sshd :22
   ├── Nginx :80 ──▶ Uvicorn on 127.0.0.1:8000 ─▶ the .db file
   │                    (two workers, kept running by systemd)
```

Port 8000 never opens to the Internet. Nginx is the only thing visitors
reach, and it passes each request to Uvicorn on 127.0.0.1. That's the
loopback address, which a computer uses to talk to itself, so nothing outside
the VM can reach Uvicorn directly. When one program takes every request and
hands it to another like this, it's called a reverse proxy.

Four programs share the work. Picture a restaurant:

| Program | Its job | In a restaurant |
| --- | --- | --- |
| Nginx | Takes every request from the Internet and passes it to your app | The host at the front door, who greets guests and seats them |
| Uvicorn's main process | Starts the workers, and replaces any that die or get stuck | The kitchen manager |
| Uvicorn's workers | Run your Python app and answer requests | The cooks |
| systemd | Starts Uvicorn when the VM boots, and starts it again if it crashes | The building manager, who unlocks the doors every morning |

A worker is a process that does the actual work of answering requests. With
`--workers 2`, Uvicorn runs one main process and two workers. If one worker
crashes, the other keeps answering while the main process replaces it, the
way a kitchen keeps cooking when one cook walks out.

Nginx sits in front because it's built to face the Internet. It deals with
slow connections and malformed requests before they reach Python, and it's
where HTTPS goes on Tuesday.

Your plan will probably create these files:

| Piece | Where it lives | Roughly |
| --- | --- | --- |
| The app | Already in your repository | `.venv/bin/uvicorn` with `--host 127.0.0.1 --port 8000 --workers 2` |
| The service | `/etc/systemd/system/career-platform.service` | `ExecStart=` runs that same command |
| The front door | `/etc/nginx/sites-available/`, linked into `sites-enabled/` | `listen 80` and `proxy_pass http://127.0.0.1:8000;` |

A few words you'll see in the plan:

- A unit, or unit file, is the short settings file that tells systemd what
  to run, which folder to start in, and what to do if it stops.
- `systemctl` is how you give systemd commands, as in
  `systemctl start career-platform`. `start` runs a service now, and `enable`
  makes it start at every boot.
- `Restart=` is the line in the unit that brings the app back after a crash.
- `sites-available` holds every site Nginx knows about, and `sites-enabled`
  holds links to the ones it actually serves. Nginx comes with a sample
  welcome site that should be disabled, or visitors see it instead of yours.
- `proxy_pass` is the line that hands each request to Uvicorn.
- A reload makes Nginx reread its settings without stopping. `nginx -t`
  checks the settings first, so a typo can't take the site down.

Checkpoint: compare the plan with what you wrote on paper. What did the agent
add that you didn't predict? Say what each addition is for, in your own words.

## 4. Build it one section at a time

Approve the plan and start the first section, the same way as Tuesday:

```text
The implementation plan looks good. Let's work on the first section using
inline execution in this session.
```

After each section, read what the agent reports, then say "Let's work on the
next section." Stop before any firewall step, since the firewall is yours. Use
the pauses for these:

| After | Look at | Answer this |
| --- | --- | --- |
| The app runs by hand | `ps -ef \| grep uvicorn` | Which line is the main process, and how can you tell? |
| The service is set up | `systemctl status career-platform` | What's the difference between `enable` and `start`? |
| The front door is set up | `curl -I http://localhost` on the VM | Which program answered, Nginx or Uvicorn? The `Server:` header says one, but both did. |

`ps -ef` lists every running process, and `grep uvicorn` keeps only the lines
that mention Uvicorn. In that list, PID is a process's ID number, which Linux
gives every running process, and PPID is the ID of the process that started
it. `curl -I` asks for only the headers, the short labels at the top of a
response, like `Server:`.

Stay in manual mode through the first section so you can read each command.
After that, press Shift+Tab for auto mode if you're keeping up.

### A pause: what the agent remembers

Do this after the service is set up, before the front door.

1. Ask the agent: "What's my VM's public IP, and which section of the plan are
   we on?" It knows both.
2. Type `/clear`. That erases the conversation.
3. Ask the same question again.
4. Then ask: "Read @docs/superpowers/plans/2026-10-01-operate-the-vm.md.
   Where are we, and what's next?"

Before step 3, predict what it will say. Before step 4, predict whether the
plan file will be enough to get it back on track. Watch how it answers in step
3. It may look up the IP again with the Azure CLI, but no command can tell it
which section you're on.

Checkpoint: which answer came from a tool, and which came from the file? How
is the file like what survived the VM restart in section 2?

## 5. Open the front door

Nginx is listening on port 80, but the network security group still drops
everything except SSH. Predict what `http://PUBLIC-IP` shows right now, then
open it in a new browser tab. It hangs, then times out.

In the portal, open your VM's Networking, then Network settings, and add an
inbound port rule like the SSH one, with these changes:

| Field | Value |
| --- | --- |
| Source | Any |
| Destination port ranges | `80` |
| Priority and name | `320`, `Allow-HTTP-80` |

Reload in a new tab. You should see your site, with your name on it and no
port number.

Now try `http://PUBLIC-IP:8000`. It should hang, because you deleted
`Temp-HTTP-8000` at the start of class, and that's the point. Try your phone
with Wi-Fi off, too.

Unlike Tuesday's `Temp-HTTP-8000`, this rule stays. Port 80 is meant to be
public, because Nginx is the one program built to face the Internet.

Checkpoint: a visitor's request passes three things on the VM's side before
it reaches your data. Name them in order.

## 6. Restart it, then break it

### The restart test

This is the test Tuesday's setup failed. Predict what happens to your site
when the VM restarts.

1. In the portal, select Restart on the VM's Overview page. Use Restart, not
   Stop. Restart keeps the hardware and reboots Ubuntu.
2. Wait until the status says Running, then reload your site in a new tab.
   Give it a minute if it's slow to come up.

Nobody logged in, and the site came back. Now ask for the evidence:

```text
Show me when the VM last booted, when the career-platform service started,
and that the site answers through Nginx with my own name on the page. Add
the results to the plan's restart section.
```

The service's start time should match the boot time. That's systemd starting
it, not you.

### Break it on purpose

`kill -9` forces a process to stop right away, with no chance to clean up.
That's the closest thing to a real crash. Predict each result before you ask
for it.

```text
Kill one Uvicorn worker process with kill -9, not the main one. Then
show me the Uvicorn processes and systemctl status career-platform.
```

The worker's process ID changes, and the main one doesn't. Uvicorn's main
process replaced the worker, and systemd never had to act.

```text
Now kill the main Uvicorn process with kill -9, the way a crash would.
Don't use systemctl. Then show me systemctl status career-platform twice,
five seconds apart.
```

Every process ID changes this time. The main process took its workers down
with it, and systemd noticed and started the service again, which is what
`Restart=` is for. Uvicorn's main process recovers from a worker crash, and
systemd recovers from a crash of Uvicorn itself.

```text
Stop the career-platform service with systemctl, then show me what Nginx
returns for http://localhost and the last lines of Nginx's error log.
Then start the service again.
```

Reload your site while it's stopped. You'll see `502 Bad Gateway`. That page
comes from Nginx, which is still running. Nginx reached for Uvicorn, and
nothing answered. The error log says so, with a line about the connection to
the upstream being refused. Upstream is Nginx's word for the program it passes
requests to, which is Uvicorn here.

You now have three different failures, and each points at a different layer:

| What you see | Who's talking | What it means |
| --- | --- | --- |
| The page hangs, then times out | Nobody | The firewall dropped the request before it reached the VM |
| `502 Bad Gateway` | Nginx | Nginx is up, and the app behind it isn't |
| "Projects temporarily unavailable" with a 503 | Your app | The app is up, and its database isn't |

Checkpoint: list everything that had to be configured for the site to come
back after the restart. Some of it is on the VM, and some of it isn't.

## 7. Check your domain

You switched your name servers over an hour ago. For a new domain, that's
usually plenty of time. Back on your laptop, check whether the switch is
visible:

```text
nslookup -type=NS yourname.com
```

If the answer shows Cloudflare's name servers, look up the address:

```text
nslookup yourname.com
```

It should return your VM's public IP. Then open `http://yourname.com` in a
browser. Your site answers at your own name.

If it doesn't work yet, try these in order:

1. In the Cloudflare dashboard, open your domain and select "Check
   nameservers now." Cloudflare checks on a schedule, and this makes it look
   right away.
2. Ask Cloudflare's own resolver, which skips your network's saved answers:

   ```text
   nslookup yourname.com 1.1.1.1
   ```

   If this returns your VM's IP and the plain `nslookup` doesn't, the switch
   worked. Your laptop or the campus network is still holding an old answer,
   often Namecheap's parking page, and it clears on its own within about half
   an hour.
3. Open `http://yourname.com` on your phone with Wi-Fi off. Your carrier's
   resolver probably hasn't saved an old answer.

If the name servers still show Namecheap's after all three, check that the
Custom DNS change saved and that DNSSEC is off, then check again tonight. If
the name servers are Cloudflare's but the address isn't your VM's, look at the
A records in Cloudflare. Addresses starting with `104.` or `172.` mean the
orange cloud is on, so switch it to DNS only.

The browser still says "Not secure," and that's what Tuesday fixes.

## 8. Save the record and shut down

Your project needs your network setup explained, not just working. Ask for
it:

```text
Add a Record section to the plan with three things:
- every port listening on the VM from sudo ss -ltnp, with its address and
  the program behind it
- the VM's private IP and public IP
- each inbound rule in the network security group, and why it exists
Then remove anything that shouldn't be public, like my laptop's IP address
or my Azure subscription ID. Show me the changes, then commit the plan and
push it.
```

`ss -ltnp` lists each port a program is listening on, and which program it
is. Expect `0.0.0.0:22` for SSH, `0.0.0.0:80` for Nginx, and `127.0.0.1:8000`
for Uvicorn. You'll also see `127.0.0.53:53`, which is Ubuntu's local DNS
helper, and matching lines for IPv6, the newer and longer style of address.

Look closely at the addresses. The VM's own address is private, starting with
`10.`, which means it works only inside Azure's network. The public IP doesn't
appear anywhere on the VM. Azure holds the
public address and forwards traffic to the private one.

Then shut down before you leave. Select Stop on the Overview page and wait for
Stopped (deallocated). A running VM spends your credits all night, and some
regions don't offer auto-shutdown as a backup. Keep the `Allow-HTTP-80` rule,
since you'll need it Tuesday. Your domain's A records keep pointing at the
static IP while the VM is off, and the site comes back on its own when you
start it, because of what you built today.

## 9. What you should be able to explain now

- What systemd does for your app that starting it by hand doesn't.
- The difference between `systemctl enable` and `systemctl start`.
- Why Uvicorn listens on `127.0.0.1` while Nginx listens on `0.0.0.0`.
- What Uvicorn's main process does that its workers don't.
- What a 502 tells you, compared with a timeout and a 503.
- Everything that had to be configured for the site to survive a restart.
- The difference between a registrar and a DNS host, and what delegation
  changed.
- Why your public IP never appears on the VM.
- What the agent remembered after `/clear`, and where it got it back from.

## Before Tuesday

1. Run `nslookup -type=NS yourname.com` and confirm that Cloudflare's name
   servers come back. If they don't by Sunday, send me a Teams message.
2. Create a Resend account at https://resend.com/signup.
3. Leave the VM deallocated, and keep the resource group.
4. Railway's sign-in window opens Saturday, October 3. See the syllabus.

## 10. If something goes wrong

Give the agent the exact error, and ask it to explain before it fixes
anything.

| Symptom | What it tells you | Check first |
| --- | --- | --- |
| `az` asks you to sign in | The Azure CLI's sign-in expired | Run `az login`, then ask the agent to try again |
| `az login` fails on Windows with a device registration or MDM error | LMU's device policy blocks the Windows sign-in helper | `az account clear`, then `az config set core.enable_broker_on_windows=false`, then `az login` |
| The agent finds more than one VM | A VM or resource group is left over from an earlier try | Tell it which one, and check the resource group in the portal |
| SSH hangs, then times out | Your laptop's address changed, or the VM isn't running | The SSH rule's source IP, and the VM's status |
| The Nginx welcome page instead of your site | The default site is still enabled | `ls /etc/nginx/sites-enabled` |
| `502 Bad Gateway` | Nginx can't reach the app | `systemctl status career-platform`, then `journalctl -u career-platform -n 50` |
| The service fails with "No such file or directory" | A path in the unit file is wrong | `WorkingDirectory=` and the path to `.venv/bin/uvicorn` |
| The service fails with "Address already in use" | Something else is on port 8000, probably Tuesday's Uvicorn started by hand | `sudo ss -ltnp` and look for 8000 |
| The site loads with the demo profile | The service can't find your database | The unit's working directory, and `DATABASE_URL` in `.env` |
| `nginx -t` reports an error | A typo in the site file | The line number in the message |
| `http://PUBLIC-IP` hangs | The port 80 rule is missing | The inbound rules in the portal |
| The site doesn't come back after Restart | The service was started but never enabled | `systemctl is-enabled career-platform` |
| `nslookup` shows Namecheap's name servers | The change hasn't spread yet, or it wasn't saved | "Check nameservers now" in Cloudflare, `nslookup yourname.com 1.1.1.1`, then the Nameservers section in Namecheap |
| `nslookup` returns a `104.` or `172.` address | The Cloudflare proxy is on | Set the A records to DNS only |

`journalctl` reads the logs systemd keeps for each service, and `-n 50` shows
the last 50 lines.

If the agent suggests opening port 8000, running the app as root, or allowing
SSH from Any to get past a problem, say no. Write down the symptom, the
evidence, and your next check instead.

## 11. Sources

- https://www.uvicorn.org/deployment/
- https://nginx.org/en/docs/http/ngx_http_proxy_module.html
- https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html
- https://developers.cloudflare.com/dns/zone-setups/full-setup/setup/
- https://developers.cloudflare.com/dns/proxy-status/
- https://www.namecheap.com/support/knowledgebase/article.aspx/767/10/how-to-change-dns-for-a-domain/
- https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses
