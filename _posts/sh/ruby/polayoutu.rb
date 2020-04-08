# 下载泼辣有图图片，
require 'rest-client'

@download_path="./download/"

#每页图片张数
@per_page_num = 30
#每期图片个数
@max_page_num = 163

#创建下载目录
FileUtils.mkdir_p(@download_path)

def download_file(url, filename)
    file = @download_path + filename
    File.open(file, "wb") { |s|
        res = RestClient.get(url)
        s.write(res)
        s.close()
    }
end


# 写文件
# file_name = "/Users/chenwei/Library/Logs/tmp/75670089.csv"
def write_csv_file(file, data)
  File.open(file,"a+:utf-8") do |f|
    f.puts data
    f.close
  end
end

# 判断URL中文件存在， 返回 true/false
require 'net/http'
require 'uri'
def check_file_exist(url)
    uri = URI(url)

    host = uri.host
    port = uri.port
    path = uri.path

	Net::HTTP.start(host, port){ |http|
	    response = http.head(path)
        head_hash = response.to_hash
        # p head_hash
        # p response.code
	    if response.code == "200" ||  response.code == "304"
            return true
		else
            return false
	    end
	}
end


url = "http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/1/12/full_res.jpg"


# 拼接每页下载的图片链接， 判断图片时候存在
def check_page_pics(page)
    err_count = 0

    (1..@per_page_num).each do |i|
        url = "http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/#{page}/#{i}/full_res.jpg"

        p "#{page}/#{i}"
        if check_file_exist(url)
            filename = "#{page}_#{i}.jpg"
            data = url +", "+filename
            download_file(url, filename)
            write_csv_file("泼辣有图.csv", data)
        else
            err_count = err_count + 1
            p "...... next"
            if err_count >= 4
                break
            end
        end
        # p i
    end
end


(1..@max_page_num).each do |page|
    # p "#{page}/#{i}"
    # check_page_pics(1)
    check_page_pics(page)
    # p i
end
# check_page_pics(1)