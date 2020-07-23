#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  author      : chenwei
#  description : 判断磁盘使用率
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


alarm_used_precent=80

# 判断磁盘使用率是否大于阈值
df -Ph | grep -vE '^Filesystem|tmpfs|cdrom|overlay|shm' | awk '{ print $5,$1 }'| while read output;
do
  # echo $output
  used=$(echo $output | awk '{print $1}' | sed s/%//g)
  partition=$(echo $output | awk '{print $2}')
  if [ $used -ge $alarm_used_precent ]; then
    reason="分区: "$partition" 已使用 $used%"
    echo $reason
    #send_alarm_request $reason
  fi
done
