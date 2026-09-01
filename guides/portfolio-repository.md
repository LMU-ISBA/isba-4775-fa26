# Your portfolio repository

Set this up in week 1. It's where every exercise and both projects are submitted,
and it's the first thing Exercise 01 assumes you already have.

Name it `isba-4775-portfolio` and make it public. Everyone in the course uses the
same name, so your repository lives at
https://github.com/YOUR-USERNAME/isba-4775-portfolio and I can find it without
guessing.

## Create it

1. Go to https://github.com/new
2. Repository name: `isba-4775-portfolio`
3. Visibility: Public
4. Check "Add a README file"
5. Click Create repository

## Clone it to your laptop

You'll be editing these files with a code editor and Claude Code all semester, so
don't work in the browser. Replace YOUR-USERNAME with your actual GitHub username.

    git clone https://github.com/YOUR-USERNAME/isba-4775-portfolio.git
    cd isba-4775-portfolio

If the clone asks for a password and your GitHub password doesn't work, that's
expected. GitHub stopped accepting passwords over HTTPS in 2021. Install the
GitHub CLI from https://cli.github.com and run `gh auth login`, which handles
this once and then stays handled.

## How it's organized

One folder per exercise, named `ex01` through `ex10`, created as you go. You
don't need to make all ten now.

    isba-4775-portfolio/
      README.md
      ex01/
        plan.md
        verify.txt
        README.md
      ex02/
      ...

Each exercise brief tells you what goes in its folder. The pattern is a plan
committed before the work, evidence that the thing actually runs, and a README
explaining what broke and how you fixed it.

## Submit the URL

Post your repository URL on Brightspace as part of Exercise 01, in the same place
you submit the self-discovery interview file. That's how I get the list of 19
repositories to grade against.

Do that even though the name is fixed, because I still need your GitHub username.

## Two things worth knowing now

This repository is public and permanent, and it carries your name. That's the
point of it. A public record of ten working systems is worth more to you in a
job search than a grade is, and it's the reason the work is submitted this way
rather than as an attachment nobody sees again.

The one exception all semester is the self-discovery interview, which goes on
Brightspace instead. It has your career plans in it, and that doesn't belong on
the open internet with your name attached. Nothing else in the course gets that
treatment.

## If something goes wrong

Committed something you shouldn't have, like a key or a password? Tell me rather
than quietly deleting it. Deleting a file doesn't remove it from the history, and
the fix is different depending on whether you've pushed yet.

Made the repository private by accident? Settings, then General, then scroll to
the bottom and change the visibility.
