---
layout: post
title: Rails 离线 Bundle
tags:   rails bundle
category:  rails bundle
---


# 开启 Gem Server
离线安装GEM是件很麻烦的事情，可以先把项目中用到的全部的包先离线缓存，然后传到服务器上开启Gem server 再进行安装即可．

## 项目中缓存GEM

>bundle --local

*　会把项目中用到的包全部下载到　vendor/cache/　目录下

## 安装本地gem

>gem install xxx.gem


## 开启本地Gem Server

```
gem generate_index -d vendor/cache/
cd vendor/cache/
gem server
#Server started at http://0.0.0.0:8808
#Server started at http://[::]:8808
```

把项目中 Gemfile 中地址修改为　"http://0.0.0.0:8808", 即可

