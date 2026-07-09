## secure_ssh

一个轻量级的 Linux SSH 访问控制脚本，通过自动封禁多次登录失败的 IP，保护你的服务器免遭暴力破解。

### 你的服务器可能正在被攻击

SSH 暴力破解是互联网上最常见的攻击手段之一。你可以查看以下日志确认：

- **CentOS**：`/var/log/secure`
- **Ubuntu / Debian**：`/var/log/auth.log`

如果看到大量陌生 IP 的失败登录记录，说明你的服务器已经在被扫描或暴力破解。

### 使用方法

根据你的系统运行对应脚本：

bash

```bash
# CentOS 7
bash run_centos7.sh

# Debian 11
bash run_debian11.sh
```

#### 设置定时任务

将脚本添加到 crontab，每分钟自动执行一次，形如：

```
* * * * * root cd /home/azureuser/.local/secure_ssh/ && ./run_debian11.sh >> ./log/$(date +\%Y\%m\%d).log 2>&1
```

把上述 `/home/azureuser/.local/secure_ssh/`替换成你机器上secure_ssh所在目录，脚本会将触发阈值的攻击 IP 自动写入 `/etc/hosts.deny` 黑名单，被封禁的 IP 将无法再建立 SSH 连接。

### 防止误封自己

在 `/etc/hosts.allow` 中加入你自己的 IP 段，将其加入白名单：

```
sshd: 10.0.0.:allow
```

> **注意**：脚本需要 root 权限运行，因为它会修改 `/etc/hosts.deny` 文件。
