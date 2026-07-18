#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)

"$basepath/OpenSSH9/conn_closed_by_invalid_user.sh"
"$basepath/OpenSSH9/disconn_from_invalid_user.sh"
"$basepath/OpenSSH9/failed_password_for.sh"
"$basepath/OpenSSH9/invalid_user.sh"
