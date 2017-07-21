<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_saleOrderStatus" defaultValue="订单状态" /></span>
			<div class="common-box-line">
				<label id="status"></label>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />： </span><select id="operateType">
						<option value="1"><i18n:I18n key="i18n_label_confirm" defaultValue="确认" /></option>
						<option value="2"><i18n:I18n key="i18n_saleorder_return" defaultValue="退回" /></option>
						<option value="7"><i18n:I18n key="i18n_label_updateProductionStatus" defaultValue="更改生产状态" /></option>
					</select>
				</div>
<!-- 				<div class="dis-in-b input-and-tip"> -->
<!-- 					<span>对方子账号：</span><select id="otherSubAccount"></select> -->
<!-- 				</div> -->
				<button class="button-wrap" id="send"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
				<button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
	            <button id="printBtn" class="button-wrap"><i18n:I18n key="i18n_button_print" defaultValue="打印" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_saleOrder_head" defaultValue="销售订单头" /></span>
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
		<form id="saleOrderForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<ul>
						<li><a href="#sheet-project-one"><i18n:I18n key="i18n_title_saleOrder_item" defaultValue="销售行项目" /></a></li>
						<li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
						<li id="deliveryTab"><a href="#sheet-project-three"><i18n:I18n key="i18n_label_deliverySchedule" defaultValue="交货计划" /></a></li>
					</ul>
					<div id="sheet-project-one" style="padding: 2px;">
						<button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
<%-- 						<button style="margin-left: 10px;margin-bottom:10px;" id="fillTime" class="button-wrap"><i18n:I18n key="i18n_label_fillcolumn" defaultValue="填充列" /></button> --%>
<%-- 						<button style="margin-left: 10px;margin-bottom:10px;" id="btnBom" class="button-wrap"><i18n:I18n key="i18n_common_button_viewbom" defaultValue="查看BOM" /></button> --%>
<!-- 						<input type="checkbox" id="showDelete"/>显示删除行 -->
						<main class="grid-container">
							<input type="hidden" name="companyShortName"value="<%=session.getAttribute("companyShortName")%>" /> 
							<input type="hidden" class="elsAccountParam" name="elsAccount" /> 
							<input type="hidden" class="fbk5Param" name="fbk5" /> 
							<input type="hidden" class="orderStatusParam" name="orderStatus" />
							<input type="hidden" class="elsSubAccountParam" name="elsSubAccount" /> 
							<input type="hidden" class="saleOrderNumberParam" name="saleOrderNumber" /> 
							<input type="hidden" class="orderItemNumberParam" name="orderItemNumber" />
							<input type="hidden" class="fbk29Param" name="fbk29" />
							<div class="grid-100" id="saleOrderItemGrid">
								<table id="saleOrderItemTable"></table>
							</div>
						</main>
					</div>
					<div id="sheet-project-two" style="padding: 2px;">
						<div class="common-box-line p-zero">
							<div class="pos-relative upload-wrap">
								<div class="pos-absolute file-list">
									<div class="file-list-head">
										<i18n:I18n key="i18n_common_lable_filelist" defaultValue="表单文件列表" />：<span></span>
									</div>
									<main class="grid-container">
									<div class="grid-100">
										<table id="table-file"></table>
									</div>
									</main>
								</div>
								<div class="file-scan">
									<div class="file-option-zoom">
										<div class="dis-in-b text-left">
											<button id="btnAddFile" class="button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button>
											<button id="btnModifyFile" class="button-wrap"><i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改文件" /></button>
											<button id="btnDeleteFile" class="button-wrap"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button>
										</div>
										<div class="dis-in-b text-right">
											<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
											<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
<%-- 										<button class="button-wrap" id="sendForm"><i18n:I18n key="i18n_label_sendformfile" defaultValue="发送表单文件" /></button> --%>
										</div>
									</div>
									<div class="file-display" id="file-display">
										<a id="viewerPlaceHolder"></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="sheet-project-three" style="padding: 2px;">
						<div class="common-box-line">
							<div class="dis-in-b input-and-tip">
<%-- 								<span><i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="请选择行项目" />：</span> --%>
<!-- 								<select id="orderType"> -->
<!-- 								</select> -->
<%-- 								<button class="button-wrap" id="deleteItem"><i18n:I18n key="i18n_common_button_removeline" defaultValue="删除" /></button> --%>
<%-- 								<button class="button-wrap" id="addItem"><i18n:I18n key="i18n_common_button_addlinebottom" defaultValue="添加" /></button> --%>
<%-- 								<button id="btnPlanUpload" class="button-wrap btnUpload"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="excel上载交货计划" /></button> --%>
<%-- 								<button id="btnPlanTempDownload" class="edit-btn button-wrap btnUpload"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="下载导入模板" /></button> --%>
<%-- 								<button class="button-wrap" id="save"><i18n:I18n key ="i18n_button_save" defaultValue="保存" /></button> --%>
							</div>
							<main class="grid-container">
								<div class="grid-100" id="saleDeliveryPlanGrid">
									<table id="saleDeliveryPlanTable"></table>
								</div>
							</main>
						</div>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
	<div class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" /> <span
					id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件分类" />：</span> <select id="operTypeSelector"
								onchange="loadOrderItem()">
								<option value="0"><i18n:I18n key="i18n_common_select_head" defaultValue="按订单头" /></option>
								<option value="1"><i18n:I18n key="i18n_common_select_item" defaultValue="按订单行" /></option>
							</select>
						</div>
						<div id="divOrderItem" class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="请选择行项目" />：</span> <select id="orderItemSelector"
								name="orderItemNumber">
							</select>
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span><input id="fileName" name="fileName"
								type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /></div></span>
							<input id="filePath" name="filePath" type="hidden" />
						</div>
						<input id="fileType" name="fileType" type="hidden" />
					</div>
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	var winId = "<%= request.getParameter("winId") %>";
	var saleOrderNumber=GetQueryString("saleOrderNumber");
	var purchaseOrderNumber=GetQueryString("purchaseOrderNumber");
	var toElsAccount;
	var headGrid;
	var itemGrid;
	var printData ={};
	var deliveryGrid;
	var fileGrid;
	var formId;
	var fileName;
	var fileStatus;
	var orderItemNumber;
	var fileUploader;
	var planUploader;
	var purchaseOrderNumber;
	var orderItem;
	var cols;
	var selector = '<base:subAccount role='sale' elsAccount='${elsAccount }' type='multiple' name='purchaseOrderHeaderVO[fbk5]' id='fbk5' ></base:subAccount>';
	var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="confirmSaleOrder_mt"/>;
	
	$(document).ready(function() {
		$("#sheet-head").tabs();
		$("#sheet-project").tabs();
	});
		//初始化表单文件列表
		initFileTable();
		
		//得到订单头部信息
		function getSaleOrderHeadBySaleOrderNumber(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/SaleOrderService/getSaleOrderHeadBySaleOrderNumber",
				type :"POST",
				contentType : "application/json",
				data : '{"elsAccount":"'+elsAccount+'","purchaseOrderNumber":"'+purchaseOrderNumber+'"}',
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					toElsAccount=data.toElsAccount;
					purchaseOrderNumber=data.purchaseOrderNumber;
					if (data.fbk15 == 'Y') {
						var back = [{ title:'<i18n:I18n key="i18n_common_refundorder" defaultValue="退货订单" />',name:'fbk15' ,width:100, align:'center',renderer:function(val){
							return "<font color='red'><i18n:I18n key='i18n_common_refundorder' defaultValue='退货订单' /></font>";
						}},{ title:'<i18n:I18n key="i18n_common_practicalrefunds" defaultValue="实物退货" />',name:'fbk16' ,width:100, align:'center',renderer:function(val){
							if (val=="Y") {
								return "<i18n:I18n key='i18n_common_yes' defaultValue='是' />";
							} else {
								return "<i18n:I18n key='i18n_common_no' defaultValue='否' />";
							}
						}}];
						cols_head = back.concat(cols_head);
					}
					insertSaleOrderHeader(data);
					$("#status").html(showSaleOrderStatus(data.orderStatus,data.deliveryStatus));
					//如果已经确认过,则此次只能更新生产状态
					if(data.orderStatus == 1 || data.orderStatus == 7){
						$(".orderStatusParam").val(7);
						$("#operateType").val(7);
						$("#operateType").attr("disabled",true);
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}
		
		// 填入订单头信息
		function insertSaleOrderHeader(data){
			var date = new Date().format("yyyy-MM-dd");
			headGrid = $('#table-head').mmGrid({
		        cols: cols_head,
		        height: 100,
		        items:[data]
		    });
			
			headGrid.on('loadSuccess',function(e, d) {
				$('body').data('selectHead',headGrid.rows(0));
				$("#fbk5").css("display","");
				if (data.fbk5) {
					$("#fbk5").find("option").each(function(){
						if (data.fbk5.indexOf($(this).val()) != -1) {
							$(this).attr("selected","selected");
						}
					});
				}else{
					$("#fbk5").find("option").each(function(){
						if (elsSubAccount.indexOf($(this).val().split("_")[0]) != -1) {
							$(this).attr("selected","selected");
						}
					});
				}
				
				
				$("#fbk5").SumoSelect({optAfter:'#sheet-head ',optCancel:'#sheet-head .mmg-bodyWrapper'});
				$(".SlectBox").each(function(){
					$(this).css("width",$(this).parent().parent().parent().width()-18);
				});
				
				//显示交货计划
				itemIds="";
		        // 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 begin
		    	itemPurchaseIds="";
		    	// 1003-1696 销售订单号重复 @author jiangzhidong @date 20170106 end
		     	var hadSelected = headGrid.rows(0);
		     	currentPurchaseOrderNumber = hadSelected[0].purchaseOrderNumber;
		    	saleOrderNumber=hadSelected[0].saleOrderNumber;
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
		     	insertSaleDeliveryTable(1,itemIds,itemPurchaseIds);
			});
		}

		//显示当前销售订单状态
		function showSaleOrderStatus(orderStatus,deliveryStatus){
			var str="<i18n:I18n key="i18n_label_currentStatus" defaultValue="目前状态" />：<i18n:I18n key="i18n_title_saleOrder" defaultValue="销售订单" />";
			if(orderStatus==0){//销售订单未确认
				return str+=" --> <i18n:I18n key="i18n_saleorder_notconfirm" defaultValue="未确认" />";
			}else if(orderStatus==1){//订单已确认
				str+=" --> <i18n:I18n key="i18n_saleorder_confirmed" defaultValue="已确认" />";
			}else if(orderStatus==7){//订单更改生产状态
				str+=" --> <i18n:I18n key="i18n_label_updateProductionStatus" defaultValue="更改生产状态" />";
			}else if(orderStatus==2){//销售订单已退回
				return str+=" --> <i18n:I18n key="i18n_saleorder_return" defaultValue="退回" />";
			}
			
			if(deliveryStatus==0){//未交收
				str+=" --> <i18n:I18n key="i18n_label_noDelivery" defaultValue="未交收" />";
			}else if(deliveryStatus==1){//订单发送在途
				str+=" --> <i18n:I18n key="i18n_label_deivery" defaultValue="发货在途" />";
			}else if(deliveryStatus==2){//部分交收
				str+=" --> <i18n:I18n key="i18n_label_partDeivery" defaultValue="部分交收" />";
			}else if(deliveryStatus==3){//全部交收
				str+=" --> <i18n:I18n key="i18n_label_allDeivery" defaultValue="全部交收" />";
			}else if(deliveryStatus==4){//超额交收
				str+=" --> <i18n:I18n key="i18n_label_superDeivery" defaultValue="超额交收" />";
			}
			return str;
		}
		
		getSaleOrderHeadBySaleOrderNumber();
		
		//将销售订单项数据插入表格中
		function insertSaleOrderItemTable(){
			var paramStr={"elsAccount":elsAccount,"purchaseOrderNumber":purchaseOrderNumber};
			//列
			cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="confirmSaleOrderItem_mt"/>;
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
					return txt + "<input name='saleOrderItemList[][deleteFlag]' type='hidden' class='deleteFlag' value='"+val+"'/>";
				}
			});
			$.ajax({
				url : "<%=basePath%>rest/SaleOrderService/querySaleOrderItemsByHead",
				type : "post",
				dataType : "json",
				contentType : "application/json",
				data:JSON.stringify(paramStr),
				success : function(data) {
					var result = data;
					if (data.saleOrderItemList.length > 200) {
						loadPartItem(0,200,data);
					} else {
						if (orderItem) {
							orderItem.load(data.saleOrderItemList);
						} else {
							orderItem = $('#saleOrderItemTable').mmGrid({
						        cols: cols,
						        height:$(document).height()-420,
						        checkCol:true,
						        multiSelect: true,
						        items: data.saleOrderItemList
						    });
						    orderItem.on('loadSuccess',function(e, data) {
						    	$('body').data('findSaleOrderItem',orderItem.rows());
								setTimeout(function(){
							    	for(var i=0;i<orderItem.rowsLength();i++){
							    		var row=orderItem.row(i);
							    		$("#orderType").append('<option value="'+row.orderItemNumber+'">'+row.orderItemNumber+'_'+row.purchaseMaterialDesc+'</option>');
							    	}
							    	fillDeliveryPlan(result.saleDeliveryPlanList);
							    	showCheck();
							    	initModifyFiled(result.saleOrderItemList);
								},100);
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
		
		insertSaleOrderItemTable();
		
		var cols_item = [
		 				{title:'行项目号',name:'orderItemNumber', width: 120, align: 'center',renderer:function(val){
						     return val + "<input name='saleDeliveryPlanList[][orderItemNumber]' class='delivery-orderItemNumber' type='text' style='display:none' value='"+val+"'/>";
						}},
						{title:'计划行号',name:'orderDeliveryItem', width: 120, align: 'center',renderer:function(val){
								if (!val) {val = "1";}
								     return val + "<input class='delivery-orderDeliveryItem' name='saleDeliveryPlanList[][orderDeliveryItem]' type='text' style='display:none' value='"+val+"'/>";
						}},
						{title:'gridValue', hidden:true,name:'gridValue', width: 120, align: 'center',renderer:function(val){
								if (!val) {val = "1";}
							     return "<input class='delivery-gridValue' name='saleDeliveryPlanList[][gridValue]' type='text' style='display:none' value='"+val+"'/>";
						 }},
		                 {title:'<i18n:I18n key="i18n_purchaseorder_deliverytime" defaultValue="计划交货时间" />', name:'purchaseDeliveryTimePlan', width: 240, align: 'center',renderer:function(val,item,rowIndex){
		                 	if(!val){val = item.deliveryTime;}
		                 	val = dateFormat(val);
		                    return "<input name='saleDeliveryPlanList[][purchaseDeliveryTimePlan]' class='Wdate' onfocus='WdatePicker()' type='text' value='"+val+"'/>";
		                 }},
		                 { title:'<i18n:I18n key="i18n_purchaseorder_deliveryquantity" defaultValue="计划交货数量" />', name:'purchaseDeliveryQuantityPlan' ,width:200, align:'center',renderer:function(val){
		                 	if (!val) {val = "0.000";}
		                 	return "<input name='saleDeliveryPlanList[][purchaseDeliveryQuantityPlan]' type='text' value='"+val+"'/>";
		                 }},
		                 {title:'<i18n:I18n key="i18n_saleorder_todeliverytime" defaultValue="客户计划交货时间" />', name:'deliveryTime', width: 240, align: 'center',renderer:function(val){
		                  	if (!val) {val = new Date();}
		                  	val = dateFormat(val);
		                    return "<span class='showText'>" + val + "</span><input class='hiddenItem' name='saleDeliveryPlanList[][deliveryTime]' type='hidden' style='display:none' value='"+val+"'/>";
		                }},
			                 { title:'<i18n:I18n key="i18n_saleorder_todeliveryquantity" defaultValue="客户计划交货数量" />', name:'deliveryQuantity' ,width:200, align:'center',renderer:function(val){
			                  	if (!val) {val = "0.000";}
			                    return "<span class='showText'>" + val + "</span><input class='hiddenItem' name='saleDeliveryPlanList[][deliveryQuantity]' type='hidden' style='display:none' value='"+val+"'/>";
			                }}];

/* 		var cols_item = [
		 				 {title:'orderItemNumber', hidden:true,name:'orderItemNumber', width: 120, align: 'center',renderer:function(val){
						     return "<input name='saleDeliveryPlanVOs[][orderItemNumber]' class='delivery-orderItemNumber' type='text' style='display:none' value='"+val+"'/>";
						 }},
		                 {title:'计划交货时间', name:'purchaseDeliveryTimePlan', width: 240, align: 'center',renderer:function(val){
		                 	if (!val) {val = "";}
		                 	val = dateFormat(val);
		                     return "<input name='saleDeliveryPlanVOs[][purchaseDeliveryTimePlan]' class='Wdate' onfocus='WdatePicker()' type='text' value='"+val+"'/>";
		                 }},
		                 { title:'计划交货数量', name:'purchaseDeliveryQuantityPlan' ,width:200, align:'center',renderer:function(val){
		                 	if (!val) {val = "";}
		                 	return "<input name='saleDeliveryPlanVOs[][purchaseDeliveryQuantityPlan]' type='text' value='"+val+"'/>";
		                 }},
		                 {title:'客户计划交货时间', name:'deliveryTime', width: 240, align: 'center',renderer:function(val){
		                  	if (!val) {val = "";}
		                  	val = dateFormat(val);
		                    return "<span class='showText'>" + val + "</span><input class='hiddenItem' name='saleDeliveryPlanVOs[][deliveryTime]' type='hidden' style='display:none' value='"+val+"'/>";
		                }},
			                 { title:'客户计划交货数量', name:'deliveryQuantity' ,width:200, align:'center',renderer:function(val){
			                  	if (!val) {val = "";}
			                    return "<span class='showText'>" + val + "</span><input class='hiddenItem' name='saleDeliveryPlanVOs[][deliveryQuantity]' type='hidden' style='display:none' value='"+val+"'/>";
			                }}]; */

		var newRow = {"orderItemNumber":"","orderDeliveryItem":"","gridValue":"","purchaseDeliveryTimePlan":timeFormat(new Date()),"purchaseDeliveryQuantityPlan":"0","deliveryTime":timeFormat(new Date()),"deliveryQuantity":"0"};
		
		var itemGrid;
		var isNull=false;
		//显示物料交货计划
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
	 		filterDeliveryPlan(); 
		}
// 		function showDeliveryPlanTable(orderItemNumber){
			
// 			$('#saleDeliveryPlanGrid').html('<table id="saleDeliveryPlanTable"></table>')
// // 			var paramStr={"elsAccount":elsAccount,"saleOrderNumber":saleOrderNumber,"orderItemNumber":orderItemNumber};
// 			var paramStr={"elsAccount":elsAccount,"itemIds":itemIds};
// 			$.ajax({
<%-- 				url :"<%=basePath%>rest/SaleDeliveryPlanService/findSaleDeliveryPlanList", --%>
// 				type : "POST",
// 				contentType : "application/json",
// 				data : paramStr,
// 				dataType : "json",
// 				success : function(data) {
// 					if(data.length>0){
// 						isNull=false;
// 					}else{
// 						isNull=true;
// 					}
// 					itemGrid = $('#saleDeliveryPlanTable').mmGrid({
// 						cols: cols_item,
// 						items:data,
// 						checkCol:true,
// 				        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
// 				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
// 				    });
					
// 					itemGrid.on('loadSuccess',function(e, data) {
// 						bindItemEvent();
// 					});
// 				},
// 				error : function(data) {
// 	    			if (!permissionError(data)) {
// 	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
// 	    			}
// 				}
// 			});
// 		}
		
		function filterDeliveryPlan() {
			var orderItemNumber = $("#orderType").val();
			$(".delivery-orderItemNumber").each(function(){
				if ($(this).val()==orderItemNumber) {
					$(this).parent().parent().parent().css("display","");
				} else {
					$(this).parent().parent().parent().css("display","none");
				}
			});
			deliveryGrid.deselect("all");
		}
		
		function fillDeliveryPlan(data){
			$('#saleDeliveryPlanGrid').html('<table id="saleDeliveryPlanTable"></table>');
			deliveryGrid = $('#saleDeliveryPlanGrid').mmGrid({
		        cols: cols_item,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol:true,
		        items: data
		    });
			deliveryGrid.on('loadSuccess',function(e, d) {
				setTimeout(function(){
// 					filterDeliveryPlan();
				},100);
			});
		}
		
		function bindHeadEvent(status){
			var orderStatus = status;
			$("#table-head").find("td").unbind("dblclick").bind("dblclick",function(){
				var $input = $(this).find("input");
				var $select = $(this).find("select");
				if ($input.hasClass("Wdate") || $input.hasClass("noEdit") || $input.is(":checkbox")) {
					return false;
				}
				$(this).find(".showText").hide();
				$input.show();
				$select.show();
				$select.val(orderStatus);
				$input.css("width",$(this).width()-15);
				$select.css("width",$(this).width()-15);
				$input.focus();
				$select.focus();
			});
			$("#table-head").find("input").unbind("blur").bind("blur",function(){
				if ($(this).hasClass("Wdate") || $(this).is(":checkbox")) {
					return false;
				}
				$(this).prev(".showText").html($(this).val());
				$(this).prev(".showText").show();
				$(this).hide();
			});
			$("#table-head").find("select").unbind("blur").bind("blur",function(){
				orderStatus = $(this).val();
				$(this).prev(".showText").html($(this).find("option:selected").text()); 
				$(this).prev(".showText").show();
				$(this).hide();
			});
		}
		
		function bindItemEvent(){
// 			$("#saleDeliveryPlanTable,#saleOrderItemTable").find("td").each(function(){
// 				if($(this).find(".hiddenItem").length<=0){
// 					if($(this).find("span input").attr("class")!="mmg-check"){
// 						$(this).find(".showText").hide();
// 						$(this).find("span input").show();
// 						$(this).find("input").css("width",$(this).width()-15);
// 					}
					
// 				}
// 			});
			
// 			$("#saleDeliveryPlanTable,#saleOrderItemTable").find("td").unbind("dblclick").bind("dblclick",function(){
// 				if($(this).find(".hiddenItem").length<=0){
// 					$(this).find(".showText").hide();
// 					$(this).find("input").show();
// 					$(this).find("input").css("width",$(this).width()-15);
// 					$(this).find("input").focus();
// 				}
// 			});
// 			$("#saleDeliveryPlanTable,#saleOrderItemTable").find("input").unbind("blur").bind("blur",function(){
// 				if($(this).attr("class")!="itemNumberInput"){
// 					$(this).prev(".showText").html($(this).val());
// 					$(this).prev(".showText").show();
// 					$(this).hide();
// 				}
// 			});
		}
		
		//添加尾部
		$("#addItem").click(function(){
			var val = $("#orderType").val();
			if (val) {
				//取出最大的 orderDeliveryItem 和 gridValue
				var orderDeliveryItem = 0;
				var gridValue = 0;
				if(deliveryGrid.rowsLength() > 0){
					$("#saleDeliveryPlanGrid").find("tr:visible").each(function(i,o){
						var data = $(this).data("item");
						var temOrderDeliveryItem = parseInt(data.orderDeliveryItem);
						var temGridValue = parseInt(data.gridValue);
						if(orderDeliveryItem <= temOrderDeliveryItem)
							orderDeliveryItem = temOrderDeliveryItem;
						if(gridValue <= temGridValue)
							gridValue = temGridValue;
					});
				}
				//添加一行
				var aNewRow = $.extend({}, newRow);
				aNewRow.orderDeliveryItem = orderDeliveryItem + 1;
				aNewRow.gridValue = gridValue + 1;
				aNewRow.orderItemNumber = val;
				deliveryGrid.addRow(aNewRow,deliveryGrid.rowsLength());
				bindItemEvent();
			}
		});
		$("#showDelete").click(function(){
			var itemList = orderItem.rows();
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
		//删除交货计划项
		$("#deleteItem").click(function(){
			var selectedIndexs = deliveryGrid.selectedRowsIndex();
			if (selectedIndexs.length == 0) {
				alert("<i18n:I18n key='i18n_refund_chooseitem' defaultValue='请选择项目行' />",2);
				return;
			}
			deliveryGrid.removeRow(selectedIndexs[0]);
		});
		
		//选择物料
		$("#orderType").change(function(){
			filterDeliveryPlan();
		});
		
		//保存订单交货计划
		$("#save").click(function(){
			
			if(deliveryGrid.rowsLength()==0){
				return;
			}
			var checkResult=checkDelivery();
			if(checkResult!=""){
				alert("<i18n:I18n key='i18n_delivery_orderitem' defaultValue='订单项' />【" + checkResult + "】<i18n:I18n key='i18n_deliveryquantity_cantbigplan' defaultValue='的数量超过计划交货数量' />",2);
				return;
			}
			
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_savedeliveryplan" defaultValue="是否确认保存订单交货计划？" />',closeEvent:function(){
				var frm=$("#saleOrderForm");
				$(".elsAccountParam").val(elsAccount);
				$(".elsSubAccountParam").val(elsSubAccount);
				$(".saleOrderNumberParam").val(saleOrderNumber);
				$(".orderItemNumberParam").val($("#orderType option:selected").val());
				$(".fbk5Param").val($("#fbk5").val());
				parent.elsDeskTop.showLoading();
				$.ajax({
					url :"<%=basePath%>rest/SaleDeliveryPlanService/saveSaleDeliveryPlan",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(frm.serializeJSON()),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
		
		//发送订单
		$("#send").click(function(){
			if (!$("#fbk5").val()) {
				alert("<i18n:I18n key='i18n_label_selectthepersoninchargeoftheorder' defaultValue='请选择订单负责人' />",2);
				return;
			}
			//检查销售方回复交期
			var flag = false;
			$("#saleOrderItemTable").find("input[name='saleOrderItemList[][fbk29]']").each(function(){
				var saleDate = $(this).val();
				if(saleDate == ""){
					flag = true;
					return false; //跳出循环
				}
			});
			if(flag){
				// 判断是否有交货计划时间，有就选交货计划时间并且选时间最早的同步到采购方回复交期，没有就提示填写采购方要求交期等于回复交期。
				var minPlanDeliveryDate = Math.min.apply(null,$("#sheet-project-three")
						.find("input[name='saleDeliveryPlanList[][purchaseDeliveryTimePlan]']")
						.toArray().map(function(elm){
								return new Date(elm.value);
							}
					));
				console.log(minPlanDeliveryDate);
					if(!(minPlanDeliveryDate===Infinity)){
						$("#saleOrderItemTable").find("tr").each(function(){
							if(minPlanDeliveryDate == '')
								minPlanDeliveryDate = new Date();
							var minPlanDeliveryDates = new Date(minPlanDeliveryDate).format("yyyy-MM-dd"); 
							$(this).find("input[name='saleOrderItemList[][fbk29]']").val(minPlanDeliveryDates);
						});
						send();
					}else{
						debugger;
// 							parent.elsDeskTop.tip.init({type: 'confirm',message:'未填写回复交期,是否设置回复交期=采购方要求交期?',closeEvent:function(){
// 								$("#saleOrderItemTable").find("tr").each(function(){
// 									var tempDate = $(this).data("item").deliveryDate;
// 									if(tempDate == '')
// 										tempDate = new Date();
// 									var purchaseDate = new Date(tempDate).format("yyyy-MM-dd");
// 									$(this).find("input[name='saleOrderItemList[][fbk29]']").val(purchaseDate);
// 								});
								send();
// 							}});
					}
					
			}else{
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_send" defaultValue="是否确认发送？" />',closeEvent:function(){
					send();
				}});
				
			}
		});
		 //打印
	     $('#printBtn').click(function() {
	 		currentPurchaseOrderNumber = purchaseOrderNumber;
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
	         	$.ajax({
	         		url : "<%=basePath%>rest/PurchaseOrderService/printERPPurchaseOrde/"+currentPurchaseOrderNumber+"/"+toElsAccount,
	         		type : "get",
	         		contentType : "application/json",
	         		dataType : "json",
	         		success : function(data) {
	         			if (data!=null&&data.statusCode == "-100") {
	         				alert(data.message,2);
	         			}else{
	         				window.location.href = "${pageContext.request.contextPath}/temp/"+data.fileName;
	         			}
	         		},
	         		error : function(data) {
	     	    		alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
	         		}
	         	});
	     }
	 	
	 	//使用自己的模板打印
	 	function printMyself(){
	 		// 组合打印数据
	 		var frm=$("#saleOrderForm");
	 		// 组合打印数据
			var bodyData = $('body').data();
			var rowsData = (bodyData['findSaleOrderItem']||{});
			var datas = bodyData['selectHead'];
// 	 		var datas = JSON.stringify(frm.serializeJSON());
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
	 	
// 		<button id="exitBtn" class="button-wrap">退出</button>
		//退出
		$("#exitBtn").click(function(){
			if (winId != null && winId != "" && winId != "null") {
				parent.elsDeskTop.closeCurWin(winId,closeCallback);
			} else {
				parent.elsDeskTop.closeCurWin('saleOrderConfirm',closeCallback);
			}
		});
		
		function closeCallback() {
			if (parent.frames["iframeApp_OrderManage"+toElsAccount]) {
				parent.frames["iframeApp_OrderManage"+toElsAccount].insertSaleOrderHeaderTable();
			}
		}
		
	
	var cols_file = [
		             { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
		                 	if (val != "" && val!=null&& val!=elsAccount) {
		                 		return "<i18n:I18n key="i18n_common_purchase" defaultValue="采购方" />";
		                	} else {
		                		return "<i18n:I18n key="i18n_common_sale" defaultValue="销售方" />";
		                	} 
		             }},
	                 { title:'id',name:'formId' ,width:200, align:'center',hidden:true},
	                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
	                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'orderItemNumber' ,width:90, align:'center',renderer:function(val){
		                 	if (val == ""||val== null) {
		                		return '<i18n:I18n key="i18n_label_headfile" defaultValue="订单头文件" />';
		                	} else{
		                		return '<i18n:I18n key="i18n_label_itemfile" defaultValue="订单项文件" />';
		                	}
		                }},
	                 { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="订单项编号" />',name:'orderItemNumber' ,width:80, align:'center'},
	                 { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />',name:'filePath' ,width:200, align:'center',hidden:true},
	                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="待发状态" />', name:'fileStatus' ,width:59, align:'center',renderer:function(val){
	                	 var showText;
	                	 if (val == "0") {
	                		 showText = '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
	                	} else if (val == "1") {
	                		showText = '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
	                	} else if (val == "2") {
	                		showText = '<i18n:I18n key="i18n_common_title_sendstatus_received" defaultValue="已接收" />';
	                	}
	                 	return showText;
	                }}
	             ];
	function initAddFileDialog(){
		$(".dialog-tip").height(240);
		$("#fileName").attr("readonly",false);
	    $("#filePath").val(null);
	    $("#fileType").val(null);
	    $("#fileName").val(null);
	    $("#operTypeSelector").val("0");
	    $("#orderItemSelector").empty();
	    $("#divOrderItem").hide();
	    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" />');
	    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="上传文件" />');
	    $("#btnFileOK").unbind("click");
	    $("#btnFileOK").click(function(){addFormFile();});
	}
	function send(){
		$(".elsAccountParam").val(elsAccount);
		$(".elsSubAccountParam").val(elsSubAccount);
		$(".saleOrderNumberParam").val(saleOrderNumber);
		$(".orderStatusParam").val($("#operateType option:selected").val());
		$(".fbk5Param").val($("#fbk5").val());
		$(".fbk29Param").val($("#table-head input[name='purchaseOrderHeaderVO[fbk29]']").val());
		var formObj=$("#saleOrderForm").serializeJSON();
		formObj["saleOrderNumber"]=purchaseOrderNumber;
		debugger;
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/SaleOrderService/updateSaleOrder",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(formObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				getSaleOrderHeadBySaleOrderNumber();
				alert("<i18n:I18n key='i18n_common_sendsuccess' defaultValue='发送成功' />");
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key='i18n_common_sendfail' defaultValue='发送失败' />",3);
			}
		});
	}
	function initModifyFileDialog(){
		$("#fileName").attr("readonly",true);
	    $("#filePath").val();
	    $("#fileType").val();
	    if(orderItemNumber){
	    	$(".dialog-tip").height(270);
	    	$("#operTypeSelector").val("1");
	    	loadOrderItem();
	    	$("#orderItemSelector").val(orderItemNumber);
	    }else{
	    	$(".dialog-tip").height(240);
	    	$("#operTypeSelector").val("0");
	        $("#orderItemSelector").empty();
	        $("#divOrderItem").hide();
	    }
		$("#fileName").val(fileName);
	    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改表单文件" />');
	    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_rechooseformfile" defaultValue="重传文件" />');
	    $("#btnFileOK").unbind("click");
	    $("#btnFileOK").click(function(){modifyFormFile();});
	}
	function addFormFile(){
		var fileName = $("#fileName").val();
		if (!fileName) {
			alert("<i18n:I18n key='i18n_delivery_enterfilename' defaultValue='请填写文件名称' />",2);
			return;
		}
		var filePath = $("#filePath").val();
		if(!filePath){
			alert("<i18n:I18n key='i18n_delivery_uploadfileplease' defaultValue='请上传文件' />",2);
			return;
		}
// 		var purchaseOrderNumber = $("#purchaseOrderNumber").val();
		var purchaseOrderNumber = headGrid.row(0).purchaseOrderNumber;
		var orderItemNumber = $("#orderItemSelector").val();
		var fileType = $("#fileType").val();
		var logtime = new Date();
		var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseOrderNumber":purchaseOrderNumber,"saleOrderNumber":saleOrderNumber,"orderItemNumber":orderItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : "<%=basePath%>rest/SaleFormFileService/order/addSaleFormFile",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data != null){
					fileGrid.addRow(data,fileGrid.rowsLength());
					$('.fixed-dialog').hide();
				}else{
					alert("<i18n:I18n key='i18n_delivery_filenameexist' defaultValue='该文件名已存在' />",2);
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	function modifyFormFile(){
		var fileName = $("#fileName").val();
		if (!fileName) {
			alert("<i18n:I18n key='i18n_delivery_enterfilename' defaultValue='请填写文件名称' />",2);
			return;
		}
		var purchaseOrderNumber = $("#purchaseOrderNumber").val();
		var orderItemNumber = $("#orderItemSelector").val();
		var fileType = $("#fileType").val();
		var filePath = $("#filePath").val();
		var logtime = new Date();
		var data = {"elsAccount":elsAccount,"formId":formId,"fileStatus":fileStatus,"purchaseOrderNumber":purchaseOrderNumber,"saleOrderNumber":saleOrderNumber,"orderItemNumber":orderItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : "<%=basePath%>rest/SaleFormFileService/order/updateSaleFormFile",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				var index = fileGrid.selectedRowsIndex()[0];
				fileGrid.updateRow(data,index);
				$('.fixed-dialog').hide();
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	function initFileUploader(fileUploader){
	    //新增表单文件
	    if (!fileUploader) {
	  	fileUploader = WebUploader.create({
	  	    // swf文件路径
	  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
	  	    auto: true,
	  	    // 文件接收服务端。
	  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
	  	    // 选择文件的按钮。可选。
	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	  	    pick: '#btnFileUpload',
	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	  	    resize: false
	  	});
	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
	  		if(0 == response.error){
	 	  	   var filePath = response.url;
		  	   var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
	  	  	   var noEdit = $("#fileName").attr("readonly");
	  	  	   if(!noEdit){
	  	  		$("#fileName").val(obj.file.name);
	  	  	   }
		       $("#filePath").val(filePath);
		       $("#fileType").val(fileType);
	  		}else{
	  			alert(response.message,2);
	  		}
	  	});
	    }
	}
	function initFileTable(){
		$("#divOrderItem").hide();
		if(saleOrderNumber == ""){
			fileGrid = $('#table-file').mmGrid({
		        cols: cols_file,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        items: []
		    });
		}else{
			$.ajax({
				url :"<%=basePath%>rest/SaleFormFileService/order/findSaleFormFileByNumber/"+elsAccount+"/"+saleOrderNumber,
				type :"get",
				contentType : "application/json",
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
		}
	}
	function fillData(data){
		fileGrid = $('#table-file').mmGrid({
	        cols: cols_file,
	        items: data.rows,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    	height: 323,
	    	checkCol: true
	    });
	}
    $('#btnAddFile').click(function() {
        $('.fixed-dialog').show();
        initAddFileDialog();
        initFileUploader(fileUploader);
    });
    $('#btnModifyFile').click(function() {
    	var selectedIndexs = fileGrid.selectedRowsIndex();
    	if (selectedIndexs.length == 0) {
    		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
    		return;
    	}
    	var selectedRow = fileGrid.row(selectedIndexs[0]);
		if(selectedRow.createBy != elsAccount){
			alert("<i18n:I18n key='i18n_delivery_cantmodifytofile' defaultValue='对方文件不能修改' />",2);
			return;
		}
    	formId = selectedRow.formId;
    	fileName = selectedRow.fileName;
    	fileStatus = selectedRow.fileStatus;
    	orderItemNumber = selectedRow.orderItemNumber;
        $('.fixed-dialog').show();
        initModifyFileDialog();
        initFileUploader(fileUploader);
    });
    $("#btnDeleteFile").click(function(){
    	var selectedIndexs = fileGrid.selectedRowsIndex();
    	if (selectedIndexs.length == 0) {
    		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
    		return;
    	}
    	var selectedRow = fileGrid.row(selectedIndexs[0]);
		if(selectedRow.createBy != elsAccount){
			alert("<i18n:I18n key='i18n_delivery_cantdeletetofile' defaultValue='对方文件不能删除' />",2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
    	var data = {"formId":selectedRow.formId,"elsAccount":elsAccount};
    	parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/SaleFormFileService/order/deleteSaleFormFile",
    		type : "post",
    		contentType : "application/json",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			fileGrid.removeRow(selectedIndexs[0]);
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
    $("#btnDownloadFile").click(function(){
    	var selectedRows = fileGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
    		return;
    	}
    	window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + selectedRows[0].filePath;
    });
    $("#btnPlanTempDownload").click(function(){
    	window.location.href = "${pageContext.request.contextPath}/template/ELS_销售方交货计划.xls";
    });
    $("#btnViewFile").click(function(){
    	var selectedRows = fileGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
    		return;
    	}
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var filePath = selectedRows[0].filePath;
    	var data = {"elsAccount":elsAccount,"filePath":filePath};
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	}else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
    	    parent.elsDeskTop.showLoading();
    	    $.ajax({
			url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				var resStatus = data.statusCode;
				var filePath = data.message;
				if("200" == resStatus){
					var width=$("#file-display").width();
					var height=$("#file-display").height();
					$("#viewerPlaceHolder").css("width",width*0.94+"px");  
					$("#viewerPlaceHolder").css("height",height+"px");  
					$("#viewerPlaceHolder").css("padding-left",width*0.03+"px");  
					$("#viewerPlaceHolder").css("display","block" );  

					var fp = new FlexPaperViewer(
					            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
					            'viewerPlaceHolder', 
					            {config : {
					                SwfFile : filePath,
					                Scale : 1.5,
					                ZoomTransition : 'easeOut',
					                ZoomTime : 0.5,
					                ZoomInterval : 0.2,
					                FitPageOnLoad : false,
					                FitWidthOnLoad : false,
					                FullScreenAsMaxWindow : false,
					                ProgressiveLoading : false,
					                MinZoomSize : 0.2,
					                MaxZoomSize : 5,
					                SearchMatchAll : false,
					                InitViewMode : 'SinglePage',
					                ViewModeToolsVisible : true,
					                ZoomToolsVisible : true,
					                NavToolsVisible : true,
					                CursorToolsVisible : true,
					                SearchToolsVisible : true,
					                localeChain: 'zh_CN'
					            	}
					            });
				}else{
					alert(data.message,2);
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
    	}else {
    		alert('<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型!" />',2);
    	}
    });
    $('.dialog-close-btn').click(function(){
        $('.fixed-dialog').hide();
    });
    $('.tip-option-btn').click(function(){
        $('.dialog-close-btn').trigger('click');
    });
    

    //发送表单文件
    $("#sendForm").click(function(){
    	var selectedIndexs = fileGrid.selectedRowsIndex();
    	if (selectedIndexs.length == 0) {
    		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
    		return;
    	}
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
        	var selectedRow = fileGrid.row(selectedIndexs[0]);
        	formId = selectedRow.formId;
        	var paramStr='{"elsAccount":"'+ elsAccount+ '","companyShortName":"'+companyShortName+'","elsSubAccount":"'+ elsSubAccount+ '","formId":"'+ formId+ '"}';
        	parent.elsDeskTop.showLoading();
        	$.ajax({
        		url :"<%=basePath%>rest/SaleFormFileService/order/sendSaleFormFile",
    										type : "post",
    										contentType : "application/json",
    										data : paramStr,
    										dataType : "json",
    										success : function(data) {
    											parent.elsDeskTop.hideLoading();
    											selectedRow.fileStatus = 1;
    											fileGrid.updateRow(selectedRow,selectedIndexs[0]);
    											alert("<i18n:I18n key='i18n_common_sendsuccess' defaultValue='发送成功' />");
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
    $("#columnDefineBtn").click(function(){
    	parent.elsDeskTop.defineWin({
    	    'iconSrc':'icon/els-icon.png',
    	    'windowsId':'subAccountColumnSetting',
    	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
    	    windowSubTitle: "",
    	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=confirmSaleOrder_mt" + "&window=iframeApp_saleOrderConfirm",
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
    	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=confirmSaleOrderItem_mt" + "&window=iframeApp_confirmSaleOrderItem_mt",
    	    windowMinWidth: 480,
    	    windowMinHeight: 600,
    	    'windowWidth':480,
    	    'windowHeight':600,
    	    'parentPanel':".currDesktop"
    	});
    	});
    	
//     	$("#deliveryTab").click(function(){
//     		initPlanUploader();
//     	});
    	
    	function initPlanUploader(){
    		if(!planUploader){
    			planUploader = WebUploader.create({
    			    // swf文件路径
    			    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
    			    auto: true,
    			    duplicate :true,
    			    accept:{
    			    	extensions:"xls,xlsx"
    			    },
    			    // 文件接收服务端。
    			    server: '<%=basePath%>rest/SaleOrderService/uploadSaleOrderPlan',
    			    // 选择文件的按钮。可选。
    			    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    			    pick: '#btnPlanUpload',
    			    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
    			    resize: false
    			});
    			
    			planUploader.on( 'uploadAccept', function( file, response ) {
/*     			   updateDeliveryPlan(response._raw); */
    			   getDeliveryPlanFromExcel(response._raw);
    			});
    		}
    	}
    	
    	function getDeliveryPlanFromExcel(fileName){
    		var paramStr='{"elsAccount":"'+elsAccount+'","toElsAccount":"'+toElsAccount+'","elsSubAccount":"'+elsSubAccount+'","purchaseOrderNumber":"'+purchaseOrderNumber+'","saleOrderNumber":"'+saleOrderNumber+'","fileName":"'+fileName+'"}';
    		$.ajax({
    			url : "<%=basePath%>rest/SaleOrderService/getDeliveryPlanFromExcel",
    			type : "post",
    			contentType : "application/json",
    			dataType : "json",
    			data:paramStr,
    			success : function(data) {
    				if(data.statusCode=="-100"){
    					alert(data.message,2);
    				}else{
    					fillDeliveryPlan(data);
    					alert("<i18n:I18n key='i18n_alert_uploadSuccess' defaultValue='上传成功！' />");
    				}
    			},
    			error : function(data) {
    				parent.elsDeskTop.hideLoading();
        			if (!permissionError(data)) {
        				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
        			}
    			}
    		});
    	}
    	
    	function updateDeliveryPlan(fileName){
    		var paramStr='{"elsAccount":"'+elsAccount+'","toElsAccount":"'+toElsAccount+'","elsSubAccount":"'+elsSubAccount+'","purchaseOrderNumber":"'+purchaseOrderNumber+'","saleOrderNumber":"'+saleOrderNumber+'","fileName":"'+fileName+'"}';
    		$.ajax({
    			url : "<%=basePath%>rest/SaleOrderService/updateDeliveryPlan",
    			type : "post",
    			contentType : "application/json",
    			dataType : "json",
    			data:paramStr,
    			success : function(data) {
    				if(data.statusCode=="-100"){
    					alert(data.message,2);
    				}else{
    					fillDeliveryPlan(data);
    					alert("<i18n:I18n key='i18n_alert_uploadSuccess' defaultValue='上传成功！' />");
    				}
    			},
    			error : function(data) {
    				parent.elsDeskTop.hideLoading();
        			if (!permissionError(data)) {
        				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
        			}
    			}
    		});
    	}
//     });
    function loadOrderItem(){
    	var isOrderItem = $("#operTypeSelector").val();
    	if("1" == isOrderItem){
    		$(".dialog-tip").height(270);
    		$("#divOrderItem").show();
    		getOrderItem();
    	}else{
    		$(".dialog-tip").height(240);
    		$("#divOrderItem").hide();
    		$("#orderItemSelector").empty();
    	}
   }
	function getOrderItem(){
		$("#orderItemSelector").empty();
		var html = "";
		var trs = $("#saleOrderItemTable").find("tr");
		for (var i=0;i<trs.length;i++){
			var data = trs.eq(i).data("item");
			if (data.orderItemNumber != "") 
				html += "<option value='"+data.orderItemNumber+"'>" + data.orderItemNumber + "_" + data.purchaseMaterialDesc + "</option>";
		}
		$("#orderItemSelector").append(html);
		
	}
	
	//检查交货计划数量是不是超过订单数
	function checkDelivery(){
		var flag = "";
		var orderItemRows = orderItem.rows();
		for(var index in orderItemRows){
			var totalCount = 0;
			var quality = orderItemRows[index].quantity;
			$("#saleDeliveryPlanGrid").find("tr").each(function(){
				var item = $(this).find("input[name='saleDeliveryPlanList[][orderItemNumber]']").val();
				if(orderItemRows[index].orderItemNumber == item){
					var deliveryQuantity = $(this).find("input[name='saleDeliveryPlanList[][purchaseDeliveryQuantityPlan]']").val();
					if(deliveryQuantity == "" || deliveryQuantity == null){
						$(this).find("input[name='saleDeliveryPlanList[][purchaseDeliveryQuantityPlan]']").val("0");
						deliveryQuantity = 0;
					}
					totalCount = parseFloat(totalCount) + parseFloat(deliveryQuantity);
				}
			});
			if(parseFloat(quality) < parseFloat(totalCount)){
				flag = orderItemRows[index].orderItemNumber;
				return flag;
			}
		}
		return flag;
	}
	
	//检查交货计划数量是不是超过订单数
	function checkDeliveryCount(){
		var orderItemRows=orderItem.rows();
		var totalCount=0;
		var quantity=0;
		var orderItemNumber=$("#orderType option:selected").val();
		
		$("#saleDeliveryPlanTable").find("tr").each(function(){
			var deliveryQuantity=$(this).find("input[name='saleDeliveryPlanList[][purchaseDeliveryQuantityPlan]']").val();
			if(deliveryQuantity==""||deliveryQuantity==null){
				$(this).find(".deliveryQuantity").val("0");
				deliveryQuantity=0;
			}
			totalCount=parseFloat(totalCount)+parseFloat(deliveryQuantity);
		});
		
		for(var index in orderItemRows){
			if(orderItemRows[index].orderItemNumber==orderItemNumber){
				quality=orderItemRows[index].quantity;
				break;
			}
		}
		if(parseFloat(quality)<parseFloat(totalCount)){
			return orderItemNumber;
		}else{
			return "true";
		}
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
	
	function loadPartItem(start,size,data) {
		var array = [];
		for (var i=0;i<size;i++) {
			array[i] = data.saleOrderItemList[start+i];
		}
		start = start + size;
		if (orderItem) {
			orderItem.addRows(array);
		} else {
			orderItem = $('#saleOrderItemTable').mmGrid({
		        cols: cols,
		        checkCol:true,
		        height:$(document).height()-420,
		        items: array
		    });
		}
		if (start < data.saleOrderItemList.length) {
			setTimeout(function(){
				if (data.saleOrderItemList.length - start > 200) {
					loadPartItem(start,200,data);
				} else {
					loadPartItem(start,data.saleOrderItemList.length-start,data);
				}
			},200);
		} else {
	    	for(var i=0;i<orderItem.rowsLength();i++){
	    		var row=orderItem.row(i);
	    		$("#orderType").append('<option value="'+row.orderItemNumber+'">'+row.orderItemNumber+'_'+row.purchaseMaterialDesc+'</option>');
	    	}
	    	fillDeliveryPlan(data.saleDeliveryPlanList);
	    	initModifyFiled(data.saleOrderItemList);
		}
	}
	
	//给可以填充的列添加选择框
	function showCheck(){
		$("#saleOrderItemGrid").find("th").each(function(){
			var className=$(this).attr("class").split(" ")[0];
			var addCheck="<input type='checkbox' class='mmg-column-check'>";
			var count=$("."+className).find("input[name^='saleOrderItemList[]']").not(".noEdit").length;
			if(count>0){
				$(this).find(".mmg-titleWrapper").css('white-space','nowrap').prepend(addCheck);
			}
		});
	}
	
	//填充
	$("#fillTime").click(function(){
		var selecteds=$("#saleOrderItemTable tr[class$='selected']");
		var columnSelected=$("#saleOrderItemGrid").find("th input:checked");          
		if(selecteds.length<1){
			alert("请选择填充行！",2);
			return;
		}
		if(columnSelected.length<1){
			alert("请选择填充列！",2);
			return;
		}
		$("#saleOrderItemGrid").find("th input:checked").each(function(){
			var className=$(this).parent().parent().attr("class").split(" ")[0];
			var val=selecteds.eq(0).find("."+className+" input").val();
			$("#saleOrderItemTable tr[class$='selected']").each(function(){
				$(this).find("."+className+" input").val(val);
			});
		});
	});
	
	$("#btnBom").click(function(){
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    var orderItemNumber = "";
		var selectedIndexs = orderItem.selectedRowsIndex();
		if(selectedIndexs.length>0)
			orderItemNumber = orderItem.row(selectedIndexs[0]).orderItemNumber;
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'SaleOrderBom',
	        'windowTitle':'<i18n:I18n key="i18n_common_button_viewbom" defaultValue="查看BOM" />',
	        'iframSrc':"<%=basePath%>ordermanage/saleorder/saleOrderBom.jsp?saleOrderNumber="+saleOrderNumber+"&purchaseOrderNumber="+purchaseOrderNumber
	        		+"&orderItemNumber="+orderItemNumber+"&toElsAccount="+toElsAccount+"&winId="+winId,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
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
	function initModifyFiled(itemList) {
		var map = {};
		for (var i in cols) {
			map[cols[i].name] = i;
		}
		for (var i in itemList) {
			var fbk50 = itemList[i].fbk50;
			if (fbk50) {
				var changeFields = fbk50.split(",");
				for (var j in changeFields) {
					if (changeFields[j]=="materialNumber"||changeFields[j]=="materialDesc") {
						changeFields[j] = "purchaseM" + changeFields[j].substring(1);
					}
					$("#saleOrderItemTable").find("tr").eq(i).find("td").eq(parseInt(map[changeFields[j]])+1).css("background","yellow");
				}
			}
			// 删除待确认的标识
			if (itemList[i].deleteFlag && itemList[i].deleteFlag=="C") {
				$("#saleOrderItemTable").find("tr").eq(i).find("td").css("background","yellow");
			}
			if (itemList[i].deleteFlag && itemList[i].deleteFlag=="X") {
				$("#saleOrderItemTable").find("tr").eq(i).css("background-color","rgba(213, 58, 58, 0.0980392)");
				$("#saleOrderItemTable").find("tr").eq(i).hide();
			}
		}
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
</script>
</body>
</html>