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
				<span><i18n:I18n defaultValue="组织类别描述" key=""/>:</span>
				<input type="text" id="orgCategoryDesc" name="orgCategoryDesc" />
			</div>	
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="组织编码" key=""/>:</span>
				<input type="text" id="orgId" name="orgId" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="组织描述" key=""/>:</span>
				<input type="text" id="orgDesc" name="orgDesc" />
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

<div class="fixed-dialog" id="orgInfoAdd" >
	<div class="dialog-tip bg-common" style="width: 502px;height: 340px;margin-left: -251px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="btnAddClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span id="dialogTitle" class="dialogTitle"><i18n:I18n defaultValue="新增组织类别" key=""/></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="输入组织类别信息" key=""/></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="组织类别编码" key=""/>:</td>
	                		<td><input type="text" id="orgCategoryIdAdd" readonly="readonly" />
								<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 20px; height: 20px;" id="queryOrgCategory" />
							</td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="组织类别描述" key=""/>:</td>
	                		<td><input  type="text" id="orgCategoryDescAdd" readonly="readonly" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="组织编码" key=""/>:</td>
	                		<td><input  type="text" id="orgIdAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="组织描述" key=""/>:</td>
	                		<td><input  type="text" id="orgDescAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="上级组织编码" key=""/>:</td>
	                		<td><input  type="text" id="parentOrgIdAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="上级组织描述" key=""/>:</td>
	                		<td><input  type="text" id="parentOrgDescAdd"  readOnly/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="上级组织类别" key=""/>:</td>
	                		<td><input  type="text" id="fbk1Add" readOnly/>
	                			<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 20px; height: 20px;" id="queryUpperOrgCategory" />
	                		</td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="上级组织类别描述" key=""/>:</td>
	                		<td><input  type="text" id="fbk2Add" readOnly/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="地址编码" key=""/>:</td>
	                		<td><input  type="text" id="addrIdAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="地址" key=""/>:</td>
	                		<td><input  type="text" id="addrDescAdd" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="备注" key=""/>:</td>
	                		<td><input  type="text" id="remarkAdd" /></td>
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
	{ title:"<i18n:I18n key='' defaultValue='组织类别描述' />", name:"orgCategoryDesc", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='组织编码' />", name:"orgId", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='组织描述' />", name:"orgDesc", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='上级组织编码' />", name:"parentOrgId", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='上级组织描述' />", name:"parentOrgDesc", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='上级组织类别编码' />", name:"fbk1", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='上级组织类别描述' />", name:"fbk2", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='地址编码' />", name:"addrId", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='地址' />", name:"addrDesc", width:300, align:"center"},
	{ title:"<i18n:I18n key='i18n_common_title_remarks' defaultValue='备注' />", name:"remark" , width:100, align:"center"},
];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/queryOrganizationInfo",
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
    //读取上级组织信息
    $("#parentOrgIdAdd").change(function(){
    	var params = {"elsAccount":elsAccount,"orgId":$(this).val()};
    	$.ajax({
    		url :"${pageContext.request.contextPath}/rest/ElsOrganizationService/queryOrganizationInfo",
    		type :"post",
    		contentType : "application/json",
    		data : JSON.stringify(params),
    		dataType : "json",
    		success : function(data) {
    			if (data.rows.length == 0) {
    				alert("找不到该组织信息",2);
    				$("#parentOrgIdAdd").val("");
    				$("#parentOrgDescAdd").val("");
    				$("#fbk1Add").val("");
    				$("#fbk2Add").val("");
    				return;
    			}
    			$("#parentOrgIdAdd").val(data.rows[0].orgId);
				$("#parentOrgDescAdd").val(data.rows[0].orgDesc);
				$("#fbk1Add").val(data.rows[0].orgCategoryId);
				$("#fbk2Add").val(data.rows[0].orgCategoryDesc);
    		}
    	});
    });
});

$("#queryBtn").click(function(){
	refreshData();
});
var opType = "";
var updRowIndex;
$("#addBtn").click(function(){
	clearAddInfo();
	opType = "add";
	$("#queryOrgCategory").show();
	$("#queryUpperOrgCategory").show();
	$("#dialogTitle").html('<i18n:I18n defaultValue="新增组织类别" key=""/>');
	$("#orgInfoAdd").show();
	$("#orgIdAdd").removeAttr("readonly");//新增时组织编码去掉只读属性
});

$("#btnAddOK").click(function(){
	migrationAddInfo();
});

$("#btnAddCancel").click(function(){
	$("#orgInfoAdd").hide();
	clearAddInfo();
});

$("#btnAddClose").click(function(){
	$("#orgInfoAdd").hide();
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
		$("#orgIdAdd").val(selectRecord.orgId);
		$("#orgIdAdd").attr("readonly","readonly");//组织编码设为只读不可修改
		$("#orgDescAdd").val(selectRecord.orgDesc);
		$("#parentOrgIdAdd").val(selectRecord.parentOrgId);
		$("#parentOrgDescAdd").val(selectRecord.parentOrgDesc);
		$("#fbk1Add").val(selectRecord.fbk1);
		$("#fbk2Add").val(selectRecord.fbk2);
		$("#addrIdAdd").val(selectRecord.addrId);
		$("#addrDescAdd").val(selectRecord.addrDesc);
		$("#remarkAdd").val(selectRecord.remark);
		$("#dialogTitle").html('<i18n:I18n defaultValue="修改组织类别" key=""/>');
		$("#queryOrgCategory").hide();
		$("#queryUpperOrgCategory").hide();
		$("#orgInfoAdd").show();
	}
	
});

$("#saveBtn").click(function(){
	var rows = headGrid.rowsLength()==0?[]:headGrid.rows();
	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中' key='i18n_requirementsPlanning_alert_inTheSave'/>");
	$.ajax({
		url :"${pageContext.request.contextPath}/rest/ElsOrganizationService/saveOrganizationInfo",
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
	    		url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/delOrganizationInfo",
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

$("#queryOrgCategory").click(function(){
	var obj={
		windowTitle: '组织架构',
		data:{"parentWinId":"orgInfoManage"},//传递上一级的窗口iframe id用parentWinId,其他数据自定
		windowMaximize: false,
		windowMinimize: false,
		windowStatus: 'regular',
		windowWidth: 639,
		windowHeight: 480,
		iframSrc: 'OrgStructure.jsp',
		windowsId: 'OrgStructure_select' 
	};
	parent.elsDeskTop.defineWin(obj);
});

function selectOrgInfo(returnJson){
	if(returnJson) {
		var jsonObj = returnJson[0];
		$("#orgCategoryIdAdd").val(jsonObj.orgCategoryId);
		$("#orgCategoryDescAdd").val(jsonObj.orgCategoryDesc);
	}
}

//上级组织类别点击事件
$("#queryUpperOrgCategory").click(function(){
	var obj={
		windowTitle: '组织架构',
		data:{"parentWinId":"orgInfoManage"},//传递上一级的窗口iframe id用parentWinId,其他数据自定
		windowMaximize: false,
		windowMinimize: false,
		windowStatus: 'regular',
		windowWidth: 639,
		windowHeight: 480,
		iframSrc: 'upperOrgStructure.jsp',
		windowsId: 'upperOrgStructure_select' 
	};
	parent.elsDeskTop.defineWin(obj);
})

function selectUpperOrgInfo(returnJson){
	if(returnJson) {
		var jsonObj = returnJson[0];
		$("#fbk1Add").val(jsonObj.fbk1);
		$("#fbk2Add").val(jsonObj.fbk2);
	}
}

function clearAddInfo(){
	$("#orgCategoryIdAdd").val("");
	$("#orgCategoryDescAdd").val("");
	$("#orgIdAdd").val("");
	$("#orgDescAdd").val("");
	$("#parentOrgIdAdd").val("");
	$("#parentOrgDescAdd").val("");
	$("#fbk1Add").val("");
	$("#fbk2Add").val("");
	$("#addrIdAdd").val("");
	$("#addrDescAdd").val("");
	$("#remarkAdd").val("");
}

function migrationAddInfo(){
	var orgCategoryIdAdd = $("#orgCategoryIdAdd").val();
	var orgCategoryDescAdd = $("#orgCategoryDescAdd").val();
	var orgIdAdd = $("#orgIdAdd").val();
	var orgDescAdd = $("#orgDescAdd").val();
	var parentOrgIdAdd = $("#parentOrgIdAdd").val();
	var parentOrgDescAdd = $("#parentOrgDescAdd").val();
	var fbk1Add = $("#fbk1Add").val();
	var fbk2Add = $("#fbk2Add").val();
	var addrIdAdd = $("#addrIdAdd").val();
	var addrDescAdd = $("#addrDescAdd").val();
	var remarkAdd = $("#remarkAdd").val();
	//判断字段非空
	if (orgCategoryIdAdd=="") {
		alert("组织类型不能为空",2);
		return;
	}
	if (orgIdAdd=="") {
		alert("组织编码不能为空",2);
		return;
	}
	var newRecord = {
			elsAccount : elsAccount,
			elsDesc : elsDesc,
			orgCategoryId : orgCategoryIdAdd,
			orgCategoryDesc : orgCategoryDescAdd,
			orgId : orgIdAdd,
			orgDesc : orgDescAdd,
			parentOrgId : parentOrgIdAdd,
			parentOrgDesc : parentOrgDescAdd,
			fbk1 : fbk1Add,
			fbk2 : fbk2Add,
			addrId : addrIdAdd,
			addrDesc : addrDescAdd,
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
	$("#orgInfoAdd").hide();
}

function refreshData(){
	var orgCategoryId = $("#orgCategoryId").val();
	var orgCategoryDesc = $("#orgCategoryDesc").val();
	var orgId = $("#orgId").val();
	var orgDesc = $("#orgDesc").val();
	
	var queryParam = {
    	elsAccount : elsAccount,
    	orgCategoryId : orgCategoryId,
    	orgCategoryDesc : orgCategoryDesc,
    	orgId : orgId,
    	orgDesc : orgDesc,
    };
    $.extend(headGrid.opts.params,queryParam);
    headGrid.load();
}


</script>
</body>
</html>