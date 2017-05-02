# http head request
require 'net/http'  

def head_request(host, port=80, url)
	Net::HTTP.start(host, port){|http|   
	    response = http.head(url)  
		  head_hash = response.to_hash  
	    if response.code == "200" &&  response.code == "304"
		    p  host + url
		    p  head_hash 
		else 
		    # p  response.to_hash       
	    end 
	}  
end

head_request("fanyi.baidu.com","/static/translation/img/header/logo_cbfea26.png")

