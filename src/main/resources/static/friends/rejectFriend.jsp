<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 130px;
		padding-left: 20px;
		padding-top: 10px ;
		text-align: right;
	}
</style>

<div id="friend">
<form id="friendVerifyForm" action="" method="post">

	<input type="hidden" value="" id="fromElsAccount" name="fromElsAccount"></input>
	<input type="hidden" value=""  id="fromElsSubAccount" name="fromElsSubAccount"></input>
	<input type="hidden" value="" id="toElsAccount" name="toElsAccount"></input>
	<input type="hidden" id="requestId" name="requestId" value="">
	
	<input type="hidden" id="rejectReason" name="rejectReason" value="">
	    <div class="input-and-tip text-left">
	        <span class="edit-sub-title">
		         <i18n:I18n key="i18n_account_title_rejectReason" defaultValue="拒绝理由" />：
		    </span>
	    </div>
		<div class="input-and-tip text-left">
		    <center>
			    <textarea id="rejectMsg" rows="4" cols="40"></textarea>
			</center>
		</div>
		
		<div style="text-align: center; padding: 5px">
		     <button onclick="rejectFriend();" class="button-wrap"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
		     <button class="button-wrap" onclick="closeWin()" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>	
		</div>
</form>
</div>

<script type="text/javascript">

requestId=GetQueryString("requestId");

elsAccount='<%=session.getAttribute("elsAccount") %>';
elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';

// 	function init(){
		
// 		showGroupSelect(1);
// 		showGroupSelect(2);
// 	}
	
// 	$(function() {
// 		init();
// 	});

	
	function rejectFriend(){
		$("#requestId").val(requestId);
		 var rejectMsg=document.getElementById("rejectMsg").value;
			
		 if(rejectMsg.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_rejectReasonRequired" defaultValue="请输入拒绝理由!" />',2);
			 return;
		 }
		 
		 $('#rejectReason').val(rejectMsg);
		 
		 var frm = $("#friendVerifyForm");
		 debugger;
		 $.ajax({
				url : "../rest/FriendsService/rejectFriendsRequest",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />',1);
// 					setTimeout(function(){				     
// 						closeWin();
// 					 }, "3000"); 
					closeWin();

				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />',1);
					closeWin();
				}
			});	
		 
	}
	
	
	function closeWin(){
// 		parent.elsDeskTop.closeCurWin('addFriends');
//		parent.frames['iframeApp_'+parentWinId].queryAccount();
 		parent.frames['iframeApp_friendVerify'].queryAccount();
        parent.elsDeskTop.closeCurWin('rejectFriend');
	}
</script>
	
</body>
</html>