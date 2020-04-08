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
    url = "http://192.168.90.10:81/"+path
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
