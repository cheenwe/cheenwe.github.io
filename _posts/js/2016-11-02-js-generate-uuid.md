---
layout: post
title: JS generate uuid
tags: js uuid
category: js
---

# JS generate unique id

```js
this.uuid = "ID"+(new Date().getTime())+"RAND"+(Math.ceil(Math.random() * 100000));
```


```js
   // The Central Randomizer 1.3 (C) 1997 by Paul Houle (paul@honeylocust.com)
    // See:  http://www.honeylocust.com/javascript/randomizer.html

    rnd.today=new Date();
    rnd.seed=rnd.today.getTime();
    function rnd() {
      rnd.seed = (rnd.seed*9301+49297) % 233280;
      return rnd.seed/(233280.0);
    };

    function rand(number) {
      return Math.ceil(rnd()*number);
    };
```


```javascript
function guid() {
    function S4() {
       return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    }
    return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
}
```