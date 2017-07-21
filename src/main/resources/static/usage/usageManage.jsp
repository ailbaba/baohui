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
        </div>
    </div>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<div class="common-box-line">
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="客户编号" key=""/>:</span>
				<input type="text" id="elsAccount" name="elsAccount" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="客户名称" key=""/>:</span>
				<input type="text" id="elsDesc" name="elsDesc" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="应用名称" key=""/>:</span>
				<input type="text" id="appName" name="appName" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="开始日期" key=""/>:</span>
				<input type="text" id="fromDate" name="fromDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="结束日期" key=""/>:</span>
				<input type="text" id="endDate" name="endDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			</div>
			<%-- <div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="供应商ELS" key=""/>:</span>
				<input type="text" id="toElsAccount" name="toElsAccount" />
				<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 20px; height: 20px;" id="queryToElsAccount" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="供应商名称" key=""/>:</span>
				<input type="text" id="toElsDesc" name="toElsDesc" />
			</div>	 --%>
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

<script type="text/javascript">
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";

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

var headCols = [
	{ title:"<i18n:I18n key='i18n_common_title_elsaccount' defaultValue='ELS账号' />", name:"elsAccount", width:100, align:"center"},
	{ title:"<i18n:I18n key='i18n_common_title_elsDesc' defaultValue='ELS描述' />", name:"elsDesc", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='应用编码' />", name:"appCode", width:300, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='应用名称' />", name:"appName", width:300, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='使用次数' />", name:"useCount", width:100, align:"center"},
];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ElsUsageInfoService/queryUsageInfoCount",
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

function refreshData(){
	var elsAccount = $("#elsAccount").val();
	var elsDesc = $("#elsDesc").val();
	var appName = $("#appName").val();
	var fromDate = $("#fromDate").val();
	var endDate = $("#endDate").val();
	
	var queryParam = {
			elsAccount : elsAccount,
			elsDesc : elsDesc,
			appName : appName,
			fromDate : fromDate,
			endDate : endDate
    };
    $.extend(headGrid.opts.params,queryParam);
    headGrid.load();
}
</script>
</body>
</html>