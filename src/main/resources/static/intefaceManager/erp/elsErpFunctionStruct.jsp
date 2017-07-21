<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />

<body>
<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/ElsErpService/queryElsErpFunctionStructs">
            <input name="elsAccount" id="elsAccount" style="display:none" type="text"/>
            <input name="integrationType" id="integrationType" style="display:none" type="text"/>
            <div class="common-box-line">
           		<button style="margin-left: 5px;" id="addRow" class="button-wrap">新增</button>
            	<button style="margin-left: 5px;" id="removeRow" class="button-wrap">删除</button>
            	<button style="margin-left: 5px;" id="saveRow" class="button-wrap">保存</button>
            	<button style="margin-left: 5px;" id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
            </form>
        </div>
        <div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="ELS配置" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<main class="grid-container">
					 <form id="submitForm" onsubmit="return false;" >
					<div class="grid-100">
						<table id="table-head"></table>
					</div>
					</form>
					</main>
				</div>
			</div>
		</div>
<script type="text/javascript">
var headerGrid;
var functionId = "<%=request.getParameter("functionId") %>";
var paramName = "<%=request.getParameter("paramName") %>";

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
//渲染   @author jiangzhidong 20160611  end

var cols=[{ title:'接口编号', name:'functionId' ,width:80, align:'center'},
          { title:'接口参数名', name:'paramName' ,width:120, align:'center'},
          { title:'接口参数属性字段名', name:'paramFieldName' ,width:120, align:'center', renderer:initInputAny},
          { title:'接口参数属性字段类型', name:'paramFieldType' ,width:120, align:'center', renderer:initInputAny},
          { title:'接口参数默认值', name:'paramFieldDefaultValue' ,width:120, align:'center', renderer:initInputAny},
          { title:'对应传入数据名', name:'inputDataName' ,width:120, align:'center', renderer:initInputAny},
          { title:'对应传入数据类型', name:'inputDataType' ,width:120, align:'center', renderer:initInputAny},
          { title:'对应传入数据来源类型', name:'inputDataFromType' ,width:120, align:'center', renderer:initInputAny},
          { title:'对应传入数据表达式', name:'inputDataExpression' ,width:120, align:'center', renderer:initInputAny},
          { title:'输出字段的类型', name:'exportDataType' ,width:120, align:'center', renderer:initInputAny},
          { title:'操作方法名', name:'operateMothodName' ,width:120, align:'center', renderer:initInputAny},
          { title:'操作方法参数', name:'operateParam' ,width:120, align:'center', renderer:initInputAny},
          { title:'创建时间', name:'createDate' ,width:100, align:'center',renderer:formatDate},
          { title:'创建人', name:'createUser' ,width:100, align:'center'}];
	        
$().ready(function(){
	init();
	$('.mmg-title:first').text('');
});

function init(){
    var frm = $("#queryForm");
    var obj = frm.serializeJSON();
    obj["functionId"]=functionId;
    obj["paramName"]=paramName;
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
	        indexCol: true,
	        checkCol:true,
	        remoteSort:true,
	        multiSelect:true,
	        height: 500
	    });
	}
    
    headerGrid.on('loadSuccess', function(e, dat) {
    	
	});
    
    headerGrid.on('cellSelected', function(e, item, index) {
    	
    });
    
    headerGrid.on('loadError', function(e, data) {
    	if (!permissionError(data)) {
			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		}
    });
  
}

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin("elsErpFunctionStruct",closeCallback());
});


//添加
$("#addRow").click(function(){
	headerGrid.addRow({"functionId":functionId, "paramName":paramName});
});

//保存
$("#saveRow").click(function(){
	var rows=headerGrid.rows();
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定保存参数属性结构信息？',closeEvent:function(){
    	parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/ElsErpService/saveElsErpFunctionStructs",
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
					alert("保存成功！", 1);
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
$("#removeRow").click(function(){
	var rows=headerGrid.selectedRows()
	if(rows.length<=0){
		alert("请选择要配置的行",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定删除参数属性结构信息？',closeEvent:function(){
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/ElsErpService/deleteElsErpFunctionStructs",
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
				alert("删除成功！",1);
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
	itemGrid.opts.params = frm.serializeJSON();
	itemGrid.load({});
}

//编辑事件
$('.updateRowBtn').live("blur", function() {
	var editCol = $(this).next().text();
	var item = JSON.parse(editCol);
	var name = this.id.split('_')[0];
	var index = this.id.split('_')[1];
	item[name]=this.value;
	headerGrid.updateRow(item,index);
 });

</script>
</body>
</html>