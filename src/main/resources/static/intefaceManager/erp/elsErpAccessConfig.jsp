<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
		
<body>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/ElsErpService/queryElsErpAccessConfigs">
            <div class="common-box-line">
           		<button style="margin-left: 5px;" id="deleteElsAccount" class="button-wrap">删除</button>
           	 	<button style="margin-left: 5px;" id="addElsAccount" class="button-wrap">新增</button>
           	 	<button style="margin-left: 5px;" id="saveElsAccount" class="button-wrap">保存</button>
            	<button style="margin-left: 5px;" id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
            </form>
        </div>
	   <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="ERP系统配置 " /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100" id="materialTotal">
                       <table id="table-head"></table>
						<div id="pg" style="text-align: right;display: inline-block;position: absolute;top: -49px;right: 19px;"></div>
                    </div>
                </main>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="接口配置信息" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                      	<li><a href="#edit-line-import"><i18n:I18n key="test" defaultValue="接口入参配置信息" /></a></li>
						<li class="edit-line-export"><a href="#edit-line-export"><i18n:I18n key="test" defaultValue="接口出参配置信息" /></a></li>
                    </ul>
                    <div id="edit-line-import">
                         <main class="grid-container nest-table">
                         <div class="common-box-line">
								<button id="addRowImport" class="button-wrap"><i18n:I18n key="test" defaultValue="新增行" /></button>
								<button id="saveRowImport" class="button-wrap"><i18n:I18n key="test" defaultValue="保存行" /></button>
								<button id="removeRowImport" class="button-wrap"><i18n:I18n key="test" defaultValue="删除行" /></button>
			             </div>
		                    <div class="grid-100" id="reCreate">
		                        <table id="table-import-item"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="edit-line-export">
                       <main class="grid-container nest-table">
                         <div class="common-box-line">
								<button id="addRowExport" class="button-wrap"><i18n:I18n key="test" defaultValue="新增行" /></button>
								<button id="removeRowExport" class="button-wrap"><i18n:I18n key="test" defaultValue="删除行" /></button>
								<button id="saveRowExport" class="button-wrap"><i18n:I18n key="test" defaultValue="保存行" /></button>
			             </div>
		                    <div class="grid-100" id="reCreate">
		                        <table id="table-export-item"></table>
		                    </div>
		                </main>
                    </div>
                </div>
            </div>
        </div>
        
<script type="text/javascript">
var headerGrid;
var itemImportGrid;
var itemExportGrid;
var selectElsAccount;
var reqCode = getIframeData().reqCode;
var elsAccountNumber = getIframeData().elsAccount;

//渲染   @author jiangzhidong 20160611  begin
//允许任何字符输入框
var initInputAny = function (val,item,index){
	if(!val) { val = '';}
	return '<input class="updateRowBtn" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>'+"<span style='display: none;'>"+JSON.stringify(item)+"</span>";
};
//日期
var formatDate = function (val,item,index){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	   return val;
};
//接口编号
var initFunctionId = function (val,item,index){
	if (!val) {val = "";}
	return  '<input class="updateRowBtn" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" style="color:blue;" value="'+val+'"/>'+"<span style='display: none;'>"+JSON.stringify(item)+"</span>";

};
//----------------------Import----------------------------
//允许任何字符输入框
var initInputAnyImport = function (val,item,index){
	if(!val) { val = '';}
	return '<input class="updateRowImportBtn" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>'+"<span style='display: none;'>"+JSON.stringify(item)+"</span>";
};
//接口编号Import
var initParamNameImport = function (val,item,index){
	if(!val) { val = '';}
	return '<input class="paramNameBtn updateRowImportBtn" type="text" style="color:blue;" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>'+"<span style='display: none;'>"+JSON.stringify(item)+"</span>";
};
//----------------------Export----------------------------
//允许任何字符输入框
var initInputAnyExport = function (val,item,index){
	if(!val) { val = '';}
	return '<input class="updateRowExportBtn" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>'+"<span style='display: none;'>"+JSON.stringify(item)+"</span>";
};
//接口编号Export
var initParamNameExport = function (val,item,index){
	if(!val) { val = '';}
	return '<input class="paramNameBtn updateRowExportBtn" type="text" style="color:blue;" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>'+"<span style='display: none;'>"+JSON.stringify(item)+"</span>";
};

//渲染   @author jiangzhidong 20160611  end

var cols=[{ title:'els账号', name:'elsAccount', width: 80, align: 'center' },
	      { title:'请求事务码', name:'reqCode' ,width:80, align:'center', renderer:initInputAny},
	      { title:'连接编号', name:'connId' ,width:80, align:'center', renderer:initInputAny},
	      { title:'接口编号', name:'functionId' ,width:80, align:'center', renderer:initFunctionId},
	      { title:'创建时间', name:'createDate' ,width:80, align:'center', renderer:formatDate},
	      { title:'创建人', name:'createUser' ,width:120, align:'center'}];

var cols_import_item = [
	        { title:'接口编号', name:'functionId', width: 80, align: 'center'},
	        { title:'接口参数名', name:'paramName' ,width:100, align:'center', renderer:initParamNameImport},
	        { title:'接口参数类型', name:'paramType' ,width:120, align:'center', renderer:initInputAnyImport},
	        { title:'接口参数默认值', name:'paramDefaultValue' ,width:120, align:'center', renderer:initInputAnyImport},
	        { title:'对应传入数据名', name:'inputDataName' ,width:120, align:'center', renderer:initInputAnyImport},
	        { title:'对应传入数据类型', name:'inputDataType' ,width:120, align:'center', renderer:initInputAnyImport},
	        { title:'对应传入数据来源类型', name:'inputDataFromType' ,width:120, align:'center', renderer:initInputAnyImport},
	        { title:'对应传入数据表达式', name:'inputDataExpression' ,width:120, align:'center', renderer:initInputAnyImport},
	        { title:'创建时间', name:'createDate' ,width:80, align:'center', renderer:formatDate},
		    { title:'创建人', name:'createUser' ,width:120, align:'center'}];
               		    
var cols_export_item = [
			{ title:'接口编号', name:'functionId', width: 80, align: 'center'},
	        { title:'接口参数名', name:'paramName' ,width:120, align:'center', renderer:initParamNameExport},
	        { title:'接口参数类型', name:'paramType' ,width:120, align:'center', renderer:initInputAnyExport},
	        { title:'创建时间', name:'createDate' ,width:80, align:'center', renderer:formatDate},
		    { title:'创建人', name:'createUser' ,width:120, align:'center'}];

$().ready(function(){
	$('#sheet-project').tabs();
	init();
});

function init(){
	
	//--------------------------------------------ERP系统配置---------------------------------------------
    var frm = $("#queryForm");
    var obj = frm.serializeJSON();
    obj["elsAccount"]=elsAccountNumber;
    obj["reqCode"]=reqCode;
    var height = $(document).height()-160;
    if (!headerGrid) {
    	headerGrid = $('#table-head').mmGrid({
	        cols: cols,
	        url : frm[0].action,
	        params: obj,
	        method:  frm[0].method,
	        root:"rows",
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        remoteSort:true,
	        height: 150,
	        plugins: [
	            $('#pg').mmPaginator({
	                style: 'plain'
	                , totalCountName: 'total'
	                , page: 1
	                , pageParamName: 'currentPage'
	                , limitParamName: 'pageSize'
	                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
	                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
	                , limit:null
	                , limitList: [10,20,30,50]
	            })
	        ]
	    });
	}
    
    headerGrid.on('loadSuccess', function(e, data) {
    	if (data.rows && data.rows.length > 0) {
    		loadImportItem(data.rows[0]);
    		loadExportItem(data.rows[0]);
		}
	});
    
    headerGrid.on('cellSelected', function(e, item, index) {
    	if(item!=null){
    		loadImportItem(item);
    		loadExportItem(item);
    	}
    });
    
    headerGrid.on('loadError', function(e, data) {
    	if (!permissionError(data)) {
			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		}
    });
    
    
    //--------------------------------------------接口入参配置信息---------------------------------------------
    itemImportGrid = $('#table-import-item').mmGrid({
        cols: cols_import_item,
        data:[],
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol:true,
        remoteSort:true,
        multiSelect:true,
        height: 250,
    });
	
	//--------------------------------------------接口出参配置信息---------------------------------------------
    itemExportGrid = $('#table-export-item').mmGrid({
        cols: cols_export_item,
        data:[],
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol:true,
        remoteSort:true,
        multiSelect:true,
        height: 250,
    });
}

//--------------------------------------------ERP系统配置---------------------------------------------

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin("elsErpAccessConfig",closeCallback());
});

//添加
$("#addElsAccount").click(function(){
	headerGrid.addRow({"elsAccount":elsAccount});
});

//保存
$("#saveElsAccount").click(function(){
	var rows=headerGrid.rows();
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定保存ERP系统配置？',closeEvent:function(){
    	parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/ElsErpService/saveElsErpAccessConfigs",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(rows),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data!=null&&data.statusCode == "-100") {
					alert(data.message,3);
				} else {
					loadImportItem(data[0]);
		    		loadExportItem(data[0]);
					alert("保存成功！");
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	}});
});

//删除
$("#deleteElsAccount").click(function(){
	var rows=headerGrid.selectedRows();
	if(rows.length<=0){
		alert("请选择行",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定删除ERP系统配置？',closeEvent:function(){
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/ElsErpService/deleteElsErpAccessConfigs",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(rows),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data!=null&&data.statusCode == "-100") {
				alert(data.message,3);
			} else {
				headerGrid.load({});
				loadImportItem(data[0]);
	    		loadExportItem(data[0]);
				alert("删除成功！",2);
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
	}});
});

//--------------------------------------------接口入参配置信息---------------------------------------------
//接口入参配置信息
function loadImportItem(importItem){
	$.ajax({
		url :"<%=basePath%>rest/ElsErpService/queryElsErpFunctionImports",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(importItem),
		dataType : "json",
		success : function(data) {
			if (data!=null&&data.statusCode == "-100") {
				alert(data.message,2);
			} else {
				itemImportGrid.load(data);
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

//添加
$("#addRowImport").click(function(){
	var rows=headerGrid.selectedRows();
	if(rows.length!=1){
		alert("请选择行",2);
		return;
	}
	var functionId = rows[0].functionId;
	itemImportGrid.addRow({"functionId":functionId});
});

//保存
$("#saveRowImport").click(function(){
	var rows=itemImportGrid.rows();
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定保存接口入参配置信息？',closeEvent:function(){
    	parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/ElsErpService/saveElsErpFunctionImports",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(rows),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data!=null&&data.statusCode == "-100") {
					alert(data.message,3);
				} else {
					loadImportItem(data[0]);
		    		loadExportItem(data[0]);
					alert("保存成功！");
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	}});
});

//删除
$("#removeRowImport").click(function(){
	var rows=itemImportGrid.selectedRows()
	if(rows.length<=0){
		alert("请选择行",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定删除接口入参配置信息？',closeEvent:function(){
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/ElsErpService/deleteElsErpFunctionImports",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(rows),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data!=null&&data.statusCode == "-100") {
				alert(data.message,3);
			} else {
				headerGrid.load({});
				loadImportItem(data[0]);
	    		loadExportItem(data[0]);
				alert("删除成功！",2);
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
	}});
});

//--------------------------------------------接口出参配置信息---------------------------------------------
//接口出参配置信息
function loadExportItem(importItem){
	$.ajax({
		url :"<%=basePath%>rest/ElsErpService/queryElsErpFunctionExports",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(importItem),
		dataType : "json",
		success : function(data) {
			if (data!=null&&data.statusCode == "-100") {
				alert(data.message,2);
			} else {
				itemExportGrid.load(data);
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

//添加
$("#addRowExport").click(function(){
	var rows=headerGrid.selectedRows();
	if(rows.length!=1){
		alert("请选择行",2);
		return;
	}
	var functionId = rows[0].functionId;
	itemExportGrid.addRow({"functionId":functionId});
});

//保存
$("#saveRowExport").click(function(){
	var rows=itemExportGrid.rows();
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定保存接口出参配置信息？',closeEvent:function(){
    	parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/ElsErpService/saveElsErpFunctionExports",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(rows),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data!=null&&data.statusCode == "-100") {
					alert(data.message,3);
				} else {
					loadImportItem(data[0]);
		    		loadExportItem(data[0]);
					alert("保存成功！");
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	}});
});

//删除
$("#removeRowExport").click(function(){
	var rows=itemExportGrid.selectedRows()
	if(rows.length<=0){
		alert("请选择行",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定删除接口出参配置信息？',closeEvent:function(){
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/ElsErpService/deleteElsErpFunctionExports",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(rows),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data!=null&&data.statusCode == "-100") {
				alert(data.message,3);
			} else {
				headerGrid.load({});
				loadImportItem(data[0]);
	    		loadExportItem(data[0]);
				alert("删除成功！",2);
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
	}});
});

//返回回调函数
function closeCallback() {
}

//查询
function query() {
	var frm = $("#queryForm");
	itemImportGrid.opts.params = frm.serializeJSON();
	itemImportGrid.load({});
}

//查询表els_erp_function_struct
$('.paramNameBtn').live("dblclick", function() {
	var editCol = $(this).next().text();
	var headRows = JSON.parse(editCol);
	var url='<%=basePath%>intefaceManager/erp/elsErpFunctionStruct.jsp?functionId='+headRows.functionId+'&paramName='+headRows.paramName;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
        'windowsId':'elsErpFunctionStruct',
        'windowTitle':'<i18n:I18n defaultValue="参数属性结构信息" key="test"></i18n:I18n>',
        'iframSrc':url,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
 });
 
//编辑事件
$('.updateRowBtn').live("blur", function() {
	var editCol = $(this).next().text();
	var item = JSON.parse(editCol);
	var name = this.id.split('_')[0];
	var index = this.id.split('_')[1];
	item[name]=this.value;
	headerGrid.updateRow(item,index);
 });
//----------------------Import----------------------------
$('.updateRowImportBtn').live("blur", function() {
	var editCol = $(this).next().text();
	var item = JSON.parse(editCol);
	var name = this.id.split('_')[0];
	var index = this.id.split('_')[1];
	item[name]=this.value;
	itemImportGrid.updateRow(item,index);
 });
//----------------------Export----------------------------
$('.updateRowExportBtn').live("blur", function() {
	var editCol = $(this).next().text();
	var item = JSON.parse(editCol);
	var name = this.id.split('_')[0];
	var index = this.id.split('_')[1];
	item[name]=this.value;
	itemExportGrid.updateRow(item,index);
 });

</script>
</body>
</html>