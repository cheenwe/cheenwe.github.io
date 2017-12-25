---
layout: post
title: ubuntu 搭建 shadowsocks 服务器
tags: shadowsocks vpn
category: vpn
---

# ubuntu 搭建 shadowsocks服务器

## 安装

```
sudo apt-get update
sudo apt-get install python-gevent python-pip
sudo pip install shadowsocks
```

添加配置文件
>sudo nano /usr/local/lib/python2.7/dist-packages/shadowsocks/config.json

复制以下内容

```sh
{
"server":"0.0.0.0",
"server_port":8388,
"local_port":10808,
"password":"123123123123",
"timeout":600,
"method":"aes-256-cfb"
}
```

保存，退出。

server_port：  端口号，可以自己修改， 客户端记得也要修改
password：  shadowsocks 客户端是需要的密码
timeout：   重连延时
method：  加密方式, 推荐"aes-256-cfb"


## 开启

>/usr/local/bin/ssserver -c /usr/local/lib/python2.7/dist-packages/shadowsocks/config.json

## 设置开机启动

>sudo nano  /etc/rc.local

复制以下内容

>/usr/local/bin/ssserver -c /usr/local/lib/python2.7/dist-packages/shadowsocks/config.json

保存，退出。


## 客户端

<https://github.com/shadowsocks>