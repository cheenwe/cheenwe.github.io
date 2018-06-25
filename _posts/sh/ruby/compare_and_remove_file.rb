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
dir_A = "/data/source/result/noglass_2_bak/mark"

# 配置B 目录 路径:
dir_B = "/data/source/user18/noglass_2"

# 配置A 目录  处理完成后路径:
#aim_A = "/data/source/result/noglass_1_ok"

Dir.foreach(dir_A) do |file|
    if file !="." and file !=".." and file != '.DS_Store'
        puts "compare" + file

        source_name = dir_B + "/#{file}"

        if File.exists? source_name
          # FileUtils.cp source_name, dist_name
          p " "*80 + "exists"
          FileUtils.rm  source_name
        end
    end
end

#FileUtils.mv(dir_A, aim_A)

puts "success"
