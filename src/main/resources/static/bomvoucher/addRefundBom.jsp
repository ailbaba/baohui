<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<form id="bomVoucherForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<input id="elsAccount" type="hidden" name="elsAccount" value="${elsAccount}" />
<input id="elsSubAccount" type="hidden" name="elsSubAccount" value="${elsSubAccount}" />
<input id="companyShortName" type="hidden" name="companyShortName" value="${companyShortName}" />
<input id="toElsAccount" type="hidden" name="toElsAccount" />
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
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_bomvoucher_lable_refundhead" defaultValue="退料单抬头" /></span>
    <div class="common-box-line">
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="物料凭证编号" />：</span>
				<input id="materialVoucherNumber" name="materialVoucherNumber" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_voucherdate" defaultValue="凭证日期" />：</span>
				<input id="voucherDate" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_postdate" defaultValue="过账日期" />：</span>
				<input id="postDate" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_deliverystatus" defaultValue="发货状态" />：</span>
				<input id="deliveryStatus" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_mobiletype" defaultValue="移动类型" />：</span>
				<input id="mobileType" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单编号" />：</span>
				<input id="purchaseOrderNumber" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_saleOrderNumber" defaultValue="销售订单编号" />：</span>
				<input id="saleOrderNumber" type="text" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_tomaterialvouchernumber" defaultValue="对方物料凭证" />：</span>
				<input id="toMaterialVoucherNumber" name="toMaterialVoucherNumber" type="text" readOnly/></div>
    </div>
</div>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_bomvoucher_lable_refunditems" defaultValue="退料单行项目" /></span>
    <div class="common-box-line">
	            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                <button id="btnRemove" class="button-wrap" ><i18n:I18n key="i18n_common_button_removeline" defaultValue="删除一行" /></button>
<%-- 	        <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
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
var type = "<%=request.getParameter("type")%>";
var purchaseOrderNumber = "<%=request.getParameter("purchaseOrderNumber")%>";
var materialVoucherNumber = "<%=request.getParameter("materialVoucherNumber")%>";
var toMaterialVoucherNumber = "<%=request.getParameter("toMaterialVoucherNumber")%>";
var postDate = "<%=request.getParameter("postDate")%>";
var voucherDate = "<%=request.getParameter("voucherDate")%>";
var itemGrid;
var selectedVoucherItems = "";
if (null == purchaseOrderNumber || purchaseOrderNumber == "null") {
	purchaseOrderNumber = "";
}
if (null == materialVoucherNumber || materialVoucherNumber == "null") {
	materialVoucherNumber = "";
}

var cols_item = [ {"title":"ELS号","name":"elsAccount","align":"center","width":120,"hidden":true, renderer:function(val){
                     if (!val) {val = "";}
                     return val + "<input name='bomVoucherItemList[][elsAccount]' type='hidden' value='"+val+"'/>"; 
                   }},
                   {"title":"采购方ELS号","name":"toElsAccount","align":"center","width":120,"sortable":true},
                   {"title":"物料凭证编号","name":"materialVoucherNumber","align":"center","width":120, renderer:function(val){
                       if (!val) {val = "";}
                       return val + "<input name='bomVoucherItemList[][materialVoucherNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
				   {"title":"物料凭证行项目编号","name":"materialVoucherItemNumber","align":"center","width":130, renderer:function(val){
                       if (!val) {val = "";}
                       return val + "<input name='bomVoucherItemList[][materialVoucherItemNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
                   {"title":"可退料数量","name":"refundNum","align":"center","width":100, renderer:function(val){
                       if (!val) {val = "0";}
                       return val + "<input name='bomVoucherItemList[][refundNum]' type='hidden' value='"+val+"'/>"; 
                   }},
                   {"title":"数量","name":"wesbs","align":"center","width":100, renderer:function(val){
                       if (!val) {val = "";}
                       if(type == "add"){
                    	   return "<input class='wesbs' name='bomVoucherItemList[][wesbs]' type='text'/>";
                       }else if(type == "edit"){
                    	   return val + "<input name='bomVoucherItemList[][wesbs]' type='hidden'/>";
                       }
                   }},
				   {"title":"退货原因","name":"refundRemark","align":"center","width":120, renderer:function(val){
                       if (!val) {val = "";}
                       return "<input name='bomVoucherItemList[][refundRemark]' type='text' value='"+val+"'/>"; 
                   }},
				   {"title":"退货工厂","name":"refundFactory","align":"center","width":110, renderer:function(val){
                       if (!val) {val = "";}
                       return "<input name='bomVoucherItemList[][refundFactory]' type='text' value='"+val+"'/>"; 
                   }},
				   {"title":"退货库存地","name":"refundStock","align":"center","width":110, renderer:function(val){
                       if (!val) {val = "";}
                       return "<input name='bomVoucherItemList[][refundStock]' type='text' value='"+val+"'/>"; 
                   }},
				   {"title":"备注","name":"remark","align":"center","width":100},
				   {"title":"物料凭证年度","name":"voucherYear","align":"center","width":100},
				   {"title":"时间戳","name":"logtime","align":"center","width":140, renderer:function(val){
                       if (!val) {val = "";}
                       else{
                    	   val = new Date(val).format("yyyy-MM-dd hh:mm:ss");
                       }
                       return val; 
                   }},
				   {"title":"移动类型","name":"mobileType","align":"center","width":100, renderer:function(val){
                       if (!val) {val = "";}
                       return "外协退料<input name='bomVoucherItemList[][mobileType]' type='hidden' value='"+val+"'/>"; 
                   }},
				   {"title":"销售订单号","name":"saleOrderNumber","align":"center","width":120, renderer:function(val){
                       if (!val) {val = "";}
                       return val + "<input name='bomVoucherItemList[][saleOrderNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
				   {"title":"订单行项目编号","name":"orderItemNumber","align":"center","width":120, renderer:function(val){
                       if (!val) {val = "";}
                       return val + "<input name='bomVoucherItemList[][orderItemNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
				   {"title":"订单批次","name":"orderBatch","align":"center","width":80},
				   {"title":"度量单位","name":"unitMeasure","align":"center","width":100},
				   {"title":"销售方材料号","name":"saleMaterialNumber","align":"center","width":100},
				   {"title":"销售方材料描述","name":"saleMaterialDesc","align":"center","width":100},
/* 				   {"title":"销售方物料品牌","name":"saleAttr1","align":"center","width":154},
				   {"title":"销售方物料颜色","name":"saleAttr2","align":"center","width":154},
				   {"title":"销售方物料长度","name":"saleAttr3","align":"center","width":154},
				   {"title":"销售方物料宽度","name":"saleAttr4","align":"center","width":154},
				   {"title":"销售方物料高度","name":"saleAttr5","align":"center","width":154}, */
				   {"title":"销售方出货工厂","name":"saleFactory","align":"center","width":100},
				   {"title":"采购方物料凭证编号","name":"referMaterialVoucherNumber","align":"center","width":120},
				   {"title":"采购订单号","name":"purchaseOrderNumber","align":"center","width":120, renderer:function(val){
                       if (!val) {val = "";}
                       return val + "<input name='bomVoucherItemList[][purchaseOrderNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
				   {"title":"采购方材料号","name":"purchaseMaterialNumber","align":"center","width":100},
				   {"title":"采购方材描述","name":"purchaseMaterialDesc","align":"center","width":100},
/* 				   {"title":"采购方物料品牌","name":"purchaseAttr1","align":"center","width":154},
				   {"title":"采购方物料颜色","name":"purchaseAttr2","align":"center","width":154},
				   {"title":"采购方物料长度","name":"purchaseAttr3","align":"center","width":154},
				   {"title":"采购方物料宽度","name":"purchaseAttr4","align":"center","width":154},
				   {"title":"采购方物料高度","name":"purchaseAttr5","align":"center","width":154}, */
				   {"title":"采购方收货工厂","name":"purchaseFactory","align":"center","width":100}];

$().ready(function(){
	init();
});
function init(){
	if (purchaseOrderNumber != "" || materialVoucherNumber != "") {
		if(type == "add"){
			var data = {"purchaseOrderNumber":purchaseOrderNumber,"materialVoucherNumber":materialVoucherNumber,"elsAccount":elsAccount};
			$.ajax({
				url :"<%=basePath%>rest/BomVoucherService/findBomVoucherItemForRefund",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					fillData(data);
				},
				error : function(data) {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}else if(type == "edit"){
			$("#btnRemove").hide();
			var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":"512"};
			$.ajax({
				url :"<%=basePath%>rest/BomVoucherService/findBomVoucherItem",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					$("#materialVoucherNumber").val(materialVoucherNumber);
					$("#toMaterialVoucherNumber").val(toMaterialVoucherNumber);
					$("#postDate").val(postDate);
					$("#voucherDate").val(voucherDate);
					fillData(data);
				},
				error : function(data) {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}
	}
	$("#sendBtn").click(function(){
		var rows = itemGrid.rowsLength();
		if (rows == 0) {
			alert('<i18n:I18n key="i18n_refund_noitems" defaultValue="没有可退料的项目！" />',2);
			return;
		}
		var errorMsg = "";
		var index = 1;
		// 判断退料数量
 		$(".wesbs").each(function(){
			if(parseFloat($(this).val()) > parseFloat(itemGrid.row(index-1).refundNum)) {
				errorMsg += "<i18n:I18n key='i18n_refund_at' defaultValue='第' />" + index + "<i18n:I18n key='i18n_bomvoucher_itemrefundamounterror' defaultValue='行退料数量不能大于' />" + itemGrid.row(index-1).refundNum + "\t";
				index++;
			}
		});
		if (errorMsg != "") {
			alert(errorMsg,2);
			return;
		}
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_send" defaultValue="您确定要发送退料单吗？" />',closeEvent:function(){
	    	var frm = $("#bomVoucherForm");
	    	parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url :"<%=basePath%>rest/BomVoucherService/sendRefundBomVoucher",
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
			alert("<i18n:I18n key='i18n_bomvoucher_noitems' defaultValue='没有可新建退料的项目！' />",2);
			return;
		}
		var errorMsg = "";
		var index = 1;
		// 判断退料数量
 		$(".wesbs").each(function(){
			if(parseFloat($(this).val()) > parseFloat(itemGrid.row(index-1).refundNum)) {
				errorMsg += "<i18n:I18n key='i18n_refund_at' defaultValue='第' />" + index + "<i18n:I18n key='i18n_bomvoucher_itemrefundamounterror' defaultValue='行退料数量不能大于' />" + itemGrid.row(index-1).refundNum + "\t";
				index++;
			}
		});
		if (errorMsg != "") {
			alert(errorMsg,2);
			return;
		}
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="您确定要保存退料吗？" />',closeEvent:function(){
			addRefundBomVoucher();
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
function addRefundBomVoucher(){
	var frm = $("#bomVoucherForm");
	var url = "<%=basePath%>rest/BomVoucherService/addRefundBomVoucher";
	var newMaterialVoucherNumber= $("#materialVoucherNumber").val();
	if(newMaterialVoucherNumber != ""){
		url = "<%=basePath%>rest/BomVoucherService/updateRefundBomVoucher";
	}
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : url,
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
			//如果执行的是新增操作，则刷新数据
			if(newMaterialVoucherNumber == ""){
				type = "edit";
				materialVoucherNumber = data.materialVoucherNumber;
				toMaterialVoucherNumber = data.toMaterialVoucherNumber;
				if(data.postDate && data.postDate != "")
					postDate = new Date(data.postDate).format("yyyy-MM-dd");
				if(data.voucherDate && data.voucherDate != "")
					voucherDate = new Date(data.voucherDate).format("yyyy-MM-dd");
				//刷新数据
				init();
			}
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
	var lstdata;
	if(type == "add")
		lstdata = data.bomVoucherItemList;
	else if(type == "edit")
		lstdata = data;
	
	if (!itemGrid) {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        checkCol:true,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items: lstdata
	    });
		itemGrid.on("loadSuccess",function(){
			if(itemGrid.rowsLength() > 0){
			    $("#toElsAccount").val(itemGrid.row(0).toElsAccount);
                $("#deliveryStatus").val("<i18n:I18n key='i18n_bomvoucher_lable_refundundeliver' defaultValue='退料未发货' />");
			    $("#mobileType").val("外协退料");
			}
		});
	    itemGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
	        $("#saleOrderNumber").val(item.saleOrderNumber);
	        $("#purchaseOrderNumber").val(item.purchaseOrderNumber);
	    });
	} else {
	    itemGrid.load(lstdata);
	}
}
function closeCallBack(){
	if (parent.frames["iframeApp_refundBomManage"]) {
		var frame = parent.frames["iframeApp_refundBomManage"];
		var purchaseOrderNumber = frame.$("#purchaseOrderNumber").val();
		var materialVoucherNumber = frame.$("#materialVoucherNumber").val();
		frame.$("#purchaseOrderNumber").val("");
		frame.$("#materialVoucherNumber").val("");
		parent.frames["iframeApp_refundBomManage"].query();
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
		parent.elsDeskTop.closeCurWin(winId,closeCallBack);
	} else {
		parent.elsDeskTop.closeCurWin('addRefundBom',closeCallBack);
	}
});
</script>
</body>
</html>