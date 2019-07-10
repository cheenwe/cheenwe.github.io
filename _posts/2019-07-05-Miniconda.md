---
layout: post
title: Miniconda
tags:      python
category:   python
---

Miniconda，顾名思义，它只包含最基本的内容——python与conda，以及相关的必须依赖项，对于空间要求严格的用户，Miniconda是一种选择。就只包含最基本的东西，其他的库得自己装。

Anaconda则是一个打包的集合，里面预装好了conda、某个版本的python、众多packages、科学计算工具等等，就是把很多常用的不常用的库都给你装好了。



对conda的基本掌握：

```
1：基本操作：
升级全部库：  conda upgrade --all
升级一个包  conda update packagename
安装包：conda install packagename
也可以安装多个包：   conda installl numpy pandas scipy
安装固定版本的包：conda install numpy =1.10
移除一个包：conda remove packagename 
查看所有包：conda list 
2：管理python环境：
创建虚拟环境：conda create -n env_name list of packagenaem
eg:  conda create -n env_name pandas 
指定python版本：conda create -n env_name python2 = 2.7 pandas 
激活环境： activate env_name
退出环境 :  deactivate  env_name
删除虚拟环境：conda env remove -n env_name
显示所有虚拟环境：conda env list  
conda 创建的虚拟环境是在anaconda安装目录下的evens下，所以使用pycharm，只要在特定项目配置运行环境就可以了 
```

## 下载

https://repo.anaconda.com/miniconda/

## 文档

https://docs.conda.io/en/latest/miniconda.html

 
