#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)

"$basepath/ubuntu24/disconn_from_invalid_user.sh"
"$basepath/ubuntu24/conn_closed_by_invalid_user.sh"
"$basepath/ubuntu24/invalid_user.sh"
