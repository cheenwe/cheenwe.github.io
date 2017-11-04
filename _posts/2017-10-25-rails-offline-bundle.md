---
layout: post
title: Rails 离线 Bundle
tags:   rails bundle
category:  rails bundle
---



>bundle package --all

将会把所有使用到得 gem 包 放入
vendor/cache 目录下

## 本地安装gem
```
bundle install --local

or

gem install vendor/cache/*
```

## 指定安装

gem install vendor/cache/xx.gem

