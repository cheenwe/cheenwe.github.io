---
layout: post
title: Ubuntu开机进入initramfs
tags: ubuntu initramfs
category:  ubuntu
---


# Ubuntu 无法启动直接进入 initramfs

上班第一天换了个位置,打开电脑,显示器一直出现命令行,熟悉的图形界面不见了.重启几次都不行,一直进入 initramfs 模式, 仔细查看后出现以下命令

> the root filesystem on /dev/mapper/mint--vg-root requires a manual fsck



估计是哪次没有关机直接停电了, 或者换位置的时候没有关机导致的 磁盘哪里出现问题了.

网上搜索 ubuntu initramfs 的关键字,出现一大堆的解决方案,一个一个的试, 均未解决.

经查询问题如下:

```
上面是说根节点有文件系统错误, 需要修复. 然后系统自动跑去修复, 修复的是/dev/mapper/debian--vg-root, 修复失败, 模块ehci-orion在内核里面没找到. 所以系统直接进了 initramfs 系统.

这里我们可以分析一下, initramfs 是改进版的tmpfs的应用, linux在启动的时候加载内核和 initramfs 到内存执行, 内核初始化之后, 切换到用户态执行 initramfs 的程序/脚本, 加载需要的驱动模块、必要配置等, 然后加载 rootfs 切换到真正的 rootfs 上去执行后续的 init 过程, 比如桌面等等.

在修复的时候, 去修复了/dev/mapper/debian--vg-root, 实际这是一个链接, 因为根节点实际没有挂载上, 所以这个链接是无效的. 自然就修复失败.

而真实的根节点是挂在/dev/dm-0上的.

```

最后在 initramfs 模式下使用以下命令解决:

```
fsck.ext4 -y /dev/dm-0
```

回车就可以自动修复了, 我的文件系统是ext4, 如果你的是ext3, 就换成fsck.ext3.

修复完重启下就可以重新引导和挂载上根文件系统了.

