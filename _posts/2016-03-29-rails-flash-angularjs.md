---
layout: post
title: 在 AngularJS 中显示 Rails Flash中消息
tags: rails angularjs
categories: ruby
---

经常有些自定义的提醒 , 如 : 登陆成功, 或者是记录修改成功 的消息, 通过 AngularJS  结合第三方的样式可能更加的人性化 .  下面记录如何把 Rails 中 Flash  的消息传到 AngularJS 中 .

## View 代码

```javascript
<!-- _flash_messages.html.erb -->
<div ng-controller="FlashMessagesController as flash"
  data-notice="<%= flash[:notice] %>"
  data-alert="<%= flash[:alert] %>">
</div>

```

## Angular controller

```javascript
 # flash_messages_controller.js.coffee
FlashMessagesController = ($attrs) ->
  @notice = $attrs.notice
  @alert = $attrs.alert
  return
```


## View 代码-2

```javascript
<div ng-controller="FlashMessagesController as flash" data-initial="<%= flash.to_json.html_safe %>" ng-cloak>
  <div class="flash" ng-show="flash.show" ng-class="flash.show">
    <div class="close" ng-click="flash.show = false">
      <%= fa_icon "close" %>
    </div>
    {{flash.message}}
  </div>
</div>
```

## Angular controller-2

```javascript
 # flash_messages_controller.js.coffee
FlashMessagesController = ($scope, $attrs) ->
  initial = eval($attrs.initial)
  if initial.length
    @show = $attrs.initial[0][0]
    @message = $attrs.initial[0][1]
  return
```





