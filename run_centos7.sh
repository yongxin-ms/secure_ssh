#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)
scripts_dir="$basepath/centos7"

"$scripts_dir/check_invalid_user.sh"
"$scripts_dir/check_wrong_passwd.sh"
