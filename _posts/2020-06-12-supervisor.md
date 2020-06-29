---
layout: post
title: 使用 supervisor 管理多个程序
tags: supervisor
category: web
---



Supervisor是一个c/s架构的进程管理工具，提供web页面管理及xmlrpc接口，能对进程进行自动重启等操作。
适用于对项目中多个服务进行统一管理。文档： http://www.supervisord.org/



### 安装

```

git clone https://github.com/cheenwe/supervisor /etc/

##前两步设置pip源，可忽略
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

pip install supervisor


## 设置 supervisor 开机启动
sudo cp /etc/supervisor.service  /lib/systemd/system/
sudo systemctl enable --now supervisor.service  

```

### 访问服务

http://127.0.0.1:9001


```
用户名： admin
密码： admin2020

```

可在 supervisor.conf 文件中修改端口及用户名密码。


### 服务配置

为方便维护各个服务，每个服务一个配置文件进行管理，服务文件名需和配置文件中 program 保持一致，示例：

[sp_ssh](conf/sp_ssh.ini)


 
### 常用命令


```
service supervisor status 

service supervisor restart 

supervisorctl status sp_ssh # 查看 ssh 服务状态
supervisorctl start sp_ssh
supervisorctl stop sp_ssh

supervisorctl reload： 重新启动配置中的所有程序


supervisorctl update # 配置文件修改后,重新加载配置

```


### XML-RPC API 


```
# pip install xmlrpclib

import xmlrpclib
server = xmlrpclib.Server('http://admin:admin2020@127.0.0.1:9001/RPC2')
methods = server.system.listMethods()
print(methods)

```

### 其他

安装supervisor时需要装很多python依赖，为了简便使用该服务，有大神使用golang重写了该程序，
可直接运行该服务更多参见： https://github.com/ochinchina/supervisord