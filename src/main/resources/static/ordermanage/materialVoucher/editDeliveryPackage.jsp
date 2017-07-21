<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
<input type="hidden" id="wesbzHidden" name="wesbzHidden" />
<input type="hidden" id="conversionParam" name="conversionParam" />
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
	<input type="hidden" name="elsAccount" value="${elsAccount}" />
	<input type="hidden" id="toElsAccount" name="toElsAccount" />
	<input type="hidden" id="materialVoucherNumber" name="materialVoucherNumber" />
	<input type="hidden" id="referMaterialVoucherNumber" name="referMaterialVoucherNumber" />
	<input type="hidden" id="mobileType" name="mobileType" value="601" />
	<input type="hidden" id="wesbs" name="wesbs"/>
	<div class="box-wrap pos-relative bg-common">
<!-- 		<span class="dis-in-b pos-absolute box-tip bg-common">操作</span> -->
		<div class="common-box-line">
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="行项目编号" />：</span>
				<select id="itemNumberSelector" name="materialVoucherItemNumber" onchange="loadPackageItem()">
				</select></div>
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
				<span id="purchaseMaterialNumber" class="dis-in-b text-left w-72">&nbsp;</span></div>
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
				<span id="deliveryQuantityShow"></span></div>&nbsp;
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_common_lable_quantityentered" defaultValue="已输入数量" />：</span>
				<input id="wesbz" name="wesbz" type="text" style="width: 60px;"/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_xxunit" defaultValue="订单单位" />：</span>
				<span id="unitMeasureShow"></span></div>&nbsp;
			    <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_perpackage" defaultValue="每件数量" />：</span>
				<input id="perPackage" name="perPackage" type="text" style="width: 60px;"/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-30"><i18n:I18n key="i18n_delivery_lable_totalpackages" defaultValue="总件数" />：</span>
				<input id="packages" name="fbk32" type="text" style="width: 60px;"/></div>
		</div>
	</div>
    <div class="box-wrap pos-relative bg-common">
<!--          <span class="dis-in-b pos-absolute box-tip bg-common">审批人</span> -->
         <div class="common-box-line">
         		<div class="edit-box-wrap">
         		    <button id="btnAuto" class="button-wrap"><i18n:I18n key="i18n_delivery_button_createitemsauto" defaultValue="生成明细" /></button>
					<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_delivery_button_createaitem" defaultValue="新增行" /></button>
					<button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_delivery_button_removeaitem" defaultValue="删除行" /></button>
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
var materialVoucherNumber = "<%= request.getParameter("materialVoucherNumber") %>";
var materialVoucherItemNumber = "<%= request.getParameter("materialVoucherItemNumber") %>";
var wesbz = "<%= request.getParameter("wesbz") %>";
var wesbs = "<%= request.getParameter("wesbs") %>";
var conversionParam = "<%= request.getParameter("conversionParam") %>";
var height=$(document).height()-295;
var itemGrid;
var cols = [
                   { title:'<i18n:I18n key="i18n_delivery_title_deliverymaterialitem" defaultValue="送货单行号" />', name:'materialVoucherItemNumber' ,width:100, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return val + "<input name='packageList[][materialVoucherItemNumber]' type='hidden' value='"+val+"'/>"; 
                    }},
                   { title:'<i18n:I18n key="i18n_delivery_title_deliverynumber" defaultValue="发货序号" />', name:'deliveryNumber' ,width:100, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "0";}
                 	    return "<input name='packageList[][deliveryNumber]' type='text' value='"+val+"'/>"; 
                    }},
                    { title:'<i18n:I18n key="i18n_delivery_title_deliveryshu" defaultValue="发货数量" />', name:'deliveryQuantity' ,width:100, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "0";}
                 	    return "<input name='packageList[][deliveryQuantity]' type='text' class='deliveryQuantity' value='"+val+"'/>"; 
                    }},
                    { title:'<i18n:I18n key="i18n_common_title_receiptnumber" defaultValue="收货序号" />', name:'receiptNumber' ,width:100, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "0";}
                 	    return "<input name='packageList[][receiptNumber]' type='text' class='receiptNumber' value='"+val+"' readonly/>"; 
                    }},
                    { title:'<i18n:I18n key="i18n_common_title_receiptquantity" defaultValue="收货数量" />', name:'receiptQuantity' ,width:100, align:'center' ,renderer:function(val){
                  	    if (!val) {val = "0";}
                 	    return "<input name='packageList[][receiptQuantity]' type='text' class='receiptQuantity' value='"+val+"' readonly/>"; 
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
	initMaterialVoucherItems();
	getPackageItemList();
}
//获取数据
function getPackageItemList(){
		var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"materialVoucherItemNumber":materialVoucherItemNumber,"mobileType":"601"};
		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/findDeliveryPackage",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				var fbk20 = data.fbk20?data.fbk20:"";
				var fbk21 = data.fbk21?data.fbk21:"";
				var fbk26 = data.fbk26?data.fbk26:"";
				var fbk27 = data.fbk27?data.fbk27:"";
				$("#fbk20").text(fbk20);
				$("#fbk21").text(fbk21);
				$("#fbk26").text(fbk26);
				$("#fbk27").text(fbk27);
				$("#materialVoucherNumber").val(materialVoucherNumber);
				$("#wesbz").val(data.wesbz);
				$("#deliveryQuantityShow").text(data.wesbz);
				$("#wesbzHidden").val(data.wesbz);
				$("#wesbs").val(data.wesbs);
				$("#conversionParam").val(data.conversionParam);
				$("#referMaterialVoucherNumber").val(data.referMaterialVoucherNumber);
				$("#toElsAccount").val(data.toElsAccount);
				$("#itemNumberSelector").val(data.materialVoucherItemNumber);
				$("#saleMaterialNumber").text(data.saleMaterialNumber);
				$("#saleMaterialDesc").text(data.saleMaterialDesc);
				$("#purchaseMaterialNumber").text(data.purchaseMaterialNumber);
				$("#purchaseMaterialDesc").text(data.purchaseMaterialDesc);
				$("#deliveryQuantity").val(data.deliveryQuantity);
				$("#unitMeasure").val(data.unitPrice);
				$("#unitMeasureShow").text(data.unitPrice);
				$("#packages").val(data.fbk32);
				if(data.packageList.length > 0){
					$("#perPackage").val(data.packageList[0].deliveryQuantity);
				}
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
				itemGrid.on('loadSuccess',function() {
					bindItemEvent();
				});
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
}

function bindItemEvent(){
 	$(".deliveryQuantity").keyup(function(){
/* 		var val = $(this).val();
		var $receiptQuantity = $(this).parent().parent().parent().find(".receiptQuantity");
		if (isNaN(val) || val == "") {
			$(this).val(0);
		}
		var deliveryQuantity = $("#deliveryQuantity").val();
		if(!checkQuantity()){
			alert("总数量不能大于可发货数(" + deliveryQuantity + ")",2);
			$(this).focus();
		} */
		var val = $(this).val();
		if (isNaN(val) || val == "") {
			$(this).val(0);
		}
		checkQuantity();
	}); 
}

function checkQuantity(){
	var sumQuantity = 0;
	var deliveryQuantity = $("#deliveryQuantity").val();
	$("#table-item").find("tr").each(function(){
		var itemQuantity = $(this).find("input[name='packageList[][deliveryQuantity]']").val();
		sumQuantity = sumQuantity + parseFloat(itemQuantity);
	});
	$("#wesbz").val(sumQuantity);
	if(sumQuantity > deliveryQuantity){
		return false;
	}
	return true;
}

$("#btnAuto").click(function(){
	var wesbz = $("#wesbz").val();
	var packages = $("#packages").val();
	var perPackage = $("#perPackage").val();
	if (isNaN(wesbz) || wesbz =="") {
		alert("<i18n:I18n key='i18n_delivery_reenteramount' defaultValue='请重新输入总数量' />",2);
		$("#wesbz").focus();
		return;
	}
	if ((isNaN(packages) && isNaN(perPackage)) || (packages =="" && perPackage =="")) {
		alert("<i18n:I18n key='i18n_delivery_reenterpackages' defaultValue='请重新输入总件数' />",2);
		$("#packages").focus();
		return;
	}else if(isNaN(packages) || packages == ""){
		if(parseFloat(perPackage) != 0){
			if(perPackage > parseFloat(wesbz)){
				alert("<i18n:I18n key='i18n_delivery_perpackageamounterror' defaultValue='每件数量不能超过总数量' />",2);
			    $("#perPackage").focus();
			    return;
			}
			var packages = parseInt(parseFloat(wesbz)/perPackage);
			var mod = parseFloat(wesbz) % perPackage;
			var unitMeasure = $("#unitMeasure").val();
			var blankRow = {"materialVoucherItemNumber":materialVoucherItemNumber,"deliveryNumber":"1","deliveryQuantity":perPackage,"receiptNumber":"1","receiptQuantity":"0","unitMeasure":unitMeasure};
			itemGrid.removeRow();
			for(var i=1;i<=packages;i++){
				//添加一行
				var newRow = $.extend({}, blankRow);
				newRow.deliveryNumber = i;
				newRow.receiptNumber = newRow.deliveryNumber;
				itemGrid.addRow(newRow,itemGrid.rowsLength());
			}
			if(mod != 0){
				packages = packages + 1;
				//添加一行
				var newRow = $.extend({}, blankRow);
				newRow.deliveryNumber = packages;
				newRow.receiptNumber = newRow.deliveryNumber;
				newRow.deliveryQuantity = mod;
				//newRow.receiptQuantity = newRow.deliveryQuantity;
				itemGrid.addRow(newRow,itemGrid.rowsLength());
			}
			$("#packages").val(packages);
			bindItemEvent();
		}
	}else{
		if(parseFloat(packages) != 0){
			var perPackage = parseFloat(wesbz)/packages;
			$("#perPackage").val(perPackage);
			var unitMeasure = $("#unitMeasure").val();
			var blankRow = {"materialVoucherItemNumber":materialVoucherItemNumber,"deliveryNumber":"1","deliveryQuantity":perPackage,"receiptNumber":"1","receiptQuantity":"0","unitMeasure":unitMeasure};
			itemGrid.removeRow();
			for(var i=1;i<=packages;i++){
				//添加一行
				var newRow = $.extend({}, blankRow);
				newRow.deliveryNumber = i;
				newRow.receiptNumber = newRow.deliveryNumber;
				itemGrid.addRow(newRow,itemGrid.rowsLength());
			}
			bindItemEvent();
		}
	}
});
function initMaterialVoucherItems(){
	$("#itemNumberSelector").empty();
	var html = "";
	var trs = parent.frames["iframeApp_editDelivery"].$("#table-item").find("tr");
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		if (data.materialVoucherNumber != "") 
			html += "<option value='"+data.materialVoucherItemNumber+"'>" + data.materialVoucherItemNumber + "_" + data.saleMaterialDesc + "</option>";
	}
	$("#itemNumberSelector").append(html);
}
function loadPackageItem(){
	materialVoucherItemNumber = $("#itemNumberSelector").val();
	getPackageItemList();
}
//新增
$("#btnAdd").click(function(){
	var unitMeasure = $("#unitMeasure").val();
	var blankRow = {"materialVoucherItemNumber":materialVoucherItemNumber,"deliveryNumber":"1","deliveryQuantity":"0","receiptNumber":"1","receiptQuantity":"0","unitMeasure":unitMeasure};
	//取出最大的deliveryNumber
	var deliveryNumber = 0;
	for(var i=0;i<itemGrid.rowsLength();i++){
		var temp = parseInt(itemGrid.row(i).deliveryNumber);
		if(deliveryNumber <= temp)
			deliveryNumber = temp;
	}
	//添加一行
	var newRow = $.extend({}, blankRow);
	newRow.deliveryNumber = deliveryNumber + 1;
	newRow.receiptNumber = newRow.deliveryNumber;
	itemGrid.addRow(newRow,itemGrid.rowsLength());
	$("#packages").val(itemGrid.rowsLength());
	bindItemEvent();
});

//保存
$("#btnSave").click(function(){
/* 	if(!checkQuantity()){
		var deliveryQuantity = $("#deliveryQuantity").val();
		alert("总数量不能大于可发货数(" + deliveryQuantity + ")",2);
		return;
	} */
	var message = "<i18n:I18n key='i18n_common_confirm_save' defaultValue='是否确认保存？' />";
	var wesbz = $("#wesbz").val();
	var conversionParam = $("#conversionParam").val();
	var wesbs = parseFloat(wesbz)*parseFloat(conversionParam)/100;
	$("#wesbs").val(wesbs);
	var wesbzHidden = $("#wesbzHidden").val();
	if(parseFloat(wesbz) != parseFloat(wesbzHidden))
		message = "<i18n:I18n key='i18n_delivery_amountnotequal' defaultValue='总数量与发货数量' />" + "(" + wesbzHidden + ")" + "<i18n:I18n key='i18n_delivery_amountnotequalend' defaultValue='不相等,是否更新发货数量并保存？' />";
	parent.elsDeskTop.tip.init({type: 'confirm',message:message,closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialVoucherService/saveDeliveryPackage",
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
			$("#wesbzHidden").val(wesbz);
			$("#deliveryQuantityShow").text(wesbz);
			closeCallback();
			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />！');
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

//删除
$("#btnDelete").click(function(){
	var selectedIndexs = itemGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key='i18n_permission_selectitemstodelete' defaultValue='请选择要删除的项！' />",2);
		return;
	}
	itemGrid.removeRow(selectedIndexs[0]);
	$("#packages").val(itemGrid.rowsLength());
	checkQuantity();
/* 	var totalQuantity = $("#wesbz").val();
	var itemQuantity = itemGrid.row(selectedIndexs[0]).deliveryQuantity;
	itemGrid.removeRow(selectedIndexs[0]);
	$("#packages").val(itemGrid.rowsLength());
	if(itemQuantity == "")
		itemQuantity = 0;
	$("#wesbz").val(parseFloat(totalQuantity) - parseFloat(itemQuantity)); */
});

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('editDeliveryPackage',null);
});

function closeCallback() {
	var packages = $("#packages").val(); 
	var wesbz = $("#wesbz").val(); 
 	if (parent.frames["iframeApp_editDelivery"]) {
		parent.frames["iframeApp_editDelivery"].updateRowLink(materialVoucherItemNumber,packages,wesbz);
	}
}
</script>
</body>
</html>