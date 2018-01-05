---
layout: post
title: ubuntu 报错问题记录
tags:  ubuntu
category:  ubuntu
---


# ubuntu 报错问题记录

## Windows 无法访问 \\192.168.xx.xx 您没有权限访问 \\192.168.xx.xx 请于网络管理员联系请求访问权限

安装配置完 samba 后无法访问,出现以上问题, 关闭 selinux

修改`/etc/selinux/config`文件中设置`SELINUX=disabled` ，然后重启服务器。

临时方法:
>setenforce 0

## dpkg was interrupted,you must manually run dpkg --configure -a‘ to correct the problem
```shell
sudo rm /var/lib/dpkg/updates/*

sudo apt-get update

sudo apt-get upgrade

```

## dpkg: error processing package util-linux (--configure)



```shell
 sudo mv /var/lib/dpkg/info/ /var/lib/dpkg/info_old/
 sudo mkdir /var/lib/dpkg/info/
 sudo apt-get update

```


```
dpkg: warning: files list file for package 'libjpeg8:amd64' missing; assuming package has no files currently installed
dpkg: warning: files list file for package 'libcpan-meta-perl' missing; assuming package has no files currently installed
dpkg: warning: files list file for package 'python-talloc' missing; assuming package has no files currently installed
dpkg: warning: files list file for package 'python3-lazr.uri' missing; assuming package has no files currently installed
```

解决方法

```sh
for package in $(apt-get upgrade 2>&1 |\
                 grep "warning: files list file for package '" |\
                 grep -Po "[^'\n ]+'" | grep -Po "[^']+"); do
    apt-get install --reinstall "$package";
done
```


## 重新配置时区

>dpkg-reconfigure tzdata


Processing triggers for dbus (1.10.10-1ubuntu2) ...
Processing triggers for libgdk-pixbuf2.0-0:amd64 (2.36.5-3) .


>sudo apt upgrade

Reading package lists... Done
Building dependency tree
Reading state information... Done
Calculating upgrade... Done
The following packages have been kept back:

执行:

>apt-get -u dist-upgrade
