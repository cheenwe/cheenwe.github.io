#! -coding:utf8 -*-
# pip install bs4 pyquery selenium -i http://pypi.douban.com/simple  --trusted-host pypi.douban.com
# # for mac
# wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_mac64.zip
# sudo cp ~/Downloads/chromedriver /usr/local/bin


from selenium import webdriver
import time
import re
from pyquery import PyQuery as pq
import csv

from bs4 import BeautifulSoup

def write_file(data):
	with open("test.csv", 'a+') as f:
		writer = f.write(data+'\n')
		#先写入columns_name
	pass

def view_page(num, data):
		# rule = r'<td>(.*?)</td><td class="PL_SSQ_CLASS">(.*?)</td><td>(.*?)</td><td align="left">(.*?)</td><td>(.*?)</td><td>(.*?)</td>'
	rule = r'<tr>(.*?)</tr>'
	name_list = data.find_all('tr')
	j = 1
	for tr in name_list:
		tds = tr.find_all('td')
		#print(len(tds))
		if len(tds) == 3:
				a0 = tds[0].getText().strip()
				a1 = tds[1].getText().strip()
				a2 = tds[2].getText().strip()
				sn = num*20+j
				a = (str(sn) + "," + a0 + "," + a1 + "," +
						 a2 )
				j=j+1
				print(a)

				write_file(a)

def open_web_page(url, page):
	browser = webdriver.Chrome()  # 打开浏览器
	browser.get(url)  # 进入相关网站

	write_file("ID, 机构名称, 所在省市,机构层级, 法定地址（邮政编码）, 电话, 营业状态, 其他")

	html = browser.page_source  # 获取网站源码
	data = str(pq(html))  # str() 函数将对象转化为适于人阅读的形式。
	print(data)

	data = BeautifulSoup(data)

	## for test
	# for num in range(1, 20):
	# 	print(num)
	# 	browser.find_element_by_id("ess_ctr3218_ViewBranchesSearch_wuPager_lbtnNextPage").click()

	view_page(0, data)  # 处理本页数据


	for m in range(1, int(page)):
		print("=====> 正在访问" + str(m))

		html = browser.page_source  # 获取网站源码
		data = str(pq(html))  # str() 函数将对象转化为适于人阅读的形式。
		#print(data)

		data = BeautifulSoup(data)
		view_page(m, data)  # 处理本页数据

		browser.find_element_by_id("ess_ctr3218_ViewBranchesSearch_wuPager_lbtnNextPage").click()
		#time.sleep(10000)
		# while(1):
		#   browser.find_element_by_class_name("turn_next").click()
		#   time.sleep(1)

	browser.quit()

url = 'http://www.jlbank.com.cn/tabid/761/Default.aspx'
open_web_page(url, 49)
