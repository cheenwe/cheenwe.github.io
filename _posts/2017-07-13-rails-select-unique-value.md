---
layout: post
title: Rails select unique value from model
tags:  ubuntu
category:  ubuntu
---


# Rails select unique value from model



统计某个机构下数据的情况, 需要从表单中取出所有的检验机构再分别统计某个机构的数量, 以前的项目中表单设计的过程中有些问题, 在不添加表单的情况下不考虑效率的查询方式如下:


>VehicleCheck.distinct.pluck(:jyjgbh)

or

>VehicleCheck.uniq.pluck(:jyjgbh)


VehicleCheck.select('DISTINCT jyjgbh')


VehicleCheck.pluck("DISTINCT jyjgbh")