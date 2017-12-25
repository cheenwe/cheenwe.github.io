#!/bin/bash

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : rename_all_file.sh
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.12.01
#  description : 遍历文件夹下全部文件, 并重命名
#
#  history     :
#               1.
#               Author:
#               Modification:
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #

function changeName(){
    mv $1 $1.jpg
}

function travFolder(){
    echo "travFolder"
    flist=`ls $1`
    cd $1
    #echo $flist
    for f in $flist
    do
        if test -d $f
        then
            echo "dir:$f"
            travFolder $f
        else
            echo "file:$f"
            changeName $f
        fi

    done
    cd ../
}

dir="/file/projects/projects/share/"
travFolder $dir
traverse_dir(TRAVERSE_PATH)
