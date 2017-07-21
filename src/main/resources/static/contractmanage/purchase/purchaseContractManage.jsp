<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String toElsAccount = request.getParameter("toElsAccount");
String purchaseContractNumber = request.getParameter("purchaseContractNumber");
%>
<base:supplierAuth elsAccount="${param['toElsAccount'] }" authCode="contract" toElsAccount="${elsAccount }"></base:supplierAuth>
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
                <button id="updBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update"/></button>
                <button id="delBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete"/></button>
                <base:auditConfig elsAccount="${elsAccount}" businessType="contract">
					<button id="entryBtn" class="button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批" /></button>
					<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
					<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
				</base:auditConfig>
                <button id="archiveBtn" class="button-wrap"><i18n:I18n defaultValue="归档" key="i18n_common_button_pigeonhole"/></button>
                <button id="sendBtn" class="button-wrap"><i18n:I18n defaultValue="发送" key="i18n_button_send"/></button>
                <button id="endBtn" class="button-wrap"><i18n:I18n defaultValue="结束" key="i18n_common_button_end"/></button>
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
                <button class="button-wrap" id="generatePdfBtn"><i18n:I18n key="i18n_common_title_generatePDF" defaultValue="生成PDF" /></button>
                <button class="button-wrap" id="previewPdfBtn"><i18n:I18n key="i18n_common_title_PreviewPDF" defaultValue="预览PDF" /></button>
                <button class="button-wrap" id="downPdfBtn"><i18n:I18n key="i18n_common_title_DownloadPDF" defaultValue="下载PDF" /></button>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
            <div class="common-box-line">
				 <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="销售方ELS" key="i18n_materialRelation_title_saleElsAccount"/>:<input type="text" id="toElsAccount" />
				</div>
                <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="合同编码" key="i18n_common_title_contractcode"/>:<input type="text" id="contractNumber" />
				</div>
                <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="合同名称" key="i18n_common_title_contracName"/>:<input type="text" id="contractDesc" />
				</div>
                <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="合同类型编码" key="i18n_common_title_contracttypecode"/>:<input type="text" id="contractType" />
				</div>
                <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="业务类别" key="i18n_contractTemplate_businessType"/>:
                	<select id="businessType">
                		<option value=""><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></option>
                		<option value="0"><i18n:I18n defaultValue="机械" key=""/></option>
                		<option value="1"><i18n:I18n defaultValue="电商" key=""/></option>
                		<option value="2"><i18n:I18n defaultValue="农业" key=""/></option>
                	</select>
				</div>
                <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="采购方负责人" key="i18n_common_title_responserofpurchase"/>:<input type="text" id="purchasePerson" />
				</div>
				<div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="销售方负责人" key="i18n_common_title_responserofsupplier"/>:<input type="text" id="salePerson" />
				</div>
                <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="合同状态" key="i18n_common_title_contractstatus"/>:
                	<select id="contractStatus">
                		<option value=""><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></option>
                		<option value="0"><i18n:I18n defaultValue="新建" key="i18n_common_button_create"/></option>
                		<option value="1"><i18n:I18n defaultValue="提交审批" key="i18n_approval_report"/></option>
                		<option value="2"><i18n:I18n defaultValue="采购方已确认" key="i18n_additionCost_additionCostStatus_purchaseConfirm"/></option>
                		<option value="3"><i18n:I18n defaultValue="销售方已确认" key="i18n_additionCost_additionCostStatus_saleConfirm"/></option>
                		<option value="4"><i18n:I18n defaultValue="已归档" key="i18n_additionCost_additionCostStatus_pigeonholed"/></option>
                		<option value="5"><i18n:I18n defaultValue="已完结" key="i18n_additionCost_additionCostStatus_end"/></option>
                	</select>
				</div>
                <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="发送状态" key="i18n_enquiry_title_sendstatus"/>:
                	<select id="sendStatus">
                		<option value=""><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></option>
                		<option value="0"><i18n:I18n defaultValue="未发送" key="i18n_common_select_sendstatus_notsent"/></option>
                		<option value="1"><i18n:I18n defaultValue="已发送" key="i18n_common_select_sendstatus_sent"/></option>
                		<option value="2"><i18n:I18n defaultValue="新接收" key="i18n_common_select_sendstatus_newReception"/></option>
                	</select>
				</div>
                <div class="dis-in-b input-and-tip">
                	<i18n:I18n defaultValue="审批状态" key="i18n_common_auditstatus"/>:
                	<select id="auditStatus">
                		<option value=""><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></option>
                		<option value="0"><i18n:I18n defaultValue="审批通过" key="i18n_enquiry_select_approveStatus_pass"/></option>
                		<option value="1"><i18n:I18n defaultValue="未审批" key="i18n_enquiry_select_enquirystatus_approveNo"/></option>
                		<option value="2"><i18n:I18n defaultValue="审批中" key="i18n_enquiry_select_enquirystatus_approveproceed"/></option>
                		<option value="3"><i18n:I18n defaultValue="审批拒绝" key="i18n_enquiry_select_enquirystatus_approveRefuse"/></option>
                	</select>
				</div>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="采购合同头信息" key="i18n_common_title_purchaseContractHeadInfo"/></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="采购合同详细信息" key="i18n_common_title_purchaseContractDetailInfo"/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="合同条款信息" key="i18n_common_title_contractClauseInfo"/></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n defaultValue="合同物料信息" key="i18n_common_title_contractMaterialInfo"/></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n defaultValue="合同附件" key="i18n_common_title_contractFile"/></a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="reCreate">
		                        <table id="clauseTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="receiptDiv">
		                        <table id="materialTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-three">
	                  <div class="box-wrap pos-relative bg-common">
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
    <div id="dialog2" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_selectStrategy" defaultValue="新选择审批策略" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_audit_lable_stretegy" defaultValue="审批策略" />：</span> 
							<select id="stretegySelctor">
							</select>
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	var elsAccount="${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	var purchaseContractNumber = "<%=purchaseContractNumber%>";
	var toElsAccount = "<%=toElsAccount%>";
	var flowCode = "";
	if (purchaseContractNumber == "null") {
		purchaseContractNumber = "";
		
	}
	
	//表格渲染
	
  	//业务类型
    var showBusinessTypeRenderer = function (val,item,index){
    	//0:业务类型0  1:业务类型1 2:业务类型2
    	if (val == "0") return '<i18n:I18n key="" defaultValue="机械" />'
    	else if(val == "1") return '<i18n:I18n key="" defaultValue="电商" />'
    	else return '<i18n:I18n key="" defaultValue="农业" />'
    };
    
  	//合同状态
    var showContractStatusRenderer = function (val,item,index){
  		//0:新建 1:提交审批 2:采购方已确认 3:销售方已确认 4:已归档 5:已完结
    	if (val == "0") return '<i18n:I18n key="i18n_common_button_create" defaultValue="新建" />'
    	else if(val == "1") return '<i18n:I18n key="i18n_approval_report" defaultValue="提交审批" />'
    	else if(val == "2") return '<i18n:I18n key="i18n_additionCost_additionCostStatus_purchaseConfirm" defaultValue="采购方已确认" />'
    	else if(val == "3") return '<i18n:I18n key="i18n_additionCost_additionCostStatus_saleConfirm" defaultValue="销售方已确认" />'
    	else if(val == "4") return '<i18n:I18n key="i18n_additionCost_additionCostStatus_pigeonholed" defaultValue="已归档" />'
    	else return '<i18n:I18n key="i18n_additionCost_additionCostStatus_end" defaultValue="已完结" />'
    };
    
  	//发送状态
    var showSendStatusRenderer = function (val,item,index){
  		//0:未发送 1:已发送 2:新接收
    	if (val == "0") return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />'
    	else if(val == "1") return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />'
    	else return '<i18n:I18n key="i18n_common_select_sendstatus_newReception" defaultValue="新接收" />'
    };
    
  	//审批状态
    var showAuditStatusRenderer = function (val,item,index){
  		//0:审批通过 1:未审批 2:审批中 3:审批拒绝
    	if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" />'
    	else if(val == "1") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />'
    	else if(val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />'
    	else return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />'
    };
	
	//采购合同头表格
	var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractHeadManage"/>;
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractHead",
		method :  "POST",
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
		        limitList : [10,20]
		    })
		]
	});
	
	var clauseCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractClauseManage"/>;
	var clauseGrid = $("#clauseTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractClause",
	    method:  "POST",
	    cols : clauseCols,
	    autoLoad : false,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    checkCol: true,
	    multiSelect: true,
	});
	
	var materialCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractMaterialManage"/>;
	var materialGrid = $('#materialTable').mmGrid({
	    cols : materialCols,
	    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractMaterial",
	    method : 'post',
	    root : "rows",
	    autoLoad : false,
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
	    checkCol : true,
	    indexCol : false
	});
	
	var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractFileManage"/>;
	var fileGrid = $("#fileTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractFile",
	    method : "post",
	    cols : fileCols,
	    autoLoad : false,
	    root : "rows",
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    fullWidthRows :true,
	    indexCol : false,
	});
	
	var $sob;
	$(document).ready(function(){
		$sob = $('.saying-dialog .option-bar');
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    $("#sheet-project").tabs();
	    refreshData();
	    
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
			var record = data.rows[0];
            //根据头表选中项加载对应行,文件等信息
			loadClause(record.elsAccount,record.contractNumber);
			loadFile(record.elsAccount,record.contractNumber);
			loadMaterial(record.elsAccount,record.contractNumber);
		}else{
			clearChildTables();
		}
    });
    
 	// 加载明细项
    headGrid.on("cellSelected",function(e, item, rowIndex, colIndex) {
    	loadClause(item.elsAccount,item.contractNumber);
		loadFile(item.elsAccount,item.contractNumber);
		loadMaterial(item.elsAccount,item.contractNumber);
    	// 动态加载聊天窗口
		var hadSelected = headGrid.selectedRows();
		if(hadSelected && hadSelected.length) {
			initChat(hadSelected);
    	}
		
    });
 	
    fileGrid.on("loadSuccess", function(e, data){
    	reGenFileTypeSelect();
  	});
    
    fileGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
  		var filePath = item.contractFilePath;
  		previewFile(filePath);
  	});
	    
    $("#queryHeadBtn").click(function(){
		refreshData();
	});
	
	$("#addBtn").click(function(){
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "purchaseContractAdd",
	        windowTitle : "<i18n:I18n defaultValue='新建采购合同' key=''/>",
	        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/purchaseContractAdd.jsp",
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
			var contractStatus = headRecord.contractStatus;
			var sendStatus = headRecord.sendStatus;
			var purchasePerson = headRecord.purchasePerson;//subAccount_name
			var currPerson = elsSubAccount+"_"+userName;
			if((contractStatus == "0" || contractStatus == "2")
					&& sendStatus != "1"
					&& purchasePerson.indexOf(currPerson)>=0 ){
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "purchaseContractUpd",
			        windowTitle : "<i18n:I18n defaultValue='修改采购合同' key=''/>",
			        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/purchaseContractUpd.jsp?"
			        		+"elsAccount="+headRecord.elsAccount
			        		+"&contractNumber="+ headRecord.contractNumber,
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
			} else {
				alert("<i18n:I18n defaultValue='非负责人或已确认/归档/完结或已发送采购合同禁止再修改' key=''/>",2);
			}
		} else {
			alert("<i18n:I18n defaultValue='请选择修改采购合同' key=''/>",2); 
		}
	});
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var currPerson = elsSubAccount+"_"+userName;
			var contractStatus = headRecord.contractStatus;
			var sendStatus = headRecord.sendStatus;
			var purchasePerson = headRecord.purchasePerson;//subAccount_name
			if((contractStatus == "0" && "0" == sendStatus)
					&& purchasePerson.indexOf(currPerson)>=0){
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/ContractManageService/delPurchaseContract",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(headRecord),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
							
							var selectedIndexes = headGrid.selectedRowsIndex();
							headGrid.removeRow(selectedIndexes);
							
							clearChildTables();
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除失败' key='i18n_delivery_deletefail'/>",3);
						}
					});
				}});
			} else {
				alert("<i18n:I18n defaultValue='非负责人或已发送采购合同禁止删除' key=''/>",2);

			}
		} else {
			alert("<i18n:I18n defaultValue='请选择删除采购合同' key=''/>",2);
		}
	});
	
	$("#archiveBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var currPerson = elsSubAccount+"_"+userName;
			var contractStatus = headRecord.contractStatus;
			var sendStatus = headRecord.sendStatus;
			var purchasePerson = headRecord.purchasePerson;//subAccount_name
			if(contractStatus == "3" && purchasePerson.indexOf(currPerson)>=0){
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="是否确认归档" />',closeEvent:function(){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/ContractManageService/archivePurchaseContract",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(headRecord),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='归档成功' key=''/>",1);
							refreshData();
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='归档失败' key=''/>",3);
						}
					});
				}});
			} else {
				alert("<i18n:I18n defaultValue='非负责人或销售未确认采购合同禁止归档' key=''/>",2);

			}
		} else {
			alert("<i18n:I18n defaultValue='请选择归档采购合同' key=''/>",2);
		}
	});
	
	$("#endBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var currPerson = elsSubAccount+"_"+userName;
			var contractStatus = headRecord.contractStatus;
			var sendStatus = headRecord.sendStatus;
			var purchasePerson = headRecord.purchasePerson;//subAccount_name
			if(contractStatus == "4" && purchasePerson.indexOf(currPerson)>=0){
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="是否确认结束" />',closeEvent:function(){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/ContractManageService/endPurchaseContract",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(headRecord),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='结束成功' key=''/>",1);
							refreshData();
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='结束失败' key=''/>",3);
						}
					});
				}});
			} else {
				alert("<i18n:I18n defaultValue='非负责人或未归档采购合同禁止结束' key=''/>",2);

			}
		} else {
			alert("<i18n:I18n defaultValue='请选择结束采购合同' key=''/>",2);
		}
	});
	
	//发送
	$("#sendBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var currPerson = elsSubAccount+"_"+userName;
			var contractStatus = headRecord.contractStatus;
			var auditStatus = headRecord.auditStatus;
			var sendStatus = headRecord.sendStatus;
			var purchasePerson = headRecord.purchasePerson;//subAccount_name
			if((contractStatus == "0" || contractStatus == "1" || contractStatus == "2")
					&& sendStatus != "1"
					&& auditStatus == "0"
					&& purchasePerson.indexOf(currPerson)>=0){
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="是否确认发送" />',closeEvent:function(){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/ContractManageService/sendPurchaseContract",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(headRecord),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='发送成功' key=''/>",1);
							refreshData();
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='发送失败' key=''/>",3);
						}
					});
				}});
			} else {
				alert("<i18n:I18n defaultValue='非负责人或销售已确认/已归档/已完结或已发送采购合同或未审批通过禁止再发送' key=''/>",2);

			}
		} else {
			alert("<i18n:I18n defaultValue='请选择发送采购合同' key=''/>",2);
		}
	});
	
	//生成PDF
	$("#generatePdfBtn").click(function(){
		 var head = headGrid.selectedRows();
		 if(head.length<=0){
			 alert("<i18n:I18n key='i18n_alert_must_select_oneItem' defaultValue='必须选择一行！' />",2);
			 return;
		 }
		 parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认生成PDF？" />',closeEvent:function(){
			     parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_title_generatingPDF" defaultValue="生成PDF中" />');
			     var param = head[0];
			     var headRowIndex = headGrid.selectedRowsIndex()[0];
		 		 $.ajax({
		 			url : '${pageContext.request.contextPath}/rest/ContractManageService/generalContractPdf',
		 			type : 'POST',
		 			contentType : "application/json",
		 			data : JSON.stringify(param),
		 			dataType : "json",
		 			success : function(data) {
		 				if("200"==data.statusCode){
			 				alert('<i18n:I18n key="i18n_common_title_generatePDFsuccess" defaultValue="生成PDF成功!" />',1);
			 				headGrid.updateRow(data,headRowIndex);
		 				} else {
		 					alert(data.message);
		 				}
		 			},
		 			error : function(data) {
		 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="生成PDF失败!" />',3);
		 			},complete : function(data) {
		    			parent.elsDeskTop.hideLoading();
		    		}
		 		 });
		 }});
	});
		
	//预览PDF
	$("#previewPdfBtn").click(function(){
		 var head = headGrid.selectedRows();
		 if(head.length<=0){
			 alert("<i18n:I18n key='i18n_alert_must_select_oneItem' defaultValue='必须选择一行！' />",2);
			 return;
		 }
		 var param=head[0];
		 var filePath = param.fbk1;
		 if("undefined" != filePath && "" != filePath){
			 window.open("${pageContext.request.contextPath}/contractmanage/purchase/previewPdf.jsp?filePath="+filePath);
			 //window.location.href = "${pageContext.request.contextPath}/contractmanage/purchase/previewPdf.jsp?filePath="+filePath;
		 } else {
			 alert("<i18n:I18n key='i18n_common_title_PDF_contract_not_exist' defaultValue='PDF合同不存在' />",2);
		 }
	});
		
	//下载PDF
	$("#downPdfBtn").click(function(){
		 var head = headGrid.selectedRows();
		 if(head.length<=0){
			 alert("<i18n:I18n key='i18n_alert_must_select_oneItem' defaultValue='必须选择一行！' />",2);
			 return;
		 }
		 var param=head[0];
		 var filePath = param.fbk1;
		 if("undefined" != filePath && "" != filePath){
			 window.location.href = "${pageContext.request.contextPath}/servlet/downloadServlet?filePath="+filePath;
		 } else {
			 alert("<i18n:I18n key='i18n_common_title_PDF_contract_not_exist' defaultValue='PDF合同不存在' />",2);
		 }
	});
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseContractHeadManage&window=iframeApp_purchaseContractManage",
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
		var contractNumber = $("#contractNumber").val();
		var toElsAccount = $("#toElsAccount").val();
		var contractDesc = $("#contractDesc").val();
		var contractType = $("#contractType").val();
		var businessType = $("#businessType").val();
		var purchasePerson = $("#purchasePerson").val();
		var salePerson = $("#salePerson").val();
		var contractStatus = $("#contractStatus").val();
		var sendStatus = $("#sendStatus").val();
		var auditStatus = $("#auditStatus").val();
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	contractNumber : contractNumber,
	    	toElsAccount : toElsAccount,
	    	contractDesc : contractDesc,
	    	contractType : contractType,
	    	businessType : businessType,
	    	purchasePerson : purchasePerson,
	    	salePerson : salePerson,
	    	contractStatus : contractStatus,
	    	sendStatus : sendStatus,
	    	auditStatus : auditStatus,
	    };
	    headGrid.opts.params = queryParam;
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
				  if(data[0].salePerson) {
					  var salePerson = data[0].salePerson;
					  var saleArr = salePerson.split(';');
					  var storeArr =[];
					  if(saleArr && saleArr.length) {
						  if(saleArr && saleArr.length==1) {
							  var per = saleArr[0].split("_");
							  toElsSubAccount= per[0];
						  } else {
							  for(var i in saleArr) {
								  var per = saleArr[i].split("_");
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
						+ "&businessType=contract"
						+ "&businessID="+businessId
		                + "&list="+encodeURI(peopleListString)
						+"&t="+new Date().getTime();
			   
			   $(".testIframe").attr("src","${pageContext.request.contextPath}/"+ url);
			   //滚动条美化niceScroll
			   $(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
	}
		
	function loadClause(elsAccount,contractNumber) {
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	contractNumber : contractNumber
	    };
	    $.extend(clauseGrid.opts.params,queryParam);
		clauseGrid.load();
	}
	
	function loadFile(elsAccount,contractNumber) {
		var queryParam = {
	    	elsAccount : elsAccount,
	    	contractNumber : contractNumber
	    };
	    $.extend(fileGrid.opts.params,queryParam);
	    fileGrid.load();
	}
	
	function loadMaterial(elsAccount,contractNumber){
		var queryParam = {
	    	elsAccount : elsAccount,
	    	contractNumber : contractNumber
	    };
		$.extend(materialGrid.opts.params,queryParam);
		materialGrid.load();
	}
		
	function clearChildTables(){
		if(clauseGrid.rowsLength() > 0){
			for(var i=clauseGrid.rowsLength();i-1>=0;i--){
				clauseGrid.removeRow(i-1);
			}
		}
		
		if(fileGrid.rowsLength() > 0){
			for(var i=fileGrid.rowsLength();i-1>=0;i--){
				fileGrid.removeRow(i-1);
			}
		}
		
		if(materialGrid.rowsLength() > 0){
			for(var i=materialGrid.rowsLength();i-1>=0;i--){
				materialGrid.removeRow(i-1);
			}
		}
	}
	
	function reGenFileTypeSelect(){
		var fileTypeSelect = $("#selectFileType");
		fileTypeSelect.empty();
		$("<option value='all'><i18n:I18n defaultValue='所有' key='i18n_common_option_all'/></option>").appendTo(fileTypeSelect);
		$("<option value='common'><i18n:I18n defaultValue='公共' key='i18n_common_option_common'/></option>").appendTo(fileTypeSelect);
		for(var i=0;i<materialGrid.rowsLength();i++){
			var contractItemNumber = materialGrid.row(i).contractItemNumber;
			$("<option value='"+contractItemNumber+"'>"+contractItemNumber+"</option>").appendTo(fileTypeSelect);//文件下拉列表添加行项目选项
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
				var contractItemNumber = fileGrid.row(index).contractItemNumber;
				if("" == contractItemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		} else {//显示指定行项目下的文件
			$("#fileTable tr").each(function(index,domElement){
				var contractItemNumber = fileGrid.row(index).contractItemNumber;
				if(selectFileType == contractItemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		}
	}
	//提交审批
	$("#entryBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			if(headRecord.auditStatus == "0" || headRecord.auditStatus == "2"){
				alert("已通过审批或审批中的合同禁止再次上报！",2);
			}else{
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
					$.ajax({
						url : '${pageContext.request.contextPath}/rest/ContractManageService/entryPurchaseContract',
						type :"post",
						contentType : "application/json",
						data : JSON.stringify(headRecord),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							if (data.statusCode == "-100") {
								console.log(data.message);
								alert(data.message,3);
								return;
							}
							// 匹配的审批策略有多条，让用户选择
							if (data.rows) {
								showStretegySelector(data.rows);
								return;
							}
							purchaseContractNumber = data.contractNumber;
							alert("<i18n:I18n key='' defaultValue='上报成功' />",1);
							if (purchaseContractNumber != "") {
								window.location="${pageContext.request.contextPath}/contractmanage/purchase/purchaseContractManage.jsp?purchaseContractNumber="+purchaseContractNumber;
							}
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
								alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
							}
						});	
					}});
				}
			}
		});
	$("#flowBtn").click(function(){
		
		viewFlowSet();
		
		if (purchaseContractNumber == "") {
			alert("<i18n:I18n key="" defaultValue="合同尚未审批" />",2);
		} else if (flowCode == "" || flowCode == "00") {
			alert("<i18n:I18n key="" defaultValue="合同尚未审批" />",2);
		} else {
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'auditFlowList',
		        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
		        'iframSrc':"<%=basePath%>audit/auditFlowList.jsp?elsAccount=" + elsAccount + "&businessType=contract&businessId="+purchaseContractNumber,
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':680,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		}
		
	});
	
	function canelApproveSet(){
		var selectRows = headGrid.selectedRows();
		var item = selectRows[0];
		var auditStatus = item.auditStatus;
		var contractNumber = item.contractNumber;
		purchaseContractNumber = item.contractNumber;
		if(auditStatus == "2"){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/ContractManageService/findPurchaseContractByNumber/"+contractNumber+"/"+elsAccount,
				type :"get",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.flowCode) {
						flowCode = data.flowCode;
					}
					if (data.auditStatus) {
						auditStatus = data.auditStatus;
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
					
				}
			});
		}else{
			flowCode = "";
		}
	}
	function viewFlowSet(){
		var selectRows = headGrid.selectedRows();
		var item = selectRows[0];
		var auditStatus = item.auditStatus;
		var contractNumber = item.contractNumber;
		purchaseContractNumber = item.contractNumber;
		if(auditStatus != "1"){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/ContractManageService/findPurchaseContractByNumber/"+contractNumber+"/"+elsAccount,
				type :"get",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.flowCode) {
						flowCode = data.flowCode;
					}
					if (data.auditStatus) {
						auditStatus = data.auditStatus;
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
					
				}
			});
		}else{
			flowCode = "";
		}
	}
	
	$("#cancelEntryBtn").click(function(){
		
		canelApproveSet();
		
		alert(purchaseContractNumber + "_" + flowCode);
		if (purchaseContractNumber == "") {
			alert("<i18n:I18n key="" defaultValue="合同尚未审批" />",2);
		} else if (flowCode == "" || flowCode == "00") {
			alert("<i18n:I18n key="" defaultValue="合同尚未审批" />",2);
		} else {
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				var param = {"contractNumber":purchaseContractNumber,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
				$.ajax({
					url :"<%=basePath%>rest/ContractManageService/cancelAudit",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(param),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n key="i18n_delivery_revokesuccess" defaultValue="撤销成功" />");
						window.location="${pageContext.request.contextPath}/contractmanage/purchase/purchaseContractManage.jsp";
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						if (!permissionError(data)) {
							if (data.status == "401") {
								alert("<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />",3);
							} else if (data.status == "403") {
								alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",3);
							} else {
								alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
							}
						}
					}
				});
			}});
		}
	});
	function showStretegySelector(stretegyList) {
		$(".dialog-tip").height(40);
		var html = "";
		for (var i=0;i<stretegyList.length;i++){
			html += "<option value='"+stretegyList[i].stretegyCode+"'>"+stretegyList[i].stretegyName+"</option>";
		}
		$("#stretegySelctor").empty().html(html);
		$('#dialog2').show();
		$("#btnFileOK2").unbind("click").click(function(){
			var selectRows = headGrid.selectedRows();
			var record = selectRows[0];
			record["stretegyCode"]=$("#stretegySelctor").val();
			$("#entryBtn").click();
		});
	}
</script>
</body>
</html>