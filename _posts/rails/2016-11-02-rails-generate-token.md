---
layout: post
title: Rails 生成 Token
tags: rails基础
category: rails
---


# Rails 创建Join表单并使用UUID

在某些情况下需要对大量的数据进行处理，可以使用 find_in_batches 方法进行处理


## Devise

```ruby
Devise.friendly_token(24).upcase
```
## SecureRandom

```ruby
SecureRandom.hex(24)
```

## generate_unique_secure_token

```ruby
self.class.generate_unique_secure_token
```

## has_secure_token

```ruby

class App < ActiveRecord::Base
  has_secure_token :name
end

app = App.new
app.save
app.name # => "BunurUTaTEZbnr1S64Csec9h"
app.regenerate_name # => true

```
