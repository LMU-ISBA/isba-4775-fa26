# Measure your website with Google Analytics 4

By Wednesday, October 14, create a Google Analytics account, GA4 property, and Web stream for your live website's `https://` address. Bring its Measurement ID (`G-`) and saved Google tag code to class on Thursday, October 15. The tag is the code that sends activity from a visitor's browser to Google Analytics. Stop before installing it.

In class, you'll add the tag to your live site, observe one `page_view` and one outbound `click`, and explain them. An outbound click follows a link to another website. Visitor count is not graded. Tracking has delays and privacy limits.

## Choose recognizable names

The account holds your properties. A property holds your website's reports, and its Web stream receives activity from the site.

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

## In class: prepare the privacy notice

GA4 uses cookies by default and sends visitor activity data to Google. Google requires a privacy policy explaining this collection. Link a Privacy page from your footer. Where applicable privacy and cookie rules require consent, analytics cookies must wait for permission, and visitors must be able to decline or withdraw it. A notice alone doesn't provide those controls.

Open your website project in your coding agent. The stream exists, but its tag isn't installed yet. Paste your saved tag after this prompt:

```text
I'm about to add GA4 with page views and outbound-click measurement. The planned tag is below. Inspect my site's existing data collection, cookies, and forms. Draft a plain-language Privacy page for the planned setup and link it from the footer. Explain what is collected, why, who receives it, and visitors' actual choices. Flag unknowns and any consent controls needed before installation. Don't claim protections that aren't implemented. Show me the changes before publishing.
```

Review the draft against the planned setup. Resolve any required consent controls before enabling analytics, and publish the accurate notice with the tag. Keep the site usable when tracking is declined.

References: https://support.google.com/analytics/answer/11397207 , https://marketingplatform.google.com/about/analytics/terms/us/ (section 7), and https://europa.eu/youreurope/business/growing/digitalising/online-privacy/indexamp_en.htm

## In class: install, deploy, and test

Open your website project in your coding agent. Paste your saved tag after this prompt:

```text
Add this Google tag to my website so it loads once on each page, respecting the site's consent controls. Check for existing tags and show me the changes and the generated page HTML before committing or deploying.
```

1. Review the code changes and the HTML your app generates. Confirm the tag appears once, immediately after `<head>`, with your Measurement ID in both places in Google's code. Installing it twice can count the same activity twice. The Measurement ID can be public. Keep passwords, API secrets, and private credentials out of the page.
2. Commit and push to deploy through Railway. Check that Railway successfully deployed the same commit, using its commit ID. Open your live site and choose View Page Source in the browser. Confirm one tag installation with your correct Measurement ID.
3. Return to View tag instructions > Install manually. Under Test your website, enter your live HTTPS URL and click Test (or Test installation). Record the result, then verify the events below.

Google guides: https://support.google.com/analytics/answer/9304153 and https://support.google.com/analytics/answer/13566436

## Verify what GA4 received

Use your own browser and respect its privacy settings and any cookie choices you made. You don't need classmates to visit your site or turn off their privacy tools.

1. Open Reports > Realtime overview in the correct GA4 property. Load your live HTTPS page in another tab. Scroll to Event count by Event name and find `page_view`. Initial collection can take up to 30 minutes. Standard reports take longer. The active-user counter alone doesn't verify a specific event.
2. Choose a link on your site to your LinkedIn profile, GitHub profile, or a GitHub repository. Check that the address contains no email address, access code, or other private information. Click it once, then return to the event card and allow a few minutes for `click` to appear.
3. Select the `click` row and check its details: `link_url` is the full destination address, `link_domain` is the website, such as `linkedin.com`, and `outbound` indicates that the link leaves your site. Confirm the address matches what you clicked and `outbound` is true. Save screenshots of the event list and these details.
4. If Realtime doesn't show those details, use Google's Tag Assistant and DebugView tools to inspect events from your browser. Follow the Google guides below. A successful installation test alone doesn't confirm that GA4 received both events.
5. Record the time and time zone, live URL, what you did, and the event names and details you saw in GA4. Explain what the click helps you learn. It doesn't establish why someone clicked or what they did on the destination site.

Google guides: https://developers.google.com/analytics/devguides/collection/ga4/troubleshoot , https://support.google.com/analytics/answer/9322688 , and https://support.google.com/analytics/answer/7201382

If an event is missing, check that the live site has the latest code and one tag with the correct Measurement ID. Confirm you're viewing the right property and stream, Outbound clicks is enabled, and the link goes to another website. Check your browser's privacy settings and cookie choices, and allow time for GA4 to process the event. Retest in your own browser and record what happened, including anything still missing. Keep personal information out of page addresses, titles, and data sent to GA4 (https://support.google.com/analytics/answer/6366371). The site must work when tracking is blocked.

Link your dated evidence from `docs/project-1-submission.md`. Include the deployed commit, live URL, installation test result, screenshots of `page_view` and `click` with its destination details, and your explanation. State which checks you haven't verified.
