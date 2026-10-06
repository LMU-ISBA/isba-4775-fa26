# Send and receive email at your domain with Zoho

For Tuesday, October 13: create a Zoho Mail Forever Free account by Monday, October 12. Bring your Zoho and Cloudflare sign-ins and an external mailbox you control. Use Zoho webmail. The free plan does not include IMAP, POP, or ActiveSync. Mobile mail is optional if your account supports it. If signup offers only a trial or paid plan in your region, stop, record the dated screen without personal details, and tell the instructor. Do not pay. A pricing page does not prove your account can use the plan.

Your website's A/CNAME records locate the web service. MX directs incoming mail. SPF lists authorized senders, DKIM signs outgoing mail, and DMARC checks authentication against the visible From domain. Forwarding alone does not prove you can send or reply as your domain.

## Before changing DNS

1. Save a dated copy of your Cloudflare DNS records (MX, TXT, CNAME, A, AAAA). Keep private details out of public evidence. Confirm the website works over HTTPS. Leave its web records and name servers alone.
2. If the domain already receives mail, list every active mailbox, alias, group, and forwarding address and its current destination. The free plan has limits. If Zoho cannot serve every active recipient, ask the instructor before changing MX.
3. In Zoho Admin Console, add the domain and complete its ownership check using the exact DNS values it gives you. If it offers Cloudflare automation, inspect what it creates. Set a manual verification CNAME to DNS only. Create and check all needed Zoho recipient destinations before cutover.

Zoho's Cloudflare instructions: https://www.zoho.com/mail/help/adminconsole/cloudflare.html

Plan limits: https://www.zoho.com/mail/help/adminconsole/subscription.html

## Route and authenticate mail

Copy Zoho's MX hosts and priorities for your account and region. Once every active recipient has a Zoho destination, replace the old MX records as one cutover. Mixing providers can split delivery. Keep access to old mailboxes during DNS propagation. Old messages do not move with MX. Check each recipient afterward. If delivery fails, use your saved records and ask the instructor before another change. Verify the published MX in Zoho and with `dig MX yourdomain.com +short`. Record the time. An MX lookup proves routing configuration, not delivery.

At the same DNS name, keep one SPF TXT record beginning `v=spf1`. If other legitimate senders exist, merge them with Zoho's current value instead of adding a second SPF record. Verify it in Zoho. Create a DKIM selector, publish Zoho's exact TXT host and value, then verify and enable the selector in Zoho if required. Never publish a private key.

At `_dmarc.yourdomain.com`, keep one DMARC record. Preserve an existing policy, alignment, and reporting settings. Ask the instructor before changing it. If none exists, `v=DMARC1; p=none` is a starter policy. DMARC needs an SPF or DKIM pass aligned with the visible From domain. Verify the record. Do not weaken or tighten an existing policy during this lab.

Zoho guides: https://www.zoho.com/mail/help/adminconsole/spf-configuration.html , https://www.zoho.com/mail/help/adminconsole/dkim-configuration.html , and https://www.zoho.com/mail/help/adminconsole/dmarc-policy.html

## Test actual messages

Use your own external mailbox or a willing contact. Send no sensitive content.

1. Send external to Zoho and confirm the message arrives in Zoho webmail.
2. Reply from Zoho and confirm arrival with your domain address in From.
3. Compose a new Zoho message to the external mailbox and confirm arrival and From. A reply does not replace this test.
4. For the outgoing messages, inspect the receiver's authentication details where available. Record SPF, DKIM, DMARC, and the passing/aligned domain, or say what you could not inspect.
5. Recheck the website over HTTPS. Mail DNS should not change its destination.

A Sent-folder entry or sender name is not proof of external delivery or authentication. If a result fails, inspect receiver details and Zoho verification before changing DNS again.

## Record the result

Add a dated entry to your engineering record and link it from `docs/project-1-submission.md`. Note the MX, SPF, DKIM selector, and DMARC records and purposes, DNS/Zoho verification, and results of all three mail paths. Redact addresses, message bodies, IDs, credentials, and private account details while retaining the custom From domain and authentication result. Date retests separately. If setup, propagation, or delivery remains blocked, report the observed failure and next check. Forwarding, Gmail send-as, and paid trials do not substitute for this Zoho exercise.
