---
layout: post
title: Ruby 中执行周期性任务
tags: mail
category: server
---

# whenever 和 sidetiq
Ruby中执行周期性任务的方法。

* [whenever](https://github.com/javan/whenever): 是基于 linux 的 cron 服务的,将 ruby 代码翻译为 cron 脚本，从而将周期性任务转交给 cron 实际去完成 .

* [sidetiq](https://github.com/endofunky/sidetiq): 不依赖于 cron , 主要在rails项目中和sidekiq搭配来处理后台任务 .


## whenever

### 安装

```sh
gem install whenever
```

Or with Bundler in your Gemfile.

```ruby
gem 'whenever', :require => false
```

### 生成配置文件

```sh
cd /apps/my-project
wheneverize .
```

将在项目的 config 目录下生成 schedule.rb 文件，
如果不是 rails 项目，需要自己创建个 config 文件夹。


###  命令

- 查看定时任务

```sh
whenever
```
或者查看cron任务表

```sh
crontab -l
```

- 更新

```sh
whenever --update-crontab
```

- 写入 cron 任务表, 开始执行
```sh
whenever -w
```

- 取消任务

```sh
whenever -c
```
### 示例文件
whenever默认定义了三种任务类型：runner, rake, command

```ruby
every 3.hours do # 1.minute 1.day 1.week 1.month 1.year is also supported
  runner "MyModel.some_process"
  rake "my:rake:task"
  command "/usr/bin/my_great_command"
end

every 1.day, :at => '4:30 am' do
  runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
end

every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  runner "SomeModel.ladeeda"
end

every :sunday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
  runner "Task.do_something_great"
end

every '0 0 27-31 * *' do
  command "echo 'you can use raw cron syntax too'"
end

every :day, :at => '12:20am', :roles => [:app] do
  rake "app_server:task"
end
```


## sidetiq


### 用法

```ruby
class MyWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  def perform
    Calculate::Weixin.calculate_last_day
  end
end
```