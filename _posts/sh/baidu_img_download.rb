#!/usr/bin/ruby

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : img_baidu_search.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.03.11
#  description : 根据关键字批量获取图片数据,存储为 JOSN 文件.
#                https://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&word=车牌号码&pn=1&rn=1
#  history     :
#               1. Date: 2017.03.11
#               Author:  cheenwe
#               Modification: 把识别数据存储成文件
#  history     :
#               2. Date: 2017.06.14
#               Author:  cheenwe
#               Modification: 把搜索的图片下载到目录下关键字文件夹
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

require "rest-client"
require "json"
require 'uri'
require 'pathname'

APP_ROOT = Pathname.new File.expand_path('../', __FILE__)

# 搜索接口
# KEY_WORD: 搜索关键字内容
# PER_PAGE: 每页数据量
# START_PAGE: 开始下载页码
# END_PAGE: 结束下载页码, 默认为0, 表示该关键字下数据全部下载
# MAX_SIZE: 下载最大数量,  默认为0, 表示该关键字下数据全部下载

KEY_WORD = "刘德华"
PER_PAGE = 30
START_PAGE = 0
END_PAGE = 2
MAX_SIZE = 0

# rn: 表示每页数据偏移量是60
# pn: 表示当前页数，偏移量是60，也就是说下一页 pn=120,180
def search_url(rn, pn)
  URI::escape("https://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&face=1&word=#{KEY_WORD}&rn=#{rn}&pn=#{pn}")
end

def request_url(url)
  RestClient::Request.execute(method: :get, url: url) rescue ''
end

# 获取总记录条数
def get_total_numbers
  result = request_url(search_url(1, 1))
  JSON.parse(result)["displayNum"]
end


# 创建文件夹
def create_down_folder
  if MAX_SIZE > 0
    @down_dir = "#{APP_ROOT}/BDownload/#{KEY_WORD}-#{MAX_SIZE}"
  else
    @down_dir = "#{APP_ROOT}/BDownload/#{KEY_WORD}-#{get_total_numbers()}"
  end
  FileUtils.mkdir_p @down_dir
end

def write_pic_file(url, directory, file_name)
    #   filename = SecureRandom.uuid.gsub('-', '') + '.jpg'
    filename = file_name + ".jpg"
    File.open(File.join(directory, filename), "wb") { |s|
      res = RestClient.get(url)
      s.write(res)
      s.close()
    } rescue ''
end

create_down_folder()

total_nums = get_total_numbers

i=0
p=0


if END_PAGE > 0
  (START_PAGE..END_PAGE).each do |page|
    p += 1
    puts "正在处理-----第 #{p} 页数据"
    result = request_url(search_url(PER_PAGE, page*PER_PAGE))
    JSON.parse(result)["data"].each_with_index do |list, index|
      write_pic_file(list["middleURL"], @down_dir, i.to_s)

      i += 1
      if MAX_SIZE != 0 && i >= MAX_SIZE
        puts "下载结束, 共下载 #{MAX_SIZE} 条数据"
        return
      end

    end
  end

else
  (START_PAGE..(total_nums/PER_PAGE).to_i).each do |page|
    p += 1
    puts "正在处理-----第 #{ p } 页数据"

    result = request_url(search_url(PER_PAGE, page*PER_PAGE))
    JSON.parse(result)["data"].each_with_index do |list, index|
      write_pic_file(list["middleURL"], @down_dir, i.to_s)
      i += 1
      if MAX_SIZE != 0 && i >= MAX_SIZE
        puts "下载结束, 共下载 #{MAX_SIZE} 条数据"
        return
      end
    end
  end

end
