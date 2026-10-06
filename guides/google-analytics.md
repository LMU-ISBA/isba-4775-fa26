# Measure your website with Google Analytics 4

For Thursday, October 15. By Wednesday, October 14, create a Google Analytics account, a GA4 property, and a web data stream for your production HTTPS site. Bring the stream's Measurement ID, which usually begins `G-`. Account setup and website installation are separate steps. The account can exist before your site sends an event.

Use the site you control. This lab asks you to confirm one `page_view` and one useful outbound `click`, then explain what they mean. A particular visitor count is not graded. Analytics reflects measured browser activity, with delays and privacy limits. It is not a census of everyone who visited.

## Prepare the web stream

1. At https://analytics.google.com, create an Analytics account if needed. Create a GA4 property for the site. Use the time zone you want for your reports.
2. Under Admin > Data streams, add a **Web** stream using the final production `https://` address. Open that stream and copy its Measurement ID. Check the property selector if you have more than one property.
3. In that stream's Enhanced Measurement settings, turn on the option for outbound clicks. If it is already on, leave it on. Google records this as a `click` event for a link to another domain. Choose an actual external project, portfolio, or professional link on your page for the test. A link to another page on your own domain is not an outbound click. GA4 also excludes domains listed for cross-domain measurement, so choose a destination outside that list.
4. Check that the chosen link's URL has no email address, token, or private query parameter. `link_url` can be collected as an event parameter. Page URLs and titles can also be collected.

Google's account and stream setup: https://support.google.com/analytics/answer/9304153
Outbound clicks: https://support.google.com/analytics/answer/13566436

## Install one Google tag in your site

Find the shared HTML template that renders the site's `<head>`. Add the Google tag from your stream's **View tag instructions > Install manually** immediately after `<head>`. A simple direct-tag shape is below. Replace both `G-EXAMPLE123` values with the same Measurement ID from your web stream. Google Tag Manager is not needed for this lab.

```html
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-EXAMPLE123"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-EXAMPLE123');
</script>
```

Put the tag in the common template once. Do not put copies in both a layout and a page, and do not also install a second GA4 tag through a plugin or Tag Manager. A duplicate can count one visit twice. Render the page locally and inspect its HTML to see one tag and the correct ID. The Measurement ID identifies the stream and is used in browser code. It is not a secret. Do not put a service-account key or API secret in the page.

Review the diff and test locally. Commit and push the change through your normal Railway deployment path. Connect the commit SHA to the successful Railway deployment. Load the final HTTPS domain and use View Source or developer tools to confirm that the served page contains your tag once. A local template check alone does not show that Railway deployed it.

## Verify measured activity

Use your own controlled browser session. Respect any consent choice you set for your site and browser privacy settings. Do not ask classmates or other visitors to disable privacy tools or generate traffic for your grade.

1. In GA4, open Reports > Realtime for the correct property. Load your production HTTPS page yourself. Wait several minutes, then look for `page_view` in the event list. Google says initial collection can take up to 30 minutes. Standard reports can take longer.
2. Click the chosen external link once. Look for the `click` event. Inspect its parameters or link dimensions, especially `link_url`, `link_domain`, and `outbound`, where the interface exposes them. Confirm the destination matches your test. Another type of click or a page view does not prove outbound-link measurement.
3. If Realtime does not show enough event detail, use Tag Assistant on your own browser and DebugView. DebugView requires debug mode, which Tag Assistant can enable for your device. Confirm the event and its parameters there. A network request in developer tools can help diagnose a tag, but it does not by itself prove GA4 displayed the event.
4. Record the test time, timezone, production URL, action, observed event names and parameters, and where you observed them. Redact account and visitor information. Explain why an outbound project link helps you understand your site, and what it cannot tell you about a visitor's intention.

Google's verification guide: https://developers.google.com/analytics/devguides/collection/ga4/troubleshoot
Realtime and DebugView: https://support.google.com/analytics/answer/9322688 and https://support.google.com/analytics/answer/7201382

## If the event is missing

Check in this order. Confirm the final HTTPS page is the one you changed and that Railway deployed your commit. Inspect its HTML for one tag with the stream's exact Measurement ID. Check the selected GA4 property and stream. Confirm Enhanced Measurement's outbound click option is on and the link leads to another domain that is not listed for cross-domain measurement. Wait for processing, then repeat your own controlled test. Review property data filters and any consent settings. Privacy extensions or an ad blocker may prevent collection in your browser. You may use another browser you control for diagnosis, with its normal consent choice. Do not override someone else's privacy preference.

Record what you observed at each step. If Realtime or DebugView never shows the event, report it as unverified. Do not use a fabricated screenshot or event count.

## Keep the data appropriate

Do not send email addresses, message contents, names entered in forms, or other personal information in event names or parameters. Check page URLs, titles, outbound link URLs, and query strings for accidental personal data. Keep the website usable when tracking is blocked. Follow the privacy and consent expectations for your site and audience. Ask the instructor if you need help deciding what to disclose. This guide is a technical lab, not legal advice.

Google's PII guidance: https://support.google.com/analytics/answer/6366371

Link your dated verification entry from `docs/project-1-submission.md`. Your evidence should connect the tag, live site, `page_view`, outbound `click`, and your explanation. It should state clearly which checks were observed and which remain open.
