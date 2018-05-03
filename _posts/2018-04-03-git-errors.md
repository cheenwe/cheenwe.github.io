---
layout: post
title: GIT 提交异常 fatal: LF would be replaced by CRLF
tags:    git
category:   git
---

GIT 提交异常 fatal: LF would be replaced by CRLF

打开项目.git目录,修改config文件，在[core]配置项添加下面一句话，就好了。

>autocrlf = false
