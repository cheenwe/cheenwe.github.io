---
layout: null
---

/**
 * 页面ready方法
 */
$(document).ready(function() {
    generateContent();
    // disqus();
});

/**
 * 侧边目录
 */
function generateContent() {
    var $mt = $('.toc');
    var $toc;
    $mt.each(function(i,o){
        $toc = $(o);
        $toc.toc({ listType: 'ul', headers: 'h1, h2, h3' });
    });
}
