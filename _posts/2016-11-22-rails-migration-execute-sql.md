---
layout: post
title: Migration 执行 SQL 语句
tags: rails
category: rails基础 migration
---

# Migration 执行 SQL 语句

## postgresql开启插件

```ruby
class CreateRecentAnnouncementView < ActiveRecord::Migration
  def self.up
    connection.execute("create view recent_announcements as select * from announcements order by id desc limit 10;")
  end

  def self.down
    connection.execute("drop view recent_announcements;")
  end
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
