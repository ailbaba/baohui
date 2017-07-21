<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String purchaseOrderNumber = request.getParameter("purchaseOrderNumber");
String materialVoucherNumber = request.getParameter("materialVoucherNumber");
%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<form id="materialVoucherForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<input id="elsAccount" name="materialVoucherHeaderVO[elsAccount]" type="hidden" />
<input id="elsSubAccount" name="materialVoucherHeaderVO[elsSubAccount]" type="hidden" />
<input id="companyShortName" name="materialVoucherHeaderVO[companyShortName]" type="hidden" />
<input id="toElsAccount" name="materialVoucherHeaderVO[toElsAccount]" type="hidden" />
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
	    <div class="dis-in-b input-and-tip">
	        <button id="btnAddRefund" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
	        <button id="sendBtn" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
	        <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
	    </div>
	    </div>

</div>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_refundhead" defaultValue="退货单抬头" /></span>
    <div class="common-box-line">
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="物料凭证编号" />：</span>
				<input id="materialVoucherNumber" name="materialVoucherHeaderVO[materialVoucherNumber]" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_createrefundorder" defaultValue="生成退货订单" />：</span>
					<select name="materialVoucherHeaderVO[fbk15]" id="fbk15">
						<option  value="N"><i18n:I18n key="i18n_common_no" defaultValue="否" /></option>
						<option value="Y"><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
					</select>
				</div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_voucherdate" defaultValue="凭证日期" />：</span>
				<input id="voucherDate" name="voucherDate" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_postdate" defaultValue="过账日期" />：</span>
				<input id="postDate" name="postDate"  type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_deliverystatus" defaultValue="发货状态" />：</span>
				<input id="deliveryStatus" name="deliveryStatus" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_mobiletype" defaultValue="移动类型" />：</span>
				<input id="mobileType" name="materialVoucherHeaderVO[mobileType]" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单编号" />：</span>
				<input id="purchaseOrderNumber" name="materialVoucherHeaderVO[purchaseOrderNumber]" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_saleOrderNumber" defaultValue="销售订单编号" />：</span>
				<input id="saleOrderNumber" name="saleOrderNumber" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_tomaterialvouchernumber" defaultValue="对方物料凭证" />：</span>
				<input id="toMaterialVoucherNumber" name="materialVoucherHeaderVO[toMaterialVoucherNumber]" type="text" readOnly/></div>
    </div>
</div>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_refunditems" defaultValue="退货单行项目" /></span>
    <div class="common-box-line">
	            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                <button id="btnRemove" class="button-wrap" ><i18n:I18n key="i18n_common_button_removeline" defaultValue="删除一行" /></button>
	            <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                </div>
                </div>
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                    </div>
                </main>
    </div>
</div>
</form>
<script type="text/javascript">
var elsAccount = currentElsAccount;
var purchaseOrderNumber = "<%=purchaseOrderNumber%>";
var materialVoucherNumber = "<%=materialVoucherNumber%>";
var itemGrid;
var materialVoucherVO;
var selectedVoucherItems = "";
if (purchaseOrderNumber == "null") {
	purchaseOrderNumber = "";
}
if (materialVoucherNumber == "null") {
	materialVoucherNumber = "";
}
var date = new Date().format("yyyy-MM-dd");
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="addRefundOrder_mt"/>;
$().ready(function(){
	$("#elsAccount").val(elsAccount);
	init();
});
function init(){
	
	if (purchaseOrderNumber != "" || materialVoucherNumber != "") {
		var data = {"purchaseOrderNumber":purchaseOrderNumber,"materialVoucherNumber":materialVoucherNumber,"elsAccount":elsAccount,"mobileType":101};
		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherVOByPurchaseOrderNumber",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				materialVoucherVO = data;
				fillData(data);
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	$("#sendBtn").click(function(){
		var rows = itemGrid.rowsLength();
		if (rows == 0) {
			alert('<i18n:I18n key="i18n_refund_noitems" defaultValue="没有可退货的项目！" />',2);
			return;
		}
		var fbk15 = $("#fbk15").val();
		if (fbk15=="Y") {
			alert('<i18n:I18n key="i18n_refund_needbeconfirmed" defaultValue="生成的采购订单经销售方确认后方可发送！" />',2);
			return;
		}
		var errorMsg = "";
		var index = 1;
		// 判断退货数量
		$(".wesbs").each(function(){
			if(parseFloat($(this).val()) > parseFloat($(this).attr("max"))) {
				errorMsg += "<i18n:I18n key='i18n_refund_at' defaultValue='第' />" + index + "<i18n:I18n key='i18n_refund_itemrefundamounterror' defaultValue='行退货数量不能大于' />" + $(this).attr("max") + "\t";
				index++;
			}
		});
		if (errorMsg != "") {
			alert(errorMsg,2);
			return;
		}
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_send" defaultValue="您确定要发送退货单吗？" />',closeEvent:function(){
	    	var frm = $("#materialVoucherForm");
	    	parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url :"<%=basePath%>rest/MaterialVoucherService/sendRefundMaterialVoucher",
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
	    			alert("<i18n:I18n key='i18n_common_sendsuccess' defaultValue='发送成功' />");
	    			$("#exitBtn").click();
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
	$("#btnAddRefund").click(function(){
		var rows = itemGrid.rowsLength();
		if (rows == 0) {
			alert("<i18n:I18n key='i18n_refund_noitems' defaultValue='没有可退货的项目！' />",2);
			return;
		}
		var newMaterialVoucherNumber= $("#materialVoucherNumber").val();
		if(newMaterialVoucherNumber != ""){
			alert("<i18n:I18n key='i18n_refund_repeated' defaultValue='不可重复退货' />",2);
			return;
		}
		var errorMsg = "";
		var index = 1;
		// 判断退货数量
		$(".wesbs").each(function(){
			if(parseFloat($(this).val()) > parseFloat($(this).attr("max"))) {
				errorMsg += "<i18n:I18n key='i18n_refund_at' defaultValue='第' />" + index + "<i18n:I18n key='i18n_refund_itemrefundamounterror' defaultValue='行退货数量不能大于' />" + $(this).attr("max") + "\t";
				index++;
			}
		});
		if (errorMsg != "") {
			alert(errorMsg,2);
			return;
		}
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="您确定要保存退货吗？" />',closeEvent:function(){
			addRefundMaterialVoucher();
    	}});
	});
	$("#btnRemove").click(function(){
		var selectedIndexs = itemGrid.selectedRowsIndex();
		if (selectedIndexs.length == 0) {
			alert("<i18n:I18n key='i18n_refund_chooseitem' defaultValue='请选择行项目' />",2);
			return;
		}
		for(var i=0;i<selectedIndexs.length;i++){
			itemGrid.removeRow(selectedIndexs[0]);
		}
	});
}
function addRefundMaterialVoucher(){
	var frm = $("#materialVoucherForm");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialVoucherService/addRefundMaterialVoucher",
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
			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
			window.location = "<%=basePath%>ordermanage/materialVoucher/editRefundOrder.jsp?materialVoucherNumber=" + data.materialVoucherNumber + "&toElsAccount=" + data.toElsAccount;
		},
		error : function(data) {
            parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function fillData(data) {
	if (!itemGrid) {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        checkCol:true,
	        multiSelect: true,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items: data.materialVoucherItemList
	    });
		itemGrid.on("loadSuccess",function(){
			if(itemGrid.rowsLength() > 0){
				itemGrid.select(0);
			    $("#toElsAccount").val(itemGrid.selectedRows()[0].toElsAccount);
			    $("#saleOrderNumber").val(itemGrid.selectedRows()[0].saleOrderNumber);
			    $("#purchaseOrderNumber").val(itemGrid.selectedRows()[0].purchaseOrderNumber);
			    $("#elsSubAccount").val(elsSubAccount);
			    $("#companyShortName").val(companyShortName);
			    $("#deliveryStatus").val("<i18n:I18n key='i18n_delivery_lable_refundundeliver' defaultValue='退货未发货' />");
			    $("#mobileType").val("102");
			}
		});
	    itemGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
	        $("#saleOrderNumber").val(item.saleOrderNumber);
	        $("#purchaseOrderNumber").val(item.purchaseOrderNumber);
	    });
	} else {
	    itemGrid.load(data.materialVoucherItemList);
	}
}
function close(){
	if (parent.frames["iframeApp_refundOrderManage"]) {
		var frame = parent.frames["iframeApp_refundOrderManage"];
		var purchaseOrderNumber = frame.$("#purchaseOrderNumber").val();
		var materialVoucherNumber = frame.$("#materialVoucherNumber").val();
		frame.$("#purchaseOrderNumber").val("");
		frame.$("#materialVoucherNumber").val("");
		parent.frames["iframeApp_refundOrderManage"].query();
		frame.$("#purchaseOrderNumber").val(purchaseOrderNumber);
		frame.$("#materialVoucherNumber").val(materialVoucherNumber);
	}
}
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=addRefundOrder" + "&window=iframeApp_insertRefundOrder",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	});
	});
//退出
$("#exitBtn").click(function(){
	if (winId) {
		parent.elsDeskTop.closeCurWin(winId,null);
	} else {
		parent.elsDeskTop.closeCurWin('modifyRefundOrder',null);
	}
});
//渲染是否为实物收货
function rendererFbk16(val){
	if (val == "Y"){
		val =  '<i18n:I18n defaultValue="是" key=""></i18n:I18n>';
	}else{
		val = '<i18n:I18n defaultValue="否" key=""></i18n:I18n>';
	}
	return val;
}
</script>
</body>
</html>