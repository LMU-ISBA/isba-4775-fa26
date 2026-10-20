# Exercise 06: Domain email and Google Analytics

**Due Tuesday, October 20, 2026, at 1:45 PM. 15 points.** Submit your public `career-platform` repository URL and a direct GitHub link to `docs/evidence/ex06.md` in Brightspace.

Set up Zoho Mail for an address at your own domain. Use Zoho webmail or your coding agent through the Zoho MCP server to receive a message from an external mailbox, reply to it, and send a new message from your domain address. Then add Google Analytics 4 to your website and verify a page view and a click to another website. Cloudflare remains your DNS provider, and your website's routing records should keep serving the site.

## Complete the setup and checks

Follow the [Zoho Mail guide](../guides/domain-email-with-zoho.md) and the [Google Analytics guide](../guides/google-analytics.md). They cover the setup, privacy notice, deployment, and troubleshooting steps.

- Email: configure and verify the mail records. Confirm an incoming message, a reply received in your outside mailbox, and a new outgoing message received there. Check that outgoing mail shows your domain in From. Check SPF, DKIM, and DMARC in the receiving mailbox's authentication details when available.
- Analytics: prepare the Privacy page and any required consent controls, install the tag, and check the live deployment. In GA4, observe `page_view` and a `click` from a link to LinkedIn or GitHub. Check the click's destination details. Visitor count is not graded.

Use the DNS values Zoho gives your account. Preserve your website records and any mail routing you still need. If the free plan is unavailable, record the restriction and ask the instructor before choosing a paid plan.

## Submit a short results sheet

Use one file, `docs/evidence/ex06.md`. If you already started it, add to it. Include only these three items:

1. An email table with three rows: received, replied, and sent a new message. You can use the Zoho MCP server to run the tests and help build the table. Give the test time and result for each. Confirm replies and new outgoing messages arrived in the outside mailbox.
2. One screenshot or pasted excerpt showing SPF, DKIM, and DMARC results. You can use the Zoho MCP server to retrieve available message details and have your agent summarize the authentication results. Include the actual results it used. For outgoing mail, use the outside mailbox's results, supplying its header to the agent if needed. If your mailbox doesn't show them, say so and report Zoho's verification results instead. Zoho's checks confirm the setup, not whether a particular message passed authentication.
3. Your live site and Privacy page links, plus screenshots showing `page_view`, `click`, and the click's `link_url`, `link_domain`, and `outbound` details. Use as few screenshots as necessary.

If a check failed, briefly note what you tried, what happened, and your next step. No separate written explanation is required.

Keep message bodies, personal addresses, tokens, and account recovery details out of the public file. You don't need to submit full DNS output, separate analysis files, deployment commit IDs, installation-test screenshots, or the before-setup email experiment. Webmail and the Zoho MCP server are both acceptable. No extra Test 04 row is required.

Your agent can help organize the results. Check its draft against what you observed. Commit and push the file, then open its direct GitHub link. Link the same evidence from `docs/project-1-submission.md` for Project 1.

## How credit works

This exercise is credit/no credit: 15 points or 0 points. Credit reflects a meaningful attempt to configure and test both domain mail and Google Analytics. Honest failed tests and technical mistakes can earn credit with feedback. Absent work or a submission without a meaningful attempt receives no credit.
