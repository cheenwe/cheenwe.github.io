---
layout: post
title:  seaweedfs
tags:   server filesystem
category:   server filesystem
---

# seaweedfs

seaweedfs是一个由 golang 开发的分布式存储文件的系统, 适用于存储大量小文件。

## 安装
```shell

# install golang

wget https://dl.gocn.io/golang/1.9.2/go1.9.2.linux-amd64.tar.gz
sudo tar -C /usr/local -zxvf go1.9.2.linux-amd64.tar.gz

mkdir -p ~/go/src
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
go version

# install mercurial

sudo apt install git mercurial

# install seaweedfs
#go get github.com/chrislusf/seaweedfs/go/weed

wget  https://github.com/chrislusf/seaweedfs/releases/download/0.76/freebsd_amd64.tar.gz
sudo tar -C /usr/local/bin/ freebsd_amd64.tar.gz

```

## 使用

开启服务

```shell
# 启动主服务: localhost:9333
./weed master
# 启动卷服务:
./weed volume -max=100 -mserver="localhost:9333"

# 或者

./weed server -master.port=9333 -volume.port=8080 -dir="/tmp/data"

```

上传文件

```
curl -F file=@/tmp/1.jpg http://localhost:9333/submit [15:19:42]
>{"fid":"6,61db2c0e36","fileName":"1.jpg","fileUrl":"192.168.100.2:8080/6,61db2c0e36","size":131983}%

#或

# 提交一个存储请求，这个时候weed先要分配一个全局的文件ID
curl -X POST http://192.168.100.2:9333/dir/assign

# 存储一张图片
curl -X PUT -F file=@/tmp/1.jpg http://192.168.100.2:8080/6,04f00144db
```
访问 192.168.100.2:8080/6,61db2c0e36 即查看上传文件

----
参考:　https://yanyiwu.com/work/2015/01/09/weed-fs-source-analysis.html

