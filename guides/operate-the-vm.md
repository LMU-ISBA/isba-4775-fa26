# Operate your site on the VM

Session 10 · October 1, 2026

On Tuesday your site ran on the VM, and a temporary rule for port 8000 put it
on the Internet. It ran because the agent started it by hand, and nothing
would bring it back after a crash or a restart. Today it becomes a real
service. Nginx becomes the front door on port 80, Uvicorn runs the app behind
it with two workers, and systemd keeps the app running and brings it back
after a restart. You'll also point your domain at the VM through Cloudflare.

By the end of class, `http://PUBLIC-IP` shows your site with your own data,
with no port number. It survives a VM restart without anyone logging in, and
your domain is on its way to Cloudflare. Your plan file doubles as your
evidence, the same as Tuesday.

This lesson is draft status until the instructor rehearses it.

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

1. In the Azure portal, open your VM's Overview page and check its status.
   If it says Stopped (deallocated), select Start. If it says Running, it's
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
4. In Claude Code, start in your `career-platform` folder on your laptop.

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

1. Sign in at https://dash.cloudflare.com and select "Onboard a domain."
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

This is where you're headed. Port 8000 never opens to the Internet. Nginx is
the only thing visitors reach, and it passes each request to Uvicorn on
127.0.0.1. That's the loopback address, which a computer uses to talk to
itself, so nothing outside the VM can reach Uvicorn directly. When one program
takes every request and hands it to another like this, it's called a reverse
proxy.

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

### Write yours first

Take ninety seconds, like Tuesday, and write the order on paper:

```text
App server   ?
Service      ?
Front door   ?
Firewall     ?
Restart      ?
Record       ?
```

Ask yourself why the firewall comes after the front door. What would a
visitor see if you opened port 80 before Nginx was ready?

### Ask for the plan

```text
My VM is vm-career-platform in resource group rg-career-platform. Its
public IP is PUBLIC-IP, the user is azureuser, and the SSH key is
~/.ssh/isba4775_azure. Use that user and key whenever you SSH to the VM.

Today the app becomes a real service. Here is my plan, in order:

App server   Uvicorn with --workers 2, listening on 127.0.0.1:8000, run
             by hand once to prove the command works
Service      a systemd unit named career-platform that starts the app at
             boot and restarts it if it dies
Front door   Nginx on port 80, passing requests to 127.0.0.1:8000
Firewall     I'll add a port 80 rule in the portal myself
Restart      restart the VM and prove the site comes back on its own
Record       what's listening, the addresses, the network rules, and the
             restart evidence

Use your writing-plans skill to turn this into
docs/superpowers/plans/2026-10-01-operate-the-vm.md. Keep my categories
as the sections, in this order. Under each one, list the steps with: where
it runs (laptop, VM, or portal), what to run or click, why, how we check it
worked, and how we undo it. As each section finishes, write what ran and
what the checks showed under that section. Don't change anything in Azure,
and don't run anything yet.
```

The line about writing results under each section matters today, for a
reason you'll see in section 4.

### Review it against your list

The plan will mention a unit, or unit file. That's a short settings file that
tells systemd what to run, which folder to start in, and what to do if it
stops. You give systemd commands with `systemctl`, as in
`systemctl start career-platform`.

| Look for | Why |
| --- | --- |
| No new packages. Uvicorn is already in `pyproject.toml` | It's the same app server as Tuesday, started a different way |
| The App server check runs the exact command systemd will run, then stops it | If it fails by hand, it'll fail under systemd too, where it's harder to see |
| Uvicorn binds `127.0.0.1:8000`, not `0.0.0.0` | Only Nginx needs to reach it |
| Nothing left over from Tuesday is still running on port 8000 | An old Uvicorn would hold the port, and the new service couldn't start |
| The unit runs as `azureuser`, not root | Root is the administrator account that can change anything. If someone broke into your app, they'd get only what `azureuser` can do. |
| The unit's working directory, the folder the app starts in, is your repository folder | The app finds `.env` and your database from there. Tuesday's demo-profile problem comes back if it starts somewhere else. |
| `Restart=` in the unit, and `systemctl enable` as well as `start` | `start` runs it now. `enable` is what makes it start at boot. |
| Nginx's default site is disabled | Nginx comes with a sample welcome page. If it stays on, visitors see that instead of your site. |
| `nginx -t` before every reload | A reload makes Nginx reread its settings without stopping. `nginx -t` checks the settings first, so a typo can't take the site down. |
| The firewall section is marked as a portal step for you | The agent shouldn't touch Azure |
| The restart section has a check after it, not just "it should work" | You're proving it, not assuming it |
| No step opens port 8000 | That door stays shut |

Roughly, you should see these pieces:

| Piece | Where it lives | Roughly |
| --- | --- | --- |
| App server | Already in your repository | `.venv/bin/uvicorn` with `--host 127.0.0.1 --port 8000 --workers 2` |
| Service | `/etc/systemd/system/career-platform.service` | `ExecStart=` runs that same `.venv/bin/uvicorn` command |
| Front door | `/etc/nginx/sites-available/`, linked into `sites-enabled/` | `listen 80 default_server;` and `proxy_pass http://127.0.0.1:8000;` |

`sites-available` holds every site Nginx knows about, and `sites-enabled`
holds links to the ones it actually serves. `proxy_pass` is the line that
hands each request to Uvicorn.

Two workers is plenty for a small VM. `server_name _` is fine for now, since
it answers for any name. On Tuesday you'll set it to your domain for the
certificate.

Checkpoint: what did the agent add that you didn't predict? Say what each
addition is for, in your own words.

## 4. Build it one section at a time

Approve the plan and start the first section, the same way as Tuesday:

```text
The implementation plan looks good. Let's work on the first section using
inline execution in this session.
```

After each section, read what the agent reports, then say "Let's work on the
next section." Stop after Front door, since the firewall is yours. Use the
pauses for these:

| After | Look at | Answer this |
| --- | --- | --- |
| App server | `ps -ef \| grep uvicorn` while it runs by hand | Which line is the main process, and how can you tell? |
| Service | `systemctl status career-platform` | What's the difference between `enable` and `start`? |
| Front door | `curl -I http://localhost` on the VM | Which program answered, Nginx or Uvicorn? The `Server:` header says one, but both did. |

`ps -ef` lists every running process, and `grep uvicorn` keeps only the lines
that mention Uvicorn. In that list, PID is a process's ID number, which Linux
gives every running process, and PPID is the ID of the process that started
it. `curl -I` asks for only the headers, the short labels at the top of a
response, like `Server:`.

Stay in manual mode through App server so you can read each command. After
that, press Shift+Tab for auto mode if you're keeping up.

### A pause: what the agent remembers

Do this after the Service section, before Front door.

1. Ask the agent: "What's my VM's public IP, and which section of the plan are
   we on?" It knows both.
2. Type `/clear`. That erases the conversation.
3. Ask the same question again.
4. Then ask: "Read @docs/superpowers/plans/2026-10-01-operate-the-vm.md.
   Where are we, and what's next?"

Before step 3, predict what it will say. Before step 4, predict whether the
plan file will be enough to get it back on track.

Checkpoint: what survived `/clear`, and why? How is that like what survived
the VM restart in section 2?

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
the results to the Restart section of the plan.
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

Back on your laptop, check whether the delegation from section 1 has spread:

```text
nslookup -type=NS yourname.com
```

If the answer shows Cloudflare's name servers, look up the address:

```text
nslookup yourname.com
```

It should return your VM's public IP. Then open `http://yourname.com` in a
browser. Your site answers at your own name.

If you still see Namecheap's name servers, that's normal for now. Check again
tonight. If the name servers are Cloudflare's but the address isn't your VM's,
look at the A records in Cloudflare. Addresses starting with `104.` or `172.`
mean the orange cloud is on, so switch it to DNS only.

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
| SSH hangs, then times out | Your laptop's address changed, or the VM isn't running | The SSH rule's source IP, and the VM's status |
| The Nginx welcome page instead of your site | The default site is still enabled | `ls /etc/nginx/sites-enabled` |
| `502 Bad Gateway` | Nginx can't reach the app | `systemctl status career-platform`, then `journalctl -u career-platform -n 50` |
| The service fails with "No such file or directory" | A path in the unit file is wrong | `WorkingDirectory=` and the path to `.venv/bin/uvicorn` |
| The service fails with "Address already in use" | Something else is on port 8000, probably Tuesday's Uvicorn started by hand | `sudo ss -ltnp` and look for 8000 |
| The site loads with the demo profile | The service can't find your database | The unit's working directory, and `DATABASE_URL` in `.env` |
| `nginx -t` reports an error | A typo in the site file | The line number in the message |
| `http://PUBLIC-IP` hangs | The port 80 rule is missing | The inbound rules in the portal |
| The site doesn't come back after Restart | The service was started but never enabled | `systemctl is-enabled career-platform` |
| `nslookup` shows Namecheap's name servers | The change hasn't spread yet, or it wasn't saved | The Nameservers section in Namecheap, then wait |
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
