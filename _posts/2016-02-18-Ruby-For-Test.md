---
layout: post
title: Ruby模拟多线程测试接口服务器压力
tags: ruby 多线程 压力测试
categories: ruby
---

# Ruby模拟多线程测试服务器压力
用于测试接口服务器的稳定性,及最大并发量

## 多线程 demo

```console
# demo.rb ()
def func
      puts "线程 at: #{Time.now}"
   #    sleep(1)
end

start = Time.now
threads = []
100.times do
threads << Thread.new { func }
end

threads.each { |t| t.join }
puts "------------------------use----#{Time.now - start} s"
```


## http 请求实例

```console
# http.rb (gem install rest-client)

require 'rest-client'

def send
    response = RestClient.get 'https://api.douban.com/v2/book/search?q=9787115252197'
   #response = RestClient.get 'http://xxxxx:3000/fatigues',  :location_lng =>"121.4808893486593", :location_lat =>"31.229565891634657", :sim_number =>"100861008610086", :current_at =>"2016-02-17 14:05:27", :speed =>"0.0", :alarm_type =>"none", :attachment => File.new("/home/chenwei/send.jpg", 'rb')
   # puts response.code
   puts "#{Time.now}===================#{response.code} =================== #{response.headers[:x_runtime]}"
   # puts response.headers
end

start = Time.now

threads = []
n= 0
200.times do
   n = n+1
   if n%20 == 0 # 每100次,停 8 S
   # if n.to_s[1..3]== "00"
      threads << Thread.new { send }
      sleep(8)
   else
      threads << Thread.new { send }
      threads << Thread.new { send }
      threads << Thread.new { send }
      threads << Thread.new { send }
      threads << Thread.new { send }
   end
end

threads.each { |t| t.join }
puts "------------------------used----#{Time.now - start} s"

```