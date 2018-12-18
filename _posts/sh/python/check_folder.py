# -*- coding: utf-8 -*-

# 输入文件夹路径，将此文件夹下所有的空文件夹和空文件删除

import os

def check_folder(file):
    print('check at:', file)
    if os.path.isdir(file):  # 如果是文件夹
        if not os.listdir(file):  # 如果子文件为空
            os.rmdir(file)  # 删除这个空文件夹
            print('rm tmp dir success:', file)
    elif os.path.isfile(file):  # 如果是文件
        if os.path.getsize(file) == 0:  # 文件大小为0
            os.remove(file)  # 删除这个文件
    pass

def check_temp_path(path):
    files = os.listdir(path)  # 获取路径下的子文件(夹)列表
    for file in files:
        print('check at:', file)
        check_folder(file)

        path1 = path + "/" + file
        file = os.listdir(path1)  # 获取子文件(夹)下二级文件夹列表
        for f1 in file:
            print('check f1 at:', f1)
            abs_path = path1 + "/" + f1
            check_folder(abs_path)

            # for f2 in f1:
            #     print('check at:', f2)
            #     check_folder(f2)

    print (path, 'Dispose over!')


check_temp_path("/home/chenwei/workspace/renlian/shijijiayuan/0917_read_photo/output")
