# Exercise 01: Accounts, your home network, and the self-discovery interview

**Due** Tue 9/8, before class · **15 points** · **Type:** Config ·
**Submit** on Brightspace: the interview, the drawing, and your repository URL

## The work

### 1. Install a password manager before you create anything.

You'll create about eleven accounts across this course, starting with three today. Reusing one password across them turns a single breach into eleven. Inventing eleven strong passwords by hand is tedious, so this is the week people start reusing one.

Bitwarden's free tier covers everything this course needs. 1Password is also
good, and it's worth checking whether it's included in your GitHub Student
Developer Pack. The one built into your browser or operating system counts, as
long as you actually use it.

Put your GitHub password in it today, along with your GitHub two-factor
recovery codes. Those codes are easy to lose, and losing them locks you out of
the repository holding every exercise you've submitted.

### 2. Create or verify these accounts now.

| Account                                                            | Notes                                                                                                                                                       |
| ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [GitHub](https://github.com/signup)                                | Your portfolio repository lives here                                                                                                                        |
| [GitHub Student Developer Pack](https://education.github.com/pack) | Apply on day one. Verification takes a few days, and it covers a .me domain for a year and credits on Railway                                               |
| [Claude Pro](https://claude.ai/login?plan=pro)                     | Subscribe at full price, because there's no student rate. [OpenAI's Codex](https://openai.com/codex/), on a ChatGPT subscription, is an accepted alternative. You need one of the two for the interview below and for Exercise 02 |

### 3. Run the self-discovery interview.

[self-discovery-interview.md](self-discovery-interview.md) in this repository is a
prompt you paste into Claude. It interviews you, one question at a time, for about fifteen
minutes, and writes a Markdown file at the end. Answer honestly rather than impressively.
Nothing in it is graded and nothing in it is compared against anyone else.

Two people with the same prerequisite walk into this course having deployed nothing and
having run a side project on AWS for a year. Both are normal. This is how I find out which
one you are, so I can teach you rather than an average of the room.

Your portfolio repository is public, and this file has your career plans in it. So it
goes on Brightspace rather than into your repository.

### 4. Draw the network you live on.

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

Then run Thursday's commands on that network. They're in the two Teams
messages from Thursday's class, one for Mac and one for Windows.

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

## What to submit

Nothing goes in your repository for this exercise. Three things go on
Brightspace: the interview file, the photo of your drawing, and the URL of
your portfolio repository, set up following
[portfolio-repository.md](../guides/portfolio-repository.md), which shows me
it exists and is public. Most
exercises want a plan, a working system, and an evidence README, and this one
has none of them, because nothing gets built yet. That starts in Exercise 02.
