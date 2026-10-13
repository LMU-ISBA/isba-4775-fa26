# Send and receive email at your domain with Zoho

Session 13 · Tuesday, October 13, 2026

Set up `you@yourdomain.com` on Zoho Mail's free plan, prove it sends, receives, and replies, and check that other providers trust it. Your website stays on Railway the whole time. Finish what's left for [Exercise 06](../exercises/ex06-domain-email.md), due Thursday, October 15, at 1:45 PM.

## 0. Before you start

Have these open in browser tabs, in this order, so you can move left to right:

1. This guide on github.com, so you see fixes as they're pushed.
2. The [Zoho Mail Admin Console](https://mailadmin.zoho.com/), signed in to the account you created before class.
3. [Zoho Mail webmail](https://mail.zoho.com/), in the same account.
4. The [Cloudflare dashboard](https://dash.cloudflare.com/), on your domain's DNS page.
5. An outside mailbox you control, such as Gmail or your LMU Outlook. You'll send test mail to and from it.
6. `https://yourdomain.com`, loading from Railway with a padlock.

Have these open on your laptop:

- VS Code on `career-platform`, with a new Claude Code session renamed with `/rename` to something like `zoho-email`.
- A terminal where `cf` works. If it doesn't, run the install prompt from [section 5 of the Railway guide](migrate-to-railway.md#5-point-your-domain-at-railway) first.

Keep your phone nearby. It's your hotspot if a Zoho or Cloudflare page won't load on campus Wi-Fi, as on October 6, and it's where the optional Zoho app goes in section 7.

No Zoho account yet? Use the [Forever Free signup](https://workplace.zoho.com/signup?type=org&plan=free). Keep Business Email selected, not Personal Email, because a personal account has no Admin Console and can't host your domain. Enter your name, an email address you already have (it becomes your Zoho login, so use Gmail or LMU, not the address you're about to create), and a password. Accept the terms, enter the code Zoho sends, and when it asks about a domain, choose the option for a domain you already own and enter `yourdomain.com`.

If you already signed up and the [Admin Console](https://mailadmin.zoho.com/) shows no organization, you have a personal account. Either sign up again with Business Email using a different email address, or follow Zoho's steps to [switch a personal account to a business account](https://www.zoho.com/mail/help/adminconsole/manage-subscription.html#upgrade-personal-account).

Do two checks before section 1. In the Admin Console, your plan should say Free. If signup offered only a trial or a paid plan, stop, screenshot the screen without personal details, and tell the instructor. Don't pay. Zoho says the [free plan](https://www.zoho.com/mail/help/adminconsole/subscription.html) is one domain, five users, and 5 GB each, with web access and Zoho's own apps only. It has no IMAP or POP, so Apple Mail, Outlook, and the Gmail app can't connect to it. That's expected.

## 1. Snapshot your zone

Your domain already has records for the website. Mail adds a few more next to them. Save what's there first, so you can put it back.

> Using the Cloudflare CLI, list every DNS record for my domain and save a dated copy as docs/evidence/dns-before-zoho.md.

Read the list. If you see MX records ending in `registrar-servers.com` or an SPF TXT record that includes `efwd`, those are Namecheap's email forwarding defaults, and Cloudflare copied them when you moved the domain. They come out in section 3. If you set up forwarding in Namecheap and still use it, tell the instructor before you change MX, because old forwards stop working once mail goes to Zoho.

Leave the root CNAME and Railway's TXT record alone. Mail records go at the same name, `@`. A CNAME normally can't share a name with other records, but Cloudflare [flattens the root CNAME](https://developers.cloudflare.com/dns/cname-flattening/) into an address, so MX and TXT records can sit next to it.

## 2. Add your domain in Zoho

This part is by hand, in the Zoho Admin Console and the Cloudflare dashboard.

1. In the Admin Console, open Domains. If signup already asked for your domain, it's listed here. If not, click Add and enter `yourdomain.com`.
2. Open the domain. Under Verify Domain Ownership, Zoho offers "Login to my DNS," which lets Zoho write your Cloudflare records for you. Skip it today, because you'd never see the records. Choose "Add a TXT record in the DNS" and copy the value.
3. In Cloudflare, add a TXT record at `@` with that value. Save, go back to Zoho, and click Verify TXT record.
4. Open Users and confirm your mailbox exists as `you@yourdomain.com`. Create it if it doesn't. Pick a name you'd put on a resume.

Zoho's own walkthrough for this provider: https://www.zoho.com/mail/help/adminconsole/cloudflare.html

## 3. Publish the mail records

If your A or CNAME record is your street address, these four records are your mail:

- MX is the mailbox at the curb. It tells senders where to deliver.
- SPF is the list of carriers allowed to send as you.
- DKIM is a wax seal on every letter you send.
- DMARC tells the post office what to do when the seal or the carrier list doesn't match your return address.

Copy every value from the Admin Console, under Domains, your domain, Email Configuration. Zoho runs separate data centers, so your values may differ from a classmate's or from the help page. Add each record in Cloudflare by hand and note the time you save.

1. Add Zoho's three MX records at `@` with the priorities Zoho shows. If old Namecheap MX records are there, delete them in the same minute, so mail doesn't split between two providers.
2. Keep one TXT record at `@` that starts with `v=spf1`. If the Namecheap one is there, replace its value with Zoho's instead of adding a second. Two SPF records fail.
3. In Zoho's DKIM section, add a [selector](https://www.zoho.com/mail/help/adminconsole/dkim-configuration.html), then click it to see the TXT name and value. Add that record in Cloudflare. Zoho holds the private key, and the record is the public half.
4. Add a TXT record at `_dmarc` with `v=DMARC1; p=none`. That's monitor-only: it asks receivers to check, not to reject. If a `_dmarc` record already exists, ask the instructor before changing it. Zoho's [DMARC page](https://www.zoho.com/mail/help/adminconsole/dmarc-policy.html) explains the stricter settings.

Back in Zoho, click Verify on MX, then SPF, then DKIM, and switch the DKIM selector's status to Enabled once it verifies. Zoho's page says to allow a couple of hours for MX and longer for SPF and DKIM. Cloudflare usually answers much faster, so try Verify right away and again after a few minutes.

## 4. Check from the outside

Zoho's green checks are Zoho's view. Ask the internet too:

> Using the Cloudflare CLI and a DNS lookup against 8.8.8.8, show my domain's MX, SPF, DKIM, and DMARC records, and compare them with what Zoho expects.

Without a terminal, [MXToolbox](https://mxtoolbox.com/SuperTool.aspx) answers the same questions.

Then check the site still works: open `https://yourdomain.com`. Mail records don't change where the website lives.

A record in DNS proves the setup, not delivery. Section 5 tests delivery.

## 5. Send real mail

Use your outside mailbox, and keep anything sensitive out of the messages.

1. From the outside mailbox, send a message to `you@yourdomain.com`, and confirm it arrives in Zoho webmail.
2. Reply from Zoho, and confirm the reply arrives with your domain in From.
3. Write a new message from Zoho to the outside mailbox. A reply doesn't count here, because the exercise scores new outgoing mail on its own.

Now read what the receiving side decided. In Gmail, open the message from Zoho, click the three dots, then [Show original](https://support.google.com/mail/answer/29436). In Outlook on the web, it's the three dots, View, then View message source. You want SPF, DKIM, and DMARC all to say PASS, with your domain. Paste the header into your agent if it's hard to read:

> Read this mail header and tell me whether SPF, DKIM, and DMARC passed and for which domain.

A message in Zoho's Sent folder doesn't prove it arrived. Check the receiving side.

## 6. Score your deliverability

Go to [mail-tester.com](https://www.mail-tester.com/), copy the address it shows, and send it a short, normal message from Zoho. Then check your score. Aim for 9 or higher. Read what it marks down, because a missing DKIM signature or a second SPF record shows up here first. The free version allows a few checks a day, so send one careful message.

If a message lands in spam or a check fails, look at the header and Zoho's verification page before you change DNS again. Your section 1 snapshot is how you undo a mistake.

## 7. Add your phone (optional)

Install the Zoho Mail app, sign in with your Zoho account, and send one reply from it. That's the free plan's only client outside the browser. If the app says your plan doesn't include mobile, note it and move on.

## 8. Write it down

> Draft docs/evidence/ex06.md from what we did today: the records and their purposes, the lookup results, the Zoho verification states, and a table of the three mail tests. Leave out message bodies and personal addresses.

Check every line against what you actually saw. Add redacted screenshots of the From line and the authentication results, and your mail-tester score. If something is still pending, say so and name the next check. [Exercise 06](../exercises/ex06-domain-email.md) lists everything the evidence covers.

Link the file from `docs/project-1-submission.md`. Commit, push, and merge to main.
