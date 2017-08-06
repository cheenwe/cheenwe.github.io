#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : log_stop.sh
#  author      : cheenwe
#  version     : 0.0.1
#  created     : 2017.8.04
#  description : stop shell
#                   usage: bash log_stop.sh &
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# APP_NAME='log_watch_dog.sh'
APP_NAME='log.sh'

# get log file
app_pid=$(ps aux | grep $APP_NAME |  grep -v grep | awk '{print $2}')

echo "${APP_NAME} pid is: ${app_pid}"

kill -9 $app_pid

if ps -p $app_pid > /dev/null
then
   echo "$app_pid is running"
   # Do something knowing the pid exists, i.e. the process with $PID is running
fi