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
<form id="CommunicationInfoForm" action="" method="post">
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
			<td align="right">地址类型：</td>
			<td>
				<select class="" id="addressType" name="addressType">
					<option value="1">工厂/办事处</option>
					<option value="2">办公区</option>
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
				<option value=1><i18n:I18n key="i18n_common_no" defaultValue="否" /></option>
				<option value=2><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
			</select>
			</td>
		</tr>
</table>
</form>

</div>

<div style="text-align: center; padding: 5px">
	<button id="addCommunicationOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok"     defaultValue="确定" /></button>
	<button id="closeWin"           class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭" /></button>
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
	$("#addCommunicationOK").click(function(){
		 var frm = $("#CommunicationInfoForm");
			$("#standardNumber").val(standardNumber);
			$("#standardItemNumber").val(standardItemNumber);
		 $.ajax({
			url         : "<%=basePath%>rest/SupplierDataService/addStandardCommunicationInfo",
			type        : "POST",
			contentType : "application/json",
			data        :  JSON.stringify(frm.serializeJSON()),
			dataType    : "json",
			success     : function(data) {
				alert('<i18n:I18n key="test" defaultValue="新增成功:" />');
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
	
	function closeWin(){
		parent.frames['iframeApp_supplierCommunicationInfoManage'].queryInfo();
        parent.elsDeskTop.closeCurWin('supplierCommunicationInfo');
	}
    
    function operation(name){
    	$('#'+name+"_span").html('');
    	$('body').data(name,false);
    	var email = $('body').data('email');
    	var telphone1 = $('body').data('telphone1');
    	var employeeNumber = $('body').data('employeeNumber');
    	if(!email&&!telphone1&&!employeeNumber){
    		$("#addCommunicationOK").attr('disabled',false);
    	}
    }
</script>
</body>
</html>