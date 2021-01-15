#!/usr/bin/ruby

@default_folder = "/home/em/TUYANG_0425/points/"


require 'fileutils'
require "json"
require '/Users/chenwei/workspace/HM/project/parse_xml.rb'


xml_file = '/home/em/TUYANG_0425/extrinsic.xml'

@devices = gen_device_info(xml_file)


def check_folder(dir)
    unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
    end
end

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


# # 3.处理单个文件生成
def deal_one_file(file, filename)
    File.open(file,"r") do |file|
        data = ''
        # i=0
        while line  = file.gets
            arr  = line.to_s.split(" ") #打印出文件内容
            # p arr
            # 获取每一行转换后的 xyz

            xyz_arr = gen_new_xyz(arr[0].to_f,arr[1].to_f,arr[2].to_f)

            new_x = xyz_arr[0]
            new_y = xyz_arr[1]
            new_z = xyz_arr[2]

            data << "#{new_x},#{new_y},#{new_z},#{arr[3]},#{arr[4]},#{arr[5]}\n"

            # i=i+1
            # p i
        end

        res_file = @default_folder+"/result/转换后-"+filename+".xyz"
        # dir = File.dirname(res_file)
        check_folder(File.dirname(res_file))

        write_file(res_file, data)
        data =''

        # FileUtils.cp "./1.json", '/home/em/project/gggliuye.github.io/WEBGL/resources/207000107051_new.json'
    end

end

def write_file(file, data)
    File.open("#{file.to_s}","w+") do |f|
        f.puts data
        f.close
        puts "创建成功: #{file}"
    end
end


def parse_file(base_file, filename)

    filename = filename.split(".")[0]

    p filename

    device_info = @devices["#{filename}"]

    @t_arr =device_info[0].split(' ')
    @r_arr =device_info[1].split(' ')


    if (@t_arr[0] == "0" || @t_arr[1]== "0" ||  @t_arr[2] == "0")
        # 参照相机无需处理数据
        res_file = @default_folder+"/result/转换后-"+filename+".xyz"
        FileUtils.cp base_file, res_file
        p "======= skip: "+ base_file
    else

        p @t_arr
        p @r_arr

        deal_one_file(base_file, filename)

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
