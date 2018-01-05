#!/usr/bin/env bash

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : unzip_file.sh
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.11.27
#  description : 批量解压文件
#
#  history     :
#            1. Date: 2017.11.27
#               Author:  cheenwe
#               Modification: 批量解压文件
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #


current_file_path="/file/projects/projects/share/chejian/车检现场数据库/苏州车管所/zip/12/"

i=1
for shname in `ls $current_file_path`
do
unzip -o "$current_file_path$shname"
done
