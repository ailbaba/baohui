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
				<button id="clearBtn" style="display:none;" class="button-wrap"><i18n:I18n key="i18n_audit_button_reaudit" defaultValue="流程中单据重新上报" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_audit_lable_stretegies" defaultValue="策略" /></span>
    <div class="common-box-line">
    		    <div class="dis-in-b input-and-tip">
				     <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_businesstype" defaultValue="单据类型" />：</span>
				     <input id="businessType_show" type="text" readonly/>
				</div>
				<div class="dis-in-b input-and-tip">
				     <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_audit_title_stretegycode" defaultValue="策略编号" />：</span>
				     <input id="stretegyCode" name="stretegyCode" type="text"/>
				</div>
				<div class="dis-in-b input-and-tip">
				     <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_audit_title_stretegyname" defaultValue="策略名称" />：</span>
				     <input id="stretegyName" name="stretegyName" type="text"/>
				</div>
                <input id="elsAccount" name="elsAccount" value="${elsAccount}" type="hidden"/>
                <input id="businessType" name="businessType" type="hidden"/>
                <input id="sortOrder" name="sortOrder" type="hidden"/>
    </div>
</div>
<div class="box-wrap pos-relative bg-common">
 <div class="tab-wrap" id="sheet-project">
    <ul>
		<li><a href="#sheet-project-one"><i18n:I18n key="i18n_audit_lable_condition" defaultValue="条件" /></a></li>
	    <li><a href="#sheet-project-two"><i18n:I18n key="i18n_approval_flow" defaultValue="流程" /></a></li>
	</ul>
	<div id="sheet-project-one">
         <div class="common-box-line">
         		<div class="edit-box-wrap">
					<button id="btnAddStretegyItem" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="btnDeleteStretegyItem" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				</div>
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-stretegy"></table>
                    </div>
                </main>
         </div>
    </div>
    <div id="sheet-project-two">
         <div class="common-box-line">
                <div class="edit-box-wrap">
					<button id="btnAddFlow" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="btnDeleteFlow" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				</div>
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-flow"></table>
                    </div>
                </main>
         </div>
    </div>
 </div>
</div>
</form>
<script type="text/javascript">
var stretegyCode  = "<%=request.getParameter("stretegyCode")%>";
var businessType  = "<%=request.getParameter("businessType")%>";
debugger;
var sortOrder     = "<%=request.getParameter("sortOrder")%>";
//标记过程行数是否变动过，如果变动过，设置审批人之前会触发保存按钮
var hasChanged    = 0 ;
var stretegyGrid      ;
var flowGrid          ;
var propertyList      ;
var cols_stretegy = [
                      { title:'sortOrder',name:'sortOrder' ,width:150, hidden:true, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<span class='showText'>" + val + "</span>" + "<input name='auditStretegyItemList[][sortOrder]' type='text' class='noEdit' style='display:none' value='"+val+"'/>";
                      }},
                      { title:'<i18n:I18n key="i18n_audit_title_connector" defaultValue="连接符" />',name:'connector' ,width:100, align:'center',renderer:function(val){
                     	  	return "<span class='showText' style='display:none'>" + val + "</span>" + "<select name='auditStretegyItemList[][connector]'><option value='AND' selected>AND</option><option value='OR'>OR</option></select>";
                      }},
                      { title:'<i18n:I18n key="i18n_audit_title_leftbracket" defaultValue="左括号" />',name:'leftBracket' ,width:100, align:'center',renderer:function(val){
                     	  	return "<span class='showText' style='display:none'>" + val + "</span>" + "<select name='auditStretegyItemList[][leftBracket]'><option value=''></option><option value='(' selected>(</option></select>";
                      }},
                      { title:'<i18n:I18n key="i18n_audit_title_propertycode" defaultValue="属性编码" />',name:'propertyCode' ,width:150, align:'center',renderer:function(val){
                     	  	return "<span class='showText' style='display:none'>" + val + "</span>" + "<select name='auditStretegyItemList[][propertyCode]' class='propertyCode'></select>";
                      }},
                      { title:'<i18n:I18n key="i18n_audit_title_logic" defaultValue="逻辑符" />',name:'logic' ,width:100, align:'center',renderer:function(val){
                     	  	return "<span class='showText' style='display:none'>" + val + "</span>" + "<select name='auditStretegyItemList[][logic]' class='logic'><option value='>'>></option><option value='>='>>=</option><option value='=' selected>=</option><option value='<'><</option><option value='<='><=</option></select>";
                      }},
                      { title:'<i18n:I18n key="i18n_audit_title_propertyvalue" defaultValue="字段内容" />', name:'propertyValue' ,width:180, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<input id='propertyValue' name='auditStretegyItemList[][propertyValue]' type='text' value='"+val+"'/>"; 
                      }},
                      { title:'<i18n:I18n key="i18n_audit_title_rightbracket" defaultValue="右括号" />', name:'rightBracket' ,width:100, align:'center',renderer:function(val){
                     	 return "<span class='showText' style='display:none'>" + val + "</span>" + "<select name='auditStretegyItemList[][rightBracket]'><option value=''></option><option value=')' selected>)</option></select>";
                      }}
                  ];
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
	
var stretegy_blankRow = {"sortOrder":"","connector":"AND","leftBracket":"(","propertyCode":"","logic":"=","propertyValue":"","rightBracket":")"};

var flow_blankRow     = {"sortOrder":"","flowCode":"","flowName":"","auditType":"0"};

loadProperties() ;
$().ready(function(){
	init();
});
function init(){
	$("#sheet-project").tabs()          ;
	var height       = $(document).height()-295 ;
	if(!stretegyGrid){
		stretegyGrid = $('#table-stretegy').mmGrid({
	        cols        : cols_stretegy ,
	        checkCol    : true,
	        height      : height,
	        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items       : []
	    });
	}
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
	getStretegy()    ;
}
//获取数据
function getStretegy(){
	if(stretegyCode != null && stretegyCode !="null" && stretegyCode !=""){
		$("#clearBtn").show();
		var data = {"elsAccount":elsAccount,"businessType":businessType,"stretegyCode":stretegyCode};
		$.ajax({
			url         : "<%=basePath%>rest/AuditService/getAuditStretegyByCode",
			dataType    : "json",
			type        : "post",
			contentType : "application/json",
			data        : JSON.stringify(data),
			success     : function(data) {
				fillData(data);
			},
			error       : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}else{
		$("#stretegyCode").attr("readonly",false);
		$("#businessType").val(businessType);
		if(!isNaN(sortOrder))
			$("#sortOrder").val(parseInt(sortOrder)+1);
		//显示单据类型
        showBusinessType(businessType);
	}
}

//填充策略明细
function fillData(data) {
		$("#stretegyCode").val(data.stretegyCode);
		$("#stretegyName").val(data.stretegyName);
		$("#businessType").val(data.businessType);
		$("#stretegyCode").attr("readonly",true);
		stretegyGrid.load(data.auditStretegyItemList);
		flowGrid.load(data.auditFlowList);
		var stretegyTable = $("#table-stretegy");
	    var flowTable = $("#table-flow");
		initSelect(stretegyTable,1);
		initSelect(flowTable,1);
		//显示单据类型
        showBusinessType(data.businessType);
}

function showBusinessType(businessType){
	if (businessType == "purchaseOrder") {
		$("#businessType_show").val("<i18n:I18n key='i18n_title_purchaseorder' defaultValue='采购订单' />");
	} else if (businessType == "delivery") {
		$("#businessType_show").val("<i18n:I18n key='i18n_audit_lable_delivery' defaultValue='发货单' />");
	} else if (businessType == "saleEnquiry") {
		$("#businessType_show").val("<i18n:I18n key='i18n_audit_lable_saleenquiry' defaultValue='销售报价单' />");
	} else if (businessType == "bargainEnquiry") {
		$("#businessType_show").val("<i18n:I18n key='i18n_audit_lable_bargainenquiry' defaultValue='议价报价单' />");
	} else if (businessType == "standardSupplier") {
		$("#businessType_show").val("<i18n:I18n key='i18n_common_access_to_suppliers' defaultValue='供应商准入评估' />");
	} else if (businessType == "c2fo") {
		$("#businessType_show").val("<i18n:I18n key='i18n_businesstype_c2fo' defaultValue='企利通' />");
	} else if (businessType == "project") {
		$("#businessType_show").val("<i18n:I18n key='xx' defaultValue='立项' />");
	} else if (businessType == "designDoc") {
		$("#businessType_show").val("<i18n:I18n key='xx' defaultValue='设计文档' />");
	} else if (businessType == "contract") {
		$("#businessType_show").val("<i18n:I18n key='xx' defaultValue='合同管理' />");
	} else if (businessType == "bidding") {
		$("#businessType_show").val("<i18n:I18n key='xx' defaultValue='定标前' />");
	} else if (businessType == "preBidding") {
		$("#businessType_show").val("<i18n:I18n key='xx' defaultValue='发布招标前' />");
	} else{
		$("#businessType_show").val("");
	}
}

//初始化下拉框
function initSelect(obj,flag){
	obj.find("td").each(function(){
		var val=$(this).find(".showText").text();
		var selectObj=$(this).find("select");
		if(selectObj.length>0){
			var idName=selectObj.attr("class");
			if(idName=="propertyCode"){
				initPropertyCodeSelector(selectObj);
			}else if(idName=="logic"){
				val=val.replace("&gt;",">");
				val=val.replace("&lt;","<");
			}
			if(flag == 1)
				selectObj.val(val);
		}
	});
}

//加载策略属性
function loadProperties(){
	$.ajax({
		url :"<%=basePath%>rest/AuditService/getAuditProperty/"+businessType,
		type :"get",
		dataType : "json",
		contentType : "application/json",
		success : function(data) {
			propertyList = data;
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function initPropertyCodeSelector(obj){
	if (!propertyList) {
		$.ajax({
			url :"<%=basePath%>rest/AuditService/getAuditProperty/"+businessType,
			type :"get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				propertyList = data;
				obj.empty();
				var html = "";
				var propertyName="";
				for (var i=0;i<propertyList.length;i++){
					var code = propertyList[i].propertyCode;
					var name = propertyList[i].propertyName;
				    html += "<option value='" + code + "'>" + name + "</option>";
				}
				obj.html(html);
			},
			error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
		return;
	}
	obj.empty();
	var html = "";
	var propertyName="";
	for (var i=0;i<propertyList.length;i++){
		var code = propertyList[i].propertyCode;
		var name = propertyList[i].propertyName;
	    html += "<option value='" + code + "'>" + name + "</option>";
	}
	obj.html(html);
}
//新增策略明细
$("#btnAddStretegyItem").click(function(){
	stretegyGrid.addRow(stretegy_blankRow,stretegyGrid.rowsLength());
	var lastLine = $('#table-stretegy tr:last');
 	initSelect(lastLine,0);
});

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
	//初始化最后一行的select标签
	var lastLine = $('#table-flow tr:last');
 	initSelect(lastLine,0);
 	hasChanged = 1;
});

//保存
$("#saveBtn").click(function(){
	var stretegyNewCode = $("#stretegyCode").val();
	if(stretegyNewCode == ""){
		alert("<i18n:I18n key="i18n_alert_fillstretegyCode" defaultValue="请填写策略编号" />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var url;
	if(stretegyCode == null || stretegyCode == "null" || stretegyCode == ""){
		url = "<%=basePath%>rest/AuditService/addAuditStretegy";
	} else {
		url = "<%=basePath%>rest/AuditService/updateAuditStretegy";
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
			if(data == 0){
				$("#stretegyCode").focus();
				alert("<i18n:I18n key="i18n_alert_stretegyCodeExits" defaultValue="操作成功" />",2);
			}else{
				stretegyCode = stretegyNewCode;
				$("#stretegyCode").attr("readonly",true);
				hasChanged = 0;
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

//删除策略明细
$("#btnDeleteStretegyItem").click(function(){
	var selectedIndexs = stretegyGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	stretegyGrid.removeRow(selectedIndexs[0]);
});

//删除审批过程
$("#btnDeleteFlow").click(function(){
	var selectedIndexs = flowGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	if(stretegyCode == null || stretegyCode == "null" || stretegyCode == ""){
		flowGrid.removeRow(selectedIndexs[0]);
	}else{
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
            var flowCode = flowGrid.row(selectedIndexs[0]).flowCode;
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
	}
});

function editAuditUser(flowCode){
	if(stretegyCode == null || stretegyCode == "null" || stretegyCode == "" || hasChanged == 1){
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
	        'windowsId':'editAuditUser',
	        'windowTitle':'<i18n:I18n key="i18n_audit_title_auditperson" defaultValue="审批人配置" />',
	        'iframSrc':'<%=basePath%>audit/editAuditUser.jsp?stretegyCode='+stretegyCode+'&businessType='+businessType+'&flowCode='+flowCode,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
}

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('editStretegy',closeCallback);
});

function closeCallback() {
	if (parent.frames["iframeApp_auditConfig"]) {
		parent.frames["iframeApp_auditConfig"].query();
	}
}
</script>
</body>
</html>