# Exercise 06: Send and receive mail at your domain

**Due Thursday, October 15, 2026, at 1:45 PM Pacific. 15 points.** Submit your public `career-platform` repository URL and a direct GitHub link to `docs/evidence/ex06.md` in Brightspace.

Set up Zoho Mail for an address at your own domain. Use Zoho webmail to receive a message from an external mailbox, reply to it, and send a new message from your domain address. Cloudflare remains your DNS provider, and your website's routing records should keep serving the site.

Follow [Send and receive email at your domain with Zoho](../guides/domain-email-with-zoho.md) for the setup and checks. Number your test messages the way the guide does, Test 00 through Test 03, so each one can be found in either mailbox later.

Use the values Zoho gives your account and data center. Do not copy another student's DNS values or an example record into your zone. If Zoho's free plan is unavailable for your account, record the exact restriction and ask the instructor before choosing a paid plan.

## Configure and check the records

1. Add and verify your domain in Zoho's setup wizard. Copy its verification TXT value into Cloudflare and confirm Zoho accepts it.
2. Inventory any existing mailboxes, aliases, forwarding destinations, and catch-all routing. Prepare and verify a destination for every recipient you still need before changing MX. Then add Zoho's MX records for incoming mail and remove conflicting old MX records as part of that planned cutover. Keep the priority and target values Zoho shows for your account.
3. Publish one SPF TXT policy that includes your actual sending service. Don't create two SPF policies for the same hostname. Explain what SPF authorizes.
4. Publish the DKIM record Zoho gives you, the selector host and its TXT value, then confirm Zoho verifies it. Explain why the signature matters and where the private key lives.
5. Inspect `_dmarc` first. Preserve any existing DMARC policy and its settings, including a stricter policy. If no policy exists, publish a DMARC TXT record you can explain. A monitoring policy, `p=none` with a reporting address at your own domain, is the starting point while you verify mail. Explain how DMARC uses alignment with SPF or DKIM. Don't copy a reporting address you don't control.
6. Check the published MX, SPF, DKIM, and DMARC records from a terminal or a DNS lookup tool. Compare the public answers with the Zoho settings. Record the resolver or tool, date, and actual answers. DNS changes may need time to propagate.

Zoho's Cloudflare setup reference is https://www.zoho.com/mail/help/adminconsole/cloudflare.html. Its current Admin Console values control if the page's examples differ. Keep website A or CNAME records and Railway verification records separate from mail records.

## Test delivery both ways

Before any mail record exists, send one message from an external mailbox you control to your domain address and record what happens to it. Once MX is verified, send a message from the external mailbox to your domain address and confirm Zoho receives it. Reply from Zoho and confirm the external mailbox receives the reply with your domain address in **From**. Then send a new message from Zoho webmail to the external mailbox and confirm it arrives with your domain address in **From**. A message visible only in Zoho's Sent folder doesn't prove external delivery.

Where the receiving mailbox shows message headers or authentication details, check the SPF, DKIM, and DMARC results. Record what is available. If a header view is unavailable, say so and use the DNS and delivery checks you can perform. A record existing in DNS doesn't by itself prove a particular message passed authentication.

Create `docs/evidence/ex06.md` with your domain address (or a redacted version that still shows the domain), the date, DNS record types and purposes, public lookup results, and the Zoho verification states. Add a small table for the four message tests: before setup, incoming, reply, and new outgoing. For each, note the test number, sender, receiver, time, and observed result. Link the DNS snapshot and header analysis files if you saved them. Include redacted screenshots or header excerpts that show external receipt and the **From** address. Remove message bodies, personal addresses, tokens, and account recovery details before committing. If a check fails, include the error, your investigation, and the next check. Do not claim delivery or authentication that you haven't observed.

Your coding agent can help interpret DNS or mail headers and organize the evidence. Check its account against the messages and records yourself. Commit and push the file, then open its direct GitHub link.

## How credit works

This exercise is credit/no credit: 15 points or 0 points. Credit reflects a meaningful attempt to configure, test, and explain your domain mail. Honest failed tests and technical mistakes can earn credit with feedback. Absent work or a submission without a meaningful attempt receives no credit.
