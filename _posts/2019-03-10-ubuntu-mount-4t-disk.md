---
layout: post
title: ubuntu 挂载4T大硬盘
tags:    mount  
category:   shell
---

## 挂载4T大硬盘

1. 进行 sudo fdisk -l

查看机器上都插了哪些安装盘，看到/dev/sdd，并且没有进行分区；这个时候是没有挂载的，运行

2. sudo parted /dev/sdd

进入parted，

3.  mklabel gpt 

将磁盘设置为gpt格式，

4.mkpart logical 0 -1 

将磁盘所有的容量设置为GPT格式，然后输入print查看分区结果

5. quit

这个时候应该是默认进行分了一个/dev/sdd1这个分区，这个时候运行

6. sudo mkfs.ext4 -F /dev/sdd1

7. sudo blkid
 
/dev/sdd1: UUID TYPE="ext4" PARTLABEL="logical" PARTUUID="02fe7e48-2bc7-45f6-aafa-d9608c513d5f"



>sudo vim /etc/fstab

UUID=43162e3f-653d-4c44-975e-68494f0df895 /usb ext4         1       2   


