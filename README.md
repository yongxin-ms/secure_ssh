[中文](./README_ZH.md)



## secure_ssh

A lightweight Linux SSH access control script that automatically bans IPs with repeated failed login attempts, protecting your server from brute-force attacks.

### Your Server May Already Be Under Attack

SSH brute-forcing is one of the most common attacks on the internet. Check the following logs to find out:

- **CentOS**: `/var/log/secure`
- **Ubuntu / Debian**: `/var/log/auth.log`

If you see a flood of failed login attempts from unfamiliar IPs, your server is already being scanned or brute-forced.

### Usage

Run the script that matches your system:

bash

```bash
# CentOS 7
bash run_centos7.sh

# Debian 11
bash run_debian11.sh
```

#### Set Up a Cron Job

Add the script to crontab to run it automatically every minute:

```
* * * * * root cd /home/azureuser/.local/secure_ssh/ && ./run_debian11.sh >> ./log/$(date +\%Y\%m\%d).log 2>&1
```

Any IP that triggers the failure threshold will be automatically added to `/etc/hosts.deny`, permanently blocking it from establishing new SSH connections.

### Prevent Locking Yourself Out

Add your own IP range to `/etc/hosts.allow` to whitelist it:

```
sshd: 10.0.0.:allow
```

> **Note**: Root privileges are required since the script modifies `/etc/hosts.deny`.