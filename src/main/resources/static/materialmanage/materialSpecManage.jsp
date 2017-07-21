<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
<%-- 	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				
				
			</div>
		</div>
	</div> --%>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_material_catelist" defaultValue="物料特性列表" /></span>
         <div class="common-box-line">
         		<div class="edit-box-wrap">
         		    <button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
         		    <button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				    <%-- 
					<button id="btnEdit" class="button-wrap"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
					<button id="btnSAPImport" class="button-wrap"><i18n:I18n key="i18n_upload_fromsap" defaultValue="SAP导入" /></button>
					<button id="btnFileUpload" class="edit-btn button-wrap btnUpload"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></button>
					<button id="btnDownloadTemplate" class="edit-btn button-wrap btnUpload elsEdit"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="下载导入模板" /></button>
					--%>
					<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
					<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
				</div>
				<input type="hidden" name="elsAccount" value="${elsAccount}" />
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
         </div>
 </div>
</form>
<script type="text/javascript">
var grid;
var cols = [
            { title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />', name:'elsAccount' ,width:180, align:'center'  , hidden:true, renderer:function(val){
   	            if (!val) {val = "";}
  	            return val + "<input name='materialSpecList[][elsAccount]' type='hidden' value='"+val+"'/>"; 
            }},
            { title:'<i18n:I18n key="i18n_material_speccode" defaultValue="物料特性编码" />', name:'materialSpecCode' ,width:180, align:'center' ,renderer:function(val){
       	        if (!val) {val = "";}
      	        return "<input name='materialSpecList[][materialSpecCode]' type='text' value='"+val+"'/>"; 
            }},
            { title:'<i18n:I18n key="i18n_material_specname" defaultValue="物料特性名称" />', name:'materialSpecName' ,width:180, align:'center' ,renderer:function(val){
       	        if (!val) {val = "";}
      	        return "<input name='materialSpecList[][materialSpecName]' type='text' value='"+val+"'/>"; 
            }}
        ];

var blankRow = {"elsAccount":elsAccount,"materialSpecCode":"","materialSpecName":""};

$().ready(function(){
	init();
});
function init(){
	var height=$(document).height()-295;
	var frm = $("#form");
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/MaterialCateService/queryMaterialSpecList",
        params: frm.serializeJSON(),
        method: "POST",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:"200px",
        checkCol:true
    });
	grid.on('loadSuccess',function(e,data) {
		if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			grid.select(0);
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
}); 

function checkVal(){
	var msg;
	var array = [];
	$("#table").find("tr").each(function(){
		var materialSpecCode = $(this).find("input[name='materialSpecList[][materialSpecCode]']").val();
		if(materialSpecCode == ""){
			msg = '<i18n:I18n key="i18n_material_fillspeccode" defaultValue="请填写物料特性编码" />';
			return;	
		}else{
			array.push(materialSpecCode);
		}	
	});
    if(array.length > 1){
    	var nary = array.sort(); 
    	for(var i=0;i<nary.length-1;i++){ 
    		if (nary[i]==nary[i+1]){
    			msg = '<i18n:I18n key="i18n_material_speccodedupl" defaultValue="物料特性编码重复" />'; 
    	    } 
    	} 
    }
	return msg;
}

//保存
$("#saveBtn").click(function(){
	msg = checkVal();
	if(msg){
		alert(msg,2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialCateService/updateMaterialSpecList",
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

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('materialSpecManage',closeCallback);
});

function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}
</script>
</body>
</html>