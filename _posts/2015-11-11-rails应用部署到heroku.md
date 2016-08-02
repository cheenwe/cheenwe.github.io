---
layout: post
title:  rails 应用部署到 heroku
tags: heroku  rails
category: rails
---

# rails应用部署到heroku

## 安装
    wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh.
或者gem安装
    gem install heroku

## 添加公钥到Heroku
    heroku keys:add
如果没有公钥,请先添加,命令:
    ssh-keygen -t rsa

### 查看公钥，用命令：
    heroku keys
	=== XXXX@gmail.com Keys
	ssh-rsa AAAAB3NzaC...XE7RtugDUh xxx@local

### 如果想删除公钥，可以用命令：
    heroku keys:remove xxx@local

## 部署应用程序
会创建git仓库,及应用地址

    heroku create

## 提交代码
    git push heroku master

## 数据库迁移
    heroku rake db:migrate

##打开网页浏览
    heroku open
## 其他命令

### 更新代码
     git push herku


### 将本地数据更新到Heroku
    heroku db:push
这个命令会使用taps，如果没有安装，请先安装

### 查看日志信息
    heroku logs --tail

### 在本地运行console
    heroku run rails console

### 在本地运行bash
    heroku run bash

## 更多
    请参考官方网站: https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction

