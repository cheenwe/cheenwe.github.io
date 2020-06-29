---
layout: post
title: 简单的 python web 服务
tags: python
category: web
---

很多时候新安装的服务器需要进行文件共享，想通过一个简单的方式就能很便捷的把文件共享出去， 可以使用Python中自带了简单的服务器程序，能较容易地打开服务。
 


### python2

```bash
cd /home/data

python -m SimpleHTTPServer 8080
```

在python3中将原来的SimpleHTTPServer命令改为了http.server，使用方法如下：



### python3

```bash
cd /home/data

python3 -m http.server 8080
```



### 指定端口


        python -m http.server 8001



### 写成服务

使用python 启动一个简单的 http 文件服务

```
sudo -i


file=/home/pweb.sh
mv $file $file.bak
cat <<EOF >>$file


#!/bin/bash
python3 -m http.server

EOF
cat $file

chmod +x  $file

file=/lib/systemd/system/pweb.service
mv $file $file.bak
cat <<EOF >>$file

 
[Unit]
Description=Simple python http web by chenwei.

Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/home/pweb.sh
ExecReload=/bin/kill -HUP
RestartSec=5s
Restart=on-failure

[Install]
WantedBy=multi-user.target


EOF
cat $file

systemctl enable --now pweb.service

systemctl status pweb.service
```
