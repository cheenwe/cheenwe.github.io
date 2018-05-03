# 引入模块
from RestApi import RestApi

# 初始化
api = RestApi()

#  创建处理记录
#  api.create_record(name)
#    传入参数:
#         name:  2018-04-09 晴 上午
#     返回参数 : 14
api.create_record(100)


#  创建视频记录
#  api.create_video(id, name)
#
#    传入参数:
#         id: 处理记录 返回 id
#         name:  视频处理后文件夹名
#     返回参数 : 11
api.create_video(1, "上方视频")


#  写入文件记录
#  api.create_file(id, name)
#
#    传入参数:
#         id: 视频记录 返回 id
#         name:  文件名
#     返回参数 : 11
api.create_file(1, "上方视频")

