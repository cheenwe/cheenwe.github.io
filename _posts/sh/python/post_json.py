#!/usr/bin/python3
# post json api
import time, json

import requests

url = "http://192.168.1.11/notify/"
file_url = "https://www.baidu.com/img/flexible/logo/pc/result.png"
# pic_data_condition=json.loads(pic_data)


def now_timestamp(digits = 13):
    time_stamp = time.time()
    digits = 10 ** (digits -10)
    time_stamp = int(round(time_stamp*digits))
    return time_stamp

t = now_timestamp()
print(t)


pic_data={
    'time': now_timestamp(),
    'url': file_url,
}

head = {"Content-Type": "application/json; charset=UTF-8", 'Connection': 'close'}

def send_pic_request(pic_data,url): #定义页面解析的函数，返回值为json格式
    try:
        response=requests.post(url=url, header=head, data=pic_data)
        if response.status_code==200:
            return response.json()
    except requests.ConnectionError as e:
        print('Error',e.args)

send_pic_request(pic_data,url)



