#!/usr/bin/python3
#coding = utf-8

import os, sys
import  requests

host_ip="192.168.50.75:4001/"

#cmd ="ssh "+ sys.argv[1]  +" nvidia-smi -q | grep 'Gpu' | cut -d ':'  -f 2|awk '{print $1}'"

host = 'http://'+ str(host_ip)

def send_request(ip, data):
    d = {'ip': ip, 'data': data}
    print(d)
    r = requests.post(host + 'api/v1/gpu', data=d)

def send_data(current_ip, data):
    print(data)
    try:
        send_request(current_ip, data)
    except Exception as e:
        print("api request fail: %s", format(e)) # 接口请求error

def run_coomand(cmd):
    output = os.popen(cmd)
    res = output.read()
    return res

def check_free_gpu(cmd):
    res = run_coomand(cmd)
    #print(res)
    gpu_arr = res.split("\n")
    #print(gpu_arr)
    i = 0
    list=[]
    for usage in gpu_arr:
     i =i+1
     #print(usage)
     if usage == '0':
      #print(i)
      list.append(i)
    return ','.join(str(x-1) for x in list)


def new_cmd(pc):
    return "ssh "+ pc  +" nvidia-smi -q | grep 'Gpu' | cut -d ':'  -f 2|awk '{print $1}'"

for ip in "compute01", "compute02", "compute03", "192.168.30.40":
    cmd = new_cmd(ip)
    res = check_free_gpu(cmd)
    print(ip, res)
    send_data(ip, res)
