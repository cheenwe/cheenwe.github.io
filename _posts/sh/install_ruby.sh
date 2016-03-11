#!/bin/bash

source ~/.rvm/scripts/rvm

echo -n "替换淘宝镜像"
sed -i -E 's!https?://cache.ruby-lang.org/pub/ruby!https://ruby.taobao.org/mirrors/ruby!' $rvm_path/config/db

rvm pkg install readline

echo "设置 Ruby 版本"
rvm install 2.2.2

echo "设置默认版本"
rvm 2.2.2 --default

echo "安装 Bundler"
gem install bundler
bundle config mirror.https://rubygems.org https://ruby.taobao.org

echo "安装 Rails 环境"
gem install rails

