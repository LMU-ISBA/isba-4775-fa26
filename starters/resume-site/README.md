# Resume site starter

Drop-in files for running the AI dev workflow tutorial against a personal
resume site instead of the sales dashboard.

- `prd/resume-site.md` replaces `prd/ecommerce-analytics.md`. Same shape, so
  the tutorial's Section 1 builds `TASKS.md` from it unchanged.
- `data/seed.sql` replaces `data/sales-data.csv`. SQLite syntax. The
  application creates `resume.db` from it at startup.

Stack: Python 3.12+, Flask, the standard-library `sqlite3` module, gunicorn,
deployed to Railway from `main`. No MySQL and no Docker at this stage.

The `portfolio/` starter beside this one is the earlier Codespace and MySQL
version of the same build. Keep one.
