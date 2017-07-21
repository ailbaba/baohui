<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative ">
    	<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            	<button class="button-wrap" id="btnMESImport"><i18n:I18n key="test" defaultValue="从MES获取" /></button>
<%--                 <button id="editBtn" class="button-wrap"><i18n:I18n key="i18n_delivery_lable_editdeliveryorder" defaultValue="修改发货" /></button> --%>
                <button id="sendBtn" class="button-wrap" style="display:none"><i18n:I18n key="i18n_delivery_lable_senddeliveryorder" defaultValue="发货" /></button>
                <button id="printBtn" class="button-wrap"><i18n:I18n key="i18n_button_print" defaultValue="打印" /></button>
<%--                 <button id="deleteBtn" class="button-wrap"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button> --%>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
                <button  id="columnDefineBtn" class="button-wrap">头<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="itemColumnDefineBtn" class="button-wrap">行<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form style="margin:0;" id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/MaterialVoucherService/queryDelivery">
            	<input type="hidden" name="companyShortName" value="<%=session.getAttribute("companyShortName")%>"/>
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
            <div class="common-box-line">
                <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_saleOrderNumber" defaultValue="销售订单号" />：</span><input id="saleOrderNumber" name="saleOrderNumber" type="text"/></div>
                <div class="dis-in-b"><span><i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="物料凭证号" />: </span><input type="text" id="materialVoucherNumber" name="materialVoucherNumber"/></div>
                <div class="dis-in-b"><span>采购订单号: </span><input type="text" id="purchaseOrderNumber" name="purchaseOrderNumber"/></div>
                <div class="dis-in-b"><span>客户ELS号: </span><input type="text" id="toElsAccount" name="toElsAccount"/></div>
                <div class="dis-in-b"><span><i18n:I18n key="i18n_delivery_lable_deliverystatus" defaultValue="发货状态" />: </span>
                	<select id="deliveryStatus" name="deliveryStatus">
                		<option value="0"><i18n:I18n key="i18n_delivery_select_notdeliver" defaultValue="未发货" /></option>
                		<option value="1"><i18n:I18n key="i18n_delivery_select_deliveronway" defaultValue="发货在途" /></option>
                		<option value="2"><i18n:I18n key="i18n_delivery_select_allreceipt" defaultValue="全部收货" /></option>
                		<option value="4"><i18n:I18n key="i18n_delivery_select_partreceipt" defaultValue="部分收货" /></option>
                		<option value="3"><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
                	</select>
                </div>
            	<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            	
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_header" defaultValue="物料凭证抬头" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
        <div class="tab-wrap" id="sheet-project">
			<ul>
				<li><a href="#sheet-project-one"><i18n:I18n key="i18n_delivery_lable_items" defaultValue="行项目" /></a></li>
				<li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
			</ul>
			<div id="sheet-project-one" style="padding: 2px;">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                    </div>
                </main>
            </div>
				<div id="sheet-project-two" style="padding: 2px;">
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
									<div class="dis-in-b text-left">
										<button id="btnAddFile" class="button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button>
										<button id="btnModifyFile" class="button-wrap"><i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改文件" /></button>
										<button id="btnDeleteFile" class="button-wrap"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button>
									</div>
									<div class="dis-in-b text-right">
										<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
										<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
<!-- 									<button class="button-wrap" id="sendForm">发送表单文件</button> -->
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
    </div>
    	<div class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" /> <span id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
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
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
var headGrid;
var itemGrid;
var fileGrid;
var formId;
var fileName;
var mobileType;
var fileStatus;
var fileUploader;
var printData ={};
var orderItemNumber;
$().ready(function(){
	init();
});
var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="deliveryManage_head_mt"/>;
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="deliveryManage_item_mt"/>;
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
                 }},
                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
	                  	if (val == elsAccount) {
	                 		return '<i18n:I18n key="i18n_label_self" defaultValue="已方" />';
	                 	} else {
	                 		return '<i18n:I18n key="i18n_label_otherSide" defaultValue="对方" />';
	                 	} 
	            }}
             ];
function init() {
	isDisplayIntefaceButton();
	//初始化控件
    $("#deliveryStatus").val("1");
    $("#sheet-project").tabs();
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId);
		} else {
			parent.elsDeskTop.closeCurWin("deliveryManage");
		}
	});
	$("#queryBtn").click(function(){
		query();
	});
	$("#editBtn").click(function(){
		editDelivery();
	});
	$("#sendBtn").click(function(){
		sendDelivery();
	});
	$("#deleteBtn").click(function(){
		deleteDelivery();
	});
	$("#btnMESImport").click(function(){
		getSaleDelivery();
	});
	
    //订单头列表
    var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	headGrid = $('#table-head').mmGrid({
        cols: cols,
        url : frm[0].action,
        params: frm.serializeJSON(),
        method:  frm[0].method,
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        remoteSort:true,
        checkCol:true,
        plugins: [
            $('#pg').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                , limit:null
                , limitList: [100,50,30,10]
            })
        ]
    });
	headGrid.on('loadSuccess',function(e, data) {
    	if (!itemGrid) {
    	    itemGrid = $('#table-item').mmGrid({
    	        cols: cols_item,
    	        remoteSort:true,
    	        items: []
    	    });
    	}
    	if(!fileGrid) {
       		fileGrid = $('#table-file').mmGrid({
       	        cols: cols_file,
       	        items: [],
       	        checkCol: true
       	    });
    	}
    	if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			headGrid.select(0);
			$('body').data('selectHead',headGrid.selectedRows());
			loadItem(data.rows[0].materialVoucherNumber,data.rows[0].deliveryStatus);
			//初始化表单文件列表
			initFileTable(data.rows[0].materialVoucherNumber);
		}
    });
	// 加载明细项
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	$('body').data('selectHead',headGrid.selectedRows());
    	loadItem(item.materialVoucherNumber,item.deliveryStatus);
		//初始化表单文件列表
		initFileTable(item.materialVoucherNumber);
    });
    /**
     * 打印
     */
    $('#printBtn').click(function () {
	    var bodyData = $('body').data();
	    var rowsData = (bodyData['findDeliveryItem'] || {}).rows||[];
	    var selH = bodyData['selectHead'];
	    var datas=[];
	    selH.forEach(function (d) {
		    var _ds = d.purchaseOrderNumberList.map(function(p){
			    return $.extend(true,{},d,{purchaseOrderNumber:p})
		    });
		    [].push.apply(datas,_ds);
	    });
	    datas.forEach(function(d){
			var rows = [];
		    rowsData.forEach(function (r) {
			    if (-1!==d.purchaseOrderNumber.indexOf(r.purchaseOrderNumber)) {
				    var mixData = $.extend(true, {}, d, r);
				    rows.push(mixData);
			    }
		    });
		    d.rows = rows;
	    });
	    //存储打印需要的数据
	    parent.elsDeskTop.defineWin({
		    'iconSrc': 'icon/els-icon.png',
		    'windowsId': 'ePrintTemplatesManager',
		    'windowTitle': '<i18n:I18n key="i18n_windowtitle_orderprint" defaultValue="订单打印" />',
		    'iframSrc': '<%=basePath%>ePrintTemplatesManager.jsp',
		    'windowStatus': 'maximized',
		    'windowMinWidth': 960,
		    'windowMinHeight': 700,
		    'windowWidth': 960,
		    'windowHeight': 700,
		    'parentPanel': ".currDesktop",
		    data:datas
	    });
    });
}
function loadItem(materialVoucherNumber,deliveryStatus){
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"materialVoucherNumber":materialVoucherNumber,"deliveryStatus":deliveryStatus};

	$.ajax({
		url : "<%=basePath%>rest/MaterialVoucherService/findDeliveryItem",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			$('body').data('findDeliveryItem',data);
			itemGrid.load(data.rows);
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function query() {
	var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#queryForm");
	headGrid.opts.params = frm.serializeJSON();
	headGrid.load({});
}
function editDelivery() {
	var rows = headGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key='i18n_delivery_choosematerialvoucherplease' defaultValue='请选择物料凭证' />",2);
		return;
	}
	var materialVoucherNumber = rows[0].materialVoucherNumber;
	var deliveryStatus = rows[0].deliveryStatus;
	var toElsAccount = rows[0].toElsAccount;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editDelivery',
        'windowTitle':'<i18n:I18n key="i18n_delivery_lable_createdelivery" defaultValue="新建发货单" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>ordermanage/materialVoucher/editDelivery.jsp?toElsAccount='+toElsAccount+'&materialVoucherNumber=' + materialVoucherNumber + "&deliveryStatus=" +deliveryStatus,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function sendDelivery() {
	var rows = headGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key='i18n_delivery_choosematerialvoucherplease' defaultValue='请选择物料凭证' />",2);
		return;
	}
	var materialVoucherNumber = rows[0].materialVoucherNumber;
	var deliveryStatus = rows[0].deliveryStatus;
	var toElsAccount = rows[0].toElsAccount;
	if (deliveryStatus == "1") {
		alert("<i18n:I18n key='i18n_delivery_cannotdelivertwice' defaultValue='已发货的单据不能再次发货' />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_delivery_confirm_senddelivery" defaultValue="是否确认发货？" />',closeEvent:function(){
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"materialVoucherNumber":materialVoucherNumber,"deliveryStatus":deliveryStatus,"companyShortName":companyShortName};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialVoucherService/sendDeliveryByNumber",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data.statusCode != 200) {
				alert(data.message,2);
			} else {
				alert("<i18n:I18n key='i18n_delivery_deliversuccess' defaultValue='发货成功' />");
				query();
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key='i18n_delivery_deliverfail' defaultValue='发送出错' />",3);
		}
	});
	}});
}
function deleteDelivery() {
	var rows = headGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key='i18n_delivery_choosematerialvoucherplease' defaultValue='请选择物料凭证' />",2);
		return;
	}
	var materialVoucherNumber = rows[0].materialVoucherNumber;
	var deliveryStatus = rows[0].deliveryStatus;
	var toElsAccount = rows[0].toElsAccount;
	if (deliveryStatus == "1") {
		alert("<i18n:I18n key='i18n_delivery_cantdelete' defaultValue='已发货的单据不能删除' />",2);
		return;
	}

	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"materialVoucherNumber":materialVoucherNumber,"deliveryStatus":deliveryStatus};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialVoucherService/deleteDelivery",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key='i18n_common_alert_deletesuccess' defaultValue='删除成功' />");
			query();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key='i18n_delivery_deletefail' defaultValue='删除出错' />",3);
		}
	});
	}});
}


$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=deliveryManage_head_mt" + "&window=iframeApp_deliveryManage",
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
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=deliveryManage_item_mt" + "&window=iframeApp_deliveryManage",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
function initAddFileDialog(){
	$(".dialog-tip").height(240);
	$("#fileName").attr("readonly",false);
    $("#filePath").val(null);
    $("#fileType").val(null);
    $("#fileName").val(null);
    $("#operTypeSelector").val("0");
    $("#orderItemSelector").val(null);
    $("#divOrderItem").hide();
    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" />');
    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="上传文件" />');
    $("#btnFileOK").unbind("click");
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
		$(".dialog-tip").height(270);
		$("#divOrderItem").show();
		getOrderItem();
	}else{
		$(".dialog-tip").height(240);
		$("#divOrderItem").hide();
		$("#orderItemSelector").empty();
	}
}

function addFormFile(){
	var fileName = $("#fileName").val();
	if (!fileName) {
		alert("<i18n:I18n key='i18n_delivery_enterfilename' defaultValue='请填写文件名称' />",2);
		return;
	}
	var filePath = $("#filePath").val();
	if(!filePath){
		alert("<i18n:I18n key='i18n_delivery_uploadfileplease' defaultValue='请上传文件' />",2);
		return;
	}
	var indexs = headGrid.selectedRowsIndex();
	var materialVoucherNumber = headGrid.row(indexs[0]).materialVoucherNumber;
	var toElsAccount = headGrid.row(indexs[0]).toElsAccount;
	var isOrderItem = $("#operTypeSelector").val();
	var materialVoucherItemNumber = null;
	if(isOrderItem == 1)
		materialVoucherItemNumber = $("#orderItemSelector").val();
	var fileType = $("#fileType").val();
	var logtime = new Date();
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"mobileType":601,"fileStatus":0,"materialVoucherNumber":materialVoucherNumber,"materialVoucherItemNumber":materialVoucherItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialFormFileService/addMaterialFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data != null){
				fileGrid.addRow(data,fileGrid.rowsLength());
				$('.fixed-dialog').hide();
			}else{
				alert("<i18n:I18n key='i18n_delivery_filenameexist' defaultValue='该文件名已存在' />",2);
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
		alert("<i18n:I18n key='i18n_delivery_enterfilename' defaultValue='请填写文件名称' />",2);
		return;
	}
	var indexs = headGrid.selectedRowsIndex();
	var materialVoucherNumber = headGrid.row(indexs[0]).materialVoucherNumber;
	var toElsAccount = headGrid.row(indexs[0]).toElsAccount;
	var materialVoucherItemNumber = $("#orderItemSelector").val();
	var fileType = $("#fileType").val();
	var filePath = $("#filePath").val();
	var logtime = new Date();
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"formId":formId,"mobileType":mobileType,"fileStatus":fileStatus,"materialVoucherNumber":materialVoucherNumber,"materialVoucherItemNumber":materialVoucherItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialFormFileService/updateMaterialFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			var index = fileGrid.selectedRowsIndex()[0];
			fileGrid.updateRow(data,index);
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
function initFileTable(materialVoucherNumber){
	$("#divOrderItem").hide();
	var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":"601"};
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
$('#btnAddFile').click(function() {
	var materialVoucherNumber = headGrid.row(0).materialVoucherNumber; 
	if (materialVoucherNumber == "" || materialVoucherNumber == null) {
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_delivery_confirm_savedeliveryorderfirst" defaultValue="请先保存发货单！是否确认保存？" />',closeEvent:function(){
			$("#saveBtn").trigger("click");
		}});
	}else{
        $('.fixed-dialog').show();
        initAddFileDialog();
        initFileUploader(fileUploader);
	}
});
$('#btnModifyFile').click(function() {
	var selectedIndexs = fileGrid.selectedRowsIndex();
	if (selectedIndexs.length == 0) {
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
		return;
	}
	var selectedRow = fileGrid.row(selectedIndexs[0]);
	if(selectedRow.createBy != elsAccount){
		alert("<i18n:I18n key='i18n_delivery_cantmodifytofile' defaultValue='对方文件不能修改' />",2);
		return;
	}
	formId = selectedRow.formId;
	fileName = selectedRow.fileName;
	fileStatus = selectedRow.fileStatus;
	mobileType = selectedRow.mobileType;
	orderItemNumber = selectedRow.materialVoucherItemNumber;
    $('.fixed-dialog').show();
    initModifyFileDialog();
    initFileUploader(fileUploader);
});
$("#btnDeleteFile").click(function(){
	var selectedIndexs = fileGrid.selectedRowsIndex();
	if (selectedIndexs.length == 0) {
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
		return;
	}
	var selectedRow = fileGrid.row(selectedIndexs[0]);
	if(selectedRow.createBy != elsAccount){
		alert("<i18n:I18n key='i18n_delivery_cantdeletetofile' defaultValue='对方文件不能删除' />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
	var data = {"formId":selectedRow.formId,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialFormFileService/deleteMaterialFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			fileGrid.removeRow(selectedIndexs[0]);
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
$("#btnDownloadFile").click(function(){
	var selectedRows = fileGrid.selectedRows();
	if(selectedRows.length == 0){
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
		return;
	}
	window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + selectedRows[0].filePath;
});
$("#btnViewFile").click(function(){
	var selectedRows = fileGrid.selectedRows();
	if(selectedRows.length == 0){
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
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


//发送表单文件
$("#sendForm").click(function(){
	var selectedIndexs = fileGrid.selectedRowsIndex();
	if (selectedIndexs.length == 0) {
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
    	var selectedRow = fileGrid.row(selectedIndexs[0]);
    	formId = selectedRow.formId;
    	var paramStr='{"elsAccount":"'+ elsAccount+ '","companyShortName":"'+companyShortName+'","elsSubAccount":"'+ elsSubAccount+ '","formId":"'+ formId+ '"}';
    	parent.elsDeskTop.showLoading();
    	$.ajax({
    		url :"<%=basePath%>rest/SaleFormFileService/order/send",
										type : "post",
										contentType : "application/json",
										data : paramStr,
										dataType : "json",
										success : function(data) {
											parent.elsDeskTop.hideLoading();
											selectedRow.fileStatus = 1;
											fileGrid.updateRow(selectedRow,selectedIndexs[0]);
											alert("<i18n:I18n key='i18n_common_sendsuccess' defaultValue='发送成功' />");
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

//获取MES数据
function getSaleDelivery(){
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#queryForm");
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认MES导入？" />',closeEvent:function(){
		var btnMESImport = $("#btnMESImport");
		btnMESImport.empty().append('<span style="color: red;">同步中...</span>');
		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/getSaleDeliveryERP",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				if(data.statusCode=="-100"){
					alert(data.message,2);
				}else if(data.statusCode=="-200"){
					alert(data.message,3);
				}else{
					btnMESImport.empty().append('<span style="color: red;">获取数据成功</span>');
				}
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		});
	}});
}
//判断是否显隐接口按钮
function isDisplayIntefaceButton(){
	//批量获取erp订单按钮
	$.ajax({
		url :"<%=basePath%>rest/IntefaceService/isExit/" + elsAccount + "/GetDelivery",
		type :"get",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			if(data!=null&&data.statusCode=="-100"){
				//$("#btnMESImport").css("display","none");
			}else{
				//$("#btnMESImport").css("display","");
			}
		},
		error : function(data) {
//			if (!permissionError(data)) {
//				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
//			}
		}
	});
}

</script>
</body>
</html>