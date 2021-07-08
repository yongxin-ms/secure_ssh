# secure_ssh
linux机器的安全脚本，实现ssh访问控制，多次失败登录即封掉IP，防止暴力破解



你的vps很可能正在被暴力破解密码



如果你的机器是Centos，去看看/var/log/secure

如果你的机器是Ubuntu，去看看/var/log/auth.log



解决方法

在Centos机器上运行run_centos.sh

在Ubuntu机器上运行run_ubuntu.sh



添加到你的crontab中，让脚本每分钟运行一次

```
* * * * * root /home/will/.local/secure_ssh/run_ubuntu.sh
```



这样暴力破解你密码的ip会进入到hosts.deny黑名单中，以后他就不能再登录了



为了防止你自己登陆失败，需要在hosts.allow白名单中加入你自己的ip，形如：

```
sshd：10.0.0.:allow
```

