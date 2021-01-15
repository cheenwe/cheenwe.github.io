require "rexml/document"
include REXML

#==== 修改 file 为外参路径 =====
# file = "/Users/chenwei/workspace/HM/project/points_new/新建文件夹/extrinsic.xml"

def gen_device_info(file='/Users/chenwei/workspace/HM/project/old/extrinsic.xml')

    doc = (Document.new File.new file)
    config = doc.elements.to_a("//CONFIG")
    puts config[0].elements["CAM_NUM"].text

    def check_cam(cam)
        t= cam.elements["T"].text
        r =  cam.elements["R"].text
        sn = cam.elements["SN"].text
        return sn, t, r
    end

    arr = {}
    doc.elements.each("//CAM") { |e|
        mm = check_cam(e)
        # p mm
        arr["#{mm[0]}"] = [mm[1], mm[2]]
    }

    return arr
end

# 返回： 设备sn, 已经标注好的T和R
# {"207000107252"=>["0 0 0 ", "1 0 0 0 1 0 0 0 1 "], "207000107253"=>["274.365 -2372.96 3317.01 ", "-0.967352 0.252882 0.0167597 0.0610918 0.168494 0.983808 0.245963 0.952712 -0.178442 "], "207000107051"=>["1898.08 -1544.02 1560.96 ", "0.0129115 0.734963 -0.677984 -0.613509 0.541236 0.575039 0.789582 0.408525 0.457895 "], "207000107251"=>["-1817.41 -1345.18 1739.42 ", "-0.146918 -0.596698 0.788902 0.736814 0.466095 0.489756 -0.65994 0.653228 0.371177 "]}
