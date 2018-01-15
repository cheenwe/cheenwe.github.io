---
layout: post
title: Rails 生成 Token
tags: rails基础
category: rails
---


# Rails 生成 Token 方法


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
