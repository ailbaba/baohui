<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button class="button-wrap" id="getERP"><i18n:I18n key="i18n_button_getfromerp" defaultValue="从ERP获取" /></button>
            <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            <button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
            <button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
            <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
            <button class="button-wrap" id="columnDefineBtn"><i18n:I18n key="" defaultValue="列自定义" /></button>
<!--             <div class="dis-in-b input-and-tip" style="margin-left: 20px;">K3用户信息<span id="refurbish" style="color: red;"></span>条</div> -->
        </div>
    </div>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<form id="subAccountOrgForm" onsubmit="return false;">
		    <input type="hidden" id="elsAccount" name="elsAccount" />
		    <div class="common-box-line">
		    <div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="子账号名称" key=""/>:</span>
				<input type="text" id="elsSubDesc" name="elsSubDesc" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="子账号" key=""/>:</span>
				<input type="text" id="elsSubAccount" name="elsSubAccount" />
			</div>
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
		</form>
		
	</div>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
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

var headCols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="orgSubAccountinfo_mt"/>;
// var headCols = [
// 	{ title:"<i18n:I18n key='' defaultValue='子账号' />", name:"elsSubAccount", width:100, align:"center"},
// 	{ title:"<i18n:I18n key='' defaultValue='姓名' />", name:"elsSubDesc", width:100, align:"center"},
// 	{ title:"<i18n:I18n key='' defaultValue='组织类别编码' />", name:"orgCategoryId", width:200, align:"center"},
// 	{ title:"<i18n:I18n key='' defaultValue='组织类别描述' />", name:"orgCategoryDesc", width:200, align:"center"},
// 	{ title:"<i18n:I18n key='' defaultValue='组织编码' />", name:"orgId", width:100, align:"center"},
// 	{ title:"<i18n:I18n key='' defaultValue='组织描述' />", name:"orgDesc", width:200, align:"center"},
// 	{ title:"<i18n:I18n key='i18n_common_title_remarks' defaultValue='备注' />", name:"remark" , width:100, align:"center"},
// ];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/querySubaccountOrganizationInfo",
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
	        limitList : [10,20,50]
	    })
	]
});

headGrid.on('loadSuccess',function(e, data) {
// 	getERPCount();
});

$(document).ready(function(){
	//初始化控件
	$("button").button();
	$("#elsAccount").val(elsAccount);
    refreshData();
});

$("#queryBtn").click(function(){
	refreshData();
});

$("#addBtn").click(function(){
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'addSubAccountOrgInfo',
        'windowTitle':'<i18n:I18n key="" defaultValue="新增子账号默认组织"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>organizationmanage/addSubAccountOrgInfo.jsp',
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
});


$("#updBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if(selectRows.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var row = selectRows[0];
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'updateSubAccountOrgInfo',
        'windowTitle':'<i18n:I18n key="" defaultValue="修改子账号默认组织"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>organizationmanage/updateSubAccountOrgInfo.jsp?elsSubAccount='+row.elsSubAccount+'&elsSubDesc='+row.elsSubDesc,
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
});
//头信息列自定义
$("#columnDefineBtn").click(function(){
		 parent.elsDeskTop.defineWin({
		     'iconSrc':'icon/els-icon.png',
		     'windowsId':'subAccountColumnSetting',
		     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		     windowSubTitle: "",
		     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=orgSubAccountinfo_mt" + "&window=iframeApp_orgSubAccountinfo_mt",
		     windowMinWidth: 480,
		     windowMinHeight: 600,
		     'windowWidth':480,
		     'windowHeight':600,
		     'parentPanel':".currDesktop"
		  });
		 });

$("#delBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if(selectRows.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var row = selectRows[0];
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除?" key=""/>',closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/ElsOrganizationService/deleteSubaccountOrganizationInfo",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(row),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					refreshData();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
	}});
	
});

function refreshData(){
	var paramObj = $("#subAccountOrgForm").serializeJSON();
    $.extend(headGrid.opts.params,paramObj);
    headGrid.load();
}

$("#getERP").click(function(){
	debugger;
	if(!(elsAccount == "160000" && elsSubAccount == "1001")){
		alert("仅160000/1001账户可执行同步操作",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认ERP导入？" />',closeEvent:function(){	
		var btnERPImport = $("#getERP");
			btnERPImport.empty().append('<span style="color: red;">同步中...</span>');
		var json={"elsAccount":elsAccount};
		var paramStr = JSON.stringify(json);
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/getERPSubaccountOrganizationInfo",
			contentType : "application/json",
	 		type : "post",
	 		dataType : "json",
	 		data:paramStr,
	 		success : function(data) {
	 			if(data!=null&&(data.statusCode=="-100"||data.statusCode=="-200")){
	 				alert(data.message,3);
	 			}else{
	 				btnERPImport.empty().append('<span style="color: red;">获取数据成功</span>');
	 				refreshData();
	 			}
	 		},
	 		error : function(data) {
	 			alert(data.message,3);
	 		}
	 	});
	}});
});

var getERPCount = function() {
	debugger;
	setInterval(function() {
		// 迈腾-接口-运行中 @author jiangzhidong @date 20160809
	    var frm = { 'elsAccount':elsAccount };
		$.ajax({
			url :"<%=basePath%>rest/ElsOrganizationService/getERPSubaccountOrganizationInfoCount",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm),
			dataType : "json",
			success : function(data) {
				if(data!=null&&data.statusCode=="-100"){
	 				alert(data.message,2);
	 			}else{
	 				$("#refurbish").text(data.message);
	 			}
			},
			error : function(data) {
				if (!permissionError(data)) {
					 //alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
    }, 5000);
}
</script>
</body>
</html>