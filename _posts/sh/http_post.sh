#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#  author      : chenwei
#  description : curl请求发送文件
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


URL="http://101.132.155.170:3006/api/v1/card_recon" #修改API请求地址
FILE="/tmp/2.png" #修改文件名路径

curl -X POST $URL \
-F "ak=qwerasdfzxc" \
-F "kind=1001" \
-F file="@$FILE"
