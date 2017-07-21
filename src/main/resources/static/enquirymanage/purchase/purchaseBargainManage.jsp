<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String purchaseEnquiryNumber = request.getParameter("purchaseEnquiryNumber");
String orderType = request.getParameter("orderType");//询价类型
String beginDate = request.getParameter("beginDate");//询价开始日期
String endDate = request.getParameter("endDate");//询价结束日期
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
<%--            <button id="fillMaterialCode" class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_fillMaterialCode" defaultValue="补录物料信息" /></button> --%>
<%-- 			<button id="uploadToERP" class="button-wrap"><i18n:I18n key="test" defaultValue="回写ERP" /></button> --%>
				<button id="materialColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_materialName" defaultValue="物料" /><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<button id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_itemName" defaultValue="行" /><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
            	<base:auditConfig elsAccount="${elsAccount}" businessType="bargainEnquiry">
					<button id="entryBtn" class="button-wrap" style="height: 23px;"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批" /></button>
					<button id="cancelEntryBtn" class="button-wrap" style="height: 23px;"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
					<button id="flowBtn" class="button-wrap" style="height: 23px;"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
				</base:auditConfig>
				<button class="span1 padClear button-wrap width_2text" id="parityBtn"><i18n:I18n key="" defaultValue="比价" /></button>
				<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common" style="position: inherit;">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="i18n_enquiry_label_enquirynumber" defaultValue="询价单号" />：</strong><span id="purchaseEnquiryNumber"/></div>
                <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="i18n_enquiry_title_enquirytype" defaultValue="询价单类型" />：</strong><span id="orderType"/></div>
                <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="i18n_purchase_bargain_beginEndDate" defaultValue="询价起止日期" />: </strong><span id="beginDate"></span><strong><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" />: </strong><span id="endDate"/></div>
                <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="test" defaultValue="最后刷新时间" />：</strong><span style="color: red;" id="refurbish" class="col-price-his"/></div>
            </div>
            
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_purchase_bargain_material" defaultValue="询价单物料项目" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100" id="materialTotal">
                        <table id="table-materialItem"></table>
                    </div>
                </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_purchase_bargain_item" defaultValue="询价单行项目" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_purchase_bargain_supplierQuotedPrice" defaultValue="供应商报价" /></a></li>
                        <li><a class="scan-file-sheet" href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                    </ul>
                    <div id="sheet-project-one">
                    
                         <main class="grid-container nest-table">
                         <div class="common-box-line">
                         		<!-- <strong>批量设置:</strong> -->
								<button id="acceptBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="接受" /></button>
								<button id="refuseBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="拒绝" /></button>
								<button id="againBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="重报" /></button>
			             </div>
		                    <div class="grid-100" id="reCreate">
		                        <table id="table-item"></table>
		                        <div id="pg-price" style="text-align: right;"></div>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two">
	                  <div class="box-wrap pos-relative bg-common" style="padding: 0;">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list" style="width: 450px">
									<div class="file-list-head">
				                       <select id="selectPurchaseSale" name="selectPurchaseSale">
					                   <option value="0"><i18n:I18n key="i18n_common_select_filetype_all" defaultValue="所有文件" /></option>
					                   <option value="1"><i18n:I18n key="i18n_common_title_ourfile" defaultValue="我方文件" /></option>
					                   <option value="2"><i18n:I18n key="i18n_common_title_theyfile" defaultValue="对方文件" /></option>
					                   </select>
					                   <select id="selectFileType" name="selectFileType" style="width: 165px;">
					                   </select>
					                 </div>
									<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="add-file-project"></table>
											<div id="enquiryFilePage" style="text-align: right;"></div>
										</div>
									</main>
			                    </div>
				                 <div class="file-scan" style="padding-left: 450px">
		   							<div class="file-option-zoom">
					                  <div class="dis-in-b text-left">
<%-- 					                  	<button id="addFileBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button> --%>
					                     <button id="fileColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
							             <button id="flushFileBtn" class="button-wrap"><i18n:I18n key="i18n_common_title_flush" defaultValue="刷新" /></button>
							             <button id="downFileBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_download" defaultValue="下载"/></button>
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
        
       <!-- 支持多个策略  begin  @jiangzhidong @date 20160428 -->
       <input type='hidden' name='stretegyCode' id="stretegyCode" />
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
		<!-- 支持多个策略  end  @jiangzhidong @date 20160428 -->
	
    </div>
    
        <!-- 对话框 -->
<div class="fixed-dialog" id="sendMsgDialog">
           <div class="dialog-tip bg-common" style="width: 420px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="<%=basePath%>/icon/destop-icon/desktop_icon_09.gif" />
                   <span class="dialogTitle"><i18n:I18n key="test" defaultValue="填写上报意见" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <textarea id="msgArea" style="width: 100%; box-sizing: border-box;margin: 0; display: block;resize: none;height: 150px;"></textarea>
	                       <div class="mt-20 text-center">
	                          <button id="sendMsgBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>

<!-- 添加文件Dialog -->
<div class="fixed-dialog" id="addFileDialog">
		<div class="dialog-tip bg-common" style="width: 350px;height: auto; margin-left: -250px;margin-top: -190px;">
			<div class="dialog-close-btn" id="dialogFileClose"></div>
			<div class="tip-head">	<img class="icon" src="../../icon/els.PNG" /><span class="dialogTitle"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件"/></span></div>
			<div class="">
	   		<div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
			<div class="common-box-line">
				<div class="input-and-tip"> <i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型 "/>：
							<select class="" id="fileTypeSelected" name="fileTypeSelected" >
								
							</select>
							
				</div>	
				<div class="input-and-tip"><span><i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>：</span><input id="fileName" name="fileName" type="text" /></div>
				<div class="input-and-tip"><span><i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>：</span><input id="filePath" name="filePath" type="text" /></div>
				<div class="input-and-tip text-right"><span><button id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件"/></button></span>
					<input id="fileType" name="fileType" type="hidden"/>
					<input id="filePath" name="filePath" type="hidden" />
				</div>
				<div class="mt-20 text-center">
					<button id="addFileBtnOK"     class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定"/></button>
					<button id="addFileBtnCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消"/></button>
				</div>
			</div>
	   		</div>
			</div>
		</div>
</div> 

<script>

var materialGrid;
var itemGrid;
var chatIfr;
var isloadItemGrid = false;
var editFileTable;
var purchaseEnquiryNumber='<%=purchaseEnquiryNumber%>';
var orderType='<%=orderType%>';
var beginDate='<%=beginDate%>';
var endDate='<%=endDate%>';
var currentPurchaseOrderNumber;
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var rowIndexSelect=0;
var peopleList;
var $sob;
var taxRate=[];

//聊天窗口
//供应商列表：toElsAccount ,每个供应商对应的负责人：elsSubAccount,询价订单号 ： businessID
function initChat() {	
	  //查询供应商表purchase_enquiry_supplie_list  供应商编码   供应商名称    
	  //查询采购方purchase_enquiry_header  负责人
	  var supplieParam = {
	  	'elsAccount':elsAccount,
	  	'purchaseEnquiryNumber':'<%=purchaseEnquiryNumber%>'
	    };
	  $.ajax({
 		 url: '<%=basePath%>rest/PurchaseEnquiryBargainService/querySupplierByCondtion',
 		 type :"post",
 		 contentType : "application/json",
 		 data : JSON.stringify(supplieParam),
 		 dataType : "json",
 		 success : function(data) {
 			var totalList = [];
 			if(data && data.length) {
 				totalList = data;
 				//供应商列表
 	 			var toElsAccountList = [];
 	 			//每个人供应商对应的责任人列表
 	 			var toElsSubAccountList = totalList;
 	 			var displayList = [];
 	 			if(totalList && totalList.length) {
 	 				totalList.forEach(function(d,i){
 	 					var kObj = d;
 	 					for(var key in kObj) {
 	 						toElsAccountList[i] = key;
 	 						displayList[i] = key;
 	 					}
 	 				});
 	 				//显示的全部数据列表
 	 				displayList=displayList.map(function(d){
 	 					return {name:d};
 	 				}); 
 	 			};
 	 			//初始化iframe
 	 		   
				setIframeData(chatIfr,{
						type:'multi',
						displayType:'1',
						fromElsAccount:elsAccount,
						fromElsSubAccount:elsSubAccount,
						toElsAccount:toElsAccountList,
						toElsSubAccount:toElsSubAccountList,
						businessType:'enquiry',
						businessID:purchaseEnquiryNumber,
						list:displayList,
						orderType:orderType,
						beginDate:beginDate,
						endDate:endDate,
						t: new Date().getTime()
				});
 	 		   //滚动条美化niceScroll
 	 		   $('.public-wrap').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
 			}
 		 },
 		 error : function(data) {
 			alert("系统异常!",3);
 		 }
    }); 
}
$(document).ready(function(){
	chatIfr= $('#chatIframe')[0];
	chatIfr.src = '<%=basePath%>' + 'multiChat_n.jsp';
	// 动态加载聊天窗口
	$sob = $('.saying-dialog .option-bar');
	initChat();
	//初始化聊天控制状态
    if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
    $sob.click();
	init();
	//获取询报价-税码、税率
	$.ajax({
	    url :"<%=basePath%>rest/ElsTaxRateService/queryElsTaxRateList",
	    type :"post",
	    contentType : "application/json",
	    data : JSON.stringify({"elsAccount":elsAccount}),
	    dataType : "json",
	    success : function(data) {
	    	if(data.statusCode == "-100"){
			}else{
				taxRate = data.rows;
			}
	    },
	    error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
    });
});


//补录物料编码,描述
$("#fillMaterialCode").click(function(){
	debugger;
	var yes = false;
	var materialRows = materialGrid.selectedRows();
	var materieRowsIndex=materialGrid.selectedRowsIndex();
	if(materialRows.length==0){
		alert('<i18n:I18n key="i18n_alert_bargain_pleaseSelectMaterial" defaultValue="请选择物料行记录!" />',2);
		return;
	}
	for(var i= 0; i<=materialRows.length-1; i++) {
		var ind = materieRowsIndex[i];
		var materialNumber =document.getElementsByName("materialNumber")[ind].value;
		if(materialNumber != '' && materialNumber != null){
			materialRows[i].materialNumber = materialNumber;
			yes = true;
		}
	}
	
	if(!yes){
		alert('<i18n:I18n key="i18n_alert_bargain_materialNumberAndMaterialDescNotNull" defaultValue="物料编码,描述不能为空!" />',2);
		return;
	}
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_materialNumberDescFill" defaultValue="是否确认补录?" />',closeEvent:function(){
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsFillToMaterial' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(materialRows),
			dataType : "json",
			success : function(data) {
    			alert('<i18n:I18n key="i18n_alert_bargain_FillSuccess" defaultValue="补录成功!" />',1);
    			query();
    		},
    		error : function(data) {
    			alert('<i18n:I18n key="i18n_alert_bargain_fillFailed" defaultValue="补录失败!" />',3);
    		}
		});
	}});
	
});

//提交审批
$("#entryBtn").click(function(){
	debugger;
   var material = itemGrid.selectedRows();
    selsIndex = itemGrid.selectedRowsIndex();
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBargainService/queryEnquiryItemsByCondtion' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(material),
		dataType : "json",
		success : function(data) {
			debugger;
			var itemRows = data.rows;
// 			var itemRows = itemGrid.selectedRows();
			var itemRowsIndex=itemGrid.selectedRowsIndex();
			var yes = 0;
			var yes2 = 0;
			var yes3 = 0;
			
			if(itemRows.length==0){
				alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />',2);
				return;
			}
			
		   //订单状态须是审批中,才能提交
			for(var i= 0; i<=itemRows.length-1; i++) {
				if(itemRows[i].orderStatus != 3){
					yes = yes + 1;
				}
			}
			if(yes==itemRows.length){
				alert("订单状态是审批中,才能执行操作!",2);
				return;
			}else if(yes>0){
				alert("部分订单状态不是审批中,不能执行操作!",2);
				return;
			}
			
			//审批中(即：已提交)不能再提交
			for(var i= 0; i<=itemRows.length-1; i++) {
				if(itemRows[i].auditStatus == 2){
					yes2 = yes2 + 1;
				}
			}
			if(yes2==itemRows.length){
				alert('<i18n:I18n key="i18n_alert_bargain_auditSendNoOperate" defaultValue="审批已提交,不能执行操作!" />',2);
				return;
			}else if(yes2>0){
				alert('<i18n:I18n key="i18n_alert_bargain_partAuditSendNoOperate" defaultValue="部分审批已提交,不能执行操作!" />',2);
				return;
			}
			
			/*//审批通过不能再提交
			for(var i= 0; i<=itemRows.length-1; i++) {
				if(itemRows[i].auditStatus == 0){
					yes3 = yes3 + 1;
				}
			}
			if(yes3==itemRows.length){
				alert('<i18n:I18n key="i18n_alert_bargain_passAuditNoOperate" defaultValue="已审批通过,不能执行操作!" />',2);
				return;
			}else if(yes3>0){
				alert('<i18n:I18n key="i18n_alert_bargain_partPassAuditNoOperate" defaultValue="部分已审批通过,不能执行操作!" />',2);
				return;
			}*/
			
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_confirmReportAudit" defaultValue="是否确定提交审批?" />',closeEvent:function(){
				$("body").data("itemRowsJson",itemRows);
				$("#sendMsgDialog").show();
			}});
// 			itemGrid.load(data.rows);
		},
		error : function(data) {
			alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
		}
	});
});

//更新行
$("#sendMsgBtnOK").click(function() {
	debugger;
	var itemRows = $("body").data("itemRowsJson")
	//提交赋值
	for(var i= 0; i<=itemRows.length-1; i++) {
		itemRows[i].elsSubAccount = elsSubAccount;
		//支持多个策略  begin  @jiangzhidong @date 20160428
		itemRows[i].stretegyCode = $("#stretegyCode").val();
		//支持多个策略  begin  @jiangzhidong @date 20160428
		//上报意见  begin  @jiangzhidong @date 20160602
		itemRows[i].remark = $("#msgArea").val();
		//上报意见  end  @jiangzhidong @date 20160602
	}
	parent.elsDeskTop.showLoading("上报中");
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToAudit' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(itemRows),
		dataType : "json",
		success : function(data) {
			$("#sendMsgDialog").hide();
			//支持多个策略  begin  @jiangzhidong @date 20160428
			if (data.rows) {
				showStretegySelector(data.rows);
				return;
			}
			$('#dialog2').hide();
			//支持多个策略  end  @jiangzhidong @date 20160428
			if (data&&data.statusCode&&data.statusCode != "200") {
				alert(data.message,3);
				return;
			}
			alert("审批提交成功",1);
			query();
		},error : function(data) {
			alert("发送失败",3);
		},complete : function(data) {
			parent.elsDeskTop.hideLoading();
		}
	});

});

//撤销审批
$("#cancelEntryBtn").click(function(){
	var itemRows = itemGrid.selectedRows();
	var itemRowsIndex=itemGrid.selectedRowsIndex();
	var yes = 0;
	var yes2 = 0;
	var yes3 = 0;
	
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	//审批通过不能再提交
	for(var i= 0; i<=itemRows.length-1; i++) {
		if(itemRows[i].auditStatus == 0){
			yes3 = yes3 + 1;
		}
	}
	if(yes3==itemRows.length){
		alert('<i18n:I18n key="i18n_alert_bargain_passAuditNoOperate" defaultValue="已审批通过,不能执行操作!" />!',2);
		return;
	}else if(yes3>0){
		alert('<i18n:I18n key="i18n_alert_bargain_partAuditSendNoOperate" defaultValue="部分已审批通过,不能执行操作!" />!',2);
		return;
	}
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_confirmCancelReportAudit" defaultValue="是否确定撤销审批?" />!',closeEvent:function(){
		for(var i= 0; i<=itemRows.length-1; i++) {
			itemRows[i].elsSubAccount = elsSubAccount;
			itemRows[i].auditStatus = 1;
		}
		
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToCancel' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRows),
			dataType : "json",
			success : function(data) {
    			alert(data.message,1);
    			$("#entryBtn").show();
    			$("#cancelEntryBtn").hide();
//     			$("#flowBtn").hide();
    			query();
    		},error : function(data) {
    			alert("发送失败",3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}});
});

//查看流程
$("#flowBtn").click(function(){
	var itemRows = itemGrid.selectedRows();
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	var targetElsAccount = itemRows[0].elsAccount;
	var businessType = "bargainEnquiry";
	var businessId = itemRows[0].toElsAccount+","+itemRows[0].purchaseEnquiryNumber+","+itemRows[0].materialLineNumber;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});

//显示当前待审批节点 @author jiangzhidong @date 20160524  begin
$('.flowBtn').live("click", function() {
    var scanCol = $(this).next().text();
    var item = JSON.parse(scanCol);
	var targetElsAccount = item.elsAccount;
	var businessType = "bargainEnquiry";
	var businessId = item.toElsAccount+","+item.purchaseEnquiryNumber+","+item.materialLineNumber;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
//显示当前待审批节点 @author jiangzhidong @date 20160524  end

//回写SAP
$("#uploadToERP").click(function(){
	var itemRows = itemGrid.selectedRows();
	var materialRows=materialGrid.selectedRows();
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作!" />!',2);
		return;
	}
	
	//订单状态须是已结束,才能提交  @author jiangzhidong @date 20160615 begin
	var yes=0;
	for(var i= 0; i<=itemRows.length-1; i++) {
		if(itemRows[i].orderStatus != 7){
			yes = yes + 1;
		}
	}
	if(yes==itemRows.length){
		alert("订单状态是已结束,才能执行操作!",2);
		return;
	}else if(yes>0){
		alert("部分订单状态不是已结束,不能执行操作!",2);
		return;
	}
	
	//未回写ERP,才能提交
	var yes2=0;
	for(var i= 0; i<=itemRows.length-1; i++) {
		if(itemRows[i].FBK17 == '1'){
			yes2 = yes2 + 1;
		}
	}
	debugger;
	if(yes2==itemRows.length){
		alert("未回写ERP,才能执行操作!",2);
		return;
	}else if(yes2>0){
		alert("部分已回写ERP,不能执行操作!",2);
		return;
	}
	//订单状态须是已结束,才能提交  @author jiangzhidong @date 20160615 end

	var param={"elsAccount":elsAccount,"purchaseEnquiryMaterial":materialRows[0],"purchaseEnquiryItemList":itemRows};
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_title_sendToErp" defaultValue="是否确定发送ERP?" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		//发送至供应商
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToERP' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				if(data!=null&&data.statusCode=="-100"){
					alert("操作失败",2)
				}else if(data!=null&&data.statusCode=="-200"){
					alert(data.message,3);
				}else{
					alert("操作成功！",1);
	    			query();
				}
    		},error : function(data) {
    			alert("上报失败!",3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}});
});

//物料列自定义
$("#materialColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainMaterial_mt" + "&window=iframeApp_PurchaseEnquiryDetail",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});

//行列自定义
$("#itemColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainItem_mt" + "&window=iframeApp_purchaseBargainManage",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});


//文件列自定义
$("#fileColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainFile" + "&window=iframeApp_purchaseBargainManage",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});

//退出
$("#exitBtn").click(function(){
	//parent.elsDeskTop.closeCurWin('purchaseBargainManage');
	top.$(frameElement).parents('.myWindow').find('a.winCloseBtn').click()
});


// 渲染   @author jiangzhidong 20160113  begin
//类型 
var rendererPurchaseType = function (val,item,index){
	if(val==0) return "标准";
	else if(val==1) return "限制";
	else if(val==2) return "寄售";
	else if(val==3) return "分包";
	else if(val==4) return "未知的商品";
	else if(val==5) return "第三方";
	else if(val==6) return "文本";
	else if(val==7) return "库存转储";
	else if(val==8) return "商品类目";
	else if(val==9) return "服务";
	else return "其他";
};
//只允许数字输入框
var initInputNumber = function (val,item,index){
	if(!val) { val = '';}
	return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
};
//允许任何字符输入框
var initInputAny = function (val,item,index){
	if(!val) { val = '';}
	return '<input type="text" name="'+this.name+'" value="'+val+'"/>';
};
//订单状态
var rendererOrderStatus = function (val,item,index){
	//0-新建1-报价中2-议价中(废弃)3-审批中4-重报价5-已定价6-已拒绝7-已结束8-已报价9-已选择(废弃)
	if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />'
	else if (val == "1") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed" defaultValue="报价中" />';
	else if (val == "3") return '<i18n:I18n key="" defaultValue="已接受" />';
	else if (val == "4") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价" />';
	else if (val == "5") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价" />';
	else if (val == "6") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝" />';
	else if (val == "7") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束" />';
	else if (val == "8") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价" />';
};
//审批状态
var rendererAuditStatus = function (val,item,index){
	debugger;
	// 审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
	if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
	else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
	else if (val == "2") {
		var fbk32 = item.FBK32;
		return '<span class="flowBtn" style="color:blue;white-space: normal;"><i18n:I18n key="test" defaultValue="'+fbk32+'" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	}else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';

	
};
//物料操作
var selColItem = function(val,item,index){
    if(!val) {
        return '<span class="col-price-his" style="color:blue;"><i18n:I18n key="i18n_purchase_bargain_history" defaultValue="历史" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
    } else {
        return '<span>'+ val +'</span>';
    }
};
//报价方式
var initQuoteMethod = function (val,item,index){
	if (val == "0") return '<i18n:I18n key="i18n_ladderprice_select_normalBidding" defaultValue="常规报价" />';
	else if (val == "1") return '<i18n:I18n key="i18n_ladderprice_select_ladderBidding" defaultValue="阶梯报价" />';
};
//日期
var formatDate = function (val,item,index){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	   return val;
};
//附件需求
var initAccessoryRequire = function (val,item,index){
	if (val == "0") return '<i18n:I18n key="i18n_common_select_accessoryrequire_choosable" defaultValue="附件可选" />';
	else if (val == "1") return '<i18n:I18n key="i18n_common_select_accessoryrequire_require" defaultValue="必须附件" />';
};
//询价单开始日期-结束日期
var initOrderDate = function(val,item,index){
	var priceDate='';
	if (item.beginDate)
		priceDate=priceDate+'<i18n:I18n key="i18n_label_from" defaultValue="从" />:'+new Date(item.beginDate).format("yyyy-MM-dd")+'<br/>';
	if (item.endDate)
		priceDate=priceDate+'<i18n:I18n key="i18n_label_to" defaultValue="到" />:'+new Date(item.endDate).format("yyyy-MM-dd");
	return priceDate;
};
//数量
var initQuantity = function(val,item,index) {
	if(val==""||val == null){
		val="";
	}
	//常规报价 
	if(item.quoteMethod==0)
		return '<div>' +val+ '</div>';
	//阶梯报价
	else if(item.quoteMethod==1){
		var contain='';
		for(var i=0; i<=item.ladderPrices.length-1;i++) {
			var bottom_line = i==item.ladderPrices.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'">' +item.ladderPrices[i].beginQuantity+'&nbsp;-&nbsp;'+item.ladderPrices[i].endQuantity+ '</div>';
		}
        return contain;
	}
	return;
};
//含税单价
var initPriceIncludingVat = function(val,item,index) {
	if (!val) {val = "";}
	//警告提示  @author jiangzhidong @date 20160201
	var title3='<img title="注意: 大于基准价格30%以上" src="<%=basePath%>/icon/ico-warn3.png" style="width:15px; height:15px; margin-right:10px; float:right; cursor: pointer;"/>';
	var title1='<img title="注意: 大于基准价格10%以上" src="<%=basePath%>/icon/ico-warn.png" style="width:15px; height:15px; margin-right:10px; float:right; cursor: pointer;"/>';
	if(item.FBK31==3)
		val=val+title3;
	else if(item.FBK31==1)
		val=val+title1;
	//常规报价
	if(item.quoteMethod==0)
		return '<div style="color: red;">' +val+ '</div>';
	//阶梯报价
	else if(item.quoteMethod==1){
		var contain='';
		for(var i=0; i<=item.ladderPrices.length-1;i++) {
			var bottom_line = i==item.ladderPrices.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'" style="color: red;">' +item.ladderPrices[i].price+ '</div>';
		}
        return contain;
	}
	return;
};
//成本项目代码
var initCostItemCode = function (val,item,index){
	var contain='';
	if(item.costConstitute){
		for(var i=0; i<=item.costConstitute.length-1;i++) {
			var bottom_line = i==item.costConstitute.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'">' +item.costConstitute[i].costItemCode+ '</div>';
		}
        return contain;
    }
};
//成本项目名称
var initCostItemName = function (val,item,index){
	var contain='';
	if(item.costConstitute){
		for(var i=0; i<=item.costConstitute.length-1;i++) {
			var bottom_line = i==item.costConstitute.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'">' +item.costConstitute[i].costItemName+ '</div>';
		}
        return contain;
    }
};
//成本项目金额
var initCostItemAmount = function (val,item,index){
	var contain='';
	if(item.costConstitute){
		for(var i=0; i<=item.costConstitute.length-1;i++) {
			var bottom_line = i==item.costConstitute.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'" style="color: red;">' +item.costConstitute[i].costItemAmount+ '</div>';
		}
        return contain;
    }
};
//行表操作
var initPriceSelected = function(val,item,index) {
	if(!val) {
		var name = this.name+"_"+index;
		var id0 = name+"_0";
		var id1 = name+"_1";
		var id2 = name+"_2";
		var checked0 = '';
		var checked1 = '';
		var checked2 = '';
		if(item.orderStatus==3 || (item.orderStatus==7&&item.auditStatus==0)) checked0 = checked0 + ' checked="checked"';
		if(item.orderStatus==6) checked1 = checked1 + ' checked="checked"';
		if(item.orderStatus==4) checked2 = checked2 + ' checked="checked"';
		var selected = '<div style="text-align:left;min-width: 160px; margin:0 auto;style="position: absolute;"">'
						+'<input type="radio" name="'+name+'" id="'+id0+'" '+checked0+' style="width: 14px !important; display:inline-block; margin-left:5px !important;" />'
						+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
						+'<label style="display:inline-block; margin-left:22px; font-size:12px;">接受</label>'
						+'<input type="radio" name="'+name+'" id="'+id1+'" '+checked1+' style="width: 14px !important; margin-left: 55px !important;display:inline-block;" />'
						+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
						+'<label style="display:inline-block; margin-left:25px; font-size:12px;">拒绝</label>'
						+'<input type="radio" name="'+name+'" id="'+id2+'" '+checked2+' style="width: 14px !important; margin-left: 105px !important;display:inline-block;" />'
						+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
						+'<label style="display:inline-block; margin-left:27px; font-size:12px;">重报</label>'
						+'</div>';
		return selected;
	}
};

//时间戳
var formatDateTime = function (val,item,index){
	if (!val) {val = "";}
	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
};

//补录物料信息
var initInputMaterial = function (val,item,index){
	if(!val) { val = '';}
	if(val=='') return '<input type="text" name="'+this.name+'" value="'+val+'"/>';
	else return '<input readonly="readonly" type="text" name="'+this.name+'" value="'+val+'"/>';
};

//价格类型 如果填了含量,显示:折百价; 不填留空  诺普信
var initFBK14 = function(val,item,index) {
	var val='';
	if(item.FBK13!=null&&item.FBK13!='')
		var val='<input style="background-color: yellow;" readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="折百价"/>';
	else
		var val='<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value=""/>';
	return val;
};

// 税码/税率  @author jiangzhidong @date 20160523 begin
var initTaxCode = function (val,item,index) {
	var orderStatus = item.orderStatus;
	if(orderStatus==3||orderStatus==4||orderStatus==5||orderStatus==6||orderStatus==7||orderStatus==8){
		var name = $(this)[0].name;
	    var sel = '<div><p style="display: none;">'+JSON.stringify(item)+'</p><select onchange="changeTaxCode(this.id, '+index+')" name="'+this.name+'" id="'+name+'_'+index+'" class="taxType" style="padding: 0;height: 25px;">';
	    for(var i = 0 ; i < taxRate.length ; i ++){
			var row = taxRate[i];
			if(row.taxCode==val)
			sel += '<option value="'+row.taxCode+'" taxValue="'+row.taxValue+'" selected>'+row.taxCode+'_'+row.taxName+'</option>';
			else
			sel += '<option value="'+row.taxCode+'" taxValue="'+row.taxValue+'">'+row.taxCode+'_'+row.taxName+'</option>';
		}
	    return sel;
	}else {
		return '<input readonly="readonly" style="width:46px;height: 14px;" name="'+this.name+'" id="'+name+'_'+index+'" type="text"/>';;
	}
}
var initTaxValue = function (val,item,index) {
	var orderStatus = item.orderStatus;
	if(orderStatus==3||orderStatus==4||orderStatus==5||orderStatus==6||orderStatus==7||orderStatus==8){
		if(!val) {
			val = '';
			if(taxRate.length>0){
	         	var row = taxRate[0];
	         	val = row.taxValue;
	        }
		}
		var name = $(this)[0].name;
		return '<input readonly="readonly" style="width:46px;height: 14px;" name="'+this.name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	}else {
		return '<input readonly="readonly" style="width:46px;height: 14px;" name="'+this.name+'" id="'+name+'_'+index+'" type="text"/>';
	}
}
var changeTaxCode = function(val,index){
	var obj=document.getElementById(val);  
	var selIndex=obj.selectedIndex;  
	var text=obj.options[selIndex].getAttribute("taxValue");  
	$('#FBK16_'+index).val(text);
	return val;
}
// 税码/税率 @author jiangzhidong @date 20160523 end

//渲染   @author jiangzhidong 20160113  end

//订单状态: orderStatus 0-新建1-报价中2-议价中(废弃)3-审批中4-重报价5-已定价6-已拒绝7-已结束8-已报价9-已选择(废弃)
//中标状态：selectStatus 0：暂无  1：已中标 2：未中标  
//审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝

//操作类型 @author jiangzhidong/zhangwangyang  @date 20160401
var itemGridLoadSuccess = function(){
	if(selsIndex&&selsIndex.length){
		selsIndex.forEach(function(i){itemGrid.select(i)})
	}
	$('[id^=priceSelected]').off('click').on('mousedown',function(){
	    updateItem(this);
		this._v=this.checked;
	}).click(function(){
		if(this._v&&this.checked)this.checked=false;
	});
}

//更新行
var updateItem = function (obj){
	var scanCol = $(obj).next('span').text();
	var item = JSON.parse(scanCol);
	var selectvalue = $(obj).next().next('label').text();
	if(!(item.orderStatus==8||item.orderStatus==3||item.orderStatus==6||item.orderStatus==4)){
		alert("订单状态:已报价/已接受/已拒绝/重报价,才能执行操作!",2);
		loadItem();
		return;
	}
	if((item.auditStatus==0)||(item.auditStatus==2)){
		alert("审批状态:未审批,才能执行操作!",2);
		loadItem();
		return;
	}
	if(selectvalue.indexOf('接受') != -1){
		item.selectStatus = 1; 
		item.orderStatus = 3;
	}else if(selectvalue.indexOf('拒绝') != -1){
		item.selectStatus = 2;
		item.orderStatus = 6;
	}else if(selectvalue.indexOf('重报') != -1){
		item.selectStatus = 2;
		item.orderStatus = 4;
	}
	//税码/税率
	var index = obj.name.split("_")[1];
	var taxCode = $('#FBK15_'+index).val();
	var taxValue = $('#FBK16_'+index).val();
	item.fbk15 = taxCode;
	item.fbk16 = taxValue;
	
	parent.elsDeskTop.showLoading('发送中');
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToSupplier' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(item),
		dataType : "json",
		success : function(data) {
			loadItem();
			parent.elsDeskTop.hideLoading();
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
			parent.elsDeskTop.hideLoading();
		}
	});
};

//检测
var checkStatus = function(itemRows) {
	var yes = 0;
	for(var i= 0; i<=itemRows.length-1; i++) {
		var item = itemRows[i];
		if(!(item.orderStatus==8||item.orderStatus==3||item.orderStatus==6||item.orderStatus==4)){
			yes = yes + 1;
		}
	}
	if(yes==itemRows.length){
		alert("订单状态:已报价/审批中/已拒绝/重报价,才能执行操作!",2);
		return true;
	}else if(yes>0){
		alert("部分订单状态:已报价/审批中/已拒绝/重报价,才能执行操作!",2);
		return true;
	}

	var yes2 = 0;
	for(var i= 0; i<=itemRows.length-1; i++) {
		var item = itemRows[i];
		if((item.auditStatus==0)||(item.auditStatus==2)||(item.auditStatus==3)){
			yes2 = yes2 + 1;
		}
	}
	if(yes2==itemRows.length){
		alert("审批状态:未审批,才能执行操作!",2);
		return true;
	}else if(yes2>0){
		alert("部分审批状态:未审批,才能执行操作!",2);
		return true;
	}
}

//接受
$("#acceptBtn").click(function(){
	var itemRows = itemGrid.rows();
	if(checkStatus(itemRows)) return;
	var itemRowsTo = [];
	for(var i= 0; i<=itemRows.length-1; i++) {
		$('input[id="priceSelected_'+i+'_0"]').attr("checked", true);
		if((itemRows[i].orderStatus==8||itemRows[i].orderStatus==3||itemRows[i].orderStatus==6||itemRows[i].orderStatus==4)
				&&(itemRows[i].auditStatus!=0&&itemRows[i].auditStatus!=2&&itemRows[i].auditStatus!=4)){
			itemRows[i].selectStatus = 1; 
			itemRows[i].orderStatus = 3;
			var taxCode = $('#FBK15_'+i).val();
			var taxValue = $('#FBK16_'+i).val();
			itemRows[i].fbk15 = taxCode;
			itemRows[i].fbk16 = taxValue;
			itemRowsTo.push(itemRows[i]);
		}
 	}
	updateItems(itemRowsTo);
});

//拒绝
$("#refuseBtn").click(function(){
	var itemRows = itemGrid.rows();
	checkStatus(itemRows);
	var itemRowsTo = [];
	for(var i= 0; i<=itemRows.length-1; i++) {
		$('input[id="priceSelected_'+i+'_1"]').attr("checked", true);
		if((itemRows[i].orderStatus==8||itemRows[i].orderStatus==3||itemRows[i].orderStatus==6||itemRows[i].orderStatus==4)
				&&(itemRows[i].auditStatus!=0&&itemRows[i].auditStatus!=2&&itemRows[i].auditStatus!=4)){
			itemRows[i].selectStatus = 2;
			itemRows[i].orderStatus = 6;
			var taxCode = $('#FBK15_'+i).val();
			var taxValue = $('#FBK16_'+i).val();
			itemRows[i].fbk15 = taxCode;
			itemRows[i].fbk16 = taxValue;
			itemRowsTo.push(itemRows[i]);
		}
 	}
	updateItems(itemRowsTo);
});

//重报
$("#againBtn").click(function(){
	var itemRows = itemGrid.rows();
	checkStatus(itemRows);
	var itemRowsTo = [];
	for(var i= 0; i<=itemRows.length-1; i++) {
		$('input[id="priceSelected_'+i+'_2"]').attr("checked", true);
		if((itemRows[i].orderStatus==8||itemRows[i].orderStatus==3||itemRows[i].orderStatus==6||itemRows[i].orderStatus==4)
				&&(itemRows[i].auditStatus!=0&&itemRows[i].auditStatus!=2&&itemRows[i].auditStatus!=4)){
			itemRows[i].selectStatus = 2;
			itemRows[i].orderStatus = 4;
			var taxCode = $('#FBK15_'+i).val();
			var taxValue = $('#FBK16_'+i).val();
			itemRows[i].fbk15 = taxCode;
			itemRows[i].fbk16 = taxValue;
			itemRowsTo.push(itemRows[i]);
		}
 	}
	updateItems(itemRowsTo);
});

//更新行 批量
var updateItems = function (obj){
	parent.elsDeskTop.showLoading('发送中');
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToSuppliers' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(obj),
		dataType : "json",
		success : function(data) {
			loadItem();
			parent.elsDeskTop.hideLoading();
		},error: function (data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
			parent.elsDeskTop.hideLoading();
        }
	});
}


//物料表purchase_enquiry_material
var material_cols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryBargainMaterial_mt"/>;
/*var material_cols = [
	    { title:'操作', clickDisable:true, name:'' ,width:50, align:'center', renderer: selColItem},
	    { title:'请求单号', name:'purchaseOrderNumber', width: 100, align: 'center'},
	    { title:'行项目号', name:'orderItemNumber' ,width:60, align:'center' },
	    { title:'物料编码', name:'materialNumber' ,width:70, align:'center', renderer: initInputMaterial},
	    { title:'物料描述', name:'materialDesc' ,width:100, align:'center', renderer: initInputMaterial},
	    { title:'工厂', name:'factory' ,width:80, align:'center' },
	    { title:'物料规格', name:'materialSpecification' ,width:80, align:'center'},
	    { title:'物料组', name:'materialGroup' ,width:80, align:'center' },
	    { title:'库存地点', name:'stockPoint' ,width:60, align:'center'},
	    { title:'项目类别', name:'itemClasses' ,width:60, align:'center',hidden:true},
	    { title:'需求数量', name:'quantity' ,width:60, align:'center'},
	    { title:'请求日期', name:'requestDate' ,width:100, align:'center',renderer: formatDate},
	    { title:'需求日期', name:'deliveryDate' ,width:100, align:'center',renderer: formatDate},
	    { title:'计量单位', name:'unitQuantity',width:60, align:'center'},
	    { title:'计价度量单位', name:'priceMetricQuantity' ,width:80, align:'center'},
	    { title:'计价单位', name:'priceQuantity' ,width:70, align:'center'},
	    { title:'报价方式', name:'quoteMethod' ,width:70, align:'center',renderer: initQuoteMethod},
	    { title:'订单状态', name:'orderStatus' ,width:65, align:'center' , renderer: rendererOrderStatus},
	    { title:'审批状态', name:'auditStatus' ,width:65, align:'center' , renderer: rendererAuditStatus},
	    { title:'附件需求', name:'accessoryRequire' ,width:70, align:'center', renderer: initAccessoryRequire},
	    { title:'采购类型', name:'purchaseType' ,width:100, align:'center',renderer: rendererPurchaseType},
	    { title:'属性1', name:'property1' ,width:100, align:'center'},
	    { title:'属性2', name:'property2' ,width:100, align:'center'},
	    { title:'属性3', name:'property3' ,width:100, align:'center'},
	    { title:'属性4', name:'property4' ,width:100, align:'center'},
	    { title:'属性5', name:'property5' ,width:100, align:'center'},
	    { title:'币别', name:'currency' ,width:100, align:'center'},
	    { title:'最小订单量', name:'minOrderQuantity' ,width:100, align:'center'},
	    { title:'最小包装数', name:'minPackQuantity' ,width:100, align:'center'},
	    { title:'采购周期', name:'cycle' ,width:100, align:'center'},
	    { title:'含税价格', name:'priceIncludingVat' ,width:100, align:'center'},
	    { title:'采购组', name:'purchaseGroup' ,width:100, align:'center'},
	    { title:'不含税价', name:'price' ,width:100, align:'center'},
	    { title:'无限制容差', name:'infinite' ,width:100, align:'center'},
	    { title:'超量容差', name:'maxTolerance' ,width:100, align:'center'},
	    { title:'不足容差', name:'minTolerance' ,width:100, align:'center'},
	    { title:'备注', name:'remark' ,width:100, align:'center'},
	    { title:'changeFlag', name:'changeFlag' ,width:100, align:'center'},
	    { title:'行号', name:'materialLineNumber' ,width:100, align:'center',hidden:true}];*/


//行表purchase_enquiry_item  阶梯表purchase_enquiry_ladder_price  成本表purchase_receive_enquiry_cost_constitute
var item_cols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryBargainItem_mt"/>;
/*var item_cols = 
			[{ title:'操作',clickDisable:true, name:'priceSelected' ,width:70, align:'center', renderer: initPriceSelected},
			{ title:'子帐号' , name:'elsSubAccount', width: 60, align:'center', hidden:true},
			{ title:'行号', name:'materialLineNumber' ,width:50, align:'center'},
			{ title:'物料编码', name:'materialNumber' ,width:100, align:'center'},
			{ title:'物料描述', name:'materialDesc' ,width:100, align:'center'},
            { title:'供应商编码', name:'toElsAccount', width: 80, align: 'center'},
            { title:'供应商名称', name:'toCompanyName', width: 120, align: 'center'},
	        { title:'价格有效期', name:'orderDate' ,width:100, align:'center',renderer: initOrderDate},
	        { title:'订单状态', name:'orderStatus' ,width:70, align:'center', renderer: rendererOrderStatus},
	        { title:'审批状态', name:'auditStatus' ,width:65, align:'center' , renderer: rendererAuditStatus},
	        { title:'数量', name:'quantity', width: 130, align: 'center', renderer: initQuantity},
			{ title:'含税单价', name:'priceIncludingVat', width: 90, align: 'center', renderer: initPriceIncludingVat},
			{ title:'不含税价', name:'price' ,width:100, align:'center'},
			{ title:'币别', name:'currency' ,width:100, align:'center'},
			{ title:'采购类型', name:'purchaseType' ,width:100, align:'center',renderer: rendererPurchaseType},
		    { title:'属性1', name:'property1' ,width:100, align:'center'},
		    { title:'属性2', name:'property2' ,width:100, align:'center'},
		    { title:'属性3', name:'property3' ,width:100, align:'center'},
		    { title:'属性4', name:'property4' ,width:100, align:'center'},
		    { title:'属性5', name:'property5' ,width:100, align:'center'},
		    { title:'最小订单量', name:'minOrderQuantity' ,width:100, align:'center'},
		    { title:'最小包装数', name:'minPackQuantity' ,width:100, align:'center'},
		    { title:'采购周期', name:'cycle' ,width:100, align:'center'},
		    { title:'不足容差', name:'minTolerance' ,width:100, align:'center'},
		    { title:'超量容差', name:'maxTolerance' ,width:100, align:'center'},
		    { title:'无限制容差', name:'infinite' ,width:100, align:'center'},
		    { title:'备注', name:'remark' ,width:100, align:'center'},
		    { title:'时间戳', name:'logtime' ,width:100, align:'center',renderer: formatDateTime},
		    {title:'成本项目代码', name:'costItemCode', width: 90, align: 'center', renderer: initCostItemCode},
			{title:'成本项目名称', name:'costItemName', width: 90, align: 'center', renderer: initCostItemName},
			{title:'成本项目金额', name:'costItemAmount', width: 90, align: 'center', renderer: initCostItemAmount}];*/
			

//我方文件(即接收我方的文件)：sale_receive_enquiry_file  对方文件(即接收对方的文件)：purchase_receive_enquiry_file
var file_cols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryBargainFile"/>;
/*var file_cols = [
      { title:'文件来源', name:'FBK2' , width:60, align:'center'},
      { title:'文件名称', name:'fileName' , width:100, align:'center'},
      { title:'文件类型', name:'fileType', width:60, align:'center', hidden:true},
      { title:'供应商编码', name:'toElsAccount' ,width:80, align:'center'},
      { title:'供应商', name:'toCompanyName' ,width:90, align:'center'},
      { title:'物料编码', name:'purchaseMaterialNumber' ,width:80, align:'center'},
      { title:'物料描述', name:'purchaseMaterialDesc' ,width:100, align:'center'},
      { title:'日期', name:'logtime', width:80, align:'center', hidden:true, renderer: formatDate},
      { title:'说明', name:'remark', width:60, align:'center', hidden:true}];*/
  
  
//初始化控件
function init() {

    //头表purchase_enquiry_header(即purchase_set_enquiry_header)
    var headParam = {
    	'elsAccount':currentElsAccount,
    	'purchaseEnquiryNumber':purchaseEnquiryNumber
    };
	
    //加载头
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryOtherService/queryEnquiryHeadByCondtion' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(headParam),
		dataType : "json",
		success : function(data) {
			$("#purchaseEnquiryNumber").text(data.purchaseEnquiryNumber);
			var beginDate = data.beginDate;
			if (beginDate!=null&&beginDate.length!=10)
        		beginDate = new Date(beginDate).format("yyyy-MM-dd");
        	var endDate = data.endDate;
        	if (endDate!=null&&endDate.length!=10)
        		endDate = new Date(endDate).format("yyyy-MM-dd");
			$("#beginDate").text(beginDate);
			$("#endDate").text(endDate);
			
			var orderTypeName="错误询价";
			if(data.orderType==0)
				orderTypeName='<i18n:I18n key="i18n_enquiry_select_enquirytype_market" defaultValue="行情询价" />';
			else if(data.orderType==1)
				orderTypeName='<i18n:I18n key="i18n_enquiry_select_enquirytype_material" defaultValue="物料询价" />';
			else if(data.orderType==2)
				orderTypeName='<i18n:I18n key="i18n_enquiry_select_enquirytype_texture" defaultValue="材质询价" />';
			$("#orderType").text(orderTypeName);
			
			//最后刷新时间  @author jiangzhidong @date 20160401
			var logtime = new Date().format("yyyy-MM-dd hh:mm:ss");
			$("#refurbish").text(logtime);
			
			//审批控制
			var entryBtn = $("#entryBtn");
			var cancelEntryBtn = $("#cancelEntryBtn");
			var flowBtn = $("#flowBtn");
			if(data.headAudit=='Y'){
				initAudit(data.flowCode, data.auditStatus);
				entryBtn.text("头"+entryBtn.text());
				cancelEntryBtn.text("头"+cancelEntryBtn.text());
				flowBtn.text("头"+flowBtn.text());
			}else{
				initAudit("N", "N");
				entryBtn.text("行"+entryBtn.text());
				cancelEntryBtn.text("行"+cancelEntryBtn.text());
				flowBtn.text("行"+flowBtn.text());
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});

    //物料表purchase_enquiry_material
    var materialParam = {
    	'elsAccount':currentElsAccount,
    	'elsSubAccount':elsSubAccount,
    	'purchaseEnquiryNumber':'<%=purchaseEnquiryNumber%>'
    };
    
    //加载物料
    materialGrid = $('#table-materialItem').mmGrid({
        cols: material_cols,
        height: 150,
        url: '<%=basePath%>rest/PurchaseEnquiryOtherService/queryMaterialByCondtion',
        params: materialParam,
        method: 'POST',
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol: true,
        multiSelect: true
    });
   
    materialGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	rowIndexSelect=rowIndex;
    	loadItem();
    });
    
    materialGrid.on('loadSuccess',function(e, data) {
		if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			materialGrid.select(rowIndexSelect);
			loadItem();
		}else{
    	    itemGrid = $('#table-item').mmGrid({
    	        cols: item_cols,
    	        items: []
    	    });
		}
    });
    
    //全选事件-物料
    $('#materialTotal').find('.mmg-head .checkAll').bind('click',function() {
    	if($(this).attr('checked')) {
    		materialGrid.select('all');
    		loadItem();
    	} else {
    		materialGrid.deselect('all');
    		loadItem();
    	}
    });
    
    //全选事件-行
    $('#reCreate').find('.mmg-head .checkAll').bind('click',function() {
    	if($(this).attr('checked')) {
    		itemGrid.select('all');
    		initAudit(null, "N");
    	} else {
    		itemGrid.deselect('all');
    		initAudit("N", "N");
    	}
    });
   
    //查看历史报价纪录
    $('.col-price-his').live("click", function() {
        var scanCol = $(this).next().text();
        var item = JSON.parse(scanCol);
        parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'purchaseBargainHisManage',
            'windowTitle':'查看历史报价记录',
            windowSubTitle: '报价记录',
            'iframSrc':'<%=basePath%>enquirymanage/purchase/purchaseBargainHisManage.jsp',
            data:item,
            windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
        });
    });
    
    //加载:物料编号-物料描述
    var tab=$( "#sheet-project").tabs();
    $('.scan-file-sheet').click(function() {
    	$('#selectFileType').empty();
     	$('#selectFileType').append('<option value=0><i18n:I18n key="i18n_common_select_filetype_all" defaultValue="所有文件" /></option>');
 		$('#selectFileType').append('<option value=1><i18n:I18n key="i18n_common_select_filetype_public" defaultValue="公共文件" /></option>');
     	var materialRows = materialGrid.rows();
     	for(var i= 0; i<=materialRows.length-1; i++) {
     		var selVal = materialRows[i].materialNumber+'-'+materialRows[i].materialDesc;
     		$('#selectFileType').append('<option value='+selVal+'>'+selVal+'</option>');
     	}
     	loadFile();
    })
    //我方的文件  对方的文件
    $('#selectPurchaseSale').change(function(){
    	loadFile();
    })
     //所有文件  公共文件  物料文件
     $('#selectFileType').change(function(){
     	loadFile();
    })
}

//审批控制
var initAudit = function (flowCode, auditStatus){
	if ((flowCode == "" || flowCode == null || flowCode == 00) ) {
		$("#entryBtn").show();
		$("#cancelEntryBtn").hide();
// 		$("#flowBtn").hide();
	}else {
		if (auditStatus == "0" || auditStatus == "N"){
			$("#entryBtn").hide() ;
			$("#cancelEntryBtn").hide() ;
// 			$("#flowBtn").hide() ;
		}else{
			$("#entryBtn").hide() ;
			$("#cancelEntryBtn").show() ;
			$("#flowBtn").show() ;
		}
	} 	
};
 
//刷新 @author jiangzhidong @date 20160401
$("#refurbish").click(function(){
	query();
});      
      
//加载物料
function query() {
  	var materialParam = {
      	'elsAccount':currentElsAccount,
      	'elsSubAccount':elsSubAccount,
      	'purchaseEnquiryNumber':'<%=purchaseEnquiryNumber%>'
      };
  	materialGrid.opts.params = materialParam;
  	materialGrid.select(rowIndexSelect);
  	materialGrid.load({});
    //最后刷新时间  @author jiangzhidong @date 20160401
	var logtime = new Date().format("yyyy-MM-dd hh:mm:ss");
	$("#refurbish").text(logtime);
}
 	
//行表purchase_enquiry_item  阶梯表purchase_enquiry_ladder_price  成本表purchase_receive_enquiry_cost_constitute
itemGrid = $('#table-item').mmGrid({
			        cols: item_cols,
			        height: 300,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        checkCol: true,
			        multiSelect: true
			    }).on('loadSuccess',itemGridLoadSuccess);
			    
itemGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
	var itemRows = itemGrid.selectedRows();
	if(itemRows.length>0){
		initAudit(itemRows[0].flowCode, itemRows[0].auditStatus);
	}else{
		initAudit("N", "N");
	}
});
	
var selsIndex = [];
//加载行
function loadItem() {
	    var material = materialGrid.selectedRows();
	    selsIndex = itemGrid.selectedRowsIndex();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/queryEnquiryItemsByCondtion' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(material),
			dataType : "json",
			success : function(data) {
				itemGrid.load(data.rows);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
			}
		});
		 
}

//我方文件(即接收我方的文件)：sale_receive_enquiry_file  对方文件(即接收对方的文件)：purchase_receive_enquiry_file
function loadFile() {
    var items = itemGrid.rows();
    var toElsAccounts = '';
 	for(var i= 0; i<=items.length-1; i++) {
 		var tmp = items[i].toElsAccount;
 		if (i==0) 
 			toElsAccounts = tmp;
 		else {
 			if(toElsAccounts.indexOf(tmp)==-1)
 			toElsAccounts = toElsAccounts+'-'+tmp;
 		}
 	}
    
    //文件参数
    var sft = $('#selectFileType').val().split("-");
	var sps = $('#selectPurchaseSale').val();
	var fileParam = {
		'elsAccount':currentElsAccount,
		'elsSubAccount':elsSubAccount,
		'purchaseEnquiryNumber':'<%=purchaseEnquiryNumber%>',
		'purchaseMaterialNumber':sft[0],
      	'purchaseMaterialDesc':sft[1],
      	'FBK1':sps,
      	'FBK3':toElsAccounts
	};
     
	if(!editFileTable){
		editFileTable=$('#add-file-project').mmGrid({
		    cols: file_cols,
		    url: '<%=basePath%>rest/PurchaseEnquiryBargainService/queryReceiveEnquiryFileByCondtion',
		    params: fileParam,
		    method: 'post',
		    checkCol: true,
		    root: 'rows',
		    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        fullWidthRows:true,
		    indexCol: false,
		    plugins: [
	              $('#enquiryFilePage').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
	                  , limit: null
	                  , limitList: [5,10,15,20]
	              })
	          ]
		});
	} else {
		editFileTable.load(fileParam);
	}
	
	//刷新
	$("#flushFileBtn").click(function() {
		editFileTable.load({});
	})
	
	//下载文件
	$("#downFileBtn").click(function(){
		var item = editFileTable.selectedRows();
		if(item.length > 0)
		{
	    	var filepath = item[0].filePath;
	    	var fileName = item[0].fileName;
	    	fileName = encodeURIComponent(encodeURIComponent(fileName));
	    	window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filepath+"&fileName="+fileName;
		}else
		{
			alert('<i18n:I18n key="" defaultValue="请选择要下载的文件"/>',2);
		}
	});
	
	 //---------------文件展示----begin------------------
    editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
//   		previewFile(filePath);
  	});
  	
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
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : message});
					}
				},
				error : function(data) {
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
				}
			});
    	} else {
    		parent.elsDeskTop.tip.init({type: 'alert',displayType: 3, message: '<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型!" />'});
    	}
    }
      //---------------文件展示----end------------------
	
}

//支持多个策略  begin  @jiangzhidong @date 20160428
function showStretegySelector(stretegyList) {
	$(".dialog-tip").height(40);
	var html = "";
	for (var i=0;i<stretegyList.length;i++){
		html += "<option value='"+stretegyList[i].stretegyCode+"'>"+stretegyList[i].stretegyName+"</option>";
	}
	$("#stretegySelctor").empty().html(html);
	$('#dialog2').show();
	$("#btnFileOK2").unbind("click").click(function(){
		$("#stretegyCode").val($("#stretegySelctor").val());
		$("#sendMsgBtnOK").click();
	});
}
$('.dialog-close-btn').click(function(){
    $('.fixed-dialog').hide();
});
$('.tip-option-btn').click(function(){
    $('.dialog-close-btn').trigger('click');
});
//支持多个策略 end @jiangzhidong @date 20160428

//比价
$("#parityBtn").click(function(){
	var itemRows = itemGrid.selectedRows();
	for(var i=0;i<itemRows.length;i++){
		var quoteMethod = itemRows[i].quoteMethod;
		if(quoteMethod==1){
			alert("存在阶梯报价不能比价",1);
			return;
		}
	}
    var Param = {
        	'elsAccount':currentElsAccount,
        	'purchaseEnquiryNumber':purchaseEnquiryNumber
        };
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/PurchaseEnquiryBargainService/purchaserice",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(Param),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + data.message;
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
<%-- 	window.location.href = "<%=basePath%>rest/PurchaseEnquiryBargainService/purchaserice/"+ elsAccount + "/" + purchaseEnquiryNumber; --%>
});


</script>

</body>
</html>