# Migrate your resume site to Railway

Session 12 · Thursday, October 8, 2026

Your resume site is running on an Azure VM. Today we'll move that same site and
its current database content to Railway-hosted PostgreSQL. Keep Azure
running while you test the target. The domain moves only after the app and
data checks pass. If you don't finish the cutover in class, finish it for
homework with the same checks.

The class example used FastAPI, Uvicorn, and SQLite. Your site may differ.
Inspect the application and its actual database engine before choosing a
migration method. Don't replace your app with a starter or reload seed rows
and call that a migration.

## 0. Before changing anything

Bring the branch and results from the required
[website design activity](improve-your-site-design.md). Identify the tested
commit that Azure is actually serving before planning the migration. If the
design is still on a separate branch, keep that distinction in your plan.

Exercise 04 is due today at 1:45 PM. Preserve dated evidence that Azure
served your site over HTTP, survived a controlled restart, and served your
domain over HTTPS. Keep the certificate and renewal check from Exercise 04.
If Tuesday's HTTPS lesson or your homework isn't finished, complete that
baseline first and tell the instructor where you're stuck. The instructor
will check the October 6 class log before this lesson.

Sign in to Railway and inspect your trial status, remaining credit, and
verification status. Railway currently gives new users a one-time $5 trial
credit for up to 30 days. Afterward, the Free plan includes $1 of monthly
credit, which doesn't roll over. A limited trial can restrict outbound
network access. Resource use can exceed the included credit, so check Usage
and the account terms before provisioning or selecting a paid plan. Trial
accounts can lose stateful volumes 30 days after credits expire. Record your
own dates and limits. See Railway's https://docs.railway.com/pricing/free-trial
and https://docs.railway.com/pricing/plans.

Choose one final hostname now: `yourdomain.com` or `www.yourdomain.com`.
Railway's trial permits one custom domain, and those two names count
separately. Keep Cloudflare as DNS provider. Record the current Azure A
record, its value, and the Azure rollback steps privately. See Railway's
https://docs.railway.com/networking/domains/working-with-domains.

Make a private backup of the current database using a method appropriate to
its engine. Record where it is and test that it can be read. Don't put a
database export, password, `.env`, or private key in Git. If the site accepts
writes, decide when you'll pause them or take a final export. A snapshot made
while writes continue can already be stale at cutover.

Make one recognizable edit to an existing project entry on Azure before the
final export. Record its stable key and exact new title or text in private
notes. This edited row is your proof that you moved today's data. Record the
source table names, columns, constraints, row counts, and selected content.
Also record the current domain response, including status code and rendered
project text. For our project, a healthy page returns 200 and a database
failure returns 503 while the profile remains visible.

## 1. Draw the boundary

Sketch this path before opening Railway:

```text
DNS lookup: browser's resolver <-> Cloudflare authoritative DNS
Before cutover: browser --HTTPS--> Azure Nginx/TLS -> app -> current database
After cutover: browser --HTTPS--> Railway edge/TLS -> app -> Railway-hosted PostgreSQL
```

DNS supplies the destination address. The browser then connects to that
destination; the HTTPS request does not pass through the DNS server.

Git moves tracked application code and dependency files. It doesn't move the
current database, environment variables, DNS, or proof that the app ran.
Inventory the actual app entry point, runtime version, dependency lock file,
production start command, database connection code, schema creation or
migrations, local file writes, secrets, and health behavior. Railway's app
filesystem is not a place to keep the migrated SQLite file. PostgreSQL must
hold the durable project data.

On Azure, you managed the VM OS, package updates, service manager, Nginx,
firewall, and Certbot. Railway manages the host, routing, and certificate
provisioning and renewal for its custom domain. You still manage your code,
runtime choice, package versions, app settings, secret values, data,
database schema, DNS records, validation, and recovery. Railway hosts its
PostgreSQL service template, but calls that template unmanaged. You decide
and verify its configuration, software maintenance and upgrades, monitoring,
backups, and data recovery. Railway provides upgrade and backup features,
but you choose and check their use. Compare these roles with a partner and
add the comparison to your README. See
https://docs.railway.com/databases/postgresql#additional-resources.

## 2. Ask your agent for a plan

Start your coding agent in your existing project repository. Ask it to inspect
before editing:

> Inspect this repository and my current Azure deployment. Identify the real
> application entry point, runtime and dependency files, production command,
> database engine and location, schema and constraints, secrets, and any local
> file writes. Draft a migration plan for this same app and its current data
> to a Railway web service and Railway PostgreSQL. Show what Git moves and
> what needs a separate transfer. Propose the smallest code changes for
> PostgreSQL, a private backup and transfer method suited to my actual
> database, source and target verification queries, a write-freeze point,
> cutover checks, and both code and data rollback. Explain risky commands
> before running them. Do not export secrets into Git, overwrite the source,
> create paid resources, or change DNS yet. Wait for my review.

Review the plan against the live system. The source might be SQLite, another
local database, or a service. A generic export command can omit constraints,
misread types, or expose credentials. Approve only the steps you understand.
If you can't identify the current database, stop and find it before creating
an empty target that merely looks healthy.

## 3. Adapt and test the app

Make the app read a database URL from an environment variable. Replace
SQLite-specific connection and SQL behavior where needed. Check placeholder
syntax, boolean and timestamp types, transaction behavior, conflict handling,
primary keys, and queries that rely on SQLite's loose typing. Keep the 200,
503, and recovery behavior in the project brief. Test an empty table and a
failed database connection without inventing sample projects.

The production process must bind to `0.0.0.0` and Railway's `PORT`. For the
class FastAPI example, a possible command is:

```text
uv run --no-dev uvicorn <actual_module>:<actual_app> --host 0.0.0.0 --port $PORT
```

Replace both placeholders after inspecting your code and build setup. If you
use a Dockerfile, shell expansion needs an explicit shell wrapper. Railway
may detect a start command, but confirm the deployed command in Settings and
logs. See https://docs.railway.com/deployments/start-command
and https://docs.railway.com/networking/troubleshooting/application-failed-to-respond.

Run your project's meaningful tests and start it locally against a disposable
PostgreSQL database if available. Record the command and actual result. Don't
describe a green test as proof of the later Railway deployment.

## 4. Build the target, then move data

In Railway, create a project with a PostgreSQL service and a web service from
your existing GitHub repository. Select the deployment branch. Give the web
service a Railway-provided domain for target testing. Configure the exact
runtime, dependencies, and production start command your app needs. Inspect
the build and deploy logs. Add app secrets in service Variables, never in Git.

Set the web service's `DATABASE_URL` as a reference to the PostgreSQL
service's `DATABASE_URL`, using Railway's variable picker. The documented
form is `${{Postgres.DATABASE_URL}}` when your service is named `Postgres`.
Review and deploy staged variable changes. This internal URL works inside
the project. It will not work from your laptop. Railway databases are private
by default. If your approved transfer method needs an external client,
enable temporary Public Access and use the supplied public connection only
for the transfer, then remove Public Access when done. Check any TCP proxy
egress cost. See https://docs.railway.com/databases/postgresql
and https://docs.railway.com/variables.

Apply the reviewed schema method to the empty target. Transfer current data
from the backed-up source with your approved, engine-specific method. Don't
run a seed script that restores the initial example rows. Use a transaction
when your tool and schema permit, and check its commit or rollback behavior.
For larger or staged transfers, document which steps can be undone and how.
Check generated identity sequences after explicit ID inserts if your schema
uses them. A new insert must get a fresh ID without collision.

Compare source and target table names, columns, keys and constraints, row
counts, and selected records. Confirm your edited row's exact content and at
least one other record. Where useful, compare a deterministic ordering of
stable IDs and content. A matching count alone doesn't prove matching data.
Record redacted results and discrepancies. Correct discrepancies before the
domain moves.

Here is a read-only comparison pattern. It assumes a `projects` table with
`id`, `title`, and `detail` columns and that you edited row 7. Replace all of
those names and the ID with your actual schema and edited row. The example
does not transfer data. Run each query against the source and target, using
the appropriate client and a private connection. For SQLite, inspect table
columns with `PRAGMA table_info(projects);`. For PostgreSQL, inspect them
with this query:

```sql
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'projects'
ORDER BY ordinal_position;
```

Compare keys and constraints separately. Then run these read-only queries
on both sides. Record actual counts and redacted row values in two columns
in your notes. If a text field contains private information, compare it
privately and record only that it matched.

```sql
SELECT COUNT(*) AS project_count FROM projects;
SELECT id, title, detail FROM projects WHERE id = 7;
SELECT id, title, detail FROM projects ORDER BY id;
```

After checking any identity sequence, test a fresh insert only in an
isolated test database. Do not add a demonstration row to your real resume
data just to test the sequence.

## 5. Test before changing DNS

Visit the Railway-provided URL. Check the status code, name, project rows,
edited row, links, and page layout. Trigger the app's deliberate database
failure test only in a safe test setting, then confirm recovery. Check logs
for connection and SQL errors. Confirm the public service is the app, while
PostgreSQL remains private after transfer. A deployed badge alone doesn't
show that a request reaches the correct database.

For a GET-based check, replace the example URL and text with your app's
actual address and edited project text. `curl -i` prints the status and
response headers along with the page. Observe the healthy page, a deliberate
database failure in an isolated test setting, and a refresh after recovery:

```text
curl -i https://your-service.up.railway.app/
healthy: HTTP 200; profile visible; edited project text visible
database unavailable in safe test: HTTP 503; profile visible;
  "Projects temporarily unavailable" visible
database restored, same GET again: HTTP 200; project text returns
```

Do not disrupt the live class or a user's site merely to create the 503.
If you cannot safely trigger it, mark that behavior unverified on Railway
and show a local test instead. Save the actual request, time, status, and
visible content. The three expected lines above are examples, not results.

Write a cutover note with the source snapshot time, whether writes are
paused, the target data check, Railway URL result, current Azure DNS record,
and rollback decision point. Keep Azure running.

If your Railway account is restricted or setup fails, record the exact
message and stop provisioning. Finish the source inventory, edited row,
private backup, migration plan, and local app changes. In class, run the
instructor's isolated synthetic comparison if available. If local PostgreSQL
is unavailable too, use this paper example: source rows are `(1, Site,
edited on source Oct 6)` and `(2, Lab, current)`. The target has the same
two rows, so count 2 and the edited row match. If its row 1 still says
`initial`, the count matches but the transfer fails the content check. This
practices the comparison method, but it does not count as your transfer. Mark PostgreSQL
import, actual source/target match, Railway URL, domain, HTTPS, and
autodeploy as pending until you perform them on your own system. Bring the
blocker to the instructor before considering a paid plan.

## 6. Move the one hostname and verify HTTPS

In Railway's web service Settings, add the one chosen custom domain. Railway
shows a routing CNAME target and a verification TXT name and value. Copy
those exact values. In Cloudflare DNS, replace the selected hostname's Azure
routing record with the Railway CNAME and add the Railway TXT record. For the apex,
Cloudflare supports CNAME flattening. Keep the course's proxy-capable records
set to DNS only. Don't invent a Railway IP or repoint mail records. If the
dashboard presents different record instructions, follow its actual values
and record them. See https://docs.railway.com/networking/domains/working-with-domains
and https://developers.cloudflare.com/dns/proxy-status/.

Wait for Railway to verify both records and issue the certificate. From a
network outside campus filtering if needed, check DNS, then request the
chosen `https://` hostname. Verify certificate hostname and validity, HTTP
status, rendered profile and edited row, links, and database-backed content.
Record the date, resolver or network, and actual results. Test a second
network if DNS caches disagree. Railway says issuance and DNS propagation
can take time. Treat a pending domain or certificate as pending, not as
success. If the course's DNS-only setup causes a redirect loop, stop the
cutover and diagnose it with the instructor. Railway's domain documentation
also discusses Cloudflare proxy configurations, so don't change proxy mode
without understanding what certificate and routing path you're testing.

## 7. Make one reviewed update

Review a small, visible app change and test it locally. Commit and push to
the connected branch. Railway's GitHub integration deploys pushed commits
from that branch. Find the commit SHA in Railway's deployment history, wait
for deployment success, and check the actual changed behavior at your custom
domain. Record the SHA, deployment, URL, time, and observed result. This
course doesn't require a GitHub Actions workflow for this project. See
https://docs.railway.com/deployments/github-autodeploys.

## 8. Recovery and Azure cleanup

Write separate recovery steps for code and data. A bad code release may be
reverted to a known commit and redeployed, but reverting code doesn't undo a
schema change or a write. If the new site accepts writes after cutover,
switching DNS back to Azure can lose those new writes. Pause writes, compare
both databases, and plan how to reconcile them before any rollback. Keep the
private source backup and a target backup plan. State who decides when to
reopen writes.

Keep Azure running until the Railway app, current data, chosen domain, and
HTTPS all pass. Then stop the VM in the Azure portal and confirm it says
`Stopped (deallocated)`. Keep its disk and evidence for now. Deallocation
stops VM compute billing, but retained disks and other resources can still
cost money. Record what remains and its cleanup date. See Azure's
https://learn.microsoft.com/en-us/azure/virtual-machines/states-billing.

## Before Tuesday

Finish any incomplete data transfer, Railway target check, domain cutover,
and HTTPS verification as homework. Preserve the Azure rollback path until
the cutover is verified. Add your dated plan, source and target comparison,
cutover results, rollback steps, responsibility table, and cost notes to your
repository's engineering record. Link them from `docs/project-1-submission.md`.
Redact private values. Bring any trial or domain blocker to the instructor
before selecting a paid plan.
