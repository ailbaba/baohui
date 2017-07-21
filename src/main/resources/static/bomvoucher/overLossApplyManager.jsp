<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
 <form id="form" onsubmit="return false;">
  <div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
	    <div>
	    	<button id="updateBtn" class="edit-btn button-wrap">修改</button>
	   		<button id="searchBtn" class="button-wrap">查询</button>
	    </div>
    </div>
    <div class="common-box-line">
    			<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount }"/>
<!--             	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/> -->
                <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input name="purchaseOrderNumber" type="text"/></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">采购方ELS号: </span><input type="text" name="toElsAccount"/></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">采购方名称: </span><input type="text" name="companyShortName"/></div>
                <div class="dis-in-b input-and-tip"><span>申请状态: </span>
                	<select id="applyStatus" name="applyStatus">
                		<option value="0">未发送</option>
                		<option value="1" selected>已发送待处理</option>
                		<option value="2">对方已确认</option>
                	</select>
                </div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">申请日期：</span></div>
                <input type="text" class="Wdate" onfocus="WdatePicker()" id="startDeliveryDate" name="startDeliveryDate"/>
                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endDeliveryDate" class="Wdate" onfocus="WdatePicker()" name="endDeliveryDate" />
            </div>
</div>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_deliveryorderhead" defaultValue="发货单抬头" /></span>
	<div class="common-box-line">
		<div class="tab-wrap" id="sheet-head">
			<main class="grid-container">
			<div class="grid-100">
				<table id="table-head"></table>
				<div id="pg" style="text-align: right;"></div>
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
	var applyStatus="";
	var selectApplyNumber="";
	var cols_head = [{title:"申请编号",name:"applyNumber",align:"center",width:100},
	                 {title:"els号",name:"elsAccount",align:"center",width:120},
	                 {title:"对方els号",name:"toElsAccount",align:"center",width:120},
	                 {title:"申请状态",name:"applyStatus",align:"center",width:100,renderer:function(val){
	                	 return dictionaryFormat(val,"0:未发送;1:已发送未通过;2:通过;3:拒绝")}},
	                 {title:"要求发货时间",name:"deliveryTime",align:"center",width:110,renderer:function(val){
	                	 return dateFormat(val,"yyyy-MM-dd")}},
	                 {title:"预期发货时间",name:"planDeliveryTime",align:"center",width:110,renderer:function(val){
	                	 return dateFormat(val,"yyyy-MM-dd")}}
	                 ];
	var cols = [{title:"申请编号",name:"applyNumber",align:"center",width:100},
	            {title:"材料编号",name:"materialNumber",align:"center",width:100},
	            {title:"材料描述",name:"materialDesc",align:"center",width:140},
	            {title:"申请数量",name:"quantity",align:"center",width:100},
	            {title:"材料单位",name:"basicUnit",align:"center",width:100},
	            {title: "bom编号",  "name": "reserveNumber",  "align": "center", "width": 100},
		        {title: "bom项编",  "name": "reserveItemNumber",  "align": "center", "width": 100},
	            {title:"采购订单号",name:"purchaseOrderNumber",align:"center",width:120},
	            {title:"采购订单行号",name:"orderItemNumber",align:"center",width:110},
	            {title:"计划行号",name:"orderItemNumber",align:"center",width:110},
	            { title:'发货工厂', name:'factory' ,width:100, align:'center'},
                { title:'发货库存地点', name:'inventoryLocation' ,width:100, align:'center'},
                { title:'发货工厂名', name:'factoryName' ,width:100, align:'center'},
                { title:'发货库存地点名', name:'inventoryLocationName' ,width:100, align:'center'},
	            { title:'收货工厂', name:'receiptFactory' ,width:100, align:'center'},
                { title:'收货库存地点', name:'receiptInventoryLocation' ,width:100, align:'center'},
                { title:'收货工厂名', name:'receiptFactoryName' ,width:100, align:'center'},
                { title:'收货库存地点名', name:'receiptInventoryLocationName' ,width:100, align:'center'},
                {title:"计算单价",name:"price",align:"center",width:100},
	            {title:"结算货币",name:"curreny",align:"center",width:110},
	            {title:"超损金额",name:"exceedLossMoney",align:"center",width:110},
	            {title:"是否通过",name:"isAccept",align:"center",width:100,renderer:function(val){
	            	return dictionaryFormat(val,"0:拒绝;1:通过;")}},
	            {title:"是否发料",name:"isDelivery",align:"center",width:100,renderer:function(val){
	            	return dictionaryFormat(val,"0:不发料;1:发料")}}
	            ];
	
	$().ready(function() {
		query();
		
		$("#searchBtn").click(function(){
			query();
		});
		
		$("#updateBtn").click(function(){
			update();
		});
	});
	
	//根据条件获取申请头
	function query(){
		if (!headGrid) {
	 		headGrid = $('#table-head').mmGrid({
	 	        cols: cols_head,
	 	       	url :"<%=basePath%>rest/BomVoucherService/findOverLostApplyHeaderByCondtion",
	 	        params: $("#form").serializeJSON(),
	 	        method:  "post",
	 	        root:"rows",
	 	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	 	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	 	        remoteSort:true,
	 	        checkCol:true,
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
	 		
	 		headGrid.on('loadSuccess',function(e,data) {
		 		if (!itemGrid) {
					itemGrid = $('#table-item').mmGrid({
				        cols: cols,
				        checkCol:true,
				        height:height,
				        items: []
				    });
			 	} 
		 		if (data.rows && data.rows.length > 0) {
					//默认选中第一行
		 			headGrid.select(0);
		 			selectApplyNumber=data.rows[0].applyNumber;
		 			applyStatus=data.rows[0].applyStatus;
		 			loadItem(selectApplyNumber);
		 		}else{
		 			itemGrid.removeRow();
		 		}
		 	});
		 	
		 	headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
		 		selectApplyNumber=item.applyNumber;
	 			applyStatus=item.applyStatus;
	 			itemGrid.removeRow();
	 			loadItem(selectApplyNumber);
		 	});
	 	} else {
	 		headGrid.opts.params = $("#form").serializeJSON();
	 		headGrid.load({});
	 	}
	}
	
	function loadItem(applyNumber){
		var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"applyNumber":applyNumber};
		$.ajax({
			url : "<%=basePath%>rest/BomVoucherService/findOverLostApplyItem",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				itemGrid.load(data);
			},
			error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	}
	
	function update(){
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
		
	   
		if( headGrid.selectedRowsIndex().length<=0||selectApplyNumber==null||selectApplyNumber==""||selectApplyNumber==undefined){
			alert("<i18n:I18n key='i18n_delivery_choosereceivevoucher' defaultValue='请选择申请项！' />",2);
			return;
		}

		var url="<%=basePath%>bomvoucher/editOverLossApply.jsp?applyNumber="+ selectApplyNumber+"&applyStatus="+applyStatus;
	    var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editOverLossApply',
	        'windowTitle':'修改超损申请',
	        'windowSubTitle': companyShortName,
	        'iframSrc':url,
			'windowStatus' : 'maximized',
			'windowMinWidth' : 960,
			'windowMinHeight' : 700,
			'windowWidth' : 960,
			'windowHeight' : 700,
			'parentPanel' : ".currDesktop"
		});	
	}

</script>
</body>
</html>