<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String businessElsAccount = request.getParameter("businessElsAccount");
String purchaseOrderNumber = request.getParameter("purchaseOrderNumber");
%>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<script type="text/javascript">
var hasRight = false;
</script>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="头列自定义" /></button>
				<button id="itemColumnDefineBtn" class="button-wrap add-bottom-btn"><i18n:I18n key="test" defaultValue="行列自定义" /></button>
				<base:audit elsSubAccount="${elsSubAccount }" businessElsAccount="${param.businessElsAccount }" businessId="${param.purchaseOrderNumber }" elsAccount="${elsAccount }" businessType="purchaseOrder">
				<button id="passBtn" class="todo button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
				<button id="noPassBtn" class="todo button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
				<script type="text/javascript"></script>
				</base:audit>
				<button id="cancelBtn" class="done button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
				<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
<%-- 			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
 				<button id="relevanceInfoBtn" class="button-wrap"><i18n:I18n key="" defaultValue="关联信息(审批辅助报表)" /></button>
			</div>
		</div>
	</div>
	<form id="auditForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="elsAccount" value="${elsAccount }">
		<input type="hidden" name="elsSubAccount" value="${elsSubAccount }">
		<input type="hidden" name="businessElsAccount" value="<%=businessElsAccount%>">
		<input type="hidden" name="purchaseOrderNumber" value="<%=purchaseOrderNumber%>">
		<input type="hidden" name="itemIds" id="itemIds"/> 
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_purchaseOrder_head" defaultValue="采购订单头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<main class="grid-container">
					<div class="grid-100">
						<table id="table-head"></table>
					</div>
					</main>
				</div>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_purchaseOrder_item" defaultValue="采购行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<ul>
						<li><a href="#sheet-item-one"><i18n:I18n key="i18n_title_purchaseOrder_item" defaultValue="采购行项目" /></a></li>
						<li><a href="#sheet-item-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
						<li id="deliveryTab"><a href="#sheet-item-three"><i18n:I18n key="i18n_label_deliverySchedule" defaultValue="交货计划" /></a></li>
					</ul>
					<div id="sheet-item-one">
						<div class="edit-box-wrap">
							<base:auditConfig elsAccount="${param.businessElsAccount }" businessType="purchaseOrder" type="item">
							<button id="itemPassBtn" style="display:none" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
							<button id="itemNoPassBtn" style="display:none" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
							</base:auditConfig>
						</div>
						<main class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
						</div>
						</main>
					</div>
					<div id="sheet-item-two">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line p-zero">
								<div class="pos-relative upload-wrap">
									<div class="pos-absolute file-list">
										<div class="file-list-head">
											<i18n:I18n key="i18n_common_lable_filelist" defaultValue="表单文件列表" />：<span></span>
										</div>
										<main class="grid-container">
										<div class="grid-100">
											<table id="table-file"></table>
										</div>
										</main>
									</div>
									<div class="file-scan">
										<div class="file-option-zoom">
											<div class="dis-in-b text-right">
												<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
												<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
											</div>
										</div>
										<div class="file-display" id="file-display">
											<a id="viewerPlaceHolder"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="sheet-item-three">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line">
								<div class="dis-in-b input-and-tip">
									<select id="itemSelector" onchange="filterDeliveryPlan()">
									</select>
								</div>
								<main class="grid-container">
								<div class="grid-100" id="deliveryGrid">
									<table id="table-delivery"></table>
								</div>
								</main>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="fixed-dialog">
			<div class="dialog-tip bg-common">
				<div class="dialog-close-btn"></div>
				<div class="tip-head">
					<img class="icon" src="../../icon/els.PNG" /> <span
						id="dialogTitle"><i18n:I18n key="i18n_title_fillOpinion" defaultValue="填写审批意见" /></span>
				</div>
				<div>
					<div class="box-wrap pos-relative bg-common">
						<div class="common-box-line">
							<textarea id="auditOpinion" name="auditOpinion" style="width:95%;" rows="5" maxlength="200"></textarea>
							<div class="mt-20">
								<button id="btnFileOK1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
								<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
								<button id="btnFileCancel1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript">
var auditType = "${param.auditType}";
var elsAccount = "<%=businessElsAccount%>";
var purchaseOrderNumber = "<%=purchaseOrderNumber%>";
var headGrid;
var itemGrid;
var fileGrid;
var formId;
var fileName;
var fileStatus;
var orderItemNumber;
var deliveryGrid;
if (purchaseOrderNumber == "null") {
	purchaseOrderNumber = "";
}

debugger;
var selector = '<base:subAccount elsAccount='${elsAccount }' type='select' name='purchaseOrderHeaderVO[fbk4]' id='fbk4' ></base:subAccount>';
var date = new Date().format("yyyy-MM-dd");
var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseOrderManage_mt"/>;   
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseOrderItemAudit_mt"/>;   
var cols_file = [{ title:'id',name:'formId' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'orderItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return '<i18n:I18n key="i18n_label_headfile" defaultValue="订单头文件" />';
	                	} else{
	                		return '<i18n:I18n key="i18n_label_itemfile" defaultValue="订单项文件" />';
	                	}
	                }},
                 { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="订单项编号" />',name:'orderItemNumber' ,width:80, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />',name:'filePath' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="待发状态" />', name:'fileStatus' ,width:59, align:'center',renderer:function(val){
                	 var showText;
                	 if (val == "0") {
                		 showText = '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
                	} else if (val == "1") {
                		showText = '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
                	} else if (val == "2") {
                		showText = '<i18n:I18n key="i18n_common_title_sendstatus_received" defaultValue="已接收" />';
                	}
                 	return showText;
                 }},
                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
                  	if (val != "" && val!=null&& val!=elsAccount) {
                 		return '<i18n:I18n key="i18n_label_otherSide" defaultValue="对方" />';
                 	} else {
                 		return '<i18n:I18n key="i18n_label_self" defaultValue="已方" />';
                 	} 
                 }}
             ];
var cols_delivery = [
				{title:'orderItemNumber', hidden:true,name:'orderItemNumber', width: 120, align: 'center',renderer:function(val){
				     return "<input class='delivery-orderItemNumber' name='purchaseDeliveryPlanList[][orderItemNumber]' type='text' style='display:none' value='"+val+"'/>";
				 }},
                 {title:'<i18n:I18n key="i18n_purchaseorder_deliverytime" defaultValue="计划交货时间" />', name:'deliveryTime', width: 120, align: 'center',renderer:function(val){
                 	if (!val) {val = "";}
                 	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
                 	return "<input name='purchaseDeliveryPlanList[][deliveryTime]' class=' Wdate' onfocus='WdatePicker()' type='text'  value='"+val+"'/>";
//                  	return "<span class='showText'>" + val + "</span>" + "<input name='purchaseDeliveryPlanList[][deliveryTime]' class='Wdate' onfocus='WdatePicker()' type='text' style='display:none' value='"+val+"'/>";
                 }},
                 { title:'<i18n:I18n key="i18n_purchaseorder_deliveryquantity" defaultValue="计划交货数量" />', name:'deliveryQuantity' ,width:200, align:'center',renderer:function(val){
                 	if (!val) {val = "0.00";}
                 	return "<input class='deliveryQuantity' name='purchaseDeliveryPlanList[][deliveryQuantity]' type='text' value='"+val+"'/>";
                 }},{title:'<i18n:I18n key="i18n_purchaseorder_purchasedeliverytimePlan" defaultValue="计划交货时间(供应商)" />', name:'purchaseDeliveryTimePlan', width: 120, align: 'center',renderer:function(val){
                  	if (!val) {val = "";}
                  	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
                    return "<span class='showText'>" + val + "</span>" + "<input name='purchaseDeliveryPlanList[][purchaseDeliveryTimePlan]' class='Wdate' onfocus='WdatePicker()' type='text' style='display:none' value='"+val+"'/>";
                }},
                { title:'<i18n:I18n key="i18n_purchaseorder_purchasedeliveryquantityPlan" defaultValue="计划交货数量(供应商)" />', name:'purchaseDeliveryQuantityPlan' ,width:200, align:'center',renderer:function(val){
                	if (!val) {val = "";}
                	return "<span class='showText'>" + val + "</span>" + "<input name='purchaseDeliveryPlanList[][purchaseDeliveryQuantityPlan]' type='text' class='noEdit' style='display:none' value='"+val+"'/>";
                }}];
$().ready(function(){
	debugger;
	init();
    $("#btnDownloadFile").click(function(){
    	var selectedRows = fileGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key="i18n_delivery_choosefileplease" defaultValue="请选择表单文件" />",2);
    		return;
    	}
    	window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + selectedRows[0].filePath;
    });
    $("#btnViewFile").click(function(){
    	var selectedRows = fileGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key="i18n_delivery_choosefileplease" defaultValue="请选择表单文件" />",2);
    		return;
    	}
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var filePath = selectedRows[0].filePath;
    	var data = {"elsAccount":elsAccount,"filePath":filePath};
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	}else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
    	    parent.elsDeskTop.showLoading();
    	    $.ajax({
			url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				var resStatus = data.statusCode;
				var filePath = data.message;
				if("200" == resStatus){
					var width=$("#file-display").width();
					var height=$("#file-display").height();
					$("#viewerPlaceHolder").css("width",width*0.94+"px");  
					$("#viewerPlaceHolder").css("height",height+"px");  
					$("#viewerPlaceHolder").css("padding-left",width*0.03+"px");  
					$("#viewerPlaceHolder").css("display","block" );  

					var fp = new FlexPaperViewer(
					            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
					            'viewerPlaceHolder', 
					            {config : {
					                SwfFile : filePath,
					                Scale : 1.5,
					                ZoomTransition : 'easeOut',
					                ZoomTime : 0.5,
					                ZoomInterval : 0.2,
					                FitPageOnLoad : false,
					                FitWidthOnLoad : false,
					                FullScreenAsMaxWindow : false,
					                ProgressiveLoading : false,
					                MinZoomSize : 0.2,
					                MaxZoomSize : 5,
					                SearchMatchAll : false,
					                InitViewMode : 'SinglePage',
					                ViewModeToolsVisible : true,
					                ZoomToolsVisible : true,
					                NavToolsVisible : true,
					                CursorToolsVisible : true,
					                SearchToolsVisible : true,
					                localeChain: 'zh_CN'
					            	}
					            });
				}else{
					alert(data.message,2);
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
    	}else {
    		alert('<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型!" />',2);
    	}
    });
    $('.dialog-close-btn').click(function(){
        $('.fixed-dialog').hide();
    });
    $('.tip-option-btn').click(function(){
        $('.dialog-close-btn').trigger('click');
    });
    
    $('#relevanceInfoBtn').click(function(){
    	//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
	        'windowsId':'auditRelevanceReport',
	        'windowTitle':'<i18n:I18n key="" defaultValue="关联信息" />',
	        'windowSubTitle': companyShortName,
	        'iframSrc':'<%=basePath%>ordermanage/purchaseorder/auditRelevanceReport.jsp?purchaseOrderNumber='+purchaseOrderNumber,
	        'showAdv': false,
	        'windowMinWidth': 960,
	        'windowStatus': 'maximized',
	        'windowMinHeight': 500,
	        'windowWidth':960,
	        'windowHeight':500,
	        'windowPositionTop':25,
	        'parentPanel':".currDesktop"
	    });
    });
});
function closeCallback() {
	if (parent.frames["iframeApp_auditList"]) {
		parent.frames["iframeApp_auditList"].query();
	}
}
function init(){
	$("#divOrderItem").hide();
	
	$( "#sheet-head").tabs();
	$( "#sheet-project").tabs();
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderByNumber/"+purchaseOrderNumber+"/"+elsAccount,
		type :"get",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			fillData(data);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
	if (auditType == "todo") {
		$(".todo").show();
		$(".done").hide();
	} else {
		$(".todo").hide();
		$(".done").show();
	}
	$("#passBtn").click(function(){
		$(".fixed-dialog").show();
    	$(".dialog-tip").height(275);
    	$("#auditOpinion").attr("readOnly",false);
    	$("#btnFileOK1").show();
    	$("#btnFileOK2").hide();
	});
	$("#noPassBtn").click(function(){
		$(".fixed-dialog").show();
    	$(".dialog-tip").height(275);
    	$("#auditOpinion").attr("readOnly",false);
    	$("#btnFileOK1").hide();
    	$("#btnFileOK2").show();
	});
	$("#btnFileOK1").click(function(){
		pass();
	});
	$("#btnFileOK2").click(function(){
		nopass();
	});
	$("#flowBtn").click(function(){
		flow();
	});
	$("#cancelBtn").click(function(){
		cancel();
	});
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback());
		} else {
			parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
		}
	});
	$("#columnDefineBtn").click(function(){
    	parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'subAccountColumnSetting',
            'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
            windowSubTitle: "",
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseOrderManage_mt" + "&window=iframeApp_PurchaseOrderUpdate",
            windowMinWidth: 480,
            windowMinHeight: 600,
            'windowWidth':480,
            'windowHeight':600,
            'parentPanel':".currDesktop"
        });
    });
    $("#itemColumnDefineBtn").click(function(){
    	parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'subAccountColumnSetting',
            'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
            windowSubTitle: "",
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseOrderItemAudit_mt" + "&window=iframeApp_PurchaseOrderUpdate",
            windowMinWidth: 480,
            windowMinHeight: 600,
            'windowWidth':480,
            'windowHeight':600,
            'parentPanel':".currDesktop"
        });
    });
    if (hasRight) {
    	$("#itemPassBtn").show();
    	$("#itemNoPassBtn").show();
    	$("#itemPassBtn").click(function(){
    		itemPass();
    	});
		$("#itemNoPassBtn").click(function(){
    		itemNoPass();
    	});
    }
}
var deliveryItemArr = [];
function getDeliveryItem() {
	$("#itemSelector").empty();
	var html = "";
	var trs = $("#table-item").find("tr");
	deliveryItemArr = []
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		if (data && data.orderItemNumber != "") {
			html += "<option value='"+data.orderItemNumber+"'>" + data.orderItemNumber + "_" + data.materialDesc + "</option>";
			deliveryItemArr.push(data.orderItemNumber);
		}
	}
	$("#itemSelector").append(html);
	filterDeliveryPlan();
}

function getOrderItem() {
	$("#orderItemSelector").empty();
	var html = "";
	var trs = $("#table-item").find("tr");
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		if (data.orderItemNumber != "") 
			html += "<option value='"+data.orderItemNumber+"'>" + data.orderItemNumber + "_" + data.materialDesc + "</option>";
	}
	$("#orderItemSelector").append(html);
}

function filterDeliveryPlan() {
	var orderItemNumber = $("#itemSelector").val();
	$(".delivery-orderItemNumber").each(function(){
		if (deliveryItemArr.indexOf($(this).val()) == -1) {
			$(this).parent().parent().parent().remove();
			return;
		}
		if ($(this).val()==orderItemNumber) {
			$(this).parent().parent().parent().show();
		} else {
			$(this).parent().parent().parent().hide();
		}
	});
	deliveryGrid.deselect("all");
}
function renderPurchaseType(val,item) {
	if(val == '0')
		return "<i18n:I18n key='i18n_common_select_procurementtype_standard' defaultValue='标准' />";
	else if(val == '1')
		return "<i18n:I18n key='i18n_common_select_procurementtype_restrict' defaultValue='限制' />";
	else if(val == '2')
		return "<i18n:I18n key='i18n_common_select_procurementtype_consignment' defaultValue='寄售' />";
	else if(val == '3')
		return "<i18n:I18n key='i18n_common_select_procurementtype_subcontract' defaultValue='分包' />";
	else if(val == '4')
		return "<i18n:I18n key='i18n_common_select_procurementtype_anunknowncommodity' defaultValue='未知的商品' />";
	else if(val == '5')
		return "<i18n:I18n key='i18n_common_select_procurementtype_thirdparty' defaultValue='第三方' />";
	else if(val == '6')
		return "<i18n:I18n key='i18n_common_select_procurementtype_text' defaultValue='文本' />";
	else if(val == '7')
		return "<i18n:I18n key='i18n_common_select_procurementtype_stocktransfer' defaultValue='库存转储' />";
	else if(val == '8')
		return "<i18n:I18n key='i18n_common_select_procurementtype_commoditytype' defaultValue='商品类目' />";
	else if(val == '9')
		return "<i18n:I18n key='i18n_common_select_procurementtype_service' defaultValue='服务' />";
	else
		return "";	
}
function fillData(data) {
	headGrid = $('#table-head').mmGrid({
        cols: cols_head,
        height: 100,
        items:[data.purchaseOrderHeaderVO]
    });
	headGrid.on('loadSuccess',function(e, d) {
		$("#fbk4").val(data.purchaseOrderHeaderVO.fbk4);
		setReadOnly();
	});
	fileGrid = $('#table-file').mmGrid({
        cols: cols_file,
        items: data.purchaseFormFileList,
    	height: 323,
    	checkCol: true
    });
	debugger;
	if (data.purchaseOrderItemList.length > 200) {
		loadPartItem(0,200,data.purchaseOrderItemList);
	} else {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        multiSelect: true,
	        checkCol:true,
	        items: data.purchaseOrderItemList
	    });
		
		itemGrid.on('loadSuccess',function(e, d) {
			fillDeliveryPlan(data.purchaseDeliveryPlanList);
			setReadOnly();
		});
	}
}
function loadPartItem(start,size,data) {
	var array = [];
	for (var i=0;i<size;i++) {
		array[i] = data[start+i];
	}
	start = start + size;
	if (itemGrid) {
		itemGrid.addRows(array);
	} else {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        multiSelect: true,
	        checkCol:true,
	        items: array
	    });
	}
	setTimeout(function(){
		setReadOnly();
	},100);
	if (start < data.length) {
		setTimeout(function(){
			if (data.length - start > 200) {
				loadPartItem(start,200,data);
			} else {
				loadPartItem(start,data.length-start,data);
			}
		},200);
	} else {
		fillDeliveryPlan(data.purchaseDeliveryPlanList);
	}
}
function fillDeliveryPlan(data){
	$('#deliveryGrid').html('<table id="table-delivery"></table><div id="pg" style="text-align: right;"></div>');

	deliveryGrid = $('#table-delivery').mmGrid({
        cols: cols_delivery,
        checkCol:true,
        items: data
    });
	deliveryGrid.on('loadSuccess',function(e, d) {
		if($("#itemSelector").find("option").length<=0){
			getDeliveryItem();
		}
		filterDeliveryPlan();
	});
}

function loadOrderItem(){
	var isOrderItem = $("#operTypeSelector").val();
	if("1" == isOrderItem){
		$("#divOrderItem").show();
		getOrderItem();
	}else{
		$("#divOrderItem").hide();
		$("#orderItemSelector").empty();
	}
}
function setReadOnly() {
// 	$("span input").not(":hidden").not(":checkbox").each(function(){
// 		$(this).parent().html($(this).val());
// 	});
// 	$("span select").each(function(){
// 		var val = $(this).find("option[value="+$(this).val()+"]").html();
// 		$(this).parent().html(val);
// 	});
}
function renderProductionStatus(val,item) {
	if (!val) {
		return "";
	}
	return "<a href=\"javascript:showProductionStatus('"+item.elsAccount+"','"+item.purchaseOrderNumber+"','"+item.orderItemNumber+"');\">"+val+"</a>";
}
function showProductionStatus(els,orderNumber,orderItemNumber) {
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editOrderSchedule',
        'windowTitle':'<i18n:I18n key="i18n_button_viewprogress" defaultValue="查看进度" />',
        windowSubTitle: orderNumber,
        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderSchedule.jsp?businessElsAccount=' + els + "&purchaseOrderNumber="+orderNumber+"&orderItemNumber="+orderItemNumber,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function pass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent:function(){
		debugger;
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		var param = frm.serializeJSON();
		//审批备注 @author jiangzhidong @date 20161011 begin
		var itemRows = itemGrid.rows();
		for(var i= 0,trs=itemGrid.find('tr');i<=itemRows.length-1; i++) {
			var value =document.getElementsByName("fbk40")[i].value;
			itemRows[i].fbk40 = value;
		}
		param['purchaseOrderItemList'] = itemRows;
		//审批备注 @author jiangzhidong @date 20161011 end
		$.ajax({
			url :"<%=basePath%>rest/PurchaseOrderService/sendPurchaseOrderPass",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "401") {
					alert("<i18n:I18n key="i18n_audit_afteritemsallpass" defaultValue="订单行项目未全部通过不能审批通过" />",3);
				} else if (data.status == "403") {
					alert("<i18n:I18n key="i18n_audit_noauthority" defaultValue="没有审批权限" />",3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}
function nopass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditrefuse" defaultValue="确认要审批拒绝吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		debugger;
		var frm = $("#auditForm");
		var param = frm.serializeJSON();
		//审批备注 @author jiangzhidong @date 20161011 begin
		var itemRows = itemGrid.rows();
		for(var i= 0,trs=itemGrid.find('tr');i<=itemRows.length-1; i++) {
			var value =document.getElementsByName("fbk40")[i].value;
			itemRows[i].fbk40 = value;
		}
		param['purchaseOrderItemList'] = itemRows;
		//审批备注 @author jiangzhidong @date 20161011 end
		$.ajax({
			url :"<%=basePath%>rest/PurchaseOrderService/sendPurchaseOrderNoPass",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
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
function cancel() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditcancel" defaultValue="确认要撤销审批吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/PurchaseOrderService/cancelAudit",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "401") {
					alert("<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />",3);
				} else if (data.status == "403") {
					alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}
function itemPass() {
	var allRows=itemGrid.rows();
	var rows = itemGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var itemIds = "";
	for (var i=0;i<rows.length;i++){
		itemIds += rows[i].orderItemNumber + ",";
	}
	itemIds = itemIds.substring(0,itemIds.length-1);
	$("#itemIds").val(itemIds);
	parent.elsDeskTop.showLoading();
	var frm = $("#auditForm");
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/itemPass",
		type :"post",
		contentType : "application/json",
		data:JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			changeStatus(allRows,rows,0);
			parent.elsDeskTop.hideLoading();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function itemNoPass() {
	var allRows=itemGrid.rows();
	var rows = itemGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var itemIds = "";
	for (var i=0;i<rows.length;i++){
		itemIds += rows[i].orderItemNumber + ",";
	}
	itemIds = itemIds.substring(0,itemIds.length-1);
	$("#itemIds").val(itemIds);
	parent.elsDeskTop.showLoading();
	var frm = $("#auditForm");
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/itemNoPass",
		type :"post",
		contentType : "application/json",
		data:JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			changeStatus(allRows,rows,3);
			parent.elsDeskTop.hideLoading();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function changeStatus(allRows,rows ,status){
	var json=new Object();
	for(var i=0;i<rows.length;i++){
		json[rows[i].orderItemNumber]="1";
	}
	for(var i=0;i<allRows.length;i++){
		var orderItemNumber=allRows[i].orderItemNumber;
		if(json[orderItemNumber]=="1"){
			allRows[i].auditStatus=status;
		}
	}
	itemGrid.load(allRows);
}

function renderIsFinish(val,item){
	if(val && val == "X")
		return "是";
	else
		return "否";
}

function renderItemIsFinish(val,item){
	if(val && val == "X")
		return "是";
	else
		return "否";
}

function flow() {
	var targetElsAccount = "${param.businessElsAccount }";
	var businessType = "purchaseOrder";
	var businessId = "${param.purchaseOrderNumber }";
	var title = '<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程     " />'+"  订单号："+businessId;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':title,
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
}

function renderIsUnlimited(val,item){
	if(val && val == "X")
		return "是";
	else
		return "否";
}

function renderIsFinish(val,item){
	if(val && val == "X")
		return "是";
	else
		return "否";
}

function renderItemIsFinish(val,item){
	if(val && val == "X")
		return "是";
	else
		return "否";
}

function renderOrderType(val,item){
	if(val && val == "71"){
		return "K3订单";
	}else if(val && val == "sample"){
		return "样品订单";
	}else{
		return "ELS订单";
	}
}

function renderAuditStatus(val,item){
	if("undefined"==typeof(val)){
		val = "";
	}
	if("0"==val){
		return "审批通过";
	} else if("1"==val){
		return "未审批";
	} else if("2"==val){
		return "审批中";
	} else {
		return "审批拒绝";
	}
}
</script>
</body>
</html>