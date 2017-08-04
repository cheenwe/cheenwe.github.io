---
layout: post
title: 安装 nokogiri gem 报错
tags:   rails gem
category:  rails 
---


# 安装 nokogiri gem 报错
把rails 升级到5.1.2后， nokogiri gem 报错， 日志信息如下：
 
```shell
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

    current directory: /Users/dev/.rvm/gems/ruby-2.4.0/gems/nokogiri-1.8.0/ext/nokogiri
/Users/dev/.rvm/rubies/ruby-2.4.0/bin/ruby -r ./siteconf20170802-79168-i5lgyl.rb extconf.rb --use-system-libraries
checking if the C compiler accepts ... yes
checking if the C compiler accepts -Wno-error=unused-command-line-argument-hard-error-in-future... no
Building nokogiri using system libraries.
ERROR: cannot discover where libxml2 is located on your system. please make sure `pkg-config` is installed.
*** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of necessary
libraries and/or headers.  Check the mkmf.log file for more details.  You may
need configuration options.
```

mac上 libxml2 和 pkg-config 均安装

查看安装信息

>brew info libxml2 

最终解决方法:

```shell

brew link --force libxml2
bundle config build.nokogiri --use-system-libraries
bundle install

```