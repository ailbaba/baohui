<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String templateCode = request.getParameter("templateCode");
String templateName = request.getParameter("templateNameTemp");
%>

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
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_schedule_lable_template" defaultValue="模板" /></span>
    <div class="common-box-line">
				<div class="dis-in-b input-and-tip">
				     <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />：</span>
				     <input id="templateCode" name="templateCode" type="text"/>
				</div>
				<div class="dis-in-b input-and-tip">
				     <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />：</span>
				     <input id="templateName" name="templateName" type="text"/>
				</div>
                <input id="elsAccount" name="elsAccount" value="${elsAccount}" type="hidden"/>
    </div>
</div>
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_schedule_lable_step" defaultValue="步骤" /></span>
         <div class="common-box-line">
         		<div class="edit-box-wrap">
					<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				</div>
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-step"></table>
                    </div>
                </main>
         </div>
</div>
</form>
<script type="text/javascript">
<%-- var templateCode = "<%=templateCode%>"; --%>
<%-- var templateName = "<%=templateName%>"; --%>
var obj = getIframeData();
var templateCode = obj.materialNumber;
var templateName = obj.materialDesc;
var toElsAccount = obj.toElsAccount;
debugger;
var stepGrid;
var cols_step = [
                   { title:'<i18n:I18n key="i18n_label_stepCode" defaultValue="步骤编号" />', name:'stepCode' ,width:180, align:'center' ,renderer:function(val){
               	    if (!val) {val = "";}
              	    return "<input name='stepList[][stepCode]' type='text' readonly='readonly' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_label_stepName" defaultValue="步骤名称" />', name:'stepName' ,width:180, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<input name='stepList[][stepName]' type='text' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_schedule_title_cycletype" defaultValue="周期类型" />', name:'cycleType' ,width:150, align:'center',renderer:function(val){
                  	 return "<span class='showText' style='display:none'>" + val + "</span>" + "<select name='stepList[][cycleType]'><option value='D'><i18n:I18n key='' defaultValue='天' /></option></select>";
                   }},
                   { title:'<i18n:I18n key="i18n_schedule_title_estimatecycle" defaultValue="预估周期" />', name:'estimateCycle' ,width:180, align:'center' ,renderer:function(val){
                 	    if (!val) {val = "0";}
                	    return "<input name='stepList[][estimateCycle]' type='text' value='"+val+"'/>"; 
                  }},
                  { title:'<i18n:I18n key="" defaultValue="预计产能" />', name:'quantity' ,width:180, align:'center' ,renderer:function(val){
                	    if (!val) {val = "0.00";}
               	    return "<input name='stepList[][quantity]' type='text' value='"+val+"'/>"; 
                 }},
                 { title:'<i18n:I18n key="i18n_schedule_title_estimatexxxx" defaultValue="预警天数" />', name:'warningDays' ,width:100, align:'center' ,renderer:function(val){
              	    if (!val) {val = "0";}
             	    return "<input name='stepList[][warningDays]' type='text' value='"+val+"'/>"; 
                 }}
               ];

var step_blankRow = {"stepCode":"","stepName":"","cycleType":"D","estimateCycle":"0","quantity":"0.00","warningDays":"0"};

$().ready(function(){
	init();
});
function init(){
	if(elsAccount == "160000"){
		$("#saveBtn").hide();
	}
	var height=$(document).height()-295;
	if(!stepGrid){
		stepGrid = $('#table-step').mmGrid({
	        cols: cols_step,
	        checkCol:true,
	        height:height,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items: []
	    });
	}
	loadSteps();
}
//获取数据
function loadSteps(){
	if(templateCode != null && templateCode != "null" && templateCode != ""){
		debugger;
		if(elsAccount == "160000"){
			elsAccount = toElsAccount;
		}
		$.ajax({
			url :"<%=basePath%>rest/OrderScheduleService/getTemplateStep/"+elsAccount+"/"+templateCode,
			dataType : "json",
			type :"get",
			contentType : "application/json",
			success : function(data) {
				if (data&&data.statusCode == "-100") {
				     alert(data.message,3);
				 } else {
					 fillData(data);
				}
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}else{
		$("#templateCode").attr("readonly",false);
		$("#templateName").attr("readonly",false);
	}
}

//填充策略明细
function fillData(data) {
		$("#templateCode").val(templateCode);
		$("#templateName").val(templateName);
		$("#templateCode").attr("readonly",true);
		$("#templateName").attr("readonly",true);
		stepGrid.load(data.rows);
		initSelect();
}

//初始化下拉框
function initSelect(){
	$('#table-step').find("td").each(function(){
		var val=$(this).find(".showText").text();
		var selectObj=$(this).find("select");
		if(selectObj.length>0){
			selectObj.val(val);
		}
	});
}

//新增步骤
$("#btnAdd").click(function(){
	//取出最大的stepCode
	var stepCode = 0;
	for(var i=0;i<stepGrid.rowsLength();i++){
		var temCode = parseInt(stepGrid.row(i).stepCode);
		if(stepCode <= temCode)
			stepCode = temCode;
	}
	//添加一行
	var newRow = $.extend({}, step_blankRow);
	newRow.stepCode = stepCode + 1;
	newRow.stepName = "<i18n:I18n key='i18n_schedule_lable_step' defaultValue='步骤' />" + newRow.stepCode;
	stepGrid.addRow(newRow,stepGrid.rowsLength());
	initSelect();
});

//删除步骤
$("#btnDelete").click(function(){
	var selectedIndexs = stepGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key='i18n_schedule_choosesteptodelete' defaultValue='请选择要删除的步骤！' />",2);
		return;
	}
	stepGrid.removeRow(selectedIndexs[0]);
});

//保存
$("#saveBtn").click(function(){
	var templateNewCode = $("#templateCode").val();
	if(templateNewCode == ""){
		alert("<i18n:I18n key='i18n_schedule_entertemplatecode' defaultValue='请填写模板编号！' />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var url;
	if(templateCode == null || templateCode == "null" || templateCode == ""){
		url = "<%=basePath%>rest/OrderScheduleService/addTemplate";
	} else {
		url = "<%=basePath%>rest/OrderScheduleService/saveMaterialSourceTemplate";
	}
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :url,
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data.statusCode != 200) {
				$("#templateCode").focus();
				alert(data.message,2);
			}else{
				templateCode = templateNewCode;
				$("#templateCode").attr("readonly",true);
				$("#templateName").attr("readonly",true);
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />！');
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

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('editMaterialScheduleTemplate',closeCallback);
});

function closeCallback() {
	if (parent.frames["iframeApp_materialSourceProductionCycle"]) {
		parent.frames["iframeApp_materialSourceProductionCycle"].refreshData();
	}
}
</script>
</body>
</html>