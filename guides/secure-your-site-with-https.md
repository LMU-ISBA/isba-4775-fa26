# Secure your site with HTTPS

Session 11 · October 6, 2026

Right now your site answers at `http://yourname.com`, and everything between a
visitor and your VM travels as plain text. Anyone on the path can read it or
change it. Today you add HTTPS. You'll get a
certificate from Let's Encrypt, install it in Nginx, and open port 443. Along
the way, you'll watch Let's Encrypt check that the domain is yours.

By the end of class, `https://yourname.com` shows your site with a padlock,
and `http://` sends visitors there automatically. You'll also be able to
answer the question a customer would ask: how do I know my data to your site
is encrypted? Your written answer is part of Ex04, which is due Thursday.

Cloudflare stays DNS only today, with the gray cloud. The secure connection
runs straight from the browser to your VM, so you can see every piece of it.

## 0. Before we start

Your site should load at `http://yourname.com`, which was Thursday's
homework. On campus Wi-Fi, check it on your phone with Wi-Fi off. If it
doesn't load, section 1 helps you find out why.

1. In the [Azure portal](https://portal.azure.com), check that your VM is
   Running, and start it if it isn't.
   Under **Operations > Auto-shutdown**, set **Enabled** to **Off** and save
   so the live site won't shut down overnight. If auto-shutdown is already
   off or wasn't available for your VM, leave it that way.
2. Open three terminal windows or tabs on your laptop:

   - **First — VM commands:** SSH into the VM. Use this window to install
     Certbot, request your certificate, and check renewal.
   - **Second — VM logs:** SSH into the VM. In section 4, you'll watch Nginx's
     access log here to see Let's Encrypt's requests.
   - **Third — laptop commands:** Stay at your laptop's prompt without SSH.
     Use this window for the DNS and HTTP checks in section 1.

   Run this in each of the first two:

   ```text
   ssh -i ~/.ssh/isba4775_azure azureuser@PUBLIC-IP
   ```

   If it hangs, update the source address on your SSH rule to your current
   IP, the same as Thursday.
3. Start a new Claude Code session in your `career-platform` folder and name
   it:

   ```text
   /rename secure-with-https
   ```

## 1. Does your site work?

Let's Encrypt only gives a certificate to a domain that already works over
plain HTTP. Check that first, even if your site worked last night. In your
third terminal, at your laptop's prompt, run these four commands with your own
domain:

```text
nslookup yourname.com
nslookup yourname.com 8.8.8.8
nslookup yourname.com 1.1.1.1
curl -I http://yourname.com
```

The first one asks your usual resolver, the one your network gave you. The
next two ask Google's and Cloudflare's public resolvers directly. The last one
requests only your home page's response headers, using capital `-I`. Look
for the status line, such as `HTTP/1.1 200 OK`.

Capital `-I` sends a `HEAD` request. If you get `405 Method Not Allowed`
with `allow: GET`, your app doesn't accept that method at this URL. Check
with a normal `GET` request instead, using lowercase `-i`:

```text
curl -i http://yourname.com
```

This prints the headers followed by the page's HTML. Use its status in the
table below. A `405` from the `HEAD` check alone doesn't mean your site is down.

Read your results against this table, and tell me which row you're in:

| Your usual resolver | 8.8.8.8 and 1.1.1.1 | `curl` | What it means |
| --- | --- | --- | --- |
| Your VM's IP | Your VM's IP | `200 OK` | Everything works. Help a neighbor. |
| A different answer, or no answer | Your VM's IP | Blocked page, or nothing | Public DNS is right. Something on your local network is answering differently. |
| No answer | No answer | Nothing | The internet can't find your domain. Check the name servers in Namecheap and the A records in Cloudflare. |
| An address starting with `104.` or `172.` | The same | Anything | Cloudflare's proxy is on. Set both records to DNS only. |
| Your VM's IP | Your VM's IP | Times out | DNS is fine. Check the port 80 rule in Azure, then Nginx on the VM. |

LMU's campus Wi-Fi blocks websites it hasn't reviewed yet, and your domain is
new. If you're on campus and in the second row, that's probably why, and it
isn't something you broke. Let's Encrypt looks up your domain from the
public internet, the same way 8.8.8.8 and 1.1.1.1 do. If they return your
VM's IP, you're ready.

Checkpoint: your usual resolver and 1.1.1.1 disagree. Which one would you
trust to tell you what the rest of the internet sees, and why?

## 2. Who do we trust?

You already know one kind of key pair. When you SSH into your VM, your laptop
holds a private key, and the VM holds the matching public key you gave it.
Your laptop proves who it is to the server.

HTTPS flips that around. The server holds the private key, and it hands the
matching public key to every visitor inside a certificate. Now the server is
proving who it is to your browser.

| | SSH | HTTPS |
| --- | --- | --- |
| Who proves who they are? | Your laptop, the client | The server |
| Where the private key lives | On your laptop | On your VM |
| Where the public key goes | Onto the VM, by you | Into a certificate, sent to everyone |
| Who vouches for the public key? | You did, when you added it | A certificate authority |

That last row is the hard part. A server can't vouch for itself, because an
imposter could say the same thing. So a third party that browsers already
trust checks that you control the domain and then signs your certificate. That
third party is a certificate authority, or CA. Your browser and your laptop
come with a list of CAs they trust.

You'll hear "SSL certificate" a lot. SSL is the old name. What runs today is
TLS, short for Transport Layer Security, and HTTPS is plain HTTP sent through
a TLS connection. People still say SSL, and they mean the same thing.

Five pieces work together today:

| Piece | Its job today |
| --- | --- |
| Let's Encrypt | The CA. It checks that you control your domain and issues a free certificate that lasts 90 days. |
| Certbot | A program on your VM that asks Let's Encrypt for the certificate, installs it in Nginx, and renews it before it expires |
| Nginx | Your web server. It keeps the private key and uses the certificate on port 443. |
| Azure network security group | Decides whether ports 80 and 443 can reach your VM at all |
| Cloudflare | Your DNS host only. It answers with your VM's IP and stays out of the traffic. |

Checkpoint: your padlock disappears 90 days from now. Which of these five
pieces would you look at first, and why?

## 3. Get ready for Certbot

### Predict first

Take a minute and write this on paper: what will Let's Encrypt need to see
before it trusts that `yourname.com` is yours? Also guess which port it will
use to check.

### Open port 443

HTTPS uses port 443, and right now Azure drops anything sent to it. In the
portal, open your VM's Networking, then Network settings, and add an inbound
port rule like your port 80 rule, with these changes:

| Field | Value |
| --- | --- |
| Source | Any |
| Destination port ranges | `443` |
| Priority and name | `320`, and a name that matches your port 80 rule. If that one is `Allow-HTTP`, use `Allow-HTTPS`. |

### Tell Nginx your domain's name

A **server block** is a `server { ... }` section in an Nginx configuration
file. It holds the settings for a site: which port to listen on, which
domain names to match, and how to handle requests.

Thursday's setup used `server_name _`, a placeholder rather than your domain.
Your site can still load because Nginx uses a default server block when no
name matches. Naming your domain explicitly helps Certbot find the block
where it should install the certificate.

Before you send the prompt, predict: does changing `server_name` change
where DNS sends visitors?

Ask the agent:

```text
Read docs/superpowers/plans/2026-10-01-operate-the-vm.md for my VM's
details. Show the Nginx configuration for my site and explain what
server_name does.

Update server_name to yourname.com www.yourname.com without
changing other settings. Test the configuration, reload Nginx if
the test passes, and show what changed.
```

Replace both `yourname.com` names with your own domain before you send it.
The agent doesn't need to search Azure
this time, because Thursday's plan already holds your VM's details. That's the
plan file doing its job.

Check that `http://yourname.com` still loads before you go on. Compare the
agent's explanation with your prediction: what changed, and what stayed
the same?

## 4. Watch Let's Encrypt check your domain

### Install Certbot

In your first terminal window (VM commands), connected to the VM over SSH,
install Certbot and its Nginx plugin:

```text
sudo apt-get update
sudo apt-get install -y certbot python3-certbot-nginx
```

- **`certbot`** requests and renews your HTTPS certificate from Let's Encrypt.
- **`python3-certbot-nginx`** lets Certbot configure Nginx to prove control of
  your domain and install the certificate.

### Start watching

In your second terminal window (VM logs), connected to the VM over SSH,
watch Nginx's access log. Every request to your site adds a line here:

```text
sudo tail -f /var/log/nginx/access.log
```

Leave it running. Press Enter (Return) a couple of times to add blank lines
in the terminal, separating the existing output from the new requests you'll
watch for next.

### A test run

Return to your first terminal window (VM commands) and run Certbot in test
mode. It checks whether you can obtain a certificate using Let's Encrypt's
test server, without saving or installing the test certificate. Let's
Encrypt limits failed attempts on its production server; test-server
attempts don't count toward that limit.

Replace `yourname.com` with your own domain and `www.yourname.com` with its
`www` version before running this command:

```text
sudo certbot certonly --nginx --dry-run -d yourname.com -d www.yourname.com
```

- **`certonly`** means obtain a certificate without installing it in Nginx.
  It's a subcommand, written as one word without a dash.
- **`--dry-run`** tests that process without saving the certificate. It works
  with `certonly` or `renew`, so we need `certonly` for this first test.

The Nginx plugin still temporarily configures Nginx to answer the challenge,
then restores the configuration. Keep both `-d` options so the certificate
will cover both names.

It asks for your email address, so Let's Encrypt can warn you before a
certificate expires, and it asks you to agree to its terms. Read them and
answer yourself. Don't let an agent answer for you, since you're the one
agreeing. It may also ask whether to share your email with the EFF, the
nonprofit behind Certbot. That one is up to you.

Now look at your second terminal window (VM logs). New lines appear, asking
for paths that start
with `/.well-known/acme-challenge/`. Those requests come from Let's Encrypt,
and you'll probably see more than one IP address. It checks from several
places on the internet, so one tampered network path can't fool it.

Here's what happened. Certbot asked Let's Encrypt for a certificate, and Let's
Encrypt answered with a challenge: put this random token at this path on your
site. Certbot had Nginx serve it, and Let's Encrypt came and fetched it over
port 80. Only someone who controls both the domain's DNS and the server it
points to could do that. This check is called the HTTP-01 challenge.

The test run should end with "The dry run was successful." If it doesn't, find
the error in section 11 before you go on.

Checkpoint: compare what you predicted with the log lines. Which port did
Let's Encrypt use, and why does your port 443 rule not matter for this step?

### The real run

In your first terminal window (VM commands), ask for the real certificate
and let Certbot install it. Remove both `certonly` and `--dry-run`: the
default action obtains the certificate and installs it in Nginx.
Use the same two domain names as in your test run:

```text
sudo certbot --nginx -d yourname.com -d www.yourname.com
```

It may ask for your email and the terms again, since the test used a separate
test server. When it finishes, it tells you where it saved the certificate and
the private key, under `/etc/letsencrypt/live/yourname.com/`, and when the
certificate expires. It also changes your Nginx site so that `http://`
visitors get sent to `https://`.

## 5. What did Certbot change?

Certbot edited your Nginx site for you. Find out exactly what it did:

```text
Show me my Nginx site file on my VM and explain, for a beginner, each line
Certbot added. Don't change anything.
```

You should see a `listen 443 ssl` line, which is Nginx answering HTTPS on port
443. `ssl_certificate` and `ssl_certificate_key` point at the certificate and
the private key. A new block for port 80 sends every visitor to `https://`
with a `301` redirect.

The private key file is readable only by root. Anyone who copied it could
pretend to be your site. So it never leaves the VM, the same way your SSH
private key never leaves your laptop.

Checkpoint: of everything Certbot created on your VM, which file would an
attacker most want, and what could they do with it?

## 6. Check it from outside

Campus Wi-Fi may still block your domain in a browser, so check from the VM,
which sits outside LMU's network. In your first terminal window (VM commands),
run:

```text
curl -I http://yourname.com
curl -I https://yourname.com
openssl s_client -connect yourname.com:443 -servername yourname.com </dev/null 2>/dev/null | openssl x509 -noout -subject -issuer -dates
```

The first should show `301` and a `Location` line with `https://`. The second
should show `200`. If it shows `405` with `allow: GET`, repeat it with
lowercase `-i`, as in section 1. The third connects to your site the way a browser would,
then prints three facts from the certificate it gets back:

- `subject` is the domain the certificate covers.
- `issuer` is who signed it, which is Let's Encrypt.
- `notBefore` and `notAfter` are when it starts and stops being valid, about
  90 days apart.

Save the `openssl` output as evidence for **Exercise 04 (Ex04)**. In section
9, you'll include it in `docs/how-this-site-is-secured.md` and push that file
to your `career-platform` repository on GitHub.

Now view the certificate in **Chrome on your laptop**:

1. Open `https://yourname.com`, using your own domain.
2. Click the site controls icon just to the left of the domain in the
   address bar.
3. Click **Connection is secure**.
4. Click **Certificate is valid** to open the certificate details.
5. Find the domain name, issuer, and validity dates. Compare them with your
   `openssl` output.

If campus Wi-Fi blocks your site, connect your laptop to your phone's
hotspot and try again. You can also check that the page loads on your phone
with Wi-Fi off, but use Chrome on your laptop for the certificate walkthrough.

## 7. What happens before your page loads

Before your browser sends a single HTTP request, it and your server set up the
TLS connection. This is called the handshake, and it goes roughly like this:

1. The browser says hello and names the site it wants, `yourname.com`.
2. Nginx sends back your certificate.
3. The browser checks the certificate. Is it signed by a CA it trusts? Does it
   cover `yourname.com`? Is it still within its dates?
4. The browser and the server agree on fresh keys that only the two of them
   know, for this one connection.
5. Every HTTP request and response after that travels encrypted with those
   keys.

The certificate's public key proves the server is who it says it is. It
doesn't encrypt your data directly. The keys from step 4 do that, and they're
new for every connection.

Notice step 1. The site's name travels before encryption starts, so someone
watching the network can see that you visited `yourname.com`. They can't see
which page, what you typed, or what came back.

Checkpoint: where does the encryption end? Think about the trip from Nginx to
Uvicorn on `127.0.0.1:8000`, and why that hop is still plain HTTP.

## 8. What breaks

Predict each result before you try it.

1. Open `https://PUBLIC-IP` on your phone, using your VM's IP instead of your
   domain. The browser warns you. The certificate covers your domain, not the
   IP, so step 3 of the handshake fails.
2. In your first terminal window (VM commands), check that renewal will work,
   without renewing anything yet:

   ```text
   sudo certbot renew --dry-run
   systemctl list-timers | grep certbot
   ```

   Certificates from Let's Encrypt last 90 days. A timer on your VM runs
   Certbot twice a day, and Certbot renews any certificate that's within 30
   days of expiring.
3. What would a visitor see if someone deleted your port 443 rule? Say it out
   loud before you check section 11.

## 9. Explain it to a customer

Pair up. One of you plays a customer who's careful about data. The customer
asks, "How do I know my data to your site is encrypted?" The other answers in about two
minutes, using your own site as the evidence. Start with what the customer
can see, which is the padlock. Then walk back through how it got there: who
issued the certificate, how the browser checks it, and what stays encrypted. Then
switch.

Then write it down yourself, in your own words, in a new file in your
repository, `docs/how-this-site-is-secured.md`. Cover these:

- Who issued your certificate, which names it covers, and when it expires
- How it renews, and how you checked that renewal works
- Which ports are open to the internet, and why each one is open
- Where encryption starts and where it ends
- How a customer could check all this for themselves
- The output of the `openssl` command from section 6, as evidence

You can ask the agent to check what you wrote for mistakes, but the
explanation has to be yours. You'll be asked to explain it out loud in your
project interview. Then commit and push it:

```text
Commit docs/how-this-site-is-secured.md and push it. Don't change the
wording.
```

Check that the file shows up in your `career-platform` repository on
github.com. This file is part of Ex04.

## 10. What you should be able to explain now

- Why HTTP isn't safe for anything private, and what HTTPS changes.
- How SSH keys and HTTPS certificates are alike, and who proves what to whom.
- What a certificate authority does, and why a server can't vouch for itself.
- The roles of Let's Encrypt, Certbot, Nginx, the NSG, and Cloudflare.
- How the HTTP-01 challenge proves you control your domain.
- What happens in the handshake before your page loads.
- Where encryption starts and ends on your site.
- What a visitor sees when the certificate is expired or the name is wrong.

## 11. If something goes wrong

Give the agent the exact error, and ask it to explain before it fixes
anything.

| Symptom | What it tells you | Check first |
| --- | --- | --- |
| Your usual resolver disagrees with 1.1.1.1 | Your local network is answering differently | Use the VM or your phone off Wi-Fi to test |
| Every resolver fails, or gives the wrong IP | The internet can't find your domain | Namecheap's Custom DNS, then the A records in Cloudflare |
| An address starting with `104.` or `172.` | Cloudflare's proxy is on | Set both records to DNS only |
| `curl http://` times out | Nothing reaches Nginx | Your port 80 rule, then `systemctl status nginx` |
| `curl -I` returns `405` with `allow: GET` | The app doesn't accept `HEAD` at this URL | Repeat with lowercase `-i` to check a normal `GET` request |
| Certbot says "Timeout during connect" | Let's Encrypt couldn't reach port 80 | Your port 80 rule's source must be Any |
| Certbot says "NXDOMAIN" for `www` | There's no record for `www` | Add the `www` A record in Cloudflare |
| Certbot shows a `404` for `/.well-known/acme-challenge/` | A different Nginx site answered | The default site is back, or `server_name` doesn't match |
| Certbot can't find a matching server block | `server_name` is still `_` | Section 3, "Tell Nginx your domain's name" |
| Certbot mentions a rate limit | Too many tries for the same domain | Wait, and use `--dry-run` while you fix things |
| `https://` times out | Port 443 is closed | Your port 443 rule in the portal |
| The browser warns that the name doesn't match | You visited a name the certificate doesn't cover | Use the exact domain, not the IP |

If the agent suggests turning on Cloudflare's proxy, opening port 22 to Any,
or skipping the test run to get past a problem, say no. Write down the
symptom, the evidence, and your next check instead.

## Before Thursday

1. Ex04 is due Thursday, October 8, at 1:45 PM. It needs your site live at
   `https://yourname.com` and `docs/how-this-site-is-secured.md` pushed to
   GitHub. Keep auto-shutdown off and leave your VM running through the
   deadline and until your Railway migration is verified. After your app,
   data, and domain work over HTTPS on Railway, stop the Azure VM in the
   portal and confirm **Stopped (deallocated)**. Keep the VM and disk for now.
2. If you haven't yet, sign in to Railway between now and Wednesday,
   October 7. See the syllabus for the link.
3. Optional: try section 6 of
   [Operate your site on the VM](operate-the-vm.md), the restart test and the
   two deliberate crashes.

The email setup with Resend moved to Tuesday, October 13. Keep your Resend
account. You'll need it then.

## 12. Sources

- https://letsencrypt.org/how-it-works/
- https://letsencrypt.org/docs/challenge-types/
- https://letsencrypt.org/docs/rate-limits/
- https://eff-certbot.readthedocs.io/en/stable/using.html
- https://nginx.org/en/docs/http/configuring_https_servers.html
- https://developers.cloudflare.com/dns/proxy-status/
