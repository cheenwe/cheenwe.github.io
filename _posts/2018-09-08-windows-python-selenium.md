---
layout: post
title: window 下 python+selenium 环境搭建
tags:    python selenium
category:   python
---

## 1.下载python 

https://www.python.org/downloads/windows/　

选Download Windows x86-64 executable installer进行下载(电脑32位选32位的),安装时勾选添加到path,然后默认安装完即可.(或者安装完后手动添加环境变量path中).

安装好后打开cmd执行

```shell
python
```
看是否安装成功.

## 2.下载谷歌浏览器并安装

https://www.google.cn/chrome/

默认安装好,然后在谷歌浏览器帮助查看谷歌版本号.

## 3.下载谷歌驱动chromedriever并解压

https://chromedriver.storage.googleapis.com/index.html

把解压好的chromedriever放入谷歌浏览器安装路径的Application目录下,并且把此目录添加到环境变量path中.

下载谷歌驱动对应的谷歌版本对照表:
(v2.39 => v66-68)
(v2.38 => v65-67)
(v2.37 => v64-66)
(v2.36 => v63-65)
(v2.35 => v62-64)
(v2.34 => v61-63)
(v2.33 => v60-62)

## 4.安装selenium

打开cmd执行命令:

```shell
pip install selenium
```
## 5.测试环境是否配置成功

打开python IDLE,输入命令:

```shell
from selenium import webdriver
browser = webdriver.Chrome()
browser.get("http://www.taobao.com")
```

