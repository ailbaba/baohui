<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String standardNumber = request.getParameter("standardNumber"); %>
<%  String standardItemNumber = request.getParameter("standardItemNumber"); %>
<%  String communicationId = request.getParameter("communicationId"); %>

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
<form id="CommunicationInfoForm" action="" method="post">
<table>
		<tr>
			<td align="right" style="width: 150px;">ELS账号：</td>
			<td><input  class="" type="text" id="elsAccount" name="elsAccount" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">地址类型：</td>
			<td>
				<select class="" id="addressType" name="addressType">
					<option value=""><i18n:I18n key="" defaultValue="" /></option>
					<option value=""><i18n:I18n key="" defaultValue="" /></option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">国家：</td>
			<td><input  class="" type="text" id="countries" name="countries" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">省：</td>
			<td><input  class="" type="text" id="provinces" name="provinces" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">市：</td>
			<td><input  class="" type="text" id="city" name="city" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">详细地址：</td>
			<td><input  class="" type="text" id="detailedAddress" name="detailedAddress" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">语言：</td>
			<td><input  class="" type="text" id="language" name="language" style="width: 180px; max-width: 180px;"/></td>
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
			<td align="right">关联组织结构：</td>
			<td><input  class="" type="text" id="organization" name="organization" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">时区：</td>
			<td><input  class="" type="text" id="timeZones" name="timeZones" style="width: 180px; max-width: 180px;"/></td>
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
</table>
</form>	
<div style="text-align: center; padding: 5px">
	<button id="UpdateCommunicationOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok"     defaultValue="确定" /></button>
	<button id="closeWin"           class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭" /></button>
</div>
<script type="text/javascript">
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	var standardItemNumber = '<%= standardItemNumber%>';
	var standardNumber = '<%= standardNumber%>';
	var communicationId = '<%= communicationId%>';
	
	$(function() {
		$("#elsAccount").val(elsAccount);
	});
	$("#UpdateCommunicationOK").click(function(){
		 var frm = $("#CommunicationInfoForm");
			$("#standardNumber").val(standardNumber);
			$("#standardItemNumber").val(standardItemNumber);
			$("#communicationId").val(communicationId);
		 $.ajax({
			url         : "<%=basePath%>rest/SupplierDataService/updateStandardCommunicationInfo",
			type        : "POST",
			contentType : "application/json",
			data        :  JSON.stringify(frm.serializeJSON()),
			dataType    : "json",
			success     : function(data) {
				alert('<i18n:I18n key="test" defaultValue="修改成功:" />');
				setTimeout(function(){				     
					closeWin();
				}, "1000"); 
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
			}
		});
	});

	$("#closeWin").click(function(){
		closeWin();
	});
	
	$(document).ready(function(){
		initCommunicationInfo();
	});
	
	function closeWin(){
		parent.frames['iframeApp_showInfo'].queryInfo();
        parent.elsDeskTop.closeCurWin('supplierCommunicationInfo');
	}
    
	function initCommunicationInfo(){
		var params = {"elsAccount":elsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber,"communicationId":communicationId}
		$.ajax({
			url :"<%=basePath%>rest/SupplierDataService/queryStandardCommunicationInfo",
			type        : "POST",
			contentType : "application/json",
			data        : JSON.stringify(params),
			dataType    : "json",
			success     : function(data) {
				//加载对应的数据
				$("#addressType").val(data.rows[0].addressType);
				$("#countries").val(data.rows[0].countries);
				$("#provinces").val(data.rows[0].provinces);
				$("#city").val(data.rows[0].city);
				$("#detailedAddress").val(data.rows[0].detailedAddress);
				$("#language").val(data.rows[0].language);
				$("#telphone").val(data.rows[0].telphone);
				$("#fax").val(data.rows[0].fax);
				$("#organization").val(data.rows[0].organization);
				$("#timeZones").val(data.rows[0].timeZones);
				$("#isDefault").val(data.rows[0].isDefault);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
			}
		});
	}
	
    function operation(name){
    	$('#'+name+"_span").html('');
    	$('body').data(name,false);
    	var email = $('body').data('email');
    	var telphone1 = $('body').data('telphone1');
    	var employeeNumber = $('body').data('employeeNumber');
    	if(!email&&!telphone1&&!employeeNumber){
    		$("#UpdateCommunicationOK").attr('disabled',false);
    	}
    }
</script>
</body>
</html>