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

##################### =========== start  =========== #####################
## 这里是需要修改信息的地方
#CSV 文件所在路径
csv_file = "./test.csv" #"/Users/chenwei/Library/Logs/2(1).csv"
download_path = '/tmp/violation/test/' #下载的图片文件夹路径
new_csv = '/tmp/violation/test/import.csv'# 重新生成 csv 文件路径
ftp_host = "10.127.3.89" #ftp ip
ftp_prot = 21
ftp_timeout = 30
ftp_user ="picuser" #ftp 用户名
ftp_password ="picuser" #ftp 密码
buffer_size = 10240  #默认是8192
timeout = 10 #http请求超时设置
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

headers = {
'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36'
}

def checkFolder(folder):
    if not os.path.exists(folder):
        os.makedirs(folder)

checkFolder(download_path)


def downloadfile(ftp, remotepath, localpath):
    try:
        with open(localpath, "wb") as f:
            ftp.retrbinary('RETR {0}'.format(remotepath), f.write, buffer_size)
            f.close()
    except:
        print('savefail\t%s' % remotepath)

#  ftp.cwd(remotepath) # 设置FTP远程目录(路径)
#  list = ftp.nlst() # 获取目录下的文件,获得目录列表
#  for name in list:
#  print(name)
#  path = localpath + name # 定义文件保存路径
#  f = open(path, 'wb') # 打开要保存文件
#  filename = 'RETR ' + name # 保存FTP文件
#     ftp.set_debuglevel(0)         #关闭调试
#     f.close()                    #关闭文件

#http 下载
def download(img_url, img_name):
    if os.path.isfile(os.path.join(download_path, img_name)):
        return
    with closing(requests.get(img_url, stream=True, headers=headers, timeout=timeout)) as r:
        rc = r.status_code
        if 299 < rc or rc < 200:
            print('returnCode%s\t%s' % (rc, img_url))
            return
        content_length = int(r.headers.get('content-length', '0'))
        if content_length == 0:
            print('size0\t%s' % img_url)
            return
        try:
            with open(os.path.join(download_path, img_name), 'wb') as f:
                for data in r.iter_content(1024):
                    f.write(data)
        except:
            print('savefail\t%s' % img_url)
# 写csv数据
def write_file(data):
    with open(new_csv, 'a+') as f:
        writer = f.write(data+'\n')
    pass

# 处理违法时间
def check_vio_time(str="2019-05-26 11:09:05"):
    return str[0:10]+"#"+str[11:13]+"#"+str[14:16]+"#"+str[17:19]

# 处理单个图片,生成文件名
def check_file(file_arr):
    # print(file_arr)
    time = file_arr[6]
    last_num = '0'
    uid = file_arr[0]
    shebeibianhao = file_arr[1]
    address = file_arr[2]
    chepai = file_arr[3]
    chexing = file_arr[4]
    # weifadaima 1208
    weifadaima = file_arr[5]
    # weifashijian 违法时间
    weifashijian = check_vio_time(time)
    last_str = "@"+last_num

    file_name = str(shebeibianhao) + "_" + chepai+ "_" + weifadaima+ "_" + address + "_" + "02"+ "_0_" + "@"+str(uid)+"@@@" + weifashijian+ "_@"+ last_num + "_0"  +".jpg"

    return file_name

if __name__ == '__main__':
    # 开始 NB 的处理 ~~~
    # 0. 登录 FTP
    # 1. 读csv数据
    # 2. 拼接文件名
    # 3. 下载到指定路径

    ftp = ftpconnect(ftp_host, ftp_user, ftp_password)
    reader = csv.reader(open(csv_file,'r'))
    # print(reader)
    i = 0

    for row in reader:
        file_name  = check_file(row)
        img_url = row[7]
        # remotepath = img_url.split(ftp_host+":"+str(ftp_prot))[1]

        remotepath =  "/"+"/".join(img_url.split("/")[3:])

        new_file_name = os.path.join(download_path, file_name)
        print(str(i) +"处理中...., 路径: "+remotepath)
        if i > 1:
          download(ftp, img_url, new_file_name)
          data = row[0] + "," +row[1] + "," +row[2] + "," +row[3] + "," +row[4] + "," +row[5] + "," +row[6] + "," + new_file_name
          write_file(data)
        i = i+1

# read_csv(csv_file)
