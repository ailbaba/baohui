<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

<style type="text/css" media="screen">
html, body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
}

#flashContent {
	display: none;
}

table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
				key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
		    <button id="save-requirementType" class="button-wrap save-isShow">保存</button>
			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
	
	<form id="requiremenTypeForm">
		<input type="hidden" id="elsAccount" name="elsAccount"/>
		<input type="hidden" id="requirementTypeCodeTmp" name="requirementTypeCodeTmp"/>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本数据</span>
			<div class="common-box-line">
				<div class="tab-wrap" id="add-enq-sheet">
					<ul>
						<li><a href="#edit-line-baseInfo">基本信息</a></li>
					</ul>
					
					<!-- 基本信息 -->
					<div id="edit-line-baseInfo">
					 <table border="0">
				    	<tbody>
				    	    <tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_requirementTypeHead_table_requirementGroupCode" defaultValue="需求组编号:" /></td>
				    			<td colspan="1" align="left">
									<input id="requirementGroupCode" name="requirementGroupCode" type="text" style="width: 200px;" /><!-- <span style="color: red;">*</span> -->
								</td>
								<td colspan="1" align="right" width="120px"><i18n:I18n key="i18n_requirementTypeHead_table_requirementGroupName" defaultValue="需求组名称:" /></td>
				    			<td colspan="1" align="left">
									<input id="requirementGroupName" name="requirementGroupName" type="text" style="width: 200px;"/><!-- <span style="color: red;">*</span> -->
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_requirementTypeHead_table_requirementTypeCode" defaultValue="需求类型编号:" /></td>
				    			<td colspan="1" align="left">
									<input id="requirementTypeCode" name="requirementTypeCode" type="text" style="width: 200px;" /><span style="color: red;">*</span>
								</td>
								<td colspan="1" align="right" width="120px"><i18n:I18n key="i18n_requirementTypeHead_table_requirementTypeName" defaultValue="需求类型名称:" /></td>
				    			<td colspan="1" align="left">
									<input id="requirementTypeName" name="requirementTypeName" type="text" style="width: 200px;"/><span style="color: red;">*</span>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_requirementTypeHead_table_lockStatus" defaultValue="锁定需求类型" />:</td>
				    			<td colspan="3" align="left">
				    			     <input type="checkbox" id="lockStatus" name="lockStatus"><span><i18n:I18n key="i18n_requirementTypeHead_table_locked" defaultValue="锁定" /></span>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_label_remark" defaultValue="备注" />:</td>
				    			<td colspan="3" align="left">
				    				<input id="remark" name="remark" type="text" style="width: 300px;"/>
								</td>
				    		</tr>
				    	</tbody>
				      </table>
					</div>
				</div>
			</div>
		</div>
		</form>
		
<script type="text/javascript">
var phasesTable;//标段mmgrid 表实体
var phasesRoundTable;//各阶段轮次 mmgrid 表实体
var requirementTypeCode ="<%=request.getParameter("requirementTypeCode") %>";

$().ready(function(){
	$( '#add-enq-sheet').tabs();
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	$(".tag-isShow").hide();
	$(".publish-isShow").hide();
	initUpdatePage();
	$("#lockStatus").click(function(){
		if ("checked" == $(this).attr("checked")) {
	    	$(this).attr("value",1);
	    } else {
	    	$(this).attr("value",0);
	    }
	});
});
//修改操作时执行此方法
function initUpdatePage(){
	//debugger;
	if(requirementTypeCode == "null" || requirementTypeCode == ""){
		return;
	}
	$("#requirementTypeCodeTmp").val(requirementTypeCode);
	var param = {"elsAccount":elsAccount,"requirementTypeCode":requirementTypeCode};
	$.ajax({
		url :"<%=basePath%>rest/RequirementTypeService/load",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(param),
		success : function(data) {
			//加载基本信息
			$("#requirementGroupCode").val(data.requirementGroupCode);
			$("#requirementGroupName").val(data.requirementGroupName);
			$("#requirementTypeCode").val(data.requirementTypeCode);
			$("#requirementTypeName").val(data.requirementTypeName);
			if (1 == data.lockStatus) {
				$("#lockStatus").attr("checked", true);
			}
			$("#remark").val(data.remark);
		},
		error: function (xhr, type, exception) {
			//获取ajax的错误信息
			parent.elsDeskTop.hideLoading();
            alert("加载标信息失败:"+exception,3); 
        }
	});
}

//增加
$("#save-requirementType").click(function() {
	if($("#lockStatus").attr("checked")=="checked") {
		$("#lockStatus").attr("value",1);
	}
	// 非空校验
	if($("#requirementTypeCode").val().trim().length==0) {
		alert("<i18n:I18n key='i18n_requirementType_alert_requirementTypeCode_blank' defaultValue='需求类型编号不能为空！'/>！",2);
		$("#requirementTypeCode").focus();
		return ;
	}
	if($("#requirementTypeName").val().trim().length==0) {
		alert("<i18n:I18n key='i18n_requirementType_alert_requirementTypeName_blank' defaultValue='需求类型名称不能为空！'/>！",2);
		$("#requirementTypeName").focus();
		return ;
	}
	var frm = $("#requiremenTypeForm");
	var frmObj = frm.serializeJSON();

	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_requirementsPlanning_alert_inTheSave" defaultValue="保存中..." />');
	var operType = "update";
	var closeCurWinId = 'updrequirementType';
	if(requirementTypeCode == "null" || requirementTypeCode == ""){
		operType = "add";
		closeCurWinId = 'addrequirementType';
	}
	$.ajax({
		url :"<%=basePath%>rest/RequirementTypeService/"+operType,
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(frmObj),
		success : function(data) {
			if(data.statusCode == "-100"){
				parent.elsDeskTop.hideLoading();
				alert(data.message,3);
			} else if(data.statusCode == "-200"){
				parent.elsDeskTop.hideLoading();
				alert(data.message,2);
			} else {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
				parent.frames['iframeApp_requirementTypeManage'].queryrequirementType();
			    parent.elsDeskTop.closeCurWin(closeCurWinId);
			}
		},
		error: function (data) {//获取ajax的错误信息
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
      }
});
	
});


$("#exitBtn").click(function(){
	if(requirementTypeCode == "null" || requirementTypeCode == ""){
		parent.elsDeskTop.closeCurWin('addrequirementType',callBack);
	} else {
		parent.elsDeskTop.closeCurWin('updrequirementType',callBack);
	}
});

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_requirementTypeManage']) {
		parent.frames['iframeApp_requirementTypeManage'].queryrequirementType();
	}

}

</script>
</body>
</html>