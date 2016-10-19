---
layout: post
title: Ubuntu查看crontab运行日志
tags: cron
category: server
---

# Ubuntu查看crontab运行日志
近两天在研究使用 ruby 写脚本定时备份数据库 , 并发邮件到邮箱的脚本 , 用到 crontab .  但是邮件没有发送成功 ， 手动执行没问题 ， 想找 crontab 的执行日志 。 在网上查了下如何开启 crontab 的日志 ， 记录如下 ：

## 开启 crontab 日志

>sudo nano /etc/rsyslog.d/50-default.conf

找到

> cron.*                          /var/log/cron.log

去掉注释。

## 重启
>sudo  service rsyslog  restart


## 查看
>tailf /var/log/cron.log