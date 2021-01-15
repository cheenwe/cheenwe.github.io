
# @devices = {"207000107051"=>["0 0 0 ", "1 0 0 0 1 0 0 0 1 "], "207000107251"=>["366.377 -2811.46 2973.56 ", "-0.975057 0.221908 0.00451221 0.0247938 0.0886962 0.99575 0.220564 0.971025 -0.0919858 "], "207000107253"=>["2129.78 -1277.01 1379.68 ", "0.161279 0.739712 -0.653311 -0.541119 0.61988 0.568277 0.825336 0.261868 0.500246 "], "207000107252"=>["-2210.6 -1187.03 1461.31 ", "0.0125036 -0.60965 0.792572 0.738545 0.539978 0.403702 -0.674088 0.580303 0.457006 "]}


@default_folder = "/Users/chenwei/workspace/HM/project/old"

is_hebing_file = false



require 'fileutils'
require "json"
require '/Users/chenwei/workspace/HM/project/parse_xml.rb'


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

