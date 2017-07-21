<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
		<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
	<div class="box-wrap pos-relative bg-common">
		<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
				<span style="display:inline;">
				<i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="行项目编号" />：
				<select id="itemNumberSelector" onchange="loadBom()">
				</select>
				</span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_delivery_lable_salematerialnumber" defaultValue="销售方物料编号" />：</span>
				<span id="materialNumber" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_delivery_lable_salematerialdesc" defaultValue="销售方物料描述" />：</span>
				<span id="materialDesc" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_delivery_lable_purchasematerialnumber" defaultValue="采购方物料编号" />：</span>
				<span id="purchaseMaterialNumber" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_delivery_lable_purchasematerialdesc" defaultValue="采购方物料描述" />：</span>
				<span id="purchaseMaterialDesc" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_common_label_quantityrequired" defaultValue="需求数量" />：</span>
				<span id="quantity" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_common_deliverydate" defaultValue="交货日期" />：</span>
				<span id="deliveryDate" class="dis-in-b text-left w-72">&nbsp;</span></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-left w-70"><i18n:I18n key="i18n_common_label_factory" defaultValue="工厂" />：</span>
				<span id="factory" class="dis-in-b text-left w-72">&nbsp;</span></div>
		</div>
	</div>
    <div class="box-wrap pos-relative bg-common">
         <div class="common-box-line">
          		<div class="edit-box-wrap">
 	<%--				<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_delivery_button_createaitem" defaultValue="新增行" /></button>
					<button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_delivery_button_removeaitem" defaultValue="删除行" /></button>--%>
					<button id="btnSave" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				</div> 
				<input type="hidden" name="elsAccount" value="${elsAccount }" />
				<input type="hidden" name="toElsAccount" value="<%= request.getParameter("toElsAccount") %>" />
				<input type="hidden" name="saleOrderNumber" value="<%= request.getParameter("saleOrderNumber") %>" />
				<input type="hidden" name="purchaseOrderNumber" value="<%= request.getParameter("purchaseOrderNumber") %>" />
				<input type="hidden" id="orderItemNumber" name="orderItemNumber"/>
				<input type="hidden" id="elsSubAccount" name="${elsSubAccount }"/>
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
var saleOrderNumber = "<%= request.getParameter("saleOrderNumber") %>";
var purchaseOrderNumber = "<%= request.getParameter("purchaseOrderNumber") %>";
var orderItemNumber = "<%= request.getParameter("orderItemNumber") %>";
var toElsAccount = "<%= request.getParameter("toElsAccount") %>";
var itemGrid;
var cols = [
              { title:'<i18n:I18n key="i18n_common_lable_elsAccount" defaultValue="采购方ELS号" />', name:'elsAccount' ,width:100, align:'center', hidden:true, renderer:function(val){
          	           if (!val) {val = "";}
         	           return val + "<input name='bomList[][elsAccount]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_common_lable_toElsAccount" defaultValue="销售方ELS号" />', name:'toElsAccount' ,width:100, align:'center', hidden:true, renderer:function(val){
          	           if (!val) {val = "";}
         	           return val + "<input name='bomList[][toElsAccount]' type='hidden' value='"+val+"'/>"; 
                   }},
                   
                   { title:'<i18n:I18n key="i18n_common_lable_purchaseOrderNumber" defaultValue="采购订单号" />', name:'purchaseOrderNumber' ,width:100, align:'center', hidden:true, renderer:function(val){
          	           if (!val) {val = "";}
         	           return val + "<input name='bomList[][purchaseOrderNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_common_lable_orderItemNumber" defaultValue="行项目编号" />', name:'orderItemNumber' ,width:100, align:'center', hidden:true, renderer:function(val){
          	           if (!val) {val = "";}
         	           return val + "<input name='bomList[][orderItemNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'计划行号', name:'planItemNumber' ,width:100, align:'center', hidden:true},
                   { title:'BOM号', name:'reserveNumber' ,width:100, align:'center', renderer:function(val){
          	           if (!val) {val = "";}
         	           return val + "<input name='bomList[][reserveNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'BOM行号', name:'reserveItemNumber' ,width:100, align:'center', renderer:function(val){
          	           if (!val) {val = "";}
         	           return val + "<input name='bomList[][reserveItemNumber]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber' ,width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_label_materialdescribe" defaultValue="物料描述" />', name:'materialDesc' ,width:100, align:'center'},
                    { title:'<i18n:I18n key="i18n_common_label_fixedNumber" defaultValue="固定数量" />', name:'isFixed' ,width:100, align:'center' },
                    { title:'<i18n:I18n key="i18n_common_label_deliveryDate" defaultValue="需求日期" />', name:'deliveryDate' ,width:100, align:'center'},
                    { title:'<i18n:I18n key="i18n_common_title_orderbatch" defaultValue="批次" />', name:'orderBatch' ,width:100, align:'center'},
                    { title:'<i18n:I18n key="i18n_common_title_itemclasses" defaultValue="项目类别" />', name:'purchaseType' ,width:100, align:'center'},
                    { title:'计划用量数量(单位)', name:'quantity' ,width:100, align:'center' },
                    { title:'计划用量(基本单位)', name:'unitQuantity' ,width:100, align:'center' }, 
                    { title:'<i18n:I18n key="i18n_delivery_lable_unit" defaultValue="单位" />', name:'unit' ,width:100, align:'center' },
                    { title:'<i18n:I18n key="i18n_label_basicUnit" defaultValue="基本单位" />', name:'basicUnit' ,width:100, align:'center'},
                    { title:'实际用量(基本单位)', name:'realQuantity' ,width:100, align:'center' },
                    { title:'标准用量(基本单位)', name:'normalQuantity' ,width:100, align:'center' },
                    { title:'消耗率(%)', name:'lossRate' ,width:100, align:'center' },
                    { title:'度量单位', name:'unitMeasure' ,width:100, align:'center' },
                    { title:'已发货数量', name:'deliveredQuantity' ,width:100, align:'center'},
                    { title:'在途数量', name:'onWayQuantity' ,width:100, align:'center' },
                    { title:'已收货数量', name:'receivedQuantity' ,width:100, align:'center' },
                    { title:'退货数量', name:'returnQuantity' ,width:100, align:'center' },
                    { title:'发货工厂', name:'factory' ,width:100, align:'center'},
                    { title:'发货库存地点', name:'inventoryLocation' ,width:100, align:'center'},
                    { title:'发货工厂名', name:'factoryName' ,width:100, align:'center'},
                    { title:'发货库存地点名', name:'inventoryLocationName' ,width:100, align:'center'},
                    { title:'收货工厂', name:'receiptFactory' ,width:100, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<input name='bomList[][receiptFactory]' type='text' value='"+val+"'/>"; 
                    }},
                    { title:'收货库存地点', name:'receiptInventoryLocation' ,width:100, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<input name='bomList[][receiptInventoryLocation]' type='text' value='"+val+"'/>"; 
                    }},
                    { title:'收货工厂名', name:'receiptFactoryName' ,width:100, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<input name='bomList[][receiptFactoryName]' type='text' value='"+val+"'/>"; 
                    }},
                    { title:'收货库存地点名', name:'receiptInventoryLocationName' ,width:100, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<input name='bomList[][receiptInventoryLocationName]' type='text' value='"+val+"'/>"; 
                    }},
                    { title:'<i18n:I18n key="i18n_common_label_mrpType" defaultValue="MRP类型" />', name:'mrpType' ,width:100, align:'center',renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<input name='bomList[][mrpType]' type='text' value='"+val+"'/>"; 
                    }}
        ];


$().ready(function(){
	init();
});
function init(){
	initOrderItemNumbers();
	initDataGrid();
}
function initDataGrid(){
	var height=$(document).height()-250;
	if(null == orderItemNumber || "" == orderItemNumber)
		orderItemNumber = $("#itemNumberSelector").val();
	var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"saleOrderNumber":saleOrderNumber,"orderItemNumber":orderItemNumber};
	itemGrid = $('#table-item').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/SaleOrderService/getBomList",
        params : data,
        method: "POST",
        root:"bomList",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:height,
        checkCol:true
    });
	itemGrid.on('loadSuccess',function(e,data) {
		//初始化
		var saleMaterialNumber = data.saleMaterialNumber?data.saleMaterialNumber:"";
		$("#materialNumber").text(saleMaterialNumber);
		var materialDesc = data.saleMaterialDesc?data.saleMaterialDesc:"";
		$("#materialDesc").text(materialDesc);
		var purchaseMaterialNumber = data.purchaseMaterialNumber?data.purchaseMaterialNumber:"";
		$("#purchaseMaterialNumber").text(purchaseMaterialNumber);
		var purchaseMaterialDesc = data.purchaseMaterialDesc?data.purchaseMaterialDesc:"";
		$("#purchaseMaterialDesc").text(purchaseMaterialDesc);
		var unit = data.unitQuantity&&isNaN(data.unitQuantity)?data.unitQuantity:"";
		var quantity = data.quantity?data.quantity:"";
		$("#quantity").text(quantity + " " + unit);
		var deliveryDate = data.deliveryDate?new Date(data.deliveryDate).format("yyyy-MM-dd"):"";
		$("#deliveryDate").text(deliveryDate);
		var factory = data.factory?data.factory:"";
		$("#factory").text(factory);
		if (itemGrid.rowsLength() > 0) {
			//默认选中第一行
			itemGrid.select(0);
		}
	});
	
}
//新增
$("#btnAdd").click(function(){
	if(null == orderItemNumber || "" == orderItemNumber)
		orderItemNumber = $("#itemNumberSelector").val();
	var blankRow = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"saleOrderNumber":saleOrderNumber,"purchaseOrderNumber":purchaseOrderNumber,
			"orderItemNumber":orderItemNumber,"materialNumber":"","materialDesc":"","quantity":"","isFixed":"1",
			"unit":"","factory":"","deliveryDate":"","orderBatch":"","purchaseType":"","basicUnit":"","mrpType":""};
	//添加一行
	var newRow = $.extend({}, blankRow);
	itemGrid.addRow(newRow,itemGrid.rowsLength());
});

//保存
$("#btnSave").click(function(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
		$("#orderItemNumber").val(orderItemNumber);
		var frm = $("#form");
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/SaleOrderService/saveBomList",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功" />！');
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	}
	});
});

//删除
$("#btnDelete").click(function(){
	var selectedIndexs = itemGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key='i18n_permission_selectitemstodelete' defaultValue='请选择要删除的项！' />",2);
		return;
	}
	itemGrid.removeRow(selectedIndexs[0]);
});
//获取数据
function getBomList(){
		var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"saleOrderNumber":saleOrderNumber,"orderItemNumber":orderItemNumber};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/SaleOrderService/getBomList",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				itemGrid.load(data);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
}
function initOrderItemNumbers(){
	$("#itemNumberSelector").empty();
	var html = "";
	var $frame = parent.frames["iframeApp_saleOrderConfirm"];
	if(winId != null && winId != "" && winId != "null"){
		$frame = parent.frames["iframeApp_"+winId];
	}
	var trs = $frame.$("#saleOrderItemTable").find("tr");
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		html += "<option value='"+data.orderItemNumber+"'>" + data.orderItemNumber + "</option>";
	}
	$("#itemNumberSelector").append(html);
	$("#itemNumberSelector").val(orderItemNumber);
}
function loadBom() {
	orderItemNumber = $("#itemNumberSelector").val();
	getBomList();
}
//初始化下拉框
function initSelect(){
	$("#table-item").find("tr").each(function(){
		var selectObj=$(this).find("select");
		if(selectObj.length>0){
			var val=selectObj.prev(".showText").text();
			selectObj.val(val);	
		}
	});
}
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('SaleOrderBom',null);
});
</script>
</body>
</html>