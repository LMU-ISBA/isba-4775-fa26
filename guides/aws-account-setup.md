# Set up your AWS account

We'll begin moving your project from Railway to AWS on Thursday, October 29, at 1:45 PM. Please set up your AWS account before class.

Your goal is to arrive with an active account and working sign-in. We'll set up deployment access in class.

The full session guide covers architecture, IAM, CLI setup, migration, and verification:

https://github.com/LMU-ISBA/isba-4775-fa26/blob/main/guides/aws-migration.md

## 1. Check for an existing account

If you've used AWS before, sign in to that account. Don't create another account to claim new-customer credits.

Existing accounts may have different billing terms. Wait until class before creating resources.

If you've never had an AWS account, continue below.

## 2. Create an account on the Free plan

This signup path requires a valid payment method and a phone for verification. If you don't have a payment card or can't select Free, stop and message me in Teams.

Open the signup page headed "Sign up for AWS (advanced)." Stay on that page rather than switching to the advertised "new" signup process.

https://signin.aws.amazon.com/signup?request_type=register

Follow Step 1 in AWS's instructions:

https://docs.aws.amazon.com/accounts/latest/reference/getting-started.html

1. Use an email address you can keep accessing for account recovery.
2. Choose the Free plan when AWS asks for your account plan.
3. Complete the contact, payment, and identity verification steps.
4. Choose Basic support if prompted, then wait for the activation email.

"Advanced" identifies the signup process, not the Paid plan. Don't choose Paid or paid support to finish setup.

The Free plan starts with $100 in credits. It ends after six months or when credits run out, whichever happens first. AWS doesn't charge for usage while you remain on this plan, but upgrading changes that protection.

https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/free-tier-plans.html

## 3. Secure and check your account

1. Enable multifactor authentication (MFA) for your root user using AWS's instructions below.
2. Sign out, then sign back in to confirm your password and MFA work.
3. Check your plan and credit balance on the Billing and Cost Management home page.

   https://console.aws.amazon.com/costmanagement/

4. Open Credits and select a credit to see its expiration date.

https://docs.aws.amazon.com/IAM/latest/UserGuide/enable-virt-mfa-for-root.html

Don't create root access keys or share passwords, MFA codes, or payment details. If activation or sign-in fails, message me right away with the error text and no secrets.

## 4. Arrive ready

Sign in before class starts. Confirm you can also access your repository, Railway database, and Cloudflare zone.

Keep your current site and database while we prepare the move together.

Don't launch AWS resources, upgrade your plan, or change your domain settings yet. We'll review the setup before deploying anything.
