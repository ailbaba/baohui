<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String standardNumber = request.getParameter("standardNumber"); %>
<%  String standardItemNumber = request.getParameter("standardItemNumber"); %>
<%  String contactId = request.getParameter("contactId"); %>


<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 130px;
		padding-left: 20px;
		padding-top: 3px ;
		text-align: right;
	}
</style>

<form id="ContractForm" action="" method="post">
<table>
		<tr>
			<td align="right" style="width: 150px;">ELS账号：</td>
			<td><input  class="" type="text" id="elsAccount" name="elsAccount" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">角色：</td>
			<td><input  class="" type="text" id="contactRole" name="contactRole" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">职务：</td>
			<td><input  class="" type="text" id="contactPosition" name="contactPosition" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">姓名：</td>
			<td><input  class="" type="text" id="contactName" name="contactName" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">邮箱：</td>
			<td><input  class="" type="text" id="email" name="email" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">手机：</td>
			<td><input  class="" type="text" id="mobile" name="mobile" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">电话：</td>
			<td><input  class="" type="text" id="telephone" name="telephone" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">传真：</td>
			<td><input  class="" type="text" id="fax" name="fax" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">是否默认：</td>
			<td>
			<select class="" id="isDefault" name="isDefault">
				<option value=0><i18n:I18n key="i18n_common_no" defaultValue="否" /></option>
				<option value=1><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
			</select>
			</td>
		</tr>
		<tr>
			<td align="right">公开模式：</td>
			<td>
			<select class="" id="publicMode" name="publicMode">
				<option value=0><i18n:I18n key="i18n_common_no" defaultValue="否" /></option>
				<option value=1><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
			</select>
			</td>
		</tr>
</table>
</form>	

<div style="text-align: center; padding: 5px">
<button id="UpdateContractOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
<button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
</div>

<script type="text/javascript">
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	var standardItemNumber = '<%= standardItemNumber%>';
	var standardNumber = '<%= standardNumber%>';
	var contactId = '<%= contactId%>';
	
	$(function() {
		$("#elsAccount").val(elsAccount);
// 		$("#standardNumber").val(standardNumber);
// 		$("#standardItemNumber").val(standardItemNumber);
	});
	$("#UpdateContractOK").click(function(){
		$("#standardNumber").val(standardNumber);
		$("#standardItemNumber").val(standardItemNumber);
		$("#contactId").val(contactId);
		 var frm = $("#ContractForm");
		 console.log(frm);
		 $.ajax({
				url :"<%=basePath%>rest/SupplierDataService/updateStandardContactInfo",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="test" defaultValue="修改成功" />',1);
					setTimeout(function(){				     
						closeWin();
					}, "1000"); 
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});
	});
	
	
	$(document).ready(function(){
		initContractInfo();
	});

	$("#closeWin").click(function(){
		closeWin();
	});
	
	function initContractInfo(){
		var params = {"elsAccount":elsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber,"contactId":contactId}
		$.ajax({
			url :"<%=basePath%>rest/SupplierDataService/queryStandardContactInfo",
			type        : "POST",
			contentType : "application/json",
			data        : JSON.stringify(params),
			dataType    : "json",
			success     : function(data) {
				//加载对应的数据
				$("#contactRole").val(data.rows[0].contactRole);
				$("#contactName").val(data.rows[0].contactName);
				$("#contactPosition").val(data.rows[0].contactPosition);
				$("#email").val(data.rows[0].email);
				$("#mobile").val(data.rows[0].mobile);
				$("#telephone").val(data.rows[0].telephone);
				$("#fax").val(data.rows[0].fax);
				$("#isDefault").val(data.rows[0].isDefault);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
			}
		});
	}
	
	function closeWin(){
		parent.frames['iframeApp_showInfo'].queryInfo();
        parent.elsDeskTop.closeCurWin('supplierContactInfo');
	}
	
    function operation(name){
    	$('#'+name+"_span").html('');
    	$('body').data(name,false);
    	var email = $('body').data('email');
    	var telphone1 = $('body').data('telphone1');
    	var employeeNumber = $('body').data('employeeNumber');
    	if(!email&&!telphone1&&!employeeNumber){
    		$("#UpdateContractOK").attr('disabled',false);
    	}
    }
</script>
</body>
</html>