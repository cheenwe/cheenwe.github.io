---
layout: post
title: 字符串处理
tags:  ruby char
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

## 生成40位随机字符串

```ruby
SecureRandom.urlsafe_base64(30).tr('_-', 'xx')
```

## shell 生成随机字符串

>cat /dev/urandom | strings -n 5 |head -n 1


其中5表示字符串的字符数，1表示要生成多少行字符。


> cat /dev/urandom | tr -dc A-Za-np-z1-9 | head -c 6
