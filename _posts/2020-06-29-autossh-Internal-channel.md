---
layout: post
title: 使用 autossh 进行SSH 端口转发，在外网访问内网主机
tags: autossh
category: ssh
---


autossh 是一个用来监控 SSH 链接，并自动进行重连的工具。为了实现从外网直接访问到内网的服务，可通过SSH 端口转发，把内网主机 A 的服务转发至公网主机 B 上 

以下示例将 主机A: 22端口映射到 主机B： 1.10sh.cn 的 11111 端口, 即可在服务器上通过 11111 端口访问局域网内主机 ， 

实际操作中将 1.10sh.cn 换成你的云主机或域名， 以下步骤使用 pc 账户登陆主机 B

操作步骤： 

1. 安装autossh 

        sudo apt  install autossh


2. 生成ssh key

```
sudo -i

ssh-keygen #一直按 enter

ssh-copy-id pc@1.10sh.cn
```

3. 生成连接脚本及服务

脚本示例 将本机的 22 端口映射到  1.10sh.cn 的 11111 端口， 10111可任意修改一个未被占用的端口，用来与代理服务器交互。

可直接输入 issh 本机端口映射或以服务的方式开启

```bash
file=/usr/bin/issh
mv $file $file.bak
cat <<EOF >>$file
#!/bin/bash
autossh -M 10111 -NR 0.0.0.0:11111:localhost:22 pc@1.10sh.cn


EOF
cat $file

chmod +x  $file

file=/lib/systemd/system/issh.service
mv $file $file.bak

cat <<EOF >>$file
[Unit]
Description=autossh shell to connect to my server by chenwei.  #sudo apt  install autossh

Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/issh
ExecReload=/bin/kill -HUP
RestartSec=5s
Restart=on-failure

[Install]
WantedBy=multi-user.target


EOF
cat $file


systemctl enable --now issh.service

systemctl status issh.service

```


4. 连接

先连接远端服务器， 再通过指定用户名及配置的端口连接内网主机。


```bash

ssh pc@1.10sh.cn # 连接远端服务器

ssh ubuntu@localhost -p 11111 # 通过用户名 ubuntu 及映射端口 11111 连接到内网中的主机

```
