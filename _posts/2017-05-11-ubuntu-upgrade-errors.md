---
layout: post
title: ubuntu 报错问题记录
tags:  ubuntu
category:  ubuntu
---


# ubuntu 报错问题记录

>dpkg: error processing package util-linux (--configure)



$ sudo mv /var/lib/dpkg/info/ /var/lib/dpkg/info_old/
$ sudo mkdir /var/lib/dpkg/info/
$ sudo apt-get update


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


重新配置时区

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