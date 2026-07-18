#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)
scripts_dir="$basepath/OpenSSH7"

"$scripts_dir/failed_password.sh"
"$scripts_dir/invalid_user.sh"
"$scripts_dir/maximum_authentication_attempts.sh"
