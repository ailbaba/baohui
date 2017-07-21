<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<base:supplierAuth elsAccount="${param['toElsAccount'] }" authCode="order" toElsAccount="${elsAccount }"></base:supplierAuth>
<body>
	<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
	<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            	<button class="button-wrap" id="seachBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                <button class="button-wrap" id="inputSession"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></button>
             	<!-- <button class="button-wrap" id="updateSchedule"><i18n:I18n key="i18n_button_updateprogress" defaultValue="更新进度" /></button>
             	<button class="editBtn button-wrap" id="downloadBtn" >进度导出</button>
                <button class="button-wrap" id="uploadBtn">进度导入</button>
                <button id="scheduleERPBtn" style="display:none;" class="button-wrap"><i18n:I18n key="" defaultValue="从ERP获取进度" /></button> 
                <button class="button-wrap" id="toErp"><i18n:I18n key="i18n_button_toERP" defaultValue="写入ERP" /></button>
	            <button class="button-wrap" id="exportBtn">订单导出</button>-->
	            <button id="printBtn" class="button-wrap"><i18n:I18n key="i18n_button_print" defaultValue="打印" /></button>
                <!-- <button class="button-wrap" id="scheduleReport"><i18n:I18n key="i18n_label_scheduleReport" defaultValue="订单进度汇总查询报表" /></button>-->
				<button id="columnDefineBtn" class="button-wrap">头<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<button id="itemColumnDefineBtn" class="button-wrap">行<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<button id="addBtn" class="button-wrap"><i18n:I18n key="i18n_delivery_lable_createdelivery" defaultValue="新建发货单" /></button>
				
<!-- 			<input type="checkbox" id="showDelete"/>显示删除行 -->
<%--            <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<input id="saleOrderNumber" name="saleOrderNumbers" type="hidden" />
				<span><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input id="purchaseOrderNumber" name="purchaseOrderNumbers" type="text" />
				<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="销售订单状态" />:</span>
				<select class="orderStatus" id="orderStatus" name="orderStatus">
					<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
					<option value="0"><i18n:I18n key="test" defaultValue="未确认" /></option>
					<option value="1"><i18n:I18n key="test" defaultValue="已确认" /></option>
					<option value="2"><i18n:I18n key="test" defaultValue="已退回" /></option>
					<option value="4"><i18n:I18n key="test" defaultValue="变更已确认" /></option>
					<option value="7"><i18n:I18n key="test" defaultValue="订单更改生产状态" /></option>
				</select>
				</div>
				<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="订单发送状态" />:</span>
				<select class="orderSendStatus" id="orderSendStatus" name="orderSendStatus">
					<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
					<option value="0"><i18n:I18n key="test" defaultValue="未发送" /></option>
					<option value="1"><i18n:I18n key="test" defaultValue="已发送" /></option>
				</select>
				</div>
				<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="订单交收状态" />:</span>
				<select class="deliveryStatus" id="deliveryStatus" name="deliveryStatus">
					<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
					<option value="0"><i18n:I18n key="test" defaultValue="未交收" /></option>
					<option value="1"><i18n:I18n key="test" defaultValue="发送在途" /></option>
					<option value="2"><i18n:I18n key="test" defaultValue="部分交收" /></option>
					<option value="3"><i18n:I18n key="test" defaultValue="全部交收" /></option>
					<option value="4"><i18n:I18n key="test" defaultValue="超额交收" /></option>
				</select>
				</div>
				<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_orderdate" defaultValue="订单日期" />：</span>
                <input type="radio" name="dateArea" value="week"><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" /><input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" /><input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" /><input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate"/><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate" /></div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_saleOrder_head" defaultValue="销售订单头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="saleOrderHeaderGrid">
							<table id="saleOrderHeaderTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_saleOrder_item" defaultValue="销售行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
				 	<ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_title_saleOrder_item" defaultValue="销售行项目" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
<%--                         <li><a href="#sheet-project-three"><i18n:I18n key="i18n_label_deliverySchedule" defaultValue="交货计划" /></a></li> --%>
                    </ul>
					<div id="sheet-project-one" style="padding: 2px;">
						<main class="grid-container">
						<div class="grid-100" id="saleOrderItemGrid">
							<table id="saleOrderItemTable"></table>
						</div>
						</main>
					</div>
					<div id="sheet-project-two" style="padding: 2px;">
                        <main class="grid-container">
		                    <div class="grid-100" id="table-file-grid">
		                        <table id="table-file"></table>
		                    </div>
		                </main>
                    </div>
<!--                     <div id="sheet-project-three" style="padding: 2px;"> -->
<!--                     	<select> -->
<!-- 						<option value="">显示全部</option> -->
<!-- 						</select> -->
<!-- 						<main class="grid-container"> -->
<!-- 							<div class="grid-100" id="saleDeliveryPlanGrid"> -->
<!-- 								<table id="saleDeliveryPlanTable"></table> -->
<!-- 							</div> -->
<!-- 						</main> -->
<!-- 					</div> -->
				</div>
			</div>
		</div>
		<div class="saying-dialog">
            <div class="fl-left left-content pos-relative">
                <div class="dis-block pos-absolute option-bar pre-active next"></div>
            </div>
            <div class="fl-left right-content pos-relative none-active">
                <div class="saying-box-wrap">
                   <iframe class="testIframe" id="chatIframe" frameborder="0" width="100%">
                   </iframe>
                </div>
            </div>
            <div class="clear-both"></div>
    </div>
	</div>
	<script type="text/javascript">
	var peopleList;
	var headGrid;
	var itemGrid;
	var deliveryGrid;
	var chatFromUrlFlag = false;
	var $sob;
	var currentPurchaseOrderNumber;
	var printData ={};
	var elsAccount='<%=session.getAttribute("elsAccount") %>';
	var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
	var toElsAccount=GetQueryString("toElsAccount");
	var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
	var isNull=false;
	var cols;
	var itemIds;
	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
	var itemPurchaseIds;
	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
	
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
		
	  //初始化聊天窗口
	  //ELS账号+订单号 作为 businessID,fbk4采购方,fbk5销售方
	  function initChat(businessID,fbk4, hadSelected) {
		  	debugger;
		    if(!ableToggleInit()) { return; }
	  		//采购凭证号
	  		var purchaseOrderNumberList = [];
	  		//订单号
	  		var bIdList = [];
	  		//聊天显示列表
	  		var chatList = [];
	  		if(hadSelected && hadSelected.length) {
	  			hadSelected.forEach(function(d,i){
	  				var obj ={};
	  				obj[d.purchaseOrderNumber] = d.fbk4 || '' ;
	  				bIdList.push(obj); 
	  				chatList.push(d.purchaseOrderNumber);
	  			});
	  			chatList=chatList.map(function(d){
	  				return {name:d}
	  			});

			}
		    //初始化iframe
	  		 var toElsSubAccount;
	  	  	//多人聊天  type=multi 一对一 type=single  list 用来显示列表人
	  	  	bIdString = bIdList&&bIdList.length?'['+bIdList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	  	peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	  	chatListString = chatList&&chatList.length?'['+chatList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	  	var url = "multiChatTest.jsp?type=multi&fromElsAccount="
	  				+ elsAccount
	  				+ "&fromElsSubAccount="
	  				+ elsSubAccount
	  				+ "&toElsAccount="
	  				+ toElsAccount
	  				+ "&toElsSubAccount="+peopleListString
	  				+ "&businessType=order"
	  				+ "&businessID="+bIdString
	                  + "&list="+ (chatListString&&chatListString.length?chatListString : peopleListString)
	  				+"&t="+new Date().getTime();
	  	   
	  	   $('.testIframe').attr('src','<%=basePath%>'+ url);
	  }
	  
	  $(document).ready(function() {
		  isDisplayIntefaceButton();
		  $("#sheet-project").tabs();
		  //radio操作
		  changeDateArea();
		  $("[name=dateArea]").click(changeDateArea);
		  uploadSchedule();
	  });
	  
// 	$(document).ready(function(){
		var toElsAccount=GetQueryString("toElsAccount");
		$("#toElsAccount").val(toElsAccount);
		$("#elsAccount").val(elsAccount);
		var saleOrderNumber;
		//获取查看消息采购订单号
		var initpurchaseOrderNumber = window.queryChats('q');
   		if(initpurchaseOrderNumber && initpurchaseOrderNumber.length) {
   			if(initpurchaseOrderNumber.lastIndexOf(',')!=-1 ) {
   				$("#purchaseOrderNumber").val(initpurchaseOrderNumber.substring(0,initpurchaseOrderNumber.length-1));
   				$(':radio[name="dateArea"]').eq(0).attr("checked",false);
   				$(':radio[name="dateArea"]').eq(3).attr("checked",true);
   			} else {
//    			$("#purchaseOrderNumber").val(initpurchaseOrderNumber.substring(0,initpurchaseOrderNumber.length));
   				$(':radio[name="dateArea"]').eq(0).attr("checked",false);
   				$(':radio[name="dateArea"]').eq(3).attr("checked",true);
   			}
		}
		//将销售订单表头数据插入表格中
		function insertSaleOrderHeaderTable(){
			$sob = $('.saying-dialog .option-bar');
			$('#saleOrderHeaderGrid').html('<table id="saleOrderHeaderTable"></table><div id="pg" style="text-align: right;"></div>');
			//列
			var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleOrderManage_mt"/>;
			var paramStr={"elsAccount":elsAccount,"toElsAccount":toElsAccount,
					"saleOrderNumbers":$("#saleOrderNumber").val(),
					"purchaseOrderNumbers":$("#purchaseOrderNumber").val().trim(),
					"orderStatus":$("#orderStatus").val(),
					"orderSendStatus":$("#orderSendStatus").val(),
					"deliveryStatus":$("#deliveryStatus").val(),
					"startOrderDate":$("#startOrderDate").val().trim(),
					"endOrderDate":$("#endOrderDate").val().trim()
			};

		    //本地示例
		     headGrid= $('#saleOrderHeaderTable').mmGrid({
		    	 cols: cols,
		         url: "<%=basePath%>rest/SaleOrderService/querySaleOrderHeadByCondtion",
		         params:paramStr,
		         method:'post',
		         root:"rows",
		         loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		         noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		         multiSelect: true,
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
		    
		     headGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
		    	 debugger;
		    	// 动态加载聊天窗口
			    $('body').data('selectHead',headGrid.selectedRows());
		    	var hadSelected = headGrid.selectedRows();
		 		if(hadSelected && hadSelected.length) {
		 			if(chatFromUrlFlag) {
		 				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
		 				if(!ableToggleInit()) {
		 					$sob[0].storeInitChat=function(){initChat(elsAccount+"_"+item.purchaseOrderNumber,item.fbk4,hadSelected)};
		 				} else {
		 					initChat(elsAccount+"_"+item.purchaseOrderNumber,item.fbk4,hadSelected);
		 				}
		 				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 end
		 			}
		     	} else {
		     		// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
		     		if(!ableToggleInit()) {
		     			$sob[0].storeInitChat=function(){initChat()};
	 				} else {
	 					initChat();
	 				}
		     		// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
		     	}
		 		
	        	currentPurchaseOrderNumber = item.purchaseOrderNumber;
		    	saleOrderNumber=item.saleOrderNumber;
		    	 
		     	itemIds="";
		        // 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
		    	itemPurchaseIds="";
		    	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
		     	
		     	hadSelected.forEach(function(val){
		     		itemIds=itemIds+","+val.saleOrderNumber;
		     		// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
		     		itemPurchaseIds=itemPurchaseIds+","+val.purchaseOrderNumber;
		     		// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
		     	});
		     	if(itemIds!=""){
		     		itemIds=itemIds.substring(1);
		     	}
		     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
		     	if(itemPurchaseIds!=""){
			     	itemPurchaseIds=itemPurchaseIds.substring(1);
		     	}
		     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
		     	
		    	insertSaleOrderItemTable(itemIds,itemPurchaseIds);
		    	insertSaleOrderFileTable(1,itemIds,itemPurchaseIds);
		    	insertSaleDeliveryTable(1,itemIds,itemPurchaseIds);
		    	
		     });
		    
		    headGrid.on('loadSuccess',function(e, data) {
		    	if(data.total>0){
		    		isNull=false;
		    		// 动态加载聊天窗口
		    		var flag = window.queryChats('flag');
		    		var chatString = window.queryChats('q');
		    		var chatArr =[];
		    		if(chatString && chatString.length) {
		    			if(chatString.lastIndexOf(',')!=-1 ) {
		    				chatArr = chatString.substring(0,chatString.length-1).split(',');
		    			} else {
		    				chatArr = chatString.substring(0,chatString.length).split(',');
		    			}
					}
		    		var hadSelected = [];
		    		if(flag !='businessObj' || !flag) {
		 					chatArr=chatArr.map(function(d){
		 	   					return {name:d}
		 	   				}); 
		   				var listName = [];
		   				data.rows.forEach(function(d){
		    				if(d.fbk4&&listName.indexOf(d.fbk4)===-1){
		    					listName.push(d.fbk4);
		    				}
		    			});
		   				listName=listName.map(function(d){
		   					return {name:d}
		   				}); 
		   				peopleList = chatArr && chatArr.length?chatArr:listName;
		   				debugger;
		   				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
		   				$sob[0].storeInitChat=function(){initChat()};
		   				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 end
		    		} else if(flag == 'businessObj') {
		    			//订单
		    			var rows = data.rows;
		    			for(var i=0;i < rows.length;i++) {
			   				for(var j=0;j<chatArr.length;j++) {
		       					if(rows[i].purchaseOrderNumber==chatArr[j]) {
		       						headGrid.select(i)
		       					}
		       				}
		    			}
		    			//存储选中的的行数据，用作打印判断
		    			if(headGrid.selectedRows() && headGrid.selectedRows().length) {
		    				$('body').data('selectHead',headGrid.selectedRows());
		    				hadSelected = headGrid.selectedRows()
		    			} else {
		    				hadSelected = chatArr.map(function(d){
		    					return {purchaseOrderNumber:d,fbk4:''};
		    				});
		    			}
		    			peopleList = [];
		    			data.rows.forEach(function(d){
		    				if(d.fbk4&&peopleList.indexOf(d.fbk4)===-1){
		    					peopleList.push(d.fbk4);
		    				}
		    			});
		    			peopleList=peopleList.map(function(d){
		   					return {name:d}
		   				}); 
		    			debugger;
		    			// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
		    			$sob[0].storeInitChat=function(){initChat('','',hadSelected)};
		    			// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 end
		    		}
		    		//打开聊天行选择开关
		    		chatFromUrlFlag = true;
					//初始化聊天控制状态
		            if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
		            $sob.click();
		            currentPurchaseOrderNumber = data.rows[0].purchaseOrderNumber;
		    		saleOrderNumber=data.rows[0].saleOrderNumber;
		    	}

	    		isNull=true;
	    		insertSaleOrderItemTable("");
	    		insertSaleOrderFileTable(1,"");
	    		insertSaleDeliveryTable(1,"");
	    		
	    		//全选事件  @author jiangzhidong @date 20161010 begin
	    	    $('#saleOrderHeaderGrid').find('.mmg-head .checkAll').bind('click',function() {
	    	    	if($(this).attr('checked')) {
	    	    		headGrid.select('all');
    			    	var hadSelected = headGrid.selectedRows();
    			     	itemIds="";
    			     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
    			     	itemPurchaseIds="";
    			     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
    			     	hadSelected.forEach(function(val){
    			     		itemIds=itemIds+","+val.saleOrderNumber;
    			     		// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
    			     		itemPurchaseIds=itemPurchaseIds+","+val.purchaseOrderNumber;
    			     		// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
    			     	});
    			     	if(itemIds!=""){
    			     		itemIds=itemIds.substring(1);
    			     	}
    			     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
    			     	if(itemPurchaseIds!=""){
    			     		itemPurchaseIds=itemPurchaseIds.substring(1);
    			     	}
    			     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
    			     	
    			    	insertSaleOrderItemTable(itemIds,itemPurchaseIds);
    			    	insertSaleOrderFileTable(1,itemIds,itemPurchaseIds);
    			    	insertSaleDeliveryTable(1,itemIds,itemPurchaseIds);
	    	    	} else {
	    	    		headGrid.deselect('all');
    			    	var hadSelected = headGrid.selectedRows();
    			     	itemIds="";
    			     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
    			     	itemPurchaseIds="";
    			     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
    			     	hadSelected.forEach(function(val){
    			     		itemIds=itemIds+","+val.saleOrderNumber;
    			     		// [1003-1696] 销售订单211600000305对应多条采购订单号且销售报表显示重复 @author jiangzhidong @date 20170106 begin
    			     		itemPurchaseIds=itemPurchaseIds+","+val.purchaseOrderNumber;
    			     		// [1003-1696] 销售订单211600000305对应多条采购订单号且销售报表显示重复 @author jiangzhidong @date 20170106 begin
    			     	});
    			     	if(itemIds!=""){
    			     		itemIds=itemIds.substring(1);
    			     	}
    			     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
    			     	if(itemPurchaseIds!=""){
    			     		itemPurchaseIds=itemPurchaseIds.substring(1);
    			     	}
    			     	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
    			    	insertSaleOrderItemTable(itemIds,itemPurchaseIds);
    			    	insertSaleOrderFileTable(1,itemIds,itemPurchaseIds);
    			    	insertSaleDeliveryTable(1,itemIds,itemPurchaseIds);
	    	    	}
	    	    });
	    	    //全选事件  @author jiangzhidong @date 20161010 end
		    });
		}
		
		
		insertSaleOrderHeaderTable();
		
		$("#downloadBtn").click(function(){
			var rows = headGrid.selectedRows();
			if (rows.length == 0) {
				alert("<i18n:I18n key='i18n_pleasechoose' defaultValue='请选择订单' />",2);
				return;
			}
			var purchaseOrderNumbers = "";
			for (var i=0;i< rows.length;i++) {
				purchaseOrderNumbers += rows[i].purchaseOrderNumber + ",";
			}
			purchaseOrderNumbers = purchaseOrderNumbers.substring(0,purchaseOrderNumbers.length - 1);
			window.location.href = "<%=basePath%>rest/OrderScheduleService/downloadTemplateBatch/"+elsAccount+"/"+ toElsAccount + "/" + purchaseOrderNumbers;
		});
		
		//选择物料
		$("#orderType").change(function(){
			filterDeliveryPlan();
		});
		
		//点击查询
		$("#toErp").click(function(){
			toErp();
		});
		
		//点击查询
		$("#seachBtn").click(function(){
			insertSaleOrderHeaderTable();
		});
		$("#updateSchedule").click(function(){
			updateSchedule();
		});
		$("#scheduleERPBtn").click(function(){
	    	if(!checkSelected()){
	    		return;
	    	}
	    	var selected = headGrid.selectedRows()[0];
	    	// 确认后才能获取
	    	if (selected.orderStatus =="0"||selected.orderStatus =="2"||selected.orderStatus =="5") {
	    		alert("订单尚未确认不能获取进度",2);
	    		return;
	    	}
	    	parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url : "<%=basePath%>rest/OrderScheduleService/getErpSchedule/"+elsAccount+"/" + selected.toElsAccount + "/" + selected.purchaseOrderNumber,
	    		contentType : "application/json",
	    		type : "get",
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			if (data&&data.statusCode == "-100") {
	     				alert(data.message,2);
	     			} else {
	     				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
	     			}
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
	    			}
	    		}
	    	});
	    });
		$("#scheduleReport").click(function(){
			//兼容ie 冒泡事件
		    if (event && event.preventDefault) {
		        event.preventDefault();
		        event.stopPropagation();
		    } else {
		        window.event.returnValue = false;
		    }
		    var toCompanyName='<%=new String(request.getParameter("toCompanyName").getBytes("iso-8859-1"),"UTF-8") %>';
		    parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'saleOrderScheduleReport',
		        'windowTitle':'<i18n:I18n key="i18n_label_scheduleReport" defaultValue="订单进度汇总查询报表" />',
		        windowSubTitle: currentPurchaseOrderNumber,
		        'iframSrc':'<%=basePath%>report/saleOrderScheduleReport.jsp?toElsAccount=' + toElsAccount,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
		});
		//将销售订单项数据插入表格中
		function insertSaleOrderItemTable(itemIds,itemPurchaseIds){
			cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleOrderItem_mt"/>;
			//增加删除标识
			cols.push({
				"title":"删除标识",
				"name":"deleteFlag",
				"align":"center",
				renderer:function(val){
					var txt = "";
					if(!val) val="";
					if (val=="C") {
						txt = "删除待确认";
					} else if (val=="X") {
						txt = "已删除";
					}
					return txt;
				}
			});
			if (!itemGrid) {
				itemGrid = $('#saleOrderItemTable').mmGrid({
			        cols: cols,
			        items:[],
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
				itemGrid.on("loadSuccess",function(e,d){
					if (d) {
						initModifyFiled(itemGrid.rows());
					}
				});
			}
			$('#saleOrderItemGrid').html('<table id="saleOrderItemTable"></table>');
			//列
		    if(itemIds==""){
		    	//本地示例
		    	itemGrid.load([]);
		    }else{
		    	var paramStr={"elsAccount":elsAccount,"itemIds":itemIds,"itemPurchaseIds":itemPurchaseIds};
	    		//本地示例
			    $('#saleOrderItemTable').mmGrid({
			        cols: cols,
			        url : "<%=basePath%>rest/SaleOrderService/findSaleOrderItem",			
			        params:paramStr,
		        	method:'post',
		        	loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
				$.ajax({
					url : "<%=basePath%>rest/SaleOrderService/findSaleOrderItem",
					type : "post",
					dataType : "json",
					contentType : "application/json",
					data:JSON.stringify(paramStr),
					success : function(data) {
						$('body').data('findSaleOrderItem',data);
						if (data.length > 200) {
							loadPartItem(0,200,data);
						} else {
							if (itemGrid) {
								itemGrid.load(data);
							} else {
								itemGrid = $('#saleOrderItemTable').mmGrid({
							        cols: cols,
							        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
							        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
							        checkCol:true,
							        items: data
							    });
							}
						}
					},
					error : function(data) {
		    			if (!permissionError(data)) {
		    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		    			}
					}
				});
		    }
		}
		
		function loadPartItem(start,size,data) {
			var array = [];
			for (var i=0;i<size;i++) {
				array[i] = data[start+i];
			}
			start = start + size;
			if (itemGrid) {
				itemGrid.addRows(array);
			} else {
				itemGrid = $('#saleOrderItemTable').mmGrid({
			        cols: cols,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        checkCol:true,
			        items: array
			    });
			}
			if (start < data.length) {
				setTimeout(function(){
					if (data.length - start > 200) {
						loadPartItem(start,200,data);
					} else {
						loadPartItem(start,data.length-start,data);
					}
				},200);
			}
		}
		
		function insertSaleOrderFileTable(status,itemIds,itemPurchaseIds){
			$('#table-file-grid').html('<table id="table-file"></table>');
			var cols_file = [
				             { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
				                 	if (val != "" && val!=null&& val!=elsAccount) {
				                 		return "<i18n:I18n key="i18n_common_purchase;" defaultValue=";采购方;" />";;
				                	} else {
				                		return "<i18n:I18n key="i18n_common_sale;" defaultValue=";销售方;" />";;
				                	} 
				             }},
			                 { title:'<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" />', name:'filePath', width: 80, align: 'center',renderer:function(val,item,index){
			                	 if(!item.fbk1){
			                		 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/downloadServlet?filePath="+ val +"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
			                	 }else{
			                		 var fileType = item.fileType;
			                 		 var fileName = item.fileName+"."+fileType;
			                 		 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/download4OSSServlet?filePath="+ val +"&fileName="+fileName+"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
			                	 }
			                 }},
			                 { title:'<i18n:I18n key="i18n_common_saleels" defaultValue="销售方ELS号" />', name:'elsAccount', width: 150, align: 'center'},
			                 { title:'<i18n:I18n key="i18n_common_purchaseels" defaultValue="采购方ELS号" />', name:'toElsAccount' ,width:150, align:'center'},
			                 { title:'<i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />', name:'purchaseOrderNumber' ,width:200, align:'center'},
			                 { title:'<i18n:I18n key="i18n_common_label_filetype" defaultValue="文件类型" />', name:'orderItemNumber' ,width:100, align:'center',renderer:function(val){
				                 	if (val == ""||val== null) {
				                		return '<i18n:I18n key="i18n_label_headfile" defaultValue="订单头文件" />';
				                	} else{
				                		return '<i18n:I18n key="i18n_label_itemfile" defaultValue="订单项文件" />';
				                	}
				                }},
			                 { title:'<i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="行项目编号" />', name:'orderItemNumber' ,width:150, align:'center'},
			                 { title:'<i18n:I18n key="i18n_common_label_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
			                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态" />', name:'fileStatus' ,width:150, align:'center',renderer:function(val){
			                	 if (val == "0") {
			                 		return '<i18n:I18n key="i18n_label_notSent" defaultValue="未发送" />';
			                 	} else {
			                 		return '<i18n:I18n key="i18n_label_sent" defaultValue="已发送" />';
			                 	} 
			                }}
			             ];
			
			if(itemIds==""){
				//本地示例
			    $('#table-file').mmGrid({
			        cols: cols_file,
			        items:[],
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}else{
				var param={"elsAccount":elsAccount,"itemIds":itemIds};
				//本地示例
			    $('#table-file').mmGrid({
			        cols: cols_file,
			        url : "<%=basePath%>rest/SaleFormFileService/order/findSaleFormFile",
			       method:'post',
			       root:"rows",
					params:param,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}
		}
		
	function insertSaleDeliveryTable(status,itemIds,itemPurchaseIds){
		$('#saleDeliveryPlanGrid').html('<table id="saleDeliveryPlanTable"></table>');
		var cols_delivery = [
		                    {title:'<i18n:I18n key="i18n_label_saleOrderNumber" defaultValue="销售订单号" />', name:'saleOrderNumber' ,width:200, align:'center'},
	                        {title:'<i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />', name:'purchaseOrderNumber' ,width:200, align:'center'},
			 				{title:'行项目号',name:'orderItemNumber', width: 120, align: 'center'},
							{title:'计划行号',name:'orderDeliveryItem', width: 120, align: 'center'},
							{title:'网格值', hidden:true,name:'gridValue', width: 120, align: 'center'},
			                {title:'<i18n:I18n key="i18n_purchaseorder_deliverytime" defaultValue="计划交货时间" />', name:'purchaseDeliveryTimePlan', width: 240, align: 'center',renderer:function(val,item,rowIndex){
			                 if(!val){val = "";}
			                 	val = dateFormat(val);
			                    return val;
			                }},
			                {title:'<i18n:I18n key="i18n_purchaseorder_deliveryquantity" defaultValue="计划交货数量" />', name:'purchaseDeliveryQuantityPlan' ,width:200, align:'center',renderer:function(val){
			                 	if (!val) {val = "0.000";}
			                 	return val;
			                }},
			                {title:'<i18n:I18n key="i18n_saleorder_todeliverytime" defaultValue="客户计划交货时间" />', name:'deliveryTime', width: 240, align: 'center',renderer:function(val){
			                  	if (!val) {val = "";}
			                  	val = dateFormat(val);
			                    return val;
			                }},
				            {title:'<i18n:I18n key="i18n_saleorder_todeliveryquantity" defaultValue="客户计划交货数量" />', name:'deliveryQuantity' ,width:200, align:'center',renderer:function(val){
				                if (!val) {val = "0.000";}
				                return val;
					        }}];
		
		if(itemIds == ""){
			deliveryGrid = $('#saleDeliveryPlanTable').mmGrid({
		        cols: cols_delivery,
		        items:[],
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
		    });
			deliveryGrid.on("loadSuccess",function(e,d){
				getDeliveryItem();
		    });
		}else{
			var param={"elsAccount":elsAccount,"itemIds":itemIds};
		    deliveryGrid = $('#saleDeliveryPlanTable').mmGrid({
		        cols: cols_delivery,
		        url : "<%=basePath%>rest/SaleDeliveryPlanService/findSaleDeliveryPlanList",
		        method:'post',
		        root:"rows",
				params:param,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
		    });
			deliveryGrid.on("loadSuccess",function(e,d){
				getDeliveryItem();
		    });
		}
	}
		
		$("#inputSession").click(function(){
			saleOrderConfirm();
		});
		
		function saleOrderConfirm(){
			if(!checkSelected()){
				return;
			}
			
			//兼容ie 冒泡事件
		    if (event && event.preventDefault) {
		        event.preventDefault();
		        event.stopPropagation();
		    } else {
		        window.event.returnValue = false;
		    }
		    var toCompanyName='<%=request.getParameter("toCompanyName")%>';
		    var purchaseOrderNumber = currentPurchaseOrderNumber;
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'saleOrderConfirm',
		        'windowTitle':'<i18n:I18n key="i18n_title_saleOrder" defaultValue="销售订单" />',
		        windowSubTitle: toCompanyName,
		        'iframSrc':'<%=basePath%>ordermanage/saleorder/saleOrderConfirm.jsp?saleOrderNumber=' + saleOrderNumber + "&purchaseOrderNumber="+purchaseOrderNumber,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
		}
	//窗口初始化
	/* setInterval(function() {
		var dh = $('.saying-dialog .left-content').height()-20;
		$('.saying-dialog  .saying-box-wrap').css({'height': parseInt(dh-2) + 'px'});
		$('.saying-dialog  .saying-box-wrap').find('iframe').css({'height': parseInt(dh-2) + 'px'});
	},10); */
	
	//退出
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback());
		} else {
			parent.elsDeskTop.closeCurWin('OrderManage'+toElsAccount,closeCallback);
		}
	});
	
	function closeCallback() {
// 		if (parent.frames["iframeApp_OrderManage"]) {
// 			parent.frames["iframeApp_OrderManage"].insertSaleOrderHeaderTable();
// 		}
	}
// 	});
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    'iconSrc':'icon/els-icon.png',
		    'windowsId':'subAccountColumnSetting',
		    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		    windowSubTitle: "",
		    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleOrderManage_mt" + "&window=iframeApp_OrderManage"+toElsAccount,
		    windowMinWidth: 480,
		    windowMinHeight: 600,
		    'windowWidth':480,
		    'windowHeight':600,
		    'parentPanel':".currDesktop"
		});
	});
	$("#itemColumnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    'iconSrc':'icon/els-icon.png',
		    'windowsId':'subAccountColumnSetting',
		    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		    windowSubTitle: "",
		    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleOrderItem_mt" + "&window=iframeApp_OrderManage"+toElsAccount,
		    windowMinWidth: 480,
		    windowMinHeight: 600,
		    'windowWidth':480,
		    'windowHeight':600,
		    'parentPanel':".currDesktop"
		});
	});
	function updateSchedule() {
		if(!checkSelected()){
			return;
		}
		
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }

	    var toCompanyName='<%=new String(request.getParameter("toCompanyName").getBytes("iso-8859-1"),"UTF-8") %>';
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editOrderSchedule',
	        'windowTitle':'<i18n:I18n key="i18n_button_viewprogress" defaultValue="查看进度" />',
	        windowSubTitle: currentPurchaseOrderNumber,
	        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderSchedule.jsp?businessElsAccount=' + toElsAccount + "&purchaseOrderNumber="+currentPurchaseOrderNumber,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
	function renderProductionStatus(val,item) {
		if (!val) {
			return "";
		}
		return "<a href=\"javascript:showProductionStatus('"+item.toElsAccount+"','"+item.purchaseOrderNumber+"','"+item.orderItemNumber+"');\">"+val+"</a>";
	}
	function showProductionStatus(els,orderNumber,orderItemNumber) {
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editOrderSchedule',
	        'windowTitle':'<i18n:I18n key="i18n_button_viewprogress" defaultValue="查看进度" />',
	        windowSubTitle: currentPurchaseOrderNumber,
	        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderSchedule.jsp?businessElsAccount=' + els + "&purchaseOrderNumber="+orderNumber+"&orderItemNumber="+orderItemNumber,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
	
	function renderPurchaseType(val,item) {
		if(val == '0')
			return "<i18n:I18n key='i18n_common_select_procurementtype_standard' defaultValue='标准' />";
		else if(val == '1')
			return "<i18n:I18n key='i18n_common_select_procurementtype_restrict' defaultValue='限制' />";
		else if(val == '2')
			return "<i18n:I18n key='i18n_common_select_procurementtype_consignment' defaultValue='寄售' />";
		else if(val == '3')
			return "<i18n:I18n key='i18n_common_select_procurementtype_subcontract' defaultValue='分包' />";
		else if(val == '4')
			return "<i18n:I18n key='i18n_common_select_procurementtype_anunknowncommodity' defaultValue='未知的商品' />";
		else if(val == '5')
			return "<i18n:I18n key='i18n_common_select_procurementtype_thirdparty' defaultValue='第三方' />";
		else if(val == '6')
			return "<i18n:I18n key='i18n_common_select_procurementtype_text' defaultValue='文本' />";
		else if(val == '7')
			return "<i18n:I18n key='i18n_common_select_procurementtype_stocktransfer' defaultValue='库存转储' />";
		else if(val == '8')
			return "<i18n:I18n key='i18n_common_select_procurementtype_commoditytype' defaultValue='商品类目' />";
		else if(val == '9')
			return "<i18n:I18n key='i18n_common_select_procurementtype_service' defaultValue='服务' />";
		else
			return "";	
	}
	
	function checkSelected(){
		var hadSelected = headGrid.selectedRows();
		if(hadSelected==null){
			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
			return false;
		}else if(hadSelected.length<=0){
			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
			return false;
		}else if(hadSelected.length>1){
			alert('<i18n:I18n key="i18n_alert_onlyOneOrder" defaultValue="只能选择一条订单"/>',2);
			return false;
	 	}else{
	 		saleOrderNumber=hadSelected[0].saleOrderNumber;
	 		currentPurchaseOrderNumber = hadSelected[0].purchaseOrderNumber;
	 	}
		return true;
	}
	
	function toErp(){
		var hadSelected = headGrid.selectedRows();
		if(hadSelected==null){
			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
			return false;
		}else if(hadSelected.length<=0){
			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
			return false;
		}
		var saleOrderNumbers="";
		for(var i=0;i<hadSelected.length;i++){
			console.log(hadSelected[i].saleOrderNumber);
			saleOrderNumbers+=","+hadSelected[i].saleOrderNumber;
		}
		var paramStr={"elsAccount":elsAccount,"toElsAccount":toElsAccount,"itemIds":saleOrderNumbers};
		console.log(JSON.stringify(paramStr));
		$.ajax({
			url : "<%=basePath%>rest/SaleOrderService/toErp",
			type : "post",
			dataType : "json",
			contentType : "application/json",
			data:JSON.stringify(paramStr),
			success : function(data) {
				if (data!=null&&data.statusCode == "-100") {
					alert('<i18n:I18n key="i18n_label_toERPErrorLeft" defaultValue="公司商号为" />'+data.message+'<i18n:I18n key="i18n_label_toERPErrorRight" defaultValue="的订单因找不到供应商ERP编码而未插入" />',2);
				} else {
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
				}
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
		
	}
	$('#exportBtn').click(function() {
		var hadSelected = headGrid.selectedRows();
 		if(hadSelected==null){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}else if(hadSelected.length<=0){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}
 		var saleOrderNumbers = "";
 		for (var i=0;i<hadSelected.length;i++) {
 			saleOrderNumbers += hadSelected[i].saleOrderNumber + ",";
 		}
 		saleOrderNumbers = saleOrderNumbers.substring(0,saleOrderNumbers.length-1);
 		window.location.href = "<%=basePath%>rest/SaleOrderService/exportExcel/"+elsAccount + "/" + saleOrderNumbers;
	});
     //打印
     $('#printBtn').click(function() {
    	 var hadSelected = headGrid.selectedRows();
 		if(hadSelected==null){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}else if(hadSelected.length<=0){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}else if(hadSelected.length>1){
 			alert('只能打印一个订单！',2);
 			return false;
 		}
 		currentPurchaseOrderNumber = hadSelected[0].purchaseOrderNumber;
    	 //判断是调用sap的合同，还是使用我们自己的模板打印
    	 $.ajax({
     		url : "<%=basePath%>rest/PurchaseOrderService/isMyself/"+toElsAccount,
     		type : "get",
     		contentType : "application/json",
     		dataType : "json",
     		success : function(data) {
     			if (data!=null&&data.statusCode == "-100") {
     				alert(data.message,2);
     			}else{
     				if(data=="0"){//使用sap的合同
     					printERP();
     				}else{//使用我们自己的模板生成合同
     					printMyself();
     				}
     			}
     		},
     		error : function(data) {
 	    		alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
     		}
     	});
     });
    
    //打印erp合同
    function printERP(){
    	//打印采购订单
//         	var data = {"purchaseOrderNumber":purchaseOrderNumber,"elsAccount":elsAccount};
        	$.ajax({
        		url : "<%=basePath%>rest/PurchaseOrderService/printERPPurchaseOrde/"+currentPurchaseOrderNumber+"/"+toElsAccount,
        		type : "get",
        		contentType : "application/json",
        		dataType : "json",
        		success : function(data) {
        			if (data!=null&&data.statusCode == "-100") {
        				alert(data.message,2);
        			}else{
        				window.location.href = data.fileName;
        			}
        		},
        		error : function(data) {
    	    		alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
        		}
        	});
    }
	
	//使用自己的模板打印
	function printMyself(){
		debugger;
		// 组合打印数据
		var bodyData = $('body').data();
		var rowsData = (bodyData['findSaleOrderItem']||{});
		var datas = bodyData['selectHead'];
		if(datas && datas.length && rowsData && rowsData.length) {
			datas.forEach(function(d){
				var rows =[];
				rowsData.forEach(function(r){
					if(d.purchaseOrderNumber=== r.purchaseOrderNumber){
						var mixData = $.extend(true,{},d,r);
						rows.push(mixData);
					}
				});
				d.rows = rows;
			});
			$.extend(printData, datas);

			//存储打印需要的数据
			var printWin = parent.elsDeskTop.defineWin({
				'iconSrc':'icon/els-icon.png',
				'windowsId':'ePrintTemplatesManager',
				'windowTitle':'<i18n:I18n key="i18n_windowtitle_orderprint" defaultValue="订单打印" />',
				'iframSrc':'<%=basePath%>ePrintTemplatesManager.jsp',
				'windowStatus': 'maximized',
				'windowMinWidth': 960,
				'windowMinHeight': 700,
				'windowWidth':960,
				'windowHeight':700,
				'parentPanel':".currDesktop"
			});
			printWin.setIframeData(printData);
		}else {
				parent.elsDeskTop.tip.init({
					type: 'alert',displayType: 3,
					message:'<i18n:I18n key="i18n_message_whichordertoprint" defaultValue="您还没选择要打印的表单" />'
				});
			}
	}
	
	
	//判断是否显隐接口按钮
	function isDisplayIntefaceButton(){
		//批量获取erp订单按钮
		$.ajax({
			url :"<%=basePath%>rest/IntefaceService/isExit/" + elsAccount + "/ToErpSaleOrder",
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if(data!=null&&data.statusCode=="-100"){
					$("#toErp").css("display","none");
				}else{
					$("#toErp").css("display","");
				}
			},
			error : function(data) {
//				if (!permissionError(data)) {
//					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
//				}
			}
		});
		$.ajax({
			url :"<%=basePath%>rest/IntefaceService/isExit/" + elsAccount + "/GetERPSchedule",
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if(data!=null&&data.statusCode=="-100"){
					$("#scheduleERPBtn").css("display","none");
				}else{
					$("#scheduleERPBtn").css("display","");
				}
			},
			error : function(data) {
//	 			if (!permissionError(data)) {
//	 				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
//	 			}
			}
	});}
	
	function uploadSchedule() {
		var uploader = WebUploader.create({
		    // swf文件路径
		    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		    auto: true,
		    duplicate :true,
		    accept:{
		    	extensions:"xls,xlsx"
		    },
		    // 文件接收服务端。
		    server: '<%=basePath%>rest/OrderScheduleService/uploadScheduleBatch/' + elsAccount + "/" + toElsAccount,
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#uploadBtn',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false
		});
		
		uploader.on( 'uploadAccept', function( file, response ) {
			if(response.statusCode=="-100"){
				alert("<i18n:I18n key="i18n_alert_importFormatError" defaultValue="导入文件格式不正确" />",3);
			}else{
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
			}
		});
	}
	$("#showDelete").click(function(){
		var itemList = itemGrid.rows();
		if($(this).attr("checked")=="checked") {
			for (var i in itemList) {
				var deleteFlag = itemList[i].deleteFlag;
				if (deleteFlag && deleteFlag == "X") {
					$("#saleOrderItemTable").find("tr").eq(i).show();
				}
			}
		} else {
			for (var i in itemList) {
				var deleteFlag = itemList[i].deleteFlag;
				if (deleteFlag && deleteFlag == "X") {
					$("#saleOrderItemTable").find("tr").eq(i).hide();
				}
			}
		}
	});
	
	function renderIsFinish(val,item){
		if(val && val == "X")
			return "是";
		else
			return "否";
	}
	
	function renderItemIsFinish(val,item){
		if(val && val == "X")
			return "是";
		else
			return "否";
	}
	function renderOrderType(val,item){
		if(val && val == "71")
			return "K3订单";
		else if(val == "sample"){
			return "样品订单";
		}else{
			return "ELS订单";
		}
	}
	
	function getDeliveryItem() {
		$("#orderType").empty();
		var html = "";
		var trs = $("#saleOrderItemTable").find("tr");
		var strArray = new Array(); 
		strArray.push("<option value=''>显示全部</option>");
		for (var i=0;i<trs.length;i++){
			var data = trs.eq(i).data("item");
			if (data && data.saleOrderNumber && data.orderItemNumber != "") {
				strArray.push("<option value='");
				strArray.push(data.saleOrderNumber);
				strArray.push("_");
				strArray.push(data.orderItemNumber);
				strArray.push("'>");
				strArray.push(data.saleOrderNumber);
				strArray.push("_");
				strArray.push(data.orderItemNumber);
				strArray.push("_");
				strArray.push(data.purchaseMaterialDesc);
				strArray.push("</option>");
			}
		}
		$("#orderType").append(String.prototype.concat.apply("", strArray));
/* 		filterDeliveryPlan(); */
	}
	
	function filterDeliveryPlan() {
		if(deliveryGrid.rowsLength() > 0){
			var orderItemNumber = $("#orderType").val();
			if(orderItemNumber == ""){
				$("#saleDeliveryPlanTable").find("tr").each(function(){
					$(this).css("display","");
				});
			}else{
				$("#saleDeliveryPlanTable").find("tr").each(function(){
					var data = $(this).data("item");
					var matchNumber = data.saleOrderNumber + "_" + data.orderItemNumber;
					if (matchNumber == orderItemNumber) {
						$(this).css("display","");
					} else {
						$(this).css("display","none");
					}
				});
			}
			deliveryGrid.deselect("all");
		}
	}
	
	function initModifyFiled(itemList) {
		var map = {};
		for (var i in cols) {
			map[cols[i].name] = i;
		}
		var showDeleteFlag = false;
		if ($("#showDelete").attr("checked") == "checked") {
			showDeleteFlag = true;
		}
		for (var i in itemList) {
			var fbk50 = itemList[i].fbk50;
			if (fbk50) {
				var changeFields = fbk50.split(",");
				for (var j in changeFields) {
					if (changeFields[j]=="materialNumber"||changeFields[j]=="materialDesc") {
						changeFields[j] = "purchaseM" + changeFields[j].substring(1);
					}
					$("#saleOrderItemTable").find("tr").eq(i).find("td").eq(parseInt(map[changeFields[j]])).css("background","yellow");
				}
			}
			// 删除待确认的标识
			if (itemList[i].deleteFlag && itemList[i].deleteFlag=="C") {
				$("#saleOrderItemTable").find("tr").eq(i).find("td").css("background","yellow");
			}
			if (itemList[i].deleteFlag && itemList[i].deleteFlag=="X") {
				$("#saleOrderItemTable").find("tr").eq(i).css("background-color","rgba(213, 58, 58, 0.0980392)");
				if (!showDeleteFlag) {
					$("#saleOrderItemTable").find("tr").eq(i).hide();
				}
			}
		}
	}
	
	function initShowFile(val,item,index){
		var showText='';
		if(!val){
			return "";
		}else{
			var fileArray = val.split(";");
			for(var i in fileArray){
				var file = fileArray[i];
				showText += file.substring(file.indexOf("_")+1,file.length)+";"
			}
			showText=showText.substring(0,showText.length-1);
		}
		return '<span class="click-showFile" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	}
	
	//查看附件
	$(".click-showFile").live("click", function(){
		var sanContent = $(this).next().text();
	    var item = JSON.parse(sanContent);
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',	
	        'windowsId':'showFileInfo',
	        'windowTitle':'文件详情列表',
	        'windowSubTitle': companyShortName,
	        'iframSrc':'<%=basePath%>filemanage/showFileInfo.jsp?fileNumber='+item.fbk27+'&toElsAccount='+item.toElsAccount,
	        'showAdv': false,
	        'windowStatus': 'regular',
	        'windowMinWidth': 960,
	        'windowMinHeight': 500,
	        'windowPositionTop':20,
	        'windowWidth':960,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
	});
	
	//20170412 发货相关
	$("#addBtn").click(function(){
		addDelivery();
	});
	
	function addDelivery() {
		var headRows = headGrid.selectedRows();
		for(var i = 0 ; i< headRows.length ; i++){
			if (headRows[i].orderType != "sample") {
				alert("<i18n:I18n key='' defaultValue='只能选择样品订单发货'/>",2);
				return;
			}
		}
		var rows = itemGrid.rows();
		if (rows.length == 0) {
			alert("<i18n:I18n key='i18n_refund_chooseitem' defaultValue='请选择行项目' />",2);
			return;
		}
		var toElsAccount = rows[0].toElsAccount;
		var flag = true;
		var isExit=false;
		var selectedItems = "";
// 		if(rows.length==itemGrid.rows().length){//如果是全选
// 			if(confirm("是否选择全部符合条件的订单项？")){
// 				$.ajax({
<%-- 					url :'<%=basePath%>rest/MaterialVoucherService/getSelectItemStr', --%>
// 					type :"post",
// 					contentType : "application/json",
// 					async:false,
// 					data : JSON.stringify(outParam),
// 					dataType : "json",
// 					success : function(data) {
// 						if(data!=null&&data.statusCode=="-100"){
// 							alert(data.message,2);
// 							isExit=true;
// 						}else{
// 							selectedItems=data.itemIds+"";
// 						}
// 					},
// 					error : function(data) {
// 						alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
// 						isExit=true;
// 					}
// 				});
// 			}else{
// 				for (var i=0;i< rows.length;i++) {
// 					if (rows[i].toElsAccount != toElsAccount) {
// 						flag = false;
// 					}
// 					selectedItems += rows[i].saleOrderNumber + "-" + rows[i].orderItemNumber + ",";
// 				}
// 			}
// 		}else{//如果不是全选
			//判断是否是一个客户的订单
			for (var i=0;i< rows.length;i++) {
				if (rows[i].toElsAccount != toElsAccount) {
					flag = false;
				}
				if(rows[i].quantity == "0" || rows[i].quantity == null ){
					alert("<i18n:I18n key='' defaultValue='订单数量为0不能发货'/>",2);
					return;
				}
				selectedItems += rows[i].saleOrderNumber + "-" + rows[i].orderItemNumber + ",";
			}
// 		}
		
		if (!flag) {//如果不是同一个客户
			alert("<i18n:I18n key='i18n_delivery_toelsmustbesame' defaultValue='只能选择同一客户的订单行项目' />",2);
			return;
		}
		if(isExit){//如果全选查询失败
			return;
		}
		selectedItems = selectedItems.substring(0,selectedItems.length - 1);
		//创建发货单
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editDelivery',
	        'windowTitle':'<i18n:I18n key="i18n_delivery_lable_createdelivery" defaultValue="新建发货单" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>ordermanage/materialVoucher/editDelivery.jsp?toElsAccount='+toElsAccount+'&selectedItems=' + selectedItems,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}

</script>
</body>
</html>