#!/bin/bash
basepath=$(cd `dirname $0`; pwd)

./centos7/check_invalid_user.sh
./centos7/check_wrong_passwd.sh
