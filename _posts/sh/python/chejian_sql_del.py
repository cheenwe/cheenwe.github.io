#!/usr/bin/python3
#coding=utf-8
import time, os, shutil

# 源数据目录
root_folder = "/home/ubuntu/Desktop/test"

# 处理完成文件夹
check_ok_folder =  root_folder + "/ok/"


""" 读取图片 """
def get_file_content(filePath):
    with open(filePath, 'rb') as fp:
        return fp.read()
file_arr = []


def check_folder_files(folder, file="jpg"):
    g = os.walk(folder)
    for path, d, filelist in g:
        for filename in filelist:
            if filename.endswith(file):
                file_arr.append(os.path.join(path, filename))
    return file_arr



def checkFolder(folder):
    if not os.path.exists(folder):
        os.makedirs(folder)

checkFolder(check_ok_folder)

# 运行命令
def run_coomand(cmd):
    output = os.popen(cmd)
    res = output.read()
    return res

# 搜索文件中某项字符串出现的行数
def search_file_str_num(file, search_str):
    cmd =  "grep -n '"+ search_str +"' " + file + "|cut -d ':' -f 1"
    print(cmd)
    res = run_coomand(cmd)
    print(res)
    gpu_arr = res.split("\n")
    print(gpu_arr)
    i = 0
    list=[]
    for usage in gpu_arr:
     i =i+1
     #print(usage)
     if usage != '':
      #print(i)
      list.append(usage)
    return list


# [~/Desktop]$ grep -n 'LOCK TABLES' /home/ubuntu/Desktop/test/vehicle_2018-01-21.sql

# 98:LOCK TABLES `vehicle_checks` WRITE;
# 105:UNLOCK TABLES;
# 161:LOCK TABLES `check_infos` WRITE;
# 166:UNLOCK TABLES;

# 将文件中某些行删除并输出到新文件中
def del_line_gen_new_file(str, file, new_file):
    # sed "${del_start_num},${del_end_num}d" "${file_name}".copy > "${file_name}".sql
    cmd =  'sed "' + str + '" ' + file +" > " + new_file
    print(cmd)
    run_coomand(cmd)

testarr = ['98', '105', '161', '166']

# 根据文件中字符出现的行数 list， 判断哪些行需要删除
def check_del_str(arr=testarr):
    i=0
    return "1,"+str(int(testarr[0])-1)+"d;"+str(int(testarr[1])+1)+","+str(int(testarr[2])-1)+"d" #  "1,97d;106,160d"


# 1. 处理单个文件
# 2. 找到要删的行
# 3. 生成要删除列表
# 4. 输出到新文件


def deal_one_sql(file, new_file):
    del_line_arr = search_file_str_num(file, "LOCK TABLES")
    print(del_line_arr)
    del_line_str = check_del_str(del_line_arr)
    print(del_line_str)
    del_line_gen_new_file(del_line_str, file, new_file)
    pass

file_lists = check_folder_files(root_folder, "sql")

print(file_lists)

for file in file_lists:
    # print(file)
    current_path = os.path.dirname(file)
    # print(current_path)
    current_file = os.path.basename(file)
    new_file = check_ok_folder + current_file

    deal_one_sql(file, new_file)

cmd = "cat " + check_ok_folder +"*.sql > " + check_ok_folder +"/all.sql"
# cat *.sql > ../all.sql

run_coomand(cmd)
