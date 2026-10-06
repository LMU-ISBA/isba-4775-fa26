# Send and receive email at your domain with Zoho

For Tuesday, October 13. Create your own Zoho Mail account on the Forever Free plan by Monday, October 12. Use a domain you control in Cloudflare DNS. Bring your laptop, Zoho sign-in, Cloudflare sign-in, and an external mailbox you control. Zoho webmail is required. The free plan excludes IMAP, POP, and ActiveSync, so do not plan to use Apple Mail or another external mail client. Mobile access is optional only if your Zoho account offers a supported method.

If Forever Free isn't offered for your signup region, or the account asks for payment or a trial, stop and contact the instructor. Do not buy a plan for this class. Record the exact screen and date, without showing personal information. Plan availability must be checked during a fresh signup. A pricing page alone doesn't prove your account can use it.

Your website and email use the same domain for different jobs. The website's A or CNAME record tells browsers where to go. MX tells other mail systems where to deliver incoming mail. SPF names approved senders, DKIM signs outbound mail, and DMARC checks whether authentication aligns with the visible From domain. You will use Zoho to send and read mail, including replies. A forwarded message arriving in another inbox does not show that you can reply as your custom address.

## Before changing DNS

1. Open Cloudflare DNS for your domain. Save a dated copy or screenshot of all current records, including MX, TXT, CNAME, A, and AAAA. Redact account identifiers before publishing evidence.
2. Confirm the website still loads over HTTPS and record its current target. Do not delete its web records or change name servers for this lab.
3. Check whether the domain already receives mail. List every address that gets mail, including individual mailboxes, aliases, groups, and forwarding addresses. Record where each address currently delivers. The free plan supports one domain and up to five users, and some routing or forwarding features require a paid plan. If you cannot create working Zoho destinations for every active address, stop and ask the instructor before changing MX.
4. Plan a short cutover if the domain already receives mail. Keep the old MX entries until every needed destination is ready in Zoho. Retain access to old mailboxes while DNS caches change. Old messages do not move with MX.
5. In Zoho Mail Admin Console, add your existing domain and follow its domain ownership check. For a manual Cloudflare CNAME check, use the host and target shown for *your* domain, and set the CNAME to DNS only. You can use Zoho's Cloudflare one-click path if offered, but inspect the resulting DNS entries before continuing.
6. Create your mailbox, such as `hello@yourdomain.com`, and the other required recipient destinations in Zoho. Check each address or alias before cutover. Write down the actual address you will test.

Zoho's Cloudflare instructions: https://www.zoho.com/mail/help/adminconsole/cloudflare.html
Free-plan limits: https://www.zoho.com/mail/help/adminconsole/subscription.html

## Route incoming mail

Open the domain's Email Configuration or DNS Mapping in Zoho Admin Console. Copy its MX hosts and priorities. Prepare the Cloudflare entries at the host Zoho names, usually the root (`@`). Use the values shown in your account and region, not a generic example from a guide. Do not publish the new MX yet. When all active recipient addresses have working Zoho destinations, replace the old MX with Zoho's MX as one cutover and check the saved entries. Leaving old and new mail providers together can split delivery. Keep access to the old provider during DNS propagation, and check each active address after cutover. If delivery fails, use your saved records and ask the instructor before making another change. Do not remove unrelated records or the website's A/CNAME records.

Verify MX in Zoho Admin Console. You can also run `dig MX yourdomain.com +short` or use a DNS lookup tool. DNS visibility and Zoho's verification can lag. Record the time and the value observed. If the old provider still appears, allow propagation and inspect authoritative Cloudflare DNS before changing more records. A successful MX lookup shows routing configuration, not that a message arrived.

## Authenticate mail from your domain

In Zoho Admin Console, open the SPF configuration for this domain. Check existing SPF TXT records at the same DNS name. Keep **one** TXT record beginning `v=spf1` per name. Merge legitimate senders into that policy if you use more than Zoho. Follow Zoho's value for your account and region. Do not paste an example SPF include blindly or create a second SPF record. Save the DNS value, wait for propagation, and verify SPF back in Zoho.

Create a DKIM selector in Zoho. Copy the exact selector host and long TXT value to Cloudflare. Verify it in Zoho, then enable the verified selector if the console requires that step. A published key that Zoho has not enabled may not sign mail. DKIM propagation can take longer than MX. Check with `dig TXT selector._domainkey.yourdomain.com +short`, substituting your actual selector. Never publish a private key.

After SPF and DKIM are configured, inspect TXT records at `_dmarc.yourdomain.com`. Keep exactly one DMARC policy. If one already exists, preserve its enforcement level, alignment, and reporting settings. Ask the instructor before changing an established policy, especially `p=quarantine` or `p=reject`. A second DMARC record causes a permanent error. If no policy exists, add a starter record such as `v=DMARC1; p=none`. `p=none` asks receivers to observe failures without requesting quarantine or rejection. DMARC passes when either SPF or DKIM passes **and** that passing domain aligns with the visible From domain. A bare SPF pass for some unrelated sending domain does not establish alignment. Verify the published DMARC record in DNS and Zoho if available. Do not relax or tighten an existing policy during this lab without checking every legitimate sender and getting instructor help.

Zoho's setup and explanation: https://www.zoho.com/mail/help/adminconsole/spf-configuration.html , https://www.zoho.com/mail/help/adminconsole/dkim-configuration.html , and https://www.zoho.com/mail/help/adminconsole/dmarc-policy.html

## Test three distinct mail paths

Use your own external mailbox or a contact who agrees to the test. Keep messages short and free of sensitive content.

1. From the external mailbox, send to your Zoho custom address. Confirm it appears in Zoho webmail. This proves an actual incoming delivery, beyond an MX lookup.
2. In Zoho webmail, reply to that message. In the external mailbox, confirm the reply arrived and the visible From address is your custom domain address.
3. Compose a **new** message in Zoho webmail to the external mailbox. Confirm it arrives and has the same custom From address. The reply test alone doesn't replace this check.
4. For both outgoing messages, inspect the recipient mailbox's original message or authentication details. Record SPF, DKIM, and DMARC results where exposed, and note which domain passed and aligned. If the interface does not expose a result, say which result you could not inspect.
5. Recheck your website over HTTPS after DNS work. Mail routing should not change its destination.

A sender name in the inbox is not proof of authentication. If an external mailbox reports failure, inspect the actual header results and Zoho's verification status before changing DNS again. If you were previously using Gmail send-as or a forwarding service, perform these tests from actual Zoho webmail.

## Record your evidence

Add a short, dated entry to your repository's existing engineering record and link it from `docs/project-1-submission.md`. Include the domain's MX, SPF, DKIM selector, and DMARC names and purposes, the DNS or Zoho verification result, and what happened in each of the three mail tests. Redact recipient addresses, message bodies, message IDs, and private account details. Keep the visible custom From domain and authentication result. State a failed or delayed check as such, then record the later retest separately. Do not put credentials or private correspondence in Git.

If Zoho account access, DNS propagation, or external delivery is blocked, write the observed failure and the next check. Contact the instructor about a blocked free account. Do not substitute forwarding, a paid trial, or a Gmail send-as address for the Zoho requirement.
