#!/usr/bin/ruby
# BASE_FILE = "/home/em/桌面/TUYANG_0425_标定/points.xyz" #输出文件
# BASE_FILE = "/home/em/project/points/207000107252.xyz" #输出文件
#  BASE_FILE = "/media/em/data_1/tuyangkeji/Tuyang/camport3-master/sample/bin/points-8.xyz" #输出文件


f1 = "/home/em/project/xyz/result/xxx/default-207000107252.xyz.json"
f2 = "/home/em/project/xyz/result/xxx/default-207000107051.xyz.json"

require 'fileutils'

require "json"


data1 = JSON.parse(File.read(f1))
p data1["descrition"]


# data["color"] = color
# data["descrition"] = "vertex"
# data["name"] = "name"
# data["size"] = i
# data["vertex"] = vertex



data2 = JSON.parse(File.read(f2))
p data2["descrition"]




data = { }

data["color"] = data1["color"].push(data2["color"]).flatten
data["descrition"] = "vertex"
data["name"] = "name"
data["size"] = data1["size"]+data2["size"]
# data["size"] = i

data["vertex"] = data1["vertex"].push(data2["vertex"]).flatten
# data["vertex"] = vertex



def write_file(file, data)
    File.open("#{file.to_s}","w+") do |f|
        f.puts data
        f.close
        puts "创建成功: #{file}"
    end
end


write_file("/Users/chenwei/nginx/html/resources/252_253_051_251.json", data.to_json)

# FileUtils.cp "./1.json", '/home/em/project/gggliuye.github.io/WEBGL/resources/all_all.json'

