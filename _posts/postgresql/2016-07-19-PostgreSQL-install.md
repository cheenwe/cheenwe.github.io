---
layout: post
title: PostgreSQL 安装
tags: postgresql
category: postgresql
---

# PostgreSQL 安装
环境： Ubuntu 14.04

## 安装依赖包:

```bash
sudo apt-get install -y postgresql postgresql-client libpq-dev postgresql-contrib
```

## 创建数据库用户:

```bash
sudo -u postgres psql -d template1 -c "CREATE USER root CREATEDB;"
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
