---
layout: post
title: chrony代替ntp同步时间
tags: chrony
category: ntp
---


Chrony能保持系统时钟与时钟服务器（NTP）同步，因此让你的时间保持精确。它由两个程序组成，分别是chronyd和chronyc。chronyd是一个后台运行的守护进程，用于调整内核中运行的系统时钟和时钟服务器同步。它确定计算机增减时间的比率，并对此进行补偿。

chronyc提供了一个用户界面，用于监控性能并进行多样化的配置。它可以在chronyd实例控制的计算机上工作，也可以在一台不同的远程计算机上工作。

 


## 安装 chrony

```
sudo apt install chrony
```


## 配置

nano /etc/chrony/chrony.conf



```
pool 2.debian.pool.ntp.org offline iburst

keyfile /etc/chrony/chrony.keys

commandkey 1

driftfile /var/lib/chrony/chrony.drift

log tracking measurements statistics
logdir /var/log/chrony

maxupdateskew 100.0

dumponexit

dumpdir /var/lib/chrony

#local stratum 10

#allow foo.example.net
#allow 10/8
#allow 0/0 (allow access by any IPv4 node)
#allow ::/0 (allow access by any IPv6 node)

logchange 0.5

hwclockfile /etc/adjtime

rtcsync

cmdallow 192.168.1.0/24
```

```
stratumweight - stratumweight指令设置当chronyd从可用源中选择同步源时，每个层应该添加多少距离到同步距离。默认情况下，CentOS中设置为0，让chronyd在选择源时忽略源的层级。

driftfile - chronyd程序的主要行为之一，就是根据实际时间计算出计算机增减时间的比率，将它记录到一个文件中是最合理的，它会在重启后为系统时钟作出补偿，甚至可能的话，会从时钟服务器获得较好的估值。

rtcsync - rtcsync指令将启用一个内核模式，在该模式中，系统时间每11分钟会拷贝到实时时钟（RTC）。

allow / deny - 这里你可以指定一台主机、子网，或者网络以允许或拒绝NTP连接到扮演时钟服务器的机器。
cmdallow / cmddeny - 跟上面相类似，只是你可以指定哪个IP地址或哪台主机可以通过chronyd使用控制命令

bindcmdaddress - 该指令允许你限制chronyd监听哪个网络接口的命令包（由chronyc执行）。该指令通过cmddeny机制提供了一个除上述限制以外可用的额外的访问控制等级。
```

## 使用chronyc命令

你也可以通过运行chronyc命令来修改设置，命令如下：

```
accheck - 检查NTP访问是否对特定主机可用

activity - 该命令会显示有多少NTP源在线/离线

add server - 手动添加一台新的NTP服务器。

clients - 在客户端报告已访问到服务器

delete - 手动移除NTP服务器或对等服务器

settime - 手动设置守护进程时间

tracking - 显示系统时间信息
```
