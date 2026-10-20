# Midterm whiteboard interview study guide

Practice explaining how a request travels from your device through the network to a working application and back. Draw the hardware and services, investigate failures, and explain your choices out loud.

The central midterm question is:

```text
What happens when you enter your domain in a browser and press Enter? Explain
it for Azure, then what changes on Railway.
```

Practice one connected explanation from entering the address to seeing the page.
Use your drawing to show both the physical network and the services handling the request.

Your site has run in two places: the Azure VM and Railway. This guide calls each one a host. Draw one host fully, then say what changes on the other.

The interview covers our first-half class material, Exercises 01 through 06, and Project 1. Your project gives you the examples, and your spec and implementation plan are the best study source you have.

Interviews run October 26, 27, and 28 in Hilton 114 and are worth 125 points. Book one 20-minute appointment:

https://calendly.com/greg-lontok/4775-midterm-interview-fa26

The interview itself is 15 minutes, followed by a five-minute debrief. You'll work from memory, without notes or your repository. Tuesday's interviews replace our October 27 class period.

## How the 20 minutes run and how you're scored

The interview has a fixed shape so you know what's coming:

1. Minutes 0 to 6: draw and narrate the request path for one host, Azure or Railway, then say what changes on the other. You choose which host to start with.
2. Minutes 6 to 10: follow-ups on your design, spec, and plan.
3. Minutes 10 to 12: one troubleshooting scenario.
4. Minutes 12 to 15: one changed constraint.
5. Minutes 15 to 20: debrief. I'll tell you how you did on each row of the table and name one explanation to practice before the final.

Fifteen minutes is short, so start drawing right away and talk while you draw.

I'll interrupt with "why" and "how do you know" throughout. Saying what you don't know and naming the check you'd run scores as proficient. An invented detail scores below "I don't know, I'd check X."

| What I listen for | Points | Developing | Proficient | Strong |
| --- | --- | --- | --- | --- |
| Request path | 40 | Lists parts, order unclear, draws the web request going through the DNS server | Connected sequence for one host, DNS separate, TLS and database placed correctly | Both hosts, client and server named per connection, where TLS ends, response and further requests |
| Network hardware and addressing | 15 | Names boxes without roles | Switch vs router, gateway vs DNS server, private vs public address | Adds DHCP, NAT, firewall behavior, and which roles share one home device |
| Spec, plan, and design reasoning | 25 | Describes what, not why | Explains what the spec promised, the plan's main steps, one choice with its alternative, and environment variables | Explains where the build departed from the plan, who owns what on each host, and actual costs |
| Troubleshooting from evidence | 25 | Guesses a fix | Picks a narrowing check and says what the result proves | Sequence of checks, separates an empty table from a failed connection, names the recovery check |
| Changed constraint | 15 | Adds services without a reason | States assumptions, changes the affected part, gives one tradeoff | Adds verification and rollback, and says what the change could make worse |
| Labeled unknowns | 5 | Invents details | Says what's unknown | Turns the unknown into a check |

Developing earns about 40 percent of a row, proficient about 75 percent, and strong the full row.

## 1. Draw the whole request path

- [ ] Draw the physical network, then place the services on it.
- [ ] Trace a request and its response, naming the client and server on each connection.
- [ ] Draw Azure or Railway fully, then mark what changes on the other.

Start with a new HTTPS connection using TCP and a DNS lookup without a cached answer.
State those assumptions so your explanation has a clear starting point.
Use this sequence to practice:

1. The browser reads what you typed, supplies a scheme, and extracts the hostname. We'll assume it tries http first, gets redirected to https, and follows the redirect.
2. Your device asks its DNS resolver for the address. That lookup crosses your local network and comes back with an answer. It's a separate exchange, not a stop the web request passes through.
3. The browser opens a TCP connection to the returned address on port 443. The packets cross the same hardware the DNS query used: your network interface, the access point or cable, a switch, your router, the modem or ONT (the fiber box), your ISP, internet routers, and the hosting network.
4. TLS runs over that connection. The browser checks the certificate's hostname, dates, and chain, then the two sides agree on keys. Say where TLS ends.
5. The HTTP request goes through the web entry to the application and any database access it needs.
6. The response returns the same way. The browser renders the HTML and requests CSS, scripts, images, and any API data as separate HTTP requests.

Be ready to explain how a cached DNS answer changes your starting sequence.

Start the hardware with your network interface and its wired or Wi-Fi connection. Include the access point, switch, router, firewall, modem or fiber box, and ISP where applicable. Home equipment usually combines several roles in one box, while campus networks separate them. Label unknown provider details as unknown instead of inventing them.

A switch connects devices within a local network, while routers forward traffic between networks. Access points connect wireless devices. Your home router also does NAT: it rewrites your private source address to its public one, remembers the flow, and maps the reply back to your laptop. That public address is what the server's log shows as the client. A firewall permits or blocks traffic by rule, and a stateful firewall lets the reply in because it saw the request go out.

Add your device's private IP address, subnet, default gateway, and DNS server. Explain what DHCP supplies and how a public address differs from a private one. Use your Exercise 01 observations to explain the settings, without memorizing your exact addresses.

Separate the DNS lookup from the web request, and identify the URL's scheme, hostname, port, and path. DNS used UDP and the site uses TCP. Say why that fits each. Distinguish software ports from physical network ports.

For Azure, show the network security group, Nginx, the application process, and the SQLite file. TLS ends at Nginx, which then talks plain HTTP to the application on the loopback address. For Railway, show its web entry, the application, and the PostgreSQL service. TLS ends at Railway's edge, which is why your app saw plain HTTP behind it and needed the forwarded-protocol setting. Label protocols, ports, and public and private connections, and name the client and server for each connection. The www redirect is a separate request. Explain it only if asked.

I may ask:

```text
Where do the VM and container run, and what does localhost mean in each
environment?
```

Connect physical CPU, memory, storage, and a network interface to the operating system and the software on it. Locate your laptop terminal, your Codespace terminal, and your SSH session. Localhost means the machine running the program that used the name.

## 2. Defend your spec and plan

Your repository holds the spec in `docs/superpowers/specs/` and the implementation and migration plans in `docs/superpowers/plans/`. Reread them before the interview. I'll ask you to defend them at a high level, not line by line through the code.

Be ready to explain, from memory:

- what the spec says the application does, for whom, and what it leaves out
- the main steps of the implementation plan, their order, and the check at the end of each step
- what the migration plan predicted and what happened when you ran it
- where the build departed from the plan and why
- one change the agent wrote that you reviewed and can explain, and one result you checked yourself

Use this prompt to study from those files:

```text
Read my spec and implementation plan without changing files. Ask me to explain
from memory what the app does, the main steps of the plan and why they're in
that order, and where the build departed from the plan. Don't quiz me on code.
```

I may ask:

```text
Why did you build it this way, and how did you prove it worked?
```

Explain two choices and the alternatives you considered. For each host, say what's on you and what's on the provider when the site goes down at 2 AM: the OS, the runtime, certificates, the application, and the database. Know your actual costs, credits, and expiration dates.

Explain how environment variables give the same code different settings. On Azure, the database URL identified the SQLite file. On Railway, it supplied the PostgreSQL connection, while the port variable supplied the application's listening port. The local transfer used a separate public database URL. Find these names in your own configuration:

```text
DATABASE_URL
PORT
RAILWAY_DATABASE_URL
```

A Git push preserves committed files, not every running service, setting, or current database row. Say what reverting a commit restores and what it can't.

## 3. Everything else that may come up

Follow-ups can reach any of these. They're a reference for review, not a list to memorize. Practice explaining the result of each action, not just naming a command.

| Work | Be ready to explain |
| --- | --- |
| Exercise 01 and early networking classes | Your home network drawing, device roles, IP settings, and what ping, a DNS lookup, and traceroute reveal. |
| Exercise 02 and the service lab | Where Nginx and MySQL run in the Codespace, installation versus a running process, listening ports, Linux service controls, and private port forwarding. Why stopping MySQL leaves the Nginx welcome page working. |
| Exercise 03 and the build/migration classes | Your spec, plan, and agent review, covered in section 2. Dependencies, the Python environment, SSH keys, firewall restrictions, and moving code separately from live data. |
| Exercise 04 and operating the VM | Domain registration, name-server delegation, DNS records, Nginx reverse proxying, application workers, and systemd restart behavior. Certificate hostname checks, HTTP-to-HTTPS redirection, and renewal. |
| Exercise 05 and the Railway migration | DNS caches and TTL, A and CNAME records, and checking the actual destination and certificate. Cloudflare flattens the root CNAME, so a lookup returns A records for Railway's edge even though the dashboard shows a CNAME. SQLite-to-PostgreSQL migration, comparing source and target data, and verification before cutover. |
| Exercise 06 and the email/analytics classes | Where domain mail goes, and which of MX, SPF, DKIM, and DMARC you'd look at first if a reply landed in spam. What an MCP server lets your coding agent do and how you checked its mail actions. How a browser event reaches GA4, and what you observed. |

## 4. Troubleshoot from evidence

- [ ] State the symptom and choose a check that narrows the cause.
- [ ] Explain what the result proves and what remains unknown.
- [ ] Repair the cause, then repeat the original check.

Each layer fails in its own way. Use the symptom to pick the first check. The questions below are ones I may ask, each followed by what I listen for.

| What the browser shows | Look first at |
| --- | --- |
| Name not found | DNS |
| Connection timed out | Firewall rule or wrong address |
| Connection refused | Nothing listening on that port |
| Certificate warning | TLS: hostname mismatch or expired certificate |
| 502 | Nginx is up and the application is down |
| 503 | The application is up and the database is unavailable |
| Page loads with no projects | Empty table or query, not connectivity |

```text
Tell me about something that actually broke. What did you see, what did you
check, and what fixed it?
```

Use the two failures you investigated for Project 1. Say what each check ruled out.

```text
Your site loads for you but not for your roommate. What do you check first,
and what does each result rule out?
```

Explain what you'd learn from IP settings, ping, a DNS lookup, traceroute, a port check, curl, or browser DevTools. A failed ping alone doesn't prove a website is down, and a DNS answer doesn't prove HTTPS works.

```text
Your database dies at 2 AM. What does a visitor see, and how would you know it
was the database and not the app?
```

Distinguish independent services from an application's dependency. Explain process and listener checks, HTTP status codes, application logs, and database queries. Separate an empty table from an unavailable database, then state the healthy result you expect after recovery.

```text
Your Azure site fails after a restart, or Railway loads the page without its
projects. What do you check next?
```

Use the drawing to choose between network rules, Nginx, the application service, database availability, and configuration. Explain why binding an application to an address differs from allowing traffic through a firewall. Name the check that proves recovery.

```text
What on your system can a stranger reach right now? How would you restore
PostgreSQL if it were lost? How would you know the site was down before I told
you?
```

For supporting services, verify the destination too. A message in Sent doesn't prove receipt, and a GA4 tag in source doesn't prove an event arrived.

## 5. Adapt in three minutes or less

State your assumptions, revise the affected part of the drawing, and explain one tradeoff. Finish with a verification and recovery plan. The practice scenarios below use the announced categories: traffic, budget, and a service ending. The interview uses a different specific constraint, so practice the method rather than the answers.

```text
Your site receives five times its usual traffic. What would you measure before
changing the system?
```

Identify a possible bottleneck and a measurement that would support a change.

```text
Your monthly hosting budget is cut in half. What would you change and give up?
```

Use actual costs and explain how you'd verify the cheaper setup.

```text
Your Railway trial ends Friday. What happens to your site, your data, and your
domain, and how do you move without losing recent writes?
```

Account for code, data, configuration, DNS, and HTTPS. Explain cutover and rollback, including what happens to new writes.

## Practice aloud with another person

Practice with a classmate, friend, family member, or roommate. Someone outside the course can tell you where your explanation becomes confusing, so explain technical terms as you go.

Give your partner the scoring table and three follow-ups to use on any claim: why, how do you know, and what if that's wrong. Draw from memory and say your answers aloud for 12 minutes, then take up to three minutes for one changed constraint. Spend the last five minutes scoring on the table together. Pause when you need to think, and say what you'd check if you don't know.

Afterward, score yourself on the table, identify one missing step, and try that answer again.

## Use Claude Code or Codex to study

Give the agent this guide and access to your course materials and project. Use this prompt:

```text
Read this study guide, the course materials, and my project without changing
files. Interview me one question at a time across the full course scope. Wait
for my answer before giving feedback. Check it against the materials, flag
anything unverified, and give me one improvement to practice.
```

Say each answer aloud before sending it. Use speech-to-text if available, or type what you just said without polishing it. Tell the agent if a course source isn't available so it doesn't guess what we covered.

For another attempt, use a short follow-up:

```text
Ask me about network hardware and packet travel. Let me explain before giving
hints.
```

Change the topic to your weak spot. Check corrections against the course materials and your evidence, since the agent can make mistakes.

Review Exercises 01 through 06 in Brightspace. Use the Project 1 requirements for the submission checks:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/projects/own-your-corner-of-the-internet.md
