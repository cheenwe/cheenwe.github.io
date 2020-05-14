---
layout: post
title: 基于 DCGM 监控 GPU 服务器
tags:  hpc 
category: hpc monitor
---

本文基于 DCGM 监控 GPU 服务器信息, 并通过 prometheus 实时采集数据到 Grafana 中以图表的样式显示.


## 什么是 DCGM
NVIDIA Data Center GPU Manager (DCGM) 是一套用于在集群环境中管理和监视Tesla™GPU的工具。 它包括主动健康监控，全面诊断，系统警报以及包括电源和时钟管理在内的治理策略。 它可以由系统管理员独立使用，并且可以轻松地集成到NVIDIA合作伙伴的集群管理，资源调度和监视产品中。

DCGM简化了数据中心中的GPU管理，提高了资源可靠性和正常运行时间，自动化了管理任务，并有助于提高整体基础架构效率。 

下载: https://developer.nvidia.com/dcgm

## 安装DCGM

```
sudo dpkg -i datacenter-gpu-manager-fabricmanager_1.7.2_amd64.deb

systemctl enable --now nvidia-fabricmanager.service

#nv-hostengine -t

```

## 安装 prometheus

```
sudo apt -y install prometheus

```


下载服务及工具: https://d.pr/free/f/qcUmPG

解压后依次执行以下命令

```
cp  dcgm-exporter /usr/local/bin/ 
cp   node_exporter /usr/local/bin/  


mkdir /run/prometheus 
  
cp prometheus-dcgm.service  /etc/systemd/system/ 
cp prometheus-node-exporter.service  /lib/systemd/system/

systemctl daemon-reload

systemctl enable --now prometheus-dcgm.service
systemctl enable --now prometheus-node-exporter.service
systemctl enable --now prometheus.service
 
service  prometheus status
service  prometheus-node-exporter status 
service  prometheus-dcgm status
```

## 安装Grafana

参见: https://github.com/cheenwe/cheenwe.github.io/blob/master/_posts/install/grafana.sh

添加 Dashboard: 11752



效果图:

![image](https://user-images.githubusercontent.com/5643208/78774972-115dc700-79c8-11ea-9db8-58951d9f15c3.png)
