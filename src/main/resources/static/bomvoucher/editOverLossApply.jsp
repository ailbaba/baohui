<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
  <div class="box-wrap pos-relative bg-common " id="operateGroup">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
	    <div>
	    	<button id="saveBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
	    	<button id="sendBtn" class="button-wrap">发送</button>
	    </div>
    </div>
</div>
<form id="form" onsubmit="return false;">
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_deliveryorderhead" defaultValue="发货单抬头" /></span>
	<div class="common-box-line">
		<div class="tab-wrap" id="sheet-head">
			<main class="grid-container">
			<div class="grid-100">
				<table id="table-head"></table>
			</div>
			</main>
		</div>
	</div>
</div>
 <div class="box-wrap pos-relative bg-common">
 <div class="tab-wrap" id="sheet-project">
	<div id="sheet-project-one">
    <div class="common-box-line">
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
	var itemGrid;
	var headGrid;
	var height = $(document).height() - 400;
	var itemNumberJson=new Object();
	var cols_head = [{title:"申请编号",name:"applyNumber",align:"center",width:100},
	                 {title:"els号",name:"elsAccount",align:"center",width:120},
	                 {title:"对方els号",name:"toElsAccount",align:"center",width:120},
	                 {title:"申请状态",name:"applyStatus",align:"center",width:100,renderer:function(val){
	                	 return dictionaryFormat(val,"0:未发送;1:已发送未通过;2:已确认")}},
	                 {title:"要求发货时间",name:"deliveryTime",align:"center",width:100,renderer:function(val){
	                	 return dateInputFormat(val,"Y","overLossApplyHeader[deliveryTime]","")}},
	                 {title:"预期发货时间",name:"planDeliveryTime",align:"center",width:100,renderer:function(val){
	                	 return dateInputFormat(val,"R","overLossApplyHeader[planDeliveryTime]","")}}
	                 ];
	var cols = [{title:"申请编号",name:"applyNumber",align:"center",width:100},
	            {title:"材料编号",name:"materialNumber",align:"center",width:100},
	            {title:"材料描述",name:"materialDesc",align:"center",width:140},
	            {title:"申请数量",name:"quantity",align:"center",width:110,renderer:function(val){
	            	if(!val||val=="null") val="0.00";return '<input name="overLossApplyItemList[][quantity]" class="quantity" type="text" value="'+val+'">';}},
	            {title:"材料单位",name:"basicUnit",align:"center",width:100},
	            {title: "bom编号",  "name": "reserveNumber",  "align": "center", "width": 100},
		        {title: "bom项编",  "name": "reserveItemNumber",  "align": "center", "width": 100},
	            {title:"采购订单号",name:"purchaseOrderNumber",align:"center",width:120},
	            {title:"采购订单行号",name:"orderItemNumber",align:"center",width:110},
	            {title:"计划行号",name:"orderItemNumber",align:"center",width:100},
	            { title:'发货工厂', name:'factory' ,width:100, align:'center'},
                { title:'发货库存地点', name:'inventoryLocation' ,width:100, align:'center'},
                { title:'发货工厂名', name:'factoryName' ,width:100, align:'center'},
                { title:'发货库存地点名', name:'inventoryLocationName' ,width:100, align:'center'},
	            { title:'收货工厂', name:'receiptFactory' ,width:100, align:'center',renderer:function(val){
               	 return stringInput(val,"Y","overLossApplyItemList[][receiptFactory]","")}},
                { title:'收货库存地点', name:'receiptInventoryLocation' ,width:100, align:'center',renderer:function(val){
                  	 return stringInput(val,"Y","overLossApplyItemList[][receiptInventoryLocation]","")}},
                { title:'收货工厂名', name:'receiptFactoryName' ,width:100, align:'center',renderer:function(val){
                  	 return stringInput(val,"Y","overLossApplyItemList[][receiptFactoryName]","")}},
                { title:'收货库存地点名', name:'receiptInventoryLocationName' ,width:100, align:'center',renderer:function(val){
                  	 return stringInput(val,"Y","overLossApplyItemList[][receiptInventoryLocationName]","")}},
                {title:"计算单价",name:"price",align:"center",width:100},
	            {title:"结算货币",name:"curreny",align:"center",width:140},
	            {title:"超损金额",name:"exceedLossMoney",align:"center",width:110},
	            {title:"是否通过",name:"isAccept",align:"center",width:100,renderer:function(val){
	            	return dictionaryFormat(val,"0:拒绝;1:通过;")}},
	            {title:"是否发料",name:"isDelivery",align:"center",width:100,renderer:function(val){
	            	return dictionaryInputFormat(val,"Y","overLossApplyItemList[][isDelivery]","0:不发料;1:发料")}}
	            ];
	
	$().ready(function() {
		init();
	});
	var pageData = {};
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	var applyStatus = "<%=request.getParameter("applyStatus")%>";
	var selectedItems = "<%=request.getParameter("selectedItems")%>";
	var applyNumber="<%=request.getParameter("applyNumber")%>";
	function closeCallback() {
	if (parent.frames["iframeApp_bomDeliveryManage"]) {
		parent.frames["iframeApp_bomDeliveryManage"].query();
	}
}
function init(){
	if(!applyNumber||applyNumber=="null"){//如果是新建
		query();
	}else{//如果是修改
		if(applyStatus=="1"){
			$("#operateGroup").css("display","none");
		}
		queryByApplyNumber();
	}
	
	
	//初始化控件
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback);
		} else {
			parent.elsDeskTop.closeCurWin("editDelivery",closeCallback);
		}
	});
	
	$("#saveBtn").click(function(){
		$("#purchaseInChargeParam").val($("#purchaseInCharge").val());
		var frm = $("#form");
		var formData = frm.serializeJSON();
		pageData = $.extend(true,{},pageData,formData);
		console.log(pageData);
		var url = "<%=basePath%>rest/BomVoucherService/saveOverLossApply";
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :url,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(pageData),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				applyStatus = data.overLossApplyItemList.applyStatus;
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
				pageData = data;
				fillData(data);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
				
			}
		});
	});
	$("#sendBtn").click(function(){
		if(applyStatus=="1"){
			alert("不能重复发送申请！",2);
			return ;
		}
		//订单状态
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			var frm = $("#form");
			var formData = frm.serializeJSON();
			pageData = $.extend(true,{},pageData,formData);
			console.log(pageData);
			var url = "<%=basePath%>rest/BomVoucherService/sendOverLossApply";
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(pageData),
				dataType : "json",
				success : function(data) {
					if(data!=null&&data.statusCode=="-100"){
						alert(data.message,2);
					}else{
						parent.elsDeskTop.hideLoading();
						pageData = data;
						applyStatus = data.overLossApplyItemList.applyStatus;
						fillData(data);
						$("#operateGroup").css("display","none");
						alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
					
				}
			});
		}});
	});
}

function query(){
	var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"itemIds":selectedItems};
	//根据行项目获取信息
	$.ajax({
		url : "<%=basePath%>rest/BomVoucherService/getOverLossApplyFromBom",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			pageData = data;
			applyStatus = data.overLossApplyItemList.applyStatus;
			fillData(data);
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});	
}

//更加申请号加载数据
function queryByApplyNumber(){
	var data = {"elsAccount":elsAccount,"applyNumber":applyNumber};
	//根据行项目获取信息
	$.ajax({
		url : "<%=basePath%>rest/BomVoucherService/getOverLossApplyByApplyNumber",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			pageData = data;
			applyStatus = data.overLossApplyHeader.applyStatus;
			fillData(data);
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});	
}

function fillData(data){
	var header=new Array();
	header.push(data.overLossApplyHeader);
	if (!headGrid) {
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height:100,
	        items: header
	    });
	} else {
		headGrid.load(header);
	}
	headGrid.on('loadSuccess',function() {
	});
	if (!itemGrid) {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols,
	        checkCol:true,
	        height:height,
	        items: data.overLossApplyItemList
	    });
	} else {
		itemGrid.load(data.overLossApplyItemList);
	}
	itemGrid.on('loadSuccess',function(e, d) {
	
	});
}

</script>
</body>
</html>