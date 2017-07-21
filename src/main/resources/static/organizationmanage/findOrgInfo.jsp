<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            <button class="button-wrap" id="addBtn"><i18n:I18n key="" defaultValue="确定" /></button>
            
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

<script type="text/javascript">
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";

var frameAppId ="<%=request.getParameter("frameAppId") %>";

var headCols = [
	{ title:"<i18n:I18n key='i18n_saleorderhis_title_elsaccount' defaultValue='ELS号' />", name:"elsAccount", width:100, align:"center"},
	{ title:"<i18n:I18n key='i18n_common_title_elsDesc' defaultValue='ELS描述' />", name:"elsDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='组织类别编码' />", name:"orgCategoryId", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='组织类别描述' />", name:"orgCategoryDesc", width:300, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='组织编码' />", name:"orgId", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='组织描述' />", name:"orgDesc", width:300, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='上级组织编码' />", name:"parentOrgId", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='上级组织描述' />", name:"parentOrgDesc", width:300, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='地址编码' />", name:"addrId", width:200, align:"center"},
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
	multiSelect : true,
	checkCol : true,
	indexCol : true,
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


$("#addBtn").click(function(){
	var rows = headGrid.selectedRows();
	if(rows.length < 1){
		alert("<i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择"/>!",2);
		return;
	}
	parent.frames['iframeApp_'+frameAppId].callbackFun(rows);
    parent.elsDeskTop.closeCurWin('findOrgInfo');
});

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