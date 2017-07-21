<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<form id="form" onsubmit="return false;" method="POST" action="<%=basePath%>rest/AuditService/saveAuditConfig">
		<input type="hidden" name="elsAccount" value="<%=session.getAttribute("elsAccount")%>"/>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_supplierAuth" defaultValue="供应商权限" /></span>
			<div class="common-box-line">		
				<main class="grid-container">
				<div class="grid-100">
					<table id="table-head"></table>
				</div>
				</main>
			</div>
		</div>
		</form>
	</div>
<script type="text/javascript">
var cols = [{ title:'<i18n:I18n defaultValue="对方公司一级类型" key="i18n_common_title_stairType"/>', name:'groupIdA' ,width:150, align:'center',renderer:function(val){
			if (val == "supplier") {
				return "<i18n:I18n defaultValue="供应商" key="i18n_label_supplier"/>";
			} else if (val == "potentialSupplier") {
				return "<i18n:I18n defaultValue="潜在供应商" key="i18n_label_potential_supplier"/>";
			} else if (val == "unfamiliarSupplier") {
				return "<i18n:I18n defaultValue="陌生供应商" key="i18n_label_unfamiliar_supplier"/>";
			} else if (val == "eliminateSupplier") {
				return "<i18n:I18n defaultValue="失效供应商" key="i18n_label_eliminate_supplier"/>";
			}
		}}];
var grid;
function genCheckbox(val,item,index,code) {
	if (item.authCode&&item.authCode.indexOf(code)!=-1) {
		return "<input type='checkbox' name='itemList[]' value='"+item.groupIdA+"-"+code+"' checked/>";
	} else {
		return "<input type='checkbox' name='itemList[]' value='"+item.groupIdA+"-"+code+"'/>";
	}
}
$().ready(function(){
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('supplierAuthSet');
	});
	$("#saveBtn").click(function(){
		$.ajax({
			url :"<%=basePath%>rest/SupplierAuthSetService/updateSupplierAuthSet",
			type : "post",
			data : JSON.stringify($("#form").serializeJSON()),
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			},
			error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	//读取权限
	$.ajax({
		url :"<%=basePath%>rest/SupplierAuthSetService/getSupplierAuth/",
		type : "get",
		dataType : "json",
		contentType : "application/json",
		success : function(data) {
			for (var i=0;i<data.rows.length;i++) {
				var item = {title:data.rows[i].authName,name:data.rows[i].authCode,width:100, align:'center',renderer:genCheckbox};
				cols.push(item);
			}
			grid= $('#table-head').mmGrid({
		    	 cols: cols,
		    	 url : "<%=basePath%>rest/SupplierAuthSetService/getSupplierAuthSet/" + elsAccount,
		         method:  "get",
		         root:"rows",
		         loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		         noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			});
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
});
		
</script>
</body>
</html>