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
					<span><i18n:I18n key="i18n_projectManage_projectNumber" defaultValue="项目编号" />:</span>
					<input type="text" id="projectNumber" name="projectNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectDesc" defaultValue="项目描述" />:</span>
					<input type="text" id="projectDesc" name="projectDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectItemNumber" defaultValue="项目行编号" />:</span>
					<input type="text" id="projectItemNumber" name="projectItemNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectItemDesc" defaultValue="项目行描述" />:</span>
					<input type="text" id="projectItemDesc" name="projectItemDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectLeader" defaultValue="项目负责人" />:</span>
					<input type="text" id="projectLeader" name="projectLeader" />
				</div>
                <div class="dis-in-b input-and-tip">
                	<span><i18n:I18n key="i18n_projectManage_projectStartDate" defaultValue="项目开始时间" /></span>
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="actualStartDate" name="actualStartDate"/>
                </div>
                <div class="dis-in-b input-and-tip">
	                <span><i18n:I18n key="i18n_projectManage_projectEndDate" defaultValue="项目结束时间" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="actualEndDate" name="actualEndDate" />
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
var auditStatus ="${param.auditStatus}";

var renderFormatDate = function(val,item,rowIndex){
	if(val){
		return new Date(val).format("yyyy-MM-dd");
	}
	return "";
};
var renderFormatStatus = function(val,item,rowIndex){
	if("0"==val){
		return "新建";
	} else if("1"==val){
		return "进行中";
	} else if("2"==val){
		return "立项";
	} else if("3"==val){
		return "关闭";
	} else {
		return "";
	}
};
var renderFormatApprove = function(val,item,rowIndex){
	if("0"==val){
		return "审批通过";
	} else if("1"==val){
		return "未审批";
	} else if("2"==val){
		return "审批中";
	} else if("3"==val){
		return "审批拒绝";
	} else {
		return "";
	}
};
var renderFormatMark = function(val,item,rowIndex){
	if("Y"==val){
		return "是";
	} else {
		return "否";
	}
};

var itemCols = [
	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
	{ title:"项目描述", name:"fbk1", width:100, align:"center"},
	{ title:"项目行编号", name:"projectItemNumber", width:100, align:"center"},
	{ title:"项目行描述", name:"projectItemDesc", width:100, align:"center"},
	{ title:"项目行地址", name:"fbk2", width:100, align:"center"},
	{ title:"外部参考项目行编号", name:"refProjectItemNumber", width:100, align:"center"},
	{ title:"项目行状态", name:"projectItemStatus" , width:100, align:"center",renderer:renderFormatStatus},
	{ title:"项目行负责人", name:"projectLeader" , width:100, align:"center"},
	{ title:"里程碑标识", name:"milestoneMark" , width:100, align:"center",renderer:renderFormatMark},
	{ title:"币别", name:"currency" , width:100, align:"center"},
	{ title:"预算金额", name:"budgetAmount" , width:100, align:"center"},
	{ title:"预算占比", name:"budgetPercentage" , width:100, align:"center"},
	{ title:"实际金额", name:"actualAmount" , width:100, align:"center"},
	{ title:"计划周期(天)", name:"planCycle" , width:100, align:"center"},
	{ title:"实际周期(天)", name:"actualCycle" , width:100, align:"center"},
	{ title:"计划开始日期", name:"planStartDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"计划结束日期", name:"planEndDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"实际开始日期", name:"actualStartDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"实际结束日期", name:"actualEndDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"完成百分比", name:"completePercentage" , width:100, align:"center"},
	{ title:"备注", name:"remark" , width:100, align:"center"},
];
  	
var itemGrid = $("#itemTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryApprovalProjectManageItem",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : itemCols,
	root : "",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : true,
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
	parent.frames['iframeApp_'+frameAppId].callbackFun(records);
	parent.elsDeskTop.closeCurWin('projectCheck');
	
});


function init(){
	refreshData();
}

function refreshData(){
	var projectNumber = $("#projectNumber").val();
	var projectDesc = $("#projectDesc").val();
	var projectItemNumber = $("#projectItemNumber").val();
	var projectItemDesc = $("#projectItemDesc").val();
	var projectLeader = $("#projectLeader").val();
	var projectStatus = $("#projectStatus").val();
	var actualStartDate = $("#actualStartDate").val();
	var actualEndDate = $("#actualEndDate").val();
	if("undefined"!=typeof(auditStatus) && ""!=auditStatus){
		auditStatus = parseInt(auditStatus);//审批状态为Int类型
	}
	
	var queryParam = {
    	elsAccount : elsAccount,
    	projectNumber : projectNumber,
    	projectDesc : projectDesc,
    	projectItemNumber : projectItemNumber,
    	projectItemDesc : projectItemDesc,
    	projectLeader : projectLeader,
    	projectStatus : projectStatus,
    	actualStartDate : actualStartDate,
    	actualEndDate : actualEndDate,
    	auditStatus : auditStatus
    };
    itemGrid.load(queryParam);
}
</script>
</body>
</html>