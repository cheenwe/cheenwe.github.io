#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#  author      : chenwei
#  description : 多线程脚本并发
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


for ((i=1; i<=100; i++))
do
{
  cd /Users/chenwei/tmp/&&./run.sh # 运行命令
}&
done
wait　　


# cat run.sh
# curl 'http://test.xxx.gateway/auth/oauth/token' \
#   -H 'Connection: keep-alive' \
#   -H 'Accept: application/json, text/plain, */*' \
#   -H 'DNT: 1' \
#   -H 'Authorization: Basic cGlnOnBpZw==' \
#   -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36' \
#   -H 'Content-Type: application/x-www-form-urlencoded' \
#   -H 'Origin: http://test.xxx.gateway' \
#   -H 'Referer: http://test.xxx.gateway/swagger-ui.html?urls.primaryName=user' \
#   -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
#   --data-raw 'grant_type=password&username=admin&password=123456' \
#   --compressed \
#   --insecure
