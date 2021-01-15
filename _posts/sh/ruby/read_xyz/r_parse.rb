#!/usr/bin/ruby
# BASE_FILE = "/home/em/桌面/TUYANG_0425_标定/points.xyz" #输出文件
# BASE_FILE = "/media/em/data_1/tuyangkeji/Tuyang/camport3-master/sample/bin/points-8.xyz" #输出文件
BASE_FILE = "/Users/chenwei/workspace/HM/project/old/207000107251.xyz" #输出文件
# # 207000107253
# @t_arr =%w(274.365 -2372.96 3317.01)
# @r_arr = %w(-0.967352 0.252882 0.0167597 0.0610918 0.168494 0.983808 0.245963 0.952712 -0.178442)

# 207000107051
# @t_arr =%w(1898.08 -1544.02 1560.96)
# @r_arr = %w(0.0129115 0.734963 -0.677984 -0.613509 0.541236 0.575039 0.789582 0.408525 0.457895)


# # 207000107251
@t_arr =%w(-1817.41 -1345.18 1739.42)
@r_arr = %w(-0.146918 -0.596698 0.788902 0.736814 0.466095 0.489756 -0.65994 0.653228 0.371177)



# "207000107251"
# ["-1817.41", "-1345.18", "1739.42"]
# ["-0.146918", "-0.596698", "0.788902", "0.736814", "0.466095", "0.489756", "-0.65994", "0.653228", "0.371177"]
# "/Users/chenwei/workspace/HM/project/old//207000107051.xyz"
# "207000107051"
# ["1898.08", "-1544.02", "1560.96"]
# ["0.0129115", "0.734963", "-0.677984", "-0.613509", "0.541236", "0.575039", "0.789582", "0.408525", "0.457895"]
# "/Users/chenwei/workspace/HM/project/old//207000107253.xyz"
# "207000107253"
# ["274.365", "-2372.96", "3317.01"]
# ["-0.967352", "0.252882", "0.0167597", "0.0610918", "0.168494", "0.983808", "0.245963", "0.952712", "-0.178442"]




def gen_new_xyz(x,y,z)
    t_x = @t_arr[0].to_f
    t_y = @t_arr[1].to_f
    t_z = @t_arr[2].to_f

    a1 = @r_arr[0].to_f
    a2 = @r_arr[1].to_f
    a3 = @r_arr[2].to_f

    b1 = @r_arr[3].to_f
    b2 = @r_arr[4].to_f
    b3 = @r_arr[5].to_f

    c1 = @r_arr[6].to_f
    c2 = @r_arr[7].to_f
    c3 = @r_arr[8].to_f

    x1= (x*a1 + y*b1 +z*c1) + t_x
    y1= (x*a2 + y*b2 + z*c2) + t_y
    z1= (x*a3 + y*b3 + z*c3) + t_z

    return [x1, y1, z1]
end


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
        # p arr


        xyz_arr = gen_new_xyz(arr[0].to_f,arr[1].to_f,arr[2].to_f)

        new_x = xyz_arr[0]/130
        new_y = xyz_arr[1]/130
        new_z = xyz_arr[2]/130

        vertex = vertex.push(new_x,new_y,new_z,)
        p vertex
        # return
        # vertex = vertex.push(arr[0].to_f/130,arr[1].to_f/130,arr[2].to_f/130,)
        color =  color.push(arr[3].to_f,arr[4].to_f,arr[5].to_f,)
        i=i+1

        if arr[3] != 0
            p color
            p i
            break
        end
    end

    data = { }
    data["color"] = color
    data["descrition"] = "vertex"
    data["name"] = "name"
    data["size"] = i
    data["vertex"] = vertex

    write_file('/Users/chenwei/nginx/html/resources/207000107251.json', data.to_json)

    # FileUtils.cp "./1.json", '/home/em/project/gggliuye.github.io/WEBGL/resources/207000107051_new.json'
end

