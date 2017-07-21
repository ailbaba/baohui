<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<body>
<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
        </div>
    </div>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<div class="common-box-line">
			<div class="dis-in-b input-and-tip pos-relative">
				<span><i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS" />:</span>
				<input type="text" id="elsAccount" name="elsAccount" />
				<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryElsAccount" />
			</div>
			<div class="dis-in-b input-and-tip">
				<input type="text" id="elsDesc" name="elsDesc" readonly="readonly" />
			</div>
			<div class="dis-in-b input-and-tip pos-relative">
				<span><i18n:I18n key="i18n_common_label_salematerialnumber" defaultValue="供应商物料" />:</span>
				<input type="text" id="materialNumber" name="materialNumber" />
				<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryMaterialNumber" />
			</div>
			<div class="dis-in-b input-and-tip">
				<input type="text" id="materialDesc" name="materialDesc" readonly="readonly" />
			</div>
			<div class="dis-in-b input-and-tip pos-relative">
				<span><i18n:I18n key="i18n_common_label_Supplyfactory" defaultValue="供应工厂" />:</span>
				<input type="text" id="factoryNumber" name="factoryNumber" />
				<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryFactoryNumber" />
			</div>
			<div class="dis-in-b input-and-tip">
				<input type="text" id="factoryName" name="factoryName" readonly="readonly" />
			</div>
			<br/>
			<div class="dis-in-b input-and-tip">
                <input type="radio" name="dateArea" value="currDate" checked="checked"><i18n:I18n key="i18n_label_currentInventory" defaultValue="当前库存" />
                <input type="radio" name="dateArea" value="definedDate"><i18n:I18n key="i18n_label_customDateInventory" defaultValue="自定义日期库存" />
			</div>
            <div class="dis-in-b input-and-tip" style="display:none;">
				<input type="text" class="Wdate" onfocus="WdatePicker()" id="stockDate" name="stockDate"/>
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

<div class="fixed-dialog" id="selectFriendElsAccountDialog" >
	<div class="dialog-tip bg-common" style="width: 500px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectFriendElsAccountDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
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

<div class="fixed-dialog" id="selectMaterialDialog" >
	<div class="dialog-tip bg-common" style="width: 500px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectMaterialDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectMaterialTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectMaterialOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectMaterialCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>

<div class="fixed-dialog" id="selectFactoryDialog" >
	<div class="dialog-tip bg-common" style="width: 500px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectFactoryDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectFactoryTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectFactoryOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectFactoryCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
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

var renderFormatDate = function(val,item,rowIndex){
	if("undefined"==typeof(val) || "" == val){
		return "";
	} else {
		return new Date(val).format("yyyy-MM-dd");
	}
};

var headCols = [
	{ title:"<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />", name:"toElsAccount", width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_common_title_elsDesc" defaultValue="ELS描述" />", name:"toElsDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS" />", name:"elsAccount", width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_common_title_supplieelsDesc" defaultValue="供应商ELS名称" />", name:"elsDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_common_label_factoryNumber" defaultValue="工厂编号" />", name:"factoryNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_saleRequirement_lable_FactoryName" defaultValue="工厂名称" />", name:"factoryName", width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_delivery_lable_suppliermaterialnumber" defaultValue="供应商物料编号" />", name:"materialNumber" , width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_delivery_lable_suppliermaterialname" defaultValue="供应商物料名称" />", name:"materialDesc" , width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_delivery_lable_purchasematerialnumber" defaultValue="采购方物料编号" />", name:"purchaseMaterialNumber" , width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_saleorder_title_purchasematerialdesc" defaultValue="采购方物料名称" />", name:"purchaseMaterialDesc" , width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />", name:"quantity" , width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_delivery_lable_unit" defaultValue="单位" />", name:"unit" , width:100, align:"center"},
	{ title:"<i18n:I18n key="i18n_common_label_stockDate" defaultValue="库存日期" />", name:"stockDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />", name:"remark" , width:100, align:"center"},
];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/SupplierStockService/querySupplierStockByPurchase",
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

$("input[name='dateArea']").click(function(){
	var dateArea = $(this).val();
	var currDate = new Date();
	
	if("currDate" == dateArea){
		$("#stockDate").val(currDate.format("yyyy-MM-dd"));
		$("#stockDate").parent().hide();
	} else if("definedDate" == dateArea) {
		$("#stockDate").val("");
		$("#stockDate").parent().show();
	} else {//默认查最近一月
		$("#stockDate").val(currDate.format("yyyy-MM-dd"));
		$("#stockDate").parent().hide();
	}
});

$("#queryBtn").click(function(){
	refreshData();
});

/* 查询供应商信息 start  */
//查询对方ELS信息(只在好友列表中查询) 
var toElsCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
var toElsGrid;
$("#queryElsAccount").click(function(){
	$("#selectFriendElsAccountDialog").show();
	toElsGrid = $('#selectFriendElsAccountTable').mmGrid({
		cols : toElsCols,
		url : "${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsByType",
		params : {
			elsAccount : elsAccount,
			elsSubAccount : elsSubAccount,
			groupIdAName : "<i18n:I18n defaultValue='供应商' key='i18n_label_supplier'/>"
		},
		method : "post",
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
		checkCol : true,
		indexCol :false
	});

	var selectElsAccount = $("#elsAccount").val();
	var totalRows = toElsGrid.rows();
	if(totalRows != null && totalRows != "" && selectElsAccount != ""){
		for(var i = 0 ; i < totalRows.length ; i ++){
			var toElsAccount = totalRows[i].friendElsAccount;
			var toElsDesc = totalRows[i].friendCompanyName;
			if(toElsAccount == selectElsAccount){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
				toElsGrid.select(i);
				continue;
			}
		}
	}
});

//选择对方ELS确认按钮单击事件
$("#selectFriendOKBtn").click(function(){
	var selectedRows = toElsGrid.selectedRows();
	if(selectedRows != "" ){
		$("#elsAccount").val(selectedRows[0].friendElsAccount);
		$("#elsDesc").val(selectedRows[0].friendCompanyName);
		//切换供应商后清除供应商物料及工厂选项
		$("#materialNumber").val("");
		$("#materialDesc").val("");
		$("#factoryNumber").val("");
		$("#factoryName").val("");
	}else{
		alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
		return;
	}
	$("#selectFriendElsAccountDialog").hide();
});

$("#selectFriendElsAccountDialogClose").click(function(){
	$("#selectFriendElsAccountDialog").hide();
});

$("#selectFriendCancelBtn").click(function(){
	$("#selectFriendElsAccountDialog").hide();
});
/* 查询供应商信息 end  */

/* 查询供应商物料信息 start */
//var materialCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
var materialGrid;
var materialCols = [
   	   	{ title:"<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />", name:"elsAccount", width:100, align:"center"},
   		{ title:"<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />", name:"materialNumber", width:100, align:"center"},
   		{ title:"<i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />", name:"materialDesc", width:100, align:"center"},
   		{ title:"<i18n:I18n key="i18n_common_title_materialgroup" defaultValue="物料组" />", name:"materialGroup", width:100, align:"center"},
   		{ title:"<i18n:I18n key="i18n_label_productionLine" defaultValue="生产线" />", name:"productLine", width:100, align:"center"},
   	];
$("#queryMaterialNumber").click(function(){
	var _elsAccount = $("#elsAccount").val();
	if("undefined"==typeof(_elsAccount) || ""==_elsAccount){
		alert("<i18n:I18n key="i18n_label_additionCost_pleaseSelectsuppliersFirst" defaultValue="请先选择供应商" />",2);
	} else {
		$("#selectMaterialDialog").show();
		if(materialGrid){
			materialGrid.load({elsAccount : _elsAccount});
		} else {
			materialGrid = $('#selectMaterialTable').mmGrid({
				cols : materialCols,
				url : "${pageContext.request.contextPath}/rest/MaterialService/queryMaterialList",
				params : {
					elsAccount : _elsAccount,
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
	}

	var selectMaterialNumber = $("#materialNumber").val();
	var totalRows = materialGrid.rows();
	if(totalRows != null && totalRows != "" && selectMaterialNumber != ""){
		for(var i = 0 ; i < totalRows.length ; i ++){
			var materialNumber = materialGrid[i].materialNumber;
			var materialDesc = totalRows[i].materialDesc;
			if(materialNumber == selectMaterialNumber){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
				materialGrid.select(i);
				continue;
			}
		}
	}
});

//选择物料确认按钮单击事件
$("#selectMaterialOKBtn").click(function(){
	var selectedRows = materialGrid.selectedRows();
	if(selectedRows != "" ){
		$("#materialNumber").val(selectedRows[0].materialNumber);
		$("#materialDesc").val(selectedRows[0].materialDesc);
	}else{
		alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
		return;
	}
	$("#selectMaterialDialog").hide();
});

$("#selectMaterialDialogClose").click(function(){
	$("#selectMaterialDialog").hide();
});

$("#selectMaterialCancelBtn").click(function(){
	$("#selectMaterialDialog").hide();
});
/* 查询供应商物料信息 end  */

/* 查询供应商工厂信息 start */
//var factoryCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
var factoryGrid;
var factoryCols = [
	   	{ title:"<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />", name:"elsAccount", width:100, align:"center"},
		{ title:"<i18n:I18n key="i18n_label_additionCost_accountName" defaultValue="ELS名称" />", name:"elsDesc", width:100, align:"center"},
		{ title:"<i18n:I18n key="i18n_common_label_factoryNumber" defaultValue="工厂编号" />", name:"factoryNumber", width:100, align:"center"},
		{ title:"<i18n:I18n key="i18n_saleRequirement_lable_FactoryName" defaultValue="工厂名称" />", name:"factoryName", width:100, align:"center"},
		{ title:"<i18n:I18n key="i18n_saleRequirement_lable_factoryNameAddress" defaultValue="工厂地址" />", name:"factoryAddress", width:100, align:"center"},
		{ title:"<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />", name:"remark" , width:100, align:"center"},
	];
$("#queryFactoryNumber").click(function(){
	var _elsAccount = $("#elsAccount").val();
	if("undefined"==typeof(_elsAccount) || ""==_elsAccount){
		alert("<i18n:I18n key="i18n_label_additionCost_pleaseSelectsuppliersFirst" defaultValue="请先选择供应商" />",2);
	} else {
		$("#selectFactoryDialog").show();
		if(factoryGrid){
			factoryGrid.load({elsAccount : _elsAccount});
		} else {
			factoryGrid = $('#selectFactoryTable').mmGrid({
				cols : factoryCols,
				url : "${pageContext.request.contextPath}/rest/SupplierStockService/querySupplierFactory",
				params : {
					elsAccount : _elsAccount
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
		
		var selectFactoryNumber = $("#factoryNumber").val();
		var totalRows = factoryGrid.rows();
		if(totalRows != null && totalRows != "" && selectFactoryNumber != ""){
			for(var i = 0 ; i < totalRows.length ; i ++){
				var factoryNumber = totalRows[i].factoryNumber;
				var factoryName = totalRows[i].factoryName;
				if(factoryNumber == selectFactoryNumber){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
					factoryGrid.select(i);
					continue;
				}
			}
		}
	}
});

//选择物料确认按钮单击事件
$("#selectFactoryOKBtn").click(function(){
	var selectedRows = factoryGrid.selectedRows();
	if(selectedRows != "" ){
		$("#factoryNumber").val(selectedRows[0].factoryNumber);
		$("#factoryName").val(selectedRows[0].factoryName);
	}else{
		alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
		return;
	}
	$("#selectFactoryDialog").hide();
});

$("#selectFactoryDialogClose").click(function(){
	$("#selectFactoryDialog").hide();
});

$("#selectFactoryCancelBtn").click(function(){
	$("#selectFactoryDialog").hide();
});
/* 查询供应商工厂信息 end  */

function refreshData(){
	var elsAccount = $("#elsAccount").val();
	var materialNumber = $("#materialNumber").val();
	var factoryNumber = $("#factoryNumber").val();
	var stockDate = $("#stockDate").val();
	
	var queryParam = {
    	elsAccount : elsAccount,
    	materialNumber : materialNumber,
    	factoryNumber : factoryNumber,
    	stockDate : stockDate
    };
    //$.extend(headGrid.opts.params,queryParam);
    headGrid.load(queryParam);
}
</script>
</body>
</html>