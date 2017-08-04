---
layout: post
title: 常用方法记录
tags: rails
category:  rails
---

记录一些看到或项目用到的方法.

## 判断性别

```ruby
  # sex enumeration
  MALE   = 1
  FEMALE = 2
  def sex_to_s(format = :default)
    case sex
    when MALE
      "M"
    when FEMALE
      "F"
    end
  end
```
