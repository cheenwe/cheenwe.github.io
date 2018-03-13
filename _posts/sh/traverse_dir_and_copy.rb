#!/usr/bin/ruby

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : traverse_dir_and_copy.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2018.03.13
#  description : 1. 列出 B 目的文件夹内全部文件, _1_
#                2. 检查 A 源文件夹是否存在向相同名称的文件  _2_
#                3. 把A源文件  复制到 B 文件夹
#
#  history     :
#               1. Date: 2017.03.09
#               Author:  cheenwe
#               Modification: 技术点： 1. 遍历文件夹； 2.追加打印内容到文件
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #




require 'fileutils'

# 配置源数据路径, 包含 文件夹名如:
#   - source
#     - suntao
#     - qwh
source_data = "/Users/chenwei/tmp/0313/source/source"

# 配置目标数据路径, 包含文件夹名如:
#   - data
#       - you-b
#        - kan-dang
#        - zuo-b
#        - yi-biao-pan
# ....

aim_data = "/Users/chenwei/tmp/0313/source/data"


def traverse_dir(source_data, file_path)
  if File.directory? file_path
      Dir.foreach(file_path) do |folder|
          if folder !="." and folder !=".." and folder != '.DS_Store'
              puts "======== 进入 #{folder} ========"
              second_folder_path = file_path + "/#{folder}"
              Dir.foreach(second_folder_path) do |file|
                  if file !="." and file !=".." and file != '.DS_Store'
                      name = file.gsub('_1_', '_2_')

                      source_name = source_data + "/2/#{name}"
                      dist_name = second_folder_path

                      if File.exists? source_name
                        FileUtils.cp source_name, dist_name
                        p " "*20 + name + "   ok"
                      end
                  end
              end
          end
      end
  end
end


Dir.foreach(source_data) do |folder|
    if folder !="." and folder !=".." and folder != '.DS_Store'
        puts "==================================================="
        puts "==================================================="
        puts "=============== 处理 #{folder} 数据开始 =============="
        puts "==================================================="
        puts "==================================================="
        source_folder = source_data + "/" + folder
        traverse_dir(source_folder, aim_data)
        puts " "*30
        puts " "*30
        puts "============== 处理 #{folder} 数据 结束 ============="
        puts " "*30

    end
end

