<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
	<div class="box-wrap pos-relative bg-common">
		<%-- <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="xxx" defaultValue="物料详情" /></span> --%>
		<div style="height:30px;">
			<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
<%-- 			<button id="setBtn" class="button-wrap"><i18n:I18n key='i18n_material_specificationsetting' defaultValue='设置物料规格' /></button> --%>
			<button id="cancelBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
		</div>
		<div class="common-box-line">
		    <input type="hidden" name="elsAccount" value="${elsAccount}" />
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />：</span><input id="materialNumber" name="materialNumber" type="text" />
			</div>
			<br>
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />：</span><input id="materialName" name="materialName" type="text" />
			</div>
			<br>
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述" />：</span><input id="materialDesc" name="materialDesc" type="text" />
			</div>
			<br>
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_materialgroup" defaultValue="物料组" />：</span><input id="materialGroup" name="materialGroup" type="text" />
			</div>
			<br>
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_material_productline" defaultValue="产品线" />：</span><input id="productLine" name="productLine" type="text" />
			</div>
			<br>
			<div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_title_materialcatecode" defaultValue="物料分类编码" />：</span>
		    <select id="fbk1" name="fbk1"></select>
		    <span id="viewBtn" style='color:blue;cursor:pointer'><i18n:I18n key='i18n_button_viewmaterialspec' defaultValue='查看物料特性' /></span>
			</div>
			<br>
		    <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_material_islocked" defaultValue="是否锁定" />：</span> 
					<select id="isLockedSelector" name="isLocked">
						<option value='N'><i18n:I18n key='i18n_material_unlocked' defaultValue='未锁定' /></option>
						<option value='Y'><i18n:I18n key='i18n_material_locked' defaultValue='锁定' /></option>
					</select>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">
var materialNumber = "<%= request.getParameter("materialNumber") %>";
var materialCateList;
$().ready(function(){
	init();
});
function init(){
	data = {"materialNumber":materialNumber,"elsAccount":elsAccount};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialService/getMaterial",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			materialCateList = data.materialCateList;
			initSelectors();
			if (materialNumber != null && materialNumber != "null" && materialNumber != "") {
				//修改操作,从服务器返回数据
				$("#materialNumber").val(data.materialNumber);
				$("#materialNumber").attr("readonly",true);
				$("#materialName").val(data.materialName);
				$("#materialDesc").val(data.materialDesc);
				$("#materialGroup").val(data.materialGroup);
				$("#productLine").val(data.productLine);
				$("#isLockedSelector").val(data.isLocked);
				$("#fbk1").val(data.fbk1);
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

function initSelectors(){
	var html = "";
	for (var i=0;i<materialCateList.length;i++){
		var materialCateCode = materialCateList[i].materialCateCode;
		var materialCateName = materialCateList[i].materialCateName;
		html += "<option value='"+materialCateCode+"'>" + materialCateCode + "_" + materialCateName + "</option>";
	}
	$("#fbk1").empty();
	$("#fbk1").append(html);
}

function checkVal(){
	var msg;
	var materialNumber = $("#materialNumber").val();
	if(materialNumber == ""){
		msg = "<i18n:I18n key="i18n_material_fillnumber" defaultValue="请填写物料编号" />";
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
	var url;
	if (materialNumber != "null" && materialNumber != "") {
		url = "<%=basePath%>rest/MaterialService/updateMaterial";
	} else {
		url = "<%=basePath%>rest/MaterialService/addMaterial";
	}
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :url,
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			materialNumber = $("#materialNumber").val();
			$("#materialNumber").attr("readonly",true);
			closeCallback();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				if (data.status == "401") {
					alert('<i18n:I18n key="i18n_upload_materialdupli" defaultValue="物料编号重复" />',2);
			    }else {
				    alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			    }
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
	parent.elsDeskTop.closeCurWin('editMaterial',null);
});

function closeCallback() {
 	if (parent.frames["iframeApp_materialManage"]) {
		parent.frames["iframeApp_materialManage"].query();
	} 
}
</script>
</body>
</html>