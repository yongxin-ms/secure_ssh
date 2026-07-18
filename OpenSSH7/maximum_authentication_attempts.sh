#!/bin/bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" >&2
	exit 1
fi

basepath=$(cd "$(dirname "$0")" && pwd)
logfile="$basepath/maximum_authentication_attempts.list"

awk '/maximum authentication attempts/ {print $(NF-4)}' /var/log/secure |
	sort | uniq -c |
	awk '{print $2"="$1}' >"$logfile"

while IFS='=' read -r IP NUM; do
	[[ -z "$IP" || -z "$NUM" ]] && continue
	if ((NUM > 4)); then
		if ! grep -qF "$IP" /etc/hosts.deny; then
			echo "sshd:$IP:deny" >>/etc/hosts.deny
			echo "[$(date '+%F %T')] Blocked $IP (attempts: $NUM)"
		fi
	fi
done <"$logfile"
