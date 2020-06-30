---
layout: post
title: MySQL 数据库的编码格式
tags: mysql  
categories: mysql
---


MySQL服务器可以支持多种字符集，在同一台服务器，同一个数据库，甚至同一个表的不同字段都可以指定使用不同的字符集, 十分灵活。

每种字符集都可能有多种校对规则，都有一个默认的校对规则，并且每个校对规则只是针对某个字符集，和其他的字符集么有关系。

在数据库创建时如果不设置数据库的默认字符编码,即缺省时会使用系统的字符编码latin1。这时需要将字符集修改成 utf-8 格式, 以下为修改步骤.


### 查看数据库的字符编码

```bash
show variables like '%char%';
```

### 修改 mysql 字符集


```bash

set character_set_client=utf8;

set character_set_connection=utf8;

set character_set_database=utf8;

set character_set_results=utf8;

set character_set_server=utf8;

set character_set_system=utf8;

set collation_connection=utf8;

set collation_database=utf8;

set collation_server=utf8;

```

可根据实际情况按需修改

### 查看数据库 test 字符编码

```bash
show create database test;
```

### 查看字段字符编码


```bash

SHOW FULL COLUMNS FROM test;
```

### 修改 test 数据库字符编码

```bash
alter database test CHARACTER SET utf8 COLLATE utf8_general_ci;
```



### 修改数据表 users 的字符集



```bash

alter table users character set utf8

```


### 修改字段的字符集

```bash

alter table users change name  char(10) character set utf-8;

```








