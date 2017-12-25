---
layout: post
title: Ruby 报错记录
tags:    ruby rails erors
category:   ruby rails
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

