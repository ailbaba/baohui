<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_specrelation" defaultValue="物料分类特性关联列表" /></span>
         <div class="common-box-line">
				<input type="hidden" name="elsAccount" value="${elsAccount}" />
				<input type="hidden" name="materialCateCode" id="materialCateCode"/>
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table"></table>
                    </div>
                </main>
         </div>
 </div>
</form>
<script type="text/javascript">
var materialCateCode = "<%=request.getParameter("materialCateCode")%>";
$("#materialCateCode").val(materialCateCode);
var materialCateName = "<%=request.getParameter("materialCateName")%>";
var materialSpecList;
var grid;
var cols = [
                   { title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />', name:'elsAccount' ,width:180, align:'center' , hidden:true, renderer:function(val){
           	            if (!val) {val = "";}
          	            return val; 
                   }},
                   { title:'<i18n:I18n key="i18n_title_materialcatecode" defaultValue="物料分类编码" />', name:'materialCateCode' ,width:180, align:'center' ,hidden:true, renderer:function(val){
               	        if (!val) {val = "";}
              	        return val; 
                   }},
                   { title:'<i18n:I18n key="i18n_title_serialnumber" defaultValue="序号" />', name:'attrIndex' ,width:180, align:'center' ,renderer:function(val){
               	    if (!val) {val = "";}
              	        return val; 
                   }},
                   { title:'<i18n:I18n key="i18n_title_materialcatename" defaultValue="物料分类名称" />', name:'materialCateName' ,width:180, align:'center', renderer:function(val){
              	        return materialCateName; 
                   }},
                   { title:'<i18n:I18n key="i18n_material_materialspec" defaultValue="物料特性" />', name:'materialSpecCode' ,width:150, align:'center',renderer:function(val){
                	   if (!val) {val = "";}
                	   return val;
                   }}
               ];

var blankRow = {"elsAccount":elsAccount,"materialCateCode":materialCateCode,"materialCateName":materialCateName,"materialSpecCode":"","attrIndex":""};

$(document).ready(function(){
	init();
});
function init(){
	var height=$(document).height()-295;
	var frm = $("#form");
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/MaterialCateService/queryMaterialSpecRelationList",
        params: frm.serializeJSON(),
        method: "POST",
        root:"materialSpecRelationList",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:"200px",
        checkCol:true
    });
	grid.on('loadSuccess',function(e,data) {
		if (data){
			materialSpecList = data.materialSpecList;
			if (data.materialSpecRelationList.length > 0) {
				//默认选中第一行
				grid.select(0);
				initSelectors($("#table"));
			}
		}
	});
}

//获取数据
function query(){
	var frm = $("#form");
	grid.opts.params = frm.serializeJSON();
	grid.load({});
}

//新增
$("#btnAdd").click(function(){
	grid.addRow(blankRow,grid.rowsLength());
	var $lastLine = $('#table tr:last');
	initSelectors($lastLine);
});

function checkVal(){
	var msg;
	var array = [];
	$("#table").find("tr").each(function(){
		var materialSpecCode = $(this).find("select[name='materialSpecRelationList[][materialSpecCode]']").val();
		var attrIndex = $(this).find("input[name='materialSpecRelationList[][attrIndex]']").val();
		if(attrIndex == ""){
			msg = '<i18n:I18n key="i18n_material_fillserialnumber" defaultValue="请填写对应的字段序号" />';
			return;	
		}else{
			array.push(materialSpecCode);
		}	
	});
    if(array.length > 1){
    	var nary = array.sort(); 
    	for(var i=0;i<nary.length-1;i++){ 
    		if (nary[i]==nary[i+1]){
    			msg = '<i18n:I18n key="i18n_material_specrelationdupl" defaultValue="请不要重复关联同一个物料特性" />'; 
    	    } 
    	} 
    }
	return msg;
}

//保存
$("#saveBtn").click(function(){
	var msg = checkVal();
	if(msg){
		alert(msg,2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialCateService/updateMaterialSpecRelationList",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
$("#btnDelete").click(function(){
	var selectedIndexs = grid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	grid.removeRow(selectedIndexs[0]);
});

function initSelectors($obj){
	var html = "";
	for (var i=0;i<materialSpecList.length;i++){
		var materialSpecCode = materialSpecList[i].materialSpecCode;
		var materialSpecName = materialSpecList[i].materialSpecName;
		html += "<option value='"+materialSpecCode+"'>" + materialSpecCode + "_" + materialSpecName + "</option>";
	}
	$obj.find(".materialSpecCode").each(function(){
		var showText = $(this).prev(".showText").text();
		$(this).empty();
		$(this).append(html);
		if(showText != null && showText != "")
			$(this).val(showText);
	});
}

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('viewMaterialSpecRelation',closeCallback);
});

function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}
</script>
</body>
</html>