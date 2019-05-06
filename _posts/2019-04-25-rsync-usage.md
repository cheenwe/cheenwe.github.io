---
layout: post
title: rsync 快速删除大量文件
tags:    rsync  
category:   shell
---

## rsync 快速删除大量文件

sudo apt-get install rsync

## 删除大量小文件

rsync --delete-before -d -a -H -v --progress --stats /tmp /your_need_delete_files

or

rsync --delete-before -d /tmp /your_need_delete_files
 

## 删除大件

rsync  --delete-before -d --progess --stats /tmp /your_need_delete_folder


## 同步文件

rsync -avz top20 ubuntu@192.168.70.122:/data/public/testtop20/

