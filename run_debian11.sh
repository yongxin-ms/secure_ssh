#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)

"$basepath/debian11/check_invalid_user.sh"
