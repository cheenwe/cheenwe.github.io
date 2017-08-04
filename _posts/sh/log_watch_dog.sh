#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : log_watch_dog.sh
#  author      : cheenwe
#  version     : 0.0.1
#  created     : 2017.8.04
#  description : 监听日志文件是否开启, 手动配置程序名,并保留日志文件
#                   
#                   usage: bash log_watch_dog.sh &
#  history     : 日志文件
#               1. Date: 2017.2.24
#               Author:  cheenwe
#               Modification: first add
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
 
RED="\\033[31m" 
BLACK="\\033[0m"
POS="\\033[60G"
date=`date '+%Y%m%d'`
now=`date '+%Y%m%d %H:%M:%S'`

SLEEP_TIME=3
APP_PATH=`pwd` 
APP_NAME='watch_dog_log.sh'
GREP_FLAG='log.sh'
APP_LOG_FILE="${APP_PATH}/log/${APP_NAME}.${date}.log"


# get log file
app_log=${APP_LOG_FILE}
log_dir=`dirname $app_log`
app=`(cd ${APP_PATH} && cd $log_dir && pwd)`/`basename $APP_NAME`
log=`(cd ${APP_PATH} && cd $log_dir && pwd)`/`basename $app_log`
 
ok_msg() {
    echo -e "${now}  ${1}${POS}${BLACK}[${RED}FAILED${BLACK}]"
    echo "[${now}] [ERROR] ${1}" >> $log
}

if [ ! -f "$APP_PATH/$APP_NAME" ]; then
    ok_msg "$APP_PATH/$APP_NAME missing, check again"
fi

while [ 0 -lt 1 ]
do 
    ret=`ps aux | grep "$GREP_FLAG" | grep -v grep | wc -l`
    if [ $ret -eq 0 ]; then
        ok_msg "process not exists ,start process now... "
        bash $app
        ok_msg "start done ..... " 
    else
        ok_msg "process exists , sleep $SLEEP_TIME seconds "
    fi
    sleep $SLEEP_TIME
done