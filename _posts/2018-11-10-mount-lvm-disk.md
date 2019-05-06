---
layout: post
title: mount-lvm-disk 
tags:   ubuntu lvm
category:  ubuntu
---


# 解决Linux下挂载LVM重名问题


在ubuntu下使用新硬盘安装系统,安装好以后再挂载原来的硬盘,磁盘使用相同规格，分区格式全为系统默认分区,系统默认使用的 是lvm格式,并且默认的卷都是 ubuntu-vg, 折腾了很久记录如下：

1. 查看LVM分区信息: 

> sudo  pvs

```
  PV         VG        Fmt  Attr PSize PFree
  /dev/sda5  ubuntu-vg lvm2 a--  1.09t    0
  /dev/sdb5  ubuntu-vg lvm2 a--  1.09t    0
```

> sudo lvscan

```
  inactive          '/dev/ubuntu-vg/root' [860.94 GiB] inherit
  inactive          '/dev/ubuntu-vg/swap_1' [255.89 GiB] inherit
  ACTIVE            '/dev/ubuntu-vg/root' [860.94 GiB] inherit
  ACTIVE            '/dev/ubuntu-vg/swap_1' [255.89 GiB] inherit
```

可以分析出前2个是旧系统的盘， 不在激活状态。


2. 查看VG uuid的命令为

> sudo vgs -v

```
    Using volume group(s) on command line.
    Archiving volume group "ubuntu-vg" metadata (seqno 3).
    Archiving volume group "ubuntu-vg" metadata (seqno 3).
    Creating volume group backup "/etc/lvm/backup/ubuntu-vg" (seqno 3).
    Archiving volume group "ubuntu-vg" metadata (seqno 3).
    Archiving volume group "ubuntu-vg" metadata (seqno 3).
    Creating volume group backup "/etc/lvm/backup/ubuntu-vg" (seqno 3).
  VG        Attr   Ext   #PV #LV #SN VSize VFree VG UUID                                VPr
  ubuntu-vg wz--n- 4.00m   1   2   0 1.09t    0  qPCevT-SSvM-nK4Y-dP8G-YPpZ-6Hbm-4UWD4M
  ubuntu-vg wz--n- 4.00m   1   2   0 1.09t    0  Yao9pC-oV7K-zHUN-dLZU-mZh1-hGRU-1YsYlI
```

3. 将旧的磁盘通过uuid重命名

> sudo vgrename  qPCevT-SSvM-nK4Y-dP8G-YPpZ-6Hbm-4UWD4M old

```
[sudo] password for user:
  Volume group "ubuntu-vg" successfully renamed to "old"
```

4. 激活lvm分区

> sudo vgchange -ay /dev/old


5. 挂载
> sudo mount /dev/old/root /mnt/


6. 开机自动挂载


> vi /etc/fstab
 
```
/dev/vg_xxxxxxx_your_lvm_uuid/lv_home /mnt ext4 defaults 00
```

指定卷的文件系统类型（如 ext4）
现在逻辑卷会在每次启动时挂载到/mnt。


## 其他命令


### 查看所有磁盘uuid

>sudo blkid

```
/dev/sda1: UUID="20eb22a1-1f71-485a-b86a-971bda876aa0" TYPE="ext2" PARTUUID="fd5                                                         25dbb-01"
/dev/sda5: UUID="ZT5D20-lwit-wue9-plkv-knJj-iHZf-7q2qbG" TYPE="LVM2_member" PART                                                         UUID="fd525dbb-05"
/dev/sdb1: UUID="d49639ed-3c30-4280-97a1-f63511c5d13d" TYPE="ext2" PARTUUID="bc0                                                         83faa-01"
/dev/sdb5: UUID="vmQJi2-N82x-6q9s-uhd7-CyMN-jKYc-H5gqux" TYPE="LVM2_member" PART                                                         UUID="bc083faa-05"
/dev/mapper/ubuntu--vg-root: UUID="475817e7-7cf9-43f5-bae2-363f3f1f7e48" TYPE="e                                                         xt4"
/dev/mapper/ubuntu--vg-swap_1: UUID="078341b8-1c97-40b4-a1b2-cd946a007ed7" TYPE=                                                         "swap"
```



>sudo lvdisplay ubuntu-vg

 

>sudo vgscan

	Reading all physical volumes.  This may take a while...
	Found volume group "ubuntu-vg" using metadata type lvm2
	Found volume group "ubuntu-vg" using metadata type lvm2

>sudo lvscan
	inactive          '/dev/ubuntu-vg/root' [860.94 GiB] inherit
	inactive          '/dev/ubuntu-vg/swap_1' [255.89 GiB] inherit
	ACTIVE            '/dev/ubuntu-vg/root' [860.94 GiB] inherit
	ACTIVE            '/dev/ubuntu-vg/swap_1' [255.89 GiB] inherit


