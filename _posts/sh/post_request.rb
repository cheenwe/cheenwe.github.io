#!/usr/bin/ruby
# 进行 POST 请求 JSON 格式
# gem install faraday --no-ri

require 'faraday'
require 'json'

host = "https://www.stc.gov.cn"
path = "/facei/JL.action"

conn = Faraday.new(:url => host)
list_arrary = []

# 页数
(1..41).each do |page|
  res = conn.post do |req|
    req.url path
    req.headers['Content-Type'] = 'application/json'
    req.body = '{
        "page" => "15",
        "pg" => page
      }'
  end

  JSON.parse(res.body).each do |item|
    list_arrary << item
  end
  p page
end



# 下载文件
# File.open("1520480989411.jpg", "wb") { |s|
#       res = Faraday.get 'https://www.stc.gov.cn/facei/images/xc/1520480989411.jpg'
#       s.write(res.body)
#       s.close()
#     } rescue ''

# 数据写文件
aFile = File.new("input.json", "wb")
aFile.syswrite(list_arrary)



