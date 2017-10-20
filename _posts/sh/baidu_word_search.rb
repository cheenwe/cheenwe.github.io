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
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

require "rest-client"
require "json"
require 'uri'

PER_PAGE = 10
start_page=1
end_page=4
KEY_WORD="津贴"

# 搜索接口
# KEY_WORD: 搜索关键字内容
# rn: 表示每页数据偏移量是60
# pn: 表示当前页数，偏移量是60，也就是说下一页 pn=120,180

# https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=2&tn=baiduhome_pg&rsv_spt=1


# https://www.baidu.com/s?wd=%E6%B4%A5%E8%B4%B4&pn=100&oq=%E6%B4%A5%E8%B4%B4&tn=baiduhome_pg&ie=utf-8&usm=2&rsv_idx=2&rsv_pq=899e6c5000002f5c&rsv_t=18f2WUXMpooOvDQY0TEM4aMdmNxhG9fjr1z82OB6M%2B%2FyPXOJ9pVwMQXczw13N%2Bc5waYS


def search_url(rn, pn)
  URI::escape("https://www.baidu.com/s?wd=#{KEY_WORD}&pn=#{pn}&rsv_bp=1&rsv_idx=2&tn=baiduhome_pg&rsv_spt=1")
end

def request_url(url)
  RestClient::Request.execute(method: :get, url: url,
    :cookies => {
      # :USRANIME =>'usrmdinst_46',
    }
  )
end

# # 获取总记录条数
# def get_total_numbers
#   result = request_url(search_url(1, 1))
#   JSON.parse(result)["displayNum"]
# end

# total_size_nums = get_total_numbers()

list_arrary = []
i=0
(start_page..(total_size_nums/PER_PAGE).to_i).each do |page|

  result = request_url(search_url(PER_PAGE, page*PER_PAGE))

  JSON.parse(result)["data"].each_with_index do |list, index|
    list_arrary << {
      width: list["width"],
      height: list["height"],
      url: list["middleURL"],
      }
  end
  i = i+1
  puts "正在处理-----第 #{i} 条数据"
end

aFile = File.new("#{KEY_WORD}_#{total_size_nums}_#{Time.now.to_i}.json",  "w+")

aFile.syswrite(list_arrary)

aFile.close
