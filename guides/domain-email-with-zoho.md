# Send and receive email at your domain with Zoho

Session 13 · Tuesday, October 13, 2026

Set up `you@yourdomain.com` on Zoho Mail's free plan, prove it sends, receives, and replies, and check that other providers trust it. Your website stays on Railway the whole time. Finish what's left for [Exercise 06](../exercises/ex06-domain-email.md), due Thursday.

## 0. Before you start

1. You created a Zoho Mail Forever Free account before class. If signup offered only a trial or paid plan, stop, screenshot the screen without personal details, and tell the instructor. Don't pay.
2. You can sign in to Cloudflare, and `https://yourdomain.com` loads from Railway with a padlock.
3. You have an outside mailbox to test with, such as Gmail or your LMU account.
4. VS Code is open on `career-platform` with a new Claude Code session, renamed with `/rename` to something like `zoho-email`.
5. This guide is open on github.com, so you see fixes as they're pushed.

The free plan is webmail and the Zoho Mail phone app only. It has no IMAP or POP, so Apple Mail, Outlook, and the Gmail app can't connect to it. That's expected.

If a Zoho or Cloudflare page won't load on campus Wi-Fi, try your phone's hotspot, as on October 6.

## 1. Snapshot your zone

Your domain already has records for the website. Mail adds a few more next to them. Save what's there first, so you can put it back.

> Using the Cloudflare CLI, list every DNS record for my domain and save a copy outside this repo.

Read the list. If you see MX records ending in `registrar-servers.com` or an SPF TXT record that includes `efwd`, those are Namecheap's email forwarding defaults. Cloudflare copied them when you moved the domain. They come out in section 3. If you set up forwarding in Namecheap and still need it, tell the instructor before you change MX, because old forwards stop working once mail goes to Zoho.

Leave the root CNAME and Railway's TXT record alone. Mail records go at the same name, `@`, and Cloudflare allows both.

## 2. Add your domain in Zoho

This part is by hand, in the Zoho Admin Console and the Cloudflare dashboard.

1. In the Zoho Admin Console, go to Domains, then Add, and enter `yourdomain.com`.
2. Zoho offers "Login to my DNS," which lets Zoho write your Cloudflare records. Skip it today. Choose the TXT method and copy the value it gives you.
3. In Cloudflare, add a TXT record at `@` with that value. Save, go back to Zoho, and click Verify.
4. Create your mailbox, `you@yourdomain.com`. A name you'd put on a resume.

Zoho plan limits: https://www.zoho.com/mail/help/adminconsole/subscription.html

## 3. Publish the mail records

If your A or CNAME record is your street address, these four are your mail:

- **MX** is the mailbox at the curb. It tells senders where to deliver.
- **SPF** is the list of carriers allowed to send as you.
- **DKIM** is a wax seal on every letter you send.
- **DMARC** tells the post office what to do when the seal or the carrier list doesn't match your return address.

Copy every value from Zoho's Admin Console for your account, under Domains, your domain, Email Configuration. Zoho runs separate data centers, so your values may differ from a classmate's or from the help page.

1. **MX.** Delete the old Namecheap MX records, then add Zoho's three MX records at `@` with Zoho's priorities. Do this as one change, so mail doesn't split between two providers.
2. **SPF.** Keep one TXT record at `@` that starts with `v=spf1`. If the Namecheap one is there, replace it with Zoho's value instead of adding a second. Two SPF records fail.
3. **DKIM.** In Zoho, add a selector and copy its TXT name and value into Cloudflare. Zoho holds the private key, and the record is the public half.
4. **DMARC.** Add a TXT record at `_dmarc` with `v=DMARC1; p=none`. That's monitor-only: it asks receivers to check, not to reject. If a `_dmarc` record already exists, ask the instructor before changing it.

Note the time you save. Back in Zoho, click Verify All Records, and enable the DKIM selector once it verifies. MX usually verifies in minutes, and SPF and DKIM can take longer.

Zoho's Cloudflare walkthrough: https://www.zoho.com/mail/help/adminconsole/cloudflare.html

## 4. Check from the outside

Zoho's green checks are Zoho's view. Ask the internet too:

> Using the Cloudflare CLI and dig, show my domain's MX, SPF, DKIM, and DMARC records, and compare them with what Zoho expects.

Then check the site still works: open `https://yourdomain.com`. Mail records don't change where the website lives.

A record in DNS proves the setup, not delivery. Section 5 tests delivery.

## 5. Send real mail

Use your outside mailbox. No sensitive content.

1. **In.** From the outside mailbox, send a message to `you@yourdomain.com`. Confirm it arrives in Zoho webmail.
2. **Reply.** Reply from Zoho. Confirm it arrives with your domain in From.
3. **Out.** Write a new message from Zoho to the outside mailbox. A reply doesn't count for this one.

In Gmail, open the message from Zoho, click the three dots, then Show original. You want SPF, DKIM, and DMARC all to say PASS, with your domain. Paste the header into your agent if it's hard to read:

> Read this mail header and tell me whether SPF, DKIM, and DMARC passed and for which domain.

A message in Zoho's Sent folder doesn't prove it arrived. Check the receiving side.

## 6. Score your deliverability

Go to https://www.mail-tester.com, copy the address it shows, and send it a short, normal message from Zoho. Then check your score. Aim for 9 or higher. Read what it marks down: a missing DKIM signature or a second SPF record shows up here first.

If a message lands in spam or a check fails, look at the header and Zoho's verification page before you change DNS again. Your section 1 snapshot is how you undo a mistake.

## 7. Add your phone (optional)

Install the Zoho Mail app, sign in with your Zoho account, and send one reply from it. That's the free plan's email client. If the app says your plan doesn't include mobile, note it and move on.

## 8. Write it down

> Draft docs/evidence/ex06.md from what we did today: the records and their purposes, the lookup results, and the three mail tests. Leave out message bodies and personal addresses.

Check every line against what you actually saw. Add redacted screenshots of the From line and the authentication results, and your mail-tester score. If something is still pending, say so and name the next check. [Exercise 06](../exercises/ex06-domain-email.md) lists everything the evidence covers.

Link the file from `docs/project-1-submission.md`. Commit, push, and merge to main.
