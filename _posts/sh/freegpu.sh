#!/bin/bash
### BEGIN INIT INFO
# Provides:          Chenwei
# Required-Start:    $remote_fs
# Required-Stop:     $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: 通过 scontrol 显示 GPU 剩余个数.
# Description:       https://github.com/cheenwe/my_shell
### END INIT INFO

gpu_num=8
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLACK="\\033[0m"
POS="\\033[60G"

ok_msg() {
  echo -e "${1}${BLACK}${GREEN} ${2}${BLACK}"
}

failed_msg() {
    echo -e "${1}${POS}${BLACK}[${RED}FAILED${BLACK}]"
}

echo -e "${POS}"

check_gpu() {
    usd=`scontrol show node $1 |grep 'AllocTRES'|awk -F"=" '{print $4}'`
    if [ ! -n "$usd" ]; then
        ok_msg "$1" "$gpu_num"
    else
        if [ "$usd" -gt "0" ]&&[ "$usd" -lt "8" ];then
            ((r=$gpu_num-$usd))
            ok_msg "$1" "$r"
        # elif [ "$usd" -ge "60" ]&&[ "$usd" -lt "85" ];then
        else
            echo -e "node${POS}${BLACK}"
            ok_msg "$1" "$gpu_num"
        fi
    fi
}

if [ ! -n "$1" ]; then
    printf 'Usage: gpuidle %s {all|em1|em2|em3|em4|em5}\n'
else
    ok_msg "Node" "Idle Gpu"
    if [ $1 == 'em1' ] || [ $1 == 'em2' ]|| [ $1 == 'em3' ]|| [ $1 == 'em4' ]|| [ $1 == 'em5' ]; then
    check_gpu $1
    else
        list="em1 em2 em3 em4 em5"
        for i in $list;
        do
        check_gpu $i
        done
    fi
fi

echo -e "${POS}"
