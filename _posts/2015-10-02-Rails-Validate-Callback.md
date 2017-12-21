---
layout: post
title:   rails常用的回调方法
tags: callback rails
category: rails
---

# 回调及验证

## 常用的回调方法

### 必填

* validates_presence_of :name, :code

### 字段长度

* validates_length_of :name, :minimum => 2 #maximum

* validates_length_of :name, :in => 6..20

* validates_length_of :phone, :is => 11

### 验证数字

* validates_numericality_of :age, :only_integer => true

* validates :age, numericality: { only_integer: true }

* validates_numericality_of :age, :greater_than => 18 #greater_than_or_equal_to, equal_to, less_than, less_than_or_equal_to

* validates_presence_of :price,
      :message => Proc.new { |book, data|
      "You must provide #{data[:attribute]} for #{book.title}"
      }


### 验证为整数

*  validates :amount, numericality: { greater_than_or_equal_to: 0 }, :allow_nil => true

```
:greater_than：属性值必须比指定的值大。该选项默认的错误消息是“must be greater than %{count}”；
:greater_than_or_equal_to：属性值必须大于或等于指定的值。该选项默认的错误消息是“must be greater than or equal to %{count}”；
:equal_to：属性值必须等于指定的值。该选项默认的错误消息是“must be equal to %{count}”；
:less_than：属性值必须比指定的值小。该选项默认的错误消息是“must be less than %{count}”；
:less_than_or_equal_to：属性值必须小于或等于指定的值。该选项默认的错误消息是“must be less than or equal to %{count}”；
:other_than：属性值必须与指定的值不同。该选项默认的错误消息是“must be other than %{count}”。
:odd：如果设为 true，属性值必须是奇数。该选项默认的错误消息是“must be odd”；
:even：如果设为 true，属性值必须是偶数。该选项默认的错误消息是“must be even”；
```

### 唯一性

* validates_uniqueness_of :code, :scope => :year, :message => "你的 code 重复了", :on => :create

* validates_uniqueness_of :phone, scope: :user_id, :message => "当前用户下手机号码重复", :on => :create

### 格式正确

* validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

* validates_format_of :url, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

* /([\s\S]*)-([\s\S]*)-\d{6}/.match?("ｉ是-你好-123212") #匹配任意字符　＊-*-123444

### 验证车牌号是否正确

*   validates_format_of :plate, with: /\A[京,津,渝,沪,冀,晋,辽,吉,黑,苏,浙,皖,闽,赣,鲁,豫,鄂,湘,粤,琼,川,贵,云,陕,秦,甘,陇,青,台,内蒙古,桂,宁,新,藏,澳,军,海,航,警][A-Z]\s?[0-9,A-Z]{5}\z/


## 可用的回调
下面列出了所有可用的 Active Record 回调，按照执行各操作时触发的顺序：

### 创建对象

* before_validation

* after_validation

* before_save

* around_save

* before_create

* around_create

* after_create

* after_save

### 更新对象

* before_validation

* after_validation

* before_save

* around_save

* before_update

* around_update

* after_update

* after_save

### 销毁对象

* before_destroy

* around_destroy

* after_destroy

## 跳过回调

* decrement

* decrement_counter

* delete

* delete_all

* increment

* increment_counter

* toggle

* touch

* update_column

* update_columns

* update_all

* update_counters


## 关联删除
has_many :users, dependent: :destroy
