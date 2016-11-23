---
layout: post
title: 在 Rails 项目开发过程中使用视图
tags: rails
category: rails基础 view
---

# 在 Rails 项目开发过程中使用视图
在项目开发过程中对数据库的操作都是基础表单的增删改查，对于复杂的 SQL 操作， 使用到 includes jions 等方法。

对一些使用多张表进行关联查询，跨表操作的方式， 使用rails方法进行编写，个人感觉有些太重了，有些时候只需要一些简单的统计结果， 如：统计今天每个车队下有报警车辆的报警总次数， 使用rails的写法是先找到所有车队，再统计每个车队报警总次数。

```ruby
fleets.each do |fleet|
  fleet.alarms.count
end

```

## Rails model

```ruby
#recent_announcement.rb
class RecentAnnouncement < ApplicationRecord

end

```


```ruby
class CreateRecentAnnouncementView < ActiveRecord::Migration
  def self.up
    execute <<-SQL
        CREATE VIEW recent_announcements
          AS SELECT * FROM announcements ORDER BY id DESC LIMIT 10
      SQL
  end

  def self.down

    execute <<-SQL
        DROP VIEW recent_announcements
      SQL
  end
end
```
