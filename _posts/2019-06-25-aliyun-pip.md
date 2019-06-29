---
layout: post
title: 设置阿里云pip源，加速pip更新速度
tags:    pip   python
category:   python
---

## Linux系统：

```

mkdir ~/.pip

cat > ~/.pip/pip.conf << EOF

[global]
trusted-host=mirrors.aliyun.com
index-url=https://mirrors.aliyun.com/pypi/simple/

EOF

```


## Windows系统：


首先在window的文件夹窗口输入 ： %APPDATA%

然后创建pip文件夹

最后创建pip.ini文件，写入如下内容


```
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
```


## 其他源:

清华: https://pypi.tuna.tsinghua.edu.cn/simple 

豆瓣: https://pypi.douban.com/simple
