<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative  ">
    
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            <div class="dis-in-b input-and-tip">
                <button id="confirmBtn" class="button-wrap"><i18n:I18n key="i18n_bomvoucher_title_refundconfirm" defaultValue="确认退料收货" /></button>
<%--            <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
            </div>
        </div>
    
       <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/BomVoucherService/queryRefundBomList">
            	<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount}"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount" value="${elsSubAccount}"/>
            	<input type="hidden" id="mobileType" name="mobileType" value="542"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_saleOrderNumber" defaultValue="销售订单号" />：</span><input name="saleOrderNumber" type="text"/></div>
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="物料凭证号" />： </span><input id="materialVoucherNumber" name="materialVoucherNumber" type="text"/></div>
            	<br><div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_voucherdate" defaultValue="凭证日期" />：</span></div>
                <input type="radio" name="dateArea" value="week" checked><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" /><input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" /><input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" /><input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate"/></div>
                <div class="dis-in-b input-and-tip" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate" /></div>
            	<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_bomvoucher_lable_header" defaultValue="退料凭证抬头" /></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_items" defaultValue="行项目" /></span>
            <div class="common-box-line">
<%--             <button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
                  <main class="grid-container">
		               <div class="grid-100">
		                  <table id="table-item"></table>
		               </div>
		          </main>
            </div>
        </div>
    </div>
<script type="text/javascript">
var headGrid;
var itemGrid;
var materialVoucherNumber;
//列
var cols = [   {"title":"ELS号","name":"elsAccount","align":"center","width":120,"hidden":true},
               {"title":"销售方ELS号","name":"toElsAccount","align":"center","width":120,"sortable":true},
               {"title":"销售方公司名称","name":"companyShortName","align":"center","width":154},
               {"title":"物料凭证编号","name":"materialVoucherNumber","align":"center","width":130,"sortable":true},
			   {"title":"物料凭证年度","name":"voucherYear","align":"center","width":100,"sortable":true},
			   {"title":"凭证日期","name":"voucherDate","align":"center","width":100,"sortable":true, renderer:function(val){
                   if (!val) {val = "";}
                   else{
                	   val = new Date(val).format("yyyy-MM-dd");
                   }
                   return val; 
               }},
			   {"title":"过账日期","name":"postDate","align":"center","width":100,"sortable":true, renderer:function(val){
                   if (!val) {val = "";}
                   else{
                	   val = new Date(val).format("yyyy-MM-dd");
                   }
                   return val; 
               }},
			   {"title":"发货状态","name":"deliveryStatus","align":"center","width":110,"sortable":true, renderer:function(val){
                   var showText = "退料发货在途";
                   if (val == '2')
                	   showText = "退料已收货";
                   return showText; 
               }},
			   {"title":"移动类型","name":"mobileType","align":"center","width":110,"sortable":true, renderer:function(val){
                   return "退料收货"; 
               }},
			   {"title":"采购方负责人","name":"purchaseInCharge","align":"center","width":100,"sortable":true},
			   {"title":"销售方负责人","name":"saleInCharge","align":"center","width":100,"sortable":true},
			   {"title":"采购方备注","name":"purchaseRemark","align":"center","width":110,"sortable":true},
			   {"title":"销售方备注","name":"saleRemark","align":"center","width":110,"sortable":true},
			   {"title":"销售方物料凭证编号","name":"toMaterialVoucherNumber","align":"center","width":140,"sortable":true},
			   {"title":"时间戳","name":"logtime","align":"center","width":140,"sortable":true, renderer:function(val){
                   if (!val) {val = "";}
                   else{
                	   val = new Date(val).format("yyyy-MM-dd hh:mm:ss");
                   }
                   return val; 
               }}
		   ];
		   
var cols_item = [  {"title":"ELS号","name":"elsAccount","align":"center","width":120,"hidden":true},
                   {"title":"销售方ELS号","name":"toElsAccount","align":"center","width":120,"sortable":true},
                   {"title":"物料凭证编号","name":"materialVoucherNumber","align":"center","width":130},
				   {"title":"物料凭证行项目编号","name":"materialVoucherItemNumber","align":"center","width":140},
				   {"title":"物料凭证年度","name":"voucherYear","align":"center","width":100},
				   {"title":"时间戳","name":"logtime","align":"center","width":140, renderer:function(val){
	                   if (!val) {val = "";}
	                   else{
	                	   val = new Date(val).format("yyyy-MM-dd hh:mm:ss");
	                   }
	                   return val; 
	               }},
				   {"title":"移动类型","name":"mobileType","align":"center","width":110, renderer:function(val){
	                   return "退料收货"; 
	               }},
				   {"title":"销售订单号","name":"saleOrderNumber","align":"center","width":154},
				   {"title":"订单行项目编号","name":"orderItemNumber","align":"center","width":100},
				   {"title":"订单批次","name":"orderBatch","align":"center","width":80},
				   {"title":"数量","name":"wesbs","align":"center","width":100},
				   {"title":"度量单位","name":"unitMeasure","align":"center","width":100},
				   {"title":"销售方物料凭证编号","name":"referMaterialVoucherNumber","align":"center","width":140},
				   {"title":"采购订单号","name":"purchaseOrderNumber","align":"center","width":154},
				   {"title":"采购方材料号","name":"purchaseMaterialNumber","align":"center","width":100},
				   {"title":"采购方材描述","name":"purchaseMaterialDesc","align":"center","width":110},
/* 				   {"title":"采购方物料品牌","name":"purchaseAttr1","align":"center","width":154},
				   {"title":"采购方物料颜色","name":"purchaseAttr2","align":"center","width":154},
				   {"title":"采购方物料长度","name":"purchaseAttr3","align":"center","width":154},
				   {"title":"采购方物料宽度","name":"purchaseAttr4","align":"center","width":154},
				   {"title":"采购方物料高度","name":"purchaseAttr5","align":"center","width":154}, */
				   {"title":"采购方收货工厂","name":"purchaseFactory","align":"center","width":110},
				   {"title":"销售方出货工厂","name":"saleFactory","align":"center","width":110},
				   {"title":"销售方材料号","name":"saleMaterialNumber","align":"center","width":120},
				   {"title":"销售方材料描述","name":"saleMaterialDesc","align":"center","width":110},
/* 				   {"title":"销售方物料品牌","name":"saleAttr1","align":"center","width":154},
				   {"title":"销售方物料颜色","name":"saleAttr2","align":"center","width":154},
				   {"title":"销售方物料长度","name":"saleAttr3","align":"center","width":154},
				   {"title":"销售方物料宽度","name":"saleAttr4","align":"center","width":154},
				   {"title":"销售方物料高度","name":"saleAttr5","align":"center","width":154}, */
				   {"title":"备注","name":"fbk13","align":"center","width":110}];

$().ready(function(){
	init();
});
function init() {
	//初始化控件
	changeDateArea();
    $("[name=dateArea]").click(changeDateArea);
    //订单头列表
    var frm = $("#queryForm");
    headGrid = $('#table-head').mmGrid({
        cols: cols,
        url : frm[0].action,
        params: frm.serializeJSON(),
        method:  frm[0].method,
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol:true,
        remoteSort:true,
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
                , limitList: [10,20]
            })
        ]
    });
    // 加载明细项
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	materialVoucherNumber = item.materialVoucherNumber;
    	loadItem();
    });
    headGrid.on('loadSuccess',function(e, data) {
    	if (!itemGrid) {
    	    itemGrid = $('#table-item').mmGrid({
    	        cols: cols_item,
    	        items: []
    	    });
    	}
    	if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			headGrid.select(0);
			materialVoucherNumber = data.rows[0].materialVoucherNumber;
			loadItem();
		}
    });
    $("#queryBtn").click(function(){
    	query();
    });
}

function loadItem() {
	var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":"542"};
	$.ajax({
		url : "<%=basePath%>rest/BomVoucherService/findBomVoucherItem",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
			itemGrid.load(data);
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
	headGrid.opts.params = frm.serializeJSON();
	headGrid.load({});
}

//确认退货
$("#confirmBtn").click(function(){
	if (!materialVoucherNumber || materialVoucherNumber == "") {
		alert("<i18n:I18n key='i18n_bomvoucher_noitemstoconfirm' defaultValue='没有可确认收货的项目！' />",2);
		return;
	}
	var selectedRow = headGrid.selectedRows()[0];
	if(selectedRow.deliveryStatus == 2 || selectedRow.deliveryStatus == "退料已收货"){
		alert("<i18n:I18n key='i18n_bomvoucher_cantconfirmtwice' defaultValue='请勿重复确认收货！' />",2);
		return;
	}
    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_refundbom" defaultValue="您确定要确认收货吗？" />',closeEvent:function(){
    	confirmRefund();
	}});
});

function confirmRefund(){
	var selectedRow = headGrid.selectedRows()[0];
	var toElsAccount = selectedRow.toElsAccount;
	var toMaterialVoucherNumber = selectedRow.toMaterialVoucherNumber;
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"materialVoucherNumber":materialVoucherNumber,
			"toMaterialVoucherNumber":toMaterialVoucherNumber,"mobileType":"542"};
    parent.elsDeskTop.showLoading();
    $.ajax({
		url : "<%=basePath%>rest/BomVoucherService/confirmRefundBomVoucher",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			query();
			alert("<i18n:I18n key='i18n_refund_confirmsuccess' defaultValue='确认退货成功！' />");
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
//退出
$("#exitBtn").click(function(){
	if (winId) {
		parent.elsDeskTop.closeCurWin(winId,closeCallback);
	} else {
		parent.elsDeskTop.closeCurWin('confirmRefundBomManage',closeCallback);
	}
});
function getDate(dates){
	var dd = new Date();
	dd.setDate(dd.getDate()+dates);
	return dd.format("yyyy-MM-dd");
}
function changeDateArea() {
	var dateArea = $("[name=dateArea]:checked").val();
	if (dateArea == "define") {
		$("#startOrderDate").val("");
		$("#endOrderDate").val("");
		$("#startOrderDate").parent().show();
		$("#endOrderDate").parent().show();
	} else {
		$("#startOrderDate").parent().hide();
		$("#endOrderDate").parent().hide();
		$("#endOrderDate").val(new Date().format("yyyy-MM-dd"));
		var startOrderDate = "";
		if (dateArea == "week") {
			startOrderDate = getDate(-7);
		} else if (dateArea == "month") {
			startOrderDate = getDate(-30);
		} else if (dateArea == "threeMonth") {
			startOrderDate = getDate(-90);
		}
		$("#startOrderDate").val(startOrderDate);
	}
}
function closeCallback() {
//		if (parent.frames["iframeApp_queryReceipt"]) {
//			parent.frames["iframeApp_queryReceipt"].insertMaterialVoucherHeaderTable();
//		}
}
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=refundConfirmOrderManage" + "&window=iframeApp_refundConfirmOrderManage",
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
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=refundConfirmOrderItem" + "&window=iframeApp_refundConfirmOrderManage",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	});
	});
</script>
</body>
</html>