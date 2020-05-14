---
layout: post
title: Ubuntu service 脚本编写 示例
tags: service
category:  ubuntu
---

使用 Linux 时经常用到 ` service mysql restart ` 等命令, 方便进行服务的操作,
具体的服务是怎么写的呢,通过以下示例将了解以下内容:

1. 如何写一个简单的服务
2. 服务异常关闭时能自动开启配置


 
## 简单的示例


nano /lib/systemd/system/xx.service 

```
[Unit]
Description=Check GPU INFO by chenwei   # 服务描述
Wants=network-online.target             # 服务依赖于网络
After=network-online.target

[Service]
Type=simple
ExecStart=/root/shell/agent/chkgpu      # 服务开启时执行脚本
ExecReload=/bin/kill -HUP $MAINPID      # 服务重新加载时执行脚本
RestartSec=5s                           # 自动启动间隔时间
Restart=on-failure                      # 在什么情况下会自动重启

[Install]
WantedBy=multi-user.target  
```


```
[Unit]
Description=Advanced key-value store
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf
ExecStop=/bin/kill -s TERM $MAINPID
PIDFile=/var/run/redis_6379.pid
Restart=always
RestartSec=5s
Restart=on-failure


[Install]
WantedBy=multi-user.target
Alias=redis.service
```

## nginx 示例

```
[Unit]
Description=A high performance web server and a reverse proxy server
After=network.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
#ExecStartPre=/usr/local/nginx/sbin/nginx 
ExecStart=/usr/sbin/nginx 
ExecReload=/usr/sbin/nginx -s reload
ExecStop=-/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid
TimeoutStopSec=5
KillMode=mixed

[Install]
WantedBy=multi-user.target

```

## 常用命令

```
systemctl enable --now nginx.service  # 立刻开启并开机启动

systemctl daemon-reload #重新加载

systemctl enable nginx.service #开机时启动
systemctl disable nginx.service #开机时禁用
systemctl list-unit-files|grep enabled #已启动服务列表
systemctl --failed  #启动失败服务列表
 
```


sudo update-rc.d nginx defaults #开机时启动





nano /lib/systemd/system/wssh.service 





### wssh
 
file=/lib/systemd/system/wssh.service 
mv $file $file.bak
cat <<EOF >>$file

[Unit]
Description=Web SSH server by chenwei.  pip install webssh
Wants=network-online.target           
After=network-online.target

[Service]
Type=simple
ExecStart=wssh
ExecReload=/bin/kill -HUP $MAINPID    
RestartSec=5s                         
Restart=on-failure                    

[Install]
WantedBy=multi-user.target  

EOF
cat $file
