#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)

"$basepath/debian11/conn_closed_by_invalid_user.sh"
"$basepath/debian11/invalid_user.sh"
"$basepath/debian11/disconn_from_invalid_user.sh"
