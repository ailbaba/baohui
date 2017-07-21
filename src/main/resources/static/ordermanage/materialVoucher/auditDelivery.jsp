<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String businessElsAccount = request.getParameter("businessElsAccount");
String materialVoucherNumber = request.getParameter("materialVoucherNumber");
%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<script type="text/javascript">
var hasRight = false;
</script>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="headColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<base:audit elsSubAccount="${elsSubAccount }"
					businessElsAccount="${param.businessElsAccount }"
					businessId="${param.materialVoucherNumber }"
					elsAccount="${elsAccount }" businessType="delivery">
					<button id="passBtn" class="button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
					<button id="noPassBtn" class="button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
					<script type="text/javascript">
				hasRight = true;
				</script>
				</base:audit>
				<button id="cancelBtn" class="done button-wrap" style="display:none"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
				<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	<form id="auditForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="elsAccount" value="${elsAccount }">
		<input type="hidden" name="elsSubAccount" value="${elsSubAccount }">
		<input type="hidden" name="businessElsAccount" value="<%=businessElsAccount%>">
		<input type="hidden" name="materialVoucherNumber" value="<%=materialVoucherNumber%>">
		<input type="hidden" name="itemIds" id="itemIds"/> 
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_deliveryorderhead" defaultValue="发货单抬头" /></span>
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
			<div class="tab-wrap" id="sheet-project">
				<ul>
					<li><a href="#sheet-project-one"><i18n:I18n key="i18n_delivery_lable_deliveryorderitems" defaultValue="发货单行项目" /></a></li>
					<li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
				</ul>
				<div id="sheet-project-one">
					<div class="common-box-line">
						<div class="edit-box-wrap">
							<button id="columnDefineBtn" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
							<base:auditConfig elsAccount="${param.businessElsAccount }"
								businessType="delivery" type="item">
									<button id="itemPassBtn" style="display:none" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_button_pass" defaultValue="通过" /></button>
									<button id="itemNoPassBtn" style="display:none" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_button_notpass" defaultValue="不通过" /></button>
							</base:auditConfig>
						</div>
						<main class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
						</div>
						</main>
					</div>
				</div>
				<div id="sheet-project-two">
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
<!-- 										<div class="dis-in-b text-right"> -->
<!-- 											<button id="btnDownloadFile" class="button-wrap">下载文件</button> -->
<!-- 											<button id="btnViewFile" class="button-wrap">在线预览文件</button> -->
<!-- 																					<button class="button-wrap" id="sendForm">发送表单文件</button> -->
<!-- 										</div> -->
									</div>
									<div class="file-display" id="file-display">
										<a id="viewerPlaceHolder"></a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="fixed-dialog">
		<div class="dialog-tip">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" /> <span
					id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div class="mt-40">
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件分类" />：</span> <select id="operTypeSelector"
								onchange="loadOrderItem()">
								<option value="0"><i18n:I18n key="i18n_common_select_bymaterialheader" defaultValue="按凭证头" /></option>
								<option value="1"><i18n:I18n key="i18n_common_select_bymaterialitem" defaultValue="按凭证行" /></option>
							</select>
						</div>
						<div id="divOrderItem" class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="请选择行项目" />：</span> <select id="orderItemSelector"
								name="orderItemNumber">
							</select>
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span><input id="fileName" name="fileName"
								type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /></div></span>
							<input id="filePath" name="filePath" type="hidden" />
						</div>
						<input id="fileType" name="fileType" type="hidden" />
					</div>
					<div class="mt-40">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	//列
	var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="deliveryHead"/>;
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editDelivery"/>;
	var blankRow;
	var itemGrid;
	var headGrid;
	var itemData;
	var fileGrid;
	var formId;
	var fileName;
	var mobileType;
	var fileStatus;
	var fileUploader;
	var orderItemNumber;
	var businessElsAccount = "<%=businessElsAccount%>";
	var isTemp = true;
	var height = $(document).height() - 245;
	$().ready(function() {
		init();
	    initFileGrid();
	});
	var materialVoucherNumber = "<%=request.getParameter("materialVoucherNumber")%>";
if (materialVoucherNumber == "null") {
	materialVoucherNumber = "";
}
var deliveryStatus = "<%=request.getParameter("deliveryStatus")%>";
if (deliveryStatus != "0" && deliveryStatus != "null") {
	isTemp = false;
}
var selectedItems = "<%=request.getParameter("selectedItems")%>";
function closeCallback() {
	if (parent.frames["iframeApp_deliveryManage"]) {
		parent.frames["iframeApp_deliveryManage"].query();
	}
}
function checkFree() {
	$(".isFree").each(function(){
		var saleOrderNumber = $(this).parent().parent().parent().data("item").saleOrderNumber;
		if (saleOrderNumber && saleOrderNumber != "")  {
			$(this).attr("checked",false);
		} else {
			$(this).attr("checked","checked");
		}
	});
}

init();

function init(){
	//初始化控件
    $("#sheet-project").tabs();
    
    $("#passBtn").click(function(){
		pass();
	});
	$("#noPassBtn").click(function(){
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
			parent.elsDeskTop.closeCurWin(winId,closeCallback);
		} else {
			parent.elsDeskTop.closeCurWin("auditRecord",closeCallback);
		}
	});
	if (materialVoucherNumber == "") {
		var data = {"elsAccount":elsAccount,"selectedItems":selectedItems};
		//根据行项目获取信息
		$.ajax({
    		url : "<%=basePath%>rest/MaterialVoucherService/getInfoFromSale",
    		type : "post",
    		contentType : "application/json",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			console.log(data);
    			itemData = data;
    			materialVoucherNumber = data.materialVoucherHeaderVO.materialVoucherNumber;
    			fillData(data);
    		},
    		error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
    		}
    	});
	} else {
		var url = "<%=basePath%>rest/MaterialVoucherService/getInfoFromTemp";
		if (!isTemp) {
			url = "<%=basePath%>rest/MaterialVoucherService/getInfo";
		}
		var data = {"elsAccount":businessElsAccount,"materialVoucherNumber":materialVoucherNumber};

		$.ajax({
    		url : url,
    		type : "post",
    		contentType : "application/json",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			itemData = data;
    			fillData(data);
    		},
    		error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
    		}
    	});
	} 
	
	 if (hasRight) {
	    	$("#itemPassBtn").show();
	    	$("#itemNoPassBtn").show();
	    	$("#itemPassBtn").click(function(){
	    		itemPass();
	    	});
			$("#itemNoPassBtn").click(function(){
	    		itemNoPass();
	    	});
	    }else{
	    	$("#cancelBtn").show();
	    }
}

function setReadOnly() {
	$("span input").not(":hidden").not(":checkbox").each(function(){
		$(this).parent().html($(this).val());
	});
}

function fillData(data){
	data.materialVoucherHeaderVO.mobileType=601;
	if (!data.materialVoucherHeaderVO.deliveryStatus) {
		data.materialVoucherHeaderVO.deliveryStatus="0";
	}
	$("#deliveryStatus").val(data.materialVoucherHeaderVO.deliveryStatus);
	var head = new Array();
	head.push(data.materialVoucherHeaderVO);
	if (!headGrid) {
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height:100,
	        items: head
	    });
	} else {
		headGrid.load(head);
	}
	headGrid.on('loadSuccess',function() {
		$("#table-head").find("input").not(":checkbox").each(function(){
			$(this).css("width",$(this).parent().parent().width()-15);
		});
		var materialVoucherNumber = headGrid.row(0).materialVoucherNumber;
		if(materialVoucherNumber != null && materialVoucherNumber != "")
			loadFileItem(materialVoucherNumber);
		setReadOnly();
	});
	if (!itemGrid) {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols,
	        checkCol:true,
	        height:height,
	        multiSelect: true,
	        items: data.materialVoucherItemList
	    });
	} else {
		itemGrid.load(data.materialVoucherItemList);
	}
	itemGrid.on('loadSuccess',function(e, d) {
		$("#table-item").find("input").not(":checkbox").each(function(){
			$(this).css("width",$(this).parent().parent().width()-15);
		});
		for (var i=0;i<data.materialVoucherItemList.length;i++) {
			if (data.materialVoucherItemList[i].saleOrderNumber == '') {
				var $tr = $("#table-item").find("tr").eq(i);
				var $purchaseMaterialNumber = $tr.find(".purchaseMaterialNumber");
				$purchaseMaterialNumber.show();
				$purchaseMaterialNumber.css("width",$purchaseMaterialNumber.parent().parent().width()-15);
				$purchaseMaterialNumber.prev("span").hide();
				var $purchaseMaterialDesc = $tr.find(".purchaseMaterialDesc");
				$purchaseMaterialDesc.show();
				$purchaseMaterialDesc.css("width",$purchaseMaterialDesc.parent().parent().width()-15);
				$purchaseMaterialDesc.prev("span").hide();
				
				var $saleMaterialNumber = $tr.find(".saleMaterialNumber");
				$saleMaterialNumber.show();
				$saleMaterialNumber.css("width",$saleMaterialNumber.parent().parent().width()-15);
				$saleMaterialNumber.prev("span").hide();
				var $saleMaterialDesc = $tr.find(".saleMaterialDesc");
				$saleMaterialDesc.show();
				$saleMaterialDesc.css("width",$saleMaterialDesc.parent().parent().width()-15);
				$saleMaterialDesc.prev("span").hide();
				$tr.find(".isFree").attr("checked","checked");
			}
		}
		setReadOnly();
		checkFree();
	});
}

$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editDelivery" + "&window=iframeApp_editDelivery",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
$("#headColumnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=deliveryHead" + "&window=iframeApp_editDelivery",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
var cols_file = [{ title:'id',name:'formId' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'materialVoucherItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialheader" defaultValue="凭证头文件" />';
	                	} else{
	                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialitem" defaultValue="凭证项文件" />';
	                	}
	                }},
                 { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="订单项编号" />',name:'materialVoucherItemNumber' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />',name:'filePath' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_delivery_lable_mobiletype" defaultValue="移动类型" />',name:'mobileType' ,width:200, align:'center',hidden:true},
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

function getOrderItem(){
	$("#orderItemSelector").empty();
	var html = "";
	var trs = $("#table-item").find("tr");
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		if (data.materialVoucherNumber != "") 
			html += "<option value='"+data.materialVoucherItemNumber+"'>" + data.materialVoucherItemNumber + "_" + data.saleMaterialDesc + "</option>";
	}
	$("#orderItemSelector").append(html);
	
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

function initFileGrid(){
	if(!fileGrid){
		fileGrid = $('#table-file').mmGrid({
	        cols: cols_file,
	        items: [],
	        checkCol: true
	    });
	}
}
function loadFileItem(materialVoucherNumber){
	var data = {"elsAccount":businessElsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":"601"};
		$.ajax({
			url :"<%=basePath%>rest/MaterialFormFileService/findMaterialFormFile",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(data),
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

$('.dialog-close-btn').click(function(){
    $('.fixed-dialog').hide();
});
$('.tip-option-btn').click(function(){
    $('.dialog-close-btn').trigger('click');
});

function cancel() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditcancel" defaultValue="确认要撤销审批吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/cancelAudit",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				if (data.status == "401") {
    					alert("<i18n:I18n key='i18n_audit_overcantcancel' defaultValue='流程结束的单据不能撤销审批' />",3);
				    }else if (data.status == "403") {
				    	alert("<i18n:I18n key='i18n_audit_higherlevelcando' defaultValue='只有上一级处理人才能撤销审批' />",3);
				    }else {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				    }
    			}
			}
		});
	}});
}

function pass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/sendPurchaseOrderPass",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
/* 				if (data.statusCode != "200") {
					alert(data.message,3);
					return;
				} */
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				if (data.status == "401") {
    					alert("<i18n:I18n key='i18n_audit_afteritemsallpass' defaultValue='订单行项目未全部通过不能审批通过' />",2);
				    }else if (data.status == "403") {
				    	alert("<i18n:I18n key='i18n_audit_noauthority' defaultValue='没有审批权限' />",2);
				    }else {
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
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/sendPurchaseOrderNoPass",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
/* 				if (data.statusCode != "200") {
					alert(data.message,3);
					return;
				} */
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
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
function itemPass() {
	var allRows=itemGrid.rows();
	var rows = itemGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key='i18n_refund_chooseitem' defaultValue='请选择行项目' />",2);
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
		url :"<%=basePath%>rest/MaterialVoucherService/itemPass",
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
		alert("<i18n:I18n key='i18n_refund_chooseitem' defaultValue='请选择行项目' />",2);
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
		url :"<%=basePath%>rest/MaterialVoucherService/itemNoPass",
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
		json[rows[i].materialVoucherItemNumber]="1";
	}
	console.log(allRows.length);
	for(var i=0;i<allRows.length;i++){
		var materialVoucherItemNumber=allRows[i].materialVoucherItemNumber;
		console.log(materialVoucherItemNumber+"  "+json[orderItemNumber]);
		if(json[materialVoucherItemNumber]=="1"){
			allRows[i].auditStatus=status;
		}
	}
	itemGrid.load(allRows);
}


function flow() {
	var targetElsAccount = "${param.businessElsAccount }";
	var businessType = "delivery";
	var businessId = "${param.purchaseOrderNumber }";
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+materialVoucherNumber,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
}

function closeCallback() {
	if (parent.frames["iframeApp_auditList"]) {
		parent.frames["iframeApp_auditList"].query();
	}
}
	</script>
</body>
</html>