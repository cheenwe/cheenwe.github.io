---
layout: post
title: MySQL 用户和授权
tags: mysql
categories: mysql
---


我们知道我们的最高权限管理者是root用户，它拥有着最高的权限操作。包括select、update、delete、update、grant等操作。
那么一般情况会创建一个用户和密码，让你去连接数据库的操作，并给当前的用户设置某个操作的权限（或者所有权限）。
那么这时就需要我们来简单了解一下：

- 如何创建用户和密码
- 给当前的用户授权
- 移除当前用户的权限

## 用户增删改

### 创建用户

```sql
use mysql

# 指定ip：192.168.1.1的 admin 用户登录
create user 'admin'@'192.168.1.1' identified by '123';

# 指定ip：192.168.1.开头的 admin 用户登录
create user 'admin'@'192.168.1.%' identified by '123';

# 指定任何ip的 admin 用户登录
create user 'admin'@'%' identified by '123';

```


### 删除用户

```sql
drop user '用户名'@'IP地址';
```


### 修改用户

```sql
rename user '用户名'@'IP地址' to '新用户名'@'IP地址';
```

### 修改密码

```sql
set password for '用户名'@'IP地址'=Password('新密码');
```


## 用户授权管理


```sql

#查看权限
show grants for '用户'@'IP地址'

#授权 admin 用户仅对db1.t1文件有查询、插入和更新的操作
grant select ,insert,update on db1.t1 to "admin"@'%';

# 表示有所有的权限，除了grant这个命令，这个命令是root才有的。admin 用户对db1下的t1文件有任意操作
grant all privileges  on db1.t1 to "admin"@'%';
#admin 用户对db1数据库中的文件执行任何操作
grant all privileges  on db1.* to "admin"@'%';
#admin 用户对所有数据库中文件有任何操作
grant all privileges  on *.*  to "admin"@'%';

#取消权限

# 取消admin 用户对db1的t1文件的任意操作
revoke all on db1.t1 from 'admin'@"%";

# 取消来自远程服务器的admin 用户对数据库db1的所有表的所有权限

revoke all on db1.* from 'admin'@"%";

取消来自远程服务器的admin 用户所有数据库的所有的表的权限
revoke all privileges on *.* from 'admin'@'%';

```



