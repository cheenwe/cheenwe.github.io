#coding=utf-8
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2019 cheenwe.
#  filename    : baidu_ai_ocr.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2019.06.27
#  description : 根据百度OCR结果修改文件名.
#
#  history     :
#               1. Date: 2017.03.11
#               Author:  cheenwe
#               Modification: 把识别数据存储成文件
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#!/usr/bin/python
from aip import AipOcr
import time
import os

""" 你的 APPID AK SK """

APP_ID = "15995762"
API_KEY = "77l2n4AhcyCDBefdxz8gvofo"
SECRET_KEY = "SnjB4lsHe0IjwrOygAZPk51fnD8v7WXd"

L_id = [["11251755", "yGxZfkXBADO4GSqu45UUYtEO", "oFGYEoqXCl0Al5GbQkNjrWURGGomYAKF"],
        ["14558774", "XUjxnyLurAtq1VqRC1tkvqvB", "vAzSvyyNvwTrE1ZdYGgoac9STrGW9Gbk"],
        ["14558623", "gyyZqcqvgASVfU1M01sKUGuK", "Hm2yhe3XIvNq2YtLw5vrsqHOCz9v1guC"],
        ["14558656", "ARwQ0RloVgcSVSZlKH3W0L3B", "grRXr8ViHTdpgNAksZvkOwu3N6WgFfYP"],
        ["14558705", "CwOiX1VRrX4ueA9g0XoklAjo", "PCGoZG5DCPTGZ85IdW9RHmBwQzmnbHM9"],
        ["14391307", "8U3loMb3xqvsDzX1WSOogQiE", "LKGsGR5zwknwtq83uWhi5SgKZ8mnafB6"],
        ["14559968", "q2R7RHpqNZG0wzcogBUO67T7", "r18WRtGttCMOPG70zHelPuxDcenG1Qyg"],
        ["14560105", "KX7QtFLNTkfQbaR5e9kZGw7c", "SHSD7en7wgbz5Po6Gb85GwqwcnNakMtG"],
        ["14561611", "6oYssZPLKFXr2FGbMIGZEvq0", "7oOT1IQ25un9eIvTRpiDzdUb67U0ulhm"],
        ["14563236", "Lb0a3XQgHaUWemWXGwueBLY1", "iD88xE8NN1hHGEOImshrv4nBO3psvj76"],
        ["14306795", "uAvAe3EA6wyrWFGdO5B9ifHH", "FEbg7djDxOojRlEyzWgS0igjKHSdsOto"],
        ["11251755", "yGxZfkXBADO4GSqu45UUYtEO", "oFGYEoqXCl0Al5GbQkNjrWURGGomYAKF"],
        ["14557197", "cHY1O4pGBeGMas6mxYzoQK1U", "QhDDtg8nzcWeyIdccOXI15jaBlPwzPRS"],
        ["14310442", "RhDWkPAPo26Xnhy2GZlKb4ma", "kzR1QbkWyfNGoqQkEoNMW19CMduHsiIO"],
        ["14374610", "fioGkSgNAYwRu7SoHDlyVILc", "PlV3agNn5Amp5MRZGMlZvcYifjfkFjfZ"],
        ["14558616", "EuoOxV1tMDBXe5rFhNfFvw93", "zW5ZN6jRjkdvGsjLVyl18MKMyRSok8Mb"],
        ["14563626", "35lcdq7pYbLg5GwnijGPq77S", "hd3UNhEdE7cpLtGWGvoKckNZKTz1gTOf"],
        ["15995762", "77l2n4AhcyCDBefdxz8gvofo", "SnjB4lsHe0IjwrOygAZPk51fnD8v7WXd"]]

# client = AipOcr(APP_ID, API_KEY, SECRET_KEY)
L_id_idx = 0
client = AipOcr(L_id[L_id_idx][0], L_id[L_id_idx][1], L_id[L_id_idx][2])

""" 读取图片 """


def get_file_content(filePath):
    with open(filePath, 'rb') as fp:
        return fp.read()


def ocr_file(file):
    image = get_file_content(file)
    """ 调用通用文字识别, 图片参数为本地图片 """
    global client
    global L_id_idx
    res = client.basicGeneral(image)
    #print(res)
    # print(res['words_result'][0]['words'])

    if (True == ('error_code' in res)):
        error_code = res['error_code']
        if (18 == error_code):
            print("warn::: Open api daily request limit reached")
            L_id_idx += 1
            client = AipOcr(L_id[L_id_idx][0], L_id[L_id_idx][1], L_id[L_id_idx][2])
            res = client.basicGeneral(image)

    try:
        ocr_res = res['words_result'][0]['words']
    except:
        ocr_res = "0"

    return ocr_res


file_arr = []


def check_folder_files(folder, file="jpg", ):
    g = os.walk(folder)
    for path, d, filelist in g:
        for filename in filelist:
            if filename.endswith('jpg'):
                file_arr.append(os.path.join(path, filename))
    return file_arr


files = check_folder_files("/media/data_2/everyday/0614/2222/2~10")
#print(files)

cnt = 0
for file in files:
    cnt += 1
    current_path = os.path.dirname(file)
    current_file = os.path.basename(file)
    file_name = current_file.split(".")[0]  # 文件名
    file_abbr = "." + current_file.split(".")[1]  # 文件后缀

    # print(file)
    ocr_name = ocr_file(file)
    print("账号%d ::: 识别计数=%d ::: 识别结果=%s"%(L_id_idx,cnt,ocr_name))
    ocr_name = ocr_name.replace('/','@')

    # 未识别， 后面添加 _err
    if ocr_name == "0":
        new_file_name = file_name + "_err" + file_abbr
    else:
        # C:\Users\chenwei\Desktop\test\716_646人型.jpg
        # 一致， 后面添加 .jpg
        if current_file.split(".")[0].split("_")[1] == ocr_name:
            new_file_name = file_name + "_ok" + file_abbr
        else:
            new_file_name = file + "_" + ocr_name + "_check" + file_abbr

    new_file = current_path + os.sep + new_file_name  # new_file = current_path +"\\" + new_file_name
    os.rename(file, new_file_name)
    time.sleep(0)
# print(file)
# print(ocr_name)

## 1. python 遍历目录下全部图片：
## 2. python 获取文件名，获取识别结果，
## 3. 改名
# os.rename(os.path.join(path,file),os.path.join(path,str(count)+".jpg"))

