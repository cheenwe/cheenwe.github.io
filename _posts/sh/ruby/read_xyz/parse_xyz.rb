#!/usr/bin/ruby
# BASE_FILE = "/home/em/桌面/TUYANG_0425_标定/points.xyz" #输出文件
# BASE_FILE = "/media/em/data_1/tuyangkeji/Tuyang/camport3-master/sample/bin/points-8.xyz" #输出文件
BASE_FILE = "/Users/chenwei/workspace/HM/project/old/207000107251.xyz" #输出文件


    # <CAM>
    #     <T>0 0 0 </T>
    #     <R>1 0 0 0 1 0 0 0 1 </R>
    #     <E>1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 </E>
    #     <SN>207000107252</SN>
    # </CAM>
    # <CAM>
    #     <T>274.365 -2372.96 3317.01 </T>
    #     <R>-0.967352 0.252882 0.0167597 0.0610918 0.168494 0.983808 0.245963 0.952712 -0.178442 </R>
    #     <E>-0.967352 0.252882 0.0167597 274.365 0.0610918 0.168494 0.983808 -2372.96 0.245963 0.952712 -0.178442 3317.01 0 0 0 1 </E>
    #     <SN>207000107253</SN>
    # </CAM>
    # <CAM>
    #     <T>1898.08 -1544.02 1560.96 </T>
    #     <R>0.0129115 0.734963 -0.677984 -0.613509 0.541236 0.575039 0.789582 0.408525 0.457895 </R>
    #     <E>0.0129115 0.734963 -0.677984 1898.08 -0.613509 0.541236 0.575039 -1544.02 0.789582 0.408525 0.457895 1560.96 0 0 0 1 </E>
    #     <SN>207000107051</SN>
    # </CAM>
    # <CAM>
    #     <T>-1817.41 -1345.18 1739.42 </T>
    #     <R>-0.146918 -0.596698 0.788902 0.736814 0.466095 0.489756 -0.65994 0.653228 0.371177 </R>


# # 207000107253
# @t_arr =%w(274.365 -2372.96 3317.01)
# @r_arr = %w(-0.967352 0.252882 0.0167597 0.0610918 0.168494 0.983808 0.245963 0.952712 -0.178442)


# # 207000107051

# @t_arr =%w(1898.08 -1544.02 1560.96)
# @r_arr = %w(0.0129115 0.734963 -0.677984 -0.613509 0.541236 0.575039 0.789582 0.408525 0.457895)


# 207000107251

@t_arr =%w(-1817.41 -1345.18 1739.42)
@r_arr = %w(-0.146918 -0.596698 0.788902 0.736814 0.466095 0.489756 -0.65994 0.653228 0.371177)



def gen_new_x(x,y,z)
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

    x1= (x*a1 + y*b1+z*c1) + t_x

    return x1
end


def gen_new_y(x,y,z)
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

    y1= (y*a2 + y*b2+z*c2) + t_y

    return y1
end

def gen_new_z(x,y,z)
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

    z1= (z*a3 + y*b3+z*c3) + t_z

    return  z1
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
    i=0
        data = ''
        # i=0
        while line  = file.gets
            arr  = line.to_s.split(" ") #打印出文件内容
            # p arr
            new_x = gen_new_x(arr[0].to_f,arr[1].to_f,arr[2].to_f)
            new_y = gen_new_y(arr[0].to_f,arr[1].to_f,arr[2].to_f)
            new_z = gen_new_z(arr[0].to_f,arr[1].to_f,arr[2].to_f)

            data << "#{new_x},#{new_y},#{new_z},#{arr[3]},#{arr[4]},#{arr[5]} \n"

            # i=i+1
            # p i
        end
    write_file('/Users/chenwei/workspace/HM/project/old/new_xyz/parse_207000107251.xyz', data)
end


