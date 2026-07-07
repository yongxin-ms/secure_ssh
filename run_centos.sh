#!/bin/bash
basepath=$(cd `dirname $0`; pwd)

$basepath/centos7/check_invalid_user.sh
$basepath/centos7/check_wrong_passwd.sh
