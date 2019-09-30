require 'net/http'
require 'json'
require 'digest'

@appid = 'xxx' #你的appid
@secretKey = 'xxxxx' #你的密钥

@host = 'http://api.fanyi.baidu.com'
@myurl = '/api/trans/vip/translate'

def digit
	(rand() * 9).round.to_s
end
def number(n)
	(1..n).collect {digit}.join
end
# 生成翻译 URL
def generate_url(q = '你好', fromLang = 'zh', toLang = 'en')
	salt = number(5)
	sign_str = @appid+q+salt.to_s+@secretKey
	sign =  Digest::MD5.hexdigest(sign_str)
	myurl = @myurl+'?appid='+@appid+'&q='+CGI.escape(q)+'&from='+fromLang+'&to='+toLang+'&salt='+salt.to_s+'&sign='+sign
	return myurl
end

def get(myurl, options = {})
	url = URI.join(@host, myurl)
	result Net::HTTP.get(url)
end

def result(body)
	begin
		result =  JSON.parse body
	rescue => e
		{
			code: 502,
			msg: '内容解析错误',
			detail: e.to_s
		}
	end
end

def fanyi(q = '你好', fromLang = 'zh', toLang = 'en')
	url = generate_url(q , fromLang, toLang)
	res = get(url)
	p res
	return res["trans_result"][0]["dst"].downcase.split.join("_").to_s
end
# p fanyi

