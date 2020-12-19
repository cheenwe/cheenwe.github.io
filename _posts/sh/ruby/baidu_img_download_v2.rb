#!/usr/bin/ruby
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : img_baidu_search.rb
#  author      : chenwei
#  version     : 0.0.3
#  created     : 2017.03.11
#  description : 根据关键字批量下载百度图片数据,存储到脚本目录DBdownload文件夹, 适用于机器学习数据收集等.
#                https://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&word=车牌号码&pn=1&rn=1
#
#  install     :
#                sudo apt install ruby2.3-dev
#                sudo chmod -R 777 /var/lib/gems/2.3.0
#                sudo chmod -R 777 /usr/local/bin
#                gem install rest-client
#
#  usage       :
#                ruby bd_image_download.rb
#
#  history     :
#               1. Date: 2017.03.11
#               Author:  cheenwe
#               Modification: 把识别数据存储成文件
#
#  history     :
#               2. Date: 2017.06.14
#               Author:  cheenwe
#               Modification: 把搜索的图片下载到目录下关键字文件夹
#
#  history     :
#               3. Date: 2018.01.12
#               Author:  cheenwe
#               Modification: 添加安装及使用说明ß及修改下载空图片
#               Notice: 设置下载最大数量时每页会少下载一条数据, 如: 最大数量100, 每页10条, 实际下载91条
#  history     :
#               4. Date: 2020.07.07
#               Author:  cheenwe
#               Modification: 支持下载多个关键字, 多线程下载, 随机生成文件名
#               Notice:
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

require "rest-client"
require "json"
require 'uri'
require 'pathname'
require 'thread'
require 'date'


APP_ROOT = Pathname.new File.expand_path('../', __FILE__)


# 搜索接口
# key_word: 搜索关键字内容
# PER_PAGE: 每页数据量
# START_PAGE: 开始下载页码
# END_PAGE: 结束下载页码, 默认为0, 表示该关键字下数据全部下载
# MAX_SIZE: 下载最大数量,  默认为0, 表示该关键字下数据全部下载
# FACE: 是否带人脸,默认0: 不带(同百度搜索结果),  1: 带

PER_PAGE = 60
START_PAGE = 0
END_PAGE = 0
MAX_SIZE = 500
FACE = 0

# THREAD_NUM: 开辟的线程数
THREAD_NUM = 10

# 搜索关键字内容 空格分隔
KEY_WORD = %w(油罐车侧面 油罐车正面  油罐车全身照 油罐车整车图 油罐车半挂)

$queue = Queue.new
threads = []



def search_url(key_word, rn, pn, face=0)
  URI::escape("https://image.baidu.com/search/acjson?tn=resultjson_com&ct=201326592&ipn=rj&face=#{face}&word=#{key_word}&rn=#{rn}&pn=#{pn}")
end

def request_url(url)
  RestClient::Request.execute(method: :get, url: url) rescue ''
end

# 获取总记录条数
def get_total_numbers(key_word)
  result = request_url(search_url(key_word, 1, 1))
  JSON.parse(result)["displayNum"]
end


# 创建文件夹
def create_down_folder(key_word, max_size)
  if MAX_SIZE > 0
    @down_dir = "#{APP_ROOT}/DBdownload/#{Time.now.strftime("%Y%m%d_%H%M%S")}-#{key_word}-#{max_size}"
  else
    @down_dir = "#{APP_ROOT}/DBdownload/#{Time.now.strftime("%Y%m%d_%H%M%S")}-#{key_word}-#{get_total_numbers()}"
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

def request_link(url)
  result = request_url(url)
  JSON.parse(result)["data"].each_with_index do |list, index|
    file = Random.new_seed.to_s
    write_pic_file(list["middleURL"], @down_dir, file) unless list["middleURL"].nil?
    puts "#{index} download ok."
  end
end

KEY_WORD.each do |key_word|

  # rn: 表示每页数据偏移量是60
  # pn: 表示当前页数，偏移量是60，也就是说下一页 pn=120,180

  p key_word

  create_down_folder(key_word, MAX_SIZE)

  total_nums = get_total_numbers(key_word)

  i=0
  p=0

  if END_PAGE > 0
    (START_PAGE..END_PAGE).each do |page|
      p += 1
      puts "---------------- 第 #{page} 页数据 ----------------"
      link = search_url(key_word, PER_PAGE, page)
      p link
      $queue.push(link)

      # result = request_url(link)
      # if JSON.parse(result)["data"].size > 0
      #   JSON.parse(result)["data"].each_with_index do |list, index|
      #     write_pic_file(list["middleURL"], @down_dir, i.to_s)  unless list["middleURL"].nil?
      #     i += 1
      #     puts "#{i} download ok."
      #     if MAX_SIZE != 0 && i >= MAX_SIZE
      #       puts "下载结束, 共下载 #{MAX_SIZE} 条数据"
      #       break
      #     end
      #   end
      # else
      #   break
      # end
    end
  else
    (START_PAGE..(total_nums/PER_PAGE).to_i).each do |page|
      p += 1
      puts "---------------- 第 #{page} 页数据 ----------------"

      if p*PER_PAGE <=  MAX_SIZE

        link = search_url(key_word, PER_PAGE, page)
        $queue.push(link)

      else
        break
      end
    end
  end
end



#程序开始的时间
$total_time_begin = Time.now.to_i

THREAD_NUM.times do
  threads<<Thread.new do
    until $queue.empty?
      url = $queue.pop(true) rescue nil
      html = request_link(url)
    end
  end
end
threads.each{|t| t.join}

#程序结束的时间
$total_time_end = Time.now.to_i
puts "线程数：" + THREAD_NUM.to_s
puts "执行时间：" + ($total_time_end - $total_time_begin).to_s + "秒"
