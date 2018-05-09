#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : parameter.sh
#  author      : cheenwe
#  version     : 0.0.1
#  created     : 2018.05.09
#  description : 判断输入参数
#
#
#  history     : 日志文件
#               1. Date: 2018.05.09
#               Author:  cheenwe
#               Modification: first add
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

echo_arg() {
   echo  $1
}

if [[ ! -z $1 ]];then

    echo "输入参数个数: $#"
    if [ ! $# == 1 ]; then

        for per in $@;
        do
            echo_arg $per
        done
    else
        echo_arg $1
    fi
    exit 1

else
    echo "***************** usage **********************"
    echo "添加单个参数: $0 user"
    echo "添加多个参数: $0 user1 user2"
    echo "****************** end ***********************"
    exit 1
fi

