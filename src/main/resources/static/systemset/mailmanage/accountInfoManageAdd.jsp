<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<style>
table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>
<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="邮件信息列表" /></span>
			  <div class="common-box-line" id="updateSupplyFormId">
			  <form id="form" onsubmit="return false;">
			   		<table>
						<tr>
							<td align="right">邮箱类型：</td>
							<td>
								<select class="" id="mailType" name="mailType" style="width: 164px; max-width: 164px; height:24px;">
									 <option value="">请选择</option>
				                     <option value="0">POP3</option>   	
				                     <option value="1">IMAP</option>		
				                     <option value="2">SMTP</option>		
			                    </select>
							</td>
						</tr>
						<tr>
							<td align="right">邮箱账号：</td>
							<td><input type="text" id="mailAccount" name="mailAccount" /></td>
						</tr>
						<tr>
							<td align="right">收件服务器：</td>
							<td><input type="text" id="receiptServer" name="receiptServer" width="200px;" /></td>
							<td align="right">&nbsp;&nbsp;<input type="checkbox" id="receiptSslCheck" name="receiptSslCheck" width="20px;"></td>
							<td align="right">&nbsp;SSL端口：</td>
							<td><input type="text" id="receiptSslPort" name="receiptSslPort" style="width:50px;"/></td>
						</tr>
						<tr>
							<td align="right">发件服务器：</td>
							<td><input type="text" id="sendServer" name="sendServer" width="200px;" /></td>
							<td align="right">&nbsp;&nbsp;<input type="checkbox" id="sendSslCheck" name="sendSslCheck" width="20px;" /></td>
							<td align="right">&nbsp;SSL端口：</td>
							<td><input type="text" id="sendSslServer" name="sendSslServer" style="width:50px;"/></td>
						</tr>
						<tr>
							<td align="right">企业 ELS：</td>
							<td><input type="text" id="elsAccount" name="elsAccount"  readonly = "readonly"/></td>
						</tr>
						<tr>
							<td align="right">个人账号：</td>
							<td><input type="text" id="elsSubAccount" name="elsSubAccount"  readonly = "readonly"/></td>
						</tr>
						<tr>
							<td align="right">个人邮箱：</td>
							<td><input type="text" id="email" name="email" /></td>
						</tr>
						<tr>
							<td align="right">密码：</td>
							<td><input type="password" id="passwd" name="passwd" /></td>
						</tr>
						<tr>
							<td align="right">备注：</td>
							<td colspan="3"><textarea id="remark" name="remark" rows="5" cols="300"></textarea></td>
						</tr>
					</table>
					</form>
			  </div>
			</div>
</div>


<script type="text/javascript">
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	
	$(document).ready(function(){
		init();
	});
	
	function init(){
		$("#elsAccount").val(elsAccount);
		$("#elsSubAccount").val(elsSubAccount);
	}
	
	$("#saveBtn").click(function(){
		debugger;
		var formObj = $("#form").serializeJSON();
		if($("#mailType").val()==''){
			alert("请选择邮箱类型!",2);
			return;
		}
		if($("#mailAccount").val()==''){
			alert("邮箱账号不能为空!",2);
			return;
		}
		var receiptSslCheck = $("#receiptSslCheck").is(':checked');
		if(receiptSslCheck){
			formObj["receiptSslCheck"]=1;
		}else{
			formObj["receiptSslCheck"]=0;
		}
		var sendSslCheck = $("#sendSslCheck").is(':checked');
		if(sendSslCheck){
			formObj["sendSslCheck"]=1;
		}else{
			formObj["sendSslCheck"]=0;
		}
	   	parent.elsDeskTop.showLoading('邮箱用户配置保存中!');
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/MailInfoManageService/insertMailAccountInfo",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(formObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
    			if(data.statusCode==-100){
    				alert(data.message,3);
    			}else{
    				alert("<i18n:I18n key='test' defaultValue='保存成功' />",1);
    				parent.elsDeskTop.closeCurWin('accountInfoManageAdd',callBack);
    			}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				parent.elsDeskTop.tip.init({type: 'alert',message:'保存出错！'});
			}
		});
	});
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
	function callBack(){
		if(parent.frames['iframeApp_accountInfoManage']) {
			parent.frames['iframeApp_accountInfoManage'].purchQuery();
		}
	}
	
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('accountInfoManageAdd');
	});
	
</script>
</body>
</html>