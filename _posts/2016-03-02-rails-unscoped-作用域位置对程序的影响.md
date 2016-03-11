---
layout: post
title:  rails unscoped作用域位置的影响
tags:
  - unscoped
  - rails
---

# rails作用域位置的影响
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