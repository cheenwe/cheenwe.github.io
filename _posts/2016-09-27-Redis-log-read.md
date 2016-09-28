---
layout: post
title: Redis 日志调试
tags: redis log
category: redis
---

# MONITOR

MONITOR是一个调试命令流回来Redis的服务器处理的每一个命令。它可以了解正在发生的事情到数据库帮助。该命令可以通过两种Redis的-CLI和通过Telnet使用。

## 连接命令 redis-cli

```sh
redis-cli monitor
```

停止

>Ctrl-C

## 连接命令 telnet

```sh
telnet localhost 6379
```

停止

>QUIT
