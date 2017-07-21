<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<base:supplierAuth elsAccount="${param['toElsAccount'] }" authCode="busRecon" toElsAccount="${elsAccount }"></base:supplierAuth>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation"/></span>
            <div class="common-box-line">
                <button id="queryHeadBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
                <button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create"/></button>
                <!-- <button id="updBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update"/></button> -->
                <button id="detailBtn" class="button-wrap"><i18n:I18n defaultValue="详情" key="test"/></button>
                <button id="delBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete"/></button>
                <button id="sendBtn" class="button-wrap"><i18n:I18n defaultValue="发送" key="i18n_button_send"/></button>
                <button class="button-wrap" id="columnDefineBtn"><i18n:I18n defaultValue="帐单头列自定义" key="test"/></button>
                <button class="button-wrap" id="itemDefineBtn"><i18n:I18n defaultValue="帐单行列自定义" key="test"/></button>
		        <button class="button-wrap" id="receiptDefineBtn"><i18n:I18n defaultValue="收货列自定义" key="test"/></button>
		        <button class="button-wrap" id="additionalDefineBtn"><i18n:I18n defaultValue="附加费列自定义" key="test"/></button>
		        <button class="button-wrap" id="deductDefineBtn"><i18n:I18n defaultValue="扣款费列自定义" key="test"/></button>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                	<strong><i18n:I18n defaultValue="对账单号" key="i18n_busRecon_label_saleBusReconNumber"/>：</strong><input type="text" id="saleBusReconNumber" name="saleBusReconNumber" />
				</div>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="对账单头信息" key="test"/></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="headTable"></table>
                        <div id="headPage" style="text-align: right;"></div>
                    </div>
               </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="对账单详细信息" key="test"/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="对账单行项目" key="test"/></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n defaultValue="表单文件" key="i18n_enquiry_title_formfile"/></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n defaultValue="收货明细" key="i18n_busRecon_title_receiptDetail"/></a></li>
                        <li><a href="#sheet-project-five"><i18n:I18n defaultValue="附加费明细" key="i18n_busRecon_title_additionalChargeDetail"/></a></li>
                        <li><a href="#sheet-project-six"><i18n:I18n defaultValue="扣款明细" key="i18n_busRecon_title_deductMoneyDetail"/></a></li>
                        <li><a href="#sheet-project-seven"><i18n:I18n defaultValue="发票明细" key="i18n_busRecon_title_invoiceDetail"/></a></li>
                    </ul>
                    <div id="sheet-project-one" style="padding: 1px;">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="reCreate">
		                        <table id="itemTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two" style="padding: 1px;">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<div class="file-list-head">
					                   <select id="selectFileType" name="selectFileType" style="width: 165px;">
					                   <option value="all"><i18n:I18n defaultValue="所有文件" key="i18n_common_select_filetype_all"/></option>
					                   <option value="common"><i18n:I18n defaultValue="公共文件" key="i18n_common_select_filetype_public"/></option>
					                   <%-- <option value="2"><i18n:I18n defaultValue="行项目文件" key="i18n_busRecon_select_fileType_line"/></option> --%>
					                   </select>
					                 </div>
									<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="fileTable" style="width: 300px;"></table>
										</div>
									</main>
			                    </div>
				                 <div class="file-scan">
		   							<div class="file-option-zoom">
					                  <div class="dis-in-b text-left">
							             <button id="addFileBtn" class="btn"><i18n:I18n defaultValue="刷新" key="i18n_common_button_refresh"/></button>
							         </div>
								     </div>
								     <div class="file-display" id="file-display">
										<a id="viewerPlaceHolder"></a>
								     </div>
								</div>
						</div>
						</div>
                    </div>
                    <div id="sheet-project-three" style="padding: 1px;">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="receiptDiv">
		                        <table id="receiptTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-five" style="padding: 1px;">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="additionCostDiv">
		                        <table id="additionCostTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-six" style="padding: 1px;">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="deductionDiv">
		                        <table id="deductionTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-seven" style="padding: 1px;">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="invoiceDiv">
		                        <table id="invoiceTable"></table>
		                    </div>
		                </main>
                    </div>
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
<script>
	var elsAccount="${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	var $sob;
	var headGrid;
	var itemGrid;
	var fileGrid;
	var receiptGrid;
	var additionCostGrid;
	var deductionGrid;
	var invoiceGrid;
	
	debugger;

	/****  自定义列编辑字段 start  *****/
	var initQuantity = function(val,item,index) {
	}
	
	var costTypeRender = function(val,item,index) {
		if("mat"==val){
			return "收货费用单";
		}else if("add"==val){
			return "附加费用单";
		}else if("ded"==val){
			return "扣款费用单";
		}
	}
	/****  自定义列编辑字段 end  *****/
	
	var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleBusReconManageHead_mt"/>;
	var param = {
	    	elsAccount : elsAccount,
	    	saleBusReconNumber : ""
	    };
	headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/querySaleBusReconHead",
		params: param,
		method :  "POST",
		height:<base:tableHeight tableCode="saleBusReconManageHead_mt"/>,
		cols : headCols,
		autoLoad : false,
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
        checkCol : true,
        indexCol :false,
		plugins : [
		    $("#headPage").mmPaginator({
		        style : "plain",
		        totalCountName : "total",
		        page : 1,
		        pageParamName : "currentPage",
		        limitParamName : "pageSize",
		        limitLabel : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
		        totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
		        limit : null,
		        limitList : [10,20,50,100]
		    })
		]
	});
	
	debugger;
	var itemCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleBusReconManageItem_mt"/>;
	itemGrid = $("#itemTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/querySaleBusReconItem",
	    method:  "POST",
	    cols : itemCols,
	    height:<base:tableHeight tableCode="saleBusReconManageItem_mt"/>,
	    autoLoad : false,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    checkCol: true,
	    multiSelect: true
	});
	
	var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleBusReconManageFile_mt"/>;
	fileGrid = $("#fileTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/querySaleBusReconFile",
	    method : "post",
	    cols : fileCols,
	    height:<base:tableHeight tableCode="saleBusReconManageFile_mt"/>,
	    autoLoad : false,
	    root : "rows",
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    fullWidthRows :true,
	    indexCol : false,
	    plugins : [
	        $("#filePage").mmPaginator({
	            style: "plain",
	            totalCountName: "total",
	            page: 1,
	            pageParamName: "currentPage",
	            limitParamName: "pageSize",
	            limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	            totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	            limit: null,
	            limitList: [10, 30, 40, 50]
	        })
	    ]
	});
	
	//收货信息列
	var receiptCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="queryReceipt_item_mt"/>;
	receiptGrid = $('#receiptTable').mmGrid({
	    cols : receiptCols,
	    height:<base:tableHeight tableCode="queryReceipt_item_mt"/>,
	    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/queryReceiptItemForBusRecon",
	    method : 'post',
	    root : "rows",
	    autoLoad : false,
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
	    checkCol : true,
	    indexCol : false
	});
	
	//附加费用信息列
	var additionCostCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageItem_mt"/>;
	additionCostGrid = $('#additionCostTable').mmGrid({
	    cols : additionCostCols,
	    height:<base:tableHeight tableCode="saleAdditionCostManageItem_mt"/>,
	    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/queryAdditionCostItemForBusRecon",
	    method : 'post',
	    root : "rows",
	    autoLoad : false,
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
	    checkCol : true,
	    indexCol : false
	});

	//扣款信息列
	var deductionCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageItem_mt"/>;
	deductionGrid = $('#deductionTable').mmGrid({
		height:<base:tableHeight tableCode="saleAdditionCostManageItem_mt"/>,
	    cols : deductionCols,
	    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/queryDeductionCostItemForBusRecon",
	    method : 'post',
	    root : "rows",
	    autoLoad : false,
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
	    checkCol : true,
	    indexCol : false
	});
	
	//发票信息列
	var invoiceCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleBusReconManageInvoice_mt"/>;
	invoiceGrid = $('#invoiceTable').mmGrid({
	    cols : invoiceCols,
	    height:<base:tableHeight tableCode="saleBusReconManageInvoice_mt"/>,
	    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/queryInvoiceItemForBusRecon",
	    method : 'post',
	    root : "rows",
	    autoLoad : false,
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
	    checkCol : true,
	    indexCol : false
	});
	
	$().ready(function(){
		$sob = $('.saying-dialog .option-bar');
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    $("#sheet-project").tabs();
	    
	    var saleBusReconNumber = $("#saleBusReconNumber").val();
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	saleBusReconNumber : saleBusReconNumber
	    };
	    headGrid.load(queryParam);
	}
    
    headGrid.on("loadSuccess",function(e, data) {
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
			var seled=headGrid.selectedRows();
			if(seled && seled.length) {
				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
				$sob[0].storeInitChat=function(){initChat(seled)};
				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 end
				if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
	            $sob.click();
			}
		}else{
			clearChildTables();
		}
    });
    
 	// 加载明细项
    headGrid.on("cellSelected",function(e, item, rowIndex, colIndex) {
    	debugger;
    	clearChildTables();
		var hadSelected = headGrid.selectedRows();
		if(hadSelected && hadSelected.length) {
			loadItem(item.elsAccount,item.toElsAccount,item.saleBusReconNumber);
	    	loadFile(item.elsAccount,item.toElsAccount,item.saleBusReconNumber);
	    	loadReceipt(item.elsAccount,item.toElsAccount,item.saleBusReconNumber,item.reconStartDate,item.reconEndDate);
			loadAdditionCost(item.elsAccount,item.toElsAccount,item.saleBusReconNumber,item.reconStartDate,item.reconEndDate);
			loadDeduction(item.elsAccount,item.toElsAccount,item.saleBusReconNumber,item.reconStartDate,item.reconEndDate);
			loadInvoice(item.elsAccount,item.toElsAccount,item.saleBusReconNumber);
			debugger;
			// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
			if(!ableToggleInit()) {
				$sob[0].storeInitChat=function(){initChat(hadSelected)};
			} else {
				initChat(hadSelected);
			}
			// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 end
    	} else {
    		clearChildTables();
    	}
    });
 	
    fileGrid.on("loadSuccess", function(e, data){
    	reGenFileTypeSelect();
  	});
    
    fileGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
  		previewFile(filePath);
  	});
    
    receiptGrid.on("loadSuccess", function(e, data){
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
    		var rows = data.rows;
    		for(var i=0;i<rows.length;i++){
    			var saleBusReconNo = rows[i].isReconciliation;
    			if("undefined"!=typeof(saleBusReconNo) && saleBusReconNo != null &&  saleBusReconNo != ""){
    				receiptGrid.select(i);
    			}
    		}
    	}
  	});
    
    additionCostGrid.on("loadSuccess", function(e, data){
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
    		var rows = data.rows;
    		for(var i=0;i<rows.length;i++){
    			var saleBusReconNo = rows[i].saleBusReconNumber;
    			if("undefined"!=typeof(saleBusReconNo) && saleBusReconNo != null &&  saleBusReconNo != ""){
    				additionCostGrid.select(i);
    			}
    		}
    	}
    	
  	});
    
    deductionGrid.on("loadSuccess", function(e, data){
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
    		var rows = data.rows;
    		for(var i=0;i<rows.length;i++){
    			var saleBusReconNo = rows[i].saleBusReconNumber;
    			if("undefined"!=typeof(saleBusReconNo) && saleBusReconNo != null &&  saleBusReconNo != ""){
    				deductionGrid.select(i);
    			}
    		}
    	}
  	});
    
    $("#queryHeadBtn").click(function(){
		refreshData();
	});
	
	$("#addBtn").click(function(){
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "saleBusReconAdd",
	        windowTitle : "<i18n:I18n defaultValue='新建业务对账单' key='i18n_busRecon_title_createBusRecon'/>",
	        iframSrc : "${pageContext.request.contextPath}/busreconmanage/sale/saleBusReconAdd.jsp",
	        showAdv : true,
	        windowStatus : "maximized",
	        windowMinWidth : 960,
	        windowMinHeight : 700,
	        windowWidth : 960,
	        windowHeight : 700,
	        parentPanel : ".currDesktop"
	    });
	});
	
	$("#updBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var busReconStatus = headRecord.busReconStatus;
			var salePerson = headRecord.salePerson;//subAccount_name
			var currPerson = elsSubAccount+"_"+userName;
			if((busReconStatus == "0" || busReconStatus == "2" || busReconStatus == "7")
					&& salePerson.indexOf(currPerson)>=0 ){
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "saleBusReconUpd",
			        windowTitle : "<i18n:I18n defaultValue='修改对账单' key='i18n_res_purchaseBusinessReconciliation_updatePurchaseBusRecon'/>",
			        iframSrc : "${pageContext.request.contextPath}/busreconmanage/sale/saleBusReconUpd.jsp?"
			        		+"elsAccount="+headRecord.elsAccount
			        		+"&toElsAccount="+headRecord.toElsAccount
			        		+"&saleBusReconNumber="+ headRecord.saleBusReconNumber,
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
			} else {
				alert("<i18n:I18n defaultValue='非负责人或对方已确认对账单禁止再修改!' key='i18n_alert_notSalePersonOrOtherConfirmedProhibitUpdate'/>",2);
			}
		} else {
			alert("<i18n:I18n defaultValue='请选择修改对账单!' key='i18n_res_purchaseBusinessReconciliation_pleaseSelectUpdatePurchaseBusRecon'/>",2); 
		}
	});
	
	$("#detailBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var busReconStatus = headRecord.busReconStatus;
			var salePerson = headRecord.salePerson;//subAccount_name
			var currPerson = elsSubAccount+"_"+userName;
			if((busReconStatus == "0" || busReconStatus == "2" || busReconStatus == "7")
					&& salePerson.indexOf(currPerson)>=0 ){
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "saleBusReconUpd",
			        windowTitle : "<i18n:I18n defaultValue='详情对账单' key='test'/>",
			        iframSrc : "${pageContext.request.contextPath}/busreconmanage/sale/saleBusReconDetail.jsp?"
			        		+"elsAccount="+headRecord.elsAccount
			        		+"&toElsAccount="+headRecord.toElsAccount
			        		+"&saleBusReconNumber="+ headRecord.saleBusReconNumber,
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
			} else {
				alert("<i18n:I18n defaultValue='非负责人或对方已确认对账单禁止再修改!' key='i18n_alert_notSalePersonOrOtherConfirmedProhibitUpdate'/>",2);
			}
		} else {
			alert("<i18n:I18n defaultValue='请选择修改对账单!' key='i18n_res_purchaseBusinessReconciliation_pleaseSelectUpdatePurchaseBusRecon'/>",2); 
		}
	});
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var busReconStatus = headRecord.busReconStatus;
			var salePerson = headRecord.salePerson;//subAccount_name
			var currPerson = elsSubAccount+"_"+userName;
			var busReconStatus = headRecord.busReconStatus;
			var sendStatus = headRecord.sendStatus;
			if(((busReconStatus == "0" && "0" == sendStatus) || busReconStatus == "7")
					&& salePerson.indexOf(currPerson)>=0){
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/delSaleBusRecon",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(selectRows),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
							
							var selectedIndexes = headGrid.selectedRowsIndex();
							headGrid.removeRow(selectedIndexes);
							
							clearItemtable();
							clearFiletable();
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除失败' key='i18n_delivery_deletefail'/>",3);
						}
					});
				}});
			} else {
				alert("<i18n:I18n defaultValue='非负责人或已发送对账单禁止删除!' key='i18n_alert_notSalePersonOrBusReconSentProhibitDelete'/>",2);

			}
		} else {
			alert("<i18n:I18n defaultValue='请选择删除费用单!' key='i18n_label_additionCost_pleaseSelectAdditionCostDelete'/>",2);
		}
		
	});
	
	//上传ERP
	$("#parkingInvoiceBtn").click(function(){
		var headRows = headGrid.selectedRows();//获取所选择行数据数组
	    var headIndexs = headGrid.selectedRowsIndex();//获取所选择行索引数组
	    if("undefined" != typeof(headRows) && headRows != ""){
	    	var headRow = headRows[0];// 获取对账单头信息，因为表格设置为单选，所以这里最多是一行数据
	    	parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认上传ERP',closeEvent:function(){
				parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_sending" defaultValue="发送中"/>');
				$.ajax({
	    			url :"${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/saleGenerateErpInvoice",
	    			type :"post",
	    			contentType : "application/json",
	    			data : JSON.stringify(headRow),
	    			dataType : "json",
	    			success : function(data) {
	    				parent.elsDeskTop.hideLoading();
	    				if("200"==data.statusCode){
		    				alert('上传ERP成功',1);
		    				$("#queryHeadBtn").trigger('click');//刷新数据显示
	    				} else {
	    					alert(data.message,3);
	    				}
	    			},
	    			error : function(data) {
	    				parent.elsDeskTop.hideLoading();
	    				alert('上传ERP失败',3);
	    			}
	    		});
			}});
	    }
	});
	
	//发送
	$("#sendBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var saleBusReconHead = selectRows[0];
		   	var saleBusReconItem = itemGrid.rowsLength() == 0 ? [] : itemGrid.rows();
		   	var saleBusReconFile = fileGrid.rowsLength() == 0 ? [] : fileGrid.rows();
		   	var receiptItem = receiptGrid.rowsLength() == 0 ? [] : receiptGrid.selectedRows();
		   	var additionCostItem = additionCostGrid.rowsLength() == 0 ? [] : additionCostGrid.selectedRows();
		   	var deductionItem = deductionGrid.rowsLength() == 0 ? [] : deductionGrid.selectedRows();
		   	var invoiceItem = invoiceGrid.rowsLength() == 0 ? [] : invoiceGrid.selectedRows();
		   	
		   	var data = {
		   			operate : "send",
		   			saleBusReconHead : JSON.stringify(saleBusReconHead),
		   			saleBusReconItem : JSON.stringify(saleBusReconItem),
		   			saleBusReconFile : JSON.stringify(saleBusReconFile),
		   			receiptItem : JSON.stringify(receiptItem),
		   			additionCostItem : JSON.stringify(additionCostItem),
		   			deductionItem : JSON.stringify(deductionItem),
		   			invoiceItem : JSON.stringify(invoiceItem)
		   	}
		   	
		   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='对账单发送中!' key='i18n_label_additionCost_BusReconIsSent'/>");
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/sendSaleBusRecon",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='发送成功' key='i18n_common_sendsuccess'/>!",1);
					refreshData();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='发送失败' key='i18n_common_sendfail'/>!",3);
				}
			});
		} else {
			alert("<i18n:I18n defaultValue='请选择发送对账单!' key='i18n_res_purchaseBusinessReconciliation_pleaseSelectBusReconToSend'/>",2); 
		}
	});
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleBusReconManageHead_mt&window=iframeApp_saleBusReconManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	$("#itemDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
			iconSrc : "icon/els-icon.png",
			windowsId :"subAccountColumnSetting",
			windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
			windowSubTitle : "",
			iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleBusReconManageItem_mt&window=iframeApp_saleBusReconManage",
			showAdv : true,
			advArr : ["icon/test-car.png","icon/test-car2.png"],
			windowMinWidth : 480,
			windowMinHeight : 600,
			windowWidth :480,
			windowHeight :600,
			parentPanel : ".currDesktop"
		});
	});
	
	$("#receiptDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
			iconSrc : "icon/els-icon.png",
			windowsId :"subAccountColumnSetting",
			windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
			windowSubTitle : "",
			iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryReceipt_item_mt&window=iframeApp_saleBusReconManage",
			showAdv : true,
			advArr : ["icon/test-car.png","icon/test-car2.png"],
			windowMinWidth : 480,
			windowMinHeight : 600,
			windowWidth :480,
			windowHeight :600,
			parentPanel : ".currDesktop"
		});
	});
	
	$("#deliveryDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
			iconSrc : "icon/els-icon.png",
			windowsId :"subAccountColumnSetting",
			windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
			windowSubTitle : "",
			iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryDelivery_item_mt&window=iframeApp_saleBusReconManage",
			showAdv : true,
			advArr : ["icon/test-car.png","icon/test-car2.png"],
			windowMinWidth : 480,
			windowMinHeight : 600,
			windowWidth :480,
			windowHeight :600,
			parentPanel : ".currDesktop"
		});
	});
	
	$("#additionalDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
			iconSrc : "icon/els-icon.png",
			windowsId :"subAccountColumnSetting",
			windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
			windowSubTitle : "",
			iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageItem_mt&window=iframeApp_saleBusReconManage",
			showAdv : true,
			advArr : ["icon/test-car.png","icon/test-car2.png"],
			windowMinWidth : 480,
			windowMinHeight : 600,
			windowWidth :480,
			windowHeight :600,
			parentPanel : ".currDesktop"
		});
	});
	
	$("#deductDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
			iconSrc : "icon/els-icon.png",
			windowsId :"subAccountColumnSetting",
			windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
			windowSubTitle : "",
			iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageItem_mt&window=iframeApp_saleBusReconManage",
			showAdv : true,
			advArr : ["icon/test-car.png","icon/test-car2.png"],
			windowMinWidth : 480,
			windowMinHeight : 600,
			windowWidth :480,
			windowHeight :600,
			parentPanel : ".currDesktop"
		});
	});
	
	function refreshData(){
		var saleBusReconNumber = $("#saleBusReconNumber").val();
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	saleBusReconNumber : saleBusReconNumber
	    };
		headGrid.load(queryParam);
	}
    
	function isImage(filePath){
		if("undefined" != typeof(filePath) && "" != filePath){
	    	var fileSuffix = filePath.substring(filePath.lastIndexOf('.')+1);
			if("bmp,png,gif,jpg,jpeg".indexOf(fileSuffix.toLowerCase()) > 0){
	    		return true;
	    	} else {
	    		return false;
	    	}
		} else {
			return false;
		}
    }
	
    //在线预览文件
    function previewFile(filePath){
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var param = {
				elsAccount : elsAccount,
				filePath : filePath
		};
    	
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	} else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
	    	$.ajax({
				url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
				type :"POST",
				data : JSON.stringify(param),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					var resStatus = data.statusCode;
					var message = data.message;
					if("200" == resStatus){
						var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
						var width=$("#file-display").width();
						var height=$("#file-display").height();
						$("#viewerPlaceHolder").css("width",width+"px");  
						$("#viewerPlaceHolder").css("height",height+"px");  
						$("#viewerPlaceHolder").css("display","block" );  
	
						var fp = new FlexPaperViewer(
						            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
						            'viewerPlaceHolder', 
						            {config : {
						                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
						                Scale : 1.5,//初始化缩放比例(1=100%)
						                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
						                ZoomTime : 0.5,//切换缩放比例延迟显示时间
						                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
						                FitPageOnLoad : false,//初始化时自适应页面
						                FitWidthOnLoad : false,//初始化时自适应宽度
						                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
						                ProgressiveLoading : true,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
						                MinZoomSize : 0.2,//最小缩放比例
						                MaxZoomSize : 5,//最大缩放比例
						                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
						                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
						                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
						                ZoomToolsVisible : true,//工具浪是否显示缩放工具
						                NavToolsVisible : true,//工具栏是否显示导航工具
						                CursorToolsVisible : true,//工具栏是否显示光标
						                SearchToolsVisible : true,//工具栏是否显示搜索工具
						                localeChain: 'zh_CN'//地区语言(en_US:English,)
						            	}
						            });
					} else {
						alert(message,3); 
					}
				},
				error : function(data) {
					alert(data.message,3); 
				}
			});
    	} else {
    		alert("<i18n:I18n defaultValue='不支持在线预览的文档类型' key='i18n_alert_filetypenotsupport'/>!",3);
    	}
    }

	//初始化聊天窗口
	//ELS账号+订单号 作为 businessID
	//TODO: 多人聊天需要传值 peopleList
	function initChat(data) {	
		   var elsAccount		='<%=session.getAttribute("elsAccount") %>',
		  	  elsSubAccount		='<%=session.getAttribute("elsSubAccount") %>',
		  	  toElsAccount = '',
		  	  toElsSubAccount ='';
		  	  var businessId = '';
		  	  var peopleList = [];
			  if(data) {
				  toElsAccount = data[0].toElsAccount;
				  businessId=''+data[0].saleBusReconNumber;
				  if(data[0].purchasePerson) {
					  var purchasePerson = data[0].purchasePerson;
					  var purchaseArr = purchasePerson.split(';');
					  var storeArr =[];
					  if(purchaseArr && purchaseArr.length) {
						  if(purchaseArr && purchaseArr.length==1) {
							  var per = purchaseArr[0].split("_");
							  toElsSubAccount= per[0];
						  } else {
							  for(var i in purchaseArr) {
								  var per = purchaseArr[i].split("_");
								  storeArr[i]=per[0];
							  }
							  toElsSubAccount = storeArr&&storeArr.length?storeArr.join(): '';
						} 
					  }
				  }
				  var obj={};
				  obj.name = data[0].toElsDesc;
				  peopleList.push(obj);
			  }
			  var peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
			  var url = "multiChat.jsp?type=multi&fromElsAccount=" + elsAccount
						+ "&fromElsSubAccount=" + elsSubAccount
						+ "&toElsAccount=" + toElsAccount
						+ "&toElsSubAccount="+toElsSubAccount
						+ "&businessType=busRecon"
						+ "&businessID="+businessId
		                + "&list="+encodeURI(peopleListString)
						+"&t="+new Date().getTime();
			   
			   $(".testIframe").attr("src","${pageContext.request.contextPath}/"+ url);
			   //滚动条美化niceScroll
			   $(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
	}

	function loadItem(elsAccount,toElsAccount,saleBusReconNumber) {
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	saleBusReconNumber : saleBusReconNumber
	    };
	    $.extend(itemGrid.opts.params,queryParam);
	    //处理列 
		itemGrid.load();
	    //处理列 
	}
	
	function loadFile(elsAccount,toElsAccount,saleBusReconNumber) {
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	saleBusReconNumber : saleBusReconNumber
	    };
	    $.extend(fileGrid.opts.params,queryParam);
	    fileGrid.load();
	}
	
	function loadReceipt(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate){
		var queryParam = {
				elsAccount : toElsAccount,
				toElsAccount : elsAccount,
				voucherType : "receipt",
				reconStartDate : new Date(reconStartDate).format("yyyy-MM-dd"),
				reconEndDate : new Date(reconEndDate).format("yyyy-MM-dd"),
				saleBusReconNumber : saleBusReconNumber
		};
		$.extend(receiptGrid.opts.params,queryParam);
		receiptGrid.load();
	}
	
	function loadAdditionCost(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate){
		var queryParam = {
				elsAccount : elsAccount,
				toElsAccount : toElsAccount,
				additionCostType : "add",
				reconStartDate : new Date(reconStartDate).format("yyyy-MM-dd"),
				reconEndDate : new Date(reconEndDate).format("yyyy-MM-dd"),
				saleBusReconNumber : saleBusReconNumber
		};
		$.extend(additionCostGrid.opts.params,queryParam);
		additionCostGrid.load();
	}
	
	function loadDeduction(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate){
		var queryParam = {
				elsAccount : elsAccount,
				toElsAccount : toElsAccount,
				additionCostType : "ded",
				reconStartDate : new Date(reconStartDate).format("yyyy-MM-dd"),
				reconEndDate : new Date(reconEndDate).format("yyyy-MM-dd"),
				saleBusReconNumber : saleBusReconNumber
		};
		$.extend(deductionGrid.opts.params,queryParam);
		deductionGrid.load();
	}
	
	function loadInvoice(elsAccount,toElsAccount,saleBusReconNumber){
		var queryParam = {
				elsAccount : elsAccount,
				toElsAccount : toElsAccount,
				saleBusReconNumber : saleBusReconNumber
		};
		$.extend(invoiceGrid.opts.params,queryParam);
		invoiceGrid.load();
	}
	
	// 清空数据 @author update/jiangzhidong @date 20170110 begin
	function clearChildTables(){
		debugger;
		try{
			if(itemGrid.rowsLength() > 0){
				itemGrid.load([]);
			}
			if(fileGrid.rowsLength() > 0){
				fileGrid.load([]);
			}
			if(receiptGrid.rowsLength() > 0){
				receiptGrid.load([]);
			}
			if(additionCostGrid.rowsLength() > 0){
				additionCostGrid.load([]);
			}
			if(deductionGrid.rowsLength() > 0){
				deductionGrid.load([]);
			}
			if(invoiceGrid.rowsLength() > 0){
				invoiceGrid.load([]);
			}
        }catch(e){
        	console.log(e);
        }
	}
	// 清空数据 @author update/jiangzhidong @date 20170110 end
	
	function reGenFileTypeSelect(){
		var itemRowSize = itemGrid.rowsLength();
		var fileTypeSelect = $("#selectFileType");
		fileTypeSelect.empty();
		$("<option value='all'><i18n:I18n defaultValue='所有' key='i18n_common_option_all'/></option>").appendTo(fileTypeSelect);
		$("<option value='common'><i18n:I18n defaultValue='公共' key='i18n_common_option_common'/></option>").appendTo(fileTypeSelect);
		for(var i=0;i<itemRowSize;i++){
			var additionCostItemNumber = itemGrid.row(i).additionCostItemNumber;
			$("<option value='"+additionCostItemNumber+"'>"+additionCostItemNumber+"</option>").appendTo(fileTypeSelect);//文件下拉列表添加行项目选项
		}
	}
	
	//表单文件tag页 文件类型更改事件
	function selectFileTypeChange(){
		var selectFileType = $("#selectFileType").val();
		if("all" == selectFileType){//显示所有
			$("#fileTable tr").each(function(index,domElement){
				$(domElement).show();
			});
		} else if("common" == selectFileType){//只显示公共文件
			$("#fileTable tr").each(function(index,domElement){
				var itemNumber = fileGrid.row(index).additionCostItemNumber;
				if("" == itemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		} else {//显示指定行项目下的文件
			$("#fileTable tr").each(function(index,domElement){
				var itemNumber = fileGrid.row(index).additionCostItemNumber;
				if(selectFileType == itemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		}
	}
</script>
</body>
</html>