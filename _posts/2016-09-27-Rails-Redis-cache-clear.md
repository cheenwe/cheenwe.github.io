---
layout: post
title: Rails项目中Redis 清除缓存
tags: redis cache clear
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


## 添加缓存

```

if Rails.cache.read("check_sums-#{start_at}-#{end_at}").nil?
	@vehicle_checks = VehicleCheck.includes(:check_infos).where(["created_at > ? AND created_at < ?", start_at, end_at])
	@check_sums = {
		:passed_total => @vehicle_checks.passed.size,
		:total => @vehicle_checks.size
	}
	Rails.cache.write("check_sums-#{start_at}-#{end_at}", @check_sums, expires_in: Rails.application.credentials.cache_seconds.seconds)
else
	@check_sums = Rails.cache.read("check_sums-#{start_at}-#{end_at}")
end
```