<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 72px;
		padding-left: 20px;
		padding-top: 3px ;
		text-align: right;
	}
</style>
<form id="subAccountForm" action="" method="post">
		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n defaultValue="els账号" key="i18n_common_title_elsaccount"></i18n:I18n>：</span>
			<input style="max-width:100%;" readonly  type="text" id="elsAccount" name="elsAccount" />
		</div>
		<div class="input-and-tip text-left">
			<span class="edit-sub-title"><i18n:I18n defaultValue="子账号" key="i18n_common_title_elssubaccount"></i18n:I18n>：</span>
			<input style="max-width:100%;" readonly  type="text" id="elsSubAccount" name="elsSubAccount" />
		</div>
	
		<div class="input-and-tip text-left">
			<span class="edit-sub-title"><i18n:I18n defaultValue="新密码" key="i18n_password_title_newPassword"></i18n:I18n>：</span>
			<input style="max-width:100%;"   type="password" id="newPassword" name="newPassword" />
		</div>
		<div class="input-and-tip text-left">
			<span class="edit-sub-title"><i18n:I18n defaultValue="新密码确认" key="i18n_password_title_newPasswordConfirm"></i18n:I18n>：</span>
			<input style="max-width:100%;"   type="password" id="newPasswordConfirm" name="newPasswordConfirm" />
		</div>
		
</form>
<div style="text-align: center; padding: 5px">
    <button id="editSubAccountOK" class="button-wrap" ><i18n:I18n defaultValue="更改密码" key="i18n_account_button_passwordchange"></i18n:I18n></button>
    <button id="closeWin" class="button-wrap" ><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"></i18n:I18n> </button>
</div>
<script type="text/javascript">
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsSubAccount=GetQueryString("elsSubAccount");
$(document).ready(function(){
	init();
	$("#editSubAccountOK").click(function(){
		var Newpassword = $("#newPassword").val();
		var passwordConfirm = $("#newPasswordConfirm").val();
		if(Newpassword.length<6){
			alert("密码长度至少6位",2);
			return;
		}
			if(Newpassword!=passwordConfirm){
				alert("密码不一致",2);
				return;
			}
		changePassword();
	});
	
	$("#closeWin").click(function(){
		closeWin();
	});
	function closeWin(){
		parent.frames['iframeApp_accountManage'].queryAccountInfo();
        parent.elsDeskTop.closeCurWin('changePassword');

	}
	
});	

function init(){
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
}

//修改密码
function changePassword(){
	var elsSubAccount = $("#elsSubAccount").val();
	var newPassword = $("#newPasswordConfirm").val();
	 $.ajax({
			url :"<%=basePath%>rest/AccountService/adminChangePassword",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"newPassword":newPassword}),
			success : function(data) {
				alert("修改成功", 1); 
				$("#newPassword").val("");
				$("#newPasswordConfirm").val("");
			},
			error: function (xhr, type, exception) {
            	alert(xhr.responseText, "Failed"); 
        	}
		});
}

</script>

</body>
</html>