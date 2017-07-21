<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String standardNumber = request.getParameter("standardNumber"); %>
<%  String standardItemNumber = request.getParameter("standardItemNumber"); %>
<%  String certificateId = request.getParameter("certificateId"); %>

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

<form id="CertificateInfoForm" action="" method="post">
<table>
		<tr>
			<td align="right" style="width: 150px;">ELS账号：</td>
			<td><input  class="" type="text" id="elsAccount" name="elsAccount" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">认证类型：</td>
			<td>
				<select class="" id="certificateType" name="certificateType">
					<option value=""><i18n:I18n key="" defaultValue="" /></option>
					<option value=""><i18n:I18n key="" defaultValue="" /></option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">证书编号：</td>
			<td><input  class="" type="text" id="certificateNumber" name="certificateNumber" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">认证机构名：</td>
			<td><input  class="" type="text" id="agencyName" name="agencyName" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">认证状态：</td>
			<td>
			<select class="" id="state" name="state">
				<option value=""><i18n:I18n key="" defaultValue="" /></option>
				<option value=""><i18n:I18n key="" defaultValue="" /></option>
			</select></td>
		</tr>
		<tr>
			<td align="right">认证日期：</td>
			<td><input  type="text" id="" class="Wdate" name="logtime"
										onfocus="WdatePicker({minDate:'%y-%M-%d ',startDate:'%y-%M-%d ',dateFmt:'yyyy-MM-dd ',alwaysUseStartDate:true})"
										name="" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">认证生效期：</td>
			<td><input  type="text" id="" class="Wdate" name="validBeginTime"
										onfocus="WdatePicker({minDate:'%y-%M-%d ',startDate:'%y-%M-%d ',dateFmt:'yyyy-MM-dd ',alwaysUseStartDate:true})"
										name="" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">认证失效期：</td>
			<td><input  type="text" id="" class="Wdate" name="validEndTime"
										onfocus="WdatePicker({minDate:'%y-%M-%d ',startDate:'%y-%M-%d ',dateFmt:'yyyy-MM-dd ',alwaysUseStartDate:true})"
										name="" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">备注：</td>
			<td><input   class="" type="text" id="remark" name="remark" style="width: 180px; max-width: 180px;"/></td>
		</tr>
</table>
</form>	

<div style="text-align: center; padding: 5px">
	<button id="updateCertificationInfo" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
	<button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
</div>
<script type="text/javascript">
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	var standardItemNumber = '<%= standardItemNumber%>';
	var standardNumber = '<%= standardNumber%>';
	var certificateId = '<%= certificateId%>';
	
	$(function() {
		$("#elsAccount").val(elsAccount);
	});

	$("#updateCertificationInfo").click(function(){
		var frm = $("#CertificateInfoForm");
		$("#standardNumber").val(standardNumber);
		$("#standardItemNumber").val(standardItemNumber);
		$("#certificateId").val(certificateId);
		$.ajax({
			url :"<%=basePath%>rest/SupplierDataService/updateStandardCertificateInfo",
			type :"POST",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				alert('<i18n:I18n key="test" defaultValue="新增成功" />' ,1);
				setTimeout(function(){	closeWin();	 }, "1000"); 
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
		initcertificateInfo();
	});
	
	function closeWin(){
		parent.frames['iframeApp_showInfo'].queryInfo();
        parent.elsDeskTop.closeCurWin('supplierCertificateInfo');
	}
	
	function initcertificateInfo(){
		var params = {"elsAccount":elsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber,"certificateId":certificateId}
		$.ajax({
			url :"<%=basePath%>rest/SupplierDataService/queryStandardCertificateInfo",
			type        : "POST",
			contentType : "application/json",
			data        : JSON.stringify(params),
			dataType    : "json",
			success     : function(data) {
				//加载对应的数据
				$("#certificateType").val(data.rows[0].certificateType);
				$("#certificateNumber").val(data.rows[0].certificateNumber);
				$("#agencyName").val(data.rows[0].agencyName);
				$("#state").val(data.rows[0].state);
				$("#logtime").val(data.rows[0].logtime);
				$("#validBeginTime").val(data.rows[0].validBeginTime);
				$("#validEndTime").val(data.rows[0].validEndTime);
				$("#remark").val(data.rows[0].remark);
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
			$("#updateCertificationInfo").attr('disabled',false);
		}
    }
</script>

</body>
</html>