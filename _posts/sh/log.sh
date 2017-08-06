#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : log.sh
#  author      : cheenwe
#  version     : 0.0.1
#  created     : 2017.8.04
#  description : shell 日志文件输出打印
#                  输出日志到终端显示颜色及输入日志到文件
#                   usage:  bash log.sh &
#  history     : 日志文件
#               1. Date: 2017.8.4
#               Author:  cheenwe
#               Modification: first add
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

########################################################################
# utility functions
########################################################################
RED="\\033[31m"
GREEN="\\033[32m"
YELLOW="\\033[33m"
BLACK="\\033[0m"
POS="\\033[60G"

date=`date '+%Y-%m-%d'`
now=`date '+%Y-%m-%d %H:%M:%S'`

APP_NAME='log.sh'
APP_PATH=`pwd`
APP_LOG_FILE="${APP_PATH}/log/${APP_NAME}.${date}.log"

# get log file
app_log=${APP_LOG_FILE}

# get abs path
log_dir=`dirname $app_log`

log=`(cd ${APP_PATH} && cd $log_dir && pwd)`/`basename $app_log`

# check log path persent
if [ ! -d "$log_dir" ]; then
    (mkdir -p ${log_dir} && chmod 777 ${log_dir} && touch $app_log)
    ret=$?; if [[ $ret -ne 0 ]]; then failed_msg "create log failed, ret=$ret"; return $ret; fi
    ok_msg "create log( ${log} ) success"
    ok_msg "see detail log: tailf ${log}"
fi

ok_msg() {
    echo -e "${now} ${1}${POS}${BLACK}[${GREEN}  OK  ${BLACK}]"
    echo "[${now}] [INFO] ${1}" >> $log
}

warn_msg(){
    echo -e "${now}  ${1}${POS}${BLACK}[ ${YELLOW}WARN${BLACK} ]"
    echo "[${now}] [WARN] ${1}" >> $log
}
failed_msg() {
    echo -e "${now}  ${1}${POS}${BLACK}[${RED}FAILED${BLACK}]"
    echo "[${now}] [ERROR] ${1}" >> $log
}

for ((i = 0; i < 50000; i++)); do
    # sleep a little while
    sleep 1
    warn_msg "${i} Myapp start warn";
    ok_msg "Myapp start ok";
    failed_msg "Myapp start failed_";
done
