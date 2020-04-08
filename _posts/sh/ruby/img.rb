# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : image.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.2.23
#  description : 下载 365日历图片,按照格言命名文件
#                http://www.51wnl.com/api/getdailysentenceweb.ashx?dt=2016-09-14&_=1487908455230
#  history     :
#               1. Date: 2017.2.24
#               Author:  cheenwe
#               Modification: first add
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

require 'fileutils'
require 'net/http'
require 'json'
require 'date'

class Img

  # 指定下载路径及日志文件
  store_path = "/Users/dev/workspace/githubs/ilocate/log"

  log_file = store_path + '/' + 'info' + ".log"

  # 路径是否存在
  unless File.directory?(store_path)
    FileUtils.mkdir_p(store_path)
  end

  # 下载
  def self.download(dir, file_name, url)
    retry_count = 0

    log_file = dir + '/' + 'info' + ".log"

    File.open log_file,'w' do |io|
      # io.write "----------start---------- #{ Time.now.strftime('%Y 年 %m 月 %d 日 %H 时 %M 分 %S 秒')} --------------------------\n"

      begin
        yield(dir, file_name, url)
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
  end
end


require 'date'
date_begin = Date.parse '2016-02-25'
date_end = Date.parse '2017-03-01'

(date_begin .. date_end).each do |date|

  uri = "http://www.51wnl.com/api/getdailysentenceweb.ashx?dt=#{date.strftime("%F")}&_=1487908455230"

  res = Net::HTTP.get(URI.parse(URI.encode(uri.strip)))

  url = JSON.parse(res)["result"]["LargeImg"]

  s_ = JSON.parse(res)["result"]["S"]

  dir = "/Users/dev/workspace/githubs/ilocate/log"

  file_name = "#{s_}.jpg"

  Img.download(dir, file_name, url) do |directory, filename, uri|
    File.open(File.join(directory, filename), "wb") { |s|
      res = Net::HTTP.get(URI.parse(URI.encode(uri.strip)))
      s.write(res)
      puts ">>>> #{date}下载中 "
      sleep 0
    }
  end

end
