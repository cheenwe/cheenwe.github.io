#!/usr/bin/ruby
# BASE_FILE = "/home/em/桌面/TUYANG_0425_标定/points.xyz" #输出文件
 BASE_FILE = "/Users/chenwei/workspace/HM/project/old/result/转换后-all.xyz" #输出文件
#  BASE_FILE = "/media/em/data_1/tuyangkeji/Tuyang/camport3-master/sample/bin/points-8.xyz" #输出文件


require 'fileutils'
require "json"

def write_file(file, data)
    File.open("#{file.to_s}","w+") do |f|
        f.puts data
        f.close
        puts "创建成功: #{file}"
    end
end

File.open(BASE_FILE,"r") do |file|
    vertex =[]
    color = []
    i=0

    while line  = file.gets
        arr  = line.to_s.split(" ") #打印出文件内容
        vertex = vertex.push(arr[0].to_f/130,arr[1].to_f/130,arr[2].to_f/130,)
        color =  color.push(arr[3].to_f,arr[4].to_f,arr[5].to_f,)
        # p vertex
        # return
        # vertex = vertex.push(arr[0].to_f/130,arr[1].to_f/130,arr[2].to_f/130,)
        # color =  color.push(arr[3].to_f,arr[4].to_f,arr[5].to_f,)
        # p color
        # return
        i=i+1
    end

    data = { }
    data["color"] = color
    data["descrition"] = "vertex"
    data["name"] = "name"
    data["size"] = i
    data["vertex"] = vertex

    write_file('/Users/chenwei/nginx/html/resources/转换后-all.json', data.to_json)

    # FileUtils.cp "./1.json", '/Users/chenwei/nginx/html/resources/all.json'
end


