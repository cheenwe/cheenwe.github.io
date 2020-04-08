---
layout: post
title: 基于 gpustat 监控 GPU 显卡利用率等
tags:  hpc 
category: hpc
---

基于 gpustat 生成 GPU 信息的 json 数据, 使用 http 发送到服务端, 然后服务端解析数据实时显示到页面上.
减少大量使用 nvidia-smi 照成服务器卡顿,提高性能.


## 安装 gpustat

```
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U


pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple


pip install  pytest-runner 

pip install   gpustat

pip install   requests

```

## agent 监控端

下载: https://d.pr/free/f/zmTeJA


## 服务端

基于 Ruby On Rails + Sqlite3 数据库 + Websocket 实现. [代码略]

效果图:

![image](https://user-images.githubusercontent.com/5643208/78780657-8aade780-79d1-11ea-9b37-bdd00b61abb0.png)
