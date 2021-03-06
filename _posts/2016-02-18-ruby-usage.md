---
layout: post
title: ruby 备忘
tags: ruby
category: ruby
---


#   ruby 备忘
整理自个人有道云记录

## 判断字符类型
    取余数 :
    n%20 == 0

    整数判断 :
    i.is_a?(Integer)

    浮点数判断 :
    i.is_a?(Float)

    数字判断 :
    i.is_a?(Numeric)

    类方法判断 :
    i.class == Fixnum


## 字符串处理

### 补位
```
 "11".rjust(4, "0")
#=> "0011"

"11".ljust(4, "0")
#=> "1100"

```

### 连接
> "a"+"b"*3 #=> "abbb"

### 比较
> "a">"b" #=>false

> "a"<"b" #=>true

### 截取
>"hello word"[1..2] #=> el

>"hello word"[2,3] #=> "llo"

>"hello word"[-9..-7] #=> "ell"


### 首字母大写 capitalize

>"hello".capitalize #=> "Hello"

>"HELLO".capitalize #=> "Hello"

>"123ABC".capitalize #=> "123abc"

### 首字母小写 downcase

>"hEllO".downcase #=> "hello"

### 删除字符 delete
"hello".delete "l","lo" #=> "heo"

"hello".delete "lo" #=> "he"

### 字符串 转 类

>"Article".constantize

or

>Object.const_get("Article")

### 替换 gsub
```ruby
b = "crm_property_anime_type"

b.gsub("_","/").underscore # => "crm/property/anime/type"
```

- 移除换行

```ruby
bak_date=`date +%F`
file =  'ran_'+"#{bak_date}"".gz"
file.gsub!(/\n/, '')
```

### 转小写 downcase
>b.downcase # => "crm_property_anime_type"

### classify
>b.classify # => "CrmPropertyAnimeType"

### 包含 include
"hello".include? "lo" #=> true
"hello".include? "ol" # => false

### 自加 next/succ
>"abcd".succ #=> "abce"

111.next #=> 112

### 转数组
>" now's  the time".split        #=> ["now's", "the", "time"]

>"1,2,,3,4,,".split(',')         #=> ["1", "2", "", "3", "4"]


### Ruby 字符串长度不要超过 23 位字符

```ruby

Benchmark.bm do |bench|
 run("12345678901234567890", bench)
 run("123456789012345678901", bench)
 run("1234567890123456789012", bench)
 run("12345678901234567890123", bench)
 run("123456789012345678901234", bench)
 run("1234567890123456789012345", bench)
 run("12345678901234567890123456", bench)
end

       user     system      total        real
21 chars  0.150000   0.000000   0.150000 (  0.145835)
22 chars  0.120000   0.000000   0.120000 (  0.127440)
23 chars  0.130000   0.000000   0.130000 (  0.129458)
24 chars  0.200000   0.000000   0.200000 (  0.201865)
25 chars  0.210000   0.000000   0.210000 (  0.202730)
26 chars  0.200000   0.000000   0.200000 (  0.201217)
27 chars  0.200000   0.000000   0.200000 (  0.204451)

```

## 文件读写

### 读文档  File.read

```ruby
def path name
  File.read("#{Rails.root}/db/#{name}")
end

countries =  JSON.parse(path("country.json"))
```

### 写文档  File.write

```ruby

File.open("#{Rails.root}/db/demo.json", 'w') do |file|
file.write User.all.to_json
end

```

## 查看项目代码行数 rake stats
>rake stats


## 自定义验证
http://api.rubyonrails.org/classes/ActiveModel/Validations/ClassMethods.html

验证名称不能以数字开头

```ruby
validate :validate_name_is_number

def validate_name_is_number
  if self.name.to_i > 0
    errors.add(:name, "名字不能全为数字")
  else
  end
end

```

## 取随机记录
>Product.order('RAND()').limit(20)

>Product.all.sample(20)

第二种方式效率比较高

## 缓存随机数据

    Rails.cache.fetch("rand_products", expires_in: 1.day) do
      Product.order('RAND()').limit(20).to_a
    end

使用 to_a 方法之后，会真正查询数据库，返回数据对象。

## MySQL在Rails迁移处理过长的索引名称
报错:
>Index name 'index_item_contacters_on_itemable_id_and_itemable_type_and_contacter_id' on table 'item_contacters' is too long; the limit is 64 characters

解决:
>    add_index :item_contacters, [:itemable_id, :itemable_type, :contacter_id],
          :unique => true, :name => 'item_contacters_index'



## 统计数组或哈希中不同元素的个数

```ruby
str='a,b,c,a,c,d'

counter = Hash.new(0)

str.split(',').each { |val| counter[val]+=1 }

puts counter
```


```ruby
    counter = Hash.new(0)

    check_infos = eval("@check_infos.#{params[:search]}.map(&:reason)")

    results = check_infos.uniq

    check_infos.each { |val| counter[val]+=1 }

    arr = []
    results.each do |r|
      if  r != "通过"
      arr << {label: r, value:counter[r] }
      end
    end

    render :json => {
      :headcode => 200,
      :message =>"ok",
      data: arr,
    }, :status => 200
```


## Rails 缓存

```ruby
    #  缓存机制, 先读缓存值,
    #  -> 不存在: 去数据库查询
    #  -> 存在:  直接使用

    start_at = Date.parse(params[:start_at]).beginning_of_day rescue (Date.today.beginning_of_day)
    end_at = Date.parse(params[:end_at]).end_of_day rescue   (Date.today.end_of_day)

    if Rails.cache.read("check_sums-#{start_at}-#{end_at}").nil?
      @vehicle_checks = VehicleCheck.includes(:check_infos).where(["created_at > ? AND created_at < ?", start_at, end_at])
      @check_sums = {
        :passed_total => @vehicle_checks.passed.size,
        :total => @vehicle_checks.size
      }
      Rails.cache.write("check_sums-#{start_at}-#{end_at}", @check_sums, expires_in: Settings.cache_seconds.seconds)
    else
      @check_sums = Rails.cache.read("check_sums-#{start_at}-#{end_at}")
    end
```


## 获取当前文件绝对路径

    require 'pathname'
    root_path = Pathname.new(File.dirname(__FILE__)).realpath


## 读 yaml 文件内容
    # config.yml
    ## file_path: "xxxx"

    require 'yaml'
    data = YAML.load_file("#{root_path}/config.yml")
    p data["file_path"]



## gem source

    gem sources --add https://gems.ruby-china.com/ --remove https://ruby.taobao.org/
    sudo gem install bundler
    bundle config mirror.https://ruby.taobao.org https://gems.ruby-china.com


## read file by line


```
File.open(down_file,"r") do |file|
  while line  = file.gets
    file_name  = line.split('/data/').last.delete('\"').chomp #打印出文件内容
    p file_name
    # if @oks.include?(file_name)
    # else
    #   p line
    # end
  end
end
```

## remove repeat


```


arr =[]
Crm::Contacter.find_in_batches(batch_size: 1000).each do |list|
  list.each do |contacter|
    conts = Crm::Contacter.where(phone: contacter.phone)
    total = conts.size
    if total > 1
      uids = conts.map { |e| e.id  }
      arr  << {:"#{contacter.phone}" => uids}
    end
  end
end




res = []
phones = []
ss.each do |i|
  unless phones.include?(i.keys[0].to_s)
    phones << i.keys[0].to_s
    res << i
  end
end



f = open("#{Rails.root}/tmp/a.csv","a")

f.puts "phone, name, client_name,manager, created_at, updated_at \n"

res.each do |i|
  phone = i.keys[0].to_s
  i.values.flatten.each do |j|
    contacter = Crm::Contacter.find(j) rescue ''
    if contacter.present?
      p " #{phone rescue ''}, #{contacter.name rescue ''}, #{contacter.client.name rescue ''}, #{contacter.the_manager.cname rescue ''}, #{contacter.created_at.to_date rescue ''}, #{contacter.updated_at.to_date}"
    end
  end
end

f.close()

```


## Rails 定时任务

    crontab -e

    * * * * * /bin/bash -l -c cd /home/ubuntu/workspace/project/smbmanage && bundle exec bin/rails runner -e development Work::Summary.new.send_mail
