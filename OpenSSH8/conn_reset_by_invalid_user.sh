#!/bin/bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" >&2
	exit 1
fi

basepath=$(cd "$(dirname "$0")" && pwd)
logfile="$basepath/conn_reset_by_invalid_user.list"

awk '/Connection reset by invalid user/ {print $(NF-3)}' /var/log/auth.log |
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
