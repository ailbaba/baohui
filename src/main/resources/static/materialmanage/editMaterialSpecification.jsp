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
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="uploadBtn" class="edit-btn button-wrap btnUpload elsEdit"><i18n:I18n key="i18n_label_uploadmaterialspecification" defaultValue="上传物料规格" /></button>
				<button id="btnDownloadTemplate" class="edit-btn button-wrap btnUpload elsEdit"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="下载导入模板" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_material_list" defaultValue="物料列表" /></span>
         <div class="common-box-line">
         		<div class="edit-box-wrap">
					<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				</div>
				<input type="hidden" name="elsAccount" value="${elsAccount}" />
				<input type="hidden" name="materialNumber" id="materialNumber"/>
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table"></table>
                    </div>
                </main>
         </div>
 </div>
</form>
<script type="text/javascript">
var materialNumber = "<%=request.getParameter("materialNumber")%>";
var materialName = "<%=request.getParameter("materialName")%>";
$("#materialNumber").val(materialNumber);
var fileUploader;
var grid;
var cols = [
                   { title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />', name:'elsAccount' ,width:180, align:'center' , hidden:true, renderer:function(val){
           	            if (!val) {val = "";}
          	            return val + "<input name='materialSpecificationList[][elsAccount]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber' ,width:180, align:'center' ,hidden:true, renderer:function(val){
               	        if (!val) {val = "";}
              	        return val + "<input name='materialSpecificationList[][materialNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_material_name" defaultValue="物料名称" />', name:'materialName' ,width:180, align:'center', renderer:function(val){
              	        return materialName; 
                   }},
                   { title:'<i18n:I18n key="i18n_common_title_materialSpecification" defaultValue="物料规格" />', name:'materialSpecification' ,width:180, align:'center' ,renderer:function(val){
                 	    if (!val) {val = "";}
                	    return "<input name='materialSpecificationList[][materialSpecification]' type='text' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_material_pinpai" defaultValue="品牌" />', name:'attribute1' ,width:180, align:'center' ,renderer:function(val){
                	    if (!val) {val = "";}
               	    return "<input name='materialSpecificationList[][attribute1]' type='text' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_material_long" defaultValue="长度" />', name:'attribute2' ,width:180, align:'center' ,renderer:function(val){
               	    if (!val) {val = "";}
              	    return "<input name='materialSpecificationList[][attribute2]' type='text' value='"+val+"'/>"; 
                  }},
                  { title:'<i18n:I18n key="i18n_material_width" defaultValue="宽度" />', name:'attribute3' ,width:180, align:'center' ,renderer:function(val){
              	    if (!val) {val = "";}
             	    return "<input name='materialSpecificationList[][attribute3]' type='text' value='"+val+"'/>"; 
                  }},
                  { title:'<i18n:I18n key="i18n_material_texture" defaultValue="材质" />', name:'attribute4' ,width:180, align:'center' ,renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<input name='materialSpecificationList[][attribute4]' type='text' value='"+val+"'/>"; 
                  }},
                 { title:'<i18n:I18n key="i18n_material_color" defaultValue="颜色" />', name:'attribute5' ,width:180, align:'center' ,renderer:function(val){
            	    if (!val) {val = "";}
           	        return "<input name='materialSpecificationList[][attribute5]' type='text' value='"+val+"'/>"; 
                 }}
               ];

var blankRow = {"elsAccount":elsAccount,"materialNumber":materialNumber,"materialName":materialName,"materialSpecification":"","attribute1":"","attribute2":"","attribute3":"","attribute4":"","attribute5":""};

$(document).ready(function(){
	init();
	//上传物料规格
		initFileUploader(fileUploader);
});
function init(){
	var height=$(document).height()-295;
	var frm = $("#form");
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/MaterialService/queryMaterialSpecificationList",
        params: frm.serializeJSON(),
        method: "POST",
        root:"lstData",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:"200px",
        checkCol:true
    });
	grid.on('loadSuccess',function(e,data) {
		if (data && data.length > 0) {
			//默认选中第一行
			grid.select(0);
		}
	});
}

$("#btnDownloadTemplate").click(function(){
	window.location.href = "${pageContext.request.contextPath}/template/物料规格模板.xlsx";
});

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




function initFileUploader(fileUploader){
    //新增表单文件
    if (!fileUploader) {
	  	fileUploader = WebUploader.create({
	  	    // swf文件路径
		    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		    auto: true,
		    duplicate :true,
		    accept:{
		    	extensions:"xls,xlsx"
		    },
	  	    // 文件接收服务端。
	  	    server: '<%=basePath%>rest/MaterialService/uploadMeterialSpecification',
	  	    // 选择文件的按钮。可选。
	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	  	    pick: '#uploadBtn',
	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	  	    resize: false
	  	});
	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
	  		insertSpecification(response.fileName);
	  	});
    }
}

function insertSpecification(fileName){
	$.ajax({
		url :"<%=basePath%>rest/MaterialService/readSpecificationFormExcel",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify({"elsAccount":elsAccount,"fileName":fileName,}),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data&&data.statusCode == "401") {
				alert(data.message,2);
		    }else{
		    	query();
		    	alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
		    }
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function checkVal(){
	var msg;
	var array = [];
	$("#table").find("tr").each(function(){
		var materialSpecification = $(this).find("input[name='materialSpecificationList[][materialSpecification]']").val();
		if(materialSpecification == ""){
			msg = '<i18n:I18n key="i18n_material_enterspecifi" defaultValue="请填写物料规格" />';
			return;	
		}else{
			array.push(materialSpecification);
		}	
	});
    if(array.length > 1){
    	var nary = array.sort(); 
    	for(var i=0;i<nary.length-1;i++){ 
    		if (nary[i]==nary[i+1]){
    			msg = '<i18n:I18n key="i18n_material_specifidupli" defaultValue="物料规格重复" />'; 
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
		url :"<%=basePath%>rest/MaterialService/saveMaterialSpecificationList",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data.statusCode == "401") {
				alert(data.message,2);
		    }else{
		    	alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
	parent.elsDeskTop.closeCurWin('editMaterialSpecification',closeCallback);
});

function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}
</script>
</body>
</html>