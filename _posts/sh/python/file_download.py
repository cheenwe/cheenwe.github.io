# -*- coding: utf-8 -*-
import os
from contextlib import closing
import threading
import requests
import time


headers = {
'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36'
}

#输出文件夹
out_dir = './output'
#线程数
thread_num = 20
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

def get_imgurl_generate():
    with open('./final.scp', 'r') as f:
        index = 0
        for line in f:
            index += 1
            if index % 500 == 0:
                print 'execute %s line at %s' % (index, time.time())
            if not line:
                print ur'line %s is empty "\t"' % index
                continue
            line = line.strip()
            try:
                imgs = line.split('\t')
                if len(imgs) != 2:
                    print ur'line %s splite error' % index
                    continue
                if not imgs[0] or not imgs[1]:
                    print ur'line %s img is empty' % index
                    continue
                yield imgs
            except:
                print ur'line %s can not split by "\t"' % index


lock = threading.Lock()
def loop(imgs):
    print 'thread %s is running...' % threading.current_thread().name

    while True:
        try:
            with lock:
                img_url, img_name = next(imgs)
        except StopIteration:
            break
        try:
            download(img_url, img_name)
        except:
            print 'exceptfail\t%s' % img_url
    print 'thread %s is end...' % threading.current_thread().name

img_gen = get_imgurl_generate()

for i in range(0, thread_num):
    t = threading.Thread(target=loop, name='LoopThread %s' % i, args=(img_gen,))
    t.start()
