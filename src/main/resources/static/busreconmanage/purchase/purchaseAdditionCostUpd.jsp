<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>

<body>
  <div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="操作" key="i18n_enquiry_title_operation"/></span>
    <div class="common-box-line">
        <button class="button-wrap" id="saveBtn"><i18n:I18n defaultValue="保存" key="i18n_button_save"/></button>
        <button class="button-wrap" id="saveSendBtn"><i18n:I18n defaultValue="保存发送" key="i18n_common_button_saveSend"/></button>
        <button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
    </div>
</div>
<form id="purchaseAdditionCostForm" onsubmit="return false;">
<div class="box-wrap pos-relative bg-common">
	 <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本信息" key="i18n_common_title_baseinformation"/></span>
	 <div class="common-box-line">
	     <div class="dis-in-b input-and-tip">
			<table>
				<tr>
					<td><i18n:I18n defaultValue="费用单号" key="i18n_label_additionCost_additionCostNumber"/>：</td>
					<td><input type="text" id="additionCostNumber" name="additionCostNumber" readonly="readonly" /></td>
					<td><i18n:I18n defaultValue="费用单描述" key="i18n_label_additionCost_additionCostDesc"/>：</td>
					<td><input type="text" id="additionCostDesc" name="additionCostDesc" width="200px;" /></td>
					<td><i18n:I18n defaultValue="费用日期" key="i18n_label_additionCost_costDate"/>：</td>
					<td><input type="text" id="costDate" name="costDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" /></td>
					<td><i18n:I18n defaultValue="货币" key="i18n_label_currency"/>：</td>
					<td><input type="text" id="currency" name="currency" /></td>
				</tr>
				<tr>
					<td><i18n:I18n defaultValue="附加费用合计金额" key="i18n_additionCost_totalAmount"/>：</td>
					<td><input type="text" id="totalAmount" name="totalAmount" readonly="readonly" /></td>
					<td>对方ELS号：</td>
					<td>
						<input type="text" id="toElsAccount" name="toElsAccount" />
						<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 20px; height: 20px;" id="queryToElsAccount" />
					</td>
					<td>对方ELS描述：</td>
					<td><input type="text" id="toElsDesc" name="toElsDesc" /></td>
					<td>本方负责人：</td>
					<td>
						<input type="hidden" id="additionCostType" name="additionCostType" value="ded">
						<input type="text" id="person" name="person" />
						<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 20px; height: 20px;" id="queryPerson" />
					</td>
				</tr>
			</table>
		 </div>
	 </div>
</div>

<div class="tab-wrap tab-wrap-change" id="add-enq-sheet">
    <ul>
        <li><a href="#edit-line-one"><i18n:I18n defaultValue="订单行项目" key="i18n_delivery_lable_orderitems"/></a></li>
        <li class="add-file-sheet"><a href="#edit-line-two"><i18n:I18n defaultValue="表单文件" key="i18n_enquiry_title_formfile"/></a></li>
    </ul>
    <div class="p-zero" id="edit-line-one" style="padding: 1px;">
        <main class="bg-common p-6">
            <div class="edit-box-wrap">
                <button id="queryPurchaseOrder" class="button-wrap"><i18n:I18n defaultValue="选择订单" key="i18n_enquiry_SelectTheOrder"/></button>
                <button id="itemDelBtn" class="button-wrap"><i18n:I18n defaultValue="移除" key="i18n_common_button_remove"/></button>
                <button id="btnManuAdd" class="button-wrap"><i18n:I18n defaultValue="直接添加" key="i18n_coststructure_button_customadd"/></button>
            </div>
            <div class="grid-100" id="reCreate">
                <table id="itemTable"></table>
            </div>
        </main>
    </div>
    <div class="p-zero" id="edit-line-two" style="padding: 1px;">
	          <div class="common-box-line p-zero">
	              <div class="pos-relative upload-wrap">
	                  <div class="pos-absolute file-list">
					<div class="file-list-head" id="file-list-head"><span><i18n:I18n defaultValue="文件类型" key="i18n_common_label_filetype"/></span>
	                      <select class="" id="selectFileType" name="selectFileType" onchange="selectFileTypeChange();" >
		                   <option value="all"><i18n:I18n defaultValue="所有文件" key="i18n_common_select_filetype_all"/></option>
		                   <option value="common"><i18n:I18n defaultValue="公共文件" key="i18n_common_select_filetype_public"/></option>
	                   </select>
	                 </div>
					<main class="grid-container">
						<div class="grid-100" id="reCreateFile">
							<table id="fileTable"></table>
						</div>
					</main>
	                  </div>
	                <div class="file-scan">
								<div class="file-option-zoom">
	                  <div class="dis-in-b text-left">
			             <button id="addFileBtn" class="button-wrap"><i18n:I18n defaultValue="添加" key="i18n_common_button_addition"/>...</button>
	                                 <button id="deleteFileBtn" class="button-wrap"><i18n:I18n defaultValue="移除" key="i18n_common_button_remove"/></button>
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
</form>

<div class="fixed-dialog" id="addFileDialog">
	<div class="dialog-tip bg-common" style="width: 262px;height: auto; margin-left: -131px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="dialogFileClose"></div>
	    <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_title_chooseformfile"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
	               <div class="common-box-line">
	                   <div class="input-and-tip"><span><i18n:I18n defaultValue="文件名称" key="i18n_common_label_filename"/>：</span><input id="fileName" name="fileName" type="text" /></div>
	                <div class="input-and-tip"><span><i18n:I18n defaultValue="文件路径" key="i18n_common_label_filepath"/>：</span><input id="filePath" name="filePath" type="text" /></div>
	                <div class="input-and-tip text-right">
	                 <div id="btnFileUpload" class="btn btnUpload"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_button_chooseformfile"/></div>
	                 <input id="fileType" name="fileType" type="hidden" />
	                </div>
	                <div class="mt-20 text-center">
	                   <button id="addFileBtnOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                <button id="addFileBtnCancel" class="button-wrap "><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
	               </div>
	           </div>
	       </div>
	</div>
</div>
     
<div class="fixed-dialog" id="selectPrincipalDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectPrincipalDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectPrincipalDialog"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="select-principal-table"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="btnSelectPrincipalOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="btnSelectPrincipalCancel" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>

<div class="fixed-dialog" id="selectFriendElsAccountDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectFriendElsAccountDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectFriendElsAccountTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectFriendOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectFriendCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>

<div class="fixed-dialog" id="additionCostManuAdd" >
	<div class="dialog-tip bg-common" style="width: 502px;height: 340px;margin-left: -251px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="btnManuClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="附加费信息" key=""/></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="输入附加费信息" key=""/></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="费用金额" key="i18n_additionCost_additionCostAmount"/>:</td>
	                		<td><input class="easyui-textbox" type="text" id="manuAdditionCostAmount" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="费用类型" key="i18n_additionCost_costType"/>:</td>
	                		<td><input class="easyui-textbox" type="text" id="manuCostType" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="费用说明" key="i18n_additionCost_costDescription"/>:</td>
	                		<td>
								<textarea id="manuRemark" cols="200" rows="5"></textarea>
							</td>
	                	</tr>
	                </table>
	            </div>
	            <div class="mt-40 text-center" >
	                <button id="btnManuAddOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                <button id="btnManuAddCancel" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	            </div>
	        </div>
    </div>
</div>

<div class="fixed-dialog" id="queryPurchaseOrderDialog" >
	<div class="dialog-tip bg-common" style="width: 830px;height: 533px;margin-left: -415px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="queryPurchaseOrderDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="queryPurchaseOrderDialogTitle"><i18n:I18n defaultValue="采购方订单查询" key="i18n_additionCost_purchaseOrderInquiry"/></span>
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查询条件" key="i18n_additionCost_queryCondition"/></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td  class="tb-p"><i18n:I18n defaultValue="采购单号" key="i18n_enquiry_title_purchaseordernumber"/>:</td>
	                		<td><input class="easyui-textbox" style="width: 100px;" type="text" id="purchaseOrderNumber" /></td>
	                		<td  class="tb-p"><i18n:I18n defaultValue="订单日期" key="i18n_label_orderdate"/>:</td>
	                		<td><input class="Wdate" onfocus="WdatePicker({startDate:'%y',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endOrderDate\')}'})" style="width: 100px;" type="text" id="startOrderDate" /></td>
	                		<td  class="tb-p"><i18n:I18n defaultValue="至" key="i18n_additionCost_to"/>:</td>
	                		<td><input class="Wdate" onfocus="WdatePicker({startDate:'%y',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startOrderDate\')}'})" style="width: 100px;" type="text" id="endOrderDate" /></td>
							<td><button id="queryPurchaseOrderBtn" class="button-wrap "><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="queryPurchaseOrderTable"></table>
                    </div>
                    <div class="mt-20 text-right" >
	                    <button id="queryPurchaseOrderDialogOkBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="queryPurchaseOrderDialogCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<script type="text/javascript">
var elsAccount = "${elsAccount}";
var elsDesc = "${companyShortName}";
var elsSubAccount = "${elsSubAccount}";
var userName = "${username}";

var fileUploader;
var currShowFile = "";

//列
var itemCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostAddItem_mt"/>;
var itemGrid = $('#itemTable').mmGrid({
    cols : itemCols,
    height:<base:tableHeight tableCode="saleAdditionCostAddItem_mt"/>,
    url : "${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/queryPurchaseAdditionItem",
    method : 'post',
    autoLoad : false,
    fullWidthRows : true,
    root:"rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    multiSelect : true,
    checkCol : true,
    indexCol : false
});
//列
var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostAddFile_mt"/>;
var fileGrid = $('#fileTable').mmGrid({
    cols : fileCols,
    height:<base:tableHeight tableCode="saleAdditionCostAddFile_mt"/>,
    url : "${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/queryPurchaseAdditionFile",
    method : 'post',
    autoLoad : false,
    root:"rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    multiSelect : false,
    checkCol : true,
    indexCol : false
});

$(document).ready(function(){
    //初始化控件
    $('button').button();
    $('#add-enq-sheet').tabs();
    $('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'});
    $('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'});
    
    //$("#person").val(elsSubAccount+"_"+userName);
    var currDate = new Date();
    //$("#costDate").val(currDate.format('yyyyMM'));
    //$("#currency").val("CNY");//默认人民币
    
    var startOrderDate = new Date();
    var currDateMill = startOrderDate.getTime();
    startOrderDate.setMonth(startOrderDate.getMonth()+1, 0);//本月最后一日
    var currMonthMaxDay = startOrderDate.getDate();
    startOrderDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
    $("#startOrderDate").val(startOrderDate.format('yyyy-MM-dd'));
    $("#endOrderDate").val(currDate.format('yyyy-MM-dd'));
	
    initData();
});
	function initData(){
		var elsAccount = "${param.elsAccount}";
		var toElsAccount = "${param.toElsAccount}";
		var additionCostType = "${param.additionCostType}";
		var additionCostNumber = "${param.additionCostNumber}";
		
		var queryParam = {elsAccount : elsAccount,
				toElsAccount : toElsAccount,
				additionCostType : additionCostType,
				additionCostNumber : additionCostNumber};
		
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/queryPurchaseAdditionCostHead",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(queryParam),
			dataType : "json",
			success : function(data, textStatus, jqXHR){
				var rows = data.rows;
				if("undefined" !=  rows && rows.length > 0){
					var head = rows[0];
					$("#additionCostNumber").val(head.additionCostNumber);
					$("#additionCostDesc").val(head.additionCostDesc);
					var costDate = new Date();
					costDate.setTime(head.costDate);
					$("#costDate").val(costDate.format("yyyy-MM-dd"));
					$("#currency").val(head.currency);
					$("#totalAmount").val(head.totalAmount);
					$("#toElsAccount").val(head.toElsAccount);
					$("#toElsDesc").val(head.toElsDesc);
					$("#additionCostType").val(head.additionCostType);
					$("#person").val(head.person);
					
					//$.extend(itemGrid.opts.params,queryParam);
					itemGrid.load(queryParam);
					//$.extend(fileGrid.opts.params,queryParam);
					fileGrid.load(queryParam);
				} else {
					alert("<i18n:I18n defaultValue='费用单信息查询异常!' key='i18n_label_additionCost_additionCostInfoQueryException'/>");
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown){
				alert(errorThrown);
			}
		});
	}
	
	itemGrid.on("loadSuccess",function(e, data){
		reGenFileTypeSelect();
	});
	
	fileGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
		var filePath = item.filePath;
		if(currShowFile == filePath){//如果选中的为当前显示文件则不做其他操作
		} else {//如果选中的不是当前显示文件则重新刷新右侧显示文件
			currShowFile = filePath;
			previewFile(filePath);
		}
	});
	
	//==========================================
	$("#btnManuAdd").click(function(){
		clearManuAddInfo();
		$("#additionCostManuAdd").show();
	});
	
	$("#btnManuAddOK").click(function(){
		migrationAdditionManuAddInfo(itemGrid);
	});
	
	$("#btnManuAddCancel").click(function(){
		$("#additionCostManuAdd").hide();
		clearManuAddInfo();
	});
	
	$("#btnManuClose").click(function(){
		$("#additionCostManuAdd").hide();
		clearManuAddInfo();
	});
	
	$("#itemDelBtn").click(function(){
		var selectedIndexes = itemGrid.selectedRowsIndex();
		for(var i = selectedIndexes.length ; i-1 >= 0 ; i--){
			var index = selectedIndexes[i-1];
			var additionCostItemNumber = itemGrid.row(index).additionCostItemNumber;
			$("#selectFileType option[value='"+additionCostItemNumber+"']").remove();//删除文件下拉列表相应的选项
			//删除文件列表数据中属于该行项目的文件行
			removeFileRowByItemNumber(additionCostItemNumber)
			
			itemGrid.removeRow(index);//删除item选中行
		}
		reGenerateItemNumber();
		calcTotalAmount();//重算总额
	});
	 
	//单击添加表单文件事件
	$('#addFileBtn').click(function() {
		clearAddFileInfo();
		$("#addFileDialog").show();
		initFileUploader(fileUploader);
	});
	 
	$("#addFileBtnOK").click(function(){
		$("#addFileDialog").hide();
		var filePath = $("#filePath").val();
		if(filePath == ""){
			alert("<i18n:I18n defaultValue='请选择上传文件！' key='i18n_please_select_a_file_to_upload'/>",1);
			return false;
		}
		addFileTableRow();
		clearAddFileInfo();
		//$( '#add-enq-sheet').tabs({active:1});//tab切换
		//预览文件内容
		previewFile(filePath);
	});
	 
	//添加文件弹出框取消按钮
	$("#addFileBtnCancel").click(function(){
		$("#addFileDialog").hide();
		clearAddFileInfo();
	});
	
	//关闭按钮处理
	$("#dialogFileClose").click(function(){
		$("#addFileDialog").hide();
		clearAddFileInfo();
	});
	 
	 //删除选择文件行事件
	 $("#deleteFileBtn").click(function(){
	     var selectedIndexes = fileGrid.selectedRowsIndex();
	     var selectedRows = fileGrid.selectedRows();
	     fileGrid.removeRow(selectedIndexes);
	     
	     reGenerateFileSequence();//删除文件行后,重新生成文件序号
	 });
	//----------添加附件相关-----------end--------------------
	
	//提交保存数据
	$("#saveBtn").click(function(){
		var additionCostNumber = $("#additionCostNumber").val();
	   	var additionCostDesc = $("#additionCostDesc").val();
	   	var costDate = $("#costDate").val();
	   	
	   	calcTotalAmount();
	   	var totalAmount = $("#totalAmount").val();
	   	var toElsAccount = $("#toElsAccount").val();
	   	var toElsDesc = $("#toElsDesc").val();
	   	var additionCostType = $("#additionCostType").val();
	   	var person = $("#person").val();
	   	var currency = $("#currency").val();
	   	
	   	if("undefined"==typeof(costDate) || "" == costDate){
	   		alert("<i18n:I18n defaultValue='请选择费用日期' key='i18n_label_additionCost_pleaseSelectCostDate'/>",3);
	   		return;
	   	}
	   	
	   	if("undefined"==typeof(toElsAccount) || "" == toElsAccount){
	   		alert("<i18n:I18n defaultValue='请选择对方ELS' key='i18n_label_additionCost_pleaseSelectToElsAccounts'/>",3);
	   		return;
	   	}
	   	
	   	if("undefined"==typeof(currency) || "" == currency){
	   		alert("<i18n:I18n defaultValue='请选择币种' key='i18n_label_pleaseSelectCurrencyType'/>",3);
	   		return;
	   	}
	   	
	   	var purchaseAdditionCostHead = {
	   			elsAccount : elsAccount,
	   			elsDesc : elsDesc,
	   			toElsAccount : toElsAccount,
	   			toElsDesc : toElsDesc,
	   			additionCostNumber : additionCostNumber,
	   			additionCostDesc : additionCostDesc,
	   			additionCostType : additionCostType,
	   			costDate : costDate,
	   			totalAmount : totalAmount,
	   			currency : currency,
	   			maker : userName,
	   			person : person,
	   	};
	   	
	   	var purchaseAdditionCostItem = itemGrid.rows();
	   	for(var i=0;i<purchaseAdditionCostItem.length;i++){
	   		if(isNaN(purchaseAdditionCostItem[i].additionCostAmount)){
	   			alert("<i18n:I18n defaultValue='金额非数字类型，不能保存' key=''/>",2);
		   		return;
	   		}
	   		if(purchaseAdditionCostItem[i].additionCostAmount <= 0 ){
	   			alert("<i18n:I18n defaultValue='金额不能小于0' key=''/>",2);
		   		return;
	   		}
	   		purchaseAdditionCostItem[i]["toElsAccount"] = toElsAccount;
	   		purchaseAdditionCostItem[i]["currency"] = currency;
	   	}
	   	
	   	var purchaseAdditionCostFile = [];
	   	if(fileGrid && fileGrid.rowsLength()){
	       	purchaseAdditionCostFile = fileGrid.rows();
	       	for(var i=0;i<purchaseAdditionCostFile.length;i++){
	       		purchaseAdditionCostFile[i]["toElsAccount"] = toElsAccount;
	       		purchaseAdditionCostFile[i]["currency"] = currency;
	       		purchaseAdditionCostFile[i]["fileSequence"] = i+1;
	       	}
	   	}
	   	
	   	
	   	var data = {
	   			purchaseAdditionCostHead : JSON.stringify(purchaseAdditionCostHead),
	   			purchaseAdditionCostItem : JSON.stringify(purchaseAdditionCostItem),
	   			purchaseAdditionCostFile : JSON.stringify(purchaseAdditionCostFile),
	   	}
	   	
	   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='费用单保存中！' key='i18n_label_additionCost_additionCostIsSaved'/>");
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/updPurchaseAdditionCost",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存成功！' key='i18n_common_alert_savesuccess'/>",1);
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_returnParentPage" defaultValue="是否返回上级页面？" />',closeEvent:function(){	
					parent.elsDeskTop.closeCurWin('purchaseAdditionCostUpd',callBack);
				}});
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存出错！' key='i18n_common_alert_saveError'/>");
			}
		});
	    	
	});
	
	//提交保存数据并发送
	$("#saveSendBtn").click(function(){
		var additionCostNumber = $("#additionCostNumber").val();
	   	var additionCostDesc = $("#additionCostDesc").val();
	   	var costDate = $("#costDate").val();
	   	
	   	calcTotalAmount();//提交前重新计算一次总费用
	   	var totalAmount = $("#totalAmount").val();
	   	var toElsAccount = $("#toElsAccount").val();
	   	var toElsDesc = $("#toElsDesc").val();
	   	var additionCostType = $("#additionCostType").val();
	   	var person = $("#person").val();
	   	var currency = $("#currency").val();
	   	
	   	if("undefined"==typeof(costDate) || "" == costDate){
	   		alert("<i18n:I18n defaultValue='请选择费用日期' key='i18n_label_additionCost_pleaseSelectCostDate'/>",3);
	   		return;
	   	}
	   	
	   	if("undefined"==typeof(toElsAccount) || "" == toElsAccount){
	   		alert("<i18n:I18n defaultValue='请选择对方ELS' key='i18n_label_additionCost_pleaseSelectToElsAccounts'/>",3);
	   		return;
	   	}
	   	
	   	if("undefined"==typeof(currency) || "" == currency){
	   		alert("<i18n:I18n defaultValue='请选择币种' key='i18n_label_pleaseSelectCurrencyType'/>",3);
	   		return;
	   	}
	   	
	   	var purchaseAdditionCostHead = {
	   			elsAccount : elsAccount,
	   			elsDesc : elsDesc,
	   			toElsAccount : toElsAccount,
	   			toElsDesc : toElsDesc,
	   			additionCostNumber : additionCostNumber,
	   			additionCostDesc : additionCostDesc,
	   			additionCostType : additionCostType,
	   			costDate : costDate,
	   			totalAmount : totalAmount,
	   			currency : currency,
	   			maker : userName,
	   			person : person,
	   	};
	   	
	   	var purchaseAdditionCostItem = itemGrid.rows();
	   	for(var i=0;i<purchaseAdditionCostItem.length;i++){
	   		if(isNaN(purchaseAdditionCostItem[i].additionCostAmount)){
	   			alert("<i18n:I18n defaultValue='金额非数字类型，不能保存' key=''/>",2);
		   		return;
	   		}
	   		if(purchaseAdditionCostItem[i].additionCostAmount <= 0 ){
	   			alert("<i18n:I18n defaultValue='金额不能小于0' key=''/>",2);
		   		return;
	   		}
	   		purchaseAdditionCostItem[i]["toElsAccount"] = toElsAccount;
	   		purchaseAdditionCostItem[i]["currency"] = currency;
	   	}
	   	
	   	var purchaseAdditionCostFile = [];
	   	if(fileGrid && fileGrid.rowsLength()){
	       	purchaseAdditionCostFile = fileGrid.rows();
	       	for(var i=0;i<purchaseAdditionCostFile.length;i++){
	       		purchaseAdditionCostFile[i]["toElsAccount"] = toElsAccount;
	       		purchaseAdditionCostFile[i]["currency"] = currency;
	       		purchaseAdditionCostFile[i]["fileSequence"] = i+1;
	       	}
	   	}
	   	
	   	var data = {
	   			operate : "saveSend",
	   			purchaseAdditionCostHead : JSON.stringify(purchaseAdditionCostHead),
	   			purchaseAdditionCostItem : JSON.stringify(purchaseAdditionCostItem),
	   			purchaseAdditionCostFile : JSON.stringify(purchaseAdditionCostFile),
	   	}
	   	
	   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='费用单保存发布中！' key='i18n_label_additionCost_additionCostIsSaveSend'/>");
	  	 $.ajax({
				url :"${pageContext.request.contextPath}/rest/PurchaseAdditionCostService/sendPurchaseAdditionCost",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='保存发布！' key='i18n_label_additionCost_keepSending'/>",1);
					parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_returnParentPage" defaultValue="是否返回上级页面？" />',closeEvent:function(){
						parent.elsDeskTop.closeCurWin('purchaseAdditionCostUpd',callBack);
					}});
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='保存发布出错！' key='i18n_label_additionCost_keepSendingError'/>");
				}
			});
		
	});
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
	function callBack(){
		if(parent.frames['iframeApp_purchaseAdditionCostManage']) {
			parent.frames['iframeApp_purchaseAdditionCostManage'].init();
		}
	} 
	
	//选择负责人相关-----------------begin---------------
	var colsPrincipal = [
		                { title:"<i18n:I18n defaultValue='用户编码' key='i18n_common_label_userCode'/>", name:'elsSubAccount' , width:60, align:'center'},
		                { title:"<i18n:I18n defaultValue='用户名称' key='i18n_common_label_userName'/>", name:'name' , width:60, align:'center'}
		            ];
	
	var selectPrincipalTable=$('#select-principal-table').mmGrid({
	    cols: colsPrincipal,
	    url: "${pageContext.request.contextPath}/rest/AccountService/subAccountList",
	    params: {"elsAccount":elsAccount},
	    method: 'post',
	    root: 'rows',
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect: true,
	    checkCol: true,
	    indexCol:true
	});
	
	//触发本方负责人查询弹出框事件
	$("#queryPerson").click(function(){
		var principal = $("#person").val();
		var principalArray = principal.split(";");//根据“;”获取以选择的负责人数组
		var totalRows = selectPrincipalTable.rows();
		if(totalRows != "" &&totalRows != null && principalArray){
			for(var i = 0 ; i < totalRows.length ; i ++){
				for(var j = 0 ; j < principalArray.length ; j ++ ){
					var elsSubAccount = totalRows[i].elsSubAccount;
					var uname = totalRows[i].name;
					var _principal = principalArray[j];
					var _principalArray = _principal.split("_");
					var _elsSubAccount = _principalArray[0];
					var _name = _principalArray[1];
					if(elsSubAccount == _elsSubAccount && uname == _name){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
						selectPrincipalTable.select(i);
						continue;
					}
				}
			}
		}
		$("#selectPrincipalDialog").show();
	});
	
	//选择本方负责人弹出框确认按钮单击事件
	$("#btnSelectPrincipalOK").click(function(){
		var selectedRows = selectPrincipalTable.selectedRows();
		var principals ="";
		if(selectedRows != "" ){
			for(var i = 0 ; i < selectedRows.length ; i ++){
				var singleRow = selectedRows[i];
				var elsSubAaccount = singleRow.elsSubAccount;
				var uname = singleRow.name;
				if(i == 0){
					principals += elsSubAaccount+"_"+uname;
				}else{
				    principals += ";"+elsSubAaccount+"_"+uname;
				}
			}
		}else{
			alert("<i18n:I18n defaultValue='至少选择一条记录！' key='i18n_common_title_selectAtLeastOneRecord'/>");
			return;
		}
		$("#person").val(principals);
		$("#selectPrincipalDialog").hide();
	});
	
	$("#btnSelectPrincipalDialogClose").click(function(){
		$("#selectPrincipalDialog").hide();
	});
	
	$("#btnSelectPrincipalCancel").click(function(){
		$("#selectPrincipalDialog").hide();
	});
	//选择负责人相关-----------------end---------------
	
	//查询对方ELS信息(只在好友列表中查询)
	var toElsCols = [
	        { title:"<i18n:I18n defaultValue='对方ELS编码' key='i18n_label_additionCost_toElsAccountCode'/>", name:'friendElsAccount' , width:100, align:'center'},
	        { title:"<i18n:I18n defaultValue='对方ELS名称' key='i18n_label_additionCost_toElsAccountName'/>", name:'friendCompanyName' , width:100, align:'center'}
	    ];
	
	var toElsTable = $('#selectFriendElsAccountTable').mmGrid({
	                cols : toElsCols,
	                url : "${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsAndGroups",
	                params : {
	                	"elsAccount" : elsAccount,
	                	"elsSubAccount" : elsSubAccount,
	                	"pageSize" : 1000,
	                },
	                method : "post",
	                root : "rows",
	                loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	                noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	                multiSelect : false,
	                checkCol : true,
	                indexCol :false
	 });
	
	//触发本方负责人查询弹出框事件
	$("#queryToElsAccount").click(function(){
		var selectToElsAccount = $("#toElsAccount").val();
		var totalRows = toElsTable.rows();
		if(totalRows != null && totalRows != "" && selectToElsAccount){
			for(var i = 0 ; i < totalRows.length ; i ++){
					var toElsAccount = totalRows[i].friendElsAccount;
					var toElsDesc = totalRows[i].friendCompanyName;
					if(toElsAccount == selectToElsAccount){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
						toElsTable.select(i);
						continue;
					}
			}
		}
		$("#selectFriendElsAccountDialog").show();
	});
	
	//选择本方负责人弹出框确认按钮单击事件
	$("#selectFriendOKBtn").click(function(){
		var selectedRows = toElsTable.selectedRows();
		var toElsAccount ="";
		var toElsDesc ="";
		if(selectedRows != "" ){
			if(selectedRows.length == 1){
				toElsAccount = selectedRows[0].friendElsAccount;
				toElsDesc = selectedRows[0].friendCompanyName;
			} else {
				alert("<i18n:I18n defaultValue='对方ELS只能选择一个!' key='i18n_label_additionCost_toElsAccountCanOnlySelectOne'/>");
			}
		}else{
			alert("<i18n:I18n defaultValue='至少选择一条记录！' key='i18n_common_title_selectAtLeastOneRecord'/>");
			return;
		}
		$("#toElsAccount").val(toElsAccount);
		$("#toElsDesc").val(toElsDesc);
		$("#selectFriendElsAccountDialog").hide();
	});
	
	$("#selectFriendElsAccountDialogClose").click(function(){
		$("#selectFriendElsAccountDialog").hide();
	});
	
	$("#selectFriendCancelBtn").click(function(){
		$("#selectFriendElsAccountDialog").hide();
	});
	
	function removeFileRowByItemNumber(additionCostItemNumber){
		var fileRowLength = fileGrid.rowsLength();
		for(var i=fileRowLength; i-1 >= 0 ;i--){
			var itemNumber = fileGrid.row(i-1).additionCostItemNumber;
			if(itemNumber == additionCostItemNumber){
			 fileGrid.removeRow(i);
			}
		}
		reGenerateFileSequence();//删除文件行后,重新生成文件序号
	}
	
    function clearAddFileInfo(){
    	$("#fileName").val("");
    	$("#filePath").val("");
    	$("#materialLineJson-File").val("");
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
    
    //增加文件到表单文件table
    function addFileTableRow(){
   		var fileName = $("#fileName").val();
   		var filePath = $("#filePath").val();
   		
   		var toElsAccount = $("#toElsAccount").val();
   		var toElsDesc = $("#toElsDesc").val();
   		var additionCostType = $("#additionCostType").val();
   		var selectFileType = $("#selectFileType").val();
   		var additionCostItemNumber = "";
   		if("all" ==  selectFileType){//选择所有下拉列表时添加文件无行项目
   		} else if("common" == selectFileType){//选择公共下拉列表时添加文件无行项目
   		} else {//选择行项目添加时
   			additionCostItemNumber = selectFileType;
   		}
   		var maker = elsSubAccount+"_"+userName;
   		var fileTableRows = fileGrid.rowsLength();
   		var fileSequence = fileTableRows+1;
   		
   		var item = {
   				fileSequence : fileSequence,
   				fileName : fileName,
   				filePath : filePath,
   				fileFrom : "0",
   				maker : maker,
   				elsAccount : elsAccount,
   				toElsAccount : toElsAccount,
   				toElsDesc : toElsDesc,
   				additionCostType : additionCostType,
   				additionCostItemNumber : additionCostItemNumber
   		};
   		fileGrid.addRow(item);
   	}
    
    function reGenerateFileSequence(){
    	var fileTableRows = fileGrid.rowsLength();
    	if(fileTableRows > 0){
	    	for(var i=0;i<fileTableRows;i++){
	    		var fileRow = fileGrid.row(i);
	    		fileRow["fileSequence"] = i+1;
	    	}
	    	fileGrid.load(fileGrid.rows());
    	}
    }

    function reGenerateItemNumber(){
    	var itemTableRows = itemGrid.rowsLength();
    	if(itemTableRows > 0){
	    	for(var i=0;i<itemTableRows;i++){
	    		var itemRow = itemGrid.row(i);
	    		itemRow["additionCostItemNumber"] = i+1+"0";
	    	}
	    	itemGrid.load(itemGrid.rows());
    	}
    	
    	reGenFileTypeSelect();
    }
    
    function reGenFileTypeSelect(){
		var itemRowSize = itemGrid.rowsLength();
		var fileTypeSelect = $("#selectFileType");
		fileTypeSelect.empty();
		$("<option value='all'><i18n:I18n defaultValue='所有文件' key='i18n_common_select_filetype_all'/></option>").appendTo(fileTypeSelect);
		$("<option value='common'><i18n:I18n defaultValue='公共文件' key='i18n_common_select_filetype_public'/></option>").appendTo(fileTypeSelect);
		for(var i=0;i<itemRowSize;i++){
			var additionCostItemNumber = itemGrid.row(i).additionCostItemNumber;
			$("<option value='"+additionCostItemNumber+"'>"+additionCostItemNumber+"</option>").appendTo(fileTypeSelect);//文件下拉列表添加行项目选项
		}
	}
  //渲染input框 仅可输入小数点跟数字
    function initInputDouble(val,item,index){
	  debugger;
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
    	if(item.busReconStatus == "0" || item.busReconStatus == "" || item.busReconStatus == null){ //只有对账单状态为新建时才允许修改
    	   return '<input class="nest-report" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:100px;height: 20px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
    	}else{
    		return val;
    	}
    }
    function initFileUploader(fileUploader){
   	    //新增表单文件
   	    if (!fileUploader) {
    	  	fileUploader = WebUploader.create({
    	  	    swf : "${pageContext.request.contextPath}/jsLib/webuploader/Uploader.swf",// swf文件路径
    	  	    auto : true,//是否选择文件后自动上传
    	  	    server : "${pageContext.request.contextPath}/servlet/UploadServlet",// 文件接收服务端。
    	  	    pick : "#btnFileUpload",//选择文件的按钮,可选.内部根据当前运行时创建,可能是input元素,也可能是flash/
    	  	    resize : false,// 不压缩image,默认如果是jpeg,文件上传前会压缩再上传.
    	  	    formData : {
    		     	elsAccount : elsAccount
    		    }
    	  	});
    	  	
    	 	// 当有文件添加进来的时候
    		fileUploader.on("fileQueued",function(file){
    			var fileName = file.name;
    			$("#fileName").val(fileName);
    			$("#fileType").val(file.ext);
    		});
    	 	//上传到服务器响应后触发
    		fileUploader.on("uploadAccept", function( obj, response ) {
    			var errorNumber = response.error;
    			if(errorNumber == 0){
					var filePath = response.url;
					$("#filePath").val(filePath);
    			} else {
	    			var errorMessage = response.message;
	    			alert(errorMessage,3);
    			}
     	  	});
    		//上传出错时触发
    		fileUploader.on( "uploadError", function( obj, response  ) {
     	  	   	var errorMessage = response.message;
     	  	    alert(errorMessage,3); 
     	  	});
   	    }
   	}

	//查询销售订单信息--------------begin---------------
	function formatDate(val){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		     return val;
	}
	
	var queryPurchaseOrderCols = [
            { title:"<i18n:I18n defaultValue='采购订单号' key='i18n_enquiry_title_purchaseordernumber'/>", name:'purchaseOrderNumber' , width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='采购订单行项目号' key='i18n_additionCost_purchaseOrderLineItemNumber'/>", name:'orderItemNumber' , width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='网格值' key='i18n_purchaseorderhis_title_gridvalue'/>", name:'gridValue' , width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='物料编码' key='i18n_common_title_materialnumber'/>", name:'materialNumber' ,width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='物料描述' key='i18n_common_title_materialdescribe'/>", name:'materialDesc' ,width:250, align:'center'},
            { title:"<i18n:I18n defaultValue='数量' key='i18n_ladderprice_label_quantity'/>", name:'quantity' ,width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='单价' key='i18n_common_title_price'/>", name:'price',width:60, align:'center'},
            { title:"<i18n:I18n defaultValue='金额' key='i18n_common_title_amount'/>", name:'totalAmount',width:60, align:'center'},
            { title:"<i18n:I18n defaultValue='交货日期' key='i18n_common_deliverydate'/>", name:'deliveryDate',width:60, align:'center',renderer:formatDate}
        ];
	
	var queryPurchaseOrderGrid;
	//查询销售订单显示
	$("#queryPurchaseOrder").click(function(){
		var toElsAccount = $("#toElsAccount").val();
		if("undefined"==typeof(toElsAccount) || "" == toElsAccount){
			alert("<i18n:I18n defaultValue='请选择对方ELS' key='i18n_label_additionCost_pleaseSelectToElsAccounts'/>!",3);
       		return;
       	}
		$("#queryPurchaseOrderDialog").show();//mmgrid加载需指定宽高或知道父容器的宽高,父容器隐藏时无宽高,需先显示再加载或者指定一个宽高让mmgrid加载
		queryPurchaseOrderGrid = $('#queryPurchaseOrderTable').mmGrid({
			cols : queryPurchaseOrderCols,
			url : "${pageContext.request.contextPath}/rest/PurchaseOrderService/queryPurchaseOrderItemByHeadCondtion",
	        method : 'post',
	        autoLoad : false,
	        root : 'rows',
	        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	        indexCol : true,
	        multiSelect :true,
	        checkCol : true
     	});
		queryPurchaseOrderGrid.on('loadSuccess',function(e,data) {
			debugger;
			if (data&&data.statusCode == "-100") {
			     alert(data.message,3);
			 } else {
			     //alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />',1);
			}
		});
	});
	
	//查询销售订单
	$("#queryPurchaseOrderBtn").click(function(){
		var toElsAccount = $("#toElsAccount").val();
		var saleOrderNumber = $("#saleOrderNumber").val();
		var purchaseOrderNumber = $("#purchaseOrderNumber").val();
		var startOrderDate = $("#startOrderDate").val();
		var endOrderDate = $("#endOrderDate").val();
		
		var param = {
				elsAccount : elsAccount,
				toElsAccount : toElsAccount,
				purchaseOrderNumber : purchaseOrderNumber,
				startOrderDate : startOrderDate,
				endOrderDate : endOrderDate,
				orderType:'71'
		};
		queryPurchaseOrderGrid.load(param);
	});
	
	//从sap获取物料信息弹出窗确认按钮单击事件
	$("#queryPurchaseOrderDialogOkBtn").click(function(){
		var selectRows = queryPurchaseOrderGrid.selectedRows();
		if(selectRows.length == 0){
			//parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '请选择订单项！'});
			alert("<i18n:I18n defaultValue='请选择订单项!' key='i18n_delivery_pleaseSelectOrderItem'/>",0);
			return;
		}
		var itemRows = itemGrid.rows();
		if("undefined" != typeof(itemRows) && itemGrid.rowsLength() > 0 && "undefined" != typeof(selectRows)){
			for( var i = 0 ; i < itemRows.length ; i ++){
				var itemRow = itemRows[i];
				if("undefined" != typeof(itemRow) && itemRow.length > 0){
					for( var j = 0 ; j < selectRows.length ; j ++){
						var selectRow = selectRows[j];
						
						var purchaseOrderNumber = itemRow.purchaseOrderNumber;
						var purchaseOrderItemNumber = itemRow.purchaseOrderItemNumber;
						var _purchaseOrderNumber = selectRow.purchaseOrderNumber;
						var _orderItemNumber = selectRow.orderItemNumber;
						if(purchaseOrderNumber == _purchaseOrderNumber && purchaseOrderItemNumber == _orderItemNumber){
							selectRows.splice(j,1);//去重复
						}
					}
				}
			}
		}
		
		var toElsAccount = $("#toElsAccount").val();
		var additionCostNumber = $("#additionCostNumber").val();
		var additionCostType = $("#additionCostType").val();
		var currency = $("#currency").val();
		
		var itemSize = itemGrid.rowsLength();
		
	    var rows = [];
		for(var i = 0 ; i < selectRows.length ; i++ ){ //设置初始值
			var selectRow = selectRows[i];
			var additionCostItemNumber = itemSize+i+1+"0";
			var record = {
					elsAccount : elsAccount,
					toElsAccount : toElsAccount,
					additionCostType : additionCostType,
					additionCostNumber : additionCostNumber,
					additionCostItemNumber : additionCostItemNumber,
					purchaseOrderNumber : selectRow.purchaseOrderNumber,
					purchaseOrderItemNumber : selectRow.orderItemNumber,
					gridValue : selectRow.gridValue,
					materialNumber : selectRow.purchaseMaterialNumber,
					materialDesc : selectRow.purchaseMaterialDesc,
					companyCode : "",
					quantity : selectRow.quantity,
					price : selectRow.price,
					amount : selectRow.totalAmount,
					deliveryDate : selectRow.deliveryDate,
					costType : "",
					additionCostAmount : "0",
					currency : currency,
					remark : "",
			};
			rows.push(record);
			
			itemGrid.addRow(record,itemSize+i);//mmgrid添加数组时顺序是反的,制定顺序添加
			$("<option value='"+additionCostItemNumber+"'>"+additionCostItemNumber+"</option>").appendTo($("#selectFileType"));//文件下拉列表添加行项目选项
		}
		//itemGrid.addRow(rows);
		$("#queryPurchaseOrderDialog").hide();
		calcTotalAmount();//重算总额
	});
	
	//关闭窗口
	$("#queryPurchaseOrderDialogClose").click(function(){
		$("#queryPurchaseOrderDialog").hide();
	});
	
	//关闭窗口
	$("#queryPurchaseOrderDialogCancelBtn").click(function(){
		$("#queryPurchaseOrderDialog").hide();
	});
	//查询销售订单信息--------------end---------------
    
    //清空手动添加费用框数据
	function clearManuAddInfo(){
		$("#manuAdditionCostAmount").val("");
		$("#manuCostType").val("");
		$("#manuRemark").val("");
	}
	
	//将手动添加窗口输入的数据添加到信息主表
	function migrationAdditionManuAddInfo(table){
		var additionCostAmount = $("#manuAdditionCostAmount").val();
		var costType = $("#manuCostType").val();
		var remark = $("#manuRemark").val();
		var currency = $("#currency").val();
		var toElsAccount = $("#toElsAccount").val();
		var additionCostNumber = $("#additionCostNumber").val();
		var toElsAccount = $("#toElsAccount").val();
		var additionCostType = $("#additionCostType").val();
		
		var itemRowSize = itemGrid.rowsLength();
		var additionCostItemNumber = itemRowSize+1+"0";
		
		var data = {
				elsAccount : elsAccount,
				toElsAccount : toElsAccount,
				additionCostNumber : additionCostNumber,
				additionCostItemNumber : additionCostItemNumber,
				additionCostType : additionCostType,
				/* purchaseOrderNumber : "",
				purchaseOrderItemNumber : "",
				gridValue : "",
				materialNumber : "",
				materialDesc : "",
				companyCode : "",
				quantity : "",
				price : "",
				amount : "",
				deliveryDate : "",*/
				costType : costType, 
				additionCostAmount : additionCostAmount,
				currency : currency,
				remark : remark
		    };
		table.addRow(data);//插入到表格最后
		$("<option value='"+additionCostItemNumber+"'>"+additionCostItemNumber+"</option>").appendTo($("#selectFileType"));//文件下拉列表添加行项目选项
		
		clearManuAddInfo();
		$("#additionCostManuAdd").hide();
		calcTotalAmount();//重算总额
	}

	function fileSelectAddItemLine(additionCostItemNumber){
		//设置表单文件tag页的文件类型下拉列表值
		var option = '<option value="'+additionCostItemNumber+'" >'+additionCostItemNumber+'</option>';
		$('#selectFileType').append(option);
	}
	
	function selectPriceQuantity(index){
		 $("#price_index").val(index);
		 $("#quantityUnit").trigger('click');
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
   
   function calcTotalAmount(){
	   var itemSize = itemGrid.rowsLength();
	   var totalAmountObj = $("#totalAmount");
	   var total = 0;
	   if(itemSize > 0){
		   var rows = itemGrid.rows();
		   for(var i=0;i<itemSize;i++){
			   //alert(rows[i].additionCostAmount);
			   total += parseFloat(rows[i].additionCostAmount);
		   }
		   totalAmountObj.val(total.toFixed(2));
	   } else {
		   totalAmountObj.val(0);
	   }
   }
   
   $("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostAddItem_mt&window=iframeApp_saleAdditionCostAdd_mt",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
   
   function additionCostAmountRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = 0; 
	   }
   	   return '<input class="additionCostAmountChange" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:100px;height: 20px;"  name="additionCostAmount" maxlength="10" id="additionCostAmount" type="text" value="'+val+'"/>';

// 	   return "<input typpe='text' name='additionCostAmount' class='additionCostAmountChange' value='"+val+"' />";
   }
   
   $(".additionCostAmountChange").live('keyup',function(){
	   var additionCostAmount = $(this).val();
	   var rowIndex = $(this).closest("tr").index();
	   var rowData = itemGrid.row(rowIndex);
	   rowData["additionCostAmount"] = additionCostAmount;//将值赋给mmgrid对象对应属性
	   
	   var total = 0;
	   $("#itemTable input[name='additionCostAmount']").each(function(){
		   total += parseFloat($(this).val());
	   });
	   $("#totalAmount").val(total);
   });
   
   function itemRemarkRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input typpe='text' name='remark' class='itemRemarkChange' value='"+val+"' />";
   }
   
   $(".itemRemarkChange").live('keyup',function(){
	   var remark = $(this).val();
	   var rowIndex = $(this).closest("tr").index();
	   var rowData = itemGrid.row(rowIndex);
	   rowData["remark"] = remark;//将值赋给mmgrid对象对应属性
   });
   
   function fileRemarkRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input typpe='text' name='remark' width='100%' class='fileRemarkChange' value='"+val+"' />";
   }
   
   $(".fileRemarkChange").live('keyup',function(){
	   var remark = $(this).val();
	   var rowIndex = $(this).closest("tr").index();
	   var rowData = fileGrid.row(rowIndex);
	   rowData["remark"] = remark;//将值赋给mmgrid对象对应属性
   });
   
   function costTypeRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input typpe='text' name='remark' width='100%' class='costTypeChange' value='"+val+"' />";
   }
   
   $(".costTypeChange").live('keyup',function(){
	   var costType = $(this).val();
	   var rowIndex = $(this).closest("tr").index();
	   var rowData = itemGrid.row(rowIndex);
	   rowData["costType"] = costType;//将值赋给mmgrid对象对应属性
   });
</script>
</body>
</html>