<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            <button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
            <button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
            <button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
            <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
        </div>
    </div>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<div class="common-box-line">
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="组织类别" key=""/>:</span>
				<input type="text" id="orgCategoryId" name="orgCategoryId" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="组织描述" key=""/>:</span>
				<input type="text" id="orgCategoryDesc" name="orgCategoryDesc" />
			</div>	
		</div>
	</div>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_projectManagerHead" defaultValue="项目管理头" /></span>
		<div class="common-box-line">
			<main class="grid-container">
				<div class="grid-100" id="headDiv">
					<table id="headTable"></table>
					<div id="headPage" style="text-align: right;"></div>
				</div>
			</main>
		</div>
	</div>
</div>

<div class="fixed-dialog" id="orgCategoryAdd" >
	<div class="dialog-tip bg-common" style="width: 502px;height: 340px;margin-left: -251px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="btnAddClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="新增组织类别" key=""/></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="输入组织类别信息" key=""/></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="组织类别编码" key=""/>:</td>
	                		<td><input class="easyui-textbox" type="text" id="orgCategoryIdAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="组织类别描述" key=""/>:</td>
	                		<td><input class="easyui-textbox" type="text" id="orgCategoryDescAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="备注" key=""/>:</td>
	                		<td><input class="easyui-textbox" type="text" id="remarkAdd" /></td>
	                	</tr>
	                </table>
	            </div>
	            <div class="mt-40 text-center" >
	                <button id="btnAddOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                <button id="btnAddCancel" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	            </div>
	        </div>
    </div>
</div>

<script type="text/javascript">
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";

var headCols = [
	{ title:"<i18n:I18n key='i18n_saleorderhis_title_elsaccount' defaultValue='ELS号' />", name:"elsAccount", width:100, align:"center"},
	{ title:"<i18n:I18n key='i18n_common_title_elsDesc' defaultValue='ELS描述' />", name:"elsDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='组织类别编码' />", name:"orgCategoryId", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='组织类别描述' />", name:"orgCategoryDesc", width:300, align:"center"},
	{ title:"<i18n:I18n key='i18n_common_title_remarks' defaultValue='备注' />", name:"remark" , width:100, align:"center"},
];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/queryOrganizationCategory",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : headCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : false,
	checkCol : true,
	indexCol : false,
	plugins : [
	    $("#headPage").mmPaginator({
	        style : "plain",
	        totalCountName : "total",
	        page : 1,
	        pageParamName : "currentPage",
	        limitParamName : "pageSize",
	        limitLabel : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	        totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	        limit : null,
	        limitList : [10,20]
	    })
	]
});

$(document).ready(function(){
	//初始化控件
	$("button").button();
    refreshData();
});

$("#queryBtn").click(function(){
	refreshData();
});
var opType = "";
var updRowIndex;
$("#addBtn").click(function(){
	clearAddInfo();
	opType = "add";
	$("#orgCategoryAdd").show();
});

$("#btnAddOK").click(function(){
	migrationAddInfo();
});

$("#btnAddCancel").click(function(){
	$("#orgCategoryAdd").hide();
	clearAddInfo();
});

$("#btnAddClose").click(function(){
	$("#orgCategoryAdd").hide();
	clearAddInfo();
});

$("#updBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	var selectRowIndexs = headGrid.selectedRowsIndex();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var selectRecord = selectRows[0];
		opType = "upd";
		updRowIndex = selectRowIndexs[0];
		$("#orgCategoryIdAdd").val(selectRecord.orgCategoryId);
		$("#orgCategoryDescAdd").val(selectRecord.orgCategoryDesc);
		$("#remarkAdd").val(selectRecord.remark);
		
		$("#orgCategoryAdd").show();
	}
	
});

$("#saveBtn").click(function(){
	var rows = headGrid.rowsLength()==0?[]:headGrid.rows();
	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中' key='i18n_requirementsPlanning_alert_inTheSave'/>");
	$.ajax({
		url :"${pageContext.request.contextPath}/rest/ElsOrganizationService/saveOrganizationCategory",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(rows),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if("200"==data.statusCode){
				alert("<i18n:I18n defaultValue='保存成功' key='i18n_common_alert_savesuccess'/>",1);
				refreshData();//刷新页面数据
			} else {
				alert("<i18n:I18n defaultValue='保存出错' key='i18n_common_alert_saveError'/>",3);
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n defaultValue='保存出错' key='i18n_common_alert_saveError'/>",3);
		}
	});
});

$("#delBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	var selectRowIndexs = headGrid.selectedRowsIndex();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除?" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/delOrganizationCategory",
	    		contentType : "application/json",
	    		type : "post",
	    		data : JSON.stringify(selectRows),
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			if("200"==data.statusCode){
	    				alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
	    				headGrid.removeRow(selectedIndexes);
	    			} else {
	    				alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",3);
	    			}
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",3);
	    		}
	    	});
		}});
	}
});

function clearAddInfo(){
	$("#orgCategoryIdAdd").val("");
	$("#orgCategoryDescAdd").val("");
	$("#remarkAdd").val("");
}

function migrationAddInfo(){
	var orgCategoryIdAdd = $("#orgCategoryIdAdd").val();
	var orgCategoryDescAdd = $("#orgCategoryDescAdd").val();
	var remarkAdd = $("#remarkAdd").val();
	var newRecord = {
			elsAccount : elsAccount,
			elsDesc : elsDesc,
			orgCategoryId : orgCategoryIdAdd,
			orgCategoryDesc : orgCategoryDescAdd,
			remark : remarkAdd,
	};
	if("add"==opType){
		newRecord["operationType"] = "add";
		headGrid.addRow(newRecord);//插入到最后一行
	} else if("upd"==opType){
		if("undefined"!=typeof(updRowIndex)){
			newRecord["operationType"] = "upd";
			headGrid.updateRow(newRecord,updRowIndex);
		}
	} else {
		
	}
	clearAddInfo();
	$("#orgCategoryAdd").hide();
}

function refreshData(){
	var orgCategoryId = $("#orgCategoryId").val();
	var orgCategoryDesc = $("#orgCategoryDesc").val();
	
	var queryParam = {
    	elsAccount : elsAccount,
    	orgCategoryId : orgCategoryId,
    	orgCategoryDesc : orgCategoryDesc,
    };
    $.extend(headGrid.opts.params,queryParam);
    headGrid.load();
}
</script>
</body>
</html>