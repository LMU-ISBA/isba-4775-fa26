# Measure your website with Google Analytics 4

By Wednesday, October 14, create a Google Analytics account, GA4 property, and Web stream for your production HTTPS site. Bring its Measurement ID (`G-`) and saved Google tag code to class on Thursday, October 15. Stop before installing the tag.

In class, you'll deploy the tag, observe one `page_view` and one useful outbound `click`, and explain them. Visitor count is not graded. Tracking has delays and privacy limits.

## Choose recognizable names

Use this naming convention when creating your setup:

| Field | Use | Example |
|---|---|---|
| Account name | Your name | `Greg Lontok` |
| Property name | Your website domain | `greglontok.com` |
| Web stream name | Your domain + Web | `greglontok.com Web` |
| Website URL | Your live HTTPS address | `https://greglontok.com` |

Already used different names? You can keep them if they're clear. To rename them, select the correct account and property in Admin:

- Account > Account details: edit the name and Save.
- Property > Property details: edit the name and Save.
- Data collection and modification > Data streams: open your Web stream, click the pencil icon, edit Stream name, and click Update stream.

You need Editor access or above. Rename the existing items instead of recreating them. Changing these labels keeps your collected data and Measurement ID. Google's instructions: https://support.google.com/analytics/answer/9304776

## Before class: create the account, property, and stream

1. At https://analytics.google.com, create the account and GA4 property using the names above. Choose your reporting time zone and currency. For a personal career site, select Jobs & Education and Small (1 to 10 employees).
2. Select Understand web and/or app traffic and View user engagement & retention as your objectives. Review the terms for your country and accept if you agree.
3. Choose Web. Select `https://` and enter your domain in the adjacent field. Name the stream and keep Enhanced measurement enabled, including Outbound clicks. Click Create & continue.
4. When Set up a Google tag appears, copy and save the complete code under Install manually. Save the Measurement ID (`G-`) too. Close the panel and click Next to finish setup. Leave installation and Test installation for class.

To find the code again, open Admin > Data collection and modification > Data streams. Select your Web stream, then View tag instructions > Install manually.

## In class: install, deploy, and test

Open your site repository in your coding agent. Paste your saved tag after this prompt:

> Add this Google tag to my website's shared HTML template immediately after the opening head tag. Check for duplicates, verify it appears once in the rendered HTML, and show me the diff before committing or deploying.

1. Review the diff and rendered local HTML. Confirm one tag installation with the same Measurement ID in the script URL and config call. An additional copy through a plugin or Tag Manager can double-count. The Measurement ID belongs in browser code. Service-account keys and API secrets do not.
2. Commit and push to deploy through Railway. Match the commit SHA to the successful Railway deployment. View the live HTTPS page source and confirm one tag installation with your correct Measurement ID.
3. Return to View tag instructions > Install manually. Under Test your website, enter your live HTTPS URL and click Test (or Test installation). Record the result, then verify the events below.

Google guides: https://support.google.com/analytics/answer/9304153 and https://support.google.com/analytics/answer/13566436

## Verify what GA4 received

Use a browser session you control and honor its consent/privacy choices. Do not ask others to disable privacy tools or generate traffic.

1. Open Reports > Realtime overview in the correct GA4 property. Load your live HTTPS page in another tab. Scroll to Event count by Event name and find `page_view`. Initial collection can take up to 30 minutes. Standard reports take longer. The active-user counter alone doesn't verify a specific event.
2. Choose a real link from your site to another domain, outside any cross-domain measurement list. Check that its URL contains no email, token, or other private data. Click it once, then return to the event card and allow a few minutes for `click` to appear.
3. Select the `click` row. Inspect `link_url`, `link_domain`, and `outbound`. Confirm the destination matches the link you clicked and that `outbound` indicates true. Save screenshots of the event list and parameter values.
4. If Realtime lacks detail, use Tag Assistant and DebugView for your own device. A successful installation test or network request doesn't establish that GA4 displayed both events.
5. Record the time and time zone, live URL, action, event names and parameters actually seen, and where you saw them. Explain what the outbound event helps you learn. It doesn't establish why someone clicked or what they did on the destination site.

Google guides: https://developers.google.com/analytics/devguides/collection/ga4/troubleshoot , https://support.google.com/analytics/answer/9322688 , and https://support.google.com/analytics/answer/7201382

If an event is missing, check the live deployment and single tag/ID, selected property and stream, outbound setting and destination, consent/privacy settings, and processing delay. Retest in a browser you control. Record the failed observation. Do not claim an unobserved event. Keep personal information out of event names, URLs, titles, and parameters (https://support.google.com/analytics/answer/6366371). The site must work when tracking is blocked.

Link your dated evidence from `docs/project-1-submission.md`: connect the deployed tag to the observed `page_view`, outbound `click` and parameters, and your interpretation. Label any unverified check.
