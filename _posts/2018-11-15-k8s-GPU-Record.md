---
layout: post
title: GPU 集群 问题解决
tags:    gpu k8s 
category:   k8s
---

## GPU 集群 问题解决 

### 挂载存储
    sudo mount -t glusterfs -o xlator-option=*dht.use-readdirp=no,use-readdirp=no,xlator-option=*md-cache.force-readdirp=no node1:/data1 /home/newnfs/nfsdir/

### 挂载SSD存储
    sudo mount -t glusterfs -o xlator-option=*dht.use-readdirp=no,use-readdirp=no,xlator-option=*md-cache.force-readdirp=no node1:/SSD /home/newnfs/

### k8s 平台出错 
K8s 平台出错一般属于比较严重的问题，导致 k8s 问题的因素比较负责，一般的排错思路还
是主要通过日志文件/var/log/syslog。当怀疑是 k8s 出错后，查看正常服务的 pod 是否还是正
常状态。
确认集群节点信息是否全是 ready。

> kubectl get no -o wide -a

确认集群相关服务 pod 是否正常，确认 nvidia-device 插件正常状态和 dns 与监控 pod 是否
正常。

>kubectl get po -o wide -a

>kubectl get po -o wide -a -n kube-system


重启节点服务

>service  kubelet restart/status

### 重启后操作

```
systemctl status docker
docker version
docker ps
vim /var/log/syslog
systemctl  restart docker.service
systemctl  status docker.service
systemctl  restart  kube-proxy.service
systemctl  restart  kubelet.service
```



### 安装中文语言包

```
apt-get update && apt-get install language-pack-zh-hans
apt install ibus-pinyin ibus-libpinyin

1. 修改/etc/default/locale

LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh"
LC_MONETARY="zh_CN"
LC_PAPER="zh_CN"
LC_NAME="zh_CN"
LC_ADDRESS="zh_CN"
LC_TELEPHONE="zh_CN"
LC_MEASUREMENT="zh_CN"
LC_IDENTIFICATION="zh_CN"
LC_ALL="zh_CN.UTF-8"

2. Source 配置文件

source /etc/default/locale

4.退出，重新 ssh 容器或者重新打包成镜像
```

### 重启 vmvare 相关服务

    for i in docker ps -a |grep vmware |awk '{print $1}'; do docker restart $i; done
