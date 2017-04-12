---
layout: post
title: Activerecord 连 MySQL
tags: rails mysql
category:  rails mysql
---

在写操作数据库脚本的时候使用Rails感觉有点太重了，研究了下只使用 activerecord连MySQL，记录如下：

## 文件目录

```sh
app.rb  Gemfile  Gemfile.lock
```

## 代码

```ruby
# app.rb

#require 'sinatra'
require 'mysql2'
require "active_record"

# MySQL Connection Config
ActiveRecord::Base.establish_connection(
  :encoding=> 'utf8',
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "root",
  :timeout=> 5000,
  :pool=>'5',
  :database => "mm_dev"
)

class User < ActiveRecord::Base
end

class App < Sinatra::Application
end

p User.last(10)

#get '/' do
#  p User.last(10)
#end
```

```ruby
# Gemfile
source "https://gems.ruby-china.org"
#gem 'sinatra'
gem 'activerecord'
gem 'mysql2'
```

## 使用

>bundle

>run app.rb


如果使用 sinatra 默认开启 3456 端口