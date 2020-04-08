---
layout: post
title: Ubuntu设置允许root用户登录
tags: ssh root login
category: server
---

# Ubuntu设置允许root用户登录
新装的 Ubuntu server 默认未开启root 用户，开启的方式如下。

## 设置root登陆密码

> sudo passwd root

```
password="root"
echo -e "$password\n$password" |sudo passwd root
```

## 修改 ssh  允许 root 登陆

>sudo nano /etc/ssh/sshd_config

修改

>PermitRootLogin yes


## 重启 ssh 服务

>sudo service ssh restart




```
echo 'PermitRootLogin  yes' >> /etc/ssh/sshd_config
sudo service  ssh restart
```