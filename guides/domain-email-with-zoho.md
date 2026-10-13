# Send and receive email at your domain with Zoho

Session 13 · Tuesday, October 13, 2026

Your website works. Can a recruiter reach you at `you@yourdomain.com`? Today you set that address up on Zoho Mail's free plan, prove it sends, receives, and replies, and check that other providers trust it. Your website stays on Railway the whole time. Finish what's left for [Exercise 06](../exercises/ex06-domain-email.md), due Thursday, October 15, at 1:45 PM.

## 0. Before you start

Have these open in browser tabs, in this order, so you can move left to right:

1. This guide on github.com, so you see fixes as they're pushed.
2. The [Zoho Mail Admin Console](https://mailadmin.zoho.com/), signed in to the account you created before class.
3. [Zoho Mail webmail](https://mail.zoho.com/), in the same account.
4. The [Cloudflare dashboard](https://dash.cloudflare.com/), on your domain's DNS page.
5. An outside mailbox you control, such as Gmail or your LMU Outlook. You'll send test mail to and from it.
6. `https://yourdomain.com`, loading from Railway. If Thursday's cutover is still pending, the site can load from Azure for now. Email doesn't depend on it.

Have these open on your laptop:

- VS Code on `career-platform`, with a new Claude Code session renamed with `/rename` to something like `zoho-email`.
- A terminal where `cf` works. If it doesn't, run the install prompt from [section 5 of the Railway guide](migrate-to-railway.md#5-point-your-domain-at-railway) first.

Keep your phone nearby. It's your hotspot if a Zoho or Cloudflare page won't load on campus Wi-Fi, as on October 6.

No Zoho account yet? Use the [Forever Free signup](https://workplace.zoho.com/signup?type=org&plan=free). Keep Business Email selected, not Personal Email, because a personal account has no Admin Console and can't host your domain. Enter your name, an email address you already have (it becomes your Zoho login, so use Gmail or LMU, not the address you're about to create), and a password. Accept the terms, enter the code Zoho sends, and when it asks about a domain, choose the option for a domain you already own and enter `yourdomain.com`.

Already have a Zoho login, and the setup page offers only paid plans and trials? The free plan is hidden unless the link asks for it. Open https://mailadmin.zoho.com/hosting?plan=free, which goes straight to "Add an existing domain." Don't start a trial.

If the [Admin Console](https://mailadmin.zoho.com/) shows no organization at all, you have a personal account. Either sign up again with Business Email using a different email address, or follow Zoho's steps to [switch a personal account to a business account](https://www.zoho.com/mail/help/adminconsole/manage-subscription.html#upgrade-personal-account).

Do two checks before section 1. In the Admin Console, your plan should say Free. If signup offered only a trial or a paid plan, stop, screenshot the screen without personal details, and tell the instructor. Don't pay. Zoho says the [free plan](https://www.zoho.com/mail/help/adminconsole/subscription.html) is one domain, five users, and 5 GB each, with web access and Zoho's own apps only. It has no IMAP or POP, so Apple Mail, Outlook, and the Gmail app can't connect to it. That's expected.

One leftover from Thursday. If your data transfer finished and the site at your domain shows your rows, open the Postgres service in Railway, then Settings, Networking, remove the TCP Proxy, and click Deploy. Your laptop doesn't need the database anymore, and that was the last step of [the Railway guide](migrate-to-railway.md#6-prove-it-works-then-write-it-down). If the transfer is still unfinished, leave it on until it's done.

## 1. Send mail to a domain that has none

First, an experiment. From your outside mailbox, send a message to `you@yourdomain.com` now, before anything is set up. Write down what you expect to happen: it arrives, it bounces right away, or something else. You'll check on it in section 3.

Number every test message today, so each one is findable later and the evidence table in section 10 writes itself. Subject `Test NN: what it checks`, body one line: the number, who sent it to whom, and the time. This one is `Test 00: before setup`.

Your domain already has records for the website. Mail adds a few more next to them. Save what's there first, so you can put it back.

> Using the Cloudflare CLI, list every DNS record for my domain and save a dated copy as docs/evidence/dns-before-zoho.md.

Read the list. Your zone already answers "where is the website." Which record type would answer "where is the mail server"? If no record does, where did your test message go?

If you see MX records ending in `registrar-servers.com` or an SPF TXT record that includes `efwd`, those are Namecheap's email forwarding defaults, and Cloudflare copied them when you moved the domain. They come out in section 3. If you set up forwarding in Namecheap and still use it, tell the instructor before you change MX, because old forwards stop working once mail goes to Zoho.

Leave the root CNAME and Railway's TXT record alone. Mail records go at the same name, `@`. A CNAME normally can't share a name with other records, but Cloudflare [flattens the root CNAME](https://developers.cloudflare.com/dns/cname-flattening/) into an address, so MX and TXT records can sit next to it.

## 2. Prove you own the domain

Zoho won't accept mail for a domain anyone can type into a form, so it asks you to publish a value that only the domain's owner could publish. This part is by hand, in Zoho and the Cloudflare dashboard.

1. Zoho's setup wizard asks for your domain first. If you see "Add an existing domain," click Add now and enter `yourdomain.com`. If the domain is already listed under Domains in the Admin Console, open it.
2. On Verify Your Domain Ownership, Zoho offers "Log in to my DNS," which lets Zoho write your Cloudflare records for you. Skip it today, because you'd never see the records. Click Configure manually, choose the TXT record method, and copy the value.
3. In Cloudflare, click Add record and fill the form from Zoho's table. Leave TTL on Auto. Cloudflare wraps the content in quotes on its own.

   | Type | Name | Content |
   | --- | --- | --- |
   | TXT | `@` | the `zoho-verification=...` value from Zoho |

   Save, go back to Zoho, and click Verify TXT Record. In rehearsal it turned green in under five seconds.
4. Zoho then asks for your login email address at the domain. That's your mailbox. Pick a name you'd put on a resume: `firstname` if the domain is your name, `firstname.lastname` if it isn't. Not `hello`, which reads as a storefront. This address is also your Zoho login and admin, so decide once. Click Create. The wizard then shows Setup Users with your one user, and Setup Groups, which a one-person domain doesn't need. Click Proceed on each until you reach DNS Mapping.

Why does Zoho verify with a DNS record instead of emailing a code to `you@yourdomain.com`?

Zoho's own walkthrough for this provider: https://www.zoho.com/mail/help/adminconsole/cloudflare.html

## 3. Route incoming mail

If your A or CNAME record is your street address, MX is the mailbox at the curb. It tells a sending server where to deliver mail for your domain. Without one, senders fall back to your website's address and knock on a port where nothing answers.

On the wizard's DNS Mapping step, click Configure manually. Read Zoho's note at the top first: you can already send from your new address, but you can't receive until MX exists. Why would sending work before receiving? Sending is Zoho's server talking out. Receiving needs every other mail server on the internet to know where your mail goes, and only a DNS record can tell them.

One table lists five records: three MX rows, one SPF, and one DKIM, each with a red status. Zoho runs separate data centers, so your values may differ from a classmate's or from the help page. Later, the same table lives in the Admin Console under Domains, your domain, Email Configuration.

Add only the three MX rows now, in Cloudflare by hand, and note the time you save. Cloudflare's MX form has a Mail server field instead of Content, plus Priority. Copy the hosts and priorities from your Zoho table, which usually look like this:

| Type | Name | Mail server | Priority |
| --- | --- | --- | --- |
| MX | `@` | `mx.zoho.com` | 10 |
| MX | `@` | `mx2.zoho.com` | 20 |
| MX | `@` | `mx3.zoho.com` | 50 | If old Namecheap MX records are there, delete them in the same minute, so mail doesn't split between two providers. Back in Zoho, click Verify all records. The MX rows should turn green and the other two stay red, which is right for now. Zoho's page says to allow up to a day. In rehearsal all three turned green within a couple of seconds, so try right away.

Once MX verifies, send `Test 01: inbound` from your outside mailbox to `you@yourdomain.com` and watch Zoho webmail. In rehearsal it arrived in about 30 seconds. Then look for the message you sent in section 1. If the sender was still retrying, it may arrive now too. If it bounced, read the bounce: it says what the sending server tried.

A published MX record and a delivered message are two different pieces of evidence. Keep both.

## 4. Prove who you are when you send

Now you'll reply. Why should Gmail believe the reply came from you, and not from someone who typed your address into the From field? Anyone can. Three records let a receiving server check:

- SPF is the list of carriers allowed to send as you.
- DKIM is a wax seal on every letter you send. Zoho holds a private key and signs each message, and the public key goes in DNS, the same split as last Tuesday's certificate.
- DMARC tells the receiver what to do when the seal or the carrier list doesn't match the domain in From.

The SPF and DKIM values are in the same DNS Mapping table as the MX rows. DMARC isn't listed there, because it's your policy, not Zoho's. Three more TXT records in Cloudflare, all with TTL on Auto:

| Type | Name | Content |
| --- | --- | --- |
| TXT | `@` | your table's SPF value, which starts with `v=spf1` |
| TXT | `zmail._domainkey` | your table's long `v=DKIM1` value |
| TXT | `_dmarc` | `v=DMARC1; p=none; rua=mailto:you@yourdomain.com` |

1. SPF: if a Namecheap record starting with `v=spf1` is already at `@`, replace its content instead of adding a second. Two SPF records fail.
2. DKIM: the name is the host Zoho shows, usually `zmail._domainkey`. Zoho generated that [selector](https://www.zoho.com/mail/help/adminconsole/dkim-configuration.html) and its key pair when you added the domain. Cloudflare splits the long value into chunks on its own.
3. DMARC: `p=none` is monitor-only. It asks receivers to check, not to reject. The `rua` address is where Google and Microsoft mail you a daily summary of who sent as your domain and whether it passed. Use your own new address, never one you don't control. Expect the first XML attachment tomorrow. If a `_dmarc` record already exists, ask the instructor before changing it. Zoho's [DMARC page](https://www.zoho.com/mail/help/adminconsole/dmarc-policy.html) explains the stricter settings.

Back in Zoho, click Verify all records again. All five rows should turn green, and in rehearsal they did right away. If DKIM shows a status toggle, switch it to Enabled.

While you wait, write one sentence each in your own words: what SPF authorizes, what DKIM proves, and what DMARC decides. Exercise 06 asks for exactly these. One more to get right: passing SPF or DKIM alone doesn't pass DMARC. The domain that passed has to match the domain in From.

## 5. Check from the outside

Zoho's green checks are Zoho's view. Ask the internet too:

> Using the Cloudflare CLI and a DNS lookup against 8.8.8.8, show my domain's MX, SPF, DKIM, and DMARC records, and compare them with what Zoho expects.

Without a terminal, [MXToolbox](https://mxtoolbox.com/SuperTool.aspx) answers the same questions. It will show "DMARC Policy Not Enabled" in red. That's your `p=none`, and it's deliberate: you monitor first and tighten to `quarantine` later, once you've seen that your own mail passes. Notice too that it asked your Cloudflare name server directly, which is why there was no wait.

Then check the site still works: open `https://yourdomain.com`. Mail records don't change where the website lives.

A record in DNS proves the setup, not delivery. Section 6 tests delivery.

## 6. Send real mail

Use your outside mailbox, and keep anything sensitive out of the messages. Incoming mail was proven in section 3. Two tests remain.

1. Reply from Zoho to Test 01, and confirm the reply lands in the outside mailbox with your domain in From. The subject stays `Re: Test 01: inbound`, which is the evidence that it was a reply.
2. Write `Test 02: new outbound` from Zoho to the outside mailbox. A reply doesn't count here, because the exercise scores new outgoing mail on its own.

Before you open the header, predict which of SPF, DKIM, and DMARC will pass, and for which domain. Then read what the receiving side decided. In Gmail, open the message from Zoho, click the three dots, then [Show original](https://support.google.com/mail/answer/29436). In Outlook on the web, it's the three dots, View, then View message details. Look for the `Authentication-Results` line. You want all three to say PASS, with your domain. Paste the header into your agent if it's hard to read:

> Read this mail header and tell me whether SPF, DKIM, and DMARC passed and for which domain.

In rehearsal the receiver's verdict named a different thing for each check: SPF the envelope sender, DKIM the `zmail` selector, and DMARC the From header. That's the alignment DMARC enforces. Keep the agent's table:

> Save this header analysis as docs/evidence/zoho-header-check.md, without the message body.

A message in Zoho's Sent folder doesn't prove it arrived. Check the receiving side.

## 7. Score your deliverability (optional)

The instructor will run one on the projector. [mail-tester.com](https://www.mail-tester.com/) gives you an address, you send it a normal message from Zoho, and it scores the result out of 10. It scores the words too, so send something a person would write. Use this:

Subject: `Test 03: deliverability`

> Test 03. Hi, this is my new address. My resume is at https://yourdomain.com. Thank you, Your Name

Skip words like free, urgent, or click here, and no capitals or exclamation points in the subject, because those cost points. In rehearsal this message scored 10 out of 10. The one orange line, no List-Unsubscribe header, is a rule for bulk senders and doesn't apply to a personal mailbox. Read what it marks down, because a missing DKIM signature or a second SPF record shows up here first. The free version allows three checks per 24 hours, and mail-tester doesn't say whether it counts by person or by network, so if it refuses you on campus, use the projector result. Your report stays public to anyone with the test address for seven days, so keep the body as written.

If a message lands in spam or a check fails, look at the header and Zoho's verification page before you change DNS again. Your section 1 snapshot is how you undo a mistake.

## 8. Where does your mail live?

Close the webmail tab. Your mail is still there, because the mailbox is on Zoho's server, and webmail is one window onto it. Zoho's phone app would be a second window. IMAP would be a third, which the free plan doesn't open, so Apple Mail and Outlook can't connect.

If every window were closed, where would the mail be?

## 9. Explain the system

With a classmate, draw two paths on paper or a whiteboard. First, a recruiter's mail server to DNS to Zoho to your browser. Label the record it looked up. Second, your reply to Gmail, with the three checks Gmail runs at its end and where each one finds its answer. Then trade drawings and find one thing the other person left out.

Then one decision for your README, written the way you wrote Thursday's Railway decision. You're the CTO of a three-developer startup. Would you run your own mail server or use Zoho? Argue it with what you saw today: what Zoho handled, what you still own (DNS, the records, the evidence that it works), what breaks if a record is wrong, and what would change your answer.

## 10. Write it down

> Draft docs/evidence/ex06.md from what we did today: the records and their purposes, the lookup results, the Zoho verification states, and a table of the three mail tests. Leave out message bodies and personal addresses.

Check every line against what you actually saw, including the section 1 experiment and its result. Add redacted screenshots of the From line and the authentication results. If something is still pending, say so and name the next check. [Exercise 06](../exercises/ex06-domain-email.md) lists everything the evidence covers.

Commit, push, and merge to main.
