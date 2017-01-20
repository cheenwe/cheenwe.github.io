---
layout: post
title: Rails Where Condiction
tags: rails基础
category: rails
---

# Rails Where 条件语句查询

在某些情况下需要对大量的数据进行处理，可以使用 find_in_batches 方法进行处理

## 模糊查询

- 单条件

>User.where("name LIKE ?", "%#{search}%")

- 数组查询

>Api::V1::Heartbeat.where("alarm_type in (?)", types)

- 多个条件

>User.where("name LIKE ：search OR username LIKE :search",  search: "%#{search}%")

>User.where("name LIKE = ? OR username = ?",  "%#{search}%",  "%#{search}%")

- 区间查询

>User.where("created_at >= :start_date AND created_at <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]})

>User.where(created_at: (params[:start_date]..params[:end_date]))


## joins
joins  和 left_outer_joins 区别
* join 是自然连接
两个表都有数据才会有数据
* left_outer_joins 左联
在左边的那个表有数据就会出来数据

>Api::V1::Machine.joins(:vehicle).where("api_v1_vehicles.fleet_id = ?", params[:fleet_id])
