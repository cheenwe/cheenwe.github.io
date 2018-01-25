---
layout: post
title: Ruby Zip Delete File
tags:    ruby zip delete file
category:   ruby
---

在 Rails 项目中开发添加文件到压缩包的功能, 实际使用中发现压缩包中相同的文件会出现多个, 只有在解压时候会提示覆盖, 客户反馈需要解决, 看了下项目的源码找到了 `remove` 的方法, 很好用.

[rubyzip](https://github.com/ruckc/rubyzip2)

实现如下:

```ruby

# 把文件添加到压缩包
# - file_to_zip: 压缩包名
# - output_file_name: 需要压缩的文件名

def zip_file(file_to_zip, output_file_name)
  ::Zip::File.open(output_file_name, ::Zip::File::CREATE)  do |zip_file|
      file_name = file_to_zip.split("/").last
      zip_file.remove(file_name) rescue '' # 判断是否有重名文件,先删除
      zip_file.add(file_name, file_to_zip)

      zip_file.close
  end
end

```

