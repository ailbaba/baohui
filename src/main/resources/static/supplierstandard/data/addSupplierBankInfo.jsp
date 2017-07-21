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
<form id="BankInfoForm" action="" method="post">
	<table>
		<tr>
			<td align="right" style="width: 150px;">ELS账号：</td>
			<td><input readonly class="" type="text" id="elsAccount" name="elsAccount" style="width: 180px; max-width: 180px;"/></td>
			<td><input readonly class="" type="hidden" id="standardNumber" name="standardNumber" style="width: 180px; max-width: 180px;"/></td>
			<td><input readonly class="" type="hidden" id="standardItemNumber" name="standardItemNumber" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right" style="width: 150px;">对方ELS账号：</td>
			<td><input   class="" type="text" id="toElsAccount" name="toElsAccount" style="width: 180px; max-width: 180px;" /></td>
		</tr>
		<tr>
			<td align="right">国家名：</td>
			<td><input  class="" type="text" id="countryName" name="countryName" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">开户银行：</td>
			<td><input  class="" type="text" id="bankName" name="bankName" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">开户银行网点名称：</td>
			<td><input  class="" type="text" id="bankBranch" name="bankBranch" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">银行账号：</td>
			<td><input  class="" type="text" id="bankAccount" name="bankAccount" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">银行账号名：</td>
			<td><input  class="" type="text" id="bankAccountName" name="bankAccountName" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">电话：</td>
			<td><input  class="" type="text" id="telphone2" name="telphone2" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">银行代码：</td>
			<td><input  class="" type="text" id="backCode" name="backCode" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">国家银行标准账号：</td>
			<td><input  class="" type="text" id="standardAccount" name="standardAccount" style="width: 180px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align="right">开户银行网点地址：</td>
			<td><input  class="" type="text" id="bankBranchAddress" name="bankBranchAddress" style="width: 180px; max-width: 180px;"/></td>
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
	<button id="addBankInfo" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
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

	$("#addBankInfo").click(function(){
		var frm = $("#BankInfoForm");
		$("#standardNumber").val(standardNumber);
		$("#standardItemNumber").val(standardItemNumber);
		$.ajax({
			url :"<%=basePath%>rest/SupplierDataService/addStandardBankInfo",
			type        : "POST",
			contentType : "application/json",
			data        : JSON.stringify(frm.serializeJSON()),
			dataType    : "json",
			success     : function(data) {
				alert('<i18n:I18n key="test" defaultValue="新增成功" />',1);
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
		parent.frames['iframeApp_supplierBankInfoManage'].queryInfo();
        parent.elsDeskTop.closeCurWin('supplierBankInfo');
	}

    function operation(name){
    	$('#'+name+"_span").html('');
    	$('body').data(name,false);

    	var email          = $('body').data('email');
    	var telphone1      = $('body').data('telphone1');
    	var employeeNumber = $('body').data('employeeNumber');

    	if(!email&&!telphone1&&!employeeNumber){
    		$("#addBankInfo").attr('disabled',false);
    	}
    }
</script>

</body>
</html>