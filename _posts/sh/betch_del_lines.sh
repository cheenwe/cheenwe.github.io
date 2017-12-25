#!/usr/bin/bash

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : betch_del_line.sh
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.12.12
#  description : 批量删除目录下全部文件指定行数
#
#  history     :
#            1. Date: 2017.12.12
#               Author:  cheenwe
#               Modification: 批量删除目录下全部文件指定行数
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #

root_path="/Users/chenwei/workspace/project/autohome/tmp/html"

function delLine(){
  sed '5,1565d' $1 > file.copy
  mv file.copy $1
}

for shname in `ls $root_path`

do
  flist=`ls  $root_path/$shname`
    #echo $flist
    for f in $flist
    do
      delLine $root_path/$shname/$f
    done
  # echo "$root_path$shname/2148-1-p1.html.html"
done


