<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
  <div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
	    <div>
	    	<button id="saveBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
	    	<button id="sendBtn" class="button-wrap"><i18n:I18n key="i18n_delivery_lable_senddeliveryorder" defaultValue="发货" /></button>
<%-- 	    	<button id="cancelBtn" class="button-wrap"><i18n:I18n key="i18n_delivery_button_canceldeliver" defaultValue="撤销发货" /></button>  --%>
<%-- 	    	<button  id="headColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
<%-- 		    <button id="printBtn" class="button-wrap"><i18n:I18n key="i18n_button_print" defaultValue="打印" /></button> --%>
<%-- 	        <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
	    	<button id="deliveryFlowBtn" style="display:none;" class="button-wrap"><i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" /></button>
	    </div>
    </div>
</div>
<form id="form" onsubmit="return false;">
<input type="hidden" id="deliveryStatus" value="0"/>
<input type="hidden" name="companyShortName" value="<%=session.getAttribute("companyShortName")%>"/>
<!-- <input type="hidden" id="selectedItems" name="selectedItems" value=""/> -->
<input type="hidden" name="elsAccount" value="${elsAccount }"/>
<input type="hidden" name="toElsAccount" value="<%=request.getParameter("toElsAccount")%>"/>
<input type="hidden" name="elsSubAccount" value="${elsSubAccount }"/>
<input type='hidden' name='purchaseInCharge' id="purchaseInChargeParam" />
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
    <ul>
		<li><a href="#sheet-project-one"><i18n:I18n key="i18n_delivery_lable_deliveryorderitems" defaultValue="发货单行项目" /></a></li>
<%-- 	    <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li> --%>
	</ul>
	<div id="sheet-project-one">
    <div class="common-box-line">
<!--     	<div class="edit-box-wrap"> -->
<%-- 			<button id="btnAdd" class="edit-btn button-wrap add-bottom-btn"><i18n:I18n key="i18n_delivery_button_addfreeitems" defaultValue="添加免费项" /></button> --%>
<%-- 			<button id="btnRemove" class="edit-btn button-wrap del-btn"><i18n:I18n key="i18n_delivery_button_removefreeitems" defaultValue="删除免费项" /></button> --%>
<%-- 			<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
<!-- 		</div> -->
       <main class="grid-container">
            <div class="grid-100">
                <table id="table-item"></table>
            </div>
        </main>
    </div>
    </div>
<!-- 			<div id="sheet-project-two"> -->
<!-- 				<div class="box-wrap pos-relative bg-common"> -->
<!-- 					<div class="common-box-line p-zero"> -->
<!-- 						<div class="pos-relative upload-wrap"> -->
<!-- 							<div class="pos-absolute file-list"> -->
<!-- 								<div class="file-list-head"> -->
<%-- 									<i18n:I18n key="i18n_common_lable_filelist" defaultValue="表单文件列表" />：<span></span> --%>
<!-- 								</div> -->
<!-- 								<main class="grid-container"> -->
<!-- 								<div class="grid-100"> -->
<!-- 									<table id="table-file"></table> -->
<!-- 								</div> -->
<!-- 								</main> -->
<!-- 							</div> -->
<!-- 							<div class="file-scan"> -->
<!-- 								<div class="file-option-zoom"> -->
<!-- 									<div class="dis-in-b text-left"> -->
<%-- 										<button id="btnAddFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button> --%>
<%-- 										<button id="btnModifyFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改文件" /></button> --%>
<%-- 										<button id="btnDeleteFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button> --%>
<!-- 									</div> -->
<!-- 									<div class="dis-in-b text-right"> -->
<%-- 										<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button> --%>
<%-- 										<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button> --%>
<!-- 										<button class="button-wrap" id="sendForm">发送表单文件</button> --> 
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="file-display" id="file-display"> -->
<!-- 									<a id="viewerPlaceHolder"></a> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->

			</div>
			</div>
		</div>
</form>
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
								<option value="0"><i18n:I18n key="i18n_common_select_bymaterialheader" defaultValue="按凭证头" /></option>
								<option value="1"><i18n:I18n key="i18n_common_select_bymaterialitem" defaultValue="按凭证行" /></option>
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
	//列
		var selector = '<base:subAccount role='purchase' elsAccount='${elsAccount }' type='multiple' id='purchaseInCharge' ></base:subAccount>';

	var cols_head = [{title:"物料凭证编号",name:"materialVoucherNumber",align:"center",width:98,renderer:function(val){return stringInput(val,"R","materialVoucherNumber")}},
	                 {title:"凭证日期",name:"voucherDate",align:"center",width:98,renderer:function(val){return dateInputFormat(val,"R","voucherDate","")}},
	                 {title:"过账日期",name:"postDate",align:"center",width:98,renderer:function(val){return dateInputFormat(val,"Y","postDate","")}},
	                 {title:"发货状态",name:"deliveryStatus",align:"center",width:98,renderer:function(val){return dictionaryFormat(val,"0:未发货;1:发货在途;2:对方已收货;3:到货")}},
	                 {title:"移动类型",name:"mobileType",align:"center",width:98,renderer:function(val){return dictionaryFormat(val,"541:发货")}},
	                 {title:"销售方负责人",name:"saleInCharge",align:"center",width:98,renderer:function(val){return stringInput(val,"R","saleInCharge")}},
	                 {title:"采购方负责人",name:"purchaseInCharge",align:"center",width:138,renderer:function(val){return selector}},
	                 {title:"物流商",name:"logistics",align:"center",width:98,renderer:function(val){if(!val||val=="null") val="";return '<input name="logistics" id="fbk1" type="text" value="'+val+'">';}},
	                 {title:"物流单号",name:"logisticsNumber",align:"center",width:98,renderer:function(val){return stringInput(val,"Y","logisticsNumber")}},
	                 {title:"预计到达时间",name:"planArrivalTime",align:"center",width:98,renderer:function(val){return dateInputFormat(val,"Y","planArrivalTime","")}}
	                 ];
	var cols = [{title:"行号",name:"materialVoucherItemNumber",align:"center",width:98},
	            {title:"材料编号",name:"purchaseMaterialNumber",align:"center",width:98},
	            {title:"材料描述",name:"purchaseMaterialDesc",align:"center",width:154},
	            {title:"材料数量",name:"quantity",align:"center",width:100},
	            {title:"发料数量",name:"wesbs",align:"center",width:100,renderer:function(val){if(!val||val=="null") val="0.00";return '<input name="bomVoucherItemList[][wesbs]" class="wesbs" type="text" value="'+val+'">';}},
	            {title:"材料单位",name:"unitQuantity",align:"center",width:100},
	            {title:"发料工厂",name:"purchaseFactory",align:"center",width:154},
	            {title:"发料库存地",name:"fbk1",align:"center",width:154},
	            {title:"采购订单号",name:"purchaseOrderNumber",align:"center",width:154},
	            {title:"采购订单行号",name:"orderItemNumber",align:"center",width:120},
	            {title:"物料编号",name:"fbk3",align:"center",width:100},
	            {title:"物料描述",name:"fbk4",align:"center",width:154},
	            {title:"订单数量",name:"fbk7",align:"center",width:100},
	            {title:"订单单位",name:"fbk8",align:"center",width:100},
	            {title:"要求交期",name:"deliveryDate",align:"center",width:100,renderer:function(val){return dateFormat(val)}}
	            ];
// 	var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="deliveryHead"/>;
// 	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editDelivery"/>;
	var blankRow;
	var itemGrid;
	var headGrid;
	var itemData;
	var fileGrid;
	var formId;
	var fileName;
	var mobileType;
	var fileStatus;
	var fileUploader;
	var orderItemNumber;
	var isTemp = true;
	var fbk1 = "";
	var fbk2 = "";
	var height = $(document).height() - 400;
	var itemNumberJson=new Object();
	$().ready(function() {
		init();
	    initFileGrid();
	});
	var pageData = {};
	var flowCode = "";
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	var materialVoucherNumber = "<%=request.getParameter("materialVoucherNumber")%>";
if (materialVoucherNumber == "null") {
	materialVoucherNumber = "";
}
var deliveryStatus = "<%=request.getParameter("deliveryStatus")%>";
if (deliveryStatus != "0" && deliveryStatus != "null") {
	isTemp = false;
}
var selectedItems = "<%=request.getParameter("selectedItems")%>";
function closeCallback() {
	if (parent.frames["iframeApp_bomDeliveryManage"]) {
		parent.frames["iframeApp_bomDeliveryManage"].query();
	}
}
function checkFree() {
	$(".isFree").each(function(){
		var saleOrderNumber = $(this).parent().parent().parent().data("item").saleOrderNumber;
		if (saleOrderNumber && saleOrderNumber != "")  {
			$(this).attr("checked",false);
		} else {
			$(this).attr("checked","checked");
		}
	});
}
function init(){
	//初始化控件
    $("#sheet-project").tabs();
    $("#btnAdd").click(function(){
    	var rows = itemGrid.selectedRows();
    	if (rows.length == 0) {
    		alert("<i18n:I18n key='i18n_delivery_chooseitemtocopy' defaultValue='请选择一行复制' />",2);
    		return;
    	}
		var row = $.extend({}, rows[0]);
		row.saleOrderNumber = "";
		row.purchaseOrderNumber = "";
		row.orderItemNumber = "";
		row.quantity = "0";
		row.deliveryQuantity = "0";
		row.fbk1 = "";
		/* row.unitMeasure=""; */
		itemGrid.addRow(row,itemGrid.rowsLength());
		var $tr = $("tr:last");
		var $purchaseMaterialNumber = $tr.find(".purchaseMaterialNumber");
		$purchaseMaterialNumber.show();
		$purchaseMaterialNumber.prev("span").hide();
		var $purchaseMaterialDesc = $tr.find(".purchaseMaterialDesc");
		$purchaseMaterialDesc.show();
		$purchaseMaterialDesc.prev("span").hide();
		
		var $unitMeasure = $tr.find(".unitMeasure");
		$unitMeasure.show();
		$unitMeasure.prev("span").hide();
		
		var $saleMaterialNumber = $tr.find(".saleMaterialNumber");
		$saleMaterialNumber.show();
		$saleMaterialNumber.prev("span").hide();
		var $saleMaterialDesc = $tr.find(".saleMaterialDesc");
		$saleMaterialDesc.show();
		$saleMaterialDesc.prev("span").hide();
		$tr.find(".isFree").attr("checked","checked");
		$("#table-item").find("input").not(":checkbox").each(function(){
			$(this).css("width",$(this).parent().parent().width()-15);
		});
		bindItemEvent();
	});
    $("#btnRemove").click(function(){
    	var rows = itemGrid.selectedRows();
    	if (rows.length == 0) {
    		alert("<i18n:I18n key='i18n_delivery_choosefreeitem' defaultValue='请选择要删除的免费行' />",2);
    		return;
    	}
    	if (rows[0].saleOrderNumber != "") {
    		alert("<i18n:I18n key='i18n_delivery_choosefreeitemonly' defaultValue='只能删除免费行' />",2);
    		return;
    	}
		itemGrid.removeRow(itemGrid.selectedRowsIndex()[0]);
	});
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback);
		} else {
			parent.elsDeskTop.closeCurWin("editDelivery",closeCallback);
		}
	});
	
	query();
	
	$("#saveBtn").click(function(){
		$("#purchaseInChargeParam").val($("#purchaseInCharge").val());
		var frm = $("#form");
		var formData = frm.serializeJSON();
		pageData = $.extend(true,{},pageData,formData);
		var url = "<%=basePath%>rest/BomVoucherService/saveDelivery";
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :url,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(pageData),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				materialVoucherNumber = data.materialVoucherNumber;
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
				fillData(data);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
				
			}
		});
	});
	$("#sendBtn").click(function(){
		//订单状态
		var status = $("#deliveryStatus").val();
		if (status != "0") {
			alert("<i18n:I18n key='i18n_delivery_cannotdelivertwice' defaultValue='已发货的单据不能再次发货' />",2);
			return;
		}
		
// 		var checkResult=check();
// 		if(checkResult!="true"){
// 			alert(checkResult,2);
// 			return;
// 		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			var frm = $("#form");
			$("#purchaseInChargeParam").val($("#purchaseInCharge").val());
			var formData = frm.serializeJSON();
			pageData = $.extend(true,{},pageData,formData);
			var url = "<%=basePath%>rest/BomVoucherService/sendDelivery";
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(pageData),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					materialVoucherNumber = data.materialVoucherNumber;
					isTemp = false;
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
					fillData(data);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
					
				}
			});
		}});
	});
	
	$("#cancelBtn").click(function(){
		var status = $("#deliveryStatus").val();
		if (status != "1") {
			alert("<i18n:I18n key='i18n_delivery_onlycancel' defaultValue='只有已发货且未收货的单据才能撤销发货' />",2);
			return;
		}
		
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
// 			var materialVoucherNumber =  $("#materialVoucherNumber").val();
			var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"materialVoucherNumber":materialVoucherNumber};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/MaterialVoucherService/cancelDelivery",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.statusCode != 200) {
						alert(data.message,3);
					} else {
						isTemp = true;
						$("#deliveryStatus").val(0);
						alert("<i18n:I18n key='i18n_delivery_cancelsuccess' defaultValue='撤销发货成功' />");
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常' />",3);
				}
			});
		}});
	});
	
	$("#cancelEntryBtn").click(function(){
		if (materialVoucherNumber == "") {
			alert("<i18n:I18n key='i18n_delivery_notreport' defaultValue='单据尚未上报' />",2);
		} else if (flowCode == "" || flowCode == "00") {
			alert("<i18n:I18n key='i18n_delivery_notreport' defaultValue='单据尚未上报' />",2);
		} else {
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				var param = {"businessElsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
				$.ajax({
					url :"<%=basePath%>rest/MaterialVoucherService/cancelAudit",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(param),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
/* 						if (data.statusCode != "200") {
							alert(data.message,3);
							return;
						} */
						closeCallback();
						alert("<i18n:I18n key='i18n_delivery_revokesuccess' defaultValue='撤销成功' />");
						window.location="<%=basePath%>ordermanage/materialVoucher/editDelivery.jsp?toElsAccount=" + toElsAccount + "&materialVoucherNumber=" + materialVoucherNumber;
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
		    			if (!permissionError(data)) {
		    				if (data.status == "401") {
		    					alert("<i18n:I18n key='i18n_audit_overcantcancel' defaultValue='流程结束的单据不能撤销审批' />",2);
						    }else if (data.status == "403") {
						    	alert("<i18n:I18n key='i18n_audit_higherlevelcando' defaultValue='只有上一级处理人才能撤销审批' />",2);
						    }else {
			    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						    }
		    			}
					}
				});
			}});
		}
	});
	
	$("#entryBtn").click(function(){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_delivery_confirm_saveandreport" defaultValue="是否确认保存数据并上报？" />',closeEvent:function(){
			selectedItems = "";
			var itemList = itemdata.bomVoucherItemList;
			for (var i=0;i<itemList.length;i++){
				selectedItems += itemList[i].purchaseOrderNumber+"-"+itemList[i].orderItemNumber + ",";
			}
			selectedItems = selectedItems.substring(0,selectedItems.length - 1);
//	 		$("#selectedItems").val(selectedItems);
			var frm = $("#form");
			var url;
			if (isTemp) {
				url = "<%=basePath%>rest/MaterialVoucherService/saveAndEntryTempDelivery";
			} else {
				url = "<%=basePath%>rest/MaterialVoucherService/saveAndEntryDelivery";
			}
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
/* 					if (data.statusCode != "200") {
						alert(data.message,3);
						return;
					} */
					materialVoucherNumber = data.materialVoucherNumber;
					closeCallback();
					alert("<i18n:I18n key='i18n_common_report_success' defaultValue='上报成功' />");
					window.location="<%=basePath%>ordermanage/materialVoucher/editDelivery.jsp?toElsAccount=" + toElsAccount + "&materialVoucherNumber=" + materialVoucherNumber;
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				if (data.status == "401") {
	    					alert("<i18n:I18n key='i18n_common_orders_cannot_be_repeated_to_report' defaultValue='订单不能重复上报' />",2);
					    }else {
		    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					    }
	    			}
				}
			});
		}});
	});
	
	$("#flowBtn").click(function(){
		if (materialVoucherNumber == "") {
			alert("<i18n:I18n key='i18n_delivery_notreport' defaultValue='单据尚未上报' />",2);
		} else if (flowCode == "" || flowCode == "00") {
			alert("<i18n:I18n key='i18n_delivery_notreport' defaultValue='单据尚未上报' />",2);
		} else {
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'auditFlowList',
		        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=delivery&businessId='+materialVoucherNumber,
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':680,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		}
		
	});
	$("#deliveryFlowBtn").click(function(){
		if (fbk1==""||fbk2=="") {
			alert("<i18n:I18n key="i18n_alert_deliveryflowcannotnull" defaultValue="物流商和物流单号不能为空" />",2);
			return;
		}
		pattern =new RegExp("\\((.| )+?\\)","igm");
		var id = fbk1.match(pattern);
		if (!id || id == "") {
			alert("<i18n:I18n key="i18n_alert_deliveryFlownotsupport" defaultValue="该物流商不支持物流跟踪" />",2);
			return;
		}
		id = id[0].substring(1,id[0].length-1);
		fbk2 = fbk2.replace(/\s/g,"");
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'deliveryFlowList',
	        'windowTitle':'<i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>ordermanage/materialVoucher/deliveryFlowList.jsp?id=' + id + '&order='+fbk2,
	        windowMinWidth: 520,
	        windowMinHeight: 500,
	        'windowWidth':520,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
	});
	$('#printBtn').click(function() {
		
		if(!materialVoucherNumber){
			alert("请先保存订单或发送订单！",2);
			return;
		}
		
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
		// 传入打印数据到打印窗口
		// 子窗口 通过loadIframeData 获取数据  onIframeDataLoad监听数据变化

		var fbk1=$("#fbk1").val();
		printWin.setIframeData({
			dataFrom:'editDelivery',
			businessType:'delivery',
			cData:[$.extend(true,itemData,{"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"toElsAccount":toElsAccount,"fbk1":fbk1})],
			tUrlPrefix:"<%=basePath%>rest/MaterialVoucherService/findDeliveryItem",
			tUrlKey:'purchaseOrderNumber'
		});
	});
}

function query(){
	if (materialVoucherNumber == "") {
		var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"itemIds":selectedItems};
		//根据行项目获取信息
		$.ajax({
    		url : "<%=basePath%>rest/BomVoucherService/getInfoFromBom",
    		type : "post",
    		contentType : "application/json",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			pageData = data;
    			itemData = data;
//     			materialVoucherNumber = data.materialVoucherNumber;
    			fillData(data);
    		},
    		error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
    		}
    	});
	} else {
		$("#deliveryFlowBtn").show();
		var url = "<%=basePath%>rest/BomVoucherService/getBomVoucherDetail";
		var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,mobileType:"541"};
		$.ajax({
    		url : url,
    		type : "post",
    		contentType : "application/json",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) { 
    			pageData = data.bomVoucherHeader;
    			pageData.bomVoucherItemList = data.bomVoucherItemList;
//     			itemData = data;
//     			pageData = data;
				if (pageData.flowCode) {
					flowCode = data.flowCode;
				}
    			fillData(pageData);
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
	if (!data.voucherDate) {
		data.voucherDate=new Date().format("yyyy-MM-dd");
	}
	if (!data.postDate) {
		data.postDate=new Date().format("yyyy-MM-dd");
	}
	data.mobileType=541;
	if (!data.deliveryStatus) {
		data.deliveryStatus="0";
	}
	if (data.logistics) {
		fbk1 = data.logistics;
	}
	if (data.logisticsNumber) {
		fbk2 = data.logisticsNumber;
	}
	$("#deliveryStatus").val(data.deliveryStatus);
	var head = new Array();
	head.push(data);
	if (!headGrid) {
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height:100,
	        items: head
	    });
	} else {
		headGrid.load(head);
	}
	headGrid.on('loadSuccess',function() {
		$("#table-head").find("input").not(":checkbox").each(function(){
			$(this).css("width",$(this).parent().parent().width()-15);
		});
		var materialVoucherNumber = headGrid.row(0).materialVoucherNumber;
		var deliveryStatus = headGrid.row(0).deliveryStatus;
		if(materialVoucherNumber != null && materialVoucherNumber != "")
			loadFileItem(materialVoucherNumber);
		if ((flowCode != "" && flowCode != "00")||deliveryStatus!=0) {
			$("input").attr("readOnly",true);
			$("select").attr("readOnly",true);
		} else {
			createInputFilter("#fbk1",logisticsMap);
		}
		$("#purchaseInChargeParam").val(headGrid.row(0).purchaseInCharge);
		if (headGrid.row(0).purchaseInCharge) {
			$("#purchaseInCharge").find("option").each(function(){
				if (headGrid.row(0).purchaseInCharge.indexOf($(this).val()) != -1) {
					$(this).attr("selected","selected");
				}
			});
		}else{
			$("#purchaseInCharge").find("option").each(function(){
				if (elsSubAccount.indexOf($(this).val().split("_")[0]) != -1) {
					$(this).attr("selected","selected");
				}
			});
		}
		$("#purchaseInCharge").SumoSelect({optAfter:'#sheet-head ',optCancel:'#sheet-head .mmg-bodyWrapper'});
		changeButtonStatus();
	});
	if (!itemGrid) {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols,
	        checkCol:true,
	        height:height,
	        items: data.bomVoucherItemList
	    });
	} else {
		itemGrid.load(data.bomVoucherItemList);
	}
	itemGrid.on('loadSuccess',function(e, d) {
		$("#table-item").find("input").not(":checkbox").each(function(){
			$(this).css("width",$(this).parent().parent().width()-15);
		});
		for (var i=0;i<data.bomVoucherItemList.length;i++) {
			if (data.bomVoucherItemList[i].purchaseOrderNumber == '') {
				var $tr = $("#table-item").find("tr").eq(i);
				var $purchaseMaterialNumber = $tr.find(".purchaseMaterialNumber");
				$purchaseMaterialNumber.show();
				$purchaseMaterialNumber.css("width",$purchaseMaterialNumber.parent().parent().width()-15);
				$purchaseMaterialNumber.prev("span").hide();
				var $purchaseMaterialDesc = $tr.find(".purchaseMaterialDesc");
				$purchaseMaterialDesc.show();
				$purchaseMaterialDesc.css("width",$purchaseMaterialDesc.parent().parent().width()-15);
				$purchaseMaterialDesc.prev("span").hide();
				
				var $saleMaterialNumber = $tr.find(".saleMaterialNumber");
				$saleMaterialNumber.show();
				$saleMaterialNumber.css("width",$saleMaterialNumber.parent().parent().width()-15);
				$saleMaterialNumber.prev("span").hide();
				var $saleMaterialDesc = $tr.find(".saleMaterialDesc");
				$saleMaterialDesc.show();
				$saleMaterialDesc.css("width",$saleMaterialDesc.parent().parent().width()-15);
				$saleMaterialDesc.prev("span").hide();
				$tr.find(".isFree").attr("checked","checked");
			}
		}
		checkFree();
		bindItemEvent();
		var deliveryStatus = headGrid.row(0).deliveryStatus;
		if (flowCode != "" && flowCode != "00" || deliveryStatus !=0) {
			$("input").attr("readOnly",true);
			$("select").attr("readOnly",true);
		}
		changeButtonStatus();
		//初始化每一行中添加发货包装明细的链接
		initRowLink();
		itemGrid.select('all');
	});
}
function bindItemEvent(){
	$(".WESBZ").blur(function(){
		var val = $(this).val();
		var $conversionParam = $(this).parent().parent().parent().find(".conversionParam");
		var $WESBS = $(this).parent().parent().parent().find(".WESBS");
		if (isNaN(val)) {
			alert("<i18n:I18n key='i18n_delivery_onlynumeric' defaultValue='请输入数字' />",2);
			$(this).focus();
			return;
		}
		$WESBS.val(parseFloat(val)*parseFloat($conversionParam.val())/100);
	});
	$(".conversionParam").blur(function(){
		var val = $(this).val();
		var $WESBZ = $(this).parent().parent().parent().find(".WESBZ");
		var $WESBS = $(this).parent().parent().parent().find(".WESBS");
		if (isNaN(val)) {
			alert("<i18n:I18n key='i18n_delivery_onlynumeric' defaultValue='请输入数字' />",2);
			$(this).focus();
			return;
		}
		$WESBS.val(parseFloat($WESBZ.val())*parseFloat(val)/100);
		
	});
	$(".WESBS").blur(function(){
		var val = $(this).val();
		var $WESBZ = $(this).parent().parent().parent().find(".WESBZ");
		var $conversionParam = $(this).parent().parent().parent().find(".conversionParam");
		if (isNaN(val)) {
			alert("<i18n:I18n key='i18n_delivery_onlynumeric' defaultValue='请输入数字' />",2);
			$(this).focus();
			return;
		}
		$WESBZ.val(parseFloat(val)*100/parseFloat($conversionParam.val()));
	});
}

$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editDelivery" + "&window=iframeApp_editDelivery",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
$("#headColumnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=deliveryHead" + "&window=iframeApp_editDelivery",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
var cols_file = [{ title:'id',name:'formId' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'materialVoucherItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialheader" defaultValue="凭证头文件" />';
	                	} else{
	                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialitem" defaultValue="凭证项文件" />';
	                	}
	                }},
                 { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="订单项编号" />',name:'materialVoucherItemNumber' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />',name:'filePath' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_delivery_lable_mobiletype" defaultValue="移动类型" />',name:'mobileType' ,width:200, align:'center',hidden:true},
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
                 }},
                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
	                  	if (val == elsAccount) {
	                 		return '<i18n:I18n key="i18n_label_self" defaultValue="已方" />';
	                 	} else {
	                 		return '<i18n:I18n key="i18n_label_otherSide" defaultValue="对方" />';
	                 	} 
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

function getOrderItem(){
	$("#orderItemSelector").empty();
	var html = "";
	var trs = $("#table-item").find("tr");
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		if (data.materialVoucherNumber != "") 
			html += "<option value='"+data.materialVoucherItemNumber+"'>" + data.materialVoucherItemNumber + "_" + data.saleMaterialDesc + "</option>";
	}
	$("#orderItemSelector").append(html);
	
}

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
	var materialVoucherNumber = headGrid.row(0).materialVoucherNumber;
	var toElsAccount = headGrid.row(0).toElsAccount;
	var isOrderItem = $("#operTypeSelector").val();
	var materialVoucherItemNumber = null;
	if(isOrderItem == 1)
		materialVoucherItemNumber = $("#orderItemSelector").val();
	var fileType = $("#fileType").val();
	var logtime = new Date();
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"mobileType":601,"fileStatus":0,"materialVoucherNumber":materialVoucherNumber,"materialVoucherItemNumber":materialVoucherItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialFormFileService/addMaterialFormFile",
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
	var materialVoucherNumber = headGrid.row(0).materialVoucherNumber;
	var toElsAccount = headGrid.row(0).toElsAccount;
	var materialVoucherItemNumber = $("#orderItemSelector").val();
	var fileType = $("#fileType").val();
	var filePath = $("#filePath").val();
	var logtime = new Date();
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"formId":formId,"mobileType":mobileType,"fileStatus":fileStatus,"materialVoucherNumber":materialVoucherNumber,"materialVoucherItemNumber":materialVoucherItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialFormFileService/updateMaterialFormFile",
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
function initFileGrid(){
	if(!fileGrid){
		fileGrid = $('#table-file').mmGrid({
	        cols: cols_file,
	        items: [],
	        checkCol: true
	    });
	}
}
function loadFileItem(materialVoucherNumber){
	var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":"601"};
		$.ajax({
			url :"<%=basePath%>rest/MaterialFormFileService/findMaterialFormFile",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				fileGrid.load(data.rows);
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
}
$('#btnAddFile').click(function() {
	var materialVoucherNumber = headGrid.row(0).materialVoucherNumber; 
	if (materialVoucherNumber == "" || materialVoucherNumber == null) {
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_delivery_confirm_savedeliveryorderfirst" defaultValue="请先保存发货单！是否确认保存？" />',closeEvent:function(){
			$("#saveBtn").trigger("click");
		}});
	}else{
        $('.fixed-dialog').show();
        initAddFileDialog();
        initFileUploader(fileUploader);
	}
});
$('#btnModifyFile').click(function() {
	var selectedIndexs = fileGrid.selectedRowsIndex();
	if (selectedIndexs.length == 0) {
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
		return;
	}
	var selectedRow = fileGrid.row(selectedIndexs[0]);
	formId = selectedRow.formId;
	fileName = selectedRow.fileName;
	fileStatus = selectedRow.fileStatus;
	mobileType = selectedRow.mobileType;
	orderItemNumber = selectedRow.materialVoucherItemNumber;
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
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){

	var selectedRow = fileGrid.row(selectedIndexs[0]);
	var data = {"formId":selectedRow.formId,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialFormFileService/deleteMaterialFormFile",
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
    		url :"<%=basePath%>rest/SaleFormFileService/order/send",
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
 
function changeButtonStatus() {
	var deliveryStatus = headGrid.row(0).deliveryStatus;
	if (deliveryStatus != 0) {
		$(".edit-btn").hide();
		$("#sendBtn").hide();
	}
	//根据flowCode改变各按钮状态 
	if (flowCode != "" && flowCode != "00") {
		$("#entryBtn").hide();
		$("#cancelEntryBtn").show();
		$("#flowBtn").show();
		$(".edit-btn").hide();
	} else {
		$("#entryBtn").show();
		$("#cancelEntryBtn").hide();
		$("#flowBtn").hide();
	}
}

//获取每个订单项可以发货数量
function getDeliveryQuery(){
	var allRows=itemGrid.rows();
	for(var i=0;i<allRows.length;i++){
		var orderItemNumber=allRows[i].orderItemNumber;
		if(orderItemNumber!=""&&orderItemNumber!=null){
			var maxDelivery=allRows[i].maxDelivery;
			var deliveredQuantity=allRows[i].deliveredQuantity;
			if(!deliveredQuantity||isNaN(deliveredQuantity)){
				deliveredQuantity=0;
			}
			var quantity=allRows[i].quantity;
			if(maxDelivery&&maxDelivery!="0"){
				itemNumberJson[orderItemNumber]=parseFloat(maxDelivery)-parseFloat(deliveredQuantity);
			}else{
				var quantity=allRows[i].orderQuantity;
				itemNumberJson[orderItemNumber]=parseFloat(quantity)-parseFloat(deliveredQuantity);
			}
		}
	}
}

function updateRowLink(item,itemQuantity,quantity){
	$("#table-item").find("tr").each(function(){
		var data = $(this).data("item");
		if(item == data.materialVoucherItemNumber){
			var link = $(this).find("span[name='rowLink']");
			var linkInput = $(this).find("input[name='materialVoucherItemList[][fbk32]']");
			var $conversionParam = $(this).find(".conversionParam");
			var $WESBS = $(this).find(".WESBS");
			var $WESBZ = $(this).find(".WESBZ");
			link.text(itemQuantity);
			linkInput.val(itemQuantity);
			$WESBZ.val(quantity);
			$WESBS.val(parseFloat(quantity)*parseFloat($conversionParam.val())/100);
			/* 更新该链接传递的总数量 */
			var data = $(this).data("item");
			link.unbind("click");
			link.click(function(){
				var materialVoucherNumber = headGrid.row(0).materialVoucherNumber; 
				var materialVoucherItemNumber = data.materialVoucherItemNumber;
				var url = "<%=basePath%>ordermanage/materialVoucher/editDeliveryPackage.jsp?materialVoucherNumber=" + materialVoucherNumber + "&materialVoucherItemNumber=" + materialVoucherItemNumber + "&wesbz=" + quantity;
				//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'editDeliveryPackage',
			        'windowTitle':'<i18n:I18n key="i18n_delivery_windowtitle_setpackage" defaultValue="添加发货包装明细" />',
			        'iframSrc':url,
			        'windowWidth':900,
			        'windowHeight':600,
			        'parentPanel':".currDesktop"
			    });
			});
		}
	});
}

function initRowLink(){
	$("#table-item").find("tr").each(function(){
		var link = $(this).find("span[name='rowLink']");
		var wesbz = $(this).find(".WESBZ").val();
		var wesbs = $(this).find(".WESBS").val();
		var conversionParam = $(this).find(".conversionParam").val();
		var data = $(this).data("item");
		link.click(function(){
			var materialVoucherNumber = headGrid.row(0).materialVoucherNumber; 
			if (materialVoucherNumber == "" || materialVoucherNumber == null) {
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_delivery_confirm_savedeliveryorderfirst" defaultValue="请先保存发货单！是否确认保存？" />',closeEvent:function(){
					$("#saveBtn").trigger("click");
				}});
			}else{
				var materialVoucherItemNumber = data.materialVoucherItemNumber;
				var url = "<%=basePath%>ordermanage/materialVoucher/editDeliveryPackage.jsp?materialVoucherNumber=" + materialVoucherNumber + "&materialVoucherItemNumber=" + materialVoucherItemNumber + "&wesbz=" + wesbz + "&wesbs=" + wesbs + "&conversionParam=" + conversionParam;
				//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'editDeliveryPackage',
			        'windowTitle':'<i18n:I18n key="i18n_delivery_windowtitle_setpackage" defaultValue="添加发货包装明细" />',
			        'iframSrc':url,
			        'windowWidth':900,
			        'windowHeight':600,
			        'parentPanel':".currDesktop"
			    });
			}
		});
	});
}

function check(){
	getDeliveryQuery();
	var resultStr="true";
	$('#table-item').find("tr").each(function(){
		var orderItemNumber=$(this).find("input[name='materialVoucherItemList[][orderItemNumber]']").val();
		if(orderItemNumber!=""&&orderItemNumber!=null){
			var wesbz=$(this).find(".WESBZ").val();
			var deliveryQuantity=itemNumberJson[orderItemNumber];
// 			var saleOrderNumber=$(this).find("input[name='materialVoucherItemList[][saleOrderNumber]']").val();
			if(parseFloat(wesbz)>parseFloat(deliveryQuantity)){
				resultStr= "<i18n:I18n key='i18n_delivery_orderitem' defaultValue='订单项' />" + "【" + orderItemNumber + "】" + "<i18n:I18n key='i18n_delivery_amounterror' defaultValue='的数量不能超过可发货数' />";
			}else if(parseFloat(wesbz) == 0){
				resultStr= "<i18n:I18n key='i18n_delivery_orderitem' defaultValue='订单项' />" + "【" + orderItemNumber + "】" + "<i18n:I18n key='i18n_delivery_amountemptyerror' defaultValue='的数量不能为 0' />";
			}
		}
	});
	return resultStr;
}

</script>
</body>
</html>