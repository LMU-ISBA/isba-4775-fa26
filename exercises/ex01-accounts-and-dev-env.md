# Exercise 01: Accounts and development environment

**Due** Tue 9/8, before class · **15 points** · **Type:** Config ·
**Submit** as `ex01/` in your public portfolio repository, plus two files on Brightspace

## Why this one is first

Everything you build this semester sits on the accounts and tools you set up  
here. The site in Exercise 03, the domain in Exercise 04, the orchestration in  
Exercise 07, the agent in Exercise 09, and both projects all assume this  
exercise worked. Anything skipped here comes back as a problem during a later  
exercise.

## Before you start

Read the budget table under Required materials in the
[syllabus](../syllabus.md). Most of the semester's costs come due this week, so
know what's coming before you subscribe to anything.

Set up your portfolio repository first if you haven't already. One public
repository named `isba-4775-portfolio`, one folder per exercise, `ex01` through
`ex10`. Step-by-step instructions are in
[portfolio-repository.md](../guides/portfolio-repository.md).

## The work



### 1. Install a password manager before you create anything.

You'll create about eleven accounts across this course, starting with five today. Reusing one password across them turns a single breach into eleven. Inventing eleven strong passwords by hand is tedious, so this is the week people start reusing one.

Bitwarden's free tier covers everything this course needs. 1Password is also
good, and it's worth checking whether it's included in your GitHub Student
Developer Pack. The one built into your browser or operating system counts, as
long as you actually use it.

Put your GitHub password in it today, along with your GitHub two-factor
recovery codes. Those codes are easy to lose, and losing them locks you out of
the repository holding every exercise you've submitted.

You'll name the password manager you chose in your README.

### 2. Create or verify these accounts now.


| Account                                                            | Notes                                                                                                                                                       |
| ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [GitHub](https://github.com/signup)                                | Your portfolio repository lives here                                                                                                                        |
| [GitHub Student Developer Pack](https://education.github.com/pack) | Apply on day one. Verification takes a few days, and it covers a .me domain for a year and credits on Railway                                               |
| [Claude Pro](https://claude.ai/login?plan=pro)                     | Subscribe at full price, because there's no student rate. You need it for the interview below and for Exercise 02                                           |
| [Granola](https://www.granola.ai/students)                         | Apply with your lion.lmu.edu address, and it's free for twelve months. Part of the tutorial in step 3, and it connects to Claude Code over MCP              |
| [Wispr Flow](https://wisprflow.ai/students)                        | Sign in with your lion.lmu.edu address for three months free, then half price. Part of the tutorial in step 3. Dictation, and you configure it during setup |




### 3. Complete Tutorial Part 1.

[LMU-ISBA/ai-dev-workflow-tutorial](https://github.com/LMU-ISBA/ai-dev-workflow-tutorial)
installs Git, Python 3.11+, Claude Code, and Cursor. It also sets up the
Superpowers plugin and the Granola connection, and it has you fork and clone the
tutorial repository. Part 1 ends with its own verification checklist. Fix
anything that fails there before moving on.

### 4. Run the self-discovery interview.

`[self-discovery-interview.md](self-discovery-interview.md)` in this repository is a
prompt you paste into Claude. It interviews you, one question at a time, for about fifteen
minutes, and writes a Markdown file at the end. Answer honestly rather than impressively.
Nothing in it is graded and nothing in it is compared against anyone else.

Two people with the same prerequisite walk into this course having deployed nothing and
having run a side project on AWS for a year. Both are normal. This is how I find out which
one you are, so I can teach you rather than an average of the room.

Your portfolio repository is public, and this file has your career plans in it. So it
goes on Brightspace rather than into your repository.

### 5. Draw the network you live on.

Thursday your laptop told you six things about the campus network: its name,
its address, the mask, the gateway, the DNS server, and the address the rest
of the internet sees. Now find out the same six where you live, find the
boxes they belong to, and draw the network.

Start with the boxes. Go look at what the wire from the street plugs into,
and at what's plugged into that. Read the labels: the maker, the model, and
whether it's one box or two. If you rent the equipment, the ISP's app or
account page says what the box is. Note which devices are wired and which are
on Wi-Fi. In a dorm there's no box to find. The network you live on is
Tuesday's building drawing, and the parts you can't see get a question mark.

Then run Thursday's commands on that network.

```
Mac                                    Windows
hostname                               hostname
ifconfig en0                           ipconfig /all
ipconfig getpacket en0                 (same output, further down)
nslookup chatgpt.com                   nslookup chatgpt.com
curl -4 ifconfig.me                    curl.exe -4 ifconfig.me
traceroute -n -q 1 -w 2 chatgpt.com    tracert -4 -d -w 1000 chatgpt.com
```

Now draw it, by hand, on paper or on a tablet with a stylus rather than in a
diagramming tool, because both whiteboard interviews are hand drawings and
this is the first one. Start at your laptop and end at the internet. Every box
you found goes in, with what it is written beside it, and everything your
laptop told you goes beside the box it belongs to. If the gateway, the DHCP
server, and the DNS server are all one address, that's one box doing three
jobs, and the drawing should say so. If the DNS server is an address outside
your house, its box goes in the cloud.

Photograph the drawing, name the file `home-network-firstname-lastname.jpg`
with your own names in it, and submit it on Brightspace. It doesn't go into
your repository. The drawing has every number on it, and some of them
identify your household, so it stays between you and me the same way the
interview does. Take the photo in daylight and check that every number is
readable before you submit it.

## What to commit

One file in `ex01/`, `README.md`. Most exercises also want a `plan.md`, and
this one doesn't, because step 2 already lists every account and a plan would
copy it back. The drawing and the interview go to Brightspace.

`README.md` opens with two lines. The first names the password manager you
installed and confirms that your GitHub password and your two-factor recovery
codes are in it. The second is the URL of your fork of the tutorial
repository.

The rest of it is your evidence README: what broke while you were doing this and
how you fixed it. Account verification and billing setup fail in ordinary ways,
and writing down what you did about it is the beginning of the troubleshooting
practice this course grades. If genuinely nothing broke, say what you expected
to break and did not.

Then a section headed "Where I live." Two short lines, then two sentences:

- home or dorm
- what the box on the shelf is: a rented gateway, your own router and modem,
  or nothing, because it's a dorm

The two sentences are what was different from Hilton 115 on Thursday, and
why. The numbers themselves stay on the drawing, which is on Brightspace,
and none of them go in the README.

Finish the README by answering "The change," which is the last section of this
brief.

## The change

Every exercise ends with a change I hand you after your work is done. You don't
build for it and you don't fix it. You answer it in two or three sentences at
the end of your README: what breaks, what you would do about it, and what that
costs you in time or money.

Here is the one for Exercise 01.

> Your GitHub Student Developer Pack application is rejected because the photo of
> your student ID is unreadable, and reapplying takes another four days.
> Exercise 03 needs the Railway credits in two weeks.



## Done means

- [ ] A password manager installed, holding your GitHub password and two-factor recovery codes
- [ ] All five accounts in step 2 created, with two-factor turned on for GitHub
- [ ] Tutorial Part 1 complete, every tool running on your machine
- [ ] Home network drawn by hand with what you found on it, photographed, named `home-network-firstname-lastname.jpg`, and submitted **on Brightspace**
- [ ] `ex01/README.md` naming your password manager, linking your fork, what broke, "Where I live," and "The change" answered
- [ ] Self-discovery interview completed and the Markdown file submitted **on Brightspace**
- [ ] Your repository URL submitted **on Brightspace**
- [ ] Pushed to your public portfolio repository before class Tue 9/8



## If you get stuck

Post in the course Teams channel or send me a Teams DM. Being stuck is normal, and many may have similar issues.