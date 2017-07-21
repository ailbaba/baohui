<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String materialVoucherNumber = request.getParameter("materialVoucherNumber");
%>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<form id="materialVoucherForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<input type="hidden" name="materialVoucherHeaderVO[elsAccount]" value="<%=session.getAttribute("elsAccount")%>"/>
<input type="hidden" name="materialVoucherHeaderVO[elsSubAccount]" value="<%=session.getAttribute("elsSubAccount")%>"/>
<input type="hidden" name="materialVoucherHeaderVO[companyShortName]" value="<%=session.getAttribute("companyShortName")%>"/>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
	    <div class="dis-in-b input-and-tip">
	        <button id="btnSaveRefund" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
	        <button id="sendBtn" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
	        <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
	        <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
	    </div>
    </div>
</div>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_refundhead" defaultValue="退货单抬头" /></span>
    <input type="hidden" name="materialVoucherHeaderVO[elsAccount]" value="${elsAccount }"/>
    <input type="hidden" name="materialVoucherHeaderVO[toElsAccount]" value="${toElsAccount }"/>
    <div class="common-box-line">
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="物料凭证编号" />：</span>
				<input id="materialVoucherNumber" name="materialVoucherHeaderVO[materialVoucherNumber]" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_createrefundorder" defaultValue="生成退货订单" />：</span>
					<select id="fbk15" name="materialVoucherHeaderVO[fbk15]" disabled>
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
				<input id="saleOrderNumber" name="materialVoucherHeaderVO[saleOrderNumber]" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_tomaterialvouchernumber" defaultValue="对方物料凭证" />：</span>
				<input id="toMaterialVoucherNumber" name="materialVoucherHeaderVO[toMaterialVoucherNumber]" type="text" readOnly/></div>
    </div>
</div>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_refunditems" defaultValue="退货单行项目" /></span>
    <div class="common-box-line">
        <div class="tab-wrap" id="sheet-project">
            <div id="sheet-item-one">
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                    </div>
                </main>
            </div>
        </div>
    </div>
</div>
</form>
<script type="text/javascript">
var elsAccount = currentElsAccount;
var materialVoucherNumber = "<%=materialVoucherNumber%>";
var itemGrid;
var materialVoucherVO;
if (materialVoucherNumber == "null") {
	materialVoucherNumber = "";
}
var date = new Date().format("yyyy-MM-dd");
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editRefundOrder_mt"/>;
$().ready(function(){
	itemGrid = $('#table-item').mmGrid({
        cols: cols_item,
        checkCol:true,
        items: [],
        height:$(document).height()-240
    });
	init();
});
function init(){
	
	if (materialVoucherNumber) {
		var data = {"materialVoucherNumber":materialVoucherNumber,"elsAccount":elsAccount,"mobileType":"122,161"};

		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherVOByMaterialVoucherNumber",
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
	$("#btnSaveRefund").click(function(){
		updateRefundMaterialVoucher();
	});
	$("#sendBtn").click(function(){
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_refund_confirm_send" defaultValue="您确定要发送退货单吗？" />',closeEvent:function(){
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
}
function updateRefundMaterialVoucher(){
	var frm = $("#materialVoucherForm");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialVoucherService/updateRefundFbk",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			close();
			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
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
	var materialVoucherHeaderVO = data.materialVoucherHeaderVO;
    $("#materialVoucherNumber").val(materialVoucherHeaderVO.materialVoucherNumber);
    $("#voucherDate").val(new Date(materialVoucherHeaderVO.voucherDate).format("yyyy-MM-dd"));
    $("#postDate").val(new Date(materialVoucherHeaderVO.postDate).format("yyyy-MM-dd"));
    $("#fbk15").val(materialVoucherHeaderVO.fbk15);
    var deliveryStatus = materialVoucherHeaderVO.deliveryStatus;
	if (deliveryStatus == "0") {
		deliveryStatus = '<i18n:I18n key="i18n_delivery_lable_refundundeliver" defaultValue="退货未发货" />';
	} else if (deliveryStatus == "1") {
		deliveryStatus = '<i18n:I18n key="i18n_refund_lable_refundonway" defaultValue="退货发货在途" />';
	} else if (deliveryStatus == "2") {
		deliveryStatus = '<i18n:I18n key="i18n_refund_lable_bereceived" defaultValue="对方已收退货" />';
	}
    $("#deliveryStatus").val(deliveryStatus);
    $("#mobileType").val(materialVoucherHeaderVO.mobileType);
    $("#purchaseOrderNumber").val(materialVoucherHeaderVO.purchaseOrderNumber);
    $("#saleOrderNumber").val(materialVoucherHeaderVO.saleOrderNumber);
    $("#toMaterialVoucherNumber").val(materialVoucherHeaderVO.toMaterialVoucherNumber);
    itemGrid.load(data.materialVoucherItemList);
}
function close(){
	if (parent.frames["iframeApp_refundOrderManage"]) {
		parent.frames["iframeApp_refundOrderManage"].query();
	}
}
//退出
$("#exitBtn").click(function(){
	if (winId) {
		parent.elsDeskTop.closeCurWin(winId,close());
	} else {
		parent.elsDeskTop.closeCurWin('modifyRefundOrder',close());
	}
});
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editRefundOrder" + "&window=iframeApp_modifyRefundOrder",
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