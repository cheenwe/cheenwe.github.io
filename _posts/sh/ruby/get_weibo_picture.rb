# 获取微博图片链接，写入到文件
# gem install rest-client

#!/usr/bin/ruby

require "rest-client"
require "json"

# http://photo.weibo.com/photos/get_all?uid=1893765037&album_id=3560876536637117&count=30&page=2&type=3&__rnd=1479904367575

uid = "1893765037"

album_id = "3560876536637117"


# 416
start_page=301
end_page=416

per_page = 60

list_arrary = []

(start_page..end_page).each do |page|

  url = "http://photo.weibo.com/photos/get_all?uid=#{uid}&album_id=#{album_id}&count=#{per_page}&page=#{page}&type=3"
  # puts url

   result = RestClient::Request.execute(method: :get, url: url,
      :cookies => {
        :USRANIME =>'usrmdinst_46',
        :SUB =>'_2A251MeS5DeTxGedN7FcU-CbNyD-IHXVWR1FxrDV8PUNbn9ANLW7HkW9sFd4wIPtZ0XWq7wPG3y3TkHG1uw..',
        :SUBP =>'0033WrSXqPxfM725Ws9jqgMF55529P9D9WhnR2puq_1_hwxC_ds4YUL85JpX5KMhUgL.Fo20S0-f1hnpe0e2dJLoIpjLxK.L1K.L1hnLxKMLB.-LBozLxKBLBo.L12zt'
      }
    )

  # result.code
  # puts JSON.parse(result.body)

  JSON.parse(result.body)["data"]["photo_list"].each do |list|
    # puts "解析中------ #{list["uid"]}"

    list_arrary << {
      mid: list["mid"],
      caption_render: list["caption_render"],
      caption: list["caption"],
      url:"#{list["pic_host"]}/large/#{list["pic_name"]}"
      }

  end

  puts "#{page} is ok --- #{result.code}"

  # p result.cookies
  sleep(0.02)
end


aFile = File.new("input.json", "r+")

aFile.syswrite(list_arrary)





# ## remove => and key value

# ```sh
# list_arrary = File.read('/Users/chenwei/workspace/project/test/sina_pic/d.json').gsub(":mid",'"mid"').gsub(":caption_render",'"caption_render"').gsub(":caption",'"caption"').gsub(":url",'"url"').gsub('"=>"', '":"')


# # list_arrary = File.read('/Users/chenwei/workspace/project/test/sina_pic/a.json').gsub('"=>"', '":"')

# lists = list_arrary

# aFile = File.new("/Users/chenwei/workspace/project/test/sina_pic/a.json", "r+")


# aFile.syswrite(lists)

# ```

# ## create records

# ```
# JSON.parse(File.read('/Users/chenwei/workspace/project/test/sina_pic/00.json')).each do |record|
# ireads = Iread.where(mid:record["mid"])
# if ireads.present?
# Picture.create( iread_id: ireads.last.id, url: record["url"])
# else
# iread = Iread.create(mid: record["mid"],caption: record["caption"],caption_render: record["caption_render"])
# Picture.create( iread_id: iread.id, url: record["url"])
# end
# end
# ```


