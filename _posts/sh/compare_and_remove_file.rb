#!/usr/bin/ruby

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : traverse_dir_and_copy.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2018.06.12
#  description : 1. 检查 A 目录中文件 B 目录中是否存在,  如果存在, 删除 B 目录中文件
#                2. 再将 A  目录中文件整体移动到新的路径
#
#  history     :
#               1. Date: 2018.06.12
#               Author:  cheenwe
#               Modification: 技术点： 1. 遍历文件夹； 2.追加打印内容到文件
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #



require 'fileutils'

# 配置A 目录 路径:
dir_A = "/home/data/mark"

# 配置B 目录 路径:
dir_B = "/home/data/json"

# 配置A 目录  处理完成后路径:
aim_A = "/home/data/json_ok"

Dir.foreach(dir_A) do |file|
    if file !="." and file !=".." and file != '.DS_Store'

        # puts "read " + file

        checkd_name = "#{dir_B}/#{file}.json"
        dist_name =  "#{aim_A}/"

        if File.exists? checkd_name
          FileUtils.cp checkd_name, dist_name
          # p " "*20 + name + "exists"
        end
    end
end









require 'fileutils'

# 配置A 目录 路径:
dir_A = "/home/data/mark"

# 配置B 目录 路径:
dir_B = "/home/data/json"


Dir.foreach(dir_A) do |file|
    if file !="." and file !=".." and file != '.DS_Store'

        source_name =  + "#{dir_B}/#{file}.json"

        # puts "read " + file

        if File.exists? source_name
          FileUtils.cp source_name, "#{dir_B}_new"
        else
          p source_name
        end
    end
end

