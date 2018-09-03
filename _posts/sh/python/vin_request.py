#!/usr/bin/python3
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : vin_request.py
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2018.01.16
#  description : 车架号VIN（车辆识别代码）信息查询
#
#  usage       :
#                python3 vin_search.py
#
#  history     :
#            1. Date: 2018.01.16
#               Author:  cheenwe
#               Modification: 检索结果存储到 tmp 目录下
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

import requests
from bs4 import BeautifulSoup

# 请更新 cookie
cookie = "PHPSESSID=v2tfeigbelnkbvm5s7ma28lovo; SearchType=vin; Hm_lvt_d6d66a78d863e895c324e752879449ea=1516086239,1516349923,1516349925,1516613629; Searchvin=LNBSCBAF5DR306555; token=aGtqMjAxOEBhMWE1ODQyNDg0OGJkODM0MTM4MjU3ZTdlNmI5ODAwMEAxNTE3MjIwMTI0; Hm_lpvt_d6d66a78d863e895c324e752879449ea=1516615436"


headers = {
          "Cookie":cookie,
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
          'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:22.0) Gecko/20100101 Firefox/22.0'}


r = requests.get('http://www.yiparts.com/vin?type=vin&keyword=LNBSCBAF5DR306559', headers=headers, timeout=3)

soup = BeautifulSoup(r.text, 'html.parser')

items = soup.find(attrs={'class':'MarkDiffTr'})

print(items)
