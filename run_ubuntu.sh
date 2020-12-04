#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
logfile=$basepath/black.list
cat /var/log/auth.log |awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $2"="$1;}' > $logfile
for i in `cat  $logfile`
do
  IP=`echo $i |awk -F= '{print $1}'`
  NUM=`echo $i|awk -F= '{print $2}'`
  if [ ${#NUM} -gt 1 ]; then
    grep $IP /etc/hosts.deny > /dev/null
    if [ $? -gt 0 ];then
      echo "sshd:$IP:deny" >> /etc/hosts.deny
    fi
  fi
done

