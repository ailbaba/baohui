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
	    	<button id="sendBtn" class="edit-btn button-wrap">确认</button>
	    	<button id="generateBomVoucherBtn" class="edit-btn button-wrap">生成发料单</button>
	   		<button id="searchBtn" class="button-wrap">查询</button>
	    </div>
    </div>
    <div class="common-box-line">
    			<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount }"/>
<!--             	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/> -->
                <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input name="purchaseOrderNumber" type="text"/></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">供应商ELS号: </span><input type="text" name="toElsAccount"/></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">供应商名称: </span><input type="text" name="companyShortName"/></div>
                <div class="dis-in-b input-and-tip"><span>申请状态: </span>
                	<select id="applyStatus" name="applyStatus">
                		<option value="1" selected>待处理</option>
                		<option value="2">已确认</option>
                		<option value="3">已生成发料单</option>
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
	var pageData={};
	var cols_head = [{title:"申请编号",name:"applyNumber",align:"center",width:100},
	                 {title:"els号",name:"elsAccount",align:"center",width:120},
	                 {title:"对方els号",name:"toElsAccount",align:"center",width:120},
	                 {title:"申请状态",name:"applyStatus",align:"center",width:100,renderer:function(val){
	                	 return dictionaryFormat(val,"0:未发送;1:已发送未通过;2:已确认;3:已生成发料单")}},
	                 {title:"要求发货时间",name:"deliveryTime",align:"center",width:118,renderer:function(val){
	                	 return dateFormat(val,"yyyy-MM-dd")}},
	                 {title:"预期发货时间",name:"planDeliveryTime",align:"center",width:118,renderer:function(val){
	                	 return dateInputFormat(val,"Y","header[][planDeliveryTime]","")}}
	                 ];
	var cols = [{title:"申请编号",name:"applyNumber",align:"center",width:100},
	            {title:"材料编号",name:"materialNumber",align:"center",width:100},
	            {title:"材料描述",name:"materialDesc",align:"center",width:120},
	            {title:"申请数量",name:"quantity",align:"center",width:100},
	            {title:"是否通过",name:"isAccept",align:"center",width:100,renderer:function(val){
	            	return	dictionaryInputFormat(val,"Y","overLossApplyItemList[][isAccept]","0:拒绝;1:通过")}},
		        {title:"是否发料",name:"isDelivery",align:"center",width:100,renderer:function(val){
		            	return dictionaryFormat(val,"0:不发料;1:发料")}},
	            {title:"材料单位",name:"basicUnit",align:"center",width:100},
	            {title: "bom编号",  "name": "reserveNumber",  "align": "center", "width": 100},
		        {title: "bom项编",  "name": "reserveItemNumber",  "align": "center", "width": 100},
	            {title:"采购订单号",name:"purchaseOrderNumber",align:"center",width:120},
	            {title:"采购订单行号",name:"orderItemNumber",align:"center",width:110},
	            {title:"计划行号",name:"orderItemNumber",align:"center",width:110},
	            { title:'发货工厂', name:'factory' ,width:100, align:'center',renderer:function(val){
                 	 return stringInput(val,"Y","overLossApplyItemList[][factory]","")}},
                { title:'发货库存地点', name:'inventoryLocation' ,width:100, align:'center',renderer:function(val){
                 	 return stringInput(val,"Y","overLossApplyItemList[][inventoryLocation]","")}},
                { title:'发货工厂名', name:'factoryName' ,width:100, align:'center',renderer:function(val){
                 	 return stringInput(val,"Y","overLossApplyItemList[][factoryName]","")}},
                { title:'发货库存地点名', name:'inventoryLocationName' ,width:100, align:'center',renderer:function(val){
                 	 return stringInput(val,"Y","overLossApplyItemList[][inventoryLocationName]","")}},
	            { title:'收货工厂', name:'receiptFactory' ,width:100, align:'center'},
                { title:'收货库存地点', name:'receiptInventoryLocation' ,width:100, align:'center'},
                { title:'收货工厂名', name:'receiptFactoryName' ,width:100, align:'center'},
                { title:'收货库存地点名', name:'receiptInventoryLocationName' ,width:100, align:'center'},
                {title:"计算单价",name:"price",align:"center",width:100,renderer:function(val){
                	 return stringInput(val,"Y","overLossApplyItemList[][price]","")}},
	            {title:"结算货币",name:"curreny",align:"center",width:100,renderer:function(val){
                	 return dictionaryInputFormat(val,"Y","overLossApplyItemList[][curreny]","CNY:CNY;HKD:HKD;USD:USD;JPY:JPY;EUR:EUR;TWD:TWD;KER:KER")}},
	            {title:"超损金额",name:"exceedLossMoney",align:"center",width:100}
	            ];
	
	$().ready(function() {
		query();
		
		//查找
		$("#searchBtn").click(function(){
			query();
		});
		
		//确认申请
		$("#sendBtn").click(function(){
			send();
		});
		
		//生成发货单
		$("#generateBomVoucherBtn").click(function(){
			generateBomVoucher();
		});
	});
	
	//根据条件获取申请头
	function query(){
		if (!headGrid) {
	 		headGrid = $('#table-head').mmGrid({
	 	        cols: cols_head,
// 	 	       	multiSelect:true,
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
	
	//加载申请行
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
	
	//确认
	function send(){
		var haederArr=headGrid.selectedRows();
		var indexs=headGrid.selectedRowsIndex();
		if(haederArr.length<=0){
			alert("请选择发送的申请项！",2);
			return;
		}
		if(haederArr.length>1){
			alert("只能选择一项申请单发送！",2);
			return;
		}
		if(haederArr[0].applyStatus=="2"){
			alert("已确认申请不可再次确认！",2);
			return;
		}
		var itemHeader=itemGrid.rows();
		var fromData=$("#form").serializeJSON();
		var planDeliveryTime=fromData["header"][indexs[0]];
		fromData["header"]="";
		haederArr[0]["planDeliveryTime"]=planDeliveryTime.planDeliveryTime;
		pageData["overLossApplyHeader"]=haederArr[0];
		pageData["overLossApplyItemList"]=itemHeader;
		pageData = $.extend(true,{},pageData,fromData);
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		var url = "<%=basePath%>rest/BomVoucherService/confirmOverLossApply";
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :url,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(pageData),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data!=null&&data.statusCode=="-100"){
					alert(data.message,2);
				}else{
					applyStatus = data.overLossApplyItemList.applyStatus;
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
					pageData = data;
					query();
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
				
			}
		});
		}});
	}
	
	//生成发货单
	function generateBomVoucher(){
		var haederArr=headGrid.selectedRows();
		if(haederArr.length<=0){
			alert("请选择发送的申请项！",2);
			return;
		}
		if(haederArr[0].applyStatus!="2"){
			alert("只有确定状态才能生成发料单！",2);
			return;
		}
		var itemHeader=itemGrid.rows();
		pageData["overLossApplyHeader"]=haederArr[0];
		pageData["overLossApplyItemList"]=itemHeader;
// 		pageData = $.extend(true,{},pageData,$("#form").serializeJSON());
		console.log(pageData);
		var items=pageData["overLossApplyItemList"];
		var newItem=new Array();
		for(var i=0; i<items.length;i++){
			var item=items[i];
			if(item.isAccept=="1"&&item.isDelivery=="1"){
				newItem.push(item);
			}
		}
		if(newItem.length<=0){
			alert("没有符合生成发料单的条件",2);
			return ;
		}
		pageData["overLossApplyItemList"]=newItem;
		console.log(pageData);
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			var url = "<%=basePath%>rest/BomVoucherService/generateBomVoucherFromOverLossApply";
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(pageData),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data!=null&&data.statusCode=="-100"){
						alert(data.message,2);
					}else{
						alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
						pageData = data;
						query();
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
					
				}
			});
			}});
	}
	
	
</script>
</body>
</html>