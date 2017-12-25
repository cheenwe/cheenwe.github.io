---
layout: post
title: Ruby With Selenium
tags:    ruby test
category:   ruby test
---

Selenium 是什么？一句话，自动化测试工具。它支持各种浏览器，包括 Chrome，Safari，Firefox 等主流界面式浏览器，如果你在这些浏览器里面安装一个 Selenium 的插件，那么便可以方便地实现Web界面的测试。

## 安装ruby版本的selenium

gem install selenium-webdriver

## 安装selenium浏览器驱动driver

- Chrome:

https://sites.google.com/a/chromium.org/chromedriver/downloads

- Firefox:

https://github.com/mozilla/geckodriver/releases


```ruby
require 'selenium-webdriver'

# dr = Selenium::WebDriver.for :chrome

driver = Selenium::WebDriver.for :chrome
# driver = Selenium::WebDriver.for :firefox

# WebDriver driver = new RemoteWebDriver("http://localhost:9515", DesiredCapabilities.chrome());
driver.get("http://www.sse.com.cn/home/search/?webswd=%E8%B4%A2%E5%8A%A1%E6%8A%A5%E8%A1%A8");

html_source = driver.page_source

sse_query_list = driver.find_element(:id, "Next").click

# driver.click 'id="Next"'
p sse_query_list
sleep(1000000)
# dr.get "http://www.sse.com.cn/home/search/?webswd=%E8%B4%A2%E5%8A%A1%E6%8A%A5%E8%A1%A8"
# 使用navigate方法，然后再调用to方法
# dr.navigate.to url

# #隐形设置等待时间
# driver.manage.timeouts.implicit_wait =60
# #最大化浏览器
# driver.manage.window.maximize
# #设置浏览器的宽、长
# #driver.manage.window.resize_to(600,400)
# #具体的url
# @url="http://www.baidu.com/"
# #打开具体的URL
# driver.get @url
# #查找id为kw的元素，并清空值
# driver.find_element(:id,"kw").clear
# #根据CSS查找id为kw的元素并赋值为杨丹霞
# driver.find_element(:css,"#kw").send_key("杨丹霞")
# driver.find_element(:id,"su").click

# print driver.current_url
# #返回（后退）到百度首页
# driver.navigate.back
# sleep(2)
# #前进到搜索杨丹霞的页面
# driver.navigate.forward

```
