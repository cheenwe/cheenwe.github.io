---
layout: post
title: Rails Controller 缓存
tags: rails基础
category: rails
---


# Rails 控制器的缓存

两种实现方式：fresh_when 和 stale?  .

[参考](http://api.rubyonrails.org/classes/ActionController/ConditionalGet.html)

## fresh_when

```ruby
def index
  @notifications = Notification.all
  fresh_when(etag: @notifications, last_modified: @notifications.maximum(:updated_at))
end
```

或者简单点写法

```ruby
def index
  @notifications = Notification.all
  fresh_when(@notifications)
end
```


## stale?

```ruby
def index
  @notifications = Notification.all

  if stale?(@notifications)
    render json: @notifications
  end
end
```

## 效果

没加缓存前，每次响应请求返回 200 ，加完缓存后， 如果数据没有改变，第二次响应请求则返回 304， 对比如下：

- Completed 200 OK in 64ms (Views: 33.0ms | ActiveRecord: 13.3ms)

- Completed 304 Not Modified in 16ms (ActiveRecord: 2.8ms)
