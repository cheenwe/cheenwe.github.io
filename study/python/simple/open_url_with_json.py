#!/usr/bin/python
# -*- coding:utf-8 -*-

import urllib2
import json

inputURL = "https://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&ct=201326592&is=&fp=result&queryWord=%E6%98%9F%E7%A9%BA&cl=2&lm=-1&ie=utf-8&oe=utf-8&adpicid=&st=-1&z=&ic=0&word=%E6%98%9F%E7%A9%BA&s=&se=&tab=&width=&height=&face=0&istype=2&qc=&nc=1&fr=&pn=30&rn=30&gsm=1000000001e&1493082617269="

html = urllib2.urlopen(inputURL)

hjson = json.loads(html.read())

print hjson
print hjson['data']
