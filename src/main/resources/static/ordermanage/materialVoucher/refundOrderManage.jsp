<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative ">
    	<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            <div class="dis-in-b input-and-tip">
                <button id="addBtn" class="button-wrap"><i18n:I18n key="i18n_delivery_button_createrefund" defaultValue="新建退货" /></button>
                <button id="modifyBtn" class="button-wrap"><i18n:I18n key="i18n_delivery_button_updaterefund" defaultValue="修改退货" /></button>
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
                
<!--                 <button id="test" class="button-wrap">收货测试</button> -->
<!--                 <button id="test1" class="button-wrap">入库测试</button> -->
<!--                 <button id="test2" class="button-wrap">获取收货凭证</button> -->
<!--                 <button id="test3" class="button-wrap"> 测试统一接口</button> -->
            </div>
            </div>
        </div>
       <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/MaterialVoucherService/queryRefundOrderList">
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
            	<input type="hidden" id="mobileType" name="mobileType" value="122,161"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input id="purchaseOrderNumber" name="purchaseOrderNumber" type="text"/></div>
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
$().ready(function(){
	init();
});
//列
var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="refundOrderManage_mt"/>;
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="refundOrderItem_mt"/>;
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
    	materialVoucherNumber = item.materialVoucherNumber
    	var toElsAccount = item.toElsAccount;
    	var mobileType = item.mobileType;
    	loadItem(materialVoucherNumber,toElsAccount,mobileType);
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
			var toElsAccount = data.rows[0].toElsAccount;
			var mobileType = data.rows[0].mobileType;
			loadItem(materialVoucherNumber,toElsAccount,mobileType);
		}
    });
    $("#queryBtn").click(function(){
    	query();
    });
    $("#addBtn").click(function(){
    	insertRefundOrder();
    });
    $("#modifyBtn").click(function(){
    	modifyRefundOrder();
    });
}
function modifyRefundOrder(){
	var materialVoucherNumber = headGrid.selectedRows()[0].materialVoucherNumber;
	var toElsAccount = headGrid.selectedRows()[0].toElsAccount;
	if (!materialVoucherNumber) {
		alert("<i18n:I18n key='i18n_refund_chooseordertoupdate' defaultValue='请选择需修改的退货单！' />",2);
		return;
	}
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'modifyRefundOrder',
        'windowTitle':'<i18n:I18n key="i18n_delivery_button_updaterefund" defaultValue="修改退货" />',
        'iframSrc':'<%=basePath%>ordermanage/materialVoucher/editRefundOrder.jsp?materialVoucherNumber=' + materialVoucherNumber + '&toElsAccount=' + toElsAccount,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function insertRefundOrder(){
	var purchaseOrderNumber = $("#purchaseOrderNumber").val();
	var materialVoucherNumber = $("#materialVoucherNumber").val();
	if (!purchaseOrderNumber && !materialVoucherNumber) {
		alert("<i18n:I18n key='i18n_refund_pleaseenternumber' defaultValue='请输入需退货的采购订单号或者物料凭证号' />",2);
		return;
	}
	//检查对方ELS号是不是同一个
	var frm = $("#queryForm");
	$.ajax({
		url : "<%=basePath%>rest/MaterialVoucherService/checkIsTheSameToElsAccount",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		success : function(data) {
			goToAddRefundPage(data.purchaseOrderNumber,data.materialVoucherNumber);
		},
		error : function(data) {
			alert(data.message, 3);
		}
	});
}
function goToAddRefundPage(purchaseOrderNumber,materialVoucherNumber){
	if (!purchaseOrderNumber && !materialVoucherNumber) {
		alert("<i18n:I18n key='i18n_refund_numbererror' defaultValue='请输入正确的采购订单号或者物料凭证号' />",2);
		return;
	}
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'modifyRefundOrder',
        'windowTitle':'<i18n:I18n key="i18n_delivery_button_createrefund" defaultValue="新建退货" />',
        'iframSrc':'<%=basePath%>ordermanage/materialVoucher/addRefundOrder.jsp?materialVoucherNumber=' + materialVoucherNumber +'&purchaseOrderNumber=' + purchaseOrderNumber,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function loadItem(materialVoucherNumber,toElsAccount,mobileType) {
	var elsAccount = $("#elsAccount").val();
// 	var toElsAccount = $("#toElsAccount").val();
//  var toElsAccount = $("#toElsAccount").val();
	var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":mobileType};

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

//退出
$("#exitBtn").click(function(){
	if (winId) {
		parent.elsDeskTop.closeCurWin(winId,closeCallback);
	} else {
		parent.elsDeskTop.closeCurWin('refundOrderManage',closeCallback);
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
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=refundOrderManage_mt" + "&window=iframeApp_refundOrderManage",
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
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=refundOrderItem_mt" + "&window=iframeApp_refundOrderManage",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	});
	});
	
	
	//退出
	$("#test").click(function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : "<%=basePath%>rest/MaterialVoucherService/getMiddlePurchaseReceipt",
			type : "post",
			dataType : "json",
			data : JSON.stringify({"elsAccount":elsAccount}),
			contentType : "application/json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data!=null&&data.statusCode=="-100"){
					alert(data.message,2);
				}else if(data!=null&&data.statusCode=="-200"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				}
			},
			error : function(data) {parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}); 
	
	
	//退出
	$("#test1").click(function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : "<%=basePath%>rest/MaterialVoucherService/getMiddlePurchaseStorage",
			type : "post",
			dataType : "json",
			data : JSON.stringify({"elsAccount":elsAccount}),
			contentType : "application/json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data!=null&&data.statusCode=="-100"){
					alert(data.message,2);
				}else if(data!=null&&data.statusCode=="-200"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				}
			},
			error : function(data) {
			}
		});
	});
	
	//退出
	$("#test3").click(function(){
		$.ajax({
			url : "<%=basePath%>rest/MaterialVoucherService/asyncCallInteface/"+elsAccount+"/com.els.vo.MaterialVoucherHeaderVO/{\"elsAccount\":\"11\"}",
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				alert("请求成功");
			},
			error : function(data) {
				
				alert("请求失败");
			}
		});
	});

</script>
</body>
</html>