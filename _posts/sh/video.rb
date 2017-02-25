# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : image.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.2.25
#  description : 批量下载视频等资源文件
#                http://vision.ouc.edu.cn/valse/slides/
#  history     :
#               1. Date: 2017.2.25
#               Author:  cheenwe
#               Modification: 成功下载5G资源
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

require 'fileutils'
require "rest-client"
require 'nokogiri'
require 'net/http'
require 'open-uri'

class Video
  # 定义常量
  STORE_PATH = "/Users/dev/workspace/githubs/slides"
  FETCH_URL = "http://vision.ouc.edu.cn/valse/slides/"

  FECTH_PAGE = Nokogiri::HTML(open(FETCH_URL))

 # 下载
  def self.download(dir, file_name, url)
    retry_count = 0
    # log_file = dir + '/' + 'info' + ".log"
    # File.open log_file,'w' do |io|
      # io.write "----------start---------- #{ Time.now.strftime('%Y 年 %m 月 %d 日 %H 时 %M 分 %S 秒')} --------------------------\n"

      begin
        # yield(dir, file_name, url)

          puts "start download #{url}"

          f = open(File.join(dir, file_name), 'wb')
          begin
            RestClient::Request.execute(method: :get, url: url,
                  :cookies => {
                    :PHPSESSID => 'e85oforkln7l8nf0q8nadp2hv3'
                  }
              ) do |res|
                f.write(res)

              puts ">>>> 下载中 "
              sleep 0
              end
          ensure
              f.close()
          end

          puts "start download #{url}"

      rescue Timeout::Error
        # io.write "下载 #{ pic_info } 超时 \n"
        retry_count += 1
        if retry_count <= 3
          # io.write "重新下载 #{ retry_count } 次 \n"
          retry
        end
      rescue Errno::ECONNRESET
        # io.write "下载 #{ url } 错误 \n"
        retry_count += 1
        if retry_count <= 3
          sleep(5)
          retry
        end
      rescue => e
        # io.write "异常 #{e.inspect}  \n"
        retry_count += 1
        if retry_count <= 3
          retry
        end
      end
      if retry_count < 4
        # io.write  "下载 #{url} 完成 \n"
        return true
      else
        # io.write  "下载 #{url} 失败 \n"
        return false
      end
    # io.close
    # io.write "----------end---------- #{ Time.now.strftime('%Y 年 %m 月 %d 日 %H 时 %M 分 %S 秒')} --------------------------\n"
    end
  # end

  def self.second_search(file_path, url)
    puts "2:  #{url}"
    doc = Nokogiri::HTML(open(url))
    # 搜索二级文件路径
    doc.search('tr td a').each_with_index do |link, index|
      if index>0
        file_name = link.content
        download_url = "#{url}#{link.content}"
        puts "下载第 #{index} 中 download_url: #{download_url}...."

        Video.download(file_path, file_name, download_url)
      end
    end

  end

  def start
    # 搜索一级文件路径
    FECTH_PAGE.search('tr td a').each_with_index do |link, index|
      if index>0
        second_url = "http://vision.ouc.edu.cn/valse/slides/#{link.content}"
        file_path = "#{STORE_PATH}/#{link.content}"

        unless File.directory?(file_path)
          FileUtils.mkdir_p(file_path)
        end
        puts "------------- #{index}:  #{link.content}- --------second_url: #{second_url}"
        Video.second_search(file_path, second_url)
      end
    end
  end

end


Video.new.start