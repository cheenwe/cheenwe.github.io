---
layout: post
title: PostgreSQL 安装
tags: postgresql 安装
category: postgresql
---

# PostgreSQL 安装
环境： Ubuntu 14.04

## 安装依赖包:


## Add PG sources
```bash
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdb.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```

```bash
sudo apt-get install -y postgresql postgresql-client libpq-dev postgresql-contrib
```

## 创建数据库用户:

```bash
sudo -u postgres psql -d template1 -c "CREATE USER root CREATEDB;"

#sudo su postgres -c "createuser -d -R -S $USER"
```

## 从模板中创建数据库并授予权限
```bash
sudo -u postgres psql -d template1 -c "CREATE DATABASE ran_dev OWNER root;"
```

## 开启 `pg_trgm` 拓展 :

pg_trgm是用来做相似度匹配的，在一些情况下也可以拿来代替全文检索做字符匹配。
从大量数据中通过字符串的匹配查找数据的关键是索引，对字符串的精确相等匹配，前缀匹配(like 'x%')和后缀匹配(like '%x')可以使用btree索引,对中缀匹配(like '%x%')和正则表达式匹配就可以用pg_trgm的索引了。

```bash
sudo -u postgres psql -d template1 -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
```

## 已新建用户登陆数据库:

```bash
sudo -u root -H psql -d ran_dev
```

##  检查拓展 `pg_trgm` 是否开启:

```bash
    SELECT true AS enabled
    FROM pg_available_extensions
    WHERE name = 'pg_trgm'
    AND installed_version IS NOT NULL;
```

如果开启输出如下:

```
    enabled
    ---------
     t
    (1 row)
```

## 关闭数据库连接:

```bash
ran_dev> \q
```


## 修改PostgreSQL数据库默认用户postgres的密码

PostgreSQL数据库创建一个postgres用户作为数据库的管理员，密码随机，所以需要修改密码，方式如下：

1. 登录PostgreSQL

		sudo -u postgres psql


2. 修改登录PostgreSQL密码

		ALTER USER postgres WITH PASSWORD 'postgres';

## PostgreSQL 允许远程访问设置方法
1.修改pg_hba.conf文件，配置用户的访问权限（#开头的行是注释内容）：

		host  all    all    192.168.1.0/24    md5
		#表示允许网段192.168.1.0上的所有主机使用所有合法的数据库用户名访问数据库，并提供加密的密码验证。

2.修改postgresql.conf文件，将数据库服务器的监听模式修改为监听所有主机发出的连接请求。

		listen_addresses=’localhost’


## 用户授权

	sudo -u postgres psql
	grant all on database crm_db to root;

	#取消
	revoke all on database crm_db from root;



## 修改密码


		alter user ubuntu with password 'ubuntu';

