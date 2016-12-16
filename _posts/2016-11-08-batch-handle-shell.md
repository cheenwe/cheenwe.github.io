---
layout: post
title: 批量处理脚本
tags: shell
category: shell
---

# 批量处理脚本

## 批量拷贝目录下图片并重命名

```sh
#!/bin/zsh
for files in `find /home/chenwei/Pictures/system/fatigues/attachments/   -name "*.jpg"`
do
  # 指定后缀名
  hname=".jpg"
  # 指定文件名(这里采用加1的方式)
  name=$(echo "$name + 1"|bc)
  # 拼接成完整文件名
  filename=$name$hname
  # 修改文件名
  cp $files $filename
done
```

- Rails 复制文件脚本 
```ruby
Heartbeat.where('created_at > ?', Time.now - 4.hour).with_location.each do |record|
  FileUtils.cp(record.file.path, "/root/backup/1124/#{record.id}.jpg")
end
```
