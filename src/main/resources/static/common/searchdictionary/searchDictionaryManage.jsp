<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            <button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
            <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
        </div>
    </div>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<form id="searchDictionaryForm" onsubmit="return false;">
		    <input type="hidden" id="elsAccount" name="elsAccount" />
		    <div class="common-box-line">
		    <div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="表名" key=""/>:</span>
				<input type="text" id="tableName" name="tableName" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="字段名" key=""/>:</span>
				<input type="text" id="fieldName" name="fieldName" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="字段描述" key=""/>:</span>
				<input type="text" id="fieldText" name="fieldText" />
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="权限组" key=""/>:</span>
				<input type="text" id="authorityGroup" name="authorityGroup" />
			</div>
			<%-- <div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="银行编码" key=""/>:</span>
				<div class="auto-bankCode"></div>
			</div>
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="组织类别" key=""/>:</span>
				<div class="auto-wrap1">
	            </div>
			</div> --%>
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


function rendererOperation(val, item, rowIndex){      
	var text = '<span class="item-details" style="color:blue;cursor:pointer;"><i18n:I18n key="" defaultValue="项值" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	return text;
}

$('.item-details').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    //兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop2_icon_349.png',
        'windowsId':'detailsFieldDictionary',
        'windowTitle':'<i18n:I18n key="" defaultValue="编辑字段字典值" />',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>common/searchdictionary/detailsFieldDictionary.jsp?tableName='+item.tableName+'&fieldName='+item.fieldName
        		+'&fieldText='+item.fieldText+'&fieldType='+item.fieldType+'&showElsAccount='+item.elsAccount+'&authorityGroup='+item.authorityGroup,
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 960,
        'windowMinHeight': 500,
        'windowPositionTop':24,
        'windowWidth':960,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
    
});

var headCols = [
    { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:100, align:'center',clickDisable:true,renderer: rendererOperation},
    { title:"<i18n:I18n key='' defaultValue='ELS账号' />", name:"elsAccount", width:120, align:"center"},
    { title:"<i18n:I18n key='' defaultValue='表名' />", name:"tableName", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='字段名' />", name:"fieldName", width:200, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='字段描述' />", name:"fieldText", width:400, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='字段类型' />", name:"fieldType", width:120, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='权限组' />", name:"authorityGroup", width:100, align:"center"}
];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ElsSearchDictionaryService/findFieldList",
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
	        limitList : [15,20,50]
	    })
	]
});

$(document).ready(function(){
	//初始化控件
	$("button").button();
	$("#elsAccount").val(elsAccount);
	
	<%-- $('.auto-bankCode').elsAutoLoad({
		getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
		elsAccount:elsAccount||'',
		tableName:'supplier_main_data',
		fieldName: 'bankCode',
		antoClass:"auto-bankCode"
    });
	
	$('.auto-wrap1').elsAutoLoad({
		getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
		elsAccount:elsAccount||'',
		tableName:'els_organization_category',
		fieldName: 'orgCategoryId',
		antoClass:"auto-wrap1"
    }); --%>
	
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
        'iconSrc':'icon/destop-icon/desktop2_icon_349.png',
        'windowsId':'addFieldDictionary',
        'windowTitle':'<i18n:I18n key="" defaultValue="新增字段字典值"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>common/searchdictionary/addFieldDictionary.jsp',
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


$("#delBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if(selectRows.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var row = selectRows[0];
	var _elsAccount = row.elsAccount;
	if(_elsAccount != elsAccount){
		alert("100000账号数据不能删除！",2);
		return;
	}
	var param = {"elsAccount":elsAccount,"tableName":row.tableName,"fieldName":row.fieldName};
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除?" key=""/>',closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/ElsSearchDictionaryService/deleteField",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
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
	var paramObj = $("#searchDictionaryForm").serializeJSON();
    $.extend(headGrid.opts.params,paramObj);
    headGrid.load();
}
</script>
</body>
</html>