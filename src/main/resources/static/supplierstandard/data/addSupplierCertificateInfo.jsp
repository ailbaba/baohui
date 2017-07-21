<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String standardNumber = request.getParameter("standardNumber"); %>
<%  String standardItemNumber = request.getParameter("standardItemNumber"); %>
<%  String toElsAccount = request.getParameter("toElsAccount"); %>

<style>
table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>

<body>
<div class="box-wrap pos-relative bg-common">
<form id="CertificateInfoForm" action="" method="post">
<table>
		<tr>
			<td align="right" style="width: 150px;">ELS账号：</td>
			<td><input readonly  class="" type="text" id="elsAccount" name="elsAccount" style="width: 180px; max-width: 180px;"/></td>
			<td><input readonly class="" type="hidden" id="standardNumber" name="standardNumber" style="width: 180px; max-width: 180px;"/></td>
			<td><input readonly class="" type="hidden" id="standardItemNumber" name="standardItemNumber" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right" style="width: 150px;">对方ELS账号：</td>
			<td><input   class="" type="text" id="toElsAccount" name="toElsAccount" style="width: 180px; max-width: 180px;" /></td>
		</tr>
		<tr>
			<td align="right">认证类型：</td>
			<td>
					<input  class="" type="text" id="certificateType" name="certificateType" style="width: 180px; max-width: 180px;"/>
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
				<option value= "1">未认证</option>
				<option value= "2">已认证</option>
			</select></td>
		</tr>
		<tr>
			<td align="right">认证日期：</td>
			<td><input  type="text" id="" class="Wdate" name="logtime"
										onfocus="WdatePicker({startDate:'%y-%M-%d ',dateFmt:'yyyy-MM-dd ',alwaysUseStartDate:true})"
										name="" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">认证生效期：</td>
			<td><input  type="text" id="" class="Wdate" name="validBeginTime"
										onfocus="WdatePicker({startDate:'%y-%M-%d ',dateFmt:'yyyy-MM-dd ',alwaysUseStartDate:true})"
										name="" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">认证失效期：</td>
			<td><input  type="text" id="" class="Wdate" name="validEndTime"
										onfocus="WdatePicker({startDate:'%y-%M-%d ',dateFmt:'yyyy-MM-dd ',alwaysUseStartDate:true})"
										name="" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">备注：</td>
			<td><input   class="" type="text" id="remark" name="remark" style="width: 180px; max-width: 180px;"/></td>
		</tr>
</table>
</form>	

</div>

<div style="text-align: center; padding: 5px">
	<button id="addSubAccountOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
	<button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
</div>
<script type="text/javascript">
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	var standardItemNumber = '<%= standardItemNumber%>';
	var standardNumber = '<%= standardNumber%>';
	var toElsAccount = '<%= toElsAccount%>';
	$(function() {
		$("#elsAccount").val(elsAccount);
		//$("#toElsAccount").val(toElsAccount);
	});

	$("#addSubAccountOK").click(function(){
		var frm = $("#CertificateInfoForm");
		$("#standardNumber").val(standardNumber);
		$("#standardItemNumber").val(standardItemNumber);
		
		$.ajax({
			url :"<%=basePath%>rest/SupplierDataService/addStandardCertificateInfo",
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
	
	function closeWin(){
		parent.frames['iframeApp_supplierCertificateInfoManage'].queryInfo();
        parent.elsDeskTop.closeCurWin('supplierCertificateInfo');
	}
	
    function operation(name){
		$('#'+name+"_span").html('');
		$('body').data(name,false);
		var email = $('body').data('email');
		var telphone1 = $('body').data('telphone1');
		var employeeNumber = $('body').data('employeeNumber');
		if(!email&&!telphone1&&!employeeNumber){
			$("#addSubAccountOK").attr('disabled',false);
		}
    }
</script>

</body>
</html>