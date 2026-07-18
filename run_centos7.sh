#!/bin/bash
set -euo pipefail

basepath=$(cd "$(dirname "$0")" && pwd)
openssh_dir="$basepath/OpenSSH7"

if [ ! -d "$openssh_dir" ]; then
	echo "Directory not found: $openssh_dir" >&2
	exit 1
fi

find "$openssh_dir" -maxdepth 1 -type f -name '*.sh' | sort | while read -r script; do
	echo "===================="
	echo "Running $(basename "$script")"
	echo "===================="
	bash "$script"
done
