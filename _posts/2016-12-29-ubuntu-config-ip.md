---
layout: post
title: Ubuntu 设置 IP
tags: ubuntu config
category:  ubuntu
---

# Ubuntu 设置 IP
在配置本地服务器时, 记录配置 ip 命令如下:


## 自动获取 IP

### 释放IP
>sudo dhclient -r

### 获取IP
>sudo dhclient

指定网卡

>sudo dhclient em1

或者编辑配置文件

>sudo nano /etc/network/interfaces

```sh
auto em1
iface em1 inet dhcp
```

## 固定 IP

### 配置ip
>sudo nano /etc/network/interfaces


```sh
auto em2
iface em2 inet static
  address 192.168.10.200
  netmask 255.255.255.0
  network 192.168.10.0
  broadcast 192.168.10.255
  gateway 192.168.10.1
  # dns-* options are implemented by the resolvconf package, if installed
  dns-nameservers 114.114.114.114
```

## 服务重启

>sudo service networking restart

或者重启网卡

>ifconfig em2 down

>ifconfig em2 up