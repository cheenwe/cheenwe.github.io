---
layout: post
title: VirtualBox 给虚拟机磁盘扩容
tags:   virtualbox windows
category:  virtualbox
---



# VirtualBox 扩大磁盘容量

在使用虚拟机的时候磁盘空间突然不够用了，看到 磁盘的格式是"动态分配差分存储"，研究了下如何扩大存储空间，记录如下：

1. 虚拟机关机

2. 打开终端， 进入虚拟机安装目录

先执行VBoxManage list hdds得到你的系统的uuid：

>D:\VirtualBox>VBoxManage list hdds

3.找到你需要修改磁盘的uuid，修改 即可

>D:\VirtualBox>VBoxManage modifyhd  9c7934b4-0f7b-44c8-b3d1-9c1e5f71155d --resize 102400
修改为 100G
