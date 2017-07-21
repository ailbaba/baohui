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
                <button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create"/> </button>
                <button id="updBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update"/></button>
                <button id="delBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete"/></button>
                <button id="receiveBtn" class="button-wrap"><i18n:I18n defaultValue="确认收货" key="i18n_common_message_confirmreceipt"/></button>
                <%-- <button id="confirmBtn" class="button-wrap"><i18n:I18n defaultValue="确认" key="i18n_common_button_confirm"/></button>
                <button id="returnBtn" class="button-wrap"><i18n:I18n defaultValue="退回" key="i18n_busRecon_select_busReconStatus_reject"/></button> --%>
                <button id="sendBtn" class="button-wrap"><i18n:I18n defaultValue="发送" key="i18n_button_send"/></button>
                <%-- <button id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button> --%>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
            <div class="common-box-line">
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="采购凭证号" key="i18n_sampleManage_purchaseSampleNumber"/>:</span>
					<input type="text" id="purchaseSampleNumber" name="purchaseSampleNumber" />
				</div>	
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="创建日期" key="i18n_sampleManage_createDate"/>:</span>
					<input type="text" id="createDateFrom" name="createDateFrom" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>	
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="到" key="i18n_common_label_to"/>:</span>
					<input type="text" id="createDateTo" name="createDateTo" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="对方ELS号" key="i18n_label_additionCost_toElsAccount"/>:</span>
					<input type="text" id="toElsAccount" name="toElsAccount" />
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="对方ELS名称" key="i18n_label_additionCost_toElsAccountName"/>:</span>
					<input type="text" id="toCompanyShortName" name="toCompanyShortName" width="100%"/>
				</div>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="样品单头" key="i18n_sampleManage_title_sampleHead"/></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="样品单明细" key="i18n_sampleManage_title_sampleDetail"/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="样品单行" key="i18n_sampleManage_title_sampleItem"/></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n defaultValue="样品单文件" key="i18n_sampleManage_title_sampleFile"/></a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container nest-table">
                        	<div class="edit-box-wrap" style="padding-top: 5px;">
		                        <%-- <button id="itemDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button> --%>
		                        <button id="qualified" class="button-wrap"><i18n:I18n defaultValue="样品合格" key="i18n_sampleManage_button_qualified"/></button>
		                        <button id="unqualified" class="button-wrap"><i18n:I18n defaultValue="样品不合格" key="i18n_sampleManage_button_unqualified"/></button>
				            </div>
		                    <div class="grid-100" id="reCreate">
		                        <table id="itemTable"></table>
		                        <div id="itemPage" style="text-align: right;"></div>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two">
	                  <div class="box-wrap pos-relative bg-common">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<div class="file-list-head">
					                   <select class="" id="selectFileType" name="selectFileType" onchange="selectFileTypeChange();" >
						                   <option value="all"><i18n:I18n defaultValue="所有" key="i18n_common_option_all"/></option>
						                   <option value="common"><i18n:I18n defaultValue="公共" key="i18n_common_option_common"/></option>
					                   </select>
					                   <%-- <button id="fileDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button> --%>
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
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	var $sob;
		
	//var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageHead"/>;
	var renderHeadStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "新建";
		} else if("1"==val){
			return "已发送";
		} else if("2"==val){
			return "已收货";
		} else {
			return "已结束";
		}
	};
	var headCols = [
			{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
			{ title:"对方ELS号", name:"toElsAccount", width:100, align:"center"},
			{ title:"对方ELS名称", name:"toCompanyShortName", width:100, align:"center"},
			{ title:"采购凭证号", name:"purchaseSampleNumber", width:100, align:"center"},
			{ title:"样品订单名", name:"sampleOrderName", width:100, align:"center"},
			{ title:"样品订单描述", name:"sampleOrderDesc", width:100, align:"center"},
			{ title:"样品订单状态", name:"orderStatus" , width:100, align:"center",renderer:renderHeadStatus},
	    ];
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/queryPurchaseSampleHead",
		method :  "POST",
		autoLoad : false,
		cols : headCols,
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
        checkCol : true,
        indexCol : false,
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
		        limitList : [10,20]
		    })
		]
	}); 
	
	//var itemCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageItem"/>;
	var renderItemStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "新建";
		} else if("1"==val){
			return "已发送";
		} else if("2"==val){
			return "已收货";
		} else {
			return "已结束";
		}
	};
	var renderItemResult = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "审核合格";
		} else if("1"==val){
			return "审核不合格";
		} else {
			return "未审核";
		}
	};
	var itemCols = [
			{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
			{ title:"对方ELS号", name:"toElsAccount", width:100, align:"center"},
			{ title:"采购凭证号", name:"purchaseSampleNumber", width:100, align:"center"},
			{ title:"物料编号", name:"materialNumber", width:100, align:"center"},
			{ title:"物料描述", name:"materialDesc", width:100, align:"center"},
			{ title:"物料行编号", name:"materialLineNumber", width:100, align:"center"},
			{ title:"物料属性1", name:"property1", width:100, align:"center"},
			{ title:"物料属性2", name:"property2", width:100, align:"center"},
			{ title:"物料属性3", name:"property3", width:100, align:"center"},
			{ title:"物料属性4", name:"property4", width:100, align:"center"},
			{ title:"物料属性5", name:"property5", width:100, align:"center"},
			{ title:"样品数量", name:"quantity", width:100, align:"center"},
			{ title:"基本数量单位", name:"unitQuantity", width:100, align:"center"},
			{ title:"样品订单状态", name:"orderStatus", width:100, align:"center",renderer:renderItemStatus},
			{ title:"样品检验结果", name:"checkResult", width:100, align:"center",renderer:renderItemResult},
			{ title:'备注', name:'remark',width:150, align:'center'}
		];
	
	var itemGrid = $("#itemTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/queryPurchaseSampleItem",
	    method:  "POST",
	    autoLoad : false,
	    cols : itemCols,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
        checkCol : true,
        indexCol : false,
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
	
	//var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageFile"/>;
	var fileCols = [
			{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
			{ title:"对方ELS号", name:"toElsAccount", width:100, align:"center"},
			{ title:"采购凭证号", name:"purchaseSampleNumber", width:100, align:"center"},
			{ title:"表单编号", name:"formId", width:100, align:"center"},
			//{ title:"物料编号", name:"materialNumber", width:100, align:"center"},
			//{ title:"物料描述", name:"materialDesc", width:100, align:"center"},
			//{ title:"物料行编号", name:"materialLineNumber", width:100, align:"center"},
			{ title:"文件名称", name:"fileName", width:100, align:"center"},
			{ title:"文件大小", name:"fbk1", width:100, align:"center"},
			{ title:"文件路径", name:"filePath", width:200, align:"center"},
			{ title:"文件状态", name:"fileStatus", width:100, align:"center"},
	    ];
	var fileGrid = $("#fileTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/queryPurchaseSampleFile",
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
	    $("#createDateFrom").val(startOrderDate.format('yyyy-MM-dd'));
	    $("#createDateTo").val(currDate.format("yyyy-MM-dd"));
	    
	    var createDateFrom = $("#createDateFrom").val();
		var createDateTo = $("#createDateTo").val();
	  	//初始化表头
	    var purchaseSampleNumber = "${param.purchaseSampleNumber}";
	    if("undefined"==typeof(purchaseSampleNumber) || "null"==purchaseSampleNumber){
	    	purchaseSampleNumber="";
		} else {
			$("#purchaseSampleNumber").val(purchaseSampleNumber);
			createDateFrom = "";//请求页面时有传条件则忽略costDateFrom,costDateTo按请求条件查找
			createDateTo = "";
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
	    	purchaseSampleNumber : purchaseSampleNumber,
	    	createDateFrom : createDateFrom,
	    	createDateTo : createDateTo
	    };
		$.extend(headGrid.opts.params,queryParam);
	    headGrid.load();
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
            var record = data.rows[0];
			loadItem(record.elsAccount,record.toElsAccount,record.purchaseSampleNumber);//根据头表选中项加载行项目信息
			loadFile(record.elsAccount,record.toElsAccount,record.purchaseSampleNumber);//根据头表选中项加载文件信息
		} else {//无Head数据则将Item及File表清空
			clearItemtable();
			clearFiletable();
		}
    	
    });
    
     headGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
    	loadItem(item.elsAccount,item.toElsAccount,item.purchaseSampleNumber);//根据头表选中项加载行项目信息
		loadFile(item.elsAccount,item.toElsAccount,item.purchaseSampleNumber);//根据头表选中项加载文件信息
		// 动态加载聊天窗口
		var hadSelected = headGrid.selectedRows();
		if(hadSelected && hadSelected.length){
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
	
	// 新增  @author jiangzhidong @date 20160317
	$("#addBtn").click(function(){
	    parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "purchaseSampleManageAdd",
	        windowTitle : "<i18n:I18n defaultValue='新建样品单' key='i18n_windowTitle_purchaseSampleManageAdd'/>",
	        iframSrc : "${pageContext.request.contextPath}/samplemanage/purchase/purchaseSampleManageAdd.jsp",
	        showAdv : true,
	        windowStatus : "maximized",
	        windowMinWidth : 960,
	        windowMinHeight : 700,
	        windowWidth : 960,
	        windowHeight : 700,
	        parentPanel : ".currDesktop"
	    });
	});
	
	// 修改  @author jiangzhidong @date 20160317
	$("#updBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var purchaseSampleNumber = headRecord.purchaseSampleNumber;
			var toElsAccount = headRecord.toElsAccount;
			parent.elsDeskTop.defineWin({
		        iconSrc : "icon/icon9.png",
		        windowsId : "purchaseSampleManageUpd",
		        windowTitle : "<i18n:I18n defaultValue='修改样品单' key='i18n_windowTitle_purchaseSampleManageUpd'/>",
		        iframSrc : "${pageContext.request.contextPath}/samplemanage/purchase/purchaseSampleManageUpd.jsp?"
		        		+"purchaseSampleNumber="+purchaseSampleNumber
		        		+"&toElsAccount="+toElsAccount,
		        showAdv : true,
		        windowStatus : "maximized",
		        windowMinWidth : 960,
		        windowMinHeight : 700,
		        windowWidth : 960,
		        windowHeight : 700,
		        parentPanel : ".currDesktop"
		    });
		}
	});
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
				var headRecord = selectRows[0];
				var purchaseSampleNumber = headRecord.purchaseSampleNumber;
				var orderStatus = headRecord.orderStatus;
				var person = headRecord.createUser;
				var currPerson = elsSubAccount+"_"+userName;
				if(orderStatus == "0" ){
					if(person == currPerson){
						$.ajax({
							url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/delPurchaseSample",
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
					} else {
						alert("<i18n:I18n defaultValue='非创建人,禁止删除' key='i18n_alert_canotUpd_notCreator'/>",2);
					}
				} else {
					alert("<i18n:I18n defaultValue='已发送,禁止删除' key='i18n_alert_canotDel_hasSend'/>",2);
				}
			}});
		}
	});
	
	$("#receiveBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var purchaseSampleNumber = headRecord.purchaseSampleNumber;
			var orderStatus = headRecord.orderStatus;
			var person = headRecord.createUser;
			var currPerson = elsSubAccount+"_"+userName;
			if(orderStatus == "0" ){
				alert("<i18n:I18n defaultValue='样品单尚未发送' key='i18n_alert_sampleNotSend'/>",2);
			} else if(orderStatus == "1" ){
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/confirmReceiveSample",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(headRecord),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='确认收货成功' key='i18n_alert_confirmReceiveSuccess'/>",1);
						refreshData();
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='确认收货失败' key='i18n_alert_confirmReceiveFail'/>",1);
					}
				});
			} else {
				alert("<i18n:I18n defaultValue='已确认收货' key='i18n_alert_hasConfirmReceived'/>",2);
			}
		}
	});
	
	
	
	$("#qualified").click(function(){
		var selectRows = itemGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var firstItem = selectRows[0];
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/PurchaseSampleService/qualifiedPurchaseSample",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(selectRows),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					var status = data.statusCode;
					if("200" == status){
						alert("<i18n:I18n defaultValue='合格认证成功' key='i18n_alert_confirmQualifiedSuccess'/>",1);
						loadItem(firstItem.elsAccount,firstItem.toElsAccount,firstItem.purchaseSampleNumber);
					} else {
						alert(data.message,2);
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='合格认证失败' key='i18n_alert_confirmQualifiedFail'/>",3);
				}
			});
		}
	});
	
	$("#unqualified").click(function(){
		var selectRows = itemGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var firstItem = selectRows[0];
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/PurchaseSampleService/unqualifiedPurchaseSample",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(selectRows),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					var status = data.statusCode;
					if("200" == status){
						alert("<i18n:I18n defaultValue='不合格认证成功' key='i18n_alert_confirmUnqualifiedSuccess'/>",1);
						loadItem(firstItem.elsAccount,firstItem.toElsAccount,firstItem.purchaseSampleNumber);
					} else {
						alert(data.message,2);
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='不合格认证失败' key='i18n_alert_confirmUnqualifiedFail'/>",3);
				}
			});
		}
	});
	
	//发送
	$("#sendBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var purchaseSampleHead = selectRows[0];
			var purchaseSampleItem = itemGrid.rowsLength()==0?[]: itemGrid.rows();
		   	var purchaseSampleFile = fileGrid.rowsLength()==0?[]: fileGrid.rows();
		   	
		   	var data = {
		   			operate : "send",
		   			purchaseSampleHead : JSON.stringify(purchaseSampleHead),
		   			purchaseSampleItem : JSON.stringify(purchaseSampleItem),
		   			purchaseSampleFile : JSON.stringify(purchaseSampleFile),
		   	}
		   	
		   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='发送中' key='i18n_common_alert_sending'/>");
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/PurchaseSampleService/sendPurchaseSample",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='发送成功' key='i18n_common_sendsuccess'/>",1);
					refreshData();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='发送失败' key='i18n_common_sendfail'/>",3);
				}
			});
		}
	});
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageHead&window=iframeApp_saleAdditionCostManage",
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
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageItem&window=iframeApp_saleAdditionCostManage",
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
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageFile&window=iframeApp_saleAdditionCostManage",
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
		var purchaseSampleNumber = $("#purchaseSampleNumber").val();
		var createDateFrom = $("#createDateFrom").val();
		var createDateTo = $("#createDateTo").val();
		var toElsAccount = $("#toElsAccount").val();
		
		var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	purchaseSampleNumber : purchaseSampleNumber,
	    	createDateFrom : createDateFrom,
	    	createDateTo : createDateTo,
	    };
		$.extend(headGrid.opts.params,queryParam);
		headGrid.load();
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
						alert(message,2);
					}
				},
				error : function(data) {
					alert(data.message,3);
				}
			});
    	} else {
    		alert("<i18n:I18n defaultValue='不支持的在线预览文档类型' key='i18n_alert_fileType_notSupport'/>",2);
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
		 businessId=''+data[0].purchaseSampleNumber;
		 //costType = data[0].additionCostType;
		 var obj={};
		 obj.name = data[0].toCompanyShortName;
		 peopleList.push(obj);
		}
		var peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
		var url = "multiChat.jsp?type=multi&fromElsAccount=" + elsAccount
			+ "&fromElsSubAccount=" + elsSubAccount
			+ "&toElsAccount=" + toElsAccount
			+ "&toElsSubAccount="+toElsSubAccount
			+ "&businessType=sampleOrder"
			+ "&businessID="+businessId
			+ "&costType="+costType
		    + "&list="+encodeURI(peopleListString)
			+ "&t="+new Date().getTime();
		 
		 $(".testIframe").attr("src","${pageContext.request.contextPath}/"+ url);
		 //滚动条美化niceScroll
		 $(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
	}

	function loadItem(elsAccount,toElsAccount,purchaseSampleNumber) {
		var queryParam = {
		    	elsAccount : elsAccount,
		    	toElsAccount : toElsAccount,
		    	purchaseSampleNumber : purchaseSampleNumber,
		    };
		$.extend(itemGrid.opts.params,queryParam);
	    //处理列 
		itemGrid.load();
	}
	
	function loadFile(elsAccount,toElsAccount,purchaseSampleNumber) {
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	purchaseSampleNumber : purchaseSampleNumber
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
		$("<option value='all'><i18n:I18n defaultValue='所有' key='i18n_common_option_all'/></option>").appendTo(fileTypeSelect);
		$("<option value='common'><i18n:I18n defaultValue='公共' key='i18n_common_option_common'/></option>").appendTo(fileTypeSelect);
		for(var i=0;i<itemRowSize;i++){
			var materialLineNumber = itemGrid.row(i).materialLineNumber;
			$("<option value='"+materialLineNumber+"'>"+materialLineNumber+"</option>").appendTo(fileTypeSelect);//文件下拉列表添加行项目选项
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
				var materialLineNumber = fileGrid.row(index).materialLineNumber;
				if("" == materialLineNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		} else {//显示指定行项目下的文件
			$("#fileTable tr").each(function(index,domElement){
				var materialLineNumber = fileGrid.row(index).materialLineNumber;
				if(selectFileType == materialLineNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		}
	}
	
	//新增回调
	window.purchQuery = function() {
		refreshData();
	}
</script>
</body>
</html>