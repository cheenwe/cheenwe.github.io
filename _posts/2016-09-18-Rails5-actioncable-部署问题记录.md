---
layout: post
title: actioncable部署记录
tags: rails
category: 服务器
---

# actioncable部署记录
以前的项目中使用Pusher进行消息通知的实时传递，后来由于升级到Rails5，改用自带的actioncable进行通知的实时发送。在部署的过程中需要出现 ws:xxxx 404及 301的问题，

## Nginx配置

```
location @unicorn {
	...
	proxy_http_version 1.1;
	proxy_set_header Upgrade $http_upgrade;
	proxy_set_header Connection "upgrade";
}

```

## 生产环境设置允许请求的地址,不然会出现301错误

```
config.action_cable.allowed_request_origins = ["http://yourhost.com"]
```