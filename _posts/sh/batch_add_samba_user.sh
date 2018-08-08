#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : batch_add_samba_user.sh
#  author      : cheenwe
#  version     : 0.0.1
#  created     : 2018.05.09
#  description : 批量添加 samba 账户及配置文件
#
#  history     : 日志文件
#               1. Date: 2018.05.09
#               Author:  cheenwe
#               Modification: first add
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# 用户主目录地址, 默认应为 /home/
home_path=/data/suanfa/
# 用户所在组
group=suanfa
# 账户信息存储文件位置
users_file=/home/chenwei/shell/users.txt
# 配置文件存储位置
smb_config_file=/etc/samba/smb.conf
# 日期
dt=`date +%Y%m%d`

add_user() {
    username="$1"
    #添加用户并设置组
    useradd $username -M -s /usr/sbin/nologin
    gpasswd -a  $username $group
    usermod -g $group $username
    # 创建用户主目录
    mkdir -p "$home_path$username/up"
    mkdir -p "$home_path$username/down"
    chown -R $username:$group $home_path$username
    # 添加到 samba 并生成密码
    passwd=`cat /dev/urandom | tr -dc A-Za-np-z1-9 | head -c 6`
    echo -e "$passwd\n$passwd" |smbpasswd -a $1 -s
    # 添加 samba 配置文件

    echo "######## 算法用户: $1  日期: $dt ##########" >> $smb_config_file
    # 只允许下载配置
    echo "[$1_down]" >> $smb_config_file
    echo "        comment = $1 download" >> $smb_config_file
    echo "        path = /data/suanfa/$1/down" >> $smb_config_file
    echo "        valid users = $1, @data, @admin" >> $smb_config_file
    echo "        admin users =  @data, @admin" >> $smb_config_file
    echo "        write list =  @data, @admin" >> $smb_config_file
    echo "        browseable = yes" >> $smb_config_file
    echo "        public = no" >> $smb_config_file
    echo "        writable = no" >> $smb_config_file
    echo "        force directory mode = 2777" >> $smb_config_file
    echo "        force create mode = 0644" >> $smb_config_file
    echo "        vfs object=full_audit" >> $smb_config_file
    # 允许上传及下载配置
    echo "[$1_up]" >> $smb_config_file
    echo "        comment = $1 upload" >> $smb_config_file
    echo "        path = /data/suanfa/$1/up" >> $smb_config_file
    echo "        valid users = $1, @data, @admin" >> $smb_config_file
    echo "        admin users = $1" >> $smb_config_file
    echo "        write list = $1" >> $smb_config_file
    echo "        browseable = yes" >> $smb_config_file
    echo "        public = no" >> $smb_config_file
    echo "        writable = yes" >> $smb_config_file
    echo "        force directory mode = 2777" >> $smb_config_file
    echo "        force create mode = 0644" >> $smb_config_file
    echo "        vfs object=full_audit " >> $smb_config_file

    echo "########      end     ##########" >> $smb_config_file

    echo "*******************************************************"
    echo "账号: $1"
    echo "密码: $passwd"
    echo "*******************************************************"

    echo "******************* 算法部 *****************************"  >> $users_file
    echo "账号: $1" >> $users_file
    echo "密码: $passwd"  >> $users_file
    echo "*******************************************************"  >> $users_file
}

if [[ ! -z $1 ]];then

    echo "输入用户个数: $#"
    if [ ! $# == 1 ]; then
        for per in $@;
        do
            add_user $per
        done
    else
        add_user $1
    fi
    exit 1

else

    echo "                添加算法部员工脚本                "
    echo ""
    echo "***************** usage **********************"
    echo "添加单个参数: sudo $0 user"
    echo "添加多个参数: sudo $0 user1 user2"
    echo "****************** end ***********************"
    exit 1
fi
