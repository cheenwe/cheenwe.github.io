#! -coding:utf8 -*-
# https://www.cnblogs.com/owasp/p/6413480.html

import threading, sys
import requests
import time
import os

class MulThreadDown(threading.Thread):
    def __init__(self, url, startpos, endpos, f):
        super(MulThreadDown, self).__init__()
        self.url = url
        self.startpos = startpos
        self.endpos = endpos
        self.fd = f

    def download(self):
        print("start thread: %s at %s" % (self.getName(), time.time() ))
        headers = {"Range": "bytes=%s-%s" % (self.startpos, self.endpos)}
        res = requests.get(self.url, headers=headers)
        self.fd.seek(self.startpos)
        self.fd.write(res.content)
        print("stop thread:%s at %s" % (self.getName(), time.time()))
    def run(self):
        self.download()

if __name__ == "__main__":
    url = sys.argv[1]
    filename = url.split('/')[-1]
    filesize = int(requests.head(url).headers['Content-Length'])
    print("%s filesize: %s" %(filename, filesize))

    threadnum = 8
    threading.BoundedSemaphore(threadnum)

    step = filesize // threadnum

    mtd_list = []
    start = 0
    end = -1


    # 请空并生成文件
    tempf = open(filename,'w')
    tempf.close()
    # rb+ ，二进制打开，可任意位置读写
    with open(filename,'rb+') as  f:
        fileno = f.fileno()
        # 如果文件大小为11字节，那就是获取文件0-10的位置的数据。如果end = 10，说明数据已经获取完了。
        while end < filesize -1:
            start = end +1
            end = start + step -1
            if end > filesize:
                end = filesize
            # print("start:%s, end:%s"%(start,end))
            # 复制文件句柄
            dup = os.dup(fileno)
            # print(dup)
            # 打开文件
            fd = os.fdopen(dup,'rb+',-1)
            # print(fd)
            t = MulThreadDown(url,start,end,fd)
            t.start()
            mtd_list.append(t)

        for i in  mtd_list:
            i.join()









