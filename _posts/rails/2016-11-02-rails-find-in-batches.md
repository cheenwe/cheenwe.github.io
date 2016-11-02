---
layout: post
title: Rails 批量查询处理数据
tags: rails基础
category: rails
---


# Rails 批量查询处理数据 find_in_batches

在某些情况下需要对大量的数据进行处理，可以使用 find_in_batches 方法进行处理



## 调用

```ruby
Api::V1::Heartbeat.find_in_batches(start: 2001, finish: 12000, batch_size: 200) do |group|
  group.each { |h| puts h.id}
end
```
该方法每次处理200条数据，

最后一个 SQL 输出如下

```sql
Api::V1::Heartbeat Load (0.5ms)  SELECT  "api_v1_heartbeats".* FROM "api_v1_heartbeats" WHERE ("api_v1_heartbeats"."id" >= 2001) AND ("api_v1_heartbeats"."id" <= 12000) AND ("api_v1_heartbeats"."id" > 11911) ORDER BY "api_v1_heartbeats"."id" ASC LIMIT $1  [["LIMIT", 200]]
```
