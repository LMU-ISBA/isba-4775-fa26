# Exercise 05: Investigate a DNS or TLS failure

**Due Tuesday, October 13, 2026, at 1:45 PM Pacific. 15 points.** Submit your public `career-platform` repository URL and a direct GitHub link to `docs/evidence/ex05.md` in Brightspace.

Your job is to investigate one failed network, DNS, or TLS check. Predict what should happen, record what happened, locate the failing step, make or propose a safe repair, and repeat the same check. You can use a failure you already investigated if you saved its actual before and after evidence. Otherwise, use the simulation below. A deliberate lab failure must be labeled as such.

Do not break the DNS records or certificates serving your Project 1 domain. Ex04 and Project 1 still need the working site. You don't need to edit your computer's hosts file, shorten a live DNS TTL, or purchase anything for this exercise.

## Choose your investigation

For an actual failure, choose a test hostname or isolated lab that you control, or reuse a prior failure with dated evidence. A domain cutover problem can count if you recorded the failed check before fixing it. Write down the hostname, network, resolver when relevant, and the exact command or browser check. Protect secrets and private account details. If you cannot safely reproduce the failure, use the simulation.

The following simulation is complete and needs no external account. Its hostnames, IP addresses, commands, and outputs are invented for this lab. Do not present them as results from your domain. Assume `site.lab.example` should reach a new Railway deployment. The Railway-provided URL has already returned the current page and database content. Cloudflare is authoritative for `lab.example`, and the site's record is DNS only.

Before repair, the zone contains an old Azure record:

```text
site.lab.example.  300  IN  A  198.51.100.24
```

The first check fails:

```text
$ dig site.lab.example A +noall +answer
site.lab.example.  300  IN  A  198.51.100.24

$ curl -Iv https://site.lab.example/
* Connected to site.lab.example (198.51.100.24) port 443
* Server certificate: subject: CN=old-vm.lab.example
* SSL: certificate subject name does not match target host name 'site.lab.example'
curl: (60) SSL certificate problem: certificate subject name does not match target host name
```

The deployment dashboard supplies `current-app.up.railway.app` as the routing CNAME target. In this simulation, the ownership TXT record has already verified. Before opening the follow-up results, write your diagnosis and proposed DNS or TLS repair. Say which failed observation supports your choice.

<details>
<summary>Open the simulated follow-up after writing your first diagnosis</summary>

A lab operator made one record change and waited for the simulated DNS answer to update. These are supplied results, not checks you ran:

```text
$ dig site.lab.example A +noall +answer
site.lab.example.  300  IN  CNAME  current-app.up.railway.app.
current-app.up.railway.app.  300  IN  A  203.0.113.44

$ curl -Iv https://site.lab.example/
* Connected to site.lab.example (203.0.113.44) port 443
* Server certificate: subject: CN=site.lab.example
* SSL certificate verify ok.
< HTTP/2 200
```

</details>

Compare the first and repeated DNS answers, connected addresses, certificate names, and HTTP results. Identify the record change and explain which fault occurred first. Say whether the repeated checks support your initial diagnosis or require you to revise it. The sample IPs are documentation addresses, so don't try to browse them. If a real cutover still shows mixed answers across resolvers, record that uncertainty and repeat later. A DNS answer alone does not prove HTTPS or database content works.

## Record the work

Create `docs/evidence/ex05.md` in your `career-platform` repository. Use these headings, with short answers in your own words:

1. **Setting and prediction:** State whether this is your real system, a safe lab, or the supplied simulation. Name the failed check and predict the expected result.
2. **Failed check and evidence:** Give the command or action, date, and actual result. For the simulation, quote the relevant supplied output and label it simulated.
3. **Diagnosis:** Trace DNS to the destination, then TLS to the certificate. Explain what the evidence supports and what remains uncertain.
4. **Repair and repeated check:** Describe your proposed change and show the same check after repair. For the simulation, identify the change shown by the follow-up DNS answer. Say you interpreted the supplied output rather than ran it, and compare it with your initial proposal.
5. **What you learned:** Explain one other check that would distinguish a DNS problem from a TLS or application problem. If the failure remains, say what you would check next.

Your coding agent may help interpret output or organize the record. Check its explanation against your evidence, and be ready to explain the diagnosis yourself. Never invent a command result or claim a repair worked when you did not verify it.

Commit and push the evidence file. Open its direct GitHub link to confirm that the file is readable. You can link this investigation from your Project 1 README and `docs/project-1-submission.md` as the network, DNS, or TLS failure record. It doesn't require a second report.

## How credit works

This exercise is credit/no credit: 15 points or 0 points. A meaningful attempt includes an investigation and your explanation, even if your diagnosis or repair needs correction. I will use missing or mistaken checks for feedback. Work that is absent or does not show a meaningful attempt receives no credit.
