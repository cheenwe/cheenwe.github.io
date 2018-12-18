---
layout: post
title: Migration 执行 SQL 语句
tags: rails migration
category: rails
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



## Rails change column to mediumtext

The reason why the limit values you're inputting are being ignored is due to how MySQL works. It has four text types, each with their own size limit:

- TINYTEXT - 256 bytes
- TEXT - 65,535 bytes
- MEDIUMTEXT - 16,777,215 bytes
- LONGTEXT - 4,294,967,295 bytes

A text column needs to be one of those four types. You can't specify a custom length for these types in MySQL.

So if you set a limit on a :text type column, Rails will automatically pick the smallest of those types that can accommodate that value, silently rounding up the limiting value you inputted to one of those four limits above.

### Example:

>t.text :example_text_field, limit: 20
will produce a TINYTEXT field with a limit of 256 bytes, whereas

>t.text :example_text_field, limit: 16.megabytes - 1
will produce a MEDIUMTEXT field with a limit of 16,777,215 bytes.

### Update
For the shake of the question: "I need to change a column"

> change_column :example_table, :example_text_field, :text, limit: 16.megabytes - 1
