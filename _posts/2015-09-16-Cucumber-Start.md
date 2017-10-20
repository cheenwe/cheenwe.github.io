---
layout: post
title: Cucumber 入门指南
tags: cucumber
categories: test
---

# 什么是Cucumber
Cucumber是一个能够理解用普通语言 描述的测试用例的支持行为驱动开发（BDD）的自动化测试工具，用Ruby编写，支持Java和·Net等多种开发语言。

两个特性:

* 可以使用自然语言描述测试用例

* 可以作为自动化测试运行

 BDD（Behavior Driven Development, 行为驱动开发）是一种敏捷软件开发的技术，它鼓励软件项目中的开发者、QA和非技术人员或商业参与者之间的协作。 它包括验收测试和客户测试驱动等的极限编程的实践，作为对测试驱动开发的回应。在过去数年里，它得到了很大的发展。它定义了一个可持续的周期，在周期中人们先设定目标，再为了达到预期目标而进行编码，只有代码通过验证才可提交。持续交付可工作、经过测试的软件。

## Rails中安装Cucumber
在Gemfile中添加

```
    group :test, :development do
      gem 'cucumber-rails', :require => false
      # database_cleaner is not required, but highly recommended
      gem 'database_cleaner'
    end
```

```
bundle install
```

生成cucumber文件:

```
rails generate cucumber:install
```

运行:

```
rake cucumber
```

## Cucumber示例
###1.写自然语言描述

```
#/features/calculator.feature
Feature: 计算器

  Scenario: 两数相加
    Given 我有一个计算器
    And 我向计算器输入50
    And 我向计算器输入70
    When 我点击累加
    Then 我应该看到结果120
```

###2.运行
cucumber features/calculator.feature

```
Feature: 计算器

  Scenario: 两数相加    # features/calculator.feature:3
    Given 我有一个计算器   # features/calculator.feature:4
    And 我向计算器输入50   # features/calculator.feature:5
    And 我向计算器输入70   # features/calculator.feature:6
    When 我点击累加      # features/calculator.feature:7
    Then 我应该看到结果120 # features/calculator.feature:8

1 scenario (1 undefined)
5 steps (5 undefined)
0m0.034s

You can implement step definitions for undefined steps with these snippets:

Given(/^我有一个计算器$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^我向计算器输入(\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^我点击累加$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^我应该看到结果(\d+)$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

```

[![](/files/images/2015/09/16/2.png)]({{ site.baseurl }}/files/images/2015/09/16/2.png)
Cucumber首先输出的是测试用例的描述，然后3行总结性地输出：本功能（Feature）有1个情景（1 scenario）；5个步骤（5 steps），全部5个步骤均未定义（undefined）；运行耗时0.005秒。这里出现了两个新名词：步骤(steps)和步骤定义（step definitions）。在Cucumber中，以关键字Given, And, When, Then开头的每一行，为一个步骤。在两数相加的情景中，一共有5行。
###2.按照步骤定义填充代码
/features/step_definitions/define_calculator.rb
```
Given /^我有一个计算器$/ do
  @c = Calculator.new
end

Given /^我向计算器输入(\d+)$/ do |num|
  @c.push(num.to_i)
end

When /^我点击累加$/ do
  @c.sum
end

Then /^我应该看到结果(\d+)$/ do |result|
  @c.result.should == result.to_i
end
```
###3.编写类方法
/features/step_definitions/calculator.rb
```
class Calculator
    def push n
        @arr ||=[]
        @arr << n
    end
    def sum()
        result = 0
        @arr.map{|a| result += a}
        @result = result
    end
    def result
        @result
    end

end
```

###4.运行
cucumber features/calculator.feature

```
Feature: 计算器

  Scenario: 两数相加    # features/calculator.feature:3
    Given 我有一个计算器   # features/step_definitions/define_calculator.rb:1
    And 我向计算器输入50   # features/step_definitions/define_calculator.rb:5
    And 我向计算器输入70   # features/step_definitions/define_calculator.rb:5
    When 我点击累加      # features/step_definitions/define_calculator.rb:9
    Then 我应该看到结果120 # features/step_definitions/define_calculator.rb:13

1 scenario (1 passed)
5 steps (5 passed)
0m0.031s
```

![如何插入并上传图片]( {{"/files/2015/09/16/4.png" | prepend: site.imgrepo }})
Cucumber输出运行结果：1个情景，5个步骤，全部通过。



## 语言支持
查看支持语言
  cucumber --i18n help
中英文对照
  cucumber --i18n zh-CN
```
      | feature          | "功能"                   |
      | background       | "背景"                   |
      | scenario         | "场景", "剧本"             |
      | scenario_outline | "场景大纲", "剧本大纲"         |
      | examples         | "例子"                   |
      | given            | "* ", "假如", "假设", "假定" |
      | when             | "* ", "当"              |
      | then             | "* ", "那么"             |
      | and              | "* ", "而且", "并且", "同时" |
      | but              | "* ", "但是"             |
      | given (code)     | "假如", "假设", "假定"       |
      | when (code)      | "当"                    |
      | then (code)      | "那么"                   |
      | and (code)       | "而且", "并且", "同时"       |
      | but (code)       | "但是"                   |
```