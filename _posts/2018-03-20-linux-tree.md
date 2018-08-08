---
layout: post
title: linux终端中用树形显示文件
tags:    linux tree
category:   linux
---

tree命令可以以树形结构显示文件目录结构

```
sudo apt-get install tree
tree –help
```

查看当前第3级的目录和文件

```
tree -L 3 >tree.txtw
```
