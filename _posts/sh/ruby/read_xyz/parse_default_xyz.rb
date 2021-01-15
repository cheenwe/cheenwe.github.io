
# @devices = {"207000107051"=>["0 0 0 ", "1 0 0 0 1 0 0 0 1 "], "207000107251"=>["366.377 -2811.46 2973.56 ", "-0.975057 0.221908 0.00451221 0.0247938 0.0886962 0.99575 0.220564 0.971025 -0.0919858 "], "207000107253"=>["2129.78 -1277.01 1379.68 ", "0.161279 0.739712 -0.653311 -0.541119 0.61988 0.568277 0.825336 0.261868 0.500246 "], "207000107252"=>["-2210.6 -1187.03 1461.31 ", "0.0125036 -0.60965 0.792572 0.738545 0.539978 0.403702 -0.674088 0.580303 0.457006 "]}


xml_file = '/Users/chenwei/workspace/HM/project/old/extrinsic.xml'
@default_folder = "/Users/chenwei/workspace/HM/project/old"

is_hebing_file = false


require 'fileutils'
require "json"
require '/Users/chenwei/workspace/HM/project/parse_xml.rb'


@devices = gen_device_info(xml_file)

p @devices

def write_file(file, data)
    File.open("#{file.to_s}","w+") do |f|
        f.puts data
        f.close
        puts "创建成功: #{file}"
    end
end

def check_folder(dir)
    unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
    end
end

# 生成新的 xyz
def gen_new_xyz(file, filename)
    File.open(file,"r") do |file|
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

        res_file = @default_folder+"/result/parse-"+filename+".xyz"
        # dir = File.dirname(res_file)
        check_folder(File.dirname(res_file))

        write_file(res_file, data)
        data =''

        # FileUtils.cp "./1.json", '/home/em/project/gggliuye.github.io/WEBGL/resources/207000107051_new.json'
    end
end



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

    x1= (x*a1 + y*b1 +z*c1) + t_x

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

    y1= (x*a2 + y*b2+z*c2) + t_y

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

    z1= (x*a3 + y*b3+z*c3) + t_z

    return  z1
end

# 3.处理单个文件生成
def deal_one_file(file, device_info, filename)

    @t_arr =device_info[0].split(' ')
    @r_arr =device_info[1].split(' ')

    # p @t_arr
    # p @r_arr

    if (@t_arr[0] == "0" || @t_arr[1]== "0" ||  @t_arr[2] == "0")
        # 参照相机无需处理数据
        res_file = @default_folder+"/result/parse-"+filename+".xyz"
        FileUtils.cp file, res_file
        p "======= skip: "+ file
    else
        gen_new_xyz(file, filename)
    end
end

# 2.根据文件路径获取对应的设备信息，
def check_filename(file)
    filename = file.split("/").last.split('.')[0]# 修改文件生成格式
    device_info = @devices["#{filename}"]

    deal_one_file(file, device_info, filename)
end

# 1. 获取目录下以。xyz的文件开始处理， 生成文件前需要先删除目录下所有。xyz文件
# Dir.foreach(@default_folder) do |f|
#     if f.end_with? ".xyz"
#         file = @default_folder+"/"+f
#         p file

#         check_filename(file)
#     end
# end


@devices.keys.each do |f|
        file = @default_folder+"/"+f+".xyz"
        p file
        check_filename(file)
end


res_folder = @default_folder+"/result"

if is_hebing_file
    system("cat #{res_folder}/*.xyz > #{res_folder}/all.xyz")
end
