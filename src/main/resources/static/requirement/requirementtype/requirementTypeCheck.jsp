<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                <button class="button-wrap" id="affirmBtn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="" defaultValue="需求组编号" />:</span>
					<input type="text" id="requirementGroupCode" name="requirementGroupCode" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="" defaultValue="需求组名称" />:</span>
					<input type="text" id="requirementGroupName" name="requirementGroupName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="" defaultValue="需求类型编号" />:</span>
					<input type="text" id="requirementTypeCode" name="requirementTypeCode" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="" defaultValue="需求类型名称" />:</span>
					<input type="text" id="requirementTypeName" name="requirementTypeName" />
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_projectManage_title_projectDetail" defaultValue="项目管理明细" /></span>
			<div class="common-box-line">
				<main class="grid-container">
					<div class="grid-100" id="headDiv">
						<table id="itemTable"></table>
					</div>
				</main>
			</div>
		</div>
		
	</div>
<script type="text/javascript">
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";
var frameAppId ="${param.frameAppId}";
var rowIndex ="${param.rowIndex}";

var renderFormatLockStatus = function(val,item,rowIndex){
	if("0"==val){
		return "否";
	} else {
		return "是";
	}
};

var itemCols = [
	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
	{ title:"需求组编号", name:"requirementGroupCode", width:100, align:"center"},
	{ title:"需求组名称", name:"requirementGroupName", width:100, align:"center"},
	{ title:"需求类型编号", name:"requirementTypeCode", width:100, align:"center"},
	{ title:"需求类型名称", name:"requirementTypeName", width:100, align:"center"},
	{ title:"是否锁定", name:"lockStatus", width:100, align:"center",renderer:renderFormatLockStatus},
	{ title:"备注", name:"remark" , width:100, align:"center"},
];
  	
var itemGrid = $("#itemTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/RequirementTypeService/findHeadList",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : itemCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : false,
	checkCol : true,
	indexCol : false,
});
	
$(document).ready(function(){
	//初始化控件
	$("button").button();
    init();
});

$("#queryBtn").click(function(){
	refreshData();
});

$("#affirmBtn").click(function(){
	var records = itemGrid.selectedRows();
	if(frameAppId=="addRequirementsPlanning" || frameAppId=="detailsRequirementsPlanning") {
		parent.frames['iframeApp_'+frameAppId].requirementTypeCallback(records,rowIndex);
	} else {
		var getData = getIframeData();
		getData(records);
	}
	parent.elsDeskTop.closeCurWin('requirementTypeCheck');
});

function init(){
	refreshData();
}

function refreshData(){
	var requirementGroupCode = $("#requirementGroupCode").val();
	var requirementGroupName = $("#requirementGroupName").val();
	var requirementTypeCode = $("#requirementTypeCode").val();
	var requirementTypeName = $("#requirementTypeName").val();
	
	var queryParam = {
    	elsAccount : elsAccount,
    	requirementGroupCode : requirementGroupCode,
    	requirementGroupName : requirementGroupName,
    	requirementTypeCode : requirementTypeCode,
    	requirementTypeName : requirementTypeName,
    };
    itemGrid.load(queryParam);
}
</script>
</body>
</html>