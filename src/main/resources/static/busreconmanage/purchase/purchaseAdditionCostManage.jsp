<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" /></span>
            <div class="common-box-line">
                <button id="queryHeadBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
                <button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create"/></button>
                <button id="updBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update"/></button>
                <button id="delBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete"/></button>
                <button id="confirmBtn" class="button-wrap"><i18n:I18n defaultValue="确认" key="i18n_common_button_confirm"/></button>
                <button id="returnBtn" class="button-wrap"><i18n:I18n defaultValue="退回" key=""/></button>
                <button id="sendBtn" class="button-wrap"><i18n:I18n defaultValue="发送" key="i18n_button_send"/></button>
                <button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
            <div class="common-box-line">
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="费用单号" key="i18n_label_additionCost_additionCostNumber"/>：</span>
					<input type="text" id="additionCostNumber" name="additionCostNumber" />
				</div>	
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="费用日期" key="i18n_label_additionCost_costDate"/>：</span>
					<input type="text" id="costDateFrom" name="costDateFrom" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>	
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="到" key="i18n_common_label_to"/>：</span>
					<input type="text" id="costDateTo" name="costDateTo" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="费用单类型" key="i18n_label_additionCost_additionCostType"/>：</span>
					<select id="additionCostType" name="additionCostType">
             					<option value=""><i18n:I18n defaultValue="所有" key="i18n_common_option_all"/></option>
             					<option value="ded"><i18n:I18n defaultValue="采购扣款单" key="i18n_label_additionCost_additionCostType_ded"/></option>
             					<option value="add"><i18n:I18n defaultValue="销售附加费用单" key="i18n_label_additionCost_additionCostType_add"/></option>
	               	</select>
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="费用单状态" key="i18n_label_additionCost_additionCostStatus"/>：</span>
					<select id="additionCostStatus" name="additionCostStatus">
             				<option value=""><i18n:I18n defaultValue="所有" key="i18n_common_option_all"/></option>
             				<option value="0"><i18n:I18n defaultValue="新建" key="i18n_additionCost_additionCostStatus_new"/></option>
        					<option value="1"><i18n:I18n defaultValue="采购方已确认" key="i18n_additionCost_additionCostStatus_purchaseConfirm"/></option>
        					<option value="2"><i18n:I18n defaultValue="销售方已确认" key="i18n_additionCost_additionCostStatus_saleConfirm"/></option>
        					<option value="3"><i18n:I18n defaultValue="已退回" key="i18n_busRecon_select_busReconStatus_reject"/></option>
        					<option value="4"><i18n:I18n defaultValue="已对账" key="i18n_additionCost_additionCostStatus_reconciliation"/></option>
	               	</select>
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="对方ELS号" key="i18n_label_additionCost_toElsAccount"/>：</span>
					<input type="text" id="toElsAccount" name="toElsAccount" />
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="费用单描述" key="i18n_label_additionCost_additionCostDesc"/>：</span>
					<input type="text" id="remark" name="remark" width="100%"/>
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="合计金额" key="i18n_label_additionCost_totalAmount"/>：</span>
					<input type="text" id="totalAmount" name="totalAmount" />
				</div>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="费用单头" key="i18n_additionCost_title_head"/></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="费用单行" key="i18n_additionCost_title_item"/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="费用单行" key="i18n_additionCost_title_item"/></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n defaultValue="费用单文件" key="i18n_additionCost_title_file"/></a></li>
                    </ul>
                    <div id="sheet-project-one" style="padding: 1px;">
                       	<div class="edit-box-wrap">
	                        <button style="margin-left: 5px;" id="itemDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
			            </div>
	                    <div class="grid-100" id="reCreate">
	                        <table id="itemTable"></table>
	                        <div id="itemPage" style="text-align: right;"></div>
	                    </div>
                    </div>
                    <div id="sheet-project-two" style="padding: 1px;">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<div class="file-list-head">
					                   <select class="" id="selectFileType" name="selectFileType" onchange="selectFileTypeChange();" >
						                   <option value="all"><i18n:I18n defaultValue="所有文件" key="i18n_common_select_filetype_all"/></option>
						                   <option value="common"><i18n:I18n defaultValue="公共文件" key="i18n_common_select_filetype_public"/></option>
					                   </select>
					                   <button style="margin-left: 15px;" id="fileDefineBtn" class="button-wrap"><i18n:I18n defaultValue="文件列自定义" key="i18n_common_button_columncustom"/></button>
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
							             &nbsp;
							         </div>
								     </div>
								     <div class="file-display" id="file-display">
								     	<a id="viewerPlaceHolder"></a>
								     </div>
								</div>
						</div>
						</div>
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
	
	var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageHead"/>;
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/queryPurchaseAdditionCostHead",
		method :  "POST",
		autoLoad : false,
		cols : headCols,
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
		        limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
		        totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
		        limit : null,
		        limitList : [10,20]
		    })
		]
	}); 
	
	var itemCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageItem"/>;
	var itemGrid = $("#itemTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/queryPurchaseAdditionItem",
	    method:  "POST",
	    autoLoad : false,
	    cols : itemCols,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    plugins: [
	        $("#itemPage").mmPaginator({
	            style: "plain",
	            totalCountName: "total",
	            page: 1,
	            pageParamName: "currentPage",
	            limitParamName: "pageSize",
	            limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	            totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	            limit:null,
	            limitList: [10,20]
	        })
	    ]
	});
	
	var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageFile"/>;
	var fileGrid = $("#fileTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/queryPurchaseAdditionFile",
	    method : "post",
	    autoLoad : false,
	    cols : fileCols,
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
	
	$(document).ready(function(){
		// 动态加载聊天窗口
		$sob = $('.saying-dialog .option-bar');
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    $("#sheet-project").tabs();
	    var currDate = new Date();
	    
	    var startOrderDate = new Date();
	    var currDateMill = startOrderDate.getTime();
	    startOrderDate.setMonth(startOrderDate.getMonth()+1, 0);//本月最后一日
	    var currMonthMaxDay = startOrderDate.getDate();
	    startOrderDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
	    $("#costDateFrom").val(startOrderDate.format('yyyy-MM-dd'));
	    $("#costDateTo").val(currDate.format("yyyy-MM-dd"));
	    
	    //初始化表头
	    var additionCostNumber = "${param.additionCostNumber}";
	    if("undefined"==typeof(additionCostNumber) || "null"==additionCostNumber){
	    	additionCostNumber="";
		} else {
			$("#additionCostNumber").val(additionCostNumber);
		}
		var additionCostType = "${param.additionCostType}";
		if("undefined"==typeof(additionCostType) || "null"==additionCostType){
			additionCostType="";
		} else {
			$("#additionCostType option[value='"+additionCostType+"']").attr("selected", "selected"); 
		}
		var toElsAccount = "${param.toElsAccount}";
		if("undefined"==typeof(toElsAccount) || "null"==toElsAccount){
			toElsAccount="";
		} else {
			$("#toElsAccount").val(toElsAccount);
		}
		
		var queryParam = {
				elsAccount : elsAccount,
		    	toElsAccount : toElsAccount,
		    	additionCostType : additionCostType,
		    	additionCostNumber : additionCostNumber
	    };
	    headGrid.load(queryParam);
	}
    
	headGrid.on("loadSuccess",function(e, data) {
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
    		headGrid.select(0);//默认选中第一行
			var seled=headGrid.selectedRows();
			if(seled && seled.length) {
				initChat(seled);// 动态加载聊天窗口
				if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
	            $sob.click();
			}
            //初始化聊天控制状态
			loadItem(data.rows[0].elsAccount,data.rows[0].toElsAccount,data.rows[0].additionCostType,data.rows[0].additionCostNumber);//根据头表选中项加载行项目信息
			loadFile(data.rows[0].elsAccount,data.rows[0].toElsAccount,data.rows[0].additionCostType,data.rows[0].additionCostNumber);//根据头表选中项加载文件信息
		} else {//无Head数据则将Item及File表清空
			clearItemtable();
			clearFiletable();
		}
    	
    });
    
    headGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
    	loadItem(item.elsAccount,item.toElsAccount,item.additionCostType,item.additionCostNumber);//根据头表选中项加载行项目信息
		loadFile(item.elsAccount,item.toElsAccount,item.additionCostType,item.additionCostNumber);//根据头表选中项加载文件信息
		// 动态加载聊天窗口
		var hadSelected = headGrid.selectedRows();
		if(hadSelected && hadSelected.length) {
			initChat(hadSelected);
    	}
  	});
    
    fileGrid.on("loadSuccess", function(e, item, rowIndex, colIndex){
    	reGenFileTypeSelect();
  	});
    
    fileGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
  		previewFile(filePath);
  	});
	
	$("#queryHeadBtn").click(function(){
		refreshData();
	});
	
	$("#addBtn").click(function(){
	    parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "purchaseAdditionCostAdd",
	        windowTitle : "<i18n:I18n defaultValue='新建附加费用单' key='i18n_windowTitle_additionCostAdd'/>",
	        iframSrc : "${pageContext.request.contextPath}/busreconmanage/purchase/purchaseAdditionCostAdd.jsp",
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
			var additionCostStatus = headRecord.additionCostStatus;
			var sendStatus = headRecord.sendStatus;
			var person = headRecord.person;//subAccount_name
			var currPerson = elsSubAccount+"_"+userName;
			if((additionCostStatus == "0" && sendStatus == "0") || additionCostStatus == "3"){
				if(person == currPerson && "ded" == headRecord.additionCostType){
					parent.elsDeskTop.defineWin({
				        iconSrc : "icon/icon9.png",
				        windowsId : "purchaseAdditionCostUpd",
				        windowTitle : "<i18n:I18n defaultValue='修改附加费用单' key='i18n_windowTitle_additionCostUpd'/>",
				        iframSrc : "${pageContext.request.contextPath}/busreconmanage/purchase/purchaseAdditionCostUpd.jsp?"
				        		+"elsAccount="+headRecord.elsAccount
				        		+"&toElsAccount="+headRecord.toElsAccount
				        		+"&additionCostType="+headRecord.additionCostType
				        		+"&additionCostNumber="+ headRecord.additionCostNumber,
				        showAdv : true,
				        windowStatus : "maximized",
				        windowMinWidth : 960,
				        windowMinHeight : 700,
				        windowWidth : 960,
				        windowHeight : 700,
				        parentPanel : ".currDesktop"
				    });
				} else {
					alert("<i18n:I18n defaultValue='非制单人或单据为对方单据,禁止修改' key='i18n_alert_canotUpd_notPurchasePerson'/>",2);
				}
			} else {
				alert("<i18n:I18n defaultValue='非新建未发送单据,禁止修改' key='i18n_alert_canotUpd_hasSend'/>",2);
			}
		}
	});
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var additionCostStatus = headRecord.additionCostStatus;
			var sendStatus = headRecord.sendStatus;
			var person = headRecord.person;
			var currPerson = elsSubAccount+"_"+userName;
			var sendStatus = headRecord.sendStatus;
			if((additionCostStatus == "0" && sendStatus == "0") || additionCostStatus == "3"){
				debugger;
				if(person == currPerson && "ded" == headRecord.additionCostType){
					parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
						$.ajax({
							url : "${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/delPurchaseAdditionCost",
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
								alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",1);
							}
						});
					}});
				} else {
					alert("<i18n:I18n defaultValue='非制单人或单据为对方单据,禁止删除' key=''/>",2);
				}
			} else {
				alert("<i18n:I18n defaultValue='非本方新建未发送单据,禁止删除' key=''/>",2);
			}
		}
	});
	
	$("#confirmBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			if(headRecord.additionCostStatus == "1"){
				alert("<i18n:I18n defaultValue='已确认，不能再次确认' key=''/>",2);
				return;
			}
			if(headRecord.additionCostStatus == "3"){
				alert("<i18n:I18n defaultValue='已退回，不能确认' key=''/>",2);
				return;
			}
			var additionCostType = headRecord.additionCostType;
			if("add" == additionCostType){
				parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='费用单确认保存中' key='i18n_label_additionCost_additionCostConfirmAndInSave'/>!");
				$.ajax({
					url :"${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/confirmAdditionCost",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(headRecord),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						var status = data.statusCode;
						if("200" == status){
							alert("<i18n:I18n defaultValue='确认成功' key='i18n_alert_confirm_success'/>",1);
							refreshData();
						} else {
							parent.elsDeskTop.tip.init({type: 'alert',displayType:2,message : data.message});
						}
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='确认失败' key='i18n_alert_confirm_error'/>",3);
					}
				});
			}
		} else {
			alert("<i18n:I18n defaultValue='请选择确认费用单!' key='i18n_res_purchaseBusinessReconciliation_pleaseSelectConfirmAdditionCost'/>",1); 
		}
	});
	
	$("#returnBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];	
			var additionCostType = headRecord.additionCostType;
			if(headRecord.additionCostStatus == "3"){
				alert("<i18n:I18n defaultValue='已退回，不能再次退回' key=''/>",2);
				return;
			}
			if(headRecord.additionCostStatus == "1"){
				alert("<i18n:I18n defaultValue='已确认，不能退回' key=''/>",2);
				return;
			}
			if("add" == additionCostType){
				$.ajax({
					url :"${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/rejectAdditionCost",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(headRecord),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						var status = data.statusCode;
						if("200" == status){
							alert("<i18n:I18n defaultValue='退回成功' key='i18n_alert_reject_success'/>",1);
							refreshData();
						} else {
							alert(data.message,2);
						}
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='退回失败' key='i18n_alert_reject_error'/>",3);
					}
				});
			}
		}
	});
	
	//发送
	$("#sendBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var purchaseAdditionCostHead = selectRows[0];
			var purchaseAdditionCostItem = itemGrid.rows();
		   	var purchaseAdditionCostFile = fileGrid.rows();
		   	
		   	var data = {
		   			operate : "send",
		   			purchaseAdditionCostHead : JSON.stringify(purchaseAdditionCostHead),
		   			purchaseAdditionCostItem : JSON.stringify(purchaseAdditionCostItem),
		   			purchaseAdditionCostFile : JSON.stringify(purchaseAdditionCostFile),
		   	}
		   	var additionCostType = selectRows[0].additionCostType;
			if("ded" == additionCostType){
		   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='费用单发送中!' key='i18n_label_additionCost_AdditionCostIsSent'/>");
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/sendPurchaseAdditionCost",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='发送成功' key='i18n_common_sendsuccess'/>!",1);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='发送失败' key='i18n_common_sendfail'/>!",3);
				}
			});
		}else{
			alert("<i18n:I18n defaultValue='非本方单据，禁止发送!' key=''/>",2);
		} }else {
			alert("<i18n:I18n defaultValue='请选择发送费用单!' key='i18n_res_purchaseBusinessReconciliation_pleaseSelectAdditionCostToSend'/>",2);
		}
		
	});
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageHead&window=iframeApp_purchaseAdditionCostManage",
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
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageItem&window=iframeApp_purchaseAdditionCostManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	$("#fileDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageFile&window=iframeApp_purchaseAdditionCostManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	$("#chatBtn").click(function(){
		//TODO
	});
	
	function refreshData(){
		var additionCostNumber = $("#additionCostNumber").val();
		var costDateFrom = $("#costDateFrom").val();
		var costDateTo = $("#costDateTo").val();
		var additionCostType = $("#additionCostType").val();
		var additionCostStatus = $("#additionCostStatus").val();
		var toElsAccount = $("#toElsAccount").val();
		var remark = $("#remark").val();
		var totalAmount = $("#totalAmount").val();
		
		var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	additionCostType : additionCostType,
	    	additionCostNumber : additionCostNumber,
	    	costDateFrom : costDateFrom,
	    	costDateTo : costDateTo,
	    	additionCostStatus : additionCostStatus,
	    	remark : remark,
	    	totalAmount : totalAmount,
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
		var elsAccount ='<%=session.getAttribute("elsAccount") %>',
	  	  elsSubAccount ='<%=session.getAttribute("elsSubAccount") %>',
	  	  toElsAccount = '',
	  	  toElsSubAccount ='';
	  	  var businessId = '';
	  	  var peopleList = [];
	  	  var costType = "";
		  if(data) {
			  toElsAccount = data[0].toElsAccount;
			  businessId=''+data[0].additionCostNumber;
			  costType = data[0].additionCostType;
			  var obj={};
			  obj.name = data[0].toElsDesc;
			  peopleList.push(obj);
		  }
		  var peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
		  var url = "multiChat.jsp?type=multi&fromElsAccount=" + elsAccount
					+ "&fromElsSubAccount=" + elsSubAccount
					+ "&toElsAccount=" + toElsAccount
					+ "&toElsSubAccount="+toElsSubAccount
					+ "&businessType=additionCost"
					+ "&businessID="+businessId
					+ "&costType="+costType
	                + "&list="+encodeURI(peopleListString)
					+ "&t="+new Date().getTime();
		   
		   $(".testIframe").attr("src","${pageContext.request.contextPath}/"+ url);
		   //滚动条美化niceScroll
		   //$(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"10px"});
	}

	function loadItem(elsAccount,toElsAccount,additionCostType,additionCostNumber) {
		var queryParam = {
		    	elsAccount : elsAccount,
		    	toElsAccount : toElsAccount,
		    	additionCostType : additionCostType,
		    	additionCostNumber : additionCostNumber
		    };
		$.extend(itemGrid.opts.params,queryParam);
	    //处理列 
		itemGrid.load();
	}
	
	function loadFile(elsAccount,toElsAccount,additionCostType,additionCostNumber) {
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	additionCostType : additionCostType,
	    	additionCostNumber : additionCostNumber
	    };
		$.extend(fileGrid.opts.params,queryParam);
	    fileGrid.load();
	}
	
	function clearItemtable(){
		if(itemGrid.rowsLength() > 0){
			for(var i=itemGrid.rowsLength();i-1>=0;i--){
				itemGrid.removeRow(i-1);
			}
		}
	}
	
	function clearFiletable(){
		if(fileGrid.rowsLength() > 0){
			for(var i=fileGrid.rowsLength();i-1>=0;i--){
				fileGrid.removeRow(i-1);
			}
		}
	}
	
	function reGenFileTypeSelect(){
		var itemRowSize = itemGrid.rowsLength();
		var fileTypeSelect = $("#selectFileType");
		fileTypeSelect.empty();
		$("<option value='all'><i18n:I18n defaultValue="所有文件" key="i18n_common_select_filetype_all"/></option>").appendTo(fileTypeSelect);
		$("<option value='common'><i18n:I18n defaultValue="公共文件" key="i18n_common_select_filetype_public"/></option>").appendTo(fileTypeSelect);
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