#!/usr/bin/python3
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : vin_search.rb
#  author      : chenwei
#  version     : 0.0.2
#  created     : 2018.09.18
#  description : 车架号VIN（车辆识别代码）信息查询, 读取 txt中 vin 并检索信息存储到 txt中
#                涉及: 文件读写, http 请求等.
#                阿里云购买接口: https://market.aliyun.com/products/56928004/cmapi013503.html?spm=5176.730006-56956004-57002002-cmapi016152/A.recommend.3.55a96fefJIJIlL#sku=yuncode750300000
#
#  usage       :
#                ruby vin_search.rb
#
#  history     :
#            1. Date: 2018.09.18
#               Author:  cheenwe
#               Modification: 检索结果存储到 tmp 目录下
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

require 'rest-client'
require 'json'

@url = "https://ali-vin.showapi.com/vin?vin="

@root_path = "/Users/chenwei/Library/Logs/cheliang_type_part5/"

@auth_header = 'APPCODE ' + 'your appcode'
@json_path = @root_path + "/json/"

#写文件
def write_file(file, data)
  File.open(file, 'w') do |file|
    file.write data
    file.close
  end
end

def check_dir(dir)
  unless File.directory?(dir)
    FileUtils.mkdir_p(dir)
  end
end

check_dir(@json_path)

def move_file(file, brand_name, manufacturer)
  source_file = @root_path + "pic/" + file
  dist_path = @root_path + "pic_result/#{brand_name}/#{manufacturer}/"
  check_dir(dist_path)
  FileUtils.cp source_file, dist_path
end

def search(file, vin)
  url = "#{@url}#{vin}"
  res  = RestClient.get url, {:Authorization => "#{@auth_header}"}
  data = JSON.parse(res.body)
  json_file = @json_path + file + ".json"
  write_file(json_file, data)
  p "write json success"

  #1类
  brand_name = data["showapi_res_body"]["brand_name"]
  #2类
  manufacturer = data["showapi_res_body"]["manufacturer"]

  move_file(file, brand_name, manufacturer)
  p "move brand_name #{brand_name}, #{manufacturer}    ok"

end



# search("test.jpg", "WDD1J4CB4JF056209")

csv_file = @root_path + "image_list.txt"

File.open(csv_file,"r") do |file|

    while line  = file.gets
        arr  = line.to_s.delete("\n").split(",") #打印出文件内容
        # file = arr[0]
        # vin = arr[1]
        # p arr[0]
        # p arr[1]
        search(arr[0], arr[1])
    end
end
