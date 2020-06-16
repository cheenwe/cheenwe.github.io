---
layout: post
title: 使用 ansible 部署分布式Minio
tags:  minio
category:  storage 
---


MinIO 是一个基于Apache License v2.0开源协议的对象存储服务。它兼容亚马逊S3云存储服务接口，非常适合于存储大容量非结构化的数据，例如图片、视频、日志文件、备份数据和容器/虚拟机镜像等，而一个对象文件可以是任意大小，从几kb到最大5T不等。

MinIO是一个非常轻量的服务,可以很简单的和其他应用的结合，类似 NodeJS, Redis 或者 MySQL。


启动分布式Minio实例，5个节点，每节点1块盘(/data/data)，需要在5个节点上都运行下面的命令。

##  部署相关

```
qx1 192.168.70.151
qx2 192.168.70.152
qx3 192.168.70.153
qx4 192.168.70.154
qx5 192.168.70.155
```

访问端口:

    9000

账户/密码: 

    abc/abc123

- 官方示例图

![](https://github.com/minio/minio/blob/master/docs/screenshots/Architecture-diagram_distributed_8.jpg?raw=true)

## 操作命令

    

```bash

### MINIO

wget https://dl.min.io/server/minio/release/linux-amd64/minio

ansible all -m copy -a "src=./minio dest=/usr/local/bin/"

ansible all  -a "chmod +x /usr/local/bin/"

ansible all -a "mkdir /root/sh"

file=/root/sh/minio.sh
cat <<EOF >>$file

export MINIO_ACCESS_KEY=abc
export MINIO_SECRET_KEY=abc123
minio server http://192.168.70.151:9000/data/data http://192.168.70.152:9000/data/data \
               http://192.168.70.153:9000/data/data http://192.168.70.154:9000/data/data \
               http://192.168.70.155:9000/data/data
EOF
cat $file


file=/root/sh/minio.service
cat <<EOF >>$file

[Unit]
Description=Minio service    
Wants=network-online.target              
After=network-online.target

[Service]
Type=simple
ExecStart=/root/sh/minio.sh
ExecReload=/bin/kill -HUP $MAINPID
RestartSec=5s
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF
cat $file


ansible all -m copy -a "src=/root/sh/minio.sh dest=/root/sh"

ansible all -m copy -a "src=/root/sh/minio.service dest=/lib/systemd/system/"

ansible all  -a "chmod +x /root/sh/minio.sh"


ansible all  -a "systemctl daemon-reload"
ansible all  -a "systemctl enable --now minio.service"


```

### 服务
 
```
service  minio.service status
service  minio.service stop
service  minio.service start

```
