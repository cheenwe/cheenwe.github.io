#!/usr/bin/python3
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : vin_search.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2018.01.16
#  description : 车架号VIN（车辆识别代码）信息查询, 读取 txt中 vin 并检索信息存储到 txt中
#                涉及: 文件读写, http 请求等.
#                阿里云购买接口: https://market.aliyun.com/products/57002002/cmapi016152.html?spm=5176.10695662.1996646101.searchclickresult.995fc3agWKqFr#sku=yuncode1015200005
#
#  usage       :
#                python3 vin_search.rb
#
#  history     :
#            1. Date: 2018.01.16
#               Author:  cheenwe
#               Modification: 检索结果存储到 tmp 目录下
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

import urllib, urllib.request, json, os,  sys

host = 'http://jisuvindm.market.alicloudapi.com'
path = '/vin/query'
method = 'GET'
appcode = 'your appcode'
querys = 'vin=LSVAL41Z882104202'
bodys = {}

vin_file = "a.txt" # 请修改该文件名为存储 vin 列表名,

def write_file(vin, result):
    f=open(vin, 'w')
    f.write(str(result))
    f.close()

def write_tmp_file(vin, json_dict):
    tmp_file = "tmp/" + vin
    f=open(tmp_file, 'w')
    f.write(str(json_dict))
    f.close()

def request_vin(vin):
    querys = 'vin=' + vin
    url = host + path + '?' + querys
    request = urllib.request.Request(url)
    request.add_header('Authorization', 'APPCODE ' + appcode)
    response = urllib.request.urlopen(request)
    content = response.read()
    if (content):
        json_dict = json.loads(content)['result']

        result = json_dict['manufacturer'] + '\n' + json_dict['brand'] + '\n' + json_dict['cartype'] + '\n' + json_dict['yeartype'] + '\n' + json_dict['vin']

        write_file(vin, result)

        write_tmp_file(vin, json_dict)

def deal_vin(vin):
    if vin.strip() !='':
        print (vin)
        request_vin(vin)

if not os.path.exists("tmp"):
    os.mkdir("tmp")

file = open(vin_file)
while 1:
    line = file.readline()
    # print  line
    deal_vin(line)



