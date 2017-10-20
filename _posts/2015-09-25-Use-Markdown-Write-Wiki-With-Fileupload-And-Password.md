---
layout: post
title: 使用Markdown写WIKI支持文件上传及简单密码验证
tags: Markdown wiki  gollum
category: wiki
---


# 使用Markdown写WIKI支持文件上传及简单密码验证

## 界面效果图

![如何插入并上传图片](http://7xl5z9.com1.z0.glb.clouddn.com/1.png)


##使用步骤

### 安装
把内容克隆到本地  /var/www目录下

```console
git clone git@github.com:cheenwe/wiki.git /var/www/wiki
```

### 安装Gem 文件
```console
cd /var/www/wiki
$ bundle install --path vendor
```

### 直接使用WEBrick开启服务

```console
$ bundle exec rackup
```

### 使用Unicorn

#### 开启服务 端口为8080

```console
$ bundle exec unicorn -c config/unicorn.rb -D
```

```console
$ bundle exec unicorn  -E production -c config/unicorn.rb -D
```

#### 重启：

```console
$ ps auwx | grep unicorn

获取：master 的pid如
  $ kill -9 pid
```


## Nginx 配置
/etc/nginx/conf.d/wiki.conf
```console
upstream my_wiki {
    server unix:/tmp/unicorn_wiki.sock;
}

server {
    listen      80;
    server_name xxxxxxx;
    #access_log  /var/log/nginx/wiki_access.log ltsv;
    #error_log   /var/log/nginx/wiki_error.log;

    location / {
        proxy_pass http://my_wiki;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

```

## GitHub 进行实时同步

```rb
require 'git'
PATH = File.join(File.dirname(__FILE__), "..")
repo = Git.open(PATH)
repo.push(repo.remote('origin'))
```


## 欢迎贡献
[Wiki](https://github.com/cheenwe/wiki)