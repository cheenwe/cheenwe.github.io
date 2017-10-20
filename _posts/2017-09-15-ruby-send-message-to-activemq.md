---
layout: post
title: Rails Send Message To ActiveMQ
tags:   gem ActiveMQ
category:  ruby 
---

项目中有 c++ 程序需要写数据库等操作, 为了保证数据的一致性, c++ 程序更新完数据库后需要通知后台 rails web 程序更新数据显示, 使用消息总线 ActiveMQ 作为中间件.

# 使用 Rails 同 ActiveMQ 通讯

## 发送消息

>gem install stomp

or

>gem 'stomp' # rails 项目中使用

```
require 'stomp'

def send_mq(host, queue_name, message)
    @stomp_client = Stomp::Client.new("", "", host, 61613)
    @stomp_client.publish("/queue/#{queue_name}",message)
end

# 组装 JSON
data = {
    "message_type":"update",
    "id": 1,
    "action": "update"
}.to_json

# 发送消息 传入总线所在 ip , 队列名, 消息内容
send_mq('192.168.1.1', 'request', data)

```



## 接收消息

### 添加 Gem

>gem 'activemessaging', github: 'ieme/activemessaging' # for rails 5
>gem 'daemons'

### 生成配置文件

```
rails g active_messaging:install
rails g active_messaging:processor
```

### 添加监听队列

在 项目目录 app 下创建 自己 的processors 

>my_message_processor.rb

```
class MyMessageProcessor < ActiveMessaging::Processor
  #监听 dete_push
  subscribes_to :dete_push 

  def on_message(message)
    logger.debug "MyMessageProcessor received: " + message
    puts "----------->>>>>>>>>>>: #{message}"
    # Reteryjob.create_record(message)
  end
end
```

### 开启服务

>script/poller  run



