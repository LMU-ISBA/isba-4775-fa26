# Prepare for the Azure VM lesson

Complete these checks before class on **Thursday, September 17, 2026**.
Try them on Wednesday so you have time to report account or installation problems.

Thursday uses Claude Code, preferably, or Codex CLI with Superpowers. Run your
chosen agent in the same `career-platform` Codespace you used on Tuesday.
It will manage Azure through the Azure CLI and SSH from that Codespace.

## 1. Finish and save Tuesday's application

Complete [Build your resume site in Codespaces](resume-site-in-codespaces.md).
Check the following before moving on:

- Your page shows your profile and a project read from MySQL.
- You verified the 200 → 503 → 200 database failure and recovery sequence.
- Your README explains how to start the services and application.
- Your reviewed code, `AGENTS.md`, spec, plan, and evidence are on GitHub.
- You can retrieve your lab database password from your password manager.

Open your repository on GitHub and check the actual files. Keep the same
Codespace because Git does not preserve its installed services or live database.
An unfinished resume is fine if its placeholders are clearly labeled.

## 2. Activate Azure for Students

Open the Azure for Students offer and complete its eligibility verification:
https://azure.microsoft.com/en-us/free/students/

The offer requires eligible full-time university students who are at least 18.
It currently includes $100 in credit for 12 months without a credit card.
Use Azure for Students, rather than the different Azure for Students Starter offer.

Sign in at https://portal.azure.com and open **Subscriptions**. Confirm your
Azure for Students subscription is active and check its remaining credit.
Keep track of which Microsoft account owns it, and have your MFA method available.

If verification fails or you only see a paid offer, tell the instructor.
Do not upgrade to pay-as-you-go or create a VM during this preparation.
We will review the region, VM size, cost, and network rules together in class.

## 3. Install and sign in to one coding agent

Open your existing `career-platform` Codespace. Run the installation commands
below in its Bash terminal, not on your laptop or inside an agent conversation.
Choose one option and confirm you have access to use it.

### Claude Code, preferred

Install Claude Code, then open a new terminal and check its version:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

```bash
claude --version
claude
```

Follow the browser sign-in instructions. Claude Code requires an eligible
subscription or another supported access method. Tell the instructor if access
is blocked before purchasing anything just to complete this check.

Source: https://code.claude.com/docs/en/quickstart

### Codex CLI, allowed alternative

If you choose Codex and are prepared to cover its access costs, install it:

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

Open a new terminal, run `codex --version`, then run `codex` from the repository.
Choose **Sign in with ChatGPT** and verify that your account can use the agent.

Source: https://learn.chatgpt.com/docs/codex/cli

## 4. Install Superpowers in your chosen agent

Tuesday's Copilot plugin installation does not install Superpowers for another
agent. Complete the matching option below inside the agent conversation.

### In Claude Code

```text
/plugin install superpowers@claude-plugins-official
```

Open `/plugin` and check that Superpowers is installed and enabled.
Exit Claude Code and start a fresh session in `career-platform`.

### In Codex CLI

```text
/plugins
```

Search for `superpowers`, open its details, and select **Install Plugin**.
Confirm installation, then start a fresh Codex session in `career-platform`.

Sources: https://github.com/obra/superpowers#installation
and https://learn.chatgpt.com/docs/plugins

## 5. Check that the new agent understands your project

Use this prompt in your chosen agent:

```text
Read AGENTS.md and the saved spec and plan in docs/superpowers/.
Explain how my application works and what would need to move to another server.
Do not change files, display secrets, or deploy anything.
```

Compare its explanation with your files and Tuesday's checks. It should
identify the application, Python dependencies, MySQL schema and data, and
environment variables. Correct any misunderstanding before the migration lesson.
Use this prompt again when starting a new session so both agents receive the
same project rules.

## 6. Check the Azure CLI and sign in

Use a separate Bash terminal in the same Codespace:

```bash
az --version
```

If the command is missing, follow Microsoft's Ubuntu/Debian installation steps:
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux

Open a new terminal and repeat the version check. Then sign in through your
browser using the code produced by your own terminal:

```bash
az login --use-device-code
az account list --output table
```

Find your Azure for Students subscription and confirm its state is `Enabled`.
If you have several subscriptions, select the student subscription using its
actual ID from that output:

```bash
az account set --subscription "ACTUAL-SUBSCRIPTION-ID"
az account show --query '{Name:name, State:state}' --output table
```

Replace the placeholder before running the command. These commands authenticate
and select your subscription. They do not create cloud resources.

## 7. Bring your readiness check to class

- [ ] My application and reviewed evidence are on GitHub.
- [ ] I kept the Codespace containing my application and live MySQL data.
- [ ] My Azure for Students subscription is active with credit available.
- [ ] Claude Code or Codex opens, signs in, and answers the project question.
- [ ] Superpowers is installed in that agent.
- [ ] Azure CLI signs in and shows the correct student subscription.

Report any blocker to the instructor before Thursday. Include the failed step
and error text, without passwords, login codes, tokens, or private keys.

Stop your Codespace when finished and verify its stopped status at
https://github.com/codespaces. Keep it available for Thursday's migration.

Your next step is to bring this checklist and your repository URL to
[Migrate your resume site to an Azure VM](azure-vm-migration.md).
