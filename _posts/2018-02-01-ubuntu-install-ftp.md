---
layout: post
title: UBuntu install ftp
tags:    ubuntu ftp  vsftpd
category:   ftp
---

公司开发用的 Linux 主机上的　samba　服务挂了, 装了好久也没成功，　主机间文件共享需要通过第三方的主机，　比较麻烦，便想到装个　ftp服务，记录命令如下：

## 安装

＞ sudo apt install vsftpd

## 配置

>nano /etc/vsftpd.conf

```
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES #主动式连接使用的数据通道  / NO 被动模式
#pasv_enable=NO #支持数据流的被动式连接模式 / YES 被动模式
#xferlog_std_format=YES  #日志文件位置
#========== 被动模式
#pasv_min_port=1024(default:0(use any port))
#pasv_max_port=65536(default:0(use any port))

chroot_local_user=YES
#锁定用户到各自的根目录
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
allow_writeable_chroot=YES

secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
#===================

ssl_enable=NO
utf8_filesystem=YES
anonymous_enable=NO

userlist_deny=NO
userlist_enable=YES
#允许登录的用户
userlist_file=/etc/allowed_users
seccomp_sandbox=NO
#添加读取用户配置目录
user_config_dir=/etc/vsftpd/userconf
use_localtime=YES
```
> cat  /etc/vsftpd/userconf/ftper

    local_root=/home/ftper 

> cat /etc/allowed_users

    ftper


touch /etc/vsftpd.chroot_list

## 重启

>sudo /etc/init.d/vsftpd restart



## 创建ftp用户

```
sudo adduser ftper
```




## Docker

- 修改IP 192.168.1.127

```
mkdir /tmp/ftp


docker run -d -p 21:21 -p 20:20 -p 21100-21110:21100-21110 -v /tmp/ftp:/home/vsftpd -e FTP_USER=ftpuser -e FTP_PASS=ftpuser -e PASV_ADDRESS=192.168.1.127 -e PASV_MIN_PORT=21100 -e PASV_MAX_PORT=21110 --name vsftpd --restart=always fauria/vsftpd
```


-其他配置

```
# 进入container

docker exec -i -t vsftpd bash 

# 修改并生成虚拟用户模式下的用户db文件，向文件中最后两行写入用户名和密码
vi /etc/vsftpd/virtual_users.txt

#假如我们添加了user用户，我们需要建立对应用户的文件夹
mkdir /home/vsftpd/user

#把登录的验证信息写入数据库 
/usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db
```


docker restart vsftpd

