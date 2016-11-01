---
layout: post
title: 修改 postgresql 密码
tags: postgresql sql
category: postgresql
---


# 修改PostgreSQL数据库默认用户postgres的密码
PostgreSQL数据库创建一个postgres用户作为数据库的管理员，密码随机，所以需要修改密码，

- 方式如下：

## 登录PostgreSQL

>sudo -u postgres psql

## 修改登录PostgreSQL密码

>ALTER USER postgres WITH PASSWORD 'postgres';