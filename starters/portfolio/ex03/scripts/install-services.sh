#!/usr/bin/env bash
# Run with Bash inside the Linux Codespace, after reading this file in class.
set -euo pipefail

if [[ "$(uname -s)" != "Linux" ]] || ! command -v apt-get >/dev/null 2>&1; then
    echo "Run this script inside the Linux Codespace terminal."
    exit 1
fi

echo "Refreshing the package catalog and installing the lab services."
sudo apt-get update
sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y nginx mysql-server python3-venv

echo "Starting Nginx and MySQL."
sudo service nginx start
sudo service mysql start

echo "Checking installed packages and the web response."
dpkg-query -W nginx mysql-server python3-venv
curl --fail --head http://127.0.0.1

echo "Next: load ex03/database/seed.sql, then configure the reader account."
