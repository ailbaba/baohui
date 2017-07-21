<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
	<input type="hidden" name="elsAccount" value="${elsAccount}" />
	<input type="hidden" id="toElsAccount" name="toElsAccount" />
	<input type="hidden" id="materialVoucherNumber" name="materialVoucherNumber" />
	<input type="hidden" id="toMaterialVoucherNumber" name="referMaterialVoucherNumber" />
	<input type="hidden" id="mobileType" name="mobileType" value="101" />
	<div class="box-wrap pos-relative bg-common">
		<div class="common-box-line">
			<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_items" defaultValue="行项目" />：</span>
			<input id="materialVoucherItemNumber" name="materialVoucherItemNumber" type="hidden" readOnly/></div>
			<select id="itemSelector"></select>
		</div>
		<div class="common-box-line">
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_salematerialnumber" defaultValue="销售方物料编号" />：</span>
				<span id="saleMaterialNumber" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_delivery_lable_salematerialdesc" defaultValue="销售方物料描述" />：</span>
				<span id="saleMaterialDesc" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_saleorder_title_fbk26" defaultValue="销售方物料规格" />：</span>
				<span id="fbk26" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_saleorder_title_fbk27" defaultValue="销售方物料属性一" />：</span>
				<span id="fbk27" class="dis-in-b text-left w-72">&nbsp;</span></div>
		</div>
		<div class="common-box-line">
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_purchasematerialnumber" defaultValue="采购方物料编号" />：</span>
				<span id="purchaseMaterialNumber"class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_purchasematerialdesc" defaultValue="采购方物料描述" />：</span>
				<span id="purchaseMaterialDesc" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_common_title_fbk20" defaultValue="采购方物料规格" />：</span>
				<span id="fbk20" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_common_title_fbk21" defaultValue="采购方物料属性一" />：</span>
				<span id="fbk21" class="dis-in-b text-left w-72">&nbsp;</span></div>
		</div>
		<div class="common-box-line">
		        <input type="hidden" id="deliveryQuantity" name="deliveryQuantity" />
		        <input type="hidden" id="unitMeasure" name="unitMeasure" />
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_totalquantity" defaultValue="总数量" />：</span>
				<input id="wesbs" name="wesbs" type="text" style="width: 60px;" readOnly/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_xxunit" defaultValue="订单单位" />：</span>
				<span id="unitMeasureShow"></span></div>&nbsp;
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_totalpackages" defaultValue="总件数" />：</span>
				<input id="packages" name="fbk32" type="text" style="width: 60px;" readOnly/></div>
			    <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_common_title_receivedquantity" defaultValue="已收货数量" />：</span>
				<span id="receivedQuantity"></span></div>&nbsp;
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_common_lable_quantityentered" defaultValue="已输入数量" />：</span>
				<span id="enteredQuantity"></span></div>
		</div>
	</div>
    <div class="box-wrap pos-relative bg-common">
         <div class="common-box-line">
         		<div class="edit-box-wrap">
					<button id="btnSave" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
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
var winId = "<%= request.getParameter("winId") %>";
var materialVoucherNumber = "<%= request.getParameter("materialVoucherNumber") %>";
var materialVoucherItemNumber = "<%= request.getParameter("materialVoucherItemNumber") %>";
var mobileType = "<%= request.getParameter("mobileType") %>";
$("#mobileType").val(mobileType);
var itemGrid;
var cols = [
                   { title:'<i18n:I18n key="i18n_delivery_title_deliverymaterialitem" defaultValue="送货单行号" />', name:'materialVoucherItemNumber' ,width:100, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return val + "<input name='packageList[][materialVoucherItemNumber]' type='hidden' value='"+val+"'/>"; 
                    }},
                   { title:'<i18n:I18n key="i18n_delivery_title_deliverynumber" defaultValue="发货序号" />', name:'deliveryNumber' ,width:100, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "0";}
                 	    return val+"<input name='packageList[][deliveryNumber]' type='hidden' value='"+val+"' readOnly/>"; 
                    }},
                    { title:'<i18n:I18n key="i18n_delivery_title_deliveryshu" defaultValue="发货数量" />', name:'deliveryQuantity' ,width:100, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "0";}
                 	    return val+"<input name='packageList[][deliveryQuantity]' type='hidden' class='deliveryQuantity' value='"+val+"' readOnly/>"; 
                    }},
                    { title:'<i18n:I18n key="i18n_common_title_receiptnumber" defaultValue="收货序号" />', name:'receiptNumber' ,width:100, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "0";}
                 	    return "<input name='packageList[][receiptNumber]' type='text' class='receiptNumber' value='"+val+"' />"; 
                    }},
                    { title:'<i18n:I18n key="i18n_common_title_receiptquantity" defaultValue="收货数量" />', name:'receiptQuantity' ,width:100, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "0";}
                 	    return "<input name='packageList[][receiptQuantity]' type='text' class='receiptQuantity' value='"+val+"' />"; 
                    }},
                    { title:'<i18n:I18n key="i18n_delivery_lable_xxunit" defaultValue="订单单位" />', name:'unitMeasure' ,width:100, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return val + "<input name='packageList[][unitMeasure]' type='hidden' value='"+val+"'/>"; 
                    }}
               ];

$().ready(function(){
	init();
});
function init(){
	getItemList();
	getPackageItemList();
}
function getItemList() {
	var paramStr={"elsAccount":elsAccount,"mobileType":mobileType,"materialVoucherNumber":materialVoucherNumber};
	var url = "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherItem";
	$.ajax({
		url :url,
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(paramStr),
		success : function(data) {
			var html = "";
			for(var i=0;i<data.rows.length;i++){
				html+="<option value='"+data.rows[i].materialVoucherItemNumber+"'>"+data.rows[i].materialVoucherItemNumber+"_"+data.rows[i].purchaseMaterialDesc+"</option>";
			}
			$("#itemSelector").html(html);
			$("#itemSelector").change(function(){
				materialVoucherItemNumber = $(this).val();
				getPackageItemList();
			});
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

//获取数据
function getPackageItemList(){
	parent.elsDeskTop.showLoading();	
	var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"materialVoucherItemNumber":materialVoucherItemNumber,"mobileType":mobileType};
		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/findDeliveryPackage",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				var fbk14 = data.fbk14?data.fbk14:"0.00";
				var fbk20 = data.fbk20?data.fbk20:"";
				var fbk21 = data.fbk21?data.fbk21:"";
				var fbk26 = data.fbk26?data.fbk26:"";
				var fbk27 = data.fbk27?data.fbk27:"";
				$("#fbk20").text(fbk20);
				$("#fbk21").text(fbk21);
				$("#fbk26").text(fbk26);
				$("#fbk27").text(fbk27);
				$("#receivedQuantity").text(fbk14);
				$("#materialVoucherNumber").val(materialVoucherNumber);
				$("#toMaterialVoucherNumber").val(data.referMaterialVoucherNumber);
				$("#toElsAccount").val(data.toElsAccount);
				$("#materialVoucherItemNumber").val(data.materialVoucherItemNumber);
				$("#saleMaterialNumber").text(data.saleMaterialNumber);
				$("#saleMaterialDesc").text(data.saleMaterialDesc);
				$("#purchaseMaterialNumber").text(data.purchaseMaterialNumber);
				$("#purchaseMaterialDesc").text(data.purchaseMaterialDesc);
				$("#deliveryQuantity").val(data.deliveryQuantity);
				$("#wesbs").val(data.wesbs);
				$("#unitMeasure").val(data.unitPrice);
				$("#unitMeasureShow").text(data.unitPrice);
				$("#packages").val(data.fbk32);
				var height=$(document).height()-295;
				if(!itemGrid){
					itemGrid = $('#table-item').mmGrid({
				        cols: cols,
				        checkCol:true,
				        height:height,
				        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
				        items: data.packageList
				    });
				}else{
					itemGrid.load(data.packageList);
				}
				itemGrid.on("loadSuccess",function(){
					sumQuantity();
					bindItemEvent();
				});
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
}

function sumQuantity(){
	var sumQuantity = 0;
	$("#table-item").find("tr").each(function(){
		var itemQuantity = $(this).find(".receiptQuantity").val();
		sumQuantity = sumQuantity + parseFloat(itemQuantity);
	});
	sumQuantity = isNaN(sumQuantity)?0:sumQuantity;
	$("#enteredQuantity").text(sumQuantity);
}

function bindItemEvent(){
	$(".receiptQuantity").keyup(function(){
		var val = $(this).val();
		if (isNaN(val)) {
			alert("<i18n:I18n key='i18n_delivery_onlynumeric' defaultValue='请输入数字' />",2);
			$(this).focus();
			return;
		}
		var $deliveryQuantity = $(this).parent().parent().parent().find(".deliveryQuantity").val();
		if (parseFloat(val) > parseFloat($deliveryQuantity)) {
			alert("<i18n:I18n key='i18n_delivery_receiveamounterror' defaultValue='收货数量不能大于发货数量' />",2);
			return;
		}
		sumQuantity();
	});
}

//保存
$("#btnSave").click(function(){
	var total = 0;
	$(".receiptQuantity").each(function(){
		if (!isNaN($(this).val())) {
			total += parseFloat($(this).val());
		}
	});
	var wesbs = $("#wesbs").val();
	var enteredQuantity = $("#enteredQuantity").text();
	if (total > wesbs) {
		alert("<i18n:I18n key='i18n_delivery_receiveamountlimit' defaultValue='收货数量不能大于' />" + wesbs,2);
		return;
	}
	var message = "<i18n:I18n key='i18n_common_confirm_save' defaultValue='是否确认保存？' />";
	if(parseFloat(enteredQuantity) != parseFloat(wesbs))
		message = "<i18n:I18n key='i18n_delivery_enterandreceiveamount' defaultValue='已输入数量与收货数量' />" + "(" + wesbs + ")" + "<i18n:I18n key='i18n_delivery_enterandreceiveamountend' defaultValue='不相等,是否确认更新收货数量并保存？' />";
	parent.elsDeskTop.tip.init({type: 'confirm',message:message,closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialVoucherService/saveReceiptPackage",
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
			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />！');
			closeCallback();
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

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('editReceiptPackage',null);
});

function closeCallback() {
	var wesbs = $("#enteredQuantity").text();
 	if (parent.frames["iframeApp_receiptConfirm"]) {
		parent.frames["iframeApp_receiptConfirm"].updateRowLink(materialVoucherItemNumber,wesbs);
	}else if(parent.frames["iframeApp_updateReceipt"]){
		parent.frames["iframeApp_updateReceipt"].updateRowLink(materialVoucherItemNumber,wesbs);
	}else{
		if(winId != null && winId != "" && winId != "null")
			parent.frames["iframeApp_"+winId].updateRowLink(materialVoucherItemNumber,wesbs);
	}
}
</script>
</body>
</html>