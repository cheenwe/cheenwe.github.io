---
layout: post
title: VirtualBox 开机自动启动虚拟机
tags:   virtualbox windows
category:  virtualbox
---




# VirtualBox 开机自启动虚拟机

1. 开启

```
@echo off
D:\VirtualBox\VBoxManage.exe -q startvm "UBUNTU" --type headless
rem pause
```

2. 关闭

```
@echo off
D:\VirtualBox\VBoxManage.exe controlvm "UBUNTU" poweroff
rem pause
```

