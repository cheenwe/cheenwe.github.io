#!/usr/bin/python
# -*- coding:utf-8 -*-

import urllib

url = "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=632114496,1198208597&fm=23&gp=0.jpg"
local_file = "0.jpg"

def download_file(url, local_file):
    try:
        urllib.urlretrieve(url, local_file)    #按照url进行下载，并以其文件名存储到本地目录
    except Exception,e:
        print " downloading errors"


