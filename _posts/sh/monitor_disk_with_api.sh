#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  author      : chenwei
#  description : 判断磁盘使用率,超过阈值部分发送到监控服务器
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
alarm_used_precent=80
app='disk_monitor'
alarm_url="http://192.168.50.11:4001/api/v1/heartbeat"


# 发送告警请求
send_alarm_request() {

    reason="$1"
    curl -X POST $alarm_url \
    -H "accept: application/json;charset=UTF-8" \
    -H "authorization: Bearer 2329c99f-71f0-4c85-80b5-aa1dd911fd5c" \
    -H "Content-Type: application/json" \
    -d "{ \"token\": \"123123123\", \"t\": \"123123123\", \"app\": \"$app\", \"service\": \"$(hostname)\", \"state\": \"1\", \"reason\": \"$reason\"}"

}

# 判断磁盘使用率是否大于阈值
df -Ph | grep -vE '^Filesystem|tmpfs|cdrom|overlay|shm' | awk '{ print $5,$1 }'| while read output;
do
  # echo $output
  used=$(echo $output | awk '{print $1}' | sed s/%//g)
  partition=$(echo $output | awk '{print $2}')
  if [ $used -ge $alarm_used_precent ]; then
    reason="分区: "$partition" 已使用 $used%"
    echo $reason
    send_alarm_request $reason
  fi
done

EOF
cat $file

chmod +x  $file



# 每 5 分钟执行一次
# crontab  -e
#*/5 * * * * /usr/local/bin/monitor_disk.sh
