#coding=utf-8
# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2019 cheenwe.
#  filename    : check_and_rename.py
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2019-06-26
#  description : 自动处理文件脚本
#
#  history     :
#
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #

import time
import os
import shutil

# 功能:
# 1. 将所有图片生成使用csv文件存储映射关系
# 2. 根据文件名进行重命名

#要求：
# 严格按照脚本中目录名存放文件夹，
# csv结果：  /tmp/record-0.csv

# 定义要处理文件所在目录
root_folder ="/tmp/20190606"

# 处理后文件夹所在目录,
res_folder ="/tmp/20190606_ok/"

# # 要处理文件所在目录目录结构:
# 20190606/
# ├── 电警
# │   ├── 东高新三路东往西方向2
# │   │   ├── 1208
# │   │   └── 1625
# │   ├── 东中东路东往西方向1
# │   │   ├── 1208
# │   │   └── 1625
# │   ├── 文兴路东往西方向1
# │   │   ├── 1208
# │   │   └── 1625
# │   └── 交警支队门口南往北方向2
# │       └── 1208
# └── 卡口
#     ├── 公安局门前路段东往西方向3
#     │   ├── 1223
#     │   └── 1240
#     ├── 西路育才路口卡口东往西1
#     │   ├── 1223
#     │   └── 1240
#     └── 南卡口南往北内车道
#         ├── 1223
#         └── 1240


def checkFolder(folder):
    if not os.path.exists(folder):
        os.makedirs(folder)

checkFolder(res_folder)

# 定义图片list,生成list
file_arr = []
def check_folder_files(folder, file="jpg", ):
    g = os.walk(folder)
    for path, d, filelist in g:
        for filename in filelist:
            if filename.endswith('jpg'):
                file_arr.append(os.path.join(path, filename))
    return file_arr

# 写csv数据
def write_file(data):
    with open("/tmp/record-0.csv", 'a+') as f:
        writer = f.write(data+'\n')
        #先写入columns_name
    pass

deal_files = check_folder_files(root_folder)
print(deal_files)

# 定义一个函数，查找某个元素的下标，若是不存在则返回-1.
# 返回地址下标
def find_number(str):
    i=0
    index=-1
    for item in device_address_arr:
        if str == item :
            index=i
        i=i+1
    return index

device_address_arr = []

# # 处理地址数组,传入地址，返回设备编号
# def check_device_no(str="xxx"):
#     if str in device_address_arr:
#         return find_number(str)
#     else:
#         device_address_arr.append(str)
#         return find_number(str)

address_dict = {"东环大道高新三路东往西方向2": '000001', "东环大道文兴路东往西方向1": '000006', "东环大道潭中东路东往西方向1": '000007', "学院路交警支队门口南往北方向2": '000008', "屏山大道箭盘路口西往东方向1": '000009', "柳太路潭中西路东往西方向1": '000010', "潭中东路海关路口东往西方向": '000011', "潭中西路西环路口东往西方向1": '000012', "荣军路银桐路路口南往北方向2": '000013', "文惠桥南卡口南往北内车道(人脸)": '000014', "柳州市公安局门前路段东往西方向3": '000015', "潭中西路育才路口卡口东往西1": '000016', "弯塘路公园小学门口南往北方向": '000017', "柳石路第六中学门口南往北方向": '000018', "文惠桥南卡口南往北内车道": '000019', "友谊路卡口东往西方向3": '000020' }

def check_device_no(str):
    try:
        return address_dict[str]
    except Exception as e:
        return '0000999'


# 定义一个函数，查找某个元素的下标，若是不存在则返回-1.
# check_device_no("定义")
# check_device_no("定义1")
# check_device_no("定义1")
# check_device_no("定义")
# check_device_no("定义2")
# check_device_no("定义")
# check_device_no("定义3")

# 处理违法时间
def check_vio_time(str="20190526110905"):
    return str[0:4]+"-"+str[4:6]+"-"+str[6:8]+"#"+str[8:10]+"#"+str[10:12]+"#"+str[12:14]

# s = check_vio_time()
# print(s)

# 处理单个图片
def check_file(file, uid):
    file_arr = file.split("/")
    address = file_arr[4]
    file_name_arr = file_arr[7].split(".")[0].split("_")
    print(file_arr)
    print(file_name_arr)
    time = file_name_arr[0]

    last_num = file_name_arr[3]

    # shebeibianhao 东高新三路东往西方向2
    shebeibianhao = check_device_no(address)
    # chepai ok
    chepai = file_name_arr[1]
    # weifadaima 1208
    weifadaima = file_arr[5]
    # weifashijian 违法时间
    weifashijian = check_vio_time(time)
    # @x
    last_str = "@"+last_num

    new_file = str(shebeibianhao) + "_" + chepai+ "_" + weifadaima+ "_" + ""+ "_" + "02"+ "_0_" + "@"+str(uid)+"@@@" + weifashijian+ "_@"+ last_num + "_0"  +".jpg"
    return new_file

# 000019_桂0007_1240_000019_2_0_@7758@@@_a1_0

# print(files)

# f = '/violation/20190606/卡口/南卡口南往北内车道/1240/不系安全带/20190526223419_桂000057_不系安全带_1.jpg'


i = 1
for f in deal_files:
    new_file_name = check_file(f, i)
    data = str(i)+ "," + f + "," + new_file_name
    write_file(data)
    target_file = res_folder +"/" + new_file_name
    shutil.copy(f,  target_file)
    i=i+1

# write_file(device_address_arr) #bug ~~
