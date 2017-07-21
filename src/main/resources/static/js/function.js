/**
 * jquery脚本测试
 */

/*加载页面时绑定事件*/
$(function(){
	console.log("页面加载中...");
});

/*页面加载完成后执行*/
$(document).ready(function() {
	$("h1").fadeIn(1000);
	$("img").fadeIn(4000);
});
