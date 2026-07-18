#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)

"$basepath/OpenSSH8/conn_closed_by_invalid_user.sh"
"$basepath/OpenSSH8/failed_password_for.sh"
"$basepath/OpenSSH8/invalid_user.sh"
