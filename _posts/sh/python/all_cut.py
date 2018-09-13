#coding = utf-8
import os

from PIL import Image

# 原图路径
path='/home/chenwei/workspace/图片切割/img'

# 切割后图片路径
new_path='/home/chenwei/workspace/图片切割/img_cuted'


def cut_file(img, info, file_name):
    region = im.crop(info)
    region.save(file_name)


for dirpath,dirnames,filenames in os.walk(path):
    for file in filenames:
            fullpath=os.path.join(dirpath,file)


            # 读图
            im =Image.open(fullpath)

            # img_size = im.size

            # 图一
            # print(img_size)
            x = 400
            y = 300
            w = 900
            h = 1832

            file1 = new_path + "/" + file+ "-1.jpg"
            info = (x, y, x+w, y+h)
            cut_file(im, info, file1)



            # 图2
            # print(img_size)
            x = 1300
            y = 300
            w = 900
            h = 1832
            file2 = new_path + "/" + file+ "-2.jpg"

            info = (x, y, x+w, y+h)

            cut_file(im, info, file2)

            # 图3
            # print(img_size)
            x = 2200
            y = 300
            w = 900
            h = 1832

            file3 = new_path + "/" + file+ "-3.jpg"
            info = (x, y, x+w, y+h)
            cut_file(im, info, file3)


