---
layout: post
title: 内网转发
tags: ssh 
category: ssh
---

## 配置 SSH 端口转发

步骤如下:

### 内网主机A(192.168.30.29)中执行：

```
ssh -R 3029:192.168.30.29:22 -Nf chenwei@cheenwe.cn
```

其中3029为服务器B(cheenwe.cn)的端口号

### 其他主机访问A

```
ssh chenwei@localhost -p 3029
```





## 内网端口映射

### 外网主机配置监听端口可以绑定到任意其他ip

sudo nano /etc/ssh/sshd_config

```
添加
GatewayPorts yes
```

sudo service sshd restart


### 内网主机配置
```
sudo apt-get install autossh
sudo -i

autossh -M 3019 -NfR 0.0.0.0:3009:localhost:87 chenwei@v.emdata.cn
```

将 内网的87 端口映射到外网 3009 端口上

这里 -M 后面任意填写一个可用端口即可，-N 代表只建立连接，不打开shell ，-f 代表建立成功后在后台运行，-R 代表指定端口映射。


将本地的 80映射到 8001
