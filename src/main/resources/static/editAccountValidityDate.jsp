<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 100px;
		padding-left: 20px;
		padding-top: 20px ;
		text-align: right;
	}
</style>
<form id="elsAccountForm" action="" method="post">
	

		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"/>：</span>
			<input readonly class="" type="text" id="elsAccount" name="elsAccount" />
		</div>
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="账户有效期" key=""/>：</span>
		    <input class="" type="text" onfocus="WdatePicker()" id="accountValidityDate" name="accountValidityDate" />
		</div>
</form>		
		
        <div style="text-align: center; padding: 5px">
            <button id="addSubAccountOK" onclick="editElsAccount();" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" onclick="closeWin();" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>

<script type="text/javascript">


	$("#elsAccount").val("<%=request.getParameter("elsAccount") %>");
	
	function editElsAccount(){
		 var frm = $("#elsAccountForm");
		 $.ajax({
				url :'<%=basePath%>rest/FriendsService/updateAccountValidityDate',
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="i18n_delivery_updatesuccess" defaultValue="修改成功" />',1);
					setTimeout(function(){				     
						closeWin();
					 }, "1000"); 
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});
	}
	
	
	function closeWin(){
        parent.elsDeskTop.closeCurWin('editAccountValidityDate');
	}
</script>
	

</body>
</html>