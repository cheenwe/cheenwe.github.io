---
layout: post
title: [oracle] 安装及配置
tags:    oracle 
category:   oracle
---

## 安装
### win7安装oracle 32位版本


严重: 程序异常终止。发生内部错误。 请将以下文件提供给 Oracle 技术支持部门:  
解决方法： 
 
1.打开\Oracle 10g\stage\prereq\db路径，找到refhost.xml文件，打开，向其中添加如下代码并保存。
``` 
<OPERATING_SYSTEM> 
          <VERSION VALUE="6.1"/> 
</OPERATING_SYSTEM> 
```
2.打开\Oracle 10G \install路径，找到oraparam.ini文件，打开，向其中添加如下代码并保存。
``` 
[Windows-6.1-required] 
#Minimum 
display colours for OUI to run 
MIN_DISPLAY_COLORS=256 
#Minimum CPU speed 
required for OUI 
#CPU=300 
[Windows-6.1-optional] 
 ```

3.找到oracle安装文件中的setup应用程序，右击属性-->兼容性-->勾上兼容模式选择("Windows XP(Service Pack 3)")，勾上"以管理员身份登录此程序",确定，然后运行！ 
 




## 数据部 oracle 

>192.168.100.200

```
Enterprise Manager Database Control URL - (orcl) :

http://R15R7WICVWUHAIT:1158/em

数据库配置文件已经安装到 E:\oracle\product\10.2.0,同时其他选定的安装组件也已经安装到 E:\oracle\product\10.2.0\db_1。

iSQL*Plus URL 为:

http://R15R7WICVWUHAIT:5560/isqlplus



iSQL*Plus DBA URL 为:

http://R15R7WICVWUHAIT:5560/isqlplus/dba

```


## 忘记密码

https://blog.csdn.net/pucao_cug/article/details/61616717


## 创建账号授权

https://www.cnblogs.com/HiJacky/p/5888623.html


导入：


```ruby

imp trff_zjk/trff_zjk file=C:\001\exppic01\exppic01.dmp FULL=Y



imp trff_zjk/trff_zjk@127.0.0.1:1521/orcl file=C:\003\exppic\exppic.
dmp FULL=Y


```

1. 创建表空间 https://localhost:1158/em sys emdata123
2. 添加数据文件，大小大于数据文件
