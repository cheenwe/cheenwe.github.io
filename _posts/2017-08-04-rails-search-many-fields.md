---
layout: post
title: 解决 Where 多条件查询
tags:   rails
category:  rails
---


    以前的项目中, 客户反馈有个查询不出来结果(对3个字段进行查询), 上次改过的代码有bug,具体见代码注
    释部分.其实修复的方很很简单: 就是判断每个字段的有无, 再进行查询. 查询3个字段, 一共 8个判断方法.
    这让我联想起以前参加一个笔试题,也是类似的查询, 我开始的时候就一直思考如何解决, 想了半小时,最后
    还是写了10几个 if else 的判断.
    以前感觉不想重复写无用的方法,刚刚使用 eval 完美解决.

```ruby
      #if params[:manager].present?
      #  users = User.where(manager: params[:manager])
      #elsif params[:province].present?
      #  users = User.where(province: params[:province])
      #elsif  params[:manager].present? && params[:province].present?
      #  users = User.where(province: params[:province]).where(manager: params[:manager])
      #elsif params[:city].present?
      #  users = User.where(city: params[:city])
      #elsif  params[:manager].present? && params[:city].present?
      #  users = User.where(city: params[:city]).where(manager: params[:manager])
      #else

      if params[:manager].present? || params[:province].present? || params[:city].present?
        condtion =''
        if params[:manager].present?
          condtion += ".where(manager: #{params[:manager]})"
        end
        if params[:province].present?
          condtion += ".where(province: #{params[:province]})"
        end
        if params[:city].present?
          condtion += ".where(city: #{params[:city]})"
        end
        users =  eval("User#{condtion}")
      else
```
