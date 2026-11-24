# Staging and production

Session 24 · Week of November 24, 2026 · On your own schedule

Your agent runs when you type a command on your laptop. Nobody else can use
it, and there's only one copy, so a change can't be checked anywhere before
it's the real thing. In this lesson you put the agent behind a web page.
Then a change moves through three places before a visitor sees it: your
laptop, a staging site, and production.

## How this lesson works

There's no class meeting for this lesson. You work through it on your own
schedule, and Milestone 2 is due Thursday, December 3, at 1:45 PM, before
class.

- Each section of this guide has a short video, in the Week 13 module in
  Brightspace. Watch the video, do the section, then check the line that
  starts "You're done with this section when."
- The first video covers the ideas: the three environments, CI and CD, and
  how a change moves. Watch it before section 0.
- The voice in the videos is an AI voice reading a script I wrote. I can fix
  a mistake in a video in a few minutes that way.
- If you get stuck, post in the course's General Teams channel, so
  everyone can see the answer, or send me a DM. I'll post updates in that
  channel too.

Start early. Section 3 changes your AWS instance, and it's the part most
likely to need a question.

## Objectives

By Thursday, December 3, at 1:45 PM, you'll have:

- A page with a question box and an `/ask` route that runs your agent,
  behind a shared password.
- Tests, a linter, and a secrets scan that run on every push.
- A staging site on your EC2 instance, deployed by GitHub Actions when you
  push.
- One release decision: the commit you tested, what you observed, and
  whether you'd release it.
- A production site, and one change that moved from staging to production.

## Learning objectives

By the end of this lesson, you should be able to:

- Say what local, staging, and production are each for.
- Explain the difference between a check you run by habit and a check the
  pipeline enforces.
- Follow one commit from your laptop to production.
- Explain how GitHub Actions deploys to an instance that only accepts SSH
  from your IP address.
- Say where your API key lives in each environment, and why it isn't in the
  repository.
- Say what CI and CD mean, and point to each one in your own project.
- Say how continuous delivery differs from continuous deployment.
- Decide whether a tested commit should be released, and say what you
  observed that supports it.

## Three environments

An environment is one running copy of your app. Each copy has its own
address, its own settings, and its own job.

| Environment | Where it runs | Who sees it | What it's for |
| --- | --- | --- | --- |
| Local | Your laptop | You | Building and trying things |
| Staging | staging.yourname.com | You | Checking a change on your instance before visitors get it |
| Production | agent.yourname.com | Anyone with the password | The copy people use |

A change moves in one direction:

```mermaid
flowchart LR
    L["Your laptop"]
    C["Checks: tests, linter, secrets scan"]
    X["Stops here"]
    S["Staging"]
    P["Production"]

    L -->|"git push"| C
    C -->|"all pass"| S
    C -->|"one fails"| X
    S -->|"you promote"| P
```

### How a change moves

Nothing is copied by hand. What moves is a commit, which is one saved
version of your code with a short code such as `52e00d7`. The same commit
goes to each place, one move at a time:

| Move | What starts it | What does the work | What happens |
| --- | --- | --- | --- |
| Laptop to GitHub | You run `git push` | Git on your laptop | GitHub receives your commit |
| The checks | The push | GitHub's computers | Tests, the linter, and the secrets scan run on that commit. Nothing moves yet |
| GitHub to staging | The checks passing | A small program on your instance, called a runner | It copies that commit into the staging folder and restarts staging |
| Staging to production | You, when you choose to promote | The same runner | It copies the commit staging is running into the production folder and restarts production |

GitHub Actions coordinates all of it. It holds the commit, knows which
checks passed, tells each computer what to do, and keeps a record of every
run. You start only the last move yourself.

Each page shows its commit at the bottom. That's how you tell which version
an environment is running, and whether staging and production match.

## A habit and a gate

Teams check code in more than one place. A check on your laptop is fast, and
you can skip it. A check in the pipeline is slower, and nothing deploys
until it passes.

| | On your laptop | In the pipeline |
| --- | --- | --- |
| When | Before you commit | After you push |
| What runs | `/code-review` and `/security-review` | Tests, a linter, and a secrets scan |
| Can you skip it? | Yes, so it's a habit | No, so it's a gate |

A habit is easy to forget, so in section 1 you'll have your agent keep it
for you, with one line in a file named `CLAUDE.md`. The gate has a name,
CI, and the next section defines it.

## CI and CD: what's ahead

Job postings say "CI/CD" as if it were one thing. It's two, and you'll
build both in this lesson.

CI is continuous integration. Every time you push, a machine checks your
change right away, so a problem shows up in minutes, while the change is
still small. "Integration" means your change joining the code that's
already on main.

CD is what happens to a change after it passes. It has two forms, and they
share the same letters:

| | Continuous delivery | Continuous deployment |
| --- | --- | --- |
| After the checks pass | The change is deployed somewhere safe, such as staging, and is ready to release | The same |
| Who releases it to production | A person does, with one action | Nobody does, because the pipeline goes all the way |
| What you need to trust it | Checks, plus a person who looked | Checks strong enough to stand in for that person |

The only difference is who makes the last move. You'll build continuous
delivery, because you promote by hand. If that step ran by itself, it would
be continuous deployment.

Here's where each one shows up. Each section says so again when you get
there.

| Section | What you do | CI or CD |
| --- | --- | --- |
| 1 | Build the app on your laptop | Neither yet, since this is local |
| 2 | Write tests and add a linter | CI, since these are the checks |
| 3 | Set up two places on your instance, and a runner | CD, since these are where a change gets delivered |
| 4 | Run the checks on every push | CI |
| 4 | Deploy to staging when the checks pass | CD |
| 5 | Decide, then promote to production by hand | CD, and the person in continuous delivery is you |

Two more words go with these:

| Term | What it means |
| --- | --- |
| Pipeline | The steps a commit goes through, in order, from push to production. Yours is two GitHub Actions workflows |
| DevOps | The people who build the software also deploy it and keep it running, with automation doing the handoffs |

Before DevOps, a development team wrote the code and handed it to a
separate operations team to run. Releases were rare, and each team blamed
the other when one failed. DevOps puts both jobs on one team and automates
the handoff. GitHub Actions is the tool we'll use. It's GitHub's service
that runs steps for you when something happens in your repository, such as
a push. Jenkins, GitLab CI, and AWS CodePipeline do the same work.

Some jobs own this work: DevOps engineer, site reliability engineer,
platform engineer, and cloud engineer. Most of those postings ask for two
to five years, so think of them as a second job. The first jobs use it
every day without the title. A technical support engineer reads a failed
deploy, an implementation specialist ships a customer's setup, and a data
analyst's report runs in a pipeline someone else built. Postings for those
jobs list CI/CD, Git, or GitHub Actions as a skill.

## 0. Check your access

Do this from the network you'll work on. Two things have changed since the
AWS migration, and both stop this lesson's work.
Your AWS CLI sign-in has expired, and your instance only accepts SSH from
the IP address you had when you launched it. From a different network, SSH
times out.

In the browser, sign in to the AWS console as isba-student, not as root.
Then sign in the CLI and check who it thinks you are:

```bash
aws login --profile isba-4775 --region us-east-1
aws sts get-caller-identity --profile isba-4775
```

Find the line that starts with `"Arn"`. It should end in
`user/isba-student`. If it ends in `:root`, follow the fix in section 5 of the
[AWS migration guide](aws-migration.md). The sign-in doesn't last a full
day, so run both commands again each day you work on this.

Open your Project 02 repository in VS Code and start a new Claude Code
session named with:

```text
/rename staging-and-production
```

You set up your instance from your career-platform repository, and this
session has never seen it. AWS can tell your agent what it needs. The
prompt uses five terms from the AWS migration:

| Term | What it means |
| --- | --- |
| AWS CLI profile | The saved sign-in your agent uses to run AWS commands. Yours is named `isba-4775` |
| Public address | Where your instance sits on the internet. Yours is an Elastic IP, so it stays the same when the instance restarts |
| Key pair | Two matching files that prove it's you when you connect with SSH. AWS holds the public one, and the private one is on your laptop in `~/.ssh` |
| Security group | The firewall around your instance. It's a list of rules, and each rule says which addresses can reach which port |
| SSH rule | The rule in that list for port 22, the port SSH uses. Yours allows one address |

Ask:

```text
Using the AWS CLI profile isba-4775, find my EC2 instance in
us-east-1: its public address, its key pair name, and its security
group. Find the matching private key in ~/.ssh and test SSH. If SSH
fails, find out why before you change anything. If my IP address
changed, replace the SSH rule in the security group with my current
address only. Then confirm that SSH works and that my resume site
still loads. Write the address and the key's path in
docs/instance.md, with no secrets.
```

If you change networks again, run this prompt again.

### Choose your known question

You need one question whose answer you can check, so you can tell whether
each copy of your app works. A password prompt only tells you that
something is asking for a password.

Your instance gets only what's in Git. If your full dataset was too large
to commit, make sure a sample is committed, and choose a question the
sample can answer. A count or a comparison works well, such as "How many
records are from October 2026?"

Replace the bracketed part, then ask:

```text
Run agent.py with this question: [your question]. Use only the data
that's committed to this repository. Save the question, the answer,
and today's date in docs/known-question.md.
```

Check the answer by hand against your data. You'll ask this question three
more times: on your laptop's page, on staging, and on production.

## 1. Build the app on your laptop

Use the session you named in section 0. If you closed it, start a new one
in your Project 02 repository and give it the same name.

Your agent needs a way in. Right now only you can run it, from a terminal.
A web app gives it an address, so a person with a browser can ask it a
question. The prompt uses these terms:

| Term | What it means |
| --- | --- |
| FastAPI | The Python framework your resume site uses. It turns Python functions into web addresses |
| Route | One address inside your app. The route `/ask` takes a question and returns the agent's answer |
| Markdown | Plain text with marks for headings, bold, and tables. Your agent writes its answers in it |
| Shared password | One password for everyone you let in. There are no user accounts |
| The environment | Settings your app reads when it starts, kept outside the code. On your laptop they live in `.env` |
| Server log | The running record your app writes while it works. It's where you look when an answer is wrong |
| Environment name | A label that says which copy this is: local, staging, or production |
| Commit | One saved version of your code in Git, named by a short code such as `15b3c0d` |

Ask your agent:

```text
Read agent.py. Build a small web app around it with FastAPI:

- One page with a question box.
- One route, /ask, that takes the question, runs the agent loop in
  agent.py, and returns the answer.
- If the answer comes back as markdown, show it formatted, not as
  plain text.
- A shared password in front of the page and the route. Read it from
  the environment, never from the code.
- Write each agent step to the server log: the question, the tool and
  its inputs, how much came back, and why the run stopped. Never log
  the password or my API key.
- At the bottom of the page, show the environment name and the commit
  the app is running.

Keep agent.py working from the command line. Ask me before you add
anything else. The sign-in checks only the password, so the user
name can stay blank. Then run the app on my laptop and tell me the
address.
```

Check it yourself:

1. Open the address.
2. Enter the password. If the browser also asks for a user name, leave it
   blank.
3. Ask your known question.
4. Compare the answer with `docs/known-question.md`.
5. Open the address in a private window, without the password. The app
   should refuse you.
6. Ask one vague question, such as "show me a report."
7. Write down what the agent does. You'll use it in section 5.

On the command line, `agent.py` prints each step. Behind a page you only
see the answer, so the steps have to go to a log. Ask:

```text
Show me the log lines for my last question, and tell me where the
log is.
```

Find the tool call, what it was given, and why the run stopped. This log
is where you'll look when an answer is wrong.

The password is your access gate. Every question costs you API credits, so
only people you allow should reach the agent.

### Review your code

Now run the two reviews, one at a time. The word "low" sets how deep the
code review goes. Low reports a few findings it's confident about, and it
uses the least of your Claude usage:

```text
/code-review low
```

```text
/security-review
```

Read the findings and fix the ones you agree with. You decide what gets
fixed, and you can leave a finding alone if you can say why.

It's hard to remember two reviews before every commit, so have your agent
remember for you. `CLAUDE.md` is a file your agent reads at the start of
every session, and what you write there becomes a standing instruction:

```text
Add a line to CLAUDE.md: before every commit that changes code, run
/code-review low and /security-review on the changes, show me the
findings, and wait for my answer before you commit.
```

From now on, when you ask your agent to commit code, it runs both reviews
first and waits for you. This is still an instruction, and nothing enforces
it. A commit you make by hand skips it. The check that can't be skipped
comes in section 4.

Reviews use a lot of your Claude usage, and this lesson has five or six
commits. Sonnet is enough for this lesson and uses less of your limit than
a larger model, and `/model` shows which one you're on. If you reach your
limit anyway, commit without the reviews and keep going. The checks in
section 4 still stop a bad change before it deploys.

## 2. Add checks a machine can run

This is where CI starts. CI needs checks that run without a person, and you
write them here.

In section 4, GitHub will check your code every time you push, and it will
deploy only if the checks pass. Nobody watches that happen, so each check
has to answer pass or fail without a person. You'll add two kinds of check
now, on your laptop, so you know they pass before GitHub runs them.

| Check | What it does | An example from your app |
| --- | --- | --- |
| A test | Runs a piece of your code and compares the result with the answer you expect | Ask for the page without the password, and expect to be refused |
| A linter | Reads your code without running it and checks every line against a list of rules. Each rule describes a known problem, such as a name that's used but never defined | A file that imports `json` and never uses it |

A linter is to code what a spelling and grammar checker is to an essay. It
catches a misspelled name or a sentence that doesn't parse, and it does
that in a second, without running anything. It can't tell you whether the
essay's argument is right. That's the tests' job: they run the code and
check what it does.

Ruff is the linter we'll use. It has a few hundred rules, and each has a
short code. This is what one result looks like:

```text
app.py:3:8: F401 `json` imported but unused
```

Read it left to right: the file, the line and column, the rule's code, and
what's wrong. Here, line 3 of `app.py` imports something the file never
uses.

The tests won't call the model. A model call costs money and can answer
differently each time, and a check has to give the same result every time.

Ask your agent:

```text
Add tests and a linter to this project.

Tests: cover the app and the tool in agent.py. They must run without
calling the model and without my API key. One test must show that a
request without the password is refused.

Linter: use ruff.

Run both and show me the results, with the one command that runs
each. If a test fails, tell me why. Don't delete it.
```

Here's what you should see:

- For the tests, a count and the word OK or passed.
- For ruff, either "All checks passed!" or a list of findings. A finding is
  one place where your code breaks one of ruff's rules, in the format
  above.

Ruff usually has findings in files from earlier lessons, such as
`workflow.py`. They're about style, and your code still works. Fix them
now, because one finding will stop the deploy in section 4:

```text
Fix the ruff findings without changing what the code does. Then run
the tests and ruff again.
```

Now look at one test yourself:

```text
Show me the test that checks the password. Explain in plain words
what it sends and what answer it expects.
```

Could you explain that test to a classmate? If not, ask your agent again in
your own words.

Last, save your work. Your key and your password belong in `.env`, which
Git ignores, and nowhere else:

```text
Check that my API key and my password aren't in any file that Git
will commit. Then commit and push.
```

Your agent runs the two reviews before it commits, and it waits for your
answer. That's the line you added to `CLAUDE.md` in section 1.

You're done with this section when the tests pass, ruff passes, and your
push shows up on GitHub.

## 3. Get your instance ready

This section is the groundwork for CD. Delivery needs somewhere to deliver
to, and something on your instance that can receive a commit.

Your instance runs one site now, your resume site. After this section it
will have room for two more: a staging copy and a production copy of your
Project 02 app. You do this setup once, and every deploy after it reuses
it.

Nginx is already the front door of your instance. It reads the name a
visitor asked for and sends the request to the right site:

```mermaid
flowchart LR
    V["Visitor"]
    N["Nginx on your instance"]
    R["Resume site"]
    S["Staging copy"]
    P["Production copy"]

    V --> N
    N -->|"yourname.com"| R
    N -->|"staging.yourname.com"| S
    N -->|"agent.yourname.com"| P
```

### Start at the board

Before you read the table below, work this out yourself. Your resume site
is live on your instance, so you already know most of the answer. The
video for this section works through the same three questions at the
whiteboard, so try them first and then watch.

1. What had to exist on your instance before a visitor could see your
   resume site?
2. For a second and a third copy of a site, which of those do you need
   again, and which can all three share?
3. GitHub's computers can't SSH into your instance. How could GitHub get
   your code there?

Write your answers down before you read on.

### Compare it with this

Each copy needs the same six parts your resume site has:

| Part | What it is |
| --- | --- |
| A DNS record | Points the copy's name at your instance |
| A folder | Where that copy's code sits on the instance |
| A service | The program that keeps the copy running and restarts it after a reboot |
| A port | The number Nginx uses to reach that copy. Each copy gets its own |
| An environment file | A file on the instance with that copy's API key, password, and environment name |
| A certificate | What lets a browser show the padlock for that name. Let's Encrypt issues it for free, and Certbot is the tool that asks for it, as on October 6 |

### The two names

Everyone uses the same two names: `staging.yourname.com` for staging and
`agent.yourname.com` for production. In every prompt and command below,
replace `yourname.com` with your domain.

### Point the names at your instance

A name has to point at your instance before anyone can visit it, and before
a certificate can be issued for it. The prompt uses three terms:

| Term | What it means |
| --- | --- |
| Cloudflare CLI | The command-line tool your agent used to change DNS in the Railway lesson |
| A record | The DNS entry that says "this name is at this address" |
| DNS only | Cloudflare hands out your instance's address and stays out of the way, the same as your resume site. The other setting, proxied, puts Cloudflare between the visitor and your instance |

Ask:

```text
Using the Cloudflare CLI, add two A records that point at my
instance's Elastic IP, DNS only: staging and agent. Don't
change any other record.
```

Check it from your laptop:

```bash
nslookup staging.yourname.com
nslookup agent.yourname.com
```

Each answer should end with your instance's address, the one in
`docs/instance.md`. If a name isn't found, wait a minute and try again.

### How GitHub reaches your instance

In section 4, GitHub Actions will copy your code to your instance. It does
its work on a runner, which is the computer that carries out the steps.
GitHub has its own runners, but they can't SSH into your instance, because
port 22 only allows your IP address. You saw that rule in section 0.

So your instance gets a runner of its own. It's a small program that asks
GitHub, "Is there a job for me?" The instance starts the conversation, so
nothing new opens on your firewall.

Use a runner like this only on a private repository. On a public one, a
stranger's pull request could run code on your instance.

### Ask for a plan

This is the largest change you've made to your instance, and your resume
site lives there. So you plan it first, the way you did for the Azure VM on
September 24 and October 1, with the writing-plans skill from Superpowers.
The skill saves the plan as a file. If you stop partway, the file is how
you pick the work up.

The prompt uses the six parts from the table above, and seven more terms:

| Term | What it means |
| --- | --- |
| Routes by hostname | Nginx reads the name in the address, such as `staging.yourname.com`, and sends the request to the copy with that name |
| GitHub Actions | GitHub's service that runs steps for you when something happens in your repository, such as a push |
| Runner | The computer that carries out those steps. GitHub lends you one for each job, and you can add your own |
| Self-hosted runner | A runner you add yourself. Here it's a small program on your instance, and not one of GitHub's computers |
| Run as a service | Started by the system and kept running, so it comes back after a reboot without you |
| Permissions | What a program is allowed to change on the instance. The runner needs only a few |
| Skill | A set of written instructions your agent loads for one kind of job. writing-plans is the one for plans |

```text
Plan how to run two copies of this app on my EC2 instance, next to
my resume site: staging at staging.yourname.com and production at
agent.yourname.com. The instance's details are in
docs/instance.md.

Each copy gets its own folder, service, port, environment file, and
Let's Encrypt certificate. Nginx routes by hostname. My resume site
has to keep working.

Include a GitHub Actions self-hosted runner for this repository,
run as a service. Later, a workflow will use it to copy a commit
into one of those folders and restart that copy's service, so give
it only the permissions that needs.

Stop at the runner. Don't write a workflow, and don't copy the app's
code to the instance. I'll build the pipeline next: staging on every
push, and production only when I promote by hand.

Keep the plan small enough to read in five minutes. Don't add tests
or change files in this repository.

Use your writing-plans skill and save the plan to
docs/superpowers/plans/2026-11-24-staging-and-production.md. Explain
each section for a beginner, and say where each step runs, how we'll
check it, and how to undo it. Don't run anything yet.
```

Open the plan in VS Code, under `docs/superpowers/plans/`. Find these four
things in it. If one is missing, ask your agent to add it before you go on.

- The two ports. They have to differ from each other and from your resume
  site's port.
- The two environment files, and where they are.
- What the runner is allowed to do. It should be able to write to the two
  folders and restart the two services, and nothing more.
- The step that could break your resume site, and how the plan checks for
  that.

Then ask the plan one more question: does any step here copy code to the
instance or start one of the two copies? The answer should be no. This plan
only prepares the instance. If it writes a workflow or copies your code,
ask your agent to take that part out, because that's the pipeline, and you
build it in sections 4 and 5.

The plan does give the runner permission to write to the production folder
and restart production later. That's expected. It means the rule "only
when I promote" will live in your workflow, and not on the instance. Teams
that need more put production behind a second runner and an approval,
which a paid GitHub plan offers.

### Build it

Run the plan one section at a time. "Native execution" in the prompt means
this session does every task itself, in order, and doesn't hand tasks to
other agents:

```text
The plan looks good. Let's work on the first section using native
execution in this session. As each section finishes, write what ran
and what the checks showed under that section of the plan. Tell me
what you need from me.
```

The agent will ask you to approve commands, so read each request before
you approve it. The certificate step can sit still for several minutes.
That's Certbot waiting on purpose, so let it finish.

To register the runner, the agent needs a registration token from GitHub.
It's a short-lived code that proves the runner belongs to your repository.
Get it only when the agent asks, because it expires in an hour:

1. Open your repository on GitHub.
2. Choose Settings, then Actions, then Runners.
3. Choose New self-hosted runner, then Linux.
4. Find the line that starts with `./config.sh`. The token is the code
   after `--token`.

Treat the token like a password. Give it to the command your agent
provides in the VS Code terminal, and not to the chat. After each section, read what it reports, then say:

```text
Let's work on the next section.
```

If you have to stop, or you start a new session, the plan file remembers
where you were:

```text
Read @docs/superpowers/plans/2026-11-24-staging-and-production.md
and docs/instance.md. Where are we, and what's next?
```

### Your key and your passwords

At some point in the build, your agent reaches the two environment files.
Each one needs your API key and a password. Keep all of them out of the
chat, because what you type there is sent to the model and saved in the
session. Ask for a script that does it:

```text
Write a script I can run in my own terminal. It copies my API key
from .env into both environment files on the instance, sets the
environment name in each, and makes a different random password for
each one. It saves the two passwords in my local .env, which Git
ignores, and it never prints a secret. I'll run it myself.
```

Run the script in the VS Code terminal, which you open with Terminal, then
New Terminal. Your two passwords are now in `.env`. That's where you'll
find them for your browser and for Milestone 2. If you ever lose them, they
are also in the two environment files on your instance, and your agent can
give you a command to read one in your own terminal. Then tell your agent:

```text
Done. Lock the two files and run the checks.
```

### Check it

Open each of these and compare what you see:

| Open | You should see | What it means |
| --- | --- | --- |
| `https://staging.yourname.com` | A padlock and "502 Bad Gateway" | Nginx answered and the certificate works. No app is behind it yet, because no code has been deployed |
| `https://agent.yourname.com` | A padlock and "502 Bad Gateway" | The same, for production |
| Your resume site | The site, as before | The new setup didn't disturb it |
| Your repository on GitHub, then Settings, Actions, Runners | Your runner, marked Idle | The runner is connected and waiting for a job |

The 502 is what you want here. No code is on the instance yet, and the
pipeline puts it there in section 4. If you see anything else, such as a page that won't load, a certificate
warning, or a runner marked Offline, tell your agent exactly what you see.

When all four rows match, save the plan and your notes:

```text
Commit and push the plan, docs/instance.md, and the script.
```

No workflow exists yet, so this push doesn't deploy anything.

You're done with this section when all four rows match and your push is on
GitHub.

## 4. Deploy to staging with GitHub Actions

Now you build the pipeline's first half. From here on, a push to GitHub
does three things without you: it runs your checks, it deploys to staging
if they pass, and it stops if one fails.

This section turns on CI and the first half of CD. Running the checks on
every push is CI. Deploying to staging when they pass is CD.

These words come up in this section:

| Word | What it means |
| --- | --- |
| Workflow | A file in your repository that tells GitHub Actions what to do, and when. Yours will run on every push |
| Job | One group of steps inside a workflow. Each job runs on one runner |
| Secrets scan | A check that reads your commits for anything that looks like a key or a password. Gitleaks is the tool |
| Push to main | Sending your commits to the main branch on GitHub. It's the event that starts the workflow |
| Deploy | Copy one commit's code to the place it runs, then restart the service so it uses the new code |
| GitHub's runner and your runner | GitHub's runners do the checks. Your self-hosted runner, from section 3, does the deploy, because only it can reach your instance |

Ask:

```text
Write a GitHub Actions workflow for this repository.

On every push to main, run the tests, ruff, and a gitleaks secrets
scan on GitHub's runner. If all three pass, deploy that commit to
staging on my self-hosted runner and restart the staging service. If
one fails, nothing deploys.

The instance has no Git folder, so have the deploy record the commit
where the app can read it, and show it at the bottom of the page.

Before I commit, explain each job to me in one line.
```

You should hear about four jobs: the tests, ruff, the secrets scan, and the
deploy. The first three run on GitHub's runners. The deploy runs on yours,
and only after the other three pass, which is what makes the checks a
gate.

The first three jobs are your CI. The fourth is the start of your CD.

### Read the workflow file

Your agent wrote a file in `.github/workflows/`. GitHub looks in that
folder, and anything there becomes instructions it can run. The file is
written in YAML, which is a way to write a list of instructions that a
machine can follow. Think of it as a checklist. Every push goes down the
same checklist, in the same order, and nobody has to remember the steps.

The file looks dense, but it's built from nine words. This short one shows
all of them:

```yaml
name: Checks and staging deploy    # the label in the Actions tab
on:                                # when to run
  push:
    branches: [main]
jobs:                              # the sections of the checklist
  tests:
    runs-on: ubuntu-latest         # a fresh computer from GitHub
    steps:
      - uses: actions/checkout@v5  # ready-made: copy my code here
      - uses: actions/setup-python@v6
        with:                      # a setting for that action
          python-version: "3.14"
      - run: python -m unittest    # a command, as in my terminal
  deploy-staging:
    needs: [tests]                 # the gate: wait for tests to pass
    runs-on: [self-hosted]         # my runner, on my instance
    steps:
      - run: sudo systemctl restart agent-staging
```

| Word | What it means |
| --- | --- |
| `name` | A label. It's what you see in the Actions tab, and it changes nothing about how the file runs |
| `on` | When to run. GitHub waits for an event, which is something that happens in your repository. Yours is a push to main |
| `jobs` | The sections of the checklist. Each job does one thing, such as running the tests |
| `runs-on` | Which computer does the job. `ubuntu-latest` is a new, empty computer that GitHub lends you. `self-hosted` is your runner |
| `needs` | Which jobs have to pass first. This one line is the gate |
| `steps` | The instructions inside a job, done in order |
| `uses` | Run a ready-made step that someone else wrote, called an action. `actions/checkout` copies your repository onto the computer, which starts out empty |
| `with` | Settings for that action, such as which Python version to install |
| `run` | Run a command, the same way you'd type it in a terminal |

Now read your own file with your agent:

```text
Walk me through my workflow file one block at a time: name, on, each
job, and each job's runs-on, needs, and steps. Show me the lines,
and say in one sentence what they do. Stop after each block until I
say next.
```

Find two lines yourself before you go on: the `needs` line in the deploy
job, and its `runs-on` line. The first is your gate, and the second is your
runner.

If you'd like to see a file like this built line by line, this video does
it in 14 minutes, for a JavaScript project:
https://www.youtube.com/watch?v=omB2JkC4QfA

### Push it

Before you push, predict it. What will run first, and what happens to the
deploy if ruff fails? Then ask:

```text
Commit and push.
```

If GitHub rejects the push with a message about the workflow scope, paste
the error to your agent. Your GitHub sign-in needs permission to change
workflow files.

### Watch it run

In your repository on GitHub, open the Actions tab and choose the newest
run. You'll see the four jobs as boxes. The three checks start together,
each on its own computer from GitHub, and the deploy box waits for them.
That wait is your `needs` line at work. The run takes a few minutes.

Don't stop at the check marks. Choose a job to open it, then choose a step
to see what it printed. Open all four jobs:

| Job | Step to open | What you'll see |
| --- | --- | --- |
| Tests | The one that runs the tests | Each test by name, then a count and OK |
| Ruff | The one that runs ruff | "All checks passed!" |
| Secrets scan | The one that scans | How many commits it read, and that it found no leaks |
| Deploy to staging | Every step, in order | The packages installed, the code copied, the commit recorded, the service restarted, and a last check that the app answers |

Two things to notice while you're in there:

- Every job starts with "Set up job" and a checkout step. The computer is
  new and empty, so the first thing it does is copy your code.
- In the deploy job, "Set up job" names your runner. That job is running on
  your instance, and the other three aren't.

While the run finishes, check your own postings for this lesson's terms:

```text
Search my saved postings in research/ for CI/CD, DevOps, pipeline,
deployment, GitHub Actions, and staging. Show me each line you find
and which posting it's from. Don't summarize.
```

### When a step is red

A red X tells you which step stopped and what it printed. Where it is tells
you what kind of problem you have:

| Where the red X is | What it means | Was anything deployed? |
| --- | --- | --- |
| Tests, Ruff, or Secrets scan | The gate did its job. Your change has a problem | No |
| Deploy to staging | The checks passed, and something on your instance went wrong | Maybe part of it. Staging may be down |
| The deploy job never starts | Your runner is offline | No |

In my rehearsal, the first deploy went red at its last step. The checks had
passed and the code was copied, but the service couldn't open its own
folder, because of the permissions the runner had copied the files with.
The log named the cause in one line, and the fix was one small change to the
deploy job. The second run passed.

Work a red step the same way every time:

1. Open the red step.
2. Read its last lines, and copy them.
3. Paste them into this prompt, in place of the bracketed part:

```text
A step in my GitHub Actions run failed. Here's what it printed:

[paste the last lines of the red step]

Find the cause before you change anything, and tell me what you
checked. Then fix it, and tell me what you changed and why.
```

4. Push again. Every push runs the whole checklist from the top.
5. Write down what you saw, the cause, and the fix. That's Exercise 10.

### Check staging

When all four jobs are green:

1. Open `https://staging.yourname.com`. The 502 is gone, and the browser
   asks for a password.
2. Enter the staging password, and leave the user name blank.
3. Read the bottom of the page. It should say staging, with a commit.
4. Run `git log -1` on your laptop. The commit should match the page.
5. Ask your known question on the page.
6. Compare the answer with `docs/known-question.md`.
7. Ask your coding agent for the log of that question:

```text
Show me the staging log lines for the question I asked a moment ago.
```

The steps are the same ones you read in section 1. They're on your instance
now, and not on your laptop.

Production still shows the 502. The pipeline only goes as far as staging,
and that's on purpose.

You're done with this section when staging answers your known question and
shows the commit you pushed.

## 5. Promote to production

This is the second half of CD, and it's what makes yours continuous
delivery: a person decides. Staging is where you find out whether a change
is right. Production is what other people use. To promote a commit is to
move the one you tested on staging into production.

### Decide

Before anything goes to production, make a release decision you can
defend. Answer three questions:

1. Which commit did you test? Read the seven characters at the bottom of
   your staging page.
2. What did you observe? Ask your known question on staging. Compare the
   answer with `docs/known-question.md`.
3. Would you release it, or hold it?

Green check marks tell you the checks passed, but they don't tell you the
answer is right. In my rehearsal, all 43 tests passed while the agent
searched the wrong dates. The checks and your own observation are two
separate kinds of evidence, and a release needs both.

Write your decision down: the seven characters, the one thing you observed,
and "release" or "hold." A hold with a reason is a good answer, and you'll
be asked for a decision like this one in your final interview.

### Build the Promote workflow

The workflow asks for the commit you tested, so it can't send a different
one by accident. If you pushed again after testing, staging has moved, and
the workflow should stop.

```text
Add a second workflow named Promote that I start by hand from the
Actions tab. It asks me for the seven-character commit I tested on
staging. If staging is running a different commit, it stops and
changes nothing. Otherwise it deploys that commit to production and
restarts the production service. If production doesn't answer after
the restart, the run fails and says so. Write the promoted commit in
the run's summary.
```

### Read the Promote file

This file uses the words you read in section 4, and five new ones. This
short version shows them. Your paths and names will differ:

```yaml
name: Promote
on:
  workflow_dispatch:           # start by hand, from a button
    inputs:
      commit:                  # a box to type into
        description: The commit you tested on staging
        required: true
jobs:
  promote:
    runs-on: [self-hosted]     # my runner, on my instance
    env:
      COMMIT: ${{ inputs.commit }}   # what I typed, handed to the steps
    steps:
      - name: Stop if staging moved
        run: test "$(cat /srv/agent-staging/COMMIT)" = "$COMMIT"
      - name: Deploy that commit to production
        run: echo "copy the code, then restart production"
      - name: Say what was promoted
        run: echo "Promoted $COMMIT" >> "$GITHUB_STEP_SUMMARY"
```

| Word | What it means |
| --- | --- |
| `workflow_dispatch` | Run when a person starts it. This is what puts the Run workflow button in the Actions tab, and it's the whole difference between this file and the first one |
| `inputs` | A box on that button's form. Yours asks for the commit you tested |
| `env` | Values every step in the job can read. Here it carries what you typed |
| `${{ }}` | A blank that GitHub fills in before the job runs, such as the text from the box |
| `GITHUB_STEP_SUMMARY` | A file GitHub shows at the top of the finished run. Writing a line to it leaves a record you can point to |

Two things are missing on purpose. There's no `push` under `on`, so a push
can never reach production. And the tests don't run again, because this
commit already passed them on its way to staging. Promote only confirms
that it's the same commit.

Read your own file with your agent:

```text
Walk me through my Promote file one block at a time, and say in one
sentence what each block does. Then show me the step that stops the
run when staging has moved, and tell me what it compares.
```

Find that step yourself before you go on. It's the one that keeps an
untested commit out of production.

Then ask:

```text
Commit and push.
```

This push runs your checks and deploys to staging again, because every push
does. Wait for the run to finish. Staging now shows a new commit, so read
it again and ask your known question once more.

### Promote it

1. Read the seven-character commit at the bottom of your staging page.
2. In your repository on GitHub, open the Actions tab.
3. Choose Promote in the list on the left.
4. Choose Run workflow.
5. Type the commit from step 1.
6. Choose the green Run workflow button.
7. Wait for the green check mark.
8. Open `https://agent.yourname.com`.
9. Enter the production password, and leave the user name blank.
10. Ask your known question.

The bottom of the page should say production, with the same commit as
staging, and the answer should match your saved one. Your app is live, and
that's most of Milestone 2. Open the Promote run in the Actions tab and find the
commit in its summary. That run is your record that this commit went from
staging to production.

### If a release goes wrong

Sooner or later a commit that passed every check will turn out to be bad.
You don't fix production by hand. You send a good commit down the same
path:

```text
Undo my last commit with a new commit that reverts it. Then commit
and push.
```

Wait for the checks and the staging deploy. Ask your known question on
staging, then promote the new commit. Production is back to working code,
and the Actions tab shows what happened and when.

### Move one real change through

Now use the whole path for a change that matters. In section 1 you asked a
vague question. If your agent answered with a question of its own, the page
gave you no way to reply. Your agent gets one request and returns one
answer, so it needs enough to act without you.

Open `agent.md` and add two things, in your own words:

- What data the agent has: the source, the topics, and the dates it
  covers.
- What it does with a vague request. A good rule is to pick a reasonable
  default, do the work, and say what it assumed.

Then ask:

```text
I added two things to agent.md: what data the agent has, and what it
does with a vague request. Update agent.py to match, and give the
agent today's date. Change nothing else. Then run the tests.
```

Move the change through, one environment at a time:

| Where | What you do | What you should see |
| --- | --- | --- |
| Your laptop | Restart the app and ask the vague question again | An answer, with what the agent assumed. If not, read the log, make your words in `agent.md` more specific, and ask again |
| Your laptop | Ask your agent to commit and push. It runs the two reviews first, so read the findings and answer | The push goes through |
| GitHub | Watch the run in the Actions tab | Four green check marks |
| Staging | Ask the vague question | The new answer, and a new commit at the bottom |
| Production | Ask the vague question | The old answer. Nothing has been promoted |
| GitHub | Run Promote with the new commit | A green check mark |
| Production | Ask the vague question again | The new answer, and the same commit as staging |

If your agent already handled the vague question in section 1, change the
heading on the page and move that through.

### Say it back

```text
I'll explain what happens between git push and a visitor seeing my
change, one line per step. Tell me only where I'm wrong.
```

You're done with this section when production shows the same commit as
staging, and you can explain how it got there.

### What real teams add

Teams with a paid GitHub plan add two rules to this path. A change can't
merge until the checks pass, and production waits for a named person to
approve. GitHub Free doesn't offer either on a private repository, so your
checks gate the deploy and you promote by hand.

Some teams take the person out. If Promote ran by itself every time staging
passed, you'd have continuous deployment. Teams do that when their checks
are strong enough to catch what you caught by looking.

## 6. What's next

- By Thursday, December 3, at 1:45 PM, before class, Milestone 2 is due:
  your app is
  live at your production address, agent.yourname.com, behind the password,
  and one commit moved from staging to production. Submit both addresses
  and both passwords in Brightspace. The passwords stay out of your
  repository.
- Tuesday, December 1, is the LMU Data Center tour. Meet in University Hall
  in front of Einstein Bros. Bagels.
- Your app reads the saved data in your repository for now. In class on
  Thursday, December 3, the data moves to S3 or RDS, and the agent gets
  access to only what it needs.
- The [Project 02 requirements](../projects/project-02.md#dates) have the
  dates and the parts that changed.

If you stop partway, write down the last "You're done with this section
when" line you passed. When you come back, start a session in your Project
02 repository and ask:

```text
Read @docs/superpowers/plans/2026-11-24-staging-and-production.md
and docs/instance.md. Where are we, and what's next?
```

Go on from that section of this guide. If you're stuck for more than 20
minutes, post in the course's General Teams channel with what you ran and
what you saw, or send me a DM.

If something breaks between now and December 3, write down what you saw and
what fixed it. Exercise 10 is now one real failure from your own project,
in your own words, due Tuesday, December 8.
