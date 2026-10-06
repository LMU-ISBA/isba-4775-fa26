# Measure your website with Google Analytics 4

For Thursday, October 15: by Wednesday, October 14, create a Google Analytics account, GA4 property, and Web stream for your production HTTPS site. Bring its Measurement ID (`G-`). The account can exist before the site sends data. Your task is to observe one `page_view` and one useful outbound `click`, then explain them. Visitor count is not graded. Tracking has delays and privacy limits.

## Set up the stream and tag

1. At https://analytics.google.com, create the account and GA4 property. Under Admin > Data streams, create a Web stream for the final `https://` address. Copy its Measurement ID and check the selected property.
2. In Enhanced Measurement, enable outbound clicks. Choose a real link from your site to another domain, outside any cross-domain measurement list. Check that its URL and query string contain no email, token, or other private data. GA4 may collect `link_url`.
3. In the shared HTML template, put the stream's View tag instructions > Install manually Google tag immediately after `<head>`. Use the same Measurement ID in both places:

```html
<script async src="https://www.googletagmanager.com/gtag/js?id=G-EXAMPLE123"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-EXAMPLE123');
</script>
```

Install one direct tag in the common template, not another copy on a page, through a plugin, or through Tag Manager. A duplicate can double-count. The Measurement ID belongs in browser code. Service-account keys and API secrets do not. Check the rendered local HTML and diff, then commit and deploy through Railway. Match the commit SHA to the Railway deployment. View the live HTTPS page source and confirm one tag installation with your correct Measurement ID.

Google guides: https://support.google.com/analytics/answer/9304153 and https://support.google.com/analytics/answer/13566436

## Verify what GA4 received

Use a browser session you control and honor its consent/privacy choices. Do not ask others to disable privacy tools or generate traffic.

1. Open Reports > Realtime in the correct GA4 property. Load your live HTTPS page. Wait several minutes and find `page_view`. Initial collection can take up to 30 minutes. Standard reports take longer.
2. Click your chosen external link once. Find the `click` event and inspect `link_url`, `link_domain`, and `outbound` where shown. Confirm the destination. A different click or a `page_view` alone does not prove outbound measurement.
3. If Realtime lacks detail, use Tag Assistant and DebugView for your own device. A browser network request helps diagnose delivery but does not prove GA4 displayed the event.
4. Record the time zone, live URL, action, event names and parameters actually seen, and where you saw them. Explain what the outbound event helps you learn and what it cannot tell you about a visitor's intent.

Google guides: https://developers.google.com/analytics/devguides/collection/ga4/troubleshoot , https://support.google.com/analytics/answer/9322688 , and https://support.google.com/analytics/answer/7201382

If an event is missing, check the live deployment and single tag/ID, selected property and stream, outbound setting and destination, consent/privacy settings, and processing delay. Retest in a browser you control. Record the failed observation. Do not claim an unobserved event. Keep personal information out of event names, URLs, titles, and parameters (https://support.google.com/analytics/answer/6366371). The site must work when tracking is blocked.

Link your dated evidence from `docs/project-1-submission.md`: connect the deployed tag to the observed `page_view`, outbound `click` and parameters, and your interpretation. Label any unverified check.
