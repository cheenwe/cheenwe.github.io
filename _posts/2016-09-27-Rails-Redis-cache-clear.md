---
layout: post
title: Rails项目中Redis 清除缓存
tags: redis cache
category: redis
---

# FLUSHALL

Redis FLUSHALL删除所有现有的数据库，而不仅仅是当前选择的一个的键。

## 命令

```ruby
# clear_redis_cache.rb

$redis = Redis.new(6379)
$redis.flushall
```