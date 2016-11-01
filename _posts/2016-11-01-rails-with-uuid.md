---
layout: post
title: Rails项目使用UUID
tags: uuid rails postgres
category: rails
---

# Rails5 项目 Postgresql 数据库使用 UUID

## postgresql开启插件

```ruby
class CreateUuidPsqlExtension < ActiveRecord::Migration[5.0]
  def self.up
    execute "CREATE EXTENSION \"uuid-ossp\";"
  end

  def self.down
    execute "DROP EXTENSION \"uuid-ossp\";"
  end
end
```
需要使用postgres用户连接数据库进行操作,如果没有设置 postgres 密码, [参考](https://github.com/cheenwe/cheenwe.github.io/tree/master/_posts/postgresql/2016-11-01-PostgreSQL-Change-Postgres-Password.md)

## Rails 添加 uuid 并设置为主键

Rails5 已经集成 UUID, 直接配置使用即可 .

**新表添加字段**

```ruby
class AddUuidToUsers < ActiveRecord::Migration[5.0]
  create_table :apps, id: :uuid do |t|
    t.string :name
  end
end
```

**新添加字段**

```ruby
class AddUuidToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :uuid, :uuid
  end

  def down
    remove_column :users, :uuid
  end
end
```

或者让数据库自动生成uuid

>add_column :users, :uuid, :uuid, :default => "uuid_generate_v4()"

**
注意：　如果其他表单需要和uuid字段进行主键关联，如： app_id 字段类型不能为integer，需要改为string
**

[参考代码](https://github.com/cheenwe/ran/issues/4)


## 使用ruby 的方法进行字符串的转换

>6175601989.to_s(30)

 => "8e45ttj"
　

>"8e45ttj".to_i(30)

=>6175601989
