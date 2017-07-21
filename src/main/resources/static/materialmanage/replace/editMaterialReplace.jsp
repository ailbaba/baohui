<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<input id="id" name="id" type="hidden" />
	<div class="box-wrap pos-relative bg-common">
		<div style="height:30px;">
			<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
			<button id="cancelBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
		</div>
		<div class="common-box-line">
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72" style="float: left"><i18n:I18n key="test" defaultValue="替代组代码" />：</span><input id="replaceGroup" name="replaceGroup" type="text" />
			</div>
			<br>
			 <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72" style="float: left"><i18n:I18n key="test" defaultValue="替代组名称" />：</span><input id="replaceName" name="replaceName" type="text" />
			</div>
			<br>
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72" style="float: left"><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />：</span>
		    <input id="materialNumber" name="materialNumber" type="text" readonly="readonly" style="width: 300px;" placeholder="物料编号" class = "findMaterial"/>
			<img src="../../icon/min/search_gray.png" style="position: absolute; width: 17px; height: 17px;left: 256px;top: 123px;cursor: pointer;" class="findMaterial" title="物料编号" />
			</div>
			<br>
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72" style="float: left"><i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />：</span><input id="materialName" name="materialName" type="text" />
			</div>
			<br>
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72" style="float: left"><i18n:I18n key="test" defaultValue="物料描述" />：</span><input id="materialDesc" name="materialDesc" type="text" />
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">
var materialNumber = "<%= request.getParameter("materialNumber") %>";
var opType = "<%= request.getParameter("opType") %>";	
var materialCateList;
$().ready(function(){
	init();
});
function init(){
	debugger;
	var obj = getIframeData();
	$("#replaceGroup").val(obj[0].replaceGroup);
	$("#replaceName").val(obj[0].replaceName);
	if(opType == "upd"){
		$("#replaceGroup").attr("readonly",true);
		$("#replaceName").attr("readonly",true);
		$("#id").val(obj[0].id);
		$("#materialNumber").val(obj[0].materialNumber);
		$("#materialName").val(obj[0].materialName);
		$("#materialDesc").val(obj[0].materialDesc);
	}
}

//保存
$("#saveBtn").click(function(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var frm = $("#form");
	var obj = frm.serializeJSON();
	obj["elsAccount"]=elsAccount;
	parent.elsDeskTop.showLoading();
	var url ='';
	if(opType == "upd")
	{
		url = "<%=basePath%>rest/MaterialReplaceService/updateMaterialReplace";
	}else
	{			
		url = "<%=basePath%>rest/MaterialReplaceService/addMaterialReplace";
	}
	$.ajax({
		url :url,
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(obj),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			closeCallback();
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

$("#setBtn").click(function(){
	var materialName = $("#materialName").val();
	if(materialNumber == "null" || materialNumber == ""){
		$("#saveBtn").trigger("click");
	}else{
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editMaterialSpecification',
	        'windowTitle':'<i18n:I18n key="i18n_material_specificationsetting" defaultValue="设置物料规格" />',
	        'iframSrc':'<%=basePath%>materialmanage/editMaterialSpecification.jsp?materialNumber=' + materialNumber + '&materialName=' + materialName,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
});

$("#viewBtn").click(function(){
	var materialCateCode = $("#fbk1").val();
	var materialCateName = $("#fbk1").find("option:selected").text().split("_")[1];
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'viewMaterialSpecRelation',
        'windowTitle':'<i18n:I18n key="i18n_button_viewmaterialspec" defaultValue="查看物料特性" />',
        'iframSrc':'<%=basePath%>materialmanage/viewMaterialSpecRelation.jsp?materialCateCode=' + materialCateCode + '&materialCateName=' + materialCateName,
        'windowWidth':580,
        'windowHeight':350,
        'parentPanel':".currDesktop"
    });
});

//退出
$("#cancelBtn").click(function(){
	parent.elsDeskTop.closeCurWin('editMaterialReplace',null);
});

function closeCallback() {
 	if (parent.frames["iframeApp_materiaReplaceManage"]) {
		parent.frames["iframeApp_materiaReplaceManage"].query();
	}
 	parent.elsDeskTop.closeCurWin('editMaterialReplace',null);
}

$('.findMaterial').live("click", function(event) {
    //兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'findMaterialManage',
        'windowTitle':'<i18n:I18n key="i18n_common_title_selectcontracttypecode" defaultValue="选择物料" />',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>materialmanage/replace/findMaterialManage.jsp?frameAppId=editMaterialReplace',
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 500,
        'windowPositionTop':24,
        'windowWidth':960,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
});

//回调
function selectMaterialCallbackFunc(row){
	$("#materialNumber").val(row.materialNumber);
	$("#materialName").val(row.materialName);
	$("#materialDesc").val(row.materialDesc);
}
</script>
</body>
</html>