---
layout: post
title: Ubuntu挂载新硬盘
tags:  ubuntu disk
category: server
---


# Ubuntu挂载新硬盘

##步骤

### 加挂硬盘
    sudo hdparm -I /dev/sdb
硬盘硬件安装后，此命令测试linux系统是否能找到挂载的未分区硬盘


### 创建分区
    sudo fdisk /dev/sdb
 sda是第一块SCSI硬盘，sdb第二块，以此类推...物理分区使用a、b编号，每个物理硬盘最多有四个主逻辑分区（或扩展分区），所以自动分区中，扩展分区sda2下第一个逻辑分区编号从5开始
第一次执行sudo fdisk /dev/sdb，出现了Error: Unable to open /dev/sdb - unrecognised disk label.  提示找不到磁盘标签，可以使用 parted 进行分区(sudo parted  /dev/sdb )。

```ruby
Command (m for help):
这里按m获得帮助
a   toggle a bootable flag   将分区设置为启动区
b   edit bsd disklabel    编辑bsd的disklabel
c   toggle the dos compatibility flag  设置该分区为dos分区
d   delete a partition 删除分区
l   list known partition types  列出已知的分区类型
m   print this menu  打印帮助列表
n   add a new partition 创建新分区
o   create a new empty DOS partition table
p   print the partition table查看分区信息
q   quit without saving changes 退出不保存
s   create a new empty Sun disklabel
t   change a partition's system id改变分区类型
u   change display/entry units
v   verify the partition table
w   write table to disk and exit 保存退出
x   extra functionality (experts only)

Command (m for help):p  //查看新硬盘的分区
********************************************************************
Disk /dev/sdb: 1000204 MB, 1000202273280 bytes
255 heads, 63 sectors/track, 121601 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Device Boot Start End Blocks Id System
********************************************************************
Command (m for help):n  //创建新分区
File system type  (default ext2): ext3    //输入想使用的分区格式
Partition name:  backup                      //输入分区的名字
First cylinder  (default 0cyl):                //第几个柱面，我们按照默认
Last cylinder or +size or +sizeMB or +sizeKB  (default 0cyl):+1000000M    //这里我们按大小输入 即+1000000M (注意这个M为大写)
Warning: You requested a partition from 0cyl to 121576cyl.
The closest location we can manage is 1cyl to 121575cyl.  Is this still
acceptable to you?
   y   Yes
   n   No
当然是y
Command (m for help): p            //查看新硬盘分区后的情况
********************************************************************
Disk /dev/sdb: 1000 GB, 1000202273280 bytes
255 heads, 63 sectors/track, 121601 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               2      121576   976559157   83  Linux
******************************************************************
Command (m for help): w
Information: Don't forget to update /etc/fstab, if necessary.            //写入硬盘分区属性并结束
```

### 格式化硬盘
```console
sudo mkfs -t ext3 /dev/sdb1               //把上面创建的新硬盘分区格式化为ext3格式，这个要等一会才能自动结束
********************************************************************************
mke2fs 1.40.8 (13-Mar-2008)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
61038592 inodes, 244137796 blocks
12206889 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=0
7451 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
    32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
    4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
    102400000, 214990848

Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 37 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
********************************************************************************
```

### 设置sdb1的卷标
    sudo e2label /dev/sdb1 /backup
这里/backup 就是在/dev/sdb1根下起了个名字


### 设置挂载点
    sudo mkdir /backup
在根路径下创建挂载点


### 设置开机自动挂载

>sudo vim /etc/fstab

在根路径下创建挂载点.

```console
<file system> <mount point>   <type>  <options>       <dump>      <pass>

    1                         2                      3              4                   5                6
1 指代文件系统的设备名。最初，该字段只包含待挂载分区的设备名（如/dev/sda1）。现在，除设备名外，还可以包含LABEL或UUID
2 文件系统挂载点。文件系统包含挂载点下整个目录树结构里的所有数据，除非其中某个目录又挂载了另一个文件系统
3 文件系统类型。下面是多数常见文件系统类型（ext3,tmpfs,devpts,sysfs,proc,swap,vfat）
4 mount命令选项。mount选项包括noauto（启动时不挂载该文件系统）和ro（只读方式挂载文件系统）等。在该字段里添加用户或属主选项，即可允许该用户挂载文件系统。多个选项之间必须用逗号隔开。其他选项的相关信息可参看mount命令手册页（-o选项处）
5转储文件系统？该字段只在用dump备份时才有意义。数字1表示该文件系统需要转储，0表示不需要转储
6文件系统检查？该字段里的数字表示文件系统是否需要用fsck检查。0表示不必检查该文件系统，数字1示意该文件系统需要先行检查（用于根文件系统）。数字2则表示完成根文件系统检查后，再检查该文件系统

文件中增加如下配置信息

LABEL=/backup   /backup      ext3        defaults        1       2
 挂载分区的卷标名称    挂载点  挂载分区文件类型  挂载方式         略         略

或者

/dev/sdb1     /backup      ext3      defaults      1      2
或者在命令行手动挂载（每次重启机器后都需要执行一次）

mount -vl -t ext3 /dev/sdb1 /backup  挂载文件系统/显示标签
```

### 重启机器查看结果

>df -h //查看分区空间使用情况，就可以看到/backup已经自动挂载

Filesystem            Size  Used Avail Use% Mounted on
/dev/sda1             139G  121G   12G  92% /
/dev/sdb1             924G   90G  834G   11% /backup