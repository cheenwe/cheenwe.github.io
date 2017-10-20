---
layout: post
title: ip digital interchange
tags:   ip 
category:  ruby 
---




#  IP地址数字相互转换

项目中需要存储设备的 IP 地址, 以我的理解直接存储 string 类型的字段, 直接读写很便利, 
但是项目有 c++ 程序部分, 数据库创建的为 integer 类型的字段. 涉及到需要把 ip 地址 和数字的互转, 方法记录如下:

## IP -> 数字

```
 require 'ipaddr'
 ip ='192.168.1.2'
 IPAddr.new(ip).to_i
 #=> 3232235778
```

##  数字 -> IP

```
 ipaddr = 3232235778
 [ipaddr].pack("N").unpack("C4").join(".")
 # 注意 外部使用 []
 #=> "192.168.1.2"
```