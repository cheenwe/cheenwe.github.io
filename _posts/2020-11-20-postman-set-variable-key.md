---
layout: post
title: 使用 Postman 设置 token 环境变量
tags: postman 
category: postman
---

在写API接口时有个需要实现 token 过期的机制， 在调试的时候每次需要重新登录并复制新的token比较
麻烦，可以通过写测试脚本设置全局环境变量， 记录整理如下。


点击添加正常的登录接口 -> Tests -> 复制以下内容进去 -> 点击发送请求即可

每次toke过期后再点下登录便自动设置token


```
// 该请求登录后自动设置 token参数
var jsondate = pm.response.json()    
var token = jsondate.token
pm.environment.set("token","Bearer "+token)
```

该登录接口后返回参数如下

```
{
    "code": "200",
    "success": 1,
    "msg": "ok",
    "token": "eyJhxxxx
}
```

 
## 其他测试脚本


- 获取全局变量
    
    pm.globals.get("variable_key");

- 添加全局变量
    
    pm.globals.set("variable_key", "variable_value");

- 清除全局变量
    pm.globals.unset("variable_key");

- 获取环境变量
    
    pm.environment.get("variable_key");

- 添加环境变量
    
    pm.environment.set("variable_key", "variable_value");


- 发送一个请求

    pm.sendRequest("https://postman-echo.com/get", function (err, response) {
        console.log(response.json());
    });


- 请求是否超过200ms

    pm.test("Response time is less than 200ms", function () {
        pm.expect(pm.response.responseTime).to.be.below(200);
    });·

- 根据状态码判断请求是否成功

    pm.test("Successful POST request", function () {
        pm.expect(pm.response.code).to.be.oneOf([201, 202]);
    });
