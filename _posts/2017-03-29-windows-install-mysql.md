---
layout: post
title: Window 安装 MySQL步骤
tags: mysql
category:  mysql windows
---


# 安装步骤

##下载安装包

>https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-5.7.17.0.msi

或在共享文件夹下载:  \\192.168.103.229\windows\databases\mysql5.7

## 安装

直接下一步到结束,默认安装路径
> C:\Program Files\MySQL\MySQL Server 5.7

打开 my-default.ini 文件, 添加以下内容

```sh
[mysqld]
basedir = C:\Program Files\MySQL\MySQL Server 5.7
datadir = C:\Program Files\MySQL\MySQL Server 5.7\data
```

，另存为 my.ini

## 配置环境变量

计算机-右键属性-高级系统设置-环境变量，在Path的值后面添加

>C:\Program Files\MySQL\MySQL Server 5.7\bin

点击确定。

## 初始化

在终端中执行

>mysqld --initialize

## 初始化root密码
1. 终端中输入

>mysqld --skip-grant-tables

回车，这个CMD会卡死，不管它；

2.另开一个终端输入

>mysql -u root
进入mysql数据库；
3.修改root密码为 123456

>use mysql
>update user set authentication_string = password("123456") where user = "root";
>flush privileges;
>exit