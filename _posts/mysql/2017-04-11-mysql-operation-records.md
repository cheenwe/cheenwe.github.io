---
layout: post
title: MySQL 操作记录
tags: MySQL 数据库
categories: MySQL
---


记录一次 MySQL 操作及优化过程。

## 背景

在学习 [Python 爬虫](https://github.com/cheenwe/mm.git)时,把爬取的数据存入到数据库中，简单的数据写入功能实现了。最后脚本在执行过程中一直对最后的几页数据一直反复爬取并写入数据库，由于数据库开始设计的问题，没有考虑主键等约束导致产生大量的冗余数据，

创建表单语句如下：

```sh
CREATE TABLE IF NOT EXISTS  users(id bigint, name varchar(255), remark text )
CREATE TABLE IF NOT EXISTS albums(id bigint, user_id bigint, name varchar(255), created_at date, remark text, kind int, total float)
CREATE TABLE IF NOT EXISTS photos(id bigint, album_id bigint, name varchar(255), url varchar(255), kind int)
```

以上表单设计有以下问题：

1. 产生大量数据重复

2. 无主键，易造成数据重复及查询速度慢

3. 缺外键，关联查询慢

## 数据总量

爬虫总共爬取了大约600万条数据，其中约几十万条重复数据，需要对重复数据进行清理工作。

```sql

mysql> select count(*) from photos;
+----------+
| count(*) |
+----------+
|  6405566 |
+----------+
1 row in set (5.33 sec)
```

## 统计出每张表里重复数据的数量
先选择其中数量较少的表单进行查询

```sql
mysql> select id,count(*) from albums group by id having count(*) >1;

+-------------+----------+
| id          | count(*) |
+-------------+----------+
|     9388666 |     3220 |
|     9388667 |     3220 |
|    11747336 |        2 |
|    26628976 |        2 |
|    26952809 |     3220 |
|    56075542 |        2 |
...
|   300745219 |        2 |
|   301350175 |        2 |
| 10000652059 |        2 |
+-------------+----------+
42 rows in set (0.78 sec)
```

## 去重操作
操作思路： 使用 DISTINCT 关键字对数据进行去重操作，存储到临时表中，然后把原表数据清除，再把临时表的数据复制到原表中。

语句如下：

>create table user_temp as (select distinct * from users);

>truncate table users;

>insert into users select * from user_temp;

>delete table user_temp;



```sql
mysql> desc albums;
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| id         | bigint(20)   | YES  |     | NULL    |       |
| user_id    | bigint(20)   | YES  |     | NULL    |       |
| name       | varchar(255) | YES  |     | NULL    |       |
| created_at | date         | YES  |     | NULL    |       |
| remark     | text         | YES  |     | NULL    |       |
| kind       | int(11)      | YES  |     | NULL    |       |
| total      | float        | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
7 rows in set (0.00 sec)
```

## 表结构优化

### 添加主键

>ALTER TABLE  albums  ADD PRIMARY KEY( id );

出现以下报错：

>ERROR 1062 (23000): Duplicate entry '300435191' for key 'PRIMARY'

原因是该表中有重复数据


```sql
mysql> select * from albums where id = "300435191";
+-----------+----------+-----------+------------+--------+------+-------+
| id        | user_id  | name      | created_at | remark | kind | total |
+-----------+----------+-----------+------------+--------+------+-------+
| 300435191 | 74386764 | honru2012 | 2012-05-04 |        |    1 |   120 |
| 300435191 | 74386764 | honru2012 | 2012-05-04 |        |    1 |   120 |
+-----------+----------+-----------+------------+--------+------+-------+
2 rows in set (0.18 sec)
```

### 添加外键
>Alter Table `albums` Add  Foreign Key (`user_id`) References `users` (`id`);

### 主键自增
>ALTER TABLE `albums` CHANGE `id` `id` bigint NOT NULL AUTO_INCREMENT;


### 删除字段
>Alter Table `albums` DROP   column id;

### 添加字段
>Alter Table `albums` add   column id bigint;


## MySQL 的 RowNum 实现

SELECT @rownum:=@rownum+1 rownum, id From
(SELECT @rownum:=0 FROM users WHERE id!='' limit 10) t;


SELECT @rownum:=@rownum+1 rownum, id From (SELECT @rownum:=0,photos.* FROM photos WHERE id!='' limit 10) t;




