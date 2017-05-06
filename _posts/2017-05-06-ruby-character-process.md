---
layout: post
title: 字符串处理
tags:  ruby
category:  ruby
---


# 字符串处理

按照字符组合依次生成对应的字符

```ruby

chars = ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a

chars.each do |a|
  chars.each do |b|
    puts a + b
  end
end

```

生成40位随机字符串

>SecureRandom.urlsafe_base64(30).tr('_-', 'xx')

