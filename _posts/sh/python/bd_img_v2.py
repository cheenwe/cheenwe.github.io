
import requests
import json
import re
import os
import sys
cwd = os.getcwd()
sys.path.append(cwd)
print(cwd)
url = 'https://image.baidu.com/search/acjson'
headers = {
    'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36',
}
params = {
    'tn':'resultjson_com',
    'ipn':'rj',
    'ct':'201326592',
    'fp':'result',
    'queryWord':'abc', # 需要搜索的关键字
    'word':'abc', # 需要搜索的关键字
    'width':'', # 宽度筛选
    'height':'', # 高度筛选
    'pn':'30', # 第120个是末尾
    'rn':'30', # 一次加载30个
}

########## 文件相关 ##########
def file_write(file_path, content, mode='a', encoding='utf8'):
    '''
    1. 作用:创建文件并把content的内容写入到文件file_path中
    2. 参数:
        file_path:文件路径
        content:文件写入的内容
        mode:文件读写的模式,默认为'w'
        encoding:文件编码,默认为'utf8'
    3. 返回值:None
    '''
    f = open(file=file_path, mode=mode, encoding=encoding)
    f.write(content)
    f.close()
def folder_exist(dir_path):
    '''
    1. 作用:判断文件夹路径是否存在,不存在则创建
    2. 参数:dir_path:文件夹路径
    3. 返回值:None
    '''
    if not os.path.exists(dir_path):
        os.makedirs(dir_path)
#http请求超时设置
timeout = 10
#下载
def DownloadFile(img_url, dir_name, img_name):
    # check_download_dir(folder_name)
    try:
        with closing(requests.get(img_url, stream=True, headers=headers, timeout=timeout)) as r:
            rc = r.status_code
            if 299 < rc or rc < 200:
                print('returnCode%s\t%s' % (rc, img_url))
                return
            content_length = int(r.headers.get('content-length', '0'))
            if content_length == 0:
                print('size0\t%s' % img_url)
                # return
            try:
                with open(os.path.join(dir_name, img_name), 'wb') as f:
                    for data in r.iter_content(1024):
                        f.write(data)
            except:
                # print('save fail \t%s' % img_url)
                log.error('save fail \t%s' % img_url, exc_info=True)
    except:
        # print('requests fail \t%s' % img_url)
        log.error('requests fail \t%s' % img_url, exc_info=True)


if __name__ == '__main__':
    cloud_type = ['絮状高积云','透光高积云','荚状高积云','积云性高积云','蔽光高积云',
    '堡状高积云','透光高层云','蔽光高层云','伪卷云','密卷云',
    '毛卷云','钩卷云','卷积云','匀卷层云','毛卷层云',
    '雨层云','碎雨云','碎积云','浓积云','淡积云',
    '鬃积雨云','秃积雨云','碎层云','层云','透光层积云',
    '荚状层积云','积云性层积云','蔽光层积云','堡状层积云',] #关键字
    base_dir = '/home/ubuntu/workspace/cloud_type1' # 存放图片的文件夹

    folder_exist(base_dir)
    for cloud_index in range(len(cloud_type)):
        count = 0
        word = cloud_type[cloud_index]
        params['queryWord'] = word
        params['word'] = word
        file_name = base_dir + '/' + str(cloud_index+1) + '.csv'
        for i in range(1, 1001):
            params['pn'] = str(30*i)
            response = requests.get(url=url, headers=headers, params=params)
            response.encoding = 'utf8'
            # print(response.status_code)
            # print(response.text)
            pattern1 = '"thumbURL":"(.*?)",'
            list_img_url = re.findall(pattern1, response.text)
            # 判断是否还有图片，没有图片则结束程序
            if not list_img_url:
                break

            pattern2 = '"fromPageTitleEnc":"(.*?)",'
            list_img_desc = re.findall(pattern2, response.text)
            for j in range(len(list_img_url)):
                count += 1
                img_name = str(cloud_index+1) + '_' + str(count) + '.jpg'
                content = img_name + ',' + list_img_desc[j].replace(',', '，') + ',' + list_img_url[j] + '\n'
                print(content)
                file_write(file_name, content, 'a')
