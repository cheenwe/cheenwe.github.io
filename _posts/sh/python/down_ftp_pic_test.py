#coding=utf-8
# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2019 cheenwe.
#  filename    : down_ftp_pic.py
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2019-07-02
#  description :  下载 ftp 链接文件
#
#  history     :
#
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #
import os, time, shutil, csv
from contextlib import closing

from ftplib import FTP
import os

import sys
# reload(sys)
# sys.setdefaultencoding('utf-8')

##################### =========== start  =========== #####################
## 这里是需要修改信息的地方
#CSV 文件所在路径
ftp_host = "192.168.50.10" #ftp ip
ftp_prot = 21
ftp_timeout = 30
ftp_user ="user" #ftp 用户名
ftp_password ="user" #ftp 密码
buffer_size = 10240  #默认是8192
timeout = 2 #http请求超时设置
#####################
##################### =========== end  =========== #####################

# 'ftp://picuser:picuser@10.127.3.89:21/dahua/20190305/341202000000010022/170720-22803-bind.jpg'

def ftpconnect(host, username, password):
    ftp = FTP() # 设置变量
    timeout = ftp_timeout
    port = ftp_prot
    ftp.connect(host, port, timeout) # 连接FTP服务器
    ftp.login(username,password) # 登录
    return ftp

def DownLoadFile(ftp, RemoteFile,  LocalFile):  # 下载当个文件
    # file_handler = open(LocalFile, 'wb')
    # # print(ftp)
    # # self.ftp.retrbinary("RETR %s" % (RemoteFile), file_handler.write)#接收服务器上文件并写入本地文件
    # ftp.retrbinary('RETR ' + RemoteFile, file_handler.write)
    # file_handler.close()

    try:
        with open(LocalFile, "wb") as f:
            ftp.retrbinary('RETR {0}'.format(RemoteFile), f.write, buffer_size)
            f.close()
    except:
        print('savefail\t%s' % RemoteFile)

if __name__ == '__main__':
    ftp = ftpconnect(ftp_host, ftp_user, ftp_password)
    print(ftp)

    img_url = "1.jpg"
    DownLoadFile(ftp, img_url, "/Users/chenwei/workspace/work/1.jpg")

