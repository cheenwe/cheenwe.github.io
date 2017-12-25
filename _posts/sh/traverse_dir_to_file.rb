#!/usr/bin/ruby

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : traverse_dir_to_file.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.03.28
#  description : 遍历文件夹下全部文件名输出到指定的文件
#
#  history     :
#               1. Date: 2017.03.09
#               Author:  cheenwe
#               Modification: 技术点： 1. 遍历文件夹； 2.追加打印内容到文件
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #

TRAVERSE_PATH = "/home/chenwei/workspace/blog/cheenwe.github.io/_posts/sh" #需要遍历的目录
OUTPUT_FILE = "0.txt" #输出文件

def traverse_dir(file_path)
    out_file = "#{file_path}/#{OUTPUT_FILE}"
    f = open(out_file,"a")
    if File.directory? file_path
        Dir.foreach(file_path) do |file|
            if file !="." and file !=".."
                f.puts file
            else
                # puts ">>>>>>"
            end
        end
    end
end

traverse_dir(TRAVERSE_PATH)
