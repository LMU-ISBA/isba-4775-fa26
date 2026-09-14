#!/usr/bin/env python3
"""Configure the disposable lab's reader using a Codespaces environment secret."""

import os
import re
import subprocess
import sys


def configure_reader(password, mysql_command=None):
    """Create/update the lab account. Supply an admin command for other lab hosts."""
    if not password or not password.strip():
        raise ValueError(
            "DB_PASSWORD is missing. Add your Codespaces secret, grant this "
            "repository access, then stop and restart the Codespace."
        )
    if any(ord(character) < 32 or ord(character) == 127 for character in password):
        raise ValueError("Use a single-line DB_PASSWORD without control characters.")

    # Disable backslash escaping and double any single quotes in the SQL literal.
    # Python sends SQL through stdin. No password is placed in a shell command.
    quoted_password = "'" + password.replace("'", "''") + "'"
    sql = f"""
SET SESSION sql_mode = 'NO_BACKSLASH_ESCAPES';
CREATE USER IF NOT EXISTS 'lab_reader'@'127.0.0.1' IDENTIFIED BY {quoted_password};
ALTER USER 'lab_reader'@'127.0.0.1' IDENTIFIED BY {quoted_password};
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'lab_reader'@'127.0.0.1';
GRANT SELECT ON session04.sales TO 'lab_reader'@'127.0.0.1';
"""
    command = mysql_command or [
        "sudo", "mysql", "--no-defaults", "--batch", "--binary-mode",
        "--default-character-set=utf8mb4",
    ]
    child_environment = os.environ.copy()
    child_environment.pop("DB_PASSWORD", None)
    try:
        result = subprocess.run(
            command, input=sql, text=True, capture_output=True,
            env=child_environment, timeout=30,
        )
    except (OSError, subprocess.TimeoutExpired):
        raise RuntimeError(
            "Could not run the MySQL administrator client. Check installation, "
            "service status, and sudo access with the instructor."
        ) from None
    if result.returncode:
        code = re.search(r"ERROR (\d+)", result.stderr)
        detail = f" (MySQL error {code.group(1)})" if code else ""
        # Raw client errors can repeat SQL containing the password.
        raise RuntimeError(
            f"Reader setup failed{detail}. Check that MySQL is running and "
            "seed.sql succeeded. Ask the instructor before changing the script."
        )


def main():
    try:
        configure_reader(os.environ.get("DB_PASSWORD"))
    except (ValueError, RuntimeError) as error:
        print(str(error), file=sys.stderr)
        return 1
    print("Reader configured. Test a new lab_reader connection and query the sales.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
