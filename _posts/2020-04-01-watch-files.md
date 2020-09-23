---
layout: post
title: 实时监控文件目录
tags: io 监控 
category: io
---

基于 inotify 实时监控目录下文件的状态


## 安装 inotify-tools

```
git clone  https://github.com/inotify-tools/inotify-tools.git
cd inotify-tools

sudo apt-get install -y autoconf autotools-dev  automake libtool

./configure
make
make install
```


## 基于 python 监控目录

pip3 install pyinotify

```
#coding:utf8

import os
import pyinotify, requests

WATCH_PATH = '/home/ftp/Cameras' #监控目录

def  request_file(file):
    res = requests.get("http://192.168.21.118:8531/camera_pics/record?picUrl="+file)
    print(res)

def  check_file(file):
    path ="/".join(file.split("/")[-4:]).strip()
    url = "http://192.168.9.10:81/"+path
    print(url)
    request_file(url)

if not WATCH_PATH:
  print('Error',"The WATCH_PATH setting MUST be set.")
  sys.exit()
else:
  if os.path.exists(WATCH_PATH):
    print('Watch status','Found watch path: path=%s.' % (WATCH_PATH))
  else:
    print('Error','The watch path NOT exists, watching stop now: path=%s.' % (WATCH_PATH))
    sys.exit()

class OnIOHandler(pyinotify.ProcessEvent):
  def process_IN_CREATE(self, event):
    print('Action',"create file: %s " % os.path.join(event.path,event.name))
    check_file(os.path.join(event.path,event.name))

  def process_IN_DELETE(self, event):
    print('Action',"delete file: %s " % os.path.join(event.path,event.name))

#  def process_IN_MODIFY(self, event):
#    print('Action',"modify file: %s " % os.path.join(event.path,event.name))

def auto_compile(path = '.'):
  wm = pyinotify.WatchManager()
  mask = pyinotify.IN_CREATE | pyinotify.IN_DELETE | pyinotify.IN_MODIFY
  notifier = pyinotify.ThreadedNotifier(wm, OnIOHandler())
  notifier.start()
  wm.add_watch(path, mask,rec = True,auto_add = True)
  print('Start Watch','Start monitoring %s' % path)
  while True:
    try:
      notifier.process_events()
      if notifier.check_events():
        notifier.read_events()
    except KeyboardInterrupt:
      notifier.stop()
      break

if __name__ == "__main__":
   auto_compile(WATCH_PATH)
```

- 监控数据发送到 MQ 及http请求中

```
#coding:utf8

import os, time, json
import pyinotify, requests
#from functions import *

from stompest.config import StompConfig
from stompest.protocol import StompSpec
from stompest.sync import Stomp

QUEUE = '/queue/ftp-camera-record-queue'
brokerUrl = 'tcp://192.168.7.151:61615'


request_url = "http://192.168.7.153:39802/notify/camera"
file_url = "https://www.baidu.com/img/flexible/logo/pc/result.png"


CONFIG = StompConfig(brokerUrl, StompSpec.VERSION_1_0)

client = Stomp(CONFIG)

MAXIMAL_RETRY = 20

def run_with_retry(times=0):
    time.sleep(2)
    try:
        client.connect()
    except Exception as e:
        if times >= MAXIMAL_RETRY:
            print(f'>> Exceed maximal retry {MAXIMAL_RETRY}, Raise exception...')
            raise(e) # will stop the program without further handling
        else:
            times += 1
            print(f'>> Exception, Retry {times} begins...')
            run_with_retry(times)

client.connect()


headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:54.0) Gecko/20100101 Firefox/54.0',
    "Content-Type": "application/json; charset=UTF-8", 
    'Connection': 'close'
}

def now_timestamp(digits = 13):
    time_stamp = time.time()
    digits = 10 ** (digits -10)
    time_stamp = int(round(time_stamp*digits))
    return time_stamp


def send_pic_request(pic_data,url): #定义页面解析的函数，返回值为json格式
    try:
        response=requests.post(url=url,headers=headers, data=pic_data, params=pic_data)
        print('-------------',response.status_code)
        #if response.status_code==200:
        #    return response.json()
    except requests.ConnectionError as e:
        print('Error',e.args)


def send_mq(msg="test"):
    client.send(QUEUE, msg.encode(), {StompSpec.RECEIPT_HEADER: str(msg)})
    frame = client.receiveFrame()
    print('resp: %s' % frame.info())

#send_mq("tes1t")


 
WATCH_PATH = '/home/ftp/Camera_Weather' #监控目录


def  request_file(file):
    res = requests.get("http://192.168.21.118:8531/camera_pics/record?picUrl="+file)
    print(res)

def  check_file(file):
    path ="/".join(file.split("/")[-4:]).strip()
    url = "http://192.168.9.10:8510/"+path
    print(url)
    #request_file(url)
    pic_data = "{'time': " + str(now_timestamp())+",'url': '"+ url +"' }"
    send_mq(pic_data)
    pic_data1={
    'time': now_timestamp(),
    'url': url,
    }

    send_pic_request(pic_data1,request_url)

if not WATCH_PATH:
  print('Error',"The WATCH_PATH setting MUST be set.")
  sys.exit()
else:
  if os.path.exists(WATCH_PATH):
    print('Watch status','Found watch path: path=%s.' % (WATCH_PATH))
  else:
    print('Error','The watch path NOT exists, watching stop now: path=%s.' % (WATCH_PATH))
    sys.exit()
 
class OnIOHandler(pyinotify.ProcessEvent):
  def process_IN_CREATE(self, event):
    print('Action',"create file: %s " % os.path.join(event.path,event.name))
    check_file(os.path.join(event.path,event.name))
 
  def process_IN_DELETE(self, event):
    print('Action',"delete file: %s " % os.path.join(event.path,event.name))
 
#  def process_IN_MODIFY(self, event):
#    print('Action',"modify file: %s " % os.path.join(event.path,event.name))
 
def auto_compile(path = '.'):
  wm = pyinotify.WatchManager()
  mask = pyinotify.IN_CREATE | pyinotify.IN_DELETE | pyinotify.IN_MODIFY
  notifier = pyinotify.ThreadedNotifier(wm, OnIOHandler())
  notifier.start()
  wm.add_watch(path, mask,rec = True,auto_add = True)
  print('Start Watch','Start monitoring %s' % path)
  while True:
    try:
      notifier.process_events()
      if notifier.check_events():
        notifier.read_events()
    except KeyboardInterrupt:
      notifier.stop()
      break
 
if __name__ == "__main__":
   auto_compile(WATCH_PATH)

```
