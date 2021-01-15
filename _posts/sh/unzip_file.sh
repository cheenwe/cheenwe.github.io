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





current_file_path="/file/projects/zip/12/"

i=1
for shname in `ls $current_file_path`
do
	unzip -o "$current_file_path$shname"
done








current_file_path="./"

i=1
for son_folder in `ls $current_file_path`
do
	# echo "$current_file_path$son_folder"
	current_folder=$current_file_path$son_folder

	tar -zxf ${current_folder}
	rm ${current_folder}
	# for file in `ls $current_file_path$son_folder`
	# do
	# 	current_file="$current_folder$file"
	# 	# unzip -o "$current_file_path$son_folder"
	# 	if [ "${file##*.}" = "gz" ]; then
	# 		echo ${current_file}
	# 		cd $current_folder
	# 		tar -zxf ${file}
	# 		rm ${file}
	# 	fi
	# done
done




current_file_path="/data_1/bigdata/0815"

i=1
for son_folder in `ls $current_file_path`
do
	# echo "$current_file_path$son_folder"
	current_folder=$current_file_path$son_folder

	for file in `ls $current_file_path$son_folder`
	do
		current_file="$current_folder$file"
		# unzip -o "$current_file_path$son_folder"
		if [ "${file##*.}" = "gz" ]; then
			echo ${current_file}
			cd $current_folder
			tar -zxf ${file}
			rm ${file}
		fi
	done
done




for i in `ls ./*.rar` 
do
	unrar x $i && rm -rf $i
done