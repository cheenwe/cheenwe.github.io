---
layout: post
title: ruby 面试题目
tags: ruby
categories: ruby
---

# ruby 面试题目
找了几个简单的面试题目

#### 题目1. What's the difference between equal?, eql?, ===, and ==?

http://stackoverflow.com/questions/7156955/whats-the-difference-between-equal-eql-and

#### 题目2. 数组 arr = [22,2,66,-2,55,0] , 请实现快速排序 .

```ruby
[22,2,66,-2,55,0].sort
```

```ruby
 def quicksort(list)
  return [] if list.size == 0
  x, *xs = *list
  less, more = xs.partition{|y| y < x}
  quicksort(less) + [x] + quicksort(more)
 end
```

```ruby
 def quicksort(l)
  return [] if (x,*xs=l).empty?
  less, more = xs.partition{|y| y < x}
  quicksort(less) + [x] + quicksort(more)
 end
```

```ruby
 def quicksort a
  (pivot = a.pop) ? quicksort(a.select{|i| i <= pivot}) + [pivot] + quicksort(a.select{|i| i > pivot}) : []
 end
```

#### 题目3. 文件在 /home/root/demo.txt 下, 请写方法读取 demo.txt 内容 . (加分项: 写方法读取*指定路径*下文件内容)

```ruby
File.read("/home/root/demo.txt")
```

```ruby
def read name
  File.read("#{name}")
end
```

#### 题目4. 字符串: str = "hello word ruby" , 写出两种方式 截取出 "word" 字符串.

```ruby
str[6..9]
```

```ruby
str[-9..-6]
```

#### 题目5. names = %w(hello good res start end string me submit), 写找出 names 中以"s"开头的单词, 并把该单词转换成大写的方法.

```ruby
names.select { |name| name.start_with?('S') }.map(&:upcase)
```

#### 题目6. 求20以内的平方可被五整除的自然数的和 的方法？

```ruby
n, num_elements, sum = 1, 0, 0
while num_elements < 100
  if n**2 % 5 == 0
    sum += n
    num_elements += 1
  end
  n += 1
end
sum #=> 25250
```

#### 题目7.

写出Animal.new.speak , Animal.speak,  Dog.speak 和 Dog.new.speak 分别输出什么结果 ? 并说明原因 .

```ruby
#animal.rb
class Animal
  def speak
    puts "Ou! Ou ....."
  end

  def self.speak
    puts "Quack! Quack... "
  end
end

#dog.rb
class Dog < Animal
  def speak
    puts 'Wang! Wang... '
  end
end
```
