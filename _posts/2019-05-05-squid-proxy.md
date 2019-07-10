---
layout: post
title: 安装squid代理服务器
tags:      proxy
category:   proxy
---

安装squid代理服务器



```


sudo apt-get install squid

vi /etc/squid/squid.conf 

 

　　1）在文件中搜索http_port 3128，修改服务器端要监听的端口，也可以不改，不过这个端口要记住，浏览器设置代理时要用。

 

　　2）设置允许访问的ip段，服务器默认不代理任何客户端

　　在文件中搜索 acl CONNECT method ...，在后面加入

acl lanhome src 10.0.0.0/24
　　3）授权给这一ip段

　　在页面中搜索 http_access allow ...，在后面添加



http_access allow lanhome
 

3 重启服务

sudo service squid restart

```
