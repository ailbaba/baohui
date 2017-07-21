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
<form id="ContractForm" action="" method="post">
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
			<td align="right">角色：</td>
			<td>
			<select class="" id="contactRole" name="contactRole">
				<option value="法人">法人</option>
				<option value="销售">销售</option>
				<option value="采购">采购</option>
				<option value="品质">品质</option>
				<option value="研发">研发</option>
				<option value="管理">管理</option>
				<option value="计划">计划</option>
				<option value="物控">物控</option>
				<option value="生产">生产</option>
				<option value="仓库">仓库</option>
			</select>
			</td>
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
				<option value=1><i18n:I18n key="i18n_common_no" defaultValue="否" /></option>
				<option value=2><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
			</select>
			</td>
		</tr>
		<tr>
			<td align="right">公开模式：</td>
			<td>
			<select class="" id="publicMode" name="publicMode">
				<option value="1">默认不公开</option>
				<option value="2">对所有公开</option>
				<option value="3">仅对合作伙伴公开</option>
				<option value="4">仅当前伙伴公开</option>
			</select>
			</td>
		</tr>
</table>
</form>
</div>

<div style="text-align: center; padding: 5px">
<button id="addContractOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
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
// 		$("#standardNumber").val(standardNumber);
// 		$("#standardItemNumber").val(standardItemNumber);
	});
	$("#addContractOK").click(function(){
		$("#standardNumber").val(standardNumber);
		$("#standardItemNumber").val(standardItemNumber);
		 var frm = $("#ContractForm");
		 $.ajax({
				url :"<%=basePath%>rest/SupplierDataService/addStandardContactInfo",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
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
		parent.frames['iframeApp_supplierContactInfoManage'].queryInfo();
        parent.elsDeskTop.closeCurWin('supplierContactInfo');
	}
	
    function operation(name){
    	$('#'+name+"_span").html('');
    	$('body').data(name,false);
    	var email = $('body').data('email');
    	var telphone1 = $('body').data('telphone1');
    	var employeeNumber = $('body').data('employeeNumber');
    	if(!email&&!telphone1&&!employeeNumber){
    		$("#addContractOK").attr('disabled',false);
    	}
    }
</script>
</body>
</html>