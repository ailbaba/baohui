<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative  ">
    
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            <div class="dis-in-b input-and-tip">
                <button id="confirmBtn" class="button-wrap"><i18n:I18n key="i18n_delivery_title_refundconfirm" defaultValue="确认退货" /></button>
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
            </div>
        </div>
    
       <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/MaterialVoucherService/queryRefundOrderList">
            	<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount}"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount" value="${elsSubAccount}"/>
            	<input type="hidden" id="mobileType" name="mobileType" value="653,651"/>
            	<%-- 查询时将会筛选出deliveryStatus不等于0的数据 --%>
            	<input type="hidden" id="deliveryStatus" name="deliveryStatus" value="0"/>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_items" defaultValue="行项目" /></span>
            <div class="common-box-line">
            <button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
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
var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="refundConfirmOrderManage"/>;
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="refundConfirmOrderItem"/>;
$().ready(function(){
	init();
});
function init() {
	//初始化控件
    
    //$( "#sheet-project").tabs();
	changeDateArea();
    $("[name=dateArea]").click(changeDateArea);
    //订单头列表
    var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
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
//	var elsAccount = $("#elsAccount").val();
// 	var toElsAccount = $("#toElsAccount").val();
//  var toElsAccount = $("#toElsAccount").val();
	var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":653};
	$.ajax({
		url : "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherItem",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
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
	headGrid.opts.params = frm.serializeJSON();
	headGrid.load({});
}

//确认退货
$("#confirmBtn").click(function(){
	if (!materialVoucherNumber || materialVoucherNumber == "") {
		alert("<i18n:I18n key='i18n_refund_noitemstoconfirm' defaultValue='没有可确认退货的项目！' />",2);
		return;
	}
	var selectedRow = headGrid.selectedRows()[0];
	if(selectedRow.deliveryStatus == 2){
		alert("<i18n:I18n key='i18n_refund_cantconfirmtwice' defaultValue='请勿重复确认退货！' />",2);
		return;
	}
    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_refundconfirm" defaultValue="您确定要确认退货吗？" />',closeEvent:function(){
    	confirmRefund();
	}});
});

function confirmRefund(){
	var selectedRow = headGrid.selectedRows()[0];
	var mobileType = selectedRow.mobileType;
    var paramStr='{"elsAccount":"'+ elsAccount+ '","elsSubAccount":"'+ elsSubAccount+ '","companyShortName":"'+ companyShortName+ '","materialVoucherNumber":"'+ materialVoucherNumber+ '","mobileType":"'+ mobileType+ '"}';
    parent.elsDeskTop.showLoading();
    $.ajax({
		url : "<%=basePath%>rest/MaterialVoucherService/confirmRefundMaterialVoucher",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data : paramStr,
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
		parent.elsDeskTop.closeCurWin('refundConfirmOrderManage',closeCallback);
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