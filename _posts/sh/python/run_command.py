#coding = utf-8
import os

output = os.popen('ls /tmp')
print(output.read())




# encoding:utf-8
import time, os
import sys
#sys.path
import subprocess


# 运行命令
def run_cmd(cmd):
	
	res = subprocess.Popen(cmd,
							shell=True,
							stdout=subprocess.PIPE,
							stderr=subprocess.PIPE,)
	return res

def push_video(file_name, uuid):
	url = "ffmpeg -re -i {0} -vcodec copy -codec copy -f rtsp rtsp://192.168.1.119:2554/{1}".format(file_name, uuid)
	print(url)
	shell_start = run_cmd(url)
	return shell_start

# run_shell("/home/pc/1234.mp4", "123")


# 检查某个进程个数
def check_pid(file_name):
	url = "ps aux |grep {0} |grep -v grep |wc -l".format(file_name)
	print(url)

	shell_start = run_cmd(url)
	
	return shell_start.stdout.read().decode("utf-8").strip()


# 杀掉进程
def kill_pid(file_name):
	str = "ps aux |grep '{0}'".format(file_name)
	str1 = str + "|grep -v grep|awk '{print $2}'"
	url = "kill -9 $({0})".format(str1)
	print(url)
	shell_start = run_cmd(url)
	return shell_start



# 杀掉获取目录下某个后缀的文件列表
def check_folder_files(folder, file="jpg", ):
	file_arr = []
	g = os.walk(folder)
	for path, d, filelist in g:
		for filename in filelist:
			if filename.endswith(file):
				file_arr.append(os.path.join(path, filename))
	return file_arr


