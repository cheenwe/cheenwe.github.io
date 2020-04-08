---
layout: post
title: Ruby 报错记录
tags:    ruby erors
category:   ruby
---




#  记录使用 ruby 脚本过程中报错信息


## Encoding::UndefinedConversionError: "\xE4" from ASCII-8BIT to UTF-8
 文件读写时需要强制转换成 utf-8

```
require 'net/http'

url = "https://car.autohome.com.cn/photo/series/30319/12/3865045.html"
File.open('1.html', "w:UTF-8") do |f|
  content = Net::HTTP.get_response(URI.parse(url)).body
  f.write(content.force_encoding("UTF-8"))
end
```



## rails不能在model中使用type作为字段名的解决办法


ActiveRecord::SubclassNotFound (The single-table inheritance mechanism failed to locate the subclass: 'G6'. This error is raised because the column 'type' is reserved for storing the class in case of inheritance. Please rename this column if you didn't intend it to be used for storing the inheritance class or overwrite Cy::Photo.inheritance_column to use another column for that information.)


在相关model中加入`self.inheritance_column = nil`即可，如：
