# -*- coding: utf-8 -*-
import os
from contextlib import closing
import requests
import time


headers = {
'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36'
}

#输出文件夹
out_dir = './output'
#http请求超时设置
timeout = 5

if not os.path.exists(out_dir):
    os.mkdir(out_dir)



def download(img_url, img_name):
    if os.path.isfile(os.path.join(out_dir, img_name)):
        return
    with closing(requests.get(img_url, stream=True, headers=headers, timeout=timeout)) as r:
        rc = r.status_code
        if 299 < rc or rc < 200:
            print 'returnCode%s\t%s' % (rc, img_url)
            return
        content_length = int(r.headers.get('content-length', '0'))
        if content_length == 0:
            print 'size0\t%s' % img_url
            return
        try:
            with open(os.path.join(out_dir, img_name), 'wb') as f:
                for data in r.iter_content(1024):
                    f.write(data)
        except:
            print 'savefail\t%s' % img_url

