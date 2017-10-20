---
layout: post
title: Ruby Gem包制作
tags:  ruby gem
category: ruby
---

#  Ruby Gem包制作
    最近由于要调用第三方Rest API来获取数据,于是根据自己需求,写了个简单的Gem包:https://github.com/cheenwe/qingting_api,
    并打包发布到rubygems.org,以下记录制作的过程.

## 1.创建名字为qingting_api 的Gem
```
    bundle gem qingting_api                   [18:01:01]
    Creating gem 'qingting_api'...
    Code of conduct enabled in config
    MIT License enabled in config
          create  qingting_api/Gemfile
          create  qingting_api/.gitignore
          create  qingting_api/lib/qingting_api.rb
          create  qingting_api/lib/qingting_api/version.rb
          create  qingting_api/qingting_api.gemspec
          create  qingting_api/Rakefile
          create  qingting_api/README.md
          create  qingting_api/bin/console
          create  qingting_api/bin/setup
          create  qingting_api/CODE_OF_CONDUCT.md
          create  qingting_api/LICENSE.txt
          create  qingting_api/.travis.yml
    Initializing git repo in /home/chenwei/workspace/github/qingting_api/test/qingting_api

```

## 2.修改Gem的配置信息

    修改qingting_api.gemspec内容

    把TODO:的部分改为自己的信息

    添加自定义 依赖gem, 如: s.add_dependency 'activerecord', ['>= 3.0', '< 5.0']

    去掉或者修改一下信息,不然无法上传到rubygems.org

      if spec.respond_to?(:metadata)
        spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
      else
        raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
      end

## 3.编码

    在lib 目录下进行编码, generators 文件夹是生成 自定义配置文件, 如 config.yml 文件
    使用命令如: rails g qingting_api:config
    对应调用的配置文件 /lib/qingting_api/config.rb
    获取用户access_token 信息在配置文件:/lib/qingting_api/account.rb
    以上２个文件内的编码都需要在　lib/qingting_api.rb　内进行　调用，如：　
      require 'qingting_api/config'
      require 'qingting_api/account'

## 4.生成及发布

## 4.1 生成GEM

    执行:  rake build
    在 pkg目录下生成  qingting_api-0.1.0.gem

## 4.2 发布

    执行:  gem push
    按照提示进行注册
    Enter your RubyGems.org credentials.
    Don't have an account yet? Create one at https://rubygems.org/sign_up
       Email:   gem_author@example
    Password:
    Signed in.
    Pushing gem to RubyGems.org...
    Successfully registered gem: qingting_api (0.1.0)

## 5.版本更新
    代码修改后可以修改版本信息进行发布, /lib/qingting_api/version.rb

    执行:  rake release
    qingting_api 0.1.4 built to pkg/qingting_api-0.1.4.gem.
    Tag v0.1.4 has already been created.
    代码会自动同步到 rubygems
