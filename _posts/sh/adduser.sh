#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : adduser.sh
#  author      : cheenwe
#  version     : 0.0.1
#  created     : 2018.08.046
#  description : 批量添加用户
#  usage: bash adduser.sh
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


#		添加用户
#=== start ====
username=user
password=user

sudo useradd $username
echo -e "$password\n$password" |sudo passwd $username

echo "next step"
echo ""
echo "sudo vi /etc/sudoers"
echo "$username ALL=(ALL:ALL) ALL"

echo ""

#=== end ====



#	 重置密码
#=== start ====
password=123
echo -e "$password\n$password" |sudo passwd user

#=== end ====
