#!/usr/bin/ruby

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : read_and_create_file.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.03.22
#  description :  读取文件内数据，根据文件内数据创建指定文件
#
#  history     :
#               1. Date: 2017.03.09
#               Author:  cheenwe
#               Modification:
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #

BASE_FILE = "data.txt" #输出文件

File.open(BASE_FILE,"r") do |file|

    while line  = file.gets
        arr  = line.to_s.split(" ") #打印出文件内容
        file_name = arr[0].to_s.gsub(".JPG", ".txt")

        if File.exist?(file_name)
            puts "文件已存在了: #{file_name}"
        else
            unless file_name == ""
                File.open("#{file_name.to_s}","w+") do |f|
                    f.puts "#{arr[1]}"
                    f.close
                    puts "创建成功: #{file_name}"
                end
            end
        end
    end
end

