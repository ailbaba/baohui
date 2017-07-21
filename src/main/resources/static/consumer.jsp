<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>
<script>

var key="demo:"+elsAccount+"$"+elsSubAccount;

$(function(){
	
	getMyMessage();
	window.setInterval(getMyMessage, 8000); 
	
});

function getMyMessage(){
	
	$.ajax({
		
		url : "rest/RedisMessageService/consumer/"+key+"?t="+new Date().getTime(),
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			var html="";
			if(data.length>0){
				for (var i = 0; i < data.length; i++) {
            		html+=data[i].message+"<br>";
				}
				$.Messager.show('<font color=red><i18n:I18n key="i18n_js_u_get_msg" defaultValue="你有新消息"/></font>',html,3000);
			}
			
		},
		error :  function(data) {
			 showMsg("异常");
		}
	});
}

	
</script>

</body>
</html>