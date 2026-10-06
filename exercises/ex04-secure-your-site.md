# Exercise 04: Secure your site with HTTPS

**Due** Thu 10/8, 1:45 PM Pacific, before class · **15 points** · **Type:** Config ·
**Submit** your public `career-platform` repository URL and HTTPS site URL in Brightspace

## What you're showing

Your site should be live at your own domain over HTTPS. You'll also explain
how a customer can check that the connection is encrypted, using your own
certificate and test results as evidence.

Follow [Secure your site with HTTPS](../guides/secure-your-site-with-https.md).
Most of this exercise is finished if you complete the guide in class.

Also required before Thursday's class: the independent
[website design activity with Impeccable](../guides/improve-your-site-design.md).
It takes about 30-45 minutes and has its own short repository record. It adds
no separate grade item or points. The HTTPS evidence and submission below
remain the requirements for Exercise 04.

## Check your live site

- Your domain uses Cloudflare for DNS. The records for your domain and its
  `www` version point to your Azure VM and stay **DNS only**.
- Your site loads at `https://yourname.com` without a certificate warning.
  Your certificate covers both your domain and its `www` version.
- Visiting `http://yourname.com` redirects to HTTPS.
- You've tested certificate renewal with `sudo certbot renew --dry-run`
  and checked the renewal timer.

Use your own domain wherever the guide says `yourname.com`.

### Check renewal outside class

Before moving your domain to Railway, run these in an SSH terminal on your
Azure VM:

```text
sudo certbot renew --dry-run
systemctl list-timers | grep certbot
```

The first tests renewal without replacing your live certificate. The second
shows when Certbot is scheduled to run automatically. Record what each check
shows for your explanation below.

### Keep the site available

In the Azure portal, open your VM's **Operations > Auto-shutdown**, set
**Enabled** to **Off**, and save. If auto-shutdown is already off or wasn't
available for your VM, leave it that way. Confirm the VM is running.

Keep the VM running through the deadline and until your move to Railway
is complete. After your app and data are verified on Railway and your domain
serves the site there over HTTPS, stop the Azure VM from the portal and
confirm **Stopped (deallocated)**. Keep the VM and its disk for now.

The running VM uses Azure credits. Deallocating it after the migration stops
compute charges; retained disks and other resources can still incur charges.

## Explain how your site is secured

Write `docs/how-this-site-is-secured.md` in your `career-platform` repository.
Answer this question in your own words:

> How do I know my data to your site is encrypted?

Include:

- Who issued your certificate, which domain names it covers, and when it expires.
- How renewal works and what your renewal test and timer check showed.
- Which ports are open to the internet, why each is open, and who can connect
  to your SSH port.
- Where encryption starts and ends, including the connection from Nginx to
  the app on your VM.
- How a customer can check the certificate in Chrome: click the icon to the
  left of the domain, then **Connection is secure**, then **Certificate is valid**.
- The actual `openssl` output from section 6 of the guide, showing your
  certificate's subject, issuer, and validity dates. Put it in a code block.

You can ask your coding agent to check your explanation for mistakes, but
write it yourself. You'll be asked to explain your system in the project
interview. Keep private keys and credentials out of your document and repository.

If something is still failing, describe what you tried, include the relevant
output, and explain what you would check next. Don't report a test as successful
unless you verified it.

## Submit in Brightspace

Commit and push `docs/how-this-site-is-secured.md`. Open your repository on
github.com and confirm the file is there and readable without an invitation.

In the Exercise 04 text submission, paste:

1. Your public `career-platform` repository URL.
2. Your live HTTPS site URL.
3. A direct GitHub link to `docs/how-this-site-is-secured.md`.

The live site and the file on GitHub are the deliverables. You don't need a
separate screenshot or a second copy of the explanation uploaded to Brightspace.

## How credit works

This exercise is credit/no credit: **15 points or 0 points**. Credit is based
on a meaningful attempt at the required work, supported by your explanation
and evidence. Technical mistakes can receive credit with feedback; missing
work or work that doesn't show a meaningful attempt receives no credit.

## Before you submit

- [ ] HTTPS works at my domain, and HTTP redirects to it.
- [ ] I checked certificate details and tested renewal.
- [ ] My explanation and actual certificate output are pushed to GitHub.
- [ ] I submitted my repository, site, and explanation links in Brightspace.
- [ ] Auto-shutdown is off, and my VM will stay running through the deadline
      and until my Railway migration is verified.
