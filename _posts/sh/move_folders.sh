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






root_folder="/data/20180817-01"

folder="$root_folder/0.任务集/" #处理前的文件夹名
new_folder="$root_folder/1.任务分配/" #处理后的文件夹名

max_folder_id=12 #平均分配文件夹个数, 需要分到12个文件夹, 这里填的数字应该为11
copy_size=2 #每次复制到文件夹个数, 需要分到一个文件夹10个文件, 这里填的数字应该为9

for i in {1..`expr $max_folder_id + 1`}
do
    eval "mkdir -p  $new_folder$i"
done

i=1
folder_id=1
for line in `ls $folder`
do
    if [ $i -gt $copy_size ]; then
        i=0
        if [ $folder_id -gt $max_folder_id ]; then
            folder_id=0
        fi
        folder_id=`expr $folder_id + 1`
    fi
    eval "cp  $folder$line  $new_folder$folder_id/"
    i=`expr $i + 1`
done
