---
layout: post
title: Hello World
tags:
  - test
---


![如何插入并上传图片]( {{"/files/2015/09/11/music.jpg" | prepend: site.imgrepo }})

# API接口

dh-11测试接口及api文档


## 用户管理 [/users]

### 注册验证 [POST]

+ Request (application/json)

        {
            "phone": "18516053754"
        }

+ Response 200 (application/json)

    + Headers

            Location: /users

    + Body

            {
                "message": "Favourite初始密码已发送成功，请查收",
                "user_id": "6"
            }


