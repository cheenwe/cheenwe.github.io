---
layout: post
title: 常用 Gems
tags: ruby gem
categories: ruby
---


# Gem整理
记录和整理一些常用和会用到的GEM

## 服务器
    puma
    thin

## 用户登录、权限:
    devise - plataformatec/devise
    rolify - RolifyCommunity/rolify
    pundit - elabs/pundit
    cancan
    the_role

## 状态机
    statesman - gocardless/statesman
    workfolw

## 搜索
    ransack
    sunspot(全文搜索)

## 分页
    kaminari - amatsuda/kaminari
    will_paginate

## 图表
    chartkick - ankane/chartkick
    lazy_high_charts

## 图片
    Paperclip 图片上传
    rmagick 图片剪裁
    carrierwave
    carrierwave-upyun
    carrierwave-qiniu
    mini_magick

## 加密
    bcrypt

## 表单
    simple_form - plataformatec/simple_form
    nested_form：嵌套表单

## 部署
    mina - mina-deploy/mina
    Capistrano

## SEO
    meta-tags - kpumuk/meta-tags

## 配置
    settingslogic - binarylogic/settingslogic

## 队列
    sidekiq - mperham/sidekiq
    tobiassvn/sidetiq #重复性作业
    gem "delayed_job_active_record" #ActiveRecord的后端集成DelayedJob  links: https://github.com/collectiveidea/delayed_job_active_record
    gem "delayed_job" #基于数据库的同步优先级队列系统  https://github.com/collectiveidea/delayed_job

## HTTP and REST client
    httparty
    httparty
    vcr
    rest-client

## 监控
    skylight - skylightio/skylight-ruby
    newrelic_rpm
    oneapm_rpm

## 错误处理
    better_errors - charliesome/better_errors

## 代码检查
    rubocop - bbatsov/rubocop

## 日志
    lograge - roidrage/lograge
    gem "rails-flog", require: "flog"  #Rails的日志格式参数和SQL   !!!
    gem "quiet_assets" #静音资产管道日志消息

## 树形结构
    closure_tree - mceachen/closure_tree
    awesome_nested_set
    the_sortable_tree

## 统计分析
    mixpanel-ruby - mixpanel/mixpanel-ruby
    meta_events - swiftype/meta_events

## 关系图
    voormedia/rails-erd https://github.com/voormedia/rails-erd
    gem 'railroady' #打印数据模型关联关系 !!!

## 浏览器检测
    browser - fnando/browser

## 假数据
    fabrication - paulelliott/fabrication

## 富文本编辑器
    KindEditor 界面很简洁，很不错
    CKEditor https://www.ruby-toolbox.com/projects/ckeditor 能很强大，很易用
    TinyMCE https://www.ruby-toolbox.com/projects/tiny_mce

## 测试驱动
    rspec-rails：BDD测试框架            初始化：rails generate rspec:install
    capybara：模拟浏览器器行为
    factory_girl_rails：生成数据
    database_cleaner：清除数据库数据
    simplecov：覆盖率测试
    faker：生成假数据
    launchy：在浏览器中打开测试用例
    guard-rspec：监视文件改变，自动运行测试
    guard-spork：加速guard运行时间
    mocha - freerange/mocha
    poltergeist - teampoltergeist/poltergeist
    timecop - travisjeffery/timecop
    cucumber - cucumber/cucumber

## JS
    Notify.js #桌面提醒 https://alexgibson.github.io/notify.js/
    ng-notify AngularJS Notifications. http://matowens.github.io/ng-notify

## 其他
    cells：view组件
    resque：后台任务
    social-share-button：分享功能
    activemerchant_patch_for_china：支付宝
    wice_grid：强大的表格工具
    client_side_validations：客户端认证
    gon：从controller传递数据到javascript中
    redcarpet：Markdown标记语言
    chinese_pinyin：汉字转换为拼音


    gem "friendly_id"   #使用名称等代替ID !!!
    gem 'by_star' #日期排序
    gem "did_you_mean" #方法错误提示   !!!
    gem "hirb-unicode"
    gem "hirb"  #迷你视图框架控制台/ IRB，  !!!
    gem "annotate" #在model中进行schema注释 !!!
    gem 'paranoia' #假删除 deleted_at:datetime:index  acts_as_paranoid  添加字段，   !!!
    gem 'acts-as-taggable-on' #标签
    gem 'by_star' #日期排序
    gem 'activeadmin', '~##  1.0.0.pre1' # Admin管理
    gem 'bullet' #N+1检测 !!!
    gem "awesome_print" #漂亮的打印您的Ruby对象与风格
    gem 'faker' #生成假数据，如姓名，地址和电话号码。
    gem 'brakeman'  #静态分析安全漏洞扫描器的Ruby on Rails应用程序 !!!!
    gem "letter_opener_web" #一个web界面浏览Ruby on Rails的发送的电子邮件
    gem "quiet_assets"  #静音资产管道日志消息
    gem 'dalli' #高性能的memcached客户对Ruby
    gem "bugsnag" #Ruby应用程序引发的异常即时通知
    gem "paper_trail" #跟踪更改您的模型的数据。适合审核或版本。 类似 audit  link:  https://github.com/airblade/paper_trail  !!!!
    gem "bourbon" #一个轻量级的sass工具集 links: https://github.com/thoughtbot/bourbon   http://bourbon.io/
