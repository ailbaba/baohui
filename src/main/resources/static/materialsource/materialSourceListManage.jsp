<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String toElsAccountparameter = request.getParameter("toElsAccount");
%>
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
            <button class="button-wrap" id="freezeBtn"><i18n:I18n key="" defaultValue="冻结" /></button>
            <button class="button-wrap" id="enableBtn"><i18n:I18n key="" defaultValue="启用" /></button>
        </div>
    </div>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<div class="common-box-line">
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="物料组编号" key=""/>:</span>
				<input type="text" id="materialGroup" name="materialGroup" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="物料组描述" key=""/>:</span>
				<input type="text" id="materialGroupDesc" name="materialGroupDesc" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="物料编号" key=""/>:</span>
				<input type="text" id="materialNumber" name="materialNumber" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="物料描述" key=""/>:</span>
				<input type="text" id="materialDesc" name="materialDesc" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="供应商ELS" key=""/>:</span>
				<input type="text" id="toElsAccount" name="toElsAccount" />
				<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 20px; height: 20px;" id="queryToElsAccount" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="供应商名称" key=""/>:</span>
				<input type="text" id="toElsDesc" name="toElsDesc" />
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

<div class="fixed-dialog" id="materialSourceAdd" >
	<div class="dialog-tip bg-common" style="width: 502px;height: 340px;margin-left: -251px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="btnAddClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="组织类别" key=""/></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="输入组织类别信息" key=""/></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="供应商ELS" key=""/>:</td>
	                		<td>
	                			<input type="text" id="toElsAccountAdd" />
	                			<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 20px; height: 20px;" id="queryToElsAccountAdd" />
	                		<span style="color:red">*</span>
	                		</td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="供应商名称" key=""/>:</td>
	                		<td><input type="text" id="toElsDescAdd" readonly="readonly"/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="物料组编码" key=""/>:</td>
	                		<td><input  type="text" id="materialGroupAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="物料组描述" key=""/>:</td>
	                		<td><input type="text" id="materialGroupDescAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="物料编码" key=""/>:</td>
	                		<td><input type="text" id="materialNumberAdd" /><span style="color:red">*</span></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="物料描述" key=""/>:</td>
	                		<td><input type="text" id="materialDescAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="配额" key=""/>:</td>
	                		<td><input type="text" id="quotaAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="有效日期" key=""/>:</td>
	                		<td><input type="text" id="startEffectiveDateAdd" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" /><span style="color:red">*</span></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="至" key=""/>:</td>
	                		<td><input type="text" id="endEffectiveDateAdd" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" /><span style="color:red">*</span></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="备注" key=""/>:</td>
	                		<td>
	                			<input type="text" id="remarkAdd" />
			                	<input type="hidden" id="statusAdd"/>
	                		</td>
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

<div class="fixed-dialog" id="selectFriendElsAccountDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectFriendElsAccountDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectFriendElsAccountTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectFriendOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectFriendCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>

<script type="text/javascript">
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";
//获取对应的页面传参
var toElsAccountparameter = '<%=toElsAccountparameter%>';

var renderFormatDate = function(val,item,rowIndex){
	if("undefined"==typeof(val) || "null"==val){
		val = "";
	}
	if(""==val){
		return val;
	} else {
		return new Date(val).format("yyyy-MM-dd");
	}
};
var renderStatus = function(val,item,rowIndex){
	if("undefined"==typeof(val) || "null"==val){
		return "启用";//默认启用
	} else if("0"==val){
		return "冻结";
	} else {
		return "启用";
	} 
};
var headCols = [
	{ title:"<i18n:I18n key='i18n_common_title_elsaccount' defaultValue='ELS账号' />", name:"elsAccount", width:100, align:"center",hidden:true},
	{ title:"<i18n:I18n key='i18n_common_title_elsDesc' defaultValue='ELS描述' />", name:"elsDesc", width:100, align:"center",hidden:true},
	{ title:"<i18n:I18n key='' defaultValue='供应商ELS账号' />", name:"toElsAccount", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='供应商ELS名称' />", name:"toElsDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='物料组编码' />", name:"materialGroup", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='物料组描述' />", name:"materialGroupDesc", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='物料编码' />", name:"materialNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='物料描述' />", name:"materialDesc", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='有效开始日期' />", name:"startEffectiveDate", width:100, align:"center",renderer:renderFormatDate},
	{ title:"<i18n:I18n key='' defaultValue='有效结束日期' />", name:"endEffectiveDate", width:100, align:"center",renderer:renderFormatDate},
	{ title:"<i18n:I18n key='' defaultValue='供货状态' />", name:"status", width:100, align:"center",renderer:renderStatus},
	{ title:"<i18n:I18n key='' defaultValue='配额' />", name:"quota", width:100, align:"center"},
	{ title:"<i18n:I18n key='i18n_common_title_remarks' defaultValue='备注' />", name:"remark" , width:100, align:"center"},
];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/MaterialSourceListManageService/queryMaterialSourceList",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : headCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : true,
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
	        limitList : [10,30,50,100]
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
	$("#materialGroupAdd").attr("readonly",false);
	$("#materialNumberAdd").attr("readonly",false);
	$("#materialSourceAdd").show();
});

$("#btnAddOK").click(function(){
	migrationAddInfo();
});

$("#btnAddCancel").click(function(){
	$("#materialSourceAdd").hide();
	clearAddInfo();
});

$("#btnAddClose").click(function(){
	$("#materialSourceAdd").hide();
	clearAddInfo();
});

$("#updBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	var selectRowIndexs = headGrid.selectedRowsIndex();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var selectRecord = selectRows[0];
		opType = "upd";
		updRowIndex = selectRowIndexs[0];
		$("#toElsAccountAdd").val(selectRecord.toElsAccount);
		$("#toElsDescAdd").val(selectRecord.toElsDesc);
		$("#materialGroupAdd").val(selectRecord.materialGroup);
		$("#materialGroupDescAdd").val(selectRecord.materialGroupDesc);
		$("#materialNumberAdd").val(selectRecord.materialNumber);
		$("#materialDescAdd").val(selectRecord.materialDesc);
		$("#quotaAdd").val(selectRecord.quota);
		if("undefined"==typeof(selectRecord.startEffectiveDate) || "null"==selectRecord.startEffectiveDate){
			$("#startEffectiveDateAdd").val("");
		} else {
			$("#startEffectiveDateAdd").val(new Date(selectRecord.startEffectiveDate).format("yyyy-MM-dd"));
		}
		if("undefined"==typeof(selectRecord.endEffectiveDate) || "null"==selectRecord.endEffectiveDate){
			$("#endEffectiveDateAdd").val("");
		} else {
			$("#endEffectiveDateAdd").val(new Date(selectRecord.endEffectiveDate).format("yyyy-MM-dd"));
		}
		$("#remarkAdd").val(selectRecord.remark);
		$("#statusAdd").val(selectRecord.status);
		$("#materialGroupAdd").attr("readonly",true);
		$("#materialNumberAdd").attr("readonly",true);
		$("#materialSourceAdd").show();
	}
	
});

$("#saveBtn").click(function(){
	var rows = headGrid.rowsLength()==0?[]:headGrid.rows();
	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中' key='i18n_requirementsPlanning_alert_inTheSave'/>");
	$.ajax({
		url :"${pageContext.request.contextPath}/rest/MaterialSourceListManageService/saveMaterialSourceList",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(rows),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n defaultValue='保存成功' key='i18n_common_alert_savesuccess'/>",1);
			refreshData();//刷新页面数据
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
	    		url : "${pageContext.request.contextPath}/rest/MaterialSourceListManageService/delMaterialSourceList",
	    		contentType : "application/json",
	    		type : "post",
	    		data : JSON.stringify(selectRows),
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>");
	    			
					headGrid.removeRow(selectedIndexes);
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",3);
	    		}
	    	});
		}});
	}
});

$("#freezeBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	var selectRowIndexs = headGrid.selectedRowsIndex();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="是否确认冻结?" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url : "${pageContext.request.contextPath}/rest/MaterialSourceListManageService/freezeMaterialSourceList",
	    		contentType : "application/json",
	    		type : "post",
	    		data : JSON.stringify(selectRows),
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n defaultValue='冻结成功' key=''/>");
	    			refreshData();//刷新页面数据
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n defaultValue='冻结出错' key=''/>",3);
	    		}
	    	});
		}});
	}
});

$("#enableBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	var selectRowIndexs = headGrid.selectedRowsIndex();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="是否确认启用?" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url : "${pageContext.request.contextPath}/rest/MaterialSourceListManageService/enableMaterialSourceList",
	    		contentType : "application/json",
	    		type : "post",
	    		data : JSON.stringify(selectRows),
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n defaultValue='启用成功' key=''/>");
	    			refreshData();//刷新页面数据
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n defaultValue='启用出错' key=''/>",3);
	    		}
	    	});
		}});
	}
});

var toElsCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
var toElsGrid;

var queryToElsAccountType = "";
$("#queryToElsAccount").click(function(){
	queryToElsAccountType="conditionQuery";
	showToElsAccount();
});

$("#queryToElsAccountAdd").click(function(){
	queryToElsAccountType="addQuery";
	showToElsAccount();
});

function showToElsAccount(){
	$("#selectFriendElsAccountDialog").show();
	if("undefined"==typeof(toElsGrid)){
		toElsGrid = $('#selectFriendElsAccountTable').mmGrid({
			cols : toElsCols,
			url : "${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsByType",
			params : {
				elsAccount : elsAccount,
				elsSubAccount : elsSubAccount,
				groupIdAName : "<i18n:I18n defaultValue='供应商' key=''/>"
			},
			method : "post",
			root : "rows",
			loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
			noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
			multiSelect : false,
			checkCol : true,
			indexCol :false
		});
	}
	toElsGrid.load();
		
	var selectToElsAccount="";
	if("conditionQuery"==queryToElsAccountType){
		selectToElsAccount = $("#toElsAccount").val();
	} else if("addQuery"==queryToElsAccountType){
		selectToElsAccount = $("#toElsAccountAdd").val();
	} else {
		selectToElsAccount="";
	}
	
	var totalRows = toElsGrid.rows();
	if(totalRows != null && totalRows != "" && selectToElsAccount){
		for(var i = 0 ; i < totalRows.length ; i ++){
			var toElsAccount = totalRows[i].friendElsAccount;
			var toElsDesc = totalRows[i].friendCompanyName;
			if(toElsAccount == selectToElsAccount){//判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
				toElsGrid.select(i);
			}
		}
	}
}

$("#selectFriendOKBtn").click(function(){
	var selectedRows = toElsGrid.selectedRows();
	var toElsAccount ="";
	var toElsDesc ="";
	if(selectedRows != "" ){
		if(selectedRows.length == 1){
			toElsAccount = selectedRows[0].friendElsAccount;
			toElsDesc = selectedRows[0].friendCompanyName;
		} else {
			alert("<i18n:I18n defaultValue='对方ELS只能选择一个!' key='i18n_label_additionCost_toElsAccountCanOnlySelectOne'/>",2);
		}
	}else{
		alert("<i18n:I18n defaultValue='至少选择一条记录！' key='i18n_common_title_selectAtLeastOneRecord'/>",2);
		return;
	}
	
	if("conditionQuery"==queryToElsAccountType){
		$("#toElsAccount").val(toElsAccount);
		$("#toElsDesc").val(toElsDesc);
	} else {
		$("#toElsAccountAdd").val(toElsAccount);
		$("#toElsDescAdd").val(toElsDesc);
	}
	
	$("#selectFriendElsAccountDialog").hide();
});

$("#selectFriendElsAccountDialogClose").click(function(){
	$("#selectFriendElsAccountDialog").hide();
});

$("#selectFriendCancelBtn").click(function(){
	$("#selectFriendElsAccountDialog").hide();
});

function clearAddInfo(){
	$("#toElsAccountAdd").val("");
	$("#toElsDescAdd").val("");
	$("#materialGroupAdd").val("");
	$("#materialGroupDescAdd").val("");
	$("#materialNumberAdd").val("");
	$("#materialDescAdd").val("");
	$("#quotaAdd").val("");
	$("#startEffectiveDateAdd").val("");
	$("#endEffectiveDateAdd").val("");
	$("#remarkAdd").val("");
	$("#statusAdd").val("");
}

function migrationAddInfo(){
	var toElsAccount = $("#toElsAccountAdd").val();
	var toElsDesc = $("#toElsDescAdd").val();
	var materialGroup = $("#materialGroupAdd").val();
	var materialGroupDesc = $("#materialGroupDescAdd").val();
	var materialNumber = $("#materialNumberAdd").val();
	var materialDesc = $("#materialDescAdd").val();
	var quota = $("#quotaAdd").val();
	var startEffectiveDate = $("#startEffectiveDateAdd").val();
	var endEffectiveDate = $("#endEffectiveDateAdd").val();
	var remark = $("#remarkAdd").val();
	var status = $("#statusAdd").val();
	if("undefined"==typeof(status)){
		status = "1";//默认为1
	}
	//判断必填项
	if (toElsAccount == null||toElsAccount == ''){
		alert("供应商els不能空!",2);
		return;
	}
	if (materialNumber == null||materialNumber == ''){
		alert("物料编码不能空!",2);
		return;
	}
	if(startEffectiveDate==''||startEffectiveDate==null){
		alert("有效开始日期不能空!",2);
		return;
	}
	if(endEffectiveDate==''||endEffectiveDate==null){
		alert("有效结束日期不能空!",2);
		return;
	}
	var newRecord = {
			elsAccount : elsAccount,
			elsDesc : elsDesc,
			toElsAccount : toElsAccount,
			toElsDesc : toElsDesc,
			materialGroup : materialGroup,
			materialGroupDesc : materialGroupDesc,
			materialNumber : materialNumber,
			materialDesc : materialDesc,
			quota : quota,
			materialDesc : materialDesc,
			startEffectiveDate : startEffectiveDate,
			endEffectiveDate : endEffectiveDate,
			remark : remark,
			status : status,
	};
	if("add"==opType){
		newRecord["operationType"] = "add";
		newRecord["status"] = "1";
		headGrid.addRow(newRecord);//插入到最后一行
	} else if("upd"==opType){
		if("undefined"!=typeof(updRowIndex)){
			newRecord["operationType"] = "upd";
			headGrid.updateRow(newRecord,updRowIndex);
		}
	} else {
		
	}
	clearAddInfo();
	$("#materialSourceAdd").hide();
}

function refreshData(){
	var materialGroup = $("#materialGroup").val();
	var materialGroupDesc = $("#materialGroupDesc").val();
	var materialNumber = $("#materialNumber").val();
	var materialDesc = $("#materialDesc").val();
	if("undefined"==typeof(toElsAccountparameter) || ""==toElsAccountparameter 
			|| "null" == toElsAccountparameter){
		var toElsAccount = $("#toElsAccount").val();
	} else {
		toElsAccount = toElsAccountparameter;
	}
	var toElsDesc = $("#toElsDesc").val();
	
	var queryParam = {
    	elsAccount : elsAccount,
    	materialGroup : materialGroup,
    	materialGroupDesc : materialGroupDesc,
    	materialNumber : materialNumber,
    	materialDesc : materialDesc,
    	toElsAccount : toElsAccount,
    	toElsDesc : toElsDesc,
    };
    $.extend(headGrid.opts.params,queryParam);
    headGrid.load();
}
</script>
</body>
</html>