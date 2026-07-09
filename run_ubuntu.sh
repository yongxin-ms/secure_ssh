#!/bin/bash
set -euo pipefail

# Root privilege check
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" >&2
	exit 1
fi

basepath=$(cd "$(dirname "$0")" && pwd)
logfile="$basepath/black.list"

# Parse failed SSH attempts from auth.log and count by IP
awk '/Failed/ {print $(NF-3)}' /var/log/auth.log |
	sort | uniq -c |
	awk '{print $2"="$1}' >"$logfile"

# Block IPs exceeding the failure threshold
while IFS='=' read -r IP NUM; do
	[[ -z "$IP" || -z "$NUM" ]] && continue
	if ((NUM > 5)); then
		# -q: silent, -F: fixed string (prevents IP dots from being treated as regex)
		if ! grep -qF "$IP" /etc/hosts.deny; then
			echo "sshd:$IP:deny" >>/etc/hosts.deny
			echo "[$(date '+%F %T')] Blocked $IP (failed attempts: $NUM)"
		fi
	fi
done <"$logfile"
