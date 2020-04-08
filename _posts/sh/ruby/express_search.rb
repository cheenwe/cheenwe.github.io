#!/usr/bin/ruby

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : express_search.rb
#  author      : cheenwe
#  version     : 0.0.1
#  created     : 2017.03.30
#  description : 调用快递100 在线接口，进行快寄送递信息搜索
#                                http://www.kuaidi100.com
#  history     :
#               1. Date: 2017.03.30
#               Author:  cheenwe
#               Modification:  查询快递的时候根据快递100 REST API进
#                    行快递信息查询
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #

require 'rest-client'
# require 'uri'
require "json"

class ExpressSearch

    class << self
        def send_request(url)
            # url = URI::escape(url)
            result = RestClient::Request.execute(method: :get, url: url)
            JSON.parse(result)
        end

        def search_result_by_postid(postid)
            url = "http://www.kuaidi100.com/autonumber/autoComNum?text=#{postid}"
            result =  send_request(url)
            # companys=[]
            result["auto"].each do |record|
                # companys << record["comCode"]
                # puts "正在查询 #{record["comCode"]} 快递中..... "
                right_request  = is_search_result(postid, record["comCode"])
                if right_request != 0
                    return right_request
                    # puts right_request
                end
            end
            # companys
        end

        def is_search_result(postid, company)
            result = search_result(postid, company)

            if result["status"] == "200"
                result
            else
                return 0
            end
        end

        def search_result(postid, company)
            url = "http://www.kuaidi100.com/query?type=#{company}&postid=#{postid}"
            send_request(url)
        end
    end

    def self.search(postid, company=nil)
        s = Time.now
        if company == nil
            p search_result_by_postid(postid)
        else
            p search_result(postid, company)
        end
        puts "used: #{Time.now - s}"

    end

end

# e = ExpressSearch.new.search("560607391039", "yuantong")
e = ExpressSearch.search("560607391039")
# e.search

# 560607391039
# 500701331701







# ems EMS
# aae AAE全球专递
# anjiekuaidi 安捷快递
# anxindakuaixi 安信达快递
# baifudongfang 百福东方
# biaojikuaidi 彪记快递
# bht BHT
# cces 希伊艾斯快递
# Coe 中国东方（COE）
# changyuwuliu 长宇物流
# datianwuliu 大田物流
# debangwuliu 德邦物流
# dpex DPEX
# dhl DHL
# dsukuaidi D速快递
# fedex fedex
# feikangda 飞康达物流
# fenghuangkuaidi 凤凰快递
# ganzhongnengda 港中能达物流
# guangdongyouzhengwuliu 广东邮政物流
# huitongkuaidi 汇通快运
# hengluwuliu 恒路物流
# huaxialongwuliu 华夏龙物流
# jiayiwuliu 佳怡物流
# jinguangsudikuaijian 京广速递
# jixianda 急先达
# jiajiwuliu 佳吉物流
# jiayunmeiwuliu 加运美
# kuaijiesudi 快捷速递
# lianhaowuliu 联昊通物流
# longbanwuliu 龙邦物流
# minghangkuaidi 民航快递
# peisihuoyunkuaidi 配思货运
# quanchenkuaidi 全晨快递
# quanjitong 全际通物流
# quanritongkuaidi 全日通快递
# quanyikuaidi 全一快递
# shenghuiwuliu 盛辉物流
# suer 速尔物流
# shengfengwuliu 盛丰物流
# tiandihuayu 天地华宇
# tiantian 天天快递
# tnt TNT
# ups UPS
# wanjiawuliu 万家物流
# wenjiesudi 文捷航空速递
# wuyuansudi 伍圆速递
# wanxiangwuliu 万象物流
# xinbangwuliu 新邦物流
# xinfengwuliu 信丰物流
# xingchengjibian 星晨急便
# xinhongyukuaidi 鑫飞鸿物流快递
# yafengsudi 亚风速递
# yibangwuliu 一邦速递
# youshuwuliu 优速物流
# yuanchengwuliu 远成物流
# yuantong 圆通速递
# yuanweifeng 源伟丰快递
# yuanzhijiecheng 元智捷诚快递
# yuefengwuliu 越丰物流
# yunda 韵达快运
# yuananda 源安达
# Yuntongkuaidi 运通快递
# zhaijisong 宅急送
# zhongtiewuliu 中铁快运
# zhongtong 中通速递
# zhongyouwuliu 中邮物流
# shentong 申通快递
# shunfen 顺丰快递