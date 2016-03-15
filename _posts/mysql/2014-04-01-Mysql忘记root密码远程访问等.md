---
layout: post
title: Mysql忘记root密码
tags: mysql 服务器
categories: mysql server
---

# Mysql笔记整理
整理记录在有道云笔记内的内容

## Mysql忘记root密码
    1. KILL掉系统里的MySQL进程；

    2. 用以下命令启动MySQL，以不检查权限的方式启动；
>mysqld_safe -skip-grant-tables &

    3. 用空密码进入mysql管理命令行，切换到mysql库, 修改密码
>mysql -u root
Welcome to the MySQL monitor.  Commands end with ; or \g.

>mysql> use mysql

>mysql> update mysql.user set password=PASSWORD（'新密码'） where User='root'；

>mysql> flush privileges；

>mysql> quit

    4.  重新启动MySQL，就可以使用新密码登录了

## 修改完root密码后。 phpmyadmin 无法登录

需要修改phpmyadmin的配置文件，让其连接到MySQL数据库，用记事本打开 config.inc.php 文件，查找下面几个部分并修改

$cfg['Servers'][$i]['host'] = 'localhost';

$cfg['Servers'][$i]['port'] = '3306';

$cfg['Servers'][$i]['user'] = '这里填写用户名';

$cfg['Servers'][$i]['password'] = '这里填写你的MySQL密码';

$cfg['Servers'][$i]['AllowNoPassword'] = true;

保存 config.inc.php 后，重启服务器即可访问 phpmyadmin 了。

## 配置远程访问mysql

>use mysql;

>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;

>FLUSH PRIVILEGES;

或者
>use mysql;

>update user set host = '%' where user = 'root';

## 导入导出数据库
1.导出整个数据库
>mysqldump -u root -p root crm > /home/crm.sql
mysqldump -u用户名 -p密码 数据库名 > 导出位置/数据库名.sql

2.导出一个表
>mysqldump -u 用户名 -p 数据库名 表名>xx.sql

3.导出一个数据库结构
>mysqldump -u wcnc -p -d --add-drop-table smgp_apps_wcnc >d:wcnc_db.sql
-d 没有数据 --add-drop-table 在每个create语句之前增加一个drop table
4.导入数据库

>source d:xx.sql