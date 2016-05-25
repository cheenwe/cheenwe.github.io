#!/bin/bash

sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#update the system
apt-get update

echo "安装 依赖 软件"
apt-get install git-core curl wget zlib1g zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev openssl  libcurl4-openssl-dev python-software-properties libffi-dev libmysqlclient-dev zsh  libreadline6 libreadline6-dev  libxslt-dev autoconf automake libtool imagemagick libmagickwand-dev   libpcre3-dev language-pack-zh-hans libevent-dev mysql-server-5.5 htop byobu ssh

echo "安装 oh my zsh "
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "plugins=(git bundler osx rake ruby rails z)" >> ~/.zshrc


echo "－－－－－－－－安装rbenv－－－－－－－－－－－－－－－－－－"
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
# 用来编译安装 ruby
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# 用来管理 gemset, 可选, 因为有 bundler 也没什么必要
git clone git://github.com/jamis/rbenv-gemset.git  ~/.rbenv/plugins/rbenv-gemset
# 通过 gem 命令安装完 gem 后无需手动输入 rbenv rehash 命令, 推荐
git clone git://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
# 通过 rbenv update 命令来更新 rbenv 以及所有插件, 推荐
git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
echo "－－－－－－－－－安装rbenv完成－－－－－－－－－－－－－－－－－"

echo "导入环境变量"
echo "export PATH="$HOME/.rbenv/bin:$PATH"" >> ~/.zshrc
echo "eval "$(rbenv init -)"" >> ~/.zshrc

source ~/.zshrc

echo "列出所有 ruby 版本"

rbenv install --list

echo " 安装 Ruby 2.2.0"
rbenv install 2.2.0

echo " 默认使用 2.2.0"
rbenv global 2.2.0

# rbenv shell 2.2.0       # 当前的 shell 使用 2.2.0, 会设置一个 `RBENV_VERSION` 环境变量
# rbenv local jruby-1.7.3      # 当前目录使用 jruby-1.7.3, 会生成一个 `.rbenv-version` 文件

echo "更改为淘宝源"
gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/

# rbenv versions               # 列出安装的版本
# rbenv version                # 列出正在使用的版本

# rbenv shell 2.2.0       # 当前的 shell 使用 2.2.0, 会设置一个 `RBENV_VERSION` 环境变量
# rbenv local jruby-1.7.3      # 当前目录使用 jruby-1.7.3, 会生成一个 `.rbenv-version` 文件

echo "安装 Bundler"
gem install bundler

echo "安装 Bundler"
bundle config mirror.https://rubygems.org https://ruby.taobao.org

echo "安装 Rails 环境"
gem install rails


