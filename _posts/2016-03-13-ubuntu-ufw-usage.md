---
layout: post
title: Ubuntu 防火墙 ufw 使用
tags: ubuntu nginx
categories: server
---

# ufw
参考 https://help.ubuntu.com/community/UFW

## 安装
    sudo apt-get install ufw （一般Ubuntu已默认安装 ufw）

## 配置
    sudo ufw enable #开启防火墙，并在系统启动时自动开启

    sudo ufw default deny #关闭所有外部对本机的访问，但本机访问外部正常。

    sudo ufw allow 53 #允许 53 端口

    sudo ufw delete allow 53  #禁用 53 端口

    sudo ufw allow 80/tcp #允许 80 端口的tcp协议

    sudo ufw delete allow 80/tcp  #删除 80 端口的tcp协议许可

    sudo ufw allow 6881:6999/tcp  #许可一定范围端口 6881 – 6999 (torrent)
