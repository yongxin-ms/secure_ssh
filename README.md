# secure_ssh
安全脚本

ubuntu用run_ubuntu.sh，centos用run_centos.sh

添加到你的crontab中

#ssh访问控制，多次失败登录即封掉IP，防止暴力破解
* * * * * root /home/will/.local/secure_ssh/run_ubuntu.sh
