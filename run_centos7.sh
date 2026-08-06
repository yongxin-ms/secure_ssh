#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)
openssh_dir="$basepath/OpenSSH7"

if [ ! -d "$openssh_dir" ]; then
	echo "Directory not found: $openssh_dir" >&2
	exit 1
fi

# ---- 从这里开始上锁，锁住整个"读-算-写"临界区 ----
LOCKFILE="$basepath/process.lock"
exec 200>"$LOCKFILE"
if ! flock -n 200; then
	echo "Another instance is still running, skipping this run." >&2
	exit 1
fi

find "$openssh_dir" -maxdepth 1 -type f -name '*.sh' | sort | while read -r script; do
	bash "$script"
done
