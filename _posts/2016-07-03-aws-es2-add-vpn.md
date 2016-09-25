---
layout: post
title: AWS上Ubunt系统添加VPN
tags: 服务器 VPN
category: 服务器
---

记录在AWS上安装搭建VPN,Mac及iPhone测试可成功使用,Linux Mint 无法链接.

## 安装VPN软件
>sudo apt-get install pptpd

## 配置VPN

### 编辑内网IP配置
>sudo nano /etc/pptpd.conf

### 删除配置文件的末尾的
>localip

>remoteip

两行的注释
control+o（保存），control+x（退出）

#### 编辑选项文件
>sudo nano /etc/ppp/pptpd-options

删除选项文件中的

>ms-dns

的注释（默认是内网IP，看个人喜好修改，我是修改成了8.8.8.8,4.4.4.4）
control+o（保存），control+x（退出）

### 编辑账户文件
添加用户

>sudo nano /etc/ppp/chap-

增加或修改用户信息，规则是：用户名，服务器，密码，授权IP地址

>user pptpd password *

control+o（保存），control+x（退出）

## 重启pptpd

>sudo /etc/init.d/pptpd restart

以上pptpd的配置就完成了，但是，还需要配置ipv4.ip_forward

## 配置ipv4.ip_forward

>sudo nano /etc/sysctl.conf

删除

>net.ipv4ip_forward=1

的注释

control+o（保存），control+x（退出）

>sudo sysctl -p

## 配置系统防火墙iptables
开系统防火墙iptables，允许VPN：

### 查看默认iptables:
>sudo iptables -L -nv


### 添加防火墙规则
>sudo iptables -A INPUT -p tcp -i eth0 --dport ssh -j ACCEPT


### 添加防火墙规则
>sudo iptables -A INPUT -p tcp -i eth0 --dport 1723 -j ACCEPT


### 添加NAT规则
>sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE

(192.168.0.0视第一部分分配的IP地址段自行修改)

### 启动防火墙
>modprobe ip_tables

## 记得在AWS的控制台上允许所有流量进出
