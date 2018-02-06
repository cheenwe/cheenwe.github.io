# 批量将博客链接提交到百度
# 使用说明
# 1. 链接提交工具是网站主动向百度搜索推送数据的工具，本工具可缩短爬虫发现网站链接时间，网站时效性内容建议使用链接提交工具，实时向搜索推送数据。本工具可加快爬虫抓取速度，无法解决网站内容是否收录问题
# 2. 百度搜索资源平台为站长提供链接提交通道，您可以提交想被百度收录的链接，百度搜索引擎会按照标准处理，但不保证一定能够收录您提交的链接。

require 'open-uri'
require 'nokogiri'
require 'net/http'

uri = URI.parse('http://cheenwe.cn/archive/')
host='www.cheenwe.cn'

WEB_INDEX = 'http://cheenwe.cn/archive/'

page = Nokogiri::HTML(open(WEB_INDEX))

results =  page.search("//div[@class='cd-timeline-content']/a")
urls = []
results.each do |result|
    link = result.attributes["href"].value
    url = host + link
    # urls << url
    p url
    # p urls.size
end

# urls = ["http://cheenwe.cn/2018-01-22/nano/"]

# # urls = ['http://www.example.com/1.html', 'http://www.example.com/2.html']
# uri = URI.parse('http://data.zz.baidu.com/urls?site=www.cheenwe.cn&token=HhE0wpGPeFiFZZD2')
# req = Net::HTTP::Post.new(uri.request_uri)
# req.body = urls.join("\n")
# req.content_type = 'text/plain'
# res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
# puts res.body
