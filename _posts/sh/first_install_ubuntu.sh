#!/bin/bash

sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#update the system
apt-get update

echo "安装 依赖 软件"
apt-get install git-core curl wget zlib1g zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev openssl  libcurl4-openssl-dev python-software-properties libffi-dev libmysqlclient-dev zsh  libreadline6 libreadline6-dev  libxslt-dev autoconf automake libtool imagemagick libmagickwand-dev   libpcre3-dev language-pack-zh-hans libevent-dev

echo "安装 oh my zsh "
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "导入rvm key"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

echo "安装rvm"
curl -L https://get.rvm.io | bash -s stable

source ~/.rvm/scripts/rvm

echo "source ~/.rvm/scripts/rvm" >> ~/.zshrc
echo "plugins=(git bundler osx rake ruby rails z)" >> ~/.zshrc

echo -n "替换淘宝镜像"
sed -i 's!cache.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' $rvm_path/config/db

echo "用 RVM 安装 Ruby 环境"
rvm install 2.2.0

echo "设置 Ruby 版本"
rvm install 2.2.0

echo "用 RVM 安装 Ruby 环境"
rvm 2.2.0 --default

echo "安装 Bundler"
gem install bundler

echo "安装 Bundler"
bundle config mirror.https://rubygems.org https://ruby.taobao.org

echo "用 RVM 安装 Ruby 环境"
rvm install 2.2.0

echo "安装 Rails 环境"
gem install rails


