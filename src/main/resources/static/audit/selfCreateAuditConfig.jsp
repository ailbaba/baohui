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
				<button id="entryBtn" class="button-wrap"><i18n:I18n key="xx" defaultValue="提交审批" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
				<input id="stretegyCode" name="stretegyCode" type="hidden"/>
				<input id="stretegyName" name="stretegyName" type="hidden"/>
				
				<input id="propertyCode" name="auditStretegyItem[propertyCode]" type="hidden"/>
				<input id="propertyValue" name="auditStretegyItem[propertyValue]" type="hidden"/>
				
                <input id="elsAccount" name="elsAccount" value="${elsAccount}" type="hidden"/>
                <input id="businessType" name="businessType" type="hidden"/>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_approval_flow" defaultValue="流程" /></span>
         <div class="common-box-line">
                <div class="edit-box-wrap">
					<button id="btnAddFlow" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="btnDeleteFlow" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
					<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				</div>
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-flow"></table>
                    </div>
                </main>
         </div>
</div>
</form>
<script type="text/javascript">
var businessType  = "<%=request.getParameter("businessType")%>";
var propertyCode  = "<%=request.getParameter("propertyCode")%>";
var propertyValue = "<%=request.getParameter("propertyValue")%>";
//标记过程行数是否变动过，如果变动过，设置审批人之前会触发保存按钮
var hasChanged    = 0 ;
var flowGrid          ;
var cols_flow = [
                   { title:'sortOrder',name:'sortOrder' ,width:150, hidden:true, align:'center',renderer:function(val){
               	    if (!val) {val = "";}
              	    return "<span class='showText'>" + val + "</span>" + "<input name='auditFlowList[][sortOrder]' type='text' class='noEdit' style='display:none' value='"+val+"'/>";
                   }},
                   { title:'<i18n:I18n key="i18n_audit_title_flowCode" defaultValue="流程代码" />', name:'flowCode' ,width:180, align:'center' ,renderer:function(val){
               	    if (!val) {val = "";}
              	    return "<input name='auditFlowList[][flowCode]' type='text' readonly='readonly' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_audit_title_flowname" defaultValue="流程名称" />', name:'flowName' ,width:180, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<input name='auditFlowList[][flowName]' type='text' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_audit_title_audittype" defaultValue="审批方" />', name:'auditType' ,width:150, align:'center',renderer:function(val){
                  	 return "<span class='showText' style='display:none'>" + val + "</span>" + "<select name='auditFlowList[][auditType]'><option value='0'><i18n:I18n key='i18n_audit_title_selfaudit' defaultValue='我方审批' /></option><option value='1'><i18n:I18n key='i18n_audit_title_toaudit' defaultValue='对方审批' /></option></select>";
                   }},
                   { title:'<i18n:I18n key="i18n_audit_title_auditperson" defaultValue="审批人配置" />', name:'flowCode' ,width:120, align:'center' ,renderer:function(val){
                	    return "<button class='button' onclick = 'editAuditUser("+val+");'><i18n:I18n key='i18n_audit_title_auditperson' defaultValue='审批人配置' /></>"; 
                   }}
               ];

var flow_blankRow     = {"sortOrder":"","flowCode":"","flowName":"","auditType":"0"};

$().ready(function(){
	init();
});
function init(){
	var height       = $(document).height()-230 ;
	if(!flowGrid){
		flowGrid = $('#table-flow').mmGrid({
	        cols        : cols_flow,
	        checkCol    : true,
	        height      : height,
	        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items       : []
	    });
	}
	initData()    ;
}
//获取数据
function initData(){
	$("#clearBtn").show();
	$("#propertyCode").val(propertyCode);
	$("#propertyValue").val(propertyValue);
	$("#stretegyCode").val(businessType + "_" +propertyValue);
	$("#stretegyName").val(businessType + "_" +propertyValue);
	$("#businessType").val(businessType);
	var frm = $("#form");
	$.ajax({
		url         : "<%=basePath%>rest/AuditService/getSelfAuditConfig",
		dataType    : "json",
		type        : "post",
		contentType : "application/json",
		data        : JSON.stringify(frm.serializeJSON()),
		success     : function(data) {
			flowGrid.load(data.auditFlowList);
			initSelect();
		},
		error       : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
/* 	if(stretegyCode != null && stretegyCode !="null" && stretegyCode !=""){

	}else{
		$("#stretegyCode").attr("readonly",false);
		$("#businessType").val(businessType);
		if(!isNaN(sortOrder))
			$("#sortOrder").val(parseInt(sortOrder)+1);
	} */
}

//初始化下拉框
function initSelect(){
	$("#table-flow").find("tr").each(function(){
		var selectObj=$(this).find("select");
		if(selectObj.length>0){
			var val=selectObj.prev(".showText").text();
			selectObj.val(val);	
		}
	});
}

//新增审批过程
$("#btnAddFlow").click(function(){
	//取出最大的flowCode
	var flowCode = 0;
	for(var i=0;i<flowGrid.rowsLength();i++){
		var temCode = parseInt(flowGrid.row(i).flowCode);
		if(flowCode <= temCode)
			flowCode = temCode;
	}
	//添加一行
	var newRow = $.extend({}, flow_blankRow);
	newRow.flowCode = flowCode + 1;
	flowGrid.addRow(newRow,flowGrid.rowsLength());
 	hasChanged = 1;
});

//保存
$("#entryBtn").click(function(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="xx" defaultValue="是否确认提交？" />',closeEvent:function(){
		var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"projectNumber":propertyValue};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/ProjectManageService/entryProject",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="xx" defaultValue="提交成功" />");
				parent.elsDeskTop.closeCurWin('selfCreateAuditConfig',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					if (data.status == "401") {
						alert("<i18n:I18n key="xx" defaultValue="项目已提交审批，不能重复提交" />",3);
					} else {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					};
				}
			}
		});
	}});
});

//保存
$("#saveBtn").click(function(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/AuditService/updateSelfAuditConfig",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			hasChanged = 0;
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

$("#clearBtn").click(function(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_audit_confirm_reaudit" defaultValue="是否确认将流程中单据退回重新上报？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#form");
		$.ajax({
			url :"<%=basePath%>rest/AuditService/clearAudit",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
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

//删除审批过程
$("#btnDeleteFlow").click(function(){
	var selectedIndexs = flowGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
        var flowCode = flowGrid.row(selectedIndexs[0]).flowCode;
        var stretegyCode = $("#stretegyCode").val();
		var data = {"elsAccount":elsAccount,"businessType":businessType,"stretegyCode":stretegyCode,"flowCode":flowCode};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/AuditService/deleteAuditFlowByCode",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				flowGrid.removeRow(selectedIndexs[0]);
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

function editAuditUser(flowCode){
	if(hasChanged == 1){
		var frm = $("#form");
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/AuditService/updateSelfAuditConfig",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				hasChanged = 0;
				goUserSetting(flowCode);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	}else{
		goUserSetting(flowCode);
	}
}

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('selfCreateAuditConfig',null);
});

function goUserSetting(flowCode){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    var stretegyCode = $("#stretegyCode").val();
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editAuditUser',
        'windowTitle':'<i18n:I18n key="i18n_audit_title_auditperson" defaultValue="审批人配置" />',
        'iframSrc':'<%=basePath%>audit/editAuditUser.jsp?stretegyCode='+stretegyCode+'&businessType='+businessType+'&flowCode='+flowCode,
        'windowWidth':800,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
}

function closeCallback() {
	if (parent.frames["iframeApp_projectManage"]) {
		parent.frames["iframeApp_projectManage"].refreshData();
	}
}
</script>
</body>
</html>