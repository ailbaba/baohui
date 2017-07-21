function messageListener() {

	JS.Engine.on({
				friends_req_message : function(data) {// 侦听一个channel
					// 转换成JSON 格式
					var list = eval("(" + data + ")");
					var html="";
					$.Messager.lays(250, 150);
					$.Messager.anim('fade', 2000);

					for (var i = 0; i < list.length; i++) {

						html += "<li onclick=openFriendVerifyWindow()> <font color='blue'>"
								+ list[i].companyName
								+ "</font>&nbsp;&nbsp;请求你为好友&nbsp;&nbsp;<a href=#>[查看]</a></li><br>";
					}

					$.myMessager.show('<font color=red>加好友请求</font>', html,30000);

				}
			});
	JS.Engine.start('comet');
}