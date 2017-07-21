<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String toElsAccount = request.getParameter("toElsAccount");
String purchaseOrderNumber = request.getParameter("purchaseOrderNumber");
String type=request.getParameter("type");
%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
<%-- 				<button id="saveBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button> --%>
				<base:auditConfig elsAccount="${elsAccount }" businessType="purchaseOrder">
				<button id="entryBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批" /></button>
				<button id="cancelEntryBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
				<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
				</base:auditConfig>
<%-- 				<button id="btnSend" class="edit-btn button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button> --%>
<%-- 				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
			</div>
		</div>
	</div>
<%-- 	<a href="<%=basePath%>rest/PurchaseOrderService/printERPPurchaseOrde/4500096448/105140">sd</a> --%>
<%-- 	<object id="object" style="width:100%; height:100% "  data="<%=basePath%>rest/PurchaseOrderService/printERPPurchaseOrde/4500096448/105140" type="application/pdf"></object> --%>
	<form id="purchaseOrderForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type='hidden' name='purchaseOrderHeaderVO[fbk4]' id="fbk4Param" />
		<input type='hidden' name='purchaseOrderHeaderVO[fbk5]' id="fbk5Param" />
		<input type='hidden' name='purchaseOrderHeaderVO[stretegyCode]' id="stretegyCode" />
		<input type='hidden' name='purchaseOrderHeaderVO[toElsAccount]' id="toElsAccount" value="<%=request.getParameter("toElsAccount")%>" />
		<input type='hidden' name='purchaseOrderHeaderVO[toElsAccountShortName]' id="toElsAccountShortName" value="<%=request.getParameter("toCompanyName")%>" />
		<input type="hidden" name="companyShortName"
			value="<%=session.getAttribute("companyShortName")%>" /> <input
			type="hidden" name="purchaseOrderHeaderVO[elsAccount]"
			value="${elsAccount }" /> <input type="hidden"
			name="purchaseOrderHeaderVO[elsSubAccount]" value="${elsSubAccount }" />
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
					<div id="sheet-item-one" style="padding: 2px;">
						<div class="edit-box-wrap">
							<button id="itemColumnDefineBtn" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
 							<button id="btnBom" class="edit-btn button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_button_setbom" defaultValue="设置BOM" /></button> 
							<button id="btnAdd" class="edit-btn button-wrap add-bottom-btn elsEdit"><i18n:I18n key="i18n_common_button_addlinebottom" defaultValue="添加至底部" /></button>
							<button id="btnAddArr" class="edit-btn button-wrap add-top-btn elsEdit"><i18n:I18n key="i18n_common_button_addlinetop" defaultValue="添加至上一行" /></button>
<%-- 						<button id="btnRemove" class="edit-btn button-wrap del-btn elsEdit"><i18n:I18n key="i18n_common_button_removeline" defaultValue="删除一行" /></button> --%>
							<button id="btnUpload" class="edit-btn button-wrap btnUpload elsEdit"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="excel上载订单" /></button>
							<button id="btnDownloadTemplate" class="edit-btn button-wrap btnUpload elsEdit"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="下载导入模板" /></button>
<!-- 							<button id="deleteRow" class="button-wrap add-bottom-btn">删除行</button> -->
<!-- 							<button id="cancelDeleteRow" class="button-wrap add-bottom-btn">取消删除行</button> -->
<!-- 							<input type="checkbox" id="showDelete"/>显示删除行 -->
						</div>
						<main class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
						</div>
						</main>
					</div>
					<div id="sheet-item-two" style="padding: 2px;">
						<div class="common-box-line p-zero">
							<div class="pos-relative upload-wrap">
								<div class="pos-absolute file-list">
									<div class="file-list-head">
										<i18n:I18n key="i18n_common_lable_filelist" defaultValue="表单文件列表" />：<span>
										<select id="formFileTypeSelector" onchange="loadFormFileByType()">
										    <option value="0"><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
							                <option value="1"><i18n:I18n key="i18n_common_select_head" defaultValue="按订单头" /></option>
							                <option value="2"><i18n:I18n key="i18n_common_select_item" defaultValue="按订单行" /></option>
						                </select></span>
									</div>
									<main class="grid-container">
									<div class="grid-100">
										<table id="table-file"></table>
									</div>
									</main>
								</div>
								<div class="file-scan">
									<div class="file-option-zoom">
										<div class="dis-in-b text-left">
											<button id="btnAddFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button>
											<button id="btnModifyFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改文件" /></button>
											<button id="btnDeleteFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button>
										</div>
										<div class="dis-in-b text-right">
											<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
											<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
											<!-- 
											<button class="button-wrap" id="sendForm">发送表单</button>
											 -->
										</div>
									</div>
									<div class="file-display" id="file-display">
										<a id="viewerPlaceHolder"></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="sheet-item-three" style="padding: 2px;">
						<div class="dis-in-b input-and-tip">
							<select id="itemSelector" onchange="filterDeliveryPlan()">
							</select>
							<button class="button-wrap edit-btn" id="insertItem"><i18n:I18n key="i18n_common_button_addlinebottom" defaultValue="插入" /></button>
							<button class="button-wrap edit-btn" id="deleteItem"><i18n:I18n key="i18n_common_button_removeline" defaultValue="删除" /></button>
							<button id="btnPlanUpload" class="edit-btn button-wrap btnUpload"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="excel上载交货计划" /></button>
							<button id="btnPlanTempDownload" class="edit-btn button-wrap btnUpload"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="下载导入模板" /></button>
							<font id="noticeText" class="edit-btn" color="red"><i18n:I18n key="i18n_common_notice_savebeforechoose" defaultValue="如果选不到行项目请先保存订单" /></font>
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
	</form>

	<div id="dialog1" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件分类" />：</span> 
							<select id="operTypeSelector" onchange="loadOrderItem()" >
								<option value="0"><i18n:I18n key="i18n_common_select_head" defaultValue="按订单头" /></option>
								<option value="1"><i18n:I18n key="i18n_common_select_item" defaultValue="按订单行" /></option>
							</select>
						</div>
						<div id="divOrderItem" class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="请选择行项目" />：</span> 
							<select id="orderItemSelector"
								name="orderItemNumber">
							</select>
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span>
							<input id="fileName" name="fileName" type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /></div></span>
							<input id="filePath" name="filePath" type="hidden" />
						</div>
						<input id="fileType" name="fileType" type="hidden" />
					</div>
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="dialog2" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_selectStrategy" defaultValue="新选择审批策略" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_audit_lable_stretegy" defaultValue="审批策略" />：</span> 
							<select id="stretegySelctor">
							</select>
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
var winId = "<%= request.getParameter("winId") %>";
var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
var elsAccount = currentElsAccount;
var toElsAccount = "<%=toElsAccount%>";
var purchaseOrderNumber = "<%=purchaseOrderNumber%>";
var type="<%=type%>";
var headGrid;
var itemGrid;
var fileGrid;
var formId;
var fileName;
var fileStatus;
var orderItemNumber;
var deliveryGrid;
var flowCode = "";
var auditStatus = "";
if (purchaseOrderNumber == "null") {
	purchaseOrderNumber = "";
}
var selector = '<base:subAccount role='purchase' elsAccount='${elsAccount }' type='multiple' name='fbk4' id='fbk4' ></base:subAccount>';
var date = new Date().format("yyyy-MM-dd");
var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editPurchaseOrder_mt"/>;   
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editPurchaseOrderItem_mt"/>;   
//增加删除标识
cols_item.push({
	"title":"删除标识",
	"name":"deleteFlag",
	"align":"center",
	renderer:function(val){
		var txt = "";
		if(!val) val="";
		if (val=="C") {
			txt = "<span>删除待确认</span>";
		} else if (val=="X") {
			txt = "<span>已删除</span>";
		}
		return txt + "<input name='purchaseOrderItemList[][deleteFlag]' type='hidden' class='deleteFlag' value='"+val+"'/>";
	}
});

var cols_file = [
                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
                    	if (val != "" && val!=null&& val!=elsAccount) {
                    		return "<i18n:I18n key="i18n_common_sale" defaultValue="销售方" />";
                   	} else {
                   		return "<i18n:I18n key="i18n_common_purchase" defaultValue="采购方" />";
                   	} 
                 }},
                 { title:'id',name:'formId' ,width:200, align:'center',hidden:true},
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
                 }}
             ];
var cols_delivery = [
				{title:'行项目号',name:'orderItemNumber', width: 120, align: 'center',renderer:function(val){
				     return val + "<input class='delivery-orderItemNumber' name='purchaseDeliveryPlanList[][orderItemNumber]' type='text' style='display:none' value='"+val+"'/>";
				}},
				{title:'计划行号',name:'orderDeliveryItem', width: 120, align: 'center',renderer:function(val){
					if (!val) {val = "1";}
					     return val + "<input class='delivery-orderDeliveryItem' name='purchaseDeliveryPlanList[][orderDeliveryItem]' type='text' style='display:none' value='"+val+"'/>";
				}},
				{title:'gridValue', hidden:true,name:'gridValue', width: 120, align: 'center',renderer:function(val){
					if (!val) {val = "1";}
				     return "<input class='delivery-gridValue' name='purchaseDeliveryPlanList[][gridValue]' type='text' style='display:none' value='"+val+"'/>";
			    }},
                 {title:'<i18n:I18n key="i18n_purchaseorder_deliverytime" defaultValue="计划交货时间" />', name:'deliveryTime', width: 120, align: 'center',renderer:function(val){
                 	if (!val) {val = "";}
                 	val = dateFormat(val);
                 	return "<input name='purchaseDeliveryPlanList[][deliveryTime]' class=' Wdate' onfocus='WdatePicker()' type='text'  value='"+val+"'/>";
//                  	return "<span class='showText'>" + val + "</span>" + "<input name='purchaseDeliveryPlanList[][deliveryTime]' class='Wdate' onfocus='WdatePicker()' type='text' style='display:none' value='"+val+"'/>";
                 }},
                 { title:'<i18n:I18n key="i18n_purchaseorder_deliveryquantity" defaultValue="计划交货数量" />', name:'deliveryQuantity' ,width:200, align:'center',renderer:function(val){
                 	if (!val) {val = "0.00";}
                 	return "<input class='deliveryQuantity' name='purchaseDeliveryPlanList[][deliveryQuantity]' type='text' value='"+val+"'/>";
                 }},
                 {title:'<i18n:I18n key="i18n_purchaseorder_purchasedeliverytimePlan" defaultValue="计划交货时间(供应商)" />', name:'purchaseDeliveryTimePlan', width: 120, align: 'center',renderer:function(val){
                  	if (!val) {val = "";}
                  	val = dateFormat(val);
                    return "<span class='showText'>" + val + "</span>" + "<input name='purchaseDeliveryPlanList[][purchaseDeliveryTimePlan]' class='Wdate' onfocus='WdatePicker()' type='text' style='display:none' value='"+val+"'/>";
                }},
                { title:'<i18n:I18n key="i18n_purchaseorder_purchasedeliveryquantityPlan" defaultValue="计划交货数量(供应商)" />', name:'purchaseDeliveryQuantityPlan' ,width:200, align:'center',renderer:function(val){
                	if (!val) {val = "0.00";}
                	return "<span class='showText'>" + val + "</span>" + "<input name='purchaseDeliveryPlanList[][purchaseDeliveryQuantityPlan]' type='text' class='noEdit' style='display:none' value='"+val+"'/>";
                }}];
var blankRow = {"quantity":"0.00","price":"0.00","WESBS":"0.00","WESBZ":"0.00","totalAmount":"0.00","erpDeliveredQuantity":"0.00","deliveredQuantity":"0.00",
		        "onWayQuantity":"0.00","receivedQuantity":"0.00","returnQuantity":"0.00","logtime":date,"deliveryDate":date,"fbk1":"0.000",
		        "lackToleranceQuantity":"0.000","unitMeasure":"1","lackTolerance":"0.00","overTolerance":"0.00","overToleranceQuantity":"0.000"};
var blankDeliveryRow = {"orderItemNumber":"","orderDeliveryItem":"","gridValue":"","deliveryTime":date,"deliveryQuantity":"0.00","purchaseDeliveryTimePlan":date,"purchaseDeliveryQuantityPlan":"0.00"};
var fileUploader;
var planUploader;
var deliveryStatus = "0";
var orderSendStatus = "0";
var orderStatus = "0";
var orderType = "ELS";
$().ready(function(){
	hideSomeCols();
	init();
// 	initDeliveryPlan();
    $('#btnAddFile').click(function() {
    	if (!purchaseOrderNumber || purchaseOrderNumber == "") {
    		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_pleasesavetheorderfirst" defaultValue="请先保存订单！是否确认保存？" />',closeEvent:function(){
    			$("#saveBtn").trigger("click");
    		}});
    	}else{
	        $('#dialog1').show();
	        initAddFileDialog();
	        initFileUploader(fileUploader);
    	}
    });
    
    $('#btnModifyFile').click(function() {
    	var selectedIndexs = fileGrid.selectedRowsIndex();
    	if (selectedIndexs.length == 0) {
    		alert("<i18n:I18n key="i18n_delivery_choosefileplease" defaultValue="请选择表单文件" />",2);
    		return;
    	}
    	var selectedRow = fileGrid.row(selectedIndexs[0]);
		if(selectedRow.createBy != elsAccount){
			alert("<i18n:I18n key="i18n_delivery_cantmodifytofile" defaultValue="对方文件不能修改" />",2);
			return;
		}
		var fbk1 = selectedRow.fbk1;
		if(fbk1){
			alert("该文件的修改请前往文档分配中心，文件号及版本号为："+fbk1,3);
			return;
		}
    	formId = selectedRow.formId;
    	fileName = selectedRow.fileName;
    	fileStatus = selectedRow.fileStatus;
    	orderItemNumber = selectedRow.orderItemNumber;
        $('#dialog1').show();
        initModifyFileDialog();
        initFileUploader(fileUploader);
    });
    $("#btnDeleteFile").click(function(){
    	var selectedIndexs = fileGrid.selectedRowsIndex();
    	if (selectedIndexs.length == 0) {
    		alert("<i18n:I18n key="i18n_delivery_choosefileplease" defaultValue="请选择表单文件" />",2);
    		return;
    	}
    	var selectedRow = fileGrid.row(selectedIndexs[0]);
		if(selectedRow.createBy != elsAccount){
			alert("<i18n:I18n key="i18n_delivery_cantdeletetofile" defaultValue="对方文件不能删除" />",2);
			return;
		}
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
	    	var data = {"formId":selectedRow.formId,"elsAccount":elsAccount};
	    	parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url : "<%=basePath%>rest/PurchaseFormFileService/order/deletePurchaseFormFile",
	    		type : "post",
	    		contentType : "application/json",
	    		data : JSON.stringify(data),
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			//fileGrid.removeRow(selectedIndexs[0]);
	    			loadFormFileByType();
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
		    			alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
	    			}
	    		}
	    	});
    	}});
    });
    $("#btnDownloadFile").click(function(){
    	var selectedRows = fileGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key="i18n_delivery_choosefileplease" defaultValue="请选择表单文件" />",2);
    		return;
    	}
    	var fbk1 = selectedRows[0].fbk1;
    	if(!fbk1){
    		window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + selectedRows[0].filePath;
    	}else{
    		var fileType = selectedRows[0].fileType;
    		var fileName = selectedRows[0].fileName+"."+fileType;
    		window.location.href = "<%=basePath%>" + "servlet/download4OSSServlet?filePath=" + selectedRows[0].filePath+'&fileName='+fileName;
    	}
    	
    });
    
    $("#btnDownloadTemplate").click(function(){
    	window.location.href = "${pageContext.request.contextPath}/template/ELS_采购订单模板.xls";
    });
    $("#btnPlanTempDownload").click(function(){
    	window.location.href = "${pageContext.request.contextPath}/template/ELS_采购方交货计划.xls";
    });
    $("#btnViewFile").click(function(){
    	var selectedRows = fileGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key="i18n_delivery_choosefileplease" defaultValue="请选择表单文件" />",2);
    		return;
    	}
    	var fbk1 = selectedRows[0].fbk1;
    	if(fbk1){
    		alert("该文件不支持在线预览，请下载查看",2);
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
					alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
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
});
function initAddFileDialog(){
	$(".dialog-tip").height(240);
	$("#fileName").attr("readonly",false);
    $("#filePath").val(null);
    $("#fileType").val(null);
    $("#fileName").val(null);
    $("#operTypeSelector").val("0");
    $("#orderItemSelector").empty();
    $("#divOrderItem").hide();
    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" />');
    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="上传文件" />');
    $("#btnFileOK").unbind("click");
    loadOrderItem();
    $("#btnFileOK").click(function(){addFormFile();});
}
function initModifyFileDialog(){
	$("#fileName").attr("readonly",true);
    $("#filePath").val();
    $("#fileType").val();
    if(orderItemNumber){
    	$(".dialog-tip").height(270);
    	$("#operTypeSelector").val("1");
    	loadOrderItem();
    	$("#orderItemSelector").val(orderItemNumber);
    }else{
    	$(".dialog-tip").height(240);
    	$("#operTypeSelector").val("0");
    	$("#orderItemSelector").empty();
        $("#divOrderItem").hide();
    }
	$("#fileName").val(fileName);
    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改表单文件" />');
    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_rechooseformfile" defaultValue="重传文件" />');
    $("#btnFileOK").unbind("click");
    $("#btnFileOK").click(function(){modifyFormFile();});
}
function addFormFile(){

	var fileName = $("#fileName").val();
	if (!fileName) {
		alert("<i18n:I18n key="i18n_delivery_enterfilename" defaultValue="请填写文件名称" />",2);
		return;
	}
	var filePath = $("#filePath").val();
	if(!filePath){
		alert("<i18n:I18n key="i18n_delivery_uploadfileplease" defaultValue="请上传文件" />",2);
		return;
	}
	var orderItemNumber = $("#orderItemSelector").val();
	var fileType = $("#fileType").val();
	var logtime = new Date();
	var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseOrderNumber":purchaseOrderNumber,"orderItemNumber":orderItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/PurchaseFormFileService/order/addPurchaseFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data != null){
				//fileGrid.addRow(data,fileGrid.rowsLength());
				loadFormFileByType();
				$('.fixed-dialog').hide();
			}else{
				alert("<i18n:I18n key="i18n_delivery_filenameexist" defaultValue="该文件名已存在" />",2);
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
function modifyFormFile(){
	var fileName = $("#fileName").val();
	if (!fileName) {
		alert("<i18n:I18n key="i18n_delivery_enterfilename" defaultValue="请填写文件名称" />",2);
		return;
	}
	var orderItemNumber = $("#orderItemSelector").val();
	var fileType = $("#fileType").val();
	var filePath = $("#filePath").val();
	var logtime = new Date();
	var data = {"elsAccount":elsAccount,"formId":formId,"fileStatus":fileStatus,"purchaseOrderNumber":purchaseOrderNumber,"orderItemNumber":orderItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/PurchaseFormFileService/order/updatePurchaseFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			//var index = fileGrid.selectedRowsIndex()[0];
			//fileGrid.updateRow(data,index);
			loadFormFileByType();
			$('.fixed-dialog').hide();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
			
		}
	});
}


function initFileUploader(fileUploader){
    //新增表单文件
    if (!fileUploader) {
  	fileUploader = WebUploader.create({
  	    // swf文件路径
  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
  	  	duplicate :true,
  	    auto: true,
  	    // 文件接收服务端。
  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
  	    // 选择文件的按钮。可选。
  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
  	    pick: '#btnFileUpload',
  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
  	    resize: false
  	});
  	fileUploader.on( 'uploadAccept', function( obj, response ) {
  	  	if(0 == response.error){
  	   	   var filePath = response.url;
  	  	   var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
  	  	   var noEdit = $("#fileName").attr("readonly");
  	  	   if(!noEdit){
  	  		$("#fileName").val(obj.file.name);
  	  	   }
  	       $("#filePath").val(filePath);
  	       $("#fileType").val(fileType);
  	  	}else{
  	  		alert(response.message,2);
  	  	}
  	});
    }
}
function closeCallback() {
	if (parent.frames["iframeApp_OrderManage_"+toElsAccount]) {
		parent.frames["iframeApp_OrderManage_"+toElsAccount].query();
	}
	if (parent.frames["iframeApp_purchaseOrderBatchManage"]) {
		parent.frames["iframeApp_purchaseOrderBatchManage"].query();
	}
}
var isChild = false;
//如果是集团账号，而销售方是集团子账号，则采购方有权指定销售负责人
function initSeller() {
	//判断是否集团账号与子账号
	$.ajax({
			url :"<%=basePath%>rest/AccountService/getAllChildElsAccount/"+elsAccount,
			type :"get",
			async:false,
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data && data.length > 0) {
					for (var i in data) {
						if (data[i] == toElsAccount) {
							isChild = true;
						}
					}
				}
			}
	});
	if (isChild) {
		var fbk5Selector = '<base:subAccount role='sale' elsAccount='${param.toElsAccount }' type='multiple' name='fbk5' id='fbk5' ></base:subAccount>';
		var fbk5Item = {title:"<i18n:I18n key="i18n_common_title_responserofsupplier" defaultValue="销售方负责人" />",name:"fbk5",align:"center",width:196,renderer:function(val){return fbk5Selector;}};
		cols_head.splice(4,0,fbk5Item);
	}
}
function init(){
	initSeller();
	$("#divOrderItem").hide();
	
	$( "#sheet-head").tabs();
	$( "#sheet-project").tabs();
	if (purchaseOrderNumber == "") {
		changeButtonStatus();
		var fbk4 = $(selector).find("option").eq(0).val();
		var initItems = [{"purchaseOrderNumber":"","toElsAccount":toElsAccount,"orderDate":date,"fbk4":fbk4,"currency":"CNY","remark":"","fbk1":"","fbk2":"","fbk3":"","logtime":date,"orderStatus":"0","orderSendStatus":"","deliveryStatus":"","totalAmount":""}];
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height: 100,
	        items:initItems
	    });
		headGrid.on('loadSuccess',function(e, d) {
// 			$("#fbk4").hide();
			$("#fbk4").css("display","");
			if (initItems.fbk4) {
				$("#fbk4").find("option").each(function(){
					if (initItems.fbk4.indexOf($(this).val()) != -1) {
						$(this).attr("selected","selected");
					}
				});
			}else{
				$("#fbk4").find("option").each(function(){
					if (elsSubAccount.indexOf($(this).val().split("_")[0]) != -1) {
						$(this).attr("selected","selected");
					}
				});
			}
			$("#fbk4").SumoSelect({optAfter:'#sheet-head ',optCancel:'#sheet-head .mmg-bodyWrapper'});
			if ($("#fbk5").length > 0) {
				$("#fbk5").css("display","");
				$("#fbk5").SumoSelect({optAfter:'#sheet-head ',optCancel:'#sheet-head .mmg-bodyWrapper'});
			}
			
			$(".SlectBox").each(function(){
				$(this).css("width",$(this).parent().parent().parent().width()-18);
			});
			bindHeadEvent("0");
		});
		//新增操作
		itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect: true,
	        items: []
	    });
		
		fileGrid = $('#table-file').mmGrid({
	        cols: cols_file,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        items: []
	    });
		deliveryGrid = $('#table-delivery').mmGrid({
	        cols: cols_delivery,
	        checkCol:true,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items: []
	    });
	} else {
		//修改操作,从服务器返回数据
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderByNumber/"+purchaseOrderNumber+"/"+elsAccount,
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.purchaseOrderHeaderVO.flowCode) {
					flowCode = data.purchaseOrderHeaderVO.flowCode;
				}
				if (data.purchaseOrderHeaderVO.auditStatus) {
					auditStatus = data.purchaseOrderHeaderVO.auditStatus;
				}
				if (data.purchaseOrderHeaderVO.orderType && data.purchaseOrderHeaderVO.orderType != "") {
					orderType = data.purchaseOrderHeaderVO.orderType;
				}
				if (data.purchaseOrderHeaderVO.stretegyCode) {
					$("#stretegyCode").val(data.purchaseOrderHeaderVO.stretegyCode);
				}
				//如果订单做废，隐藏操作按钮
				if (data.purchaseOrderHeaderVO.isDel == "Y") {
					$("#btnSend").hide();
					$("#saveBtn").hide();
					$("#entryBtn").hide();
					$("cancelEntryBtn").hide();
				}
				//如果是退货订单，可以选择是否实物退货
				if (data.purchaseOrderHeaderVO.fbk15 == 'Y') {
					var back = [{ title:'<i18n:I18n key="i18n_common_refundorder" defaultValue="退货订单" />',name:'fbk15' ,width:100, align:'center',renderer:function(val){
						return "<font color='red'><i18n:I18n key='i18n_common_refundorder' defaultValue='退货订单' /></font><input type='hidden' name='purchaseOrderHeaderVO[fbk15]' value='Y'/>";
					}},{ title:'<i18n:I18n key="i18n_common_practicalrefunds" defaultValue="实物退货" />',name:'fbk16' ,width:100, align:'center',renderer:function(val){
						var html = "<select name='purchaseOrderHeaderVO[fbk16]'>";
						if (val=="Y") {
							html += "<option value='Y'><i18n:I18n key='i18n_common_yes' defaultValue='是' /></option><option value='N'><i18n:I18n key='i18n_common_no' defaultValue='否' /></option></select>"
						} else {
							html += "<option value='Y'><i18n:I18n key='i18n_common_yes' defaultValue='是' /></option><option value='N' selected><i18n:I18n key='i18n_common_no' defaultValue='否' /></option></select>"
						}
						return html;
					}}];
					cols_head = back.concat(cols_head);
				}
				deliveryStatus = data.purchaseOrderHeaderVO.deliveryStatus;
				orderSendStatus = data.purchaseOrderHeaderVO.orderSendStatus;
				orderStatus = data.purchaseOrderHeaderVO.orderStatus;
				changeButtonStatus();
				fillData(data);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
				
			}
		});
	}
	
	$("#exitBtn").click(function(){
		if (winId != null && winId != "" && winId != "null") {
			parent.elsDeskTop.closeCurWin(winId,closeCallback());
		} else {
			parent.elsDeskTop.closeCurWin('PurchaseOrderUpdate',closeCallback());
		}
	});
	$("#btnAdd").click(function(){
		blankRow.orderItemNumber = itemGrid.rowsLength()+1;
		var row = $.extend({}, blankRow);
		itemGrid.addRow(row,itemGrid.rowsLength());
		bindItemEvent();
		
	});
	$("#btnBom").click(function(){
		if (purchaseOrderNumber == "") {
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_pleasesavetheorderfirst" defaultValue="请先保存订单！是否确认保存？" />',closeEvent:function(){
				$("#saveBtn").click();
			}});
		} else {
			//兼容ie 冒泡事件
		    if (event && event.preventDefault) {
		        event.preventDefault();
		        event.stopPropagation();
		    } else {
		        window.event.returnValue = false;
		    }
		    var orderItemNumber = "";
			var selectedIndexs = itemGrid.selectedRowsIndex();
			if(selectedIndexs.length>0)
				orderItemNumber = itemGrid.row(selectedIndexs[0]).orderItemNumber;
		    parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'PurchaseOrderBom',
		        'windowTitle':'<i18n:I18n key="i18n_common_button_setbom" defaultValue="设置BOM" />',
		        'iframSrc':"<%=basePath%>ordermanage/purchaseorder/editBom.jsp?purchaseOrderNumber="+purchaseOrderNumber+"&orderItemNumber="
		        		+orderItemNumber+"&toElsAccount="+toElsAccount+"&orderType="+orderType+"&flowCode="+flowCode+"&deliveryStatus="+deliveryStatus+"&winId="+winId,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
		}
	});
	$("#btnAddArr").click(function(){
		var selectedIndexs = itemGrid.selectedRowsIndex();
		if (selectedIndexs.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		itemGrid.addRow(blankRow,selectedIndexs[0]);
		bindItemEvent();
	});
	$("#btnRemove").click(function(){
		var selectedIndexs = itemGrid.selectedRowsIndex();
		if (selectedIndexs.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		//判断是新增的还是历史的，新增的直接删除，历史的更新删除标识
		if(itemGrid.selectedRows()[0].orderItemNumber && headGrid.rows()[0].orderStatus != '0') {
			var tr = $("#table-item").find("tr").eq(selectedIndexs[0]);
			tr.find(".deleteFlag").val("C");
			tr.find("td").css("background","yellow");
		} else {
			itemGrid.removeRow(selectedIndexs[0]);
			getDeliveryItem();
		}
	});
	$("#deleteItem").click(function(){
		var selectedIndexs = deliveryGrid.selectedRowsIndex();
		if (selectedIndexs.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		var trs = $("#table-delivery").find("tr:visible");
		if(trs.length > 1)
			deliveryGrid.removeRow(selectedIndexs[0]);
		else
			alert("计划行不能全部删除",2);
	});
	$("#columnDefineBtn").click(function(){
    	parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'subAccountColumnSetting',
            'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editPurchaseOrder_mt" + "&window=iframeApp_PurchaseOrderUpdate",
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
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editPurchaseOrderItem_mt" + "&window=iframeApp_PurchaseOrderUpdate",
            windowMinWidth: 480,
            windowMinHeight: 600,
            'windowWidth':480,
            'windowHeight':600,
            'parentPanel':".currDesktop"
        });
    });
    
    $("#btnAuditConfig").click(function(){
    	parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'selfAuditConfig',
            'windowTitle':'<i18n:I18n key="xxx" defaultValue="审批配置" />',
            'iframSrc':'<%=basePath%>audit/selfAuditConfig.jsp?businessType=purchaseOrder&propertyCode=purchaseOrderNumber&propertyValue=' + purchaseOrderNumber,
            'windowWidth':800,
            'windowHeight':500,
            'parentPanel':".currDesktop"
        });
    });
    
	$("#btnSend").click(function(){
		$("#table-head").find("select").each(function(){
			$(this).removeAttr("disabled");
		});
		$("#table-item").find("select").each(function(){
			$(this).removeAttr("disabled");
		});
		$("#table-item").find(":checkbox").each(function(){
			$(this).removeAttr("disabled");
		});
		
		if (!$("#fbk4").val()||$("#fbk4").val()=="" || $("#fbk4").val()==null) {
			alert("<i18n:I18n key="i18n_label_selectthepersoninchargeoftheorder" defaultValue="请选择订单负责人" />",2);
			return;
		}
		if(!checkFree()){
			alert("<i18n:I18n key="i18n_alert_addorderitem" defaultValue="请添加订单项" />",2);
			return;
		}
		//判断每一行是否有物料编码和物料描述
		var frm = $("#purchaseOrderForm");
		var formData = frm.serializeJSON();
		var length = formData["purchaseOrderItemList"].length;
		var flg = false;
		for(var i= 0;i<length;i++){
			var materialNumbers = formData["purchaseOrderItemList"][i].materialNumber;
			var materialDescs = formData["purchaseOrderItemList"][i].materialDesc;
			if(!materialNumbers && !materialDescs){
				flg = true;
			}
		}
		if(flg){
			alert("<i18n:I18n key="" defaultValue="物料编码和物料描述不能同时为空" />",2);
			return;
		}
		
		autoCreateDeliveryPlans();
		
/* 		genDeliveryPlanDate(); */
		
		genPurchaseQuantity();
		
/* 		if (!checkDeliveryPlan()) {
			alert(tempItemName + "<i18n:I18n key="i18n_alert_xxx" defaultValue="计划交货总数量必须等于采购数量" />",2);
			return;
		} */
		
		if(orderSendStatus != "0"){
			if(!checkQuantity()){
				alert(tempItemName + "<i18n:I18n key="i18n_alert_greatessss" defaultValue="订单数量不能修改为小于已发货数量" />",2);
				return;
			}
/* 			if(!checkUnlimited()){
				alert(tempItemName + "<i18n:I18n key="i18n_alert_greatessss" defaultValue="无限制交货标识仅在已发货数量不超过订单数量的情况下能由是改为否" />",2);
				return;
			} */
		}
		
		calculateTotalAmount();
		
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			var frm = $("#purchaseOrderForm");
			$("#fbk4Param").val($("#fbk4").val());
			if ($("#fbk5").length > 0) {
				$("#fbk5Param").val($("#fbk5").val());
			}
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/PurchaseOrderService/sendPurchaseOrder",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
                    if(data.statusCode == "E"){
						alert(data.message,3);
						return;
					}else if(data.statusCode == "Other"){
						console.log(data.errMessage);
						alert('请求不允许执行',3);
						return;
					}else if (data.statusCode == "-100") {
						console.log(data.message);
						alert(data.message,3);
						return;
					}
					alert("<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />");
					window.location="<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=" + toElsAccount + "&purchaseOrderNumber=" + data.purchaseOrderHeaderVO.purchaseOrderNumber;
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						if (data.status == "401") {
							alert("<i18n:I18n key="i18n_alert_noauditcannotsend" defaultValue="未审批通过的订单不能发送" />",3);
						} else {
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						}
					}
					
				}
			});
		}});
	});
	var uploader = WebUploader.create({
	    // swf文件路径
	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
	    auto: true,
	    duplicate :true,
	    accept:{
	    	extensions:"xls,xlsx"
	    },
	    // 文件接收服务端。
	    server: '<%=basePath%>rest/PurchaseOrderService/uploadPurchaseOrderItem',
	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#btnUpload',
	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	    resize: false
	});
	
	uploader.on( 'uploadAccept', function( file, response ) {
		if(response.statusCode=="-100"){
			alert(response.message,2);
		}else{
			if (response.rows && response.rows.length > 0) {
		    	itemGrid.addRows(response.rows);
		    	setTimeout(function(){
			    	bindItemEvent();
			    	getDeliveryItem();
		    	},100);
		    }
		}
	});
	
	$("#saveBtn").click(function(){
		
		$("#table-head").find("select").each(function(){
			$(this).removeAttr("disabled");
		});
		$("#table-item").find("select").each(function(){
			$(this).removeAttr("disabled");
		});
		$("#table-item").find(":checkbox").each(function(){
			$(this).removeAttr("disabled");
		});
		
		if (!$("#fbk4").val()||$("#fbk4").val()=="" || $("#fbk4").val()==null) {
			alert("<i18n:I18n key="i18n_label_selectthepersoninchargeoftheorder" defaultValue="请选择订单负责人" />",2);
			return;
		}
		if(!checkFree()){
			alert("<i18n:I18n key="i18n_alert_addorderitem" defaultValue="请添加订单项" />",2);
			return;
		}
		//生成交货计划
		autoCreateDeliveryPlans();
		
/* 		genDeliveryPlanDate(); */
		//从多组订单中取得最早交货的时间
		genPurchaseQuantity();
		
/* 		if (!checkDeliveryPlan()) {
			alert(tempItemName + "<i18n:I18n key="i18n_alert_xxx" defaultValue="计划交货总数量必须等于采购数量" />",2);
			return;
		} */
		
		if(orderSendStatus != "0"){
			if(!checkQuantity()){
				alert(tempItemName + "<i18n:I18n key="i18n_alert_greatessss" defaultValue="订单数量不能修改为小于已发货数量" />",2);
				return;
			}
/* 			if(!checkUnlimited()){
				alert(tempItemName + "<i18n:I18n key="i18n_alert_greatessss" defaultValue="无限制交货标识仅在已发货数量不超过订单数量的情况下能由是改为否" />",2);
				return;
			} */
		}
		
		calculateTotalAmount();
		
		var url;
		if (purchaseOrderNumber == "") {
			deleteSomeRows();
			url = "<%=basePath%>rest/PurchaseOrderService/addPurchaseOrder";
		} else {
			url = "<%=basePath%>rest/PurchaseOrderService/updatePurchaseOrder";
		}
		
		$("#fbk4Param").val($("#fbk4").val());
		if ($("#fbk5").length > 0) {
			$("#fbk5Param").val($("#fbk5").val());
		}
		
		var frm = $("#purchaseOrderForm");
	    parent.elsDeskTop.showLoading();
	    $.ajax({
		        url :url,
		        type :"post",
		        contentType : "application/json",
		        data : JSON.stringify(frm.serializeJSON()),
		        dataType : "json",
		        success : function(data) {
			        parent.elsDeskTop.hideLoading();
                    if(data.statusCode == "E"){
						alert(data.message,3);
						return;
					}else if(data.statusCode == "Other"){
						console.log(data.errMessage);
						alert('请求不允许执行',3);
						return;
					}
			        purchaseOrderNumber = data.purchaseOrderHeaderVO.purchaseOrderNumber;
			        closeCallback();
			        alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			        if (purchaseOrderNumber != "") {
			        	window.location="<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=" + toElsAccount + "&purchaseOrderNumber=" + data.purchaseOrderHeaderVO.purchaseOrderNumber;
			        }},
		        error : function(data) {
			        parent.elsDeskTop.hideLoading();
			        if (!permissionError(data)) {
			        	alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			        }}
	         });
	});
	
$("#entryBtn").click(function(){
		
		$("#table-head").find("select").each(function(){
			$(this).removeAttr("disabled");
		});
		$("#table-item").find("select").each(function(){
			$(this).removeAttr("disabled");
		});
		$("#table-item").find(":checkbox").each(function(){
			$(this).removeAttr("disabled");
		});
		
		if(!checkFree()){
			alert("<i18n:I18n key="i18n_alert_addorderitem" defaultValue="请添加订单项" />",2);
			return;
		}
		
// 		autoCreateDeliveryPlans();
		
/* 		genDeliveryPlanDate(); */
		
// 		genPurchaseQuantity();
		
/* 		if (!checkDeliveryPlan()) {
			alert(tempItemName + "<i18n:I18n key="i18n_alert_xxx" defaultValue="计划交货总数量必须等于采购数量" />",2);
			return;
		} */
		
		if(orderSendStatus != "0"){
			if(!checkQuantity()){
				alert(tempItemName + '<i18n:I18n key="i18n_alert_greatessss" defaultValue="订单数量不能修改为小于已发货数量" />',2);
				return;
			}
/* 			if(!checkUnlimited()){
				alert(tempItemName + "<i18n:I18n key="i18n_alert_greatessss" defaultValue="无限制交货标识仅在已发货数量不超过订单数量的情况下能由是改为否" />",2);
				return;
			} */
		}
		
		if ($("#fbk4").val()=="" || $("#fbk4").val()==null) {
			alert('<i18n:I18n key="i18n_label_selectthepersoninchargeoftheorder" defaultValue="请选择订单负责人" />',2);
			return;
		}
		
// 		calculateTotalAmount();
		
		var url;
		var frm = $("#purchaseOrderForm");
		$("#fbk4Param").val($("#fbk4").val());
		if ($("#fbk5").length > 0) {
			$("#fbk5Param").val($("#fbk5").val());
		}
		debugger;
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			debugger;
			$.ajax({
				url :"<%=basePath%>rest/PurchaseOrderService/entryPurchaseOrder",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
                    if(data.statusCode == "E"){
						alert(data.message,3);
						return;
					}else if(data.statusCode == "Other"){
						console.log(data.errMessage);
						alert('请求不允许执行',3);
						return;
					}else if (data.statusCode == "-100") {
						console.log(data.message);
						alert(data.message,3);
						return;
					}
					// 匹配的审批策略有多条，让用户选择
					if (data.rows) {
						showStretegySelector(data.rows);
						return;
					}
					purchaseOrderNumber = data.purchaseOrderHeaderVO.purchaseOrderNumber;
					closeCallback();
					alert("<i18n:I18n key="i18n_common_report_success" defaultValue="上报成功" />");
					if (purchaseOrderNumber != "") {
						window.location="<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=" + toElsAccount + "&purchaseOrderNumber=" + data.purchaseOrderHeaderVO.purchaseOrderNumber;
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						if (data.status == "401") {
							alert("<i18n:I18n key="i18n_common_orders_cannot_be_repeated_to_report" defaultValue="订单不能重复上报" />",3);
						} else {
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						};
					}
				}
			});
		}});
	});
	$("#flowBtn").click(function(){
		if (purchaseOrderNumber == "") {
			alert("<i18n:I18n key="i18n_delivery_notreport" defaultValue="单据尚未上报" />",2);
		} else if (flowCode == "") {
			debugger;
			alert("<i18n:I18n key="i18n_delivery_notreport" defaultValue="单据尚未上报" />",2);
		} else {
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'auditFlowList',
		        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
		        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=purchaseOrder&businessId='+purchaseOrderNumber,
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':680,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		}
		
	});
	$("#cancelEntryBtn").click(function(){
		if (purchaseOrderNumber == "") {
			alert("<i18n:I18n key="i18n_delivery_notreport" defaultValue="单据尚未上报" />",2);
		} else if (flowCode == "" || flowCode == "00") {
			alert("<i18n:I18n key="i18n_delivery_notreport" defaultValue="单据尚未上报" />",2);
		} else {
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				var param = {"businessElsAccount":elsAccount,"purchaseOrderNumber":purchaseOrderNumber,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
				$.ajax({
					url :"<%=basePath%>rest/PurchaseOrderService/cancelAudit",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(param),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						closeCallback();
						alert("<i18n:I18n key="i18n_delivery_revokesuccess" defaultValue="撤销成功" />");
						window.location="<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=" + toElsAccount + "&purchaseOrderNumber=" + purchaseOrderNumber;
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						if (!permissionError(data)) {
							if (data.status == "401") {
								alert("<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />",3);
							} else if (data.status == "403") {
								alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",3);
							} else {
								alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
							}
						}
					}
				});
			}});
		}
	});
}
function doSend(){
	var frm = $("#purchaseOrderForm");
	$("#fbk4Param").val($("#fbk4").val());
	if ($("#fbk5").length > 0) {
		$("#fbk5Param").val($("#fbk5").val());
	}
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/sendPurchaseOrder",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />");
//				if (purchaseOrderNumber == "") {
				window.location="<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=" + toElsAccount + "&purchaseOrderNumber=" + data.purchaseOrderHeaderVO.purchaseOrderNumber;
//				} else {
//					$("[name=orderSendStatus").val("2");
//				}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				if (data.status == "401") {
					alert("<i18n:I18n key="i18n_alert_noauditcannotsend" defaultValue="未审批通过的订单不能发送" />",3);
				} else {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
			
		}
	});
}
function doSave(url){
	var frm = $("#purchaseOrderForm");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :url,
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			purchaseOrderNumber = data.purchaseOrderHeaderVO.purchaseOrderNumber;
			closeCallback();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			if (purchaseOrderNumber != "") {
				window.location="<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=" + toElsAccount + "&purchaseOrderNumber=" + data.purchaseOrderHeaderVO.purchaseOrderNumber;
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
function showStretegySelector(stretegyList) {
	$(".dialog-tip").height(40);
	var html = "";
	for (var i=0;i<stretegyList.length;i++){
		html += "<option value='"+stretegyList[i].stretegyCode+"'>"+stretegyList[i].stretegyName+"</option>";
	}
	$("#stretegySelctor").empty().html(html);
	$('#dialog2').show();
	$("#btnFileOK2").unbind("click").click(function(){
		$("#stretegyCode").val($("#stretegySelctor").val());
		$("#entryBtn").click();
	});
}
function initDeliveryPlan() {
	$("#insertItem").click(function(){
		var val = $("#itemSelector").val();
		if (val) {
			//取出最大的 orderDeliveryItem 和 gridValue
			var orderDeliveryItem = 0;
			var gridValue = 0;
			if(deliveryGrid.rowsLength() > 0){
				$("#table-delivery").find("tr:visible").each(function(i,o){
					var data = $(this).data("item");
					var temOrderDeliveryItem = parseInt(data.orderDeliveryItem);
					var temGridValue = parseInt(data.gridValue);
					if(orderDeliveryItem <= temOrderDeliveryItem)
						orderDeliveryItem = temOrderDeliveryItem;
					if(gridValue <= temGridValue)
						gridValue = temGridValue;
				});
			}
			//添加一行
			var newRow = $.extend({}, blankDeliveryRow);
			newRow.orderDeliveryItem = orderDeliveryItem + 1;
			newRow.gridValue = gridValue + 1;
			newRow.orderItemNumber = val;
			deliveryGrid.addRow(newRow,deliveryGrid.rowsLength());
			bindDeliveryEvent();
		} else {
			alert("<i18n:I18n key="i18n_alert_addorderitem" defaultValue="请添加订单项" />",2);
		}
	});
}
var deliveryItemArr = [];
function getDeliveryItem() {
	$("#itemSelector").empty();
	deliveryItemArr = [];
	var strArray = new Array();
	$("#table-item").find("tr").each(function(){
		var orderItemNumber = $(this).find("input[name='purchaseOrderItemList[][orderItemNumber]']").val();
		var materialDesc = $(this).find("input[name='purchaseOrderItemList[][materialDesc]']").val();
		if (orderItemNumber && orderItemNumber != "") {
			strArray.push("<option value='");
			strArray.push(orderItemNumber);
			strArray.push("'>");
			strArray.push(orderItemNumber);
			strArray.push("_");
			strArray.push(materialDesc);
			strArray.push("</option>");
			deliveryItemArr.push(orderItemNumber);
		}
	});
	$("#itemSelector").append(String.prototype.concat.apply("", strArray));
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

function initSelectorsVal(){
	$("#table-item").find("tr").each(function(){
		var data = $(this).data("item");
		var selector = $(this).find("select[name='purchaseOrderItemList[][purchaseType]']");
		selector.val(data.purchaseType);
		var $selector2 = $(this).find("input[name='purchaseOrderItemList[][unlimited]']");
        if(data.unlimited && data.unlimited == 'X'){
        	$selector2.attr("checked",true);
    		var deliveredQuantity = parseFloat(data.deliveredQuantity);
    		var quantity = parseFloat(data.quantity);
    		if (quantity < deliveredQuantity){
    			$selector2.attr("readonly",true);
    			$selector2.removeAttr("onfocus");
    		}
        }
	});
}

function filterDeliveryPlan() {
	var orderItemNumber = $("#itemSelector").val();
	$(".delivery-orderItemNumber").each(function(){
		if (deliveryItemArr.indexOf($(this).val()) == -1) {
			$(this).parent().parent().parent().remove();
			return;
		}
		if ($(this).val()==orderItemNumber) {
			$(this).parent().parent().parent().css("display","");
		} else {
			$(this).parent().parent().parent().css("display","none");
		}
	});
	deliveryGrid.deselect("all");
}
function fillData(data) {
	headGrid = $('#table-head').mmGrid({
        cols: cols_head,
        height: 100,
        items:[data.purchaseOrderHeaderVO]
    });
	headGrid.on('loadSuccess',function(e, d) {
		setTimeout(function(){
			$("#fbk4").val(data.purchaseOrderHeaderVO.fbk4);
			$("#fbk4Param").val(data.purchaseOrderHeaderVO.fbk4);
			$("#fbk5Param").val(data.purchaseOrderHeaderVO.fbk5);
			$("#fbk4").css("display","");
			if (data.purchaseOrderHeaderVO.fbk4) {
				$("#fbk4").find("option").each(function(){
					if (data.purchaseOrderHeaderVO.fbk4.indexOf($(this).val()) != -1) {
						$(this).attr("selected","selected");
					}
				});
			}else{
				$("#fbk4").find("option").each(function(){
					if (elsSubAccount.indexOf($(this).val().split("_")[0]) != -1) {
						$(this).attr("selected","selected");
					}
				});
			}
			$("#fbk4").SumoSelect({optAfter:'#sheet-head ',optCancel:'#sheet-head .mmg-bodyWrapper'});
			if ($("#fbk5").length > 0) {
				$("#fbk5").val(data.purchaseOrderHeaderVO.fbk5);
				$("#fbk5").css("display","");
				if (data.purchaseOrderHeaderVO.fbk5) {
					$("#fbk5").find("option").each(function(){
						if (data.purchaseOrderHeaderVO.fbk5.indexOf($(this).val()) != -1) {
							$(this).attr("selected","selected");
						}
					});
				}
				$("#fbk5").SumoSelect({optAfter:'#sheet-head ',optCancel:'#sheet-head .mmg-bodyWrapper'});
			}
			
			$(".SlectBox").each(function(){
				$(this).css("width",$(this).parent().parent().parent().width()-18);
			});
			bindHeadEvent(data.purchaseOrderHeaderVO.orderStatus);
			if ((flowCode != "" && flowCode != "00" && auditStatus == "2") || deliveryStatus != "0" || orderSendStatus != "0" || orderStatus != "0") {
				if (data.purchaseOrderHeaderVO.auditStatus == "0" ){
					$("#entryBtn").hide();
					$("#flowBtn").show();
				}
				if (orderSendStatus != "1"){
					$("#btnSend").hide();
				}
				$("#table-head").find("input").each(function(){
					var name = $(this).attr("name");
					if(name != "purchaseOrderHeaderVO[isFinish]")
						$(this).attr("readOnly",true);
				});
				$("#table-head").find("select").each(function(){
					$(this).attr("disabled",true);
				});
				$("#table-head").find(".Wdate").each(function(){
					$(this).removeAttr("onfocus");
				});
/* 				$("input").attr("readOnly",true);
				$("select").attr("readOnly",true);
				$(".Wdate").removeAttr("onfocus"); */
			} else if (orderType != "ELS"&&orderType != "样品") {
				$("#table-head").find("input:not(.noElsEdit)").each(function(){
					var name = $(this).attr("name");
					if(name != "purchaseOrderHeaderVO[isFinish]")
						$(this).attr("readOnly",true);
				});
				$("#table-head").find(".Wdate").each(function(){
					$(this).removeAttr("onfocus");
				});
/* 				$("input:not(.noElsEdit)").attr("readOnly",true);
				$(".Wdate").removeAttr("onfocus"); */
				$("#fbk4").attr("readOnly",false);
				$("#fbk4").removeAttr("disabled");
			}
			debugger;
			if (data.purchaseOrderHeaderVO.auditStatus == "0"){
				$("#entryBtn").hide();
				$("#cancelEntryBtn").hide();
				$("#flowBtn").show();
			}
			if (data.purchaseOrderHeaderVO.auditStatus == "1"){
				$("#entryBtn").show();
				$("#cancelEntryBtn").hide();
			}
			if (data.purchaseOrderHeaderVO.auditStatus == "2"){
				$("#entryBtn").hide();
				$("#cancelEntryBtn").show();
				$("#flowBtn").show();
			}
			if (data.purchaseOrderHeaderVO.auditStatus == "3"){
				$("#entryBtn").show();
				$("#cancelEntryBtn").hide();
				$("#flowBtn").show();
			}
			
			var newStr='<input name="purchaseOrderHeaderVO[orderType]" class="noEdit" type="text"  value="'+data.purchaseOrderHeaderVO.orderType+'" readonly="readonly">';
			if(type!="create"){
				$("#table-head select[name='purchaseOrderHeaderVO[orderType]']").parent().html(newStr);
			}
		},100);
	});
	fileGrid = $('#table-file').mmGrid({
        cols: cols_file,
        items: data.purchaseFormFileList,
    	height: 323,
    	checkCol: true
    });
	
// 	itemGrid = $('#table-item').mmGrid({
//         cols: cols_item,
//         checkCol:true,
//         items: data.purchaseOrderItemList
//     });
	
	if (data.purchaseOrderItemList.length > 200) {
		loadPartItem(0,200,data);
	} else {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect: true,
	        items: data.purchaseOrderItemList
	    });
		itemGrid.on('loadSuccess',function(e, d) {
			setTimeout(function(){
				bindItemEvent();
				initSelectorsVal();
				calculateTotalAmount();
				fillDeliveryPlan(data.purchaseDeliveryPlanList);
				//  || orderSendStatus != "0" || deliveryStatus != "0"
				if ((flowCode != "" && flowCode != "00" && auditStatus == "2")) {
					$("#table-item").find("input").each(function(){
						if(!$(this).hasClass("mmg-check")) {
							$(this).attr("readOnly",true);
						}
/* 						var name = $(this).attr("name");
                        if(name != "purchaseOrderItemList[][fbk35]" && name != "purchaseOrderItemList[][deliveryDate]"
                        		&& name != "purchaseOrderItemList[][quantity]"){
							$(this).attr("readOnly",true);
						} */
					});
					$("#table-item").find("select").each(function(){
						$(this).attr("disabled",true);
					});
					$("#table-item").find(".Wdate").each(function(){
						$(".Wdate").removeAttr("onfocus");
					});
/* 					$("input").attr("readOnly",true);
					$("select").attr("readOnly",true);
					$(".Wdate").removeAttr("onfocus"); */
				}else if (orderType != "ELS"&&orderType != "样品") {
					disEditSomeCols();
// 					$("#table-item").find("input:not(.noElsEdit)").each(function(){
// 						var name = $(this).attr("name");
// 						if(name != "purchaseOrderItemList[][fbk35]")
// 							$(this).attr("readOnly",true);
// 					});
// 					$("#table-item").find(".Wdate").each(function(){
// 						$(".Wdate").removeAttr("onfocus");
// 					});
/* 					$("input:not(.noElsEdit)").attr("readOnly",true);
					$(".Wdate").removeAttr("onfocus");
					$("#fbk4").attr("readOnly",false);
					$("#fbk4").removeAttr("disabled"); */
				}
				
				//汇洁需求:控制某些列不能修改
				if(orderSendStatus != "0" || orderStatus != "0")
					disEditSomeCols();
					
				initModifyFiled(data.purchaseOrderItemList);
			},100);
			
		});
	}
}
function loadPartItem(start,size,data) {
	var array = [];
	for (var i=0;i<size;i++) {
		array[i] = data.purchaseOrderItemList[start+i];
	}
	start = start + size;
	if (itemGrid) {
		itemGrid.addRows(array);
	} else {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect: true,
	        items: array
	    });
	}
	if (start < data.purchaseOrderItemList.length) {
		setTimeout(function(){
			if (data.purchaseOrderItemList.length - start > 200) {
				loadPartItem(start,200,data);
			} else {
				loadPartItem(start,data.purchaseOrderItemList.length-start,data);
			}
		},200);
	} else {
		bindItemEvent();
		initSelectorsVal();
		calculateTotalAmount();
		fillDeliveryPlan(data.purchaseDeliveryPlanList);
		// || orderSendStatus != "0" || deliveryStatus != "0"
		if ((flowCode != "" && flowCode != "00" && auditStatus == "2")) {
			$("#table-item").find("input").each(function(){
				if(!$(this).hasClass("mmg-check")) {
					$(this).attr("readOnly",true);
				}
			});
			$("#table-item").find("select").each(function(){
				$(this).attr("disabled",true);
			});
			$("#table-item").find(".Wdate").each(function(){
				$(".Wdate").removeAttr("onfocus");
			});
/* 			$("input").attr("readOnly",true);
			$("select").attr("readOnly",true);
			$(".Wdate").removeAttr("onfocus"); */
		}else if (orderType != "ELS"&&orderType != "样品") {
			disEditSomeCols();
// 			$("#table-item").find("input:not(.noElsEdit)").each(function(){
// 				$(this).attr("readOnly",true);
// 			});
// 			$("#table-item").find(".Wdate").each(function(){
// 				$(".Wdate").removeAttr("onfocus");
// 			});
/* 			$("input:not(.noElsEdit)").attr("readOnly",true);
			$(".Wdate").removeAttr("onfocus");
			$("#fbk4").attr("readOnly",false); */
		}
		//汇洁需求:控制某些列不能修改
		if(orderSendStatus != "0" || orderStatus != "0")
			disEditSomeCols();
		initModifyFiled(data.purchaseOrderItemList);
	}
}

function checkFree(){
	var rows=itemGrid.rows();
	if((rows.length==1&&rows=="")||rows.length<=0){
		return false;
	}
	return true;
}

function fillDeliveryPlan(data){
	$('#deliveryGrid').html('<table id="table-delivery"></table><div id="pg" style="text-align: right;"></div>');

	deliveryGrid = $('#table-delivery').mmGrid({
        cols: cols_delivery,
        checkCol:true,
        items: data
    });
	deliveryGrid.on('loadSuccess',function(e, d) {
		setTimeout(function(){
			bindDeliveryEvent();
			if($("#itemSelector").find("option").length<=0){
				getDeliveryItem();
			}
			initDeliveryPlan();
			filterDeliveryPlan();
			//  || orderSendStatus != "0" || orderStatus != "0"
			if ((flowCode != "" && flowCode != "00" && auditStatus == "2") || deliveryStatus == "3") {
				$("#table-delivery").find("input").each(function(){
					$(this).attr("readOnly",true);
				});
				$("#table-delivery").find("select").each(function(){
					$(this).attr("disabled",true);
				});
				$("#table-delivery").find(".Wdate").each(function(){
					$(this).removeAttr("onfocus");
				});
/* 				$("input").attr("readOnly",true);
				$("select").attr("readOnly",true); */
			}
			checkDeliveryPlanTrs();
			checkItemIsDeleted();
		},100);
	});
}

function loadOrderItem(){
	var isOrderItem = $("#operTypeSelector").val();
	console.log(isOrderItem);
	if("1" == isOrderItem){
		$(".dialog-tip").height(270);
		$("#divOrderItem").show();
		getOrderItem();
	}else{
		$(".dialog-tip").height(240);
		$("#divOrderItem").hide();
		$("#orderItemSelector").empty();
	}
}
function bindItemEvent(){
// 	$("#table-item").find("input").not(":checkbox").each(function(){
// 		$(this).css("width",$(this).parent().parent().width()-15);
// 	});
// 	$("#table-item").find("td").unbind("dblclick").bind("dblclick",function(){
// 		var $input = $(this).find("input");
// 		if ($input.hasClass("Wdate")  ||$input.hasClass("noEdit")|| $input.is(":checkbox")) {
// 			return false;
// 		}
// 		$(this).find(".showText").hide();
// 		$input.show();
// 		$input.css("width",$(this).width()-15);
// 		$input.focus();
// 	});
// 	$("#table-item").find("input").unbind("blur").bind("blur",function(){
// 		if ($(this).hasClass("Wdate") || $(this).is(":checkbox")) {
// 			return false;
// 		}
// 		$(this).prev(".showText").html($(this).val());
// 		var attr = $(this).attr("attr");
// 		if (attr) {
// 			$(this).parent().parent().parent().data("item")[attr] = $(this).val();
// 			getDeliveryItem();
// 		}
// 		$(this).prev(".showText").show();
// 		$(this).hide();
// 	});
	$(".quantity").blur(function(){
		var val = $(this).val();
		var $price = $(this).parent().parent().parent().find(".price");
		var $totalAmount = $(this).parent().parent().parent().find(".totalAmount");
		if (isNaN(val)) {
			alert("<i18n:I18n key="i18n_alert_fillnumber" defaultValue="请输入数字" />",2);
			$(this).focus();
			return;
		}
		var total = parseFloat(val)*parseFloat($price.val());
		$totalAmount.val(total.toFixed(2));
		$totalAmount.prev("span").html(total.toFixed(2));
		
		//如果本行对应只有一行交货计划的情况下，将订单数量同步到计划交货数量
		var temp = 0;
		var rowIndex = -1;
		var deliveryList = deliveryGrid.rows();
		var orderItemNumber = $(this).parent().parent().parent().find("input[name='purchaseOrderItemList[][orderItemNumber]']").val();
		$("#table-delivery").find("tr").each(function(i,val){
			var planOrderItemNumber = $(this).find("input[name='purchaseDeliveryPlanList[][orderItemNumber]']").val();
			if(orderItemNumber == planOrderItemNumber){
				rowIndex = i;
				temp = temp + 1;
				if(temp > 1){
					rowIndex = -1;
					return false;
				}
			}
		});
		if(rowIndex != -1){
			deliveryList[rowIndex].deliveryQuantity = val;
			$("#table-delivery").find("tr").eq(rowIndex).find("input[name='purchaseDeliveryPlanList[][deliveryQuantity]']").val(val);
		}
	});
	
	$(".price").keyup(function(){
		var val = $(this).val();
		var $quantity = $(this).parent().parent().parent().find(".quantity");
		var $totalAmount = $(this).parent().parent().parent().find(".totalAmount");
		var $noTaxUnitPrice = $(this).parent().parent().parent().find(".noTaxUnitPrice");
		var rate = $(this).parent().parent().parent().find("input[name='purchaseOrderItemList[][fbk1]']").val();
		if (isNaN(val)) {
			alert("<i18n:I18n key="i18n_alert_fillnumber" defaultValue="请输入数字" />",2);
			$(this).focus();
			return;
		}
		var total = parseFloat($quantity.val())*parseFloat(val);
		$totalAmount.val(total.toFixed(2));
		$totalAmount.prev("span").html(total.toFixed(2));
		//根据含税单价和税率计算出不含税单价并同步
		if(rate == '' || isNaN(rate))
			return;
		var noTaxPrice = parseFloat(val) / (1 + parseFloat(rate) / 100);
		$noTaxUnitPrice.val(noTaxPrice.toFixed(2));
	});
	
	$(".noTaxUnitPrice").keyup(function(){
		var val = $(this).val();
		var $price = $(this).parent().parent().parent().find(".price");
		var rate = $(this).parent().parent().parent().find("input[name='purchaseOrderItemList[][fbk1]']").val();
		if (isNaN(val)) {
			alert("<i18n:I18n key="i18n_alert_fillnumber" defaultValue="请输入数字" />",2);
			$(this).focus();
			return;
		}
		//根据不含税单价和税率计算出含税单价并同步
		if(rate == '' || isNaN(rate))
			return;
		var price = parseFloat(val) * (1 + parseFloat(rate) / 100);
		$price.val(price.toFixed(2));
	});
	
 	$("#table-item").find("input[name='purchaseOrderItemList[][deliveryDate]']").blur(function(){
 		var val = $(this).val();
		var temp = 0;
		var rowIndex = -1;
		var deliveryList = deliveryGrid.rows();
		var orderItemNumber = $(this).parent().parent().parent().find("input[name='purchaseOrderItemList[][orderItemNumber]']").val();
		$("#table-delivery").find("tr").each(function(i,val){
			var planOrderItemNumber = $(this).find("input[name='purchaseDeliveryPlanList[][orderItemNumber]']").val();
			if(orderItemNumber == planOrderItemNumber){
				rowIndex = i;
				temp = temp + 1;
				if(temp > 1){
					rowIndex = -1;
					return false;
				}
			}
		});
		if(rowIndex != -1){
			deliveryList[rowIndex].deliveryTime = val;
			$("#table-delivery").find("tr").eq(rowIndex).find("input[name='purchaseDeliveryPlanList[][deliveryTime]']").val(val);
		}
	});
}
function bindHeadEvent(status){
// 	$("#table-head").find("input").not(":checkbox").each(function(){
// 		$(this).css("width",$(this).parent().parent().width()-15);
// 	});
// 	var orderStatus = status;
// 	$("#table-head").find("td").each(function(){
// 		var val = $(this).find(".showText").text();
// 		var selectObj = $(this).find("select");
// 		if(selectObj.length>0)
// 			selectObj.val(val);			
// 	});
// 	$("#table-head").find("td").unbind("dblclick").bind("dblclick",function(){
// 		var $input = $(this).find("input");
// 		var $select = $(this).find("select");
// 		if ($input.hasClass("Wdate") || $input.hasClass("noEdit") || $input.is(":checkbox")) {
// 			return false;
// 		}
// 		$(this).find(".showText").hide();
// 		$input.show();
// 		$select.show();
// 		$select.val(orderStatus);
// 		$input.css("width",$(this).width()-15);
// 		$select.css("width",$(this).width()-15);
// 		$input.focus();
// 		$select.focus();
// 	});
// 	$("#table-head").find("input").unbind("blur").bind("blur",function(){
// 		if ($(this).hasClass("Wdate") || $(this).is(":checkbox")) {
// 			return false;
// 		}
// 		$(this).prev(".showText").html($(this).val());
// 		$(this).prev(".showText").show();
// 		$(this).hide();
// 	});
// 	$("#table-head").find("select").unbind("blur").bind("blur",function(){
// 		orderStatus = $(this).val();
// 		$(this).prev(".showText").html($(this).find("option:selected").text()); 
// 		$(this).prev(".showText").show();
// 		$(this).hide();
// 	});
}
function bindDeliveryEvent(){
// 	$("#table-delivery").find("input").not(":checkbox").each(function(){
// 		$(this).css("width",$(this).parent().parent().width()-15);
// 	});
// 	$("#table-delivery").find("td").unbind("dblclick").bind("dblclick",function(){
// 		var $input = $(this).find("input");
// 		if ($input.hasClass("Wdate") ||$input.hasClass("noEdit") || $input.is(":checkbox")) {
// 			return false;
// 		}
// 		$(this).find(".showText").hide();
// 		$input.show();
// 		$input.css("width",$(this).width()-15);
// 		$input.focus();
// 	});
// 	$("#table-delivery").find("input").unbind("blur").bind("blur",function(){
// 		if ($(this).hasClass("Wdate") || $(this).is(":checkbox")) {
// 			return false;
// 		}
// 		$(this).prev(".showText").html($(this).val());
// 		$(this).prev(".showText").show();
// 		$(this).hide();
// 	});
}
$("#showDelete").click(function(){
	changeDelete(this);
});

function changeDelete(obj){
	var itemList = itemGrid.rows();
	if($(obj).attr("checked")=="checked") {
		for (var i in itemList) {
			var deleteFlag = itemList[i].deleteFlag;
			if (deleteFlag && deleteFlag == "X") {
				$("#table-item").find("tr").eq(i).show();
			}
		}
	} else {
		for (var i in itemList) {
			var deleteFlag = itemList[i].deleteFlag;
			if (deleteFlag && deleteFlag == "X") {
				$("#table-item").find("tr").eq(i).hide();
			}
		}
	}
}
$("#sendForm").click(function(){
	var selectedIndexs = fileGrid.selectedRowsIndex();
	if (selectedIndexs.length == 0) {
		alert("<i18n:I18n key="i18n_delivery_choosefileplease" defaultValue="请选择表单文件" />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		var selectedRow = fileGrid.row(selectedIndexs[0]);
		formId = selectedRow.formId;
		var paramStr='{"elsAccount":"'+ elsAccount+ '","companyShortName":"'+companyShortName+'","elsSubAccount":"'+ elsSubAccount+ '","formId":"'+ formId+ '"}';
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/PurchaseFormFileService/order/sendPurchaseFormFile",
			type :"post",
			contentType : "application/json",
			data : paramStr,
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				selectedRow.fileStatus = 1;
				fileGrid.updateRow(selectedRow,selectedIndexs[0]);
				closeCallback();
				alert("<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />");
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
//计算订单总价
function calculateTotalAmount() {
	var total = 0;
	$(".totalAmount").each(function(){
		var $price = $(this).parent().parent().parent().find(".price").val();
		var $quantity = $(this).parent().parent().parent().find(".quantity").val();
		var t = (parseFloat($price) * parseFloat($quantity)).toFixed(2);
		$(this).val(t);
		$(this).prev("span").html(t);
		total = parseFloat(total) + parseFloat(t);
	});
	$("#totalAmount").val(total.toFixed(2));
	$("#totalAmount").prev("span").html(total.toFixed(2));
}
var tempItemName="";

function genPurchaseQuantity() {
	var quantitys = $(".quantity");
	var flag = true;
	for (var i=0;i<quantitys.length;i++) {
		var $quantity = quantitys.eq(i);
		var planNum = 0.00;
		var orderItemNumber = $quantity.parent().parent().parent().find("[attr=orderItemNumber]").val();
		var array = [];
		$(".delivery-orderItemNumber").each(function(){
			if ($(this).val() == orderItemNumber) {
				var t = parseFloat($(this).parent().parent().parent().find(".deliveryQuantity").val());
				planNum = planNum + t;
				//将计划交货日期放入数组
				var deliveryDate = $(this).parent().parent().parent().find("input[name='purchaseDeliveryPlanList[][deliveryTime]']").val();
				array.push(deliveryDate);
			}
		});
		$quantity.parent().parent().parent().find("input[name='purchaseOrderItemList[][quantity]']").val(planNum);
		//取最早计划交货日期
		var minPlanDeliveryDate = Math.min.apply(null,array.map(function(elm){
						return new Date(elm);
					}));
		if(!(minPlanDeliveryDate === Infinity)){
			minPlanDeliveryDate = new Date(minPlanDeliveryDate).format("yyyy-MM-dd");
			$quantity.parent().parent().parent().find("input[name='purchaseOrderItemList[][deliveryDate]']").val(minPlanDeliveryDate);
		}
	}
}
//检查交货计划
 function checkDeliveryPlan() {
	var quantitys = $(".quantity");
	var flag = true;
	for (var i=0;i<quantitys.length;i++) {
		var $quantity = quantitys.eq(i);
		var num = parseFloat($quantity.val());
		var orderItemNumber = $quantity.parent().parent().parent().find("[attr=orderItemNumber]").val();
		var materialDesc = $quantity.parent().parent().parent().find("[attr=materialDesc]").val();
		var planNum = 0.00;
		$(".delivery-orderItemNumber").each(function(){
			if ($(this).val()==orderItemNumber) {
				var t = parseFloat($(this).parent().parent().parent().find(".deliveryQuantity").val());
				planNum = planNum + t;
			}
		});
		if (num != planNum) {
			flag = false;
			tempItemName = orderItemNumber + "_" + materialDesc;
			return flag;
		}
	}
	return flag;
}

function checkQuantity(){
	var quantitys = $(".quantity");
	var flag = true;
	for (var i=0;i<quantitys.length;i++) {
		var $quantity = quantitys.eq(i);
		var num = parseFloat($quantity.val());
		var deliveredQuantity = parseFloat($quantity.parent().parent().parent().find("input[name='purchaseOrderItemList[][deliveredQuantity]']").val());
		var orderItemNumber = $quantity.parent().parent().parent().find("input[name='purchaseOrderItemList[][orderItemNumber]']").val();
		var materialDesc = $quantity.parent().parent().parent().find("input[name='purchaseOrderItemList[][materialDesc]']").val();
		if (num < deliveredQuantity) {
			flag = false;
			tempItemName = orderItemNumber + "_" + materialDesc;
			return flag;
		}
	}
	return flag;
}

function checkUnlimited(){
	var flag = true;
	$("#table-item").find("select[name='purchaseOrderItemList[][unlimited]']").each(function(){
		var unlimited = $(this).val();
		var deliveredQuantity = parseFloat($(this).parent().parent().parent().find("input[name='purchaseOrderItemList[][deliveredQuantity]']").val());
		var quantity = parseFloat($(this).parent().parent().parent().find(".quantity").val());
		var orderItemNumber = $(this).parent().parent().parent().find("input[name='purchaseOrderItemList[][orderItemNumber]']").val();
		var materialDesc = $(this).parent().parent().parent().find("input[name='purchaseOrderItemList[][materialDesc]']").val();
		if (unlimited == "0" && quantity < deliveredQuantity) {
			flag = false;
			tempItemName = orderItemNumber + "_" + materialDesc;
			return flag;
		}
	});
	return flag;
}

$('#deliveryTab').click(function() {
	autoCreateDeliveryPlans();
	initPlanUploader();
});


function initPlanUploader(){
	if(!planUploader){
		planUploader = WebUploader.create({
		    // swf文件路径
		    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		    auto: true,
		    duplicate :true,
		    accept:{
		    	extensions:"xls,xlsx"
		    },
		    // 文件接收服务端。
		    server: '<%=basePath%>rest/PurchaseOrderService/uploadPurchaseOrderPlan',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#btnPlanUpload',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false
		});
		
		planUploader.on( 'uploadAccept', function( file, response ) {
		   updateDeliveryPlan(response._raw);
		});
	}
}

function updateDeliveryPlan(fileName){
	var paramStr='{"elsAccount":"'+elsAccount+'","toElsAccount":"'+toElsAccount+'","elsSubAccount":"'+elsSubAccount+'","purchaseOrderNumber":"'+purchaseOrderNumber+'","fileName":"'+fileName+'"}';
	$.ajax({
		url : "<%=basePath%>rest/PurchaseOrderService/order/updateDeliveryPlan",
		type : "post",
		contentType : "application/json",
		dataType : "json",
		data:paramStr,
		success : function(data) {
			if(data.statusCode=="-100"){
				alert(data.message,2);
			}else{
				fillDeliveryPlan(data);
				alert("<i18n:I18n key="i18n_alert_uploadSuccess" defaultValue="上传成功" />");
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
function changeButtonStatus() {
	//根据flowCode改变各按钮状态
	// || deliveryStatus != "0"
	if (flowCode != "" && flowCode != "00"){
		if(auditStatus == "2"){
			$(".edit-btn").hide();
		}
		$("#entryBtn").hide();
		$("#cancelEntryBtn").show();
		$("#flowBtn").show();
	}	else {
		$("#entryBtn").show();
		$("#cancelEntryBtn").hide();
		$("#flowBtn").hide();
	}
	if (orderType != "ELS"&&orderType != "样品") {
		$(".elsEdit").remove();
	}
	if(orderSendStatus != "0" || orderStatus != "0"){
		$("#btnBom").hide();
		$("#btnAdd").hide();
		$("#btnAddArr").hide();
		$("#btnUpload").hide();
		$("#btnDownloadTemplate").hide();
		
		if(deliveryStatus != "0"){
			$("#cancelDeleteRow").hide();
			$("#deleteRow").hide();
		}else{
			$("#cancelDeleteRow").show();
			$("#deleteRow").show();
		}			
		
/*		$("#btnAddFile").hide();
		$("#btnModifyFile").hide();
		$("#btnDeleteFile").hide();
		
 		$("#insertItem").hide();
		$("#deleteItem").hide();
		$("#btnPlanUpload").hide();
		$("#btnPlanTempDownload").hide();
		$("#noticeText").hide(); */
		
		$("#saveBtn").hide();
	}else{
		$("#saveBtn").show();
	}
}
function renderPurchaseTypeSelector(val,item) {
	return "<select name='purchaseOrderItemList[][purchaseType]'>" +
	       "<option value='0'><i18n:I18n key='i18n_common_select_procurementtype_standard' defaultValue='标准' /></option>" +
		   "<option value='1'><i18n:I18n key='i18n_common_select_procurementtype_restrict' defaultValue='限制' /></option>" +
		   "<option value='2'><i18n:I18n key='i18n_common_select_procurementtype_consignment' defaultValue='寄售' /></option>" +
		   "<option value='3'><i18n:I18n key='i18n_common_select_procurementtype_subcontract' defaultValue='分包' /></option>" +
		   "<option value='4'><i18n:I18n key='i18n_common_select_procurementtype_anunknowncommodity' defaultValue='未知的商品' /></option>" +
		   "<option value='5'><i18n:I18n key='i18n_common_select_procurementtype_thirdparty' defaultValue='第三方' /></option>" +
		   "<option value='6'><i18n:I18n key='i18n_common_select_procurementtype_text' defaultValue='文本' /></option>" +
		   "<option value='7'><i18n:I18n key='i18n_common_select_procurementtype_stocktransfer' defaultValue='库存转储' /></option>" +
		   "<option value='8'><i18n:I18n key='i18n_common_select_procurementtype_commoditytype' defaultValue='商品类目' /></option>" +
		   "<option value='9'><i18n:I18n key='i18n_common_select_procurementtype_service' defaultValue='服务' /></option>" +
		   "</select>";
}
function genOverTolerance(a){
	var checked = $(a).is(':checked');
	if (checked) {
		$(a).parent().parent().parent().find("input[name='purchaseOrderItemList[][overTolerance]']").val("0.00");
		$(a).parent().parent().parent().find("input[name='purchaseOrderItemList[][overToleranceQuantity]']").val("0.000");
		$(a).parent().parent().parent().find("input[name='purchaseOrderItemList[][overToleranceQuantity]']").prev(".showText").text("0.000");
	}
}
function renderUnlimitedSelector(val,item){
	return "<input name='purchaseOrderItemList[][unlimited]' type='checkbox' value='X' onclick='genOverTolerance(this)' />";
}
function renderIsFinishCheckbox(val,item){
	if(val && val == "X")
		return "是";
	else
		return "<input name='purchaseOrderHeaderVO[isFinish]' type='checkbox' value='X' />";
}
function renderItemIsFinishCheckbox(val,item){
	if(val && val == "X")
		return "是";
	else
		return "<input name='purchaseOrderItemList[][fbk35]' type='checkbox' value='X' />";
}
function loadFormFileByType() {
	var type = $("#formFileTypeSelector").val();
	if(purchaseOrderNumber != null && purchaseOrderNumber != "null" && purchaseOrderNumber != ""){
		$.ajax({
			url :"<%=basePath%>rest/PurchaseFormFileService/order/selectByHeadOrItem/" + elsAccount + "/" + purchaseOrderNumber + "/" + type,
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				fileGrid.load(data.rows);
			},
			error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	}
}

//汇洁需求:【物料编码】、【物料描述】、【采购方收货工厂】修改以及删除一行按钮仅在对方未发货时允许
function disEditSomeCols(){
	$("#table-item").find("select").each(function(){
		$(this).attr("disabled",true);
	});
	$("#table-item").find("input").each(function(){
		var name = $(this).attr("name");
		if(name != "purchaseOrderItemList[][materialNumber]" && name != "purchaseOrderItemList[][materialDesc]" 
				&& name != "purchaseOrderItemList[][price]" && name != "purchaseOrderItemList[][noTaxUnitPrice]" 
				&& name != "purchaseOrderItemList[][quantity]" && name != "purchaseOrderItemList[][lackTolerance]"
				&& name != "purchaseOrderItemList[][overTolerance]" && name != "purchaseOrderItemList[][unlimited]"
				&& name != "purchaseOrderItemList[][purchaseFactory]" && name != "purchaseOrderItemList[][inventoryLocation]"
				&& name != "purchaseOrderItemList[][deliveryDate]" && name != "purchaseOrderItemList[][fbk35]"){
			if(!$(this).hasClass("mmg-check")) {
				$(this).attr("readOnly",true);
			}
			$(this).removeAttr("onfocus");
		}
		if(deliveryStatus != "0"){
			if(name == "purchaseOrderItemList[][materialNumber]" || name == "purchaseOrderItemList[][materialDesc]" || name == "purchaseOrderItemList[][purchaseFactory]")
				$(this).attr("readonly",true);
		}
	});
}

function hideSomeCols(){
	if(!purchaseOrderNumber || purchaseOrderNumber == ""){
		cols_head.forEach(function(d,i){
			if(d.name == "orderSendStatus" || d.name == "deliveryStatus")
				d.hidden = true;
		});
	}
}

//根据输入的物料编号自动获取其配置的相关文档
$('.blur-autoLoadFile').live('blur',function(e) {
	if(purchaseOrderNumber == ""){ //若订单未保存不做自动获取文档操作
		return;
	}
	var scanCol = $(this).next();
    var sanContentText = scanCol.text();
    var rowIndex = $(this).closest("tr").index();
    var itemObj = JSON.parse(sanContentText);
    var orderItemNumber = itemObj.orderItemNumber;
    var logtime = new Date();
    var materialNumber = $(this).val();
    if(materialNumber == ""){
    	return;
    }
    $.ajax({
		url :"<%=basePath%>rest/ElsFileCenterService/aotuLoadFile2Item",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify({"elsAccount":elsAccount,"pertainObject":"Material","stairObjectCode":materialNumber}),
		success : function(data) {
			if(data instanceof Array){
				for(var i = 0 ; i < data.length ; i ++){
					var item = data[i];
					var datas = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,
							     "purchaseOrderNumber":purchaseOrderNumber,"orderItemNumber":orderItemNumber,
							     "fileType":item.fileType,"fileName":item.fileName,"filePath":item.filePath,
							     "logtime":logtime,"fbk1":item.fileNumber+"_"+item.versionNumber
							     };
					$.ajax({
						url : "<%=basePath%>rest/PurchaseFormFileService/order/addPurchaseFormFile",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(datas),
						dataType : "json",
						success : function(data) {
							if(data != null){
								loadFormFileByType();
							}/* else{
								alert('<i18n:I18n key="i18n_delivery_filenameexist" defaultValue="该文件名已存在" />',2);
							} */
						}
					});
				}
				
			}
		}/* ,
		error : function(data) {
			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		} */
	});
    
    
});
function initModifyFiled(itemList) {
	var map = {};
	for (var i in cols_item) {
		map[cols_item[i].name] = i;
	}
	for (var i in itemList) {
		var fbk50 = itemList[i].fbk50;
		if (fbk50) {
			var changeFields = fbk50.split(",");
			for (var j in changeFields) {
				$("#table-item").find("tr").eq(i).find("td").eq(parseInt(map[changeFields[j]])+1).css("background","yellow");
			}
		}
		// 删除待确认的标识
		if (itemList[i].deleteFlag && itemList[i].deleteFlag=="C") {
			$("#table-item").find("tr").eq(i).find("td").css("background","yellow");
		}
		if (itemList[i].deleteFlag && itemList[i].deleteFlag=="X") {
			$("#table-item").find("tr").eq(i).css("background-color","rgba(213, 58, 58, 0.0980392)");
			$("#table-item").find("tr").eq(i).hide();
			//该行不能编辑
			$("#table-item").find("tr").eq(i).find("input").each(function(){
				$(this).attr("readOnly",true);
			});
			$("#table-item").find("tr").eq(i).find(":checkbox").each(function(){
				$(this).attr("disabled",true);
			});
			$("#table-item").find("tr").eq(i).find("select").each(function(){
				$(this).attr("disabled",true);
			});
			$("#table-item").find("tr").eq(i).find(".Wdate").each(function(){
				$(".Wdate").removeAttr("onfocus");
			});
			//该行对应的所有交货计划不能编辑
			var orderItemNumber = itemList[i].orderItemNumber;
			$("#table-delivery").find("tr").each(function(i,val){
				var planOrderItemNumber = $(this).find("input[name='purchaseDeliveryPlanList[][orderItemNumber]']").val();
				if(orderItemNumber == planOrderItemNumber){
					$(this).find("input").each(function(){
						$(this).attr("readOnly",true);
					});
					$(this).find("select").each(function(){
						$(this).attr("disabled",true);
					});
					$(this).find(".Wdate").each(function(){
						$(this).removeAttr("onfocus");
					});
				}
			});
		}
	}
}

function genDeliveryPlanDate(){
	$("#table-item").find("tr").each(function(index,val){
		var temp = 0;
		var rowIndex = -1;
		var deliveryList = deliveryGrid.rows();
		var orderItemNumber = $(this).find("input[name='purchaseOrderItemList[][orderItemNumber]']").val();
		var deliveryDate = $(this).find("input[name='purchaseOrderItemList[][deliveryDate]']").val();
		var quantity = $(this).find("input[name='purchaseOrderItemList[][quantity]']").val();
		$("#table-delivery").find("tr").each(function(i,val){
			var planOrderItemNumber = $(this).find("input[name='purchaseDeliveryPlanList[][orderItemNumber]']").val();
			if(orderItemNumber == planOrderItemNumber){
				rowIndex = i;
				temp = temp + 1;
				if(temp > 1){
					rowIndex = -1;
					return false;
				}
			}
		});
		if(rowIndex != -1){
			deliveryList[rowIndex].deliveryTime = deliveryDate;
			$("#table-delivery").find("tr").eq(rowIndex).find("input[name='purchaseDeliveryPlanList[][deliveryTime]']").val(deliveryDate);
			deliveryList[rowIndex].deliveryQuantity = quantity;
			$("#table-delivery").find("tr").eq(rowIndex).find("input[name='purchaseDeliveryPlanList[][deliveryQuantity]']").val(quantity);
		}
	});
}

function checkItemIsDeleted(){
	$("#table-item").find("tr").each(function(index,val){
		var itemData = $(this).data("item");
		if (itemData.deleteFlag && itemData.deleteFlag=="X") {
			//该行对应的所有交货计划不能编辑
			var orderItemNumber = itemData.orderItemNumber;
			$("#table-delivery").find("tr").each(function(i,val){
				var planOrderItemNumber = $(this).find("input[name='purchaseDeliveryPlanList[][orderItemNumber]']").val();
				if(orderItemNumber == planOrderItemNumber){
					$(this).find("input").each(function(){
						$(this).attr("readOnly",true);
					});
					$(this).find("select").each(function(){
						$(this).attr("disabled",true);
					});
					$(this).find(".Wdate").each(function(){
						$(this).removeAttr("onfocus");
					});
				}
			});
		}
	});
}

function checkDeliveryPlanTrs(){
	$("#table-item").find("tr").each(function(index,val){
		var temp = 0;
		var orderItemNumber = $(this).find("input[name='purchaseOrderItemList[][orderItemNumber]']").val();
		var $deliveryDate = $(this).find("input[name='purchaseOrderItemList[][deliveryDate]']");
		var $quantity = $(this).find("input[name='purchaseOrderItemList[][quantity]']");
		$("#table-delivery").find("tr").each(function(i,val){
			var planOrderItemNumber = $(this).find("input[name='purchaseDeliveryPlanList[][orderItemNumber]']").val();
			if(orderItemNumber == planOrderItemNumber){
				temp = temp + 1;
				if(temp > 1){
					$deliveryDate.attr("readOnly",true);
					$deliveryDate.removeAttr("onfocus");
					$quantity.attr("readOnly",true);
					return false;
				}
			}
		});
	});
}
//交货计划自动创建 
function autoCreateDeliveryPlans(){
	$("#table-item").find("tr").each(function(index,val){
		var temp = 0;
		var orderItemNumber = $(this).find("input[name='purchaseOrderItemList[][orderItemNumber]']").val();
		var deliveryDate = $(this).find("input[name='purchaseOrderItemList[][deliveryDate]']").val();
		var quantity = $(this).find("input[name='purchaseOrderItemList[][quantity]']").val();
		$("#table-delivery").find("tr").each(function(i,val){
			var planOrderItemNumber = $(this).find("input[name='purchaseDeliveryPlanList[][orderItemNumber]']").val();
			if(planOrderItemNumber && orderItemNumber == planOrderItemNumber){
				temp = temp + 1;
				if(temp > 0)
					return false;
			}
		});
		if(temp == 0){
			//添加一行
			var newRow = $.extend({}, blankDeliveryRow);
			newRow.orderDeliveryItem = 1;
			newRow.gridValue = 1;
			newRow.orderItemNumber = orderItemNumber;
			if(deliveryDate != '')
				newRow.deliveryTime = deliveryDate;
			if(quantity == '')
				quantity = 0.00;
			newRow.deliveryQuantity = quantity;
			newRow.purchaseDeliveryTimePlan = newRow.deliveryTime;
			newRow.purchaseDeliveryQuantityPlan = newRow.deliveryQuantity;
			deliveryGrid.addRow(newRow,deliveryGrid.rowsLength());
			bindDeliveryEvent();
		}
	});
	getDeliveryItem();
}

//如果是新建采购订单，被标记为删除的行将不会插入到数据库
function deleteSomeRows(){
	var array=[];
	$("#table-item").find("tr").each(function(index,val){
		var deleteFlag = $(this).find("input[name='purchaseOrderItemList[][deleteFlag]']").val();
		if(deleteFlag && deleteFlag == "X"){
			array.push(index);
		}
	});
	itemGrid.removeRow(array);
}

//删除行
$("#deleteRow").click(function(){
	var indexs=itemGrid.selectedRowsIndex();
	console.log(indexs);
	if(indexs&&indexs.length>0){
		var paramData=JSON.stringify($("#purchaseOrderForm").serializeJSON());
		var itemData=itemGrid.rows();
		for(var i=0;i<indexs.length;i++){
			console.log(itemData[indexs[i]]);
			itemData[indexs[i]].deleteFlag="X";
		}
		$("#table-item .selected").find("input[name='purchaseOrderItemList[][deleteFlag]']").val("X");
		initModifyFiled(itemData);
		changeDelete($("#showDelete"));
	}else{
		alert("请选择要删除的行！",2);
	}
});

//删除行
$("#cancelDeleteRow").click(function(){
	var indexs=itemGrid.selectedRowsIndex();
	if(indexs&&indexs.length>0){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'确定取消删除标识？',closeEvent:function(){
			var paramData=JSON.stringify($("#purchaseOrderForm").serializeJSON());
			var itemData=itemGrid.rows();
			for(var i=0;i<indexs.length;i++){
				itemData[indexs[i]].deleteFlag=null;
				$("#table-item tr").eq(indexs[i]).attr("style","");
				//先取消该行所有不能编辑的状态
				$("#table-item").find("tr").eq(indexs[i]).find("input").each(function(){
					$(this).removeAttr("readOnly");
				});
				$("#table-item").find("tr").eq(indexs[i]).find(":checkbox").each(function(){
					$(this).removeAttr("disabled");
				});
				$("#table-item").find("tr").eq(indexs[i]).find("select").each(function(){
					$(this).removeAttr("disabled");
				});
				$("#table-item").find("tr").eq(indexs[i]).find(".Wdate").each(function(){
					$(".Wdate").attr("onfocus","WdatePicker()");
				});
				//取消该行对应的所有交货计划不能编辑的状态
				var orderItemNumber = itemData[indexs[i]].orderItemNumber;
				$("#table-delivery").find("tr").each(function(i,val){
					var planOrderItemNumber = $(this).find("input[name='purchaseDeliveryPlanList[][orderItemNumber]']").val();
					if(orderItemNumber == planOrderItemNumber){
						$(this).find("input").each(function(){
							$(this).removeAttr("readOnly");
						});
						$(this).find("select").each(function(){
							$(this).removeAttr("disabled");
						});
						$(this).find(".Wdate").each(function(){
							$(this).attr("onfocus","WdatePicker()");
						});
					}
				});
			}
			$("#table-item .selected").find("input[name='purchaseOrderItemList[][deleteFlag]']").val(null);
			$("#table-item .selected").find("input[name='purchaseOrderItemList[][deleteFlag]']").prev("span").html("");
			initModifyFiled(itemData);
			changeDelete($("#showDelete"));
			//还原之前的是否可编辑状态
			itemControl();
			deliveryControl();
		}});
	}else{
		alert("请选择要取消删除的行！",2);
	}
});

function itemControl(){
	if ((flowCode != "" && flowCode != "00" && auditStatus == "2")) {
		$("#table-item").find("input").each(function(){
			if(!$(this).hasClass("mmg-check")) {
				$(this).attr("readOnly",true);
			}
		});
		$("#table-item").find("select").each(function(){
			$(this).attr("disabled",true);
		});
		$("#table-item").find(".Wdate").each(function(){
			$(".Wdate").removeAttr("onfocus");
		});
	}else if (orderType != "ELS"&&orderType != "样品") {
		disEditSomeCols();
	}
	//汇洁需求:控制某些列不能修改
	if(orderSendStatus != "0" || orderStatus != "0")
		disEditSomeCols();
}

function deliveryControl(){
	if ((flowCode != "" && flowCode != "00" && auditStatus == "2") || deliveryStatus == "3") {
		$("#table-delivery").find("input").each(function(){
			$(this).attr("readOnly",true);
		});
		$("#table-delivery").find("select").each(function(){
			$(this).attr("disabled",true);
		});
		$("#table-delivery").find(".Wdate").each(function(){
			$(this).removeAttr("onfocus");
		});
	}
	checkDeliveryPlanTrs();
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