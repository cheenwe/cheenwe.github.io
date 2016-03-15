---
layout: post
title:  rails unscoped 作用域位置的影响
tags:
  - unscoped
  - rails
category: rails
---

#  rails作用域scope
[源码](https://github.com/rails/rails/tree/1aef6ee6f14613e0df9cd54771cc82abb4252f9a/activerecord/lib/active_record/scoping)

## scope传参数用法

```console
scope :recent, lambda{ |date| where(["created_at > ? ", date ]) }
scope :recent, Proc.new{ |date| where(["created_at > ? ", date ]) unless date.nil? }

或者 定义方法传入默认值

def self.recent(date=Time.now)
    where(["created_at > ? ", date ])
end
```

## rails作用域位置的影响
通常为了不在控制器中写很多次 Model.order("id DESC"),直接在模型层添加一个: default_scope {order('id ASC')}

特殊情况下又不想用到 default_scope , 只能用 unscoped 来解决

User.unscoped.all
在使用 unscoped 时候,注意unscoped的位置,如果放在最后可能对前面所用的查询条件进行覆盖

如:

```console
scope :today, ->(day) { playlist.where(play_date:day) }

playlists = Fm::Playlist.today("2016-02-29").unscoped
    playlists.each do |playlist|
      lists = playlists.where("id < ?",playlist.id)
      sequence = lists.present? ?  "#{lists.size+1}" :"1"
      playlist.update(sequence:sequence)
    end
end
```

>这里更新的是全部的记录.

```console
playlists = Fm::Playlist.unscoped.today("2016-02-29")
    playlists.each do |playlist|
      lists = playlists.where("id < ?",playlist.id)
      sequence = lists.present? ?  "#{lists.size+1}" :"1"
      playlist.update(sequence:sequence)
    end
end

```
>这里更新的是29号的记录


纠结了半天的时间,