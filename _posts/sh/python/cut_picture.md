## 功能

>根据标注工具标注完成的json 数据进行图片切割, 保存成多张图片.

```
import json, os
import cv2

# 处理后的数据文件目录
result_folder = "4_1"
# 放置原数据目录
images_folder = "images"
# 根路径
root_path = "/data/workspace/jingtai_静态手写数据/code1/"
# 标注好后的json路径
json_file = root_path + "模板_信用卡申请单据.jpg.json"


def check_download_dir(dir):
    if not os.path.exists(dir):
      os.makedirs(dir)
    pass

def one_json2roi(img_path, save_roi_path, json_file, save_roi_filename, mark_name):
    img = cv2.imread(img_path)
    with open(json_file, 'r') as json_f:
        data = json.load(json_f)
        obj = data['objects']
        i = 1
        for item in obj:
            print(item['rect'])
            roi_x, roi_y, roi_w, roi_h = [int(i) for i in item['rect']]
            roi_img = img[roi_y: roi_y + roi_h, roi_x: roi_x + roi_w]
            # name_id = mark_name+ "-" + str(31-i) #20-1
            # real_name = get_name_id(name_id)# 通过 20-1 获取 xx
            # print(real_name)
            save_path = save_roi_path + "/" + mark_name + "_" + str(i) +  ".jpg"
            # print(save_path)
            cv2.imwrite(save_path, roi_img)
            i = i+1

def get_chn_num(file, mark_name):
    '''
    保存roi
    '''
    img_path = root_path + images_folder+"/"+file
    # print(img_path)
    # print(json_file)
    save_roi_path =  root_path + result_folder

    check_download_dir(save_roi_path)

    one_json2roi(img_path, save_roi_path, json_file, file, mark_name)

# 循环原数据目录
movie_result_name = os.listdir(root_path + images_folder)

for file in movie_result_name:

    # print(file.split("(")[1].split(")")[0])
    mark_name = str(file.split(".")[0])
    print(mark_name)
    get_chn_num(file, mark_name)




```
