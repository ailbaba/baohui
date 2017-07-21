<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
	         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
	         <div class="common-box-line">
	         	<button id="saveBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
	         </div>
	     </div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/BomVoucherService/querySaleItem">
			<input type="hidden" name="elsAccount" value="${elsAccount }">
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>采购方名称：</span><input name="companyShortName" type="text" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input id="purchaseOrderNumber"
						name="purchaseOrderNumber" type="text" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span>采购方产品编号：</span><input name="materialNumber" type="text" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span>材料编号/描述：</span><input name="materialDesc" type="text" />
				</div>
				<br><div class="dis-in-b input-and-tip"><span class=" text-right w-72"><i18n:I18n key="i18n_label_orderdate" defaultValue="订单日期" />：</span></div>
	               <input type="radio" name="dateArea" value="week" checked><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" /><input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" /><input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" /><input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
	               <div class="dis-in-b input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate"/></div>
	               <div class="dis-in-b input-and-tip" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate" /></div>
	
				<div class="dis-in-b input-and-tip">
					<button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
	<%-- 					<button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
				</div>
			</div>
			</form>
		</div>
	
		<div class="box-wrap pos-relative bg-common">
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
			<div class="common-box-line">
<%-- 				<button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
				<form id="itemForm">
				<main class="grid-container">
				<div class="grid-100">
					<table id="table-item"></table>
				</div>
				</main>
				</form>
			</div>
		</div>
	   </div>
	</div>
	<div id="dialog" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../icon/els.PNG" />
				<span id="dialogTitle">设置批次</span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<div class="dis-in-b input-and-tip">
						<button class="button-wrap edit-btn" id="insertItem"><i18n:I18n key="i18n_common_button_addlinebottom" defaultValue="插入" /></button>
						<button class="button-wrap edit-btn" id="deleteItem"><i18n:I18n key="i18n_common_button_removeline" defaultValue="删除" /></button>
					</div>
					<form id="batchForm">
					<main class="grid-container">
					<div class="grid-100">
						<table id="batch-item"></table>
					</div>
					</main>
					</form>
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
	var batchGrid;
	var curr = new Date().format("yyyy-MM-dd");
	var cols = [{ "title": "采购方名称",  "name": "companyShortName",  "align": "center", "width": 120},
	            { "title": "采购订单号",  "name": "purchaseOrderNumber",  "align": "center", "width": 120},
	            { "title": "采购订单行",  "name": "orderItemNumber",  "align": "center", "width": 100},
	            { "title": "采购方产品编号",  "name": "purchaseMaterialNumber",  "align": "center", "width": 100},
	            { "title": "采购方产品描述",  "name": "purchaseMaterialDesc",  "align": "center", "width": 100},
	            { "title": "订单数量",  "name": "quantity",  "align": "center", "width": 100},
	            { "title": "订单单位",  "name": "unitQuantity",  "align": "center", "width": 100},
	            { "title": "要求交期",  "name": "deliveryDate",  "align": "center", "width": 100,renderer:function(val){return dateFormat(val);}},
	            { "title": "发货数量",  "name": "deliveredQuantity",  "align": "center", "width": 100},
	            { "title": "收货数量",  "name": "receivedQuantity",  "align": "center", "width": 100}
	            ];
	var cols_item = [{ "title": "采购订单号",  "name": "purchaseOrderNumber",  "align": "center", "width": 120},
	 	            { "title": "采购订单行",  "name": "orderItemNumber",  "align": "center", "width": 100},
	 	           { "title": "材料编号",  "name": "materialNumber",  "align": "center", "width": 100},
		            { "title": "材料描述",  "name": "materialDesc",  "align": "center", "width": 100},
		            { "title": "工厂",  "name": "receiptFactory",  "align": "center", "width": 100},
		            { "title": "类型",  "name": "type",  "align": "center", "width": 80,renderer:function(){
		            	return "<select name='bomList[][type]'><option value='0'>领料</option><option value='1'>退料</option></select>"
		            }},
		            { "title": "库存地",  "name": "stock",  "align": "center", "width": 100,renderer:function(){
		            	return "<input type='text' name='bomList[][stock]'/>";
		            }},
		            { "title": "当日领用量",  "name": "currQuantity",  "align": "center", "width": 100,renderer:function(){
		            	return "<input type='text' name='bomList[][currQuantity]'/>";
		            }},
		            { "title": "不良标识",  "name": "badFlag",  "align": "center", "width": 100,renderer:function(){
		            	return "<input type='checkbox' value='Y' name='bomList[][badFlag]'/>";
		            }},
		            { "title": "不良原因",  "name": "badRemark",  "align": "center", "width": 150,renderer:function(){
		            	return "<input type='text' name='bomList[][badRemark]'/>";
		            }},
		            { "title": "录入时间",  "name": "voucherDate",  "align": "center", "width": 100,renderer:function(){
		            	return "<input type='text' name='bomList[][voucherDate]' onfocus='WdatePicker()' value='"+curr+"'/>";
		            }},
		            { "title": "批次号",  "name": "orderBatch",  "align": "center", "width": 100,renderer:function(){
		            	return "<input type='hidden' name='bomList[][batchs]'/><a onclick='openBatch(this)'>设置批次</a>";
		            }},
		            { "title": "计划用量",  "name": "quantity",  "align": "center", "width": 90},
		            { "title": "实际累计用量",  "name": "realQuantity",  "align": "center", "width": 100},
		            { "title": "基本单位",  "name": "unitQuantity",  "align": "center", "width": 90},
		            { "title": "损耗率",  "name": "lossRate",  "align": "center", "width": 90}
		            ];
	var cols_batch = [{ "title": "批次号",  "name": "batchNumber",  "align": "center", "width": 100,renderer:function(val){
							if (!val)val="";
							return "<input type='text' name='batchList[][batchNumber]' value='"+val+"'/>";
						}},
	                  { "title": "批次数量",  "name": "batchQuantity",  "align": "center", "width": 100,renderer:function(val){
	                	  if (!val)val="0.00";
	                	  return "<input type='text' name='batchList[][batchQuantity]' value='"+val+"'/>";
						}},
	                  ];
	var currentPurchaseOrderNumber;
	var elsAccount='<%=session.getAttribute("elsAccount") %>';
	var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
	var $currentObj;
	var pageData;
	function openBatch(obj) {
		$currentObj = $(obj);
		if (!batchGrid) {
			batchGrid = $('#batch-item').mmGrid({
    	        cols: cols_batch,
    	        checkCol:true,
    	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
    	        items: []
    	    });
		}
		$(".dialog-tip").height(100);
		$('#dialog').show();
		//读取json
		var json = $(obj).prev("input").val();
		if (json != "") {
			batchGrid.load(eval(json));
		} else {
			batchGrid.load([]);
		}
	}
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

	$().ready(function(){
		$("#queryBtn").click(function(){
	    	query();
	    });
		$('.dialog-close-btn').click(function(){
	        $('.fixed-dialog').hide();
	    });
	    $('.tip-option-btn').click(function(){
	        $('.dialog-close-btn').trigger('click');
	    });
	    $("#btnFileOK").click(function(){
	    	var batchData = $("#batchForm").serializeJSON();
	    	if (batchData.batchList){
		    	$currentObj.prev("input").val(JSON.stringify(batchData.batchList));
	    	} else {
	    		$currentObj.prev("input").val("");
	    	}
	    });
	    $("#insertItem").click(function(){
	    	batchGrid.addRow({},batchGrid.rowsLength());
	    });
		$("#deleteItem").click(function(){
			var selectedIndexs = batchGrid.selectedRowsIndex();
			if (selectedIndexs.length == 0) {
				alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
				return;
			}
			batchGrid.removeRow(selectedIndexs[0]);
	    });
		$("#saveBtn").click(function(){
			if (itemGrid.rowsLength() == 0) {
				alert("请选择物料",2);
				return;
			}
			var formData = $("#itemForm").serializeJSON();
			pageData = $.extend(true,{},pageData,formData);
			$.ajax({
				url : "<%=basePath%>rest/BomVoucherService/genConsumeVoucher",
				type : "post",
				dataType : "json",
				contentType : "application/json",
				data:JSON.stringify(pageData),
				success : function(data) {
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
					parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10));
				},
				error : function(data) {
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		});
		changeDateArea();
	    $("[name=dateArea]").click(changeDateArea);
		var frm = $("#queryForm");
		headGrid = $('#table-head').mmGrid({
	        cols: cols,
	        url : frm[0].action,
	        params: frm.serializeJSON(),
	        method:  frm[0].method,
	        root:"rows",
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        multiSelect: false,
	        height:"150px",
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
	    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex){
// 	    	var hadSelected = headGrid.selectedRows();
	    	currentPurchaseOrderNumber = item.purchaseOrderNumber;
	    	loadItem(item.toElsAccount,item.saleOrderNumber,item.orderItemNumber);
// 	    	itemIds="";
// 	    	hadSelected.forEach(function(val){
// 	    		itemIds=itemIds+","+val.purchaseOrderNumber;
// 	    	});
// 	    	if(itemIds!=""){
// 	    		itemIds=itemIds.substring(1);
// 	    	}
// 	    	loadItem(itemIds);
		});
	    headGrid.on('loadSuccess',function(e, data) {
	    	if (!itemGrid) {
				itemGrid = $('#table-item').mmGrid({
	    	        cols: cols_item,
	    	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    	        items: []
	    	    });
			}
	    });
	});
	function loadItem(toElsAccount,saleOrderNumber,orderItemNumber) {
		var param = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"saleOrderNumber":saleOrderNumber,"orderItemNumber":orderItemNumber};
		$.ajax({
			url : "<%=basePath%>rest/SaleOrderService/getBomList",
			type : "post",
			dataType : "json",
			contentType : "application/json",
			data:JSON.stringify(param),
			success : function(data) {
				itemGrid.load(data.bomList);
				pageData = data;
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
		if (itemGrid) {
			itemGrid.load([]);
		}
		headGrid.opts.params = frm.serializeJSON();
		headGrid.load({});
	}
</script>
</body>
</html>