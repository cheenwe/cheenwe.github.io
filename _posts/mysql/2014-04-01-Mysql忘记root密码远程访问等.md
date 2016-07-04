---
layout: post
title: MySQL忘记root密码
tags: MySQL 服务器 数据库
categories: MySQL
---
　

## Mysql忘记root密码解决方案
包含 MySql 5.7

### KILL掉系统里的MySQL进程；

### 用以下命令启动MySQL，以不检查权限的方式启动；
>mysqld_safe -skip-grant-tables &

或者 (MySql 5.7):
>sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

在 [mysqld]下添加
>skip-grant-tables

### 进入管理命令行,修改密码
>mysql -u root
Welcome to the MySQL monitor.  Commands end with ; or \g.

>use mysql

>update mysql.user set password=PASSWORD('root'） where User='root'；

或者（MySql 5.7）：
>update mysql.user set authentication_string=password('root') where user='root' and Host = 'localhost';

>flush privileges；

>quit


## 修改完root密码后。 phpmyadmin 无法登录

需要修改phpmyadmin的配置文件，让其连接到MySQL数据库，用记事本打开 config.inc.php 文件，查找下面几个部分并修改

$cfg['Servers'][$i]['host'] = 'localhost';

$cfg['Servers'][$i]['port'] = '3306';

$cfg['Servers'][$i]['user'] = '这里填写用户名';

$cfg['Servers'][$i]['password'] = '这里填写你的MySQL密码';

$cfg['Servers'][$i]['AllowNoPassword'] = true;

保存 config.inc.php 后，重启服务器即可访问 phpmyadmin 了。
　
