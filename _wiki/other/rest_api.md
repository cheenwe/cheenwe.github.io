
## RESTful API

### aliyun message

error request

```json
{"code":"ConsoleNeedLogin","message":"needLogin","successResponse":false}
```
success request

```json
// 20170417091529
// https://notifications.console.aliyun.com/message/getMessageList.json?__preventCache=1492391545275&classId=0&pageNumber=1&pageSize=20&status=0

{
  "bid": "26842",
  "code": "200",
  "data": {
    "Datas": {
      "Item": [
        {
          "CategoryName": "产品消息-域名和网站",
          "Content": "",
          "GmtCreated": 1491798567000,
          "Memo": "",
          "MsgId": 9401946407,
          "Status": 0,
          "Title": "6元限量抢！虚拟主机+木马查杀，助力中小企业低成本搭建更安全的网站！"
        },
        {
          "CategoryName": "产品消息-域名和网站",
          "Content": "",
          "GmtCreated": 1490757334000,
          "Memo": "",
          "MsgId": 9401894644,
          "Status": 0,
          "Title": "【阿里云】企业邮箱老用户专享，采购季大促升级低至5折，仅剩最后几天，速抢"
        },
        {
          "CategoryName": "服务消息-使用帮助",
          "Content": "",
          "GmtCreated": 1490159180000,
          "Memo": "",
          "MsgId": 9401839610,
          "Status": 0,
          "Title": "阿里云媒体转码开通成功提醒"
        },
        {
          "CategoryName": "产品消息-存储与CDN",
          "Content": "",
          "GmtCreated": 1490067500000,
          "Memo": "",
          "MsgId": 9401831263,
          "Status": 0,
          "Title": "[产品动态]阿里云存储3月存储月刊"
        },
        {
          "CategoryName": "产品消息-域名和网站",
          "Content": "",
          "GmtCreated": 1490060854000,
          "Memo": "",
          "MsgId": 9401829902,
          "Status": 0,
          "Title": "云解析解析记录修改通知"
        },
        {
          "CategoryName": "产品消息-域名和网站",
          "Content": "",
          "GmtCreated": 1490060409000,
          "Memo": "",
          "MsgId": 9401829885,
          "Status": 0,
          "Title": "云解析解析记录修改通知"
        },
        {
          "CategoryName": "产品消息-域名和网站",
          "Content": "",
          "GmtCreated": 1488268916000,
          "Memo": "",
          "MsgId": 9401688576,
          "Status": 0,
          "Title": "云解析解析记录修改通知"
        },
        {
          "CategoryName": "产品消息-域名和网站",
          "Content": "",
          "GmtCreated": 1488268524000,
          "Memo": "",
          "MsgId": 9401688564,
          "Status": 0,
          "Title": "云解析解析记录修改通知"
        },
        {
          "CategoryName": "产品消息-域名和网站",
          "Content": "",
          "GmtCreated": 1488268329000,
          "Memo": "",
          "MsgId": 9401688560,
          "Status": 0,
          "Title": "云解析解析记录修改通知"
        },
        {
          "CategoryName": "产品消息-域名和网站",
          "Content": "",
          "GmtCreated": 1488268322000,
          "Memo": "",
          "MsgId": 9401688559,
          "Status": 0,
          "Title": "云解析解析记录删除通知"
        }
      ]
    },
    "PageNumber": 1,
    "PageSize": 10,
    "TotalCount": 56
  },
  "locale": "zh",
  "message": "",
  "requestId": "74cf3f85-7d81-4e7e-8815-a211d2a22fd0",
  "siteId": "cn",
  "successResponse": true
}


```



### baidu yun api

// 20170418115333
// https://pan.baidu.com/disk/cmsdata?do=client&&channel=chunlei&web=1&app_id=250528&bdstoken=f589a9c047a6b40186ea4d82ce8f0b2c&logid=MTQ5MjQ4NzUzMDYxNTAuMzU4NzU1MDYzMzkxOTU0Mw==&clienttype=0

{
  "errorno": 0,
  "web": {
    "version": "Web版",
    "publish": "2016-10-10 16:40",
    "feature_tips": ""
  },
  "windows": {
    "version": "Windows版 V3.9.6",
    "publish": "2015-11-18 15:10",
    "size": "6.63MB",
    "system": "XP/vista/win7/win8",
    "feature_tips": "windows版可以xxx啦"
  },
  "android": {
    "version": "Android版 V7.17.0",
    "url": "http://issuecdn.baidupcs.com/issue/netdisk/apk/BaiduNetdisk_7.17.0.apk",
    "publish": "2017-04-06 20:15:00",
    "size": "22.2M",
    "system": "Android 2.3及以上版本",
    "feature_tips": ""
  },
  "iphone": {
    "version": "iPhone版 V7.1.0",
    "publish": "2017-01-19 17:06",
    "size": " 115M",
    "system": "iOS7.0及以上版本",
    "feature_tips": ""
  },
  "ipad": {
    "version": "iPad版 V4.6.1",
    "publish": "2017-03-28 16:05:30",
    "size": "33.4MB",
    "system": "iOS7.0及以上版本",
    "feature_tips": ""
  },
  "winphone": {
    "version": "WinPhone版 V3.1.0",
    "publish": "2013-06-15 11:52",
    "size": "3M",
    "system": "Windows Phone 7.5 及Windows Phone 8",
    "feature_tips": ""
  },
  "guanjia": {
    "version": "百度网盘PC版 V5.5.4",
    "url": "http://issuecdn.baidupcs.com/issue/netdisk/yunguanjia/BaiduNetdisk_5.5.4.exe",
    "publish": "2017-03-02 13:45:45",
    "size": "21.7MB",
    "system": "XP/vista/win7/win8/win10",
    "feature_tips": ""
  },
  "mac": {
    "version": "Mac版 V2.1.0",
    "url": "http://issuecdn.baidupcs.com/issue/netdisk/MACguanjia/BaiduNetdisk_mac_2.1.0.dmg",
    "publish": "2017-02-28 11:45:33",
    "size": "11.4M",
    "system": "Mac OS X 10.10+",
    "feature_tips": "mac版可以xxx啦"
  }
}