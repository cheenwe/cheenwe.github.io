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
#这些设置系统默认是开启的，可以不管
listen=YES
listen_ipv6=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES

#下面的就要自定义设置了，建议系统默认的不管，然后复制下面的

#是否允许匿名访问，NO为不允许
anonymous_enable=NO
#是否允许本地用户访问,就是linux本机中存在的用户，YES允许
local_enable=YES
#是否开启写模式，YES为开启
write_enable=YES

#使用utf8
utf8_filesystem=YES

#新建文件权限，一般设置为022，那么新建后的文件的权限就是777-022=755
local_umask=022

#是否启动userlist为通过模式，YES的话只有存在于userlist文件中的用户才能登录ftp（可以理解为userlist是一个白名单），NO的话，白名单失效，和下面一个参数配合使用
userlist_enable=YES
#是否启动userlist为禁止模式，YES表示在userlist中的用户禁止登录ftp（黑名单），NO表示黑名单失效，我们已经让userlist作为一个白名单，所以无需使用黑名单功能
userlist_deny=NO
#指定哪个文件作为userlist文件，我们稍后编辑这个文件
userlist_file=/etc/vsftpd.user_list

#是否限制本地所有用户切换根目录的权限，YES为开启限制，即登录后的用户不能访问ftp根目录以外的目录，当然要限制啦
chroot_local_user=YES
#是否启动限制用户的名单list为允许模式，上面的YES限制了所有用户，可以用这个名单作为白名单，作为例外允许访问ftp根目录以外
chroot_list_enable=YES
#设置哪个文件是list文件，里面的用户将不受限制的去访问ftp根目录以外的目录
chroot_list_file=/etc/vsftpd.chroot_list
#是否开启写模式，开启后可以进行创建文件夹等写入操作
allow_writeable_chroot=YES

#设置ftp根目录的位置,这个文件我们稍后自己创建
local_root=/home/ftp
```
## 重启

>sudo /etc/init.d/vsftpd restart



## 创建ftp用户

```
sudo mkdir /home/ftp
sudo useradd -d /home/ftp -s /bin/bash ftp
sudo passwd ftp

```

