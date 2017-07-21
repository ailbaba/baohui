<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>
<script>

	function send() {

		var frm = $("#msgForm");

		var elsAccount=$("#elsAccount").val();
		var elsSubAccount=$("#elsSubAccount").val();
		
		$("#key").val("demo:"+elsAccount+"$"+elsSubAccount);
		//$("#key").val("clientMessage$"+elsAccount+"_"+elsSubAccount);
		
		$.ajax({
			url : "rest/RedisMessageService/producer",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				 showMsg("发送成功");
			},
			error : function(data) {
				 showMsg("发送失败");
			}
		});

	}
	
	
	function pub() {

		var frm = $("#msgForm");
		
		$("#channel").val("order_message");
		
		$.ajax({
			url : "rest/RedisMessageService/publish",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				 showMsg("发布成功");
			},
			error : function(data) {
				 showMsg("发布失败");
			}
		});

	}
	
</script>
<form id="msgForm" action="" method="post">


	<div class="">
		账号： <input class="easyui-textbox" type="text" id="elsAccount"
			name="elsAccount" />
	</div>
	<br>
	<div class="">
		子账号： <input class="easyui-textbox" type="text" id="elsSubAccount"
			name="elsSubAccount" />
	</div>
	<br>
	<div class="">
		消息内容： <input class="easyui-textbox" type="text" id="message"
			name="message" />
	</div>

	<br>
	<div style="text-align: center; padding: 5px">
		<input type="button" onclick="send();" value="发送" />
		<input type="button" onclick="pub();" value="发布" />
	</div>
 <input  type="hidden" id="key"	name="key" />
  <input  type="hidden" id="channel" name="channel" />
</form>
</body>
</html>