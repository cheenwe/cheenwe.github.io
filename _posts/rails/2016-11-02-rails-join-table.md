---
layout: post
title: Rails Join Table
tags: rails基础
category: rails
---


# Rails 创建Join表单并使用UUID

## 只创建Join table

```ruby
class CreateJoinTableUserRole < ActiveRecord::Migration
  def change
    create_join_table :roles_users, :roles do |t|
      t.index :user_id
      t.index :role_id
    end
  end
end
```

## 使用UUID创建Join table

```ruby
class CreateJoinTableUserRole < ActiveRecord::Migration
  def change
    create_table :roles_users do |t|
      t.uuid :user_id
      t.uuid :role_id
    end
  end
end
```

## 更简单的操作

```ruby
class CreateJoinTableUserRole < ActiveRecord::Migration
  def change
    create_join_table(:users, :roles, column_options: {type: :uuid})
  end
end
```

## 生成多态
rails g model relay user_id:integer to_user_id:integer modelable:references{polymorphic}
