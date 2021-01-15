#!/usr/bin/ruby

@default_folder = "/home/em/project/xyz"


require 'fileutils'
require "json"

def write_file(file, data)
    File.open("#{file.to_s}","w+") do |f|
        f.puts data
        f.close
        puts "创建成功: #{file}"
    end
end


def parse_file(base_file, filename)
    File.open(base_file,"r") do |file|
        vertex =[]
        color = []
        i=0
        while line  = file.gets
            arr  = line.to_s.split(" ") #打印出文件内容
            # vertex = vertex.push(arr[0].to_f,arr[1].to_f,arr[2].to_f,)
            vertex = vertex.push(arr[0].to_f/130,arr[1].to_f/130,arr[2].to_f/130,)
            color =  color.push(arr[3].to_f,arr[4].to_f,arr[5].to_f,)
            i=i+1
        end
        data = { }
        data["color"] = color
        data["descrition"] = "vertex"
        data["name"] = "name"
        data["size"] = i
        data["vertex"] = vertex

        res_file = @default_folder+"/result/default-"+filename+".json"
        # FileUtils.cp file, res_file

        write_file(res_file, data.to_json)

        # FileUtils.cp res_file, "/Users/chenwei/nginx/html/resources"

    end
end



# 1. 获取目录下以。xyz的文件开始处理， 生成文件前需要先删除目录下所有。xyz文件
Dir.foreach(@default_folder) do |f|
    if f.end_with? ".xyz"
        file = @default_folder+"/"+f
        p file

        parse_file(file, f)
    end
end
