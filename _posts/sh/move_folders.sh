#!/usr/bin/env bash

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : move_folders.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.03.09
#  description : 处理文件夹下目录过多导致文件夹📂无法打开,
#                 批量创建子文件夹并把相应的文件夹转移到新文件夹下
#  history     :
#               1. Date: 2017.03.09
#               Author:  cheenwe
#               Modification: 每个文件夹下保留99个子文件夹
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #


current_file_path="201607"
new_file_path="201607_all"

i=1
for shname in `ls $current_file_path`
do
name=`echo "$shname" | awk -F. '{print $1}'`
    if(($i%100==0))
    mkdir -p ./$new_file_path/$[$i/100]
    mv  $current_file_path/$name ./$new_file_path/$[$i/100]/
    then
        echo $i
        mv  $current_file_path/$name/ ./$new_file_path/$[$i/100]/
    fi
    i=$(($i+1))
done