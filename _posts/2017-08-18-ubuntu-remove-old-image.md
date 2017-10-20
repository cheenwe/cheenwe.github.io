---
layout: post
title: Ubuntu Boot 空间不足
tags:   ubuntu
category:  ubuntu
---


#  Ubuntu升级时boot分区空间不足

清理不用的内核即可


1. 查看系统现有内核

```
dpkg --get-selections|grep linux-image
```

linux-image-4.4.0-53-generic      install
linux-image-4.8.0-53-generic      install
linux-image-extra-4.4.0-53-generic    install
linux-image-extra-4.8.0-53-generic    install


2. 查看现在使用的内核

>uname -a

Linux chenwei 4.8.0-53-generic #56~16.04.1-Ubuntu SMP Tue May 16 01:18:56 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux


3. 清理/boot分区

>sudo apt-get purge linux-image-4.4.0-53-generic

4. 清理残留文件

到/usr/src目录下，删除已经卸载的内核目录。

cd /usr/src

sudo rm -rf  linux-headers-4.4.0-21/

