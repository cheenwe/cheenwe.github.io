---
layout: post
title: Rails delete_all 和 destroy_all 区别
tags: rails delete_all destroy_all
category: rails
---


最近在删除大量数据时使用了 delete_all 方法, 感觉执行的过程有点慢, 看了下日志发现
和预想的结果不太一样, 只执行了个 update 操作, 把我要关联的字段设置成 null, 实际的
数据并未删除, 整理下 delete_all 和 destroy_all 区别.


## delete_all
>Search.last.photos.delete_all

```
irb(main):008:0> Search.last.photos.delete_all
  Search Load (0.7ms)  SELECT  "searches".* FROM "searches" ORDER BY "searches"."id" DESC LIMIT $1  [["LIMIT", 1]]
  SQL (1.6ms)  UPDATE "photos" SET "search_id" = NULL WHERE "photos"."search_id" = $1  [["search_id", 2]]
```
执行很快, 仅用了1.6ms



## destroy_all

>Search.last.photos.destroy_all

```
irb(main):015:0> Search.last.photos.destroy_all
  Search Load (0.6ms)  SELECT  "searches".* FROM "searches" ORDER BY "searches"."id" DESC LIMIT $1  [["LIMIT", 1]]
  Photo Load (7.5ms)  SELECT "photos".* FROM "photos" WHERE "photos"."search_id" = $1  [["search_id", 2]]
   (0.2ms)  BEGIN
  SQL (0.5ms)  DELETE FROM "photos" WHERE "photos"."id" = $1  [["id", 3371]]
  ...
```

执行时删除一条记录0.5ms, 如果是10W 数据, 删除操作更慢了, 有没有一种更高效的方法, 直接执行 DELETE 操作, 查找了部分文档, 原来是这个方法.


>Search.last.photos.delete_all(:delete_all)

```
irb(main):016:0> Search.last.photos.delete_all(:delete_all)
  Search Load (0.6ms)  SELECT  "searches".* FROM "searches" ORDER BY "searches"."id" DESC LIMIT $1  [["LIMIT", 1]]
  SQL (7.2ms)  DELETE FROM "photos" WHERE "photos"."search_id" = $1  [["search_id", 2]]
=> nil
```

## summary
简单总结一下，delete和destroy的区别在于

1. delete直接在数据库执行一条sql语句;
2. delete效率高于destroy（因为1）;
3. delete绕开业务逻辑的callback(使用时，需注意参照完整性约束);
4. destroy需要将对象实例化;
5. destroy需要将对象一条一条删除（因为4）;
6. destroy耗费时间，因为每一条都需要执行：实例化，callback，删除;
7. destroy会把关联的对象的外键设为nil;
