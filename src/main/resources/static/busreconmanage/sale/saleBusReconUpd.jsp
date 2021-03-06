<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
  <div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="操作" key="i18n_enquiry_title_operation"/></span>
    <div class="common-box-line">
        <!-- <button class="button-wrap" id="saveBtn"><i18n:I18n defaultValue="保存" key="i18n_button_save"/></button>
        <button class="button-wrap" id="saveSendBtn"><i18n:I18n defaultValue="保存发送" key="i18n_common_button_saveSend"/></button> -->
        <button class="button-wrap" id="headDefineBtn">头<i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
        <button class="button-wrap" id="itemDefineBtn">行<i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
    </div>
</div>

<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="对账头信息" key="test"/></span>
    <div class="common-box-line">
       <main class="grid-container">
            <div class="grid-100">
                <table id="headTable"></table>
            </div>
       </main>
    </div>
</div>

<div class="tab-wrap tab-wrap-change" id="add-enq-sheet">
    <ul>
        <li><a href="#edit-line-one"><i18n:I18n defaultValue="订单行项目" key="i18n_delivery_lable_orderitems"/></a></li>
        <li><a href="#edit-line-two"><i18n:I18n defaultValue="表单文件" key="i18n_enquiry_title_formfile"/></a></li>
        <li><a href="#edit-line-three"><i18n:I18n defaultValue="收货明细" key="i18n_busRecon_title_receiptDetail"/></a></li>
        <li><a href="#edit-line-five"><i18n:I18n defaultValue="附加费明细" key="i18n_busRecon_title_additionalChargeDetail"/></a></li>
        <li><a href="#edit-line-six"><i18n:I18n defaultValue="扣款明细" key="i18n_busRecon_title_deductMoneyDetail"/></a></li>
        <li><a href="#edit-line-seven"><i18n:I18n defaultValue="发票明细" key="i18n_busRecon_title_invoiceDetail"/></a></li>
    </ul>
    <div class="p-zero" id="edit-line-one" style="padding: 2px;">
        <div class="edit-box-wrap" style="padding: 2px;margin-left: 5px;">
            <button id="itemDelBtn" class="button-wrap"><i18n:I18n defaultValue="批量移除" key="test"/></button>
        </div>
        <main class="grid-container">
        <div class="grid-100" id="reCreate">
            <table id="itemTable"></table>
        </div>
        </main>
    </div>
    <div class="p-zero" id="edit-line-two">
        <div class="box-wrap pos-relative bg-common">
		            <div class="common-box-line p-zero">
		                <div class="pos-relative upload-wrap">
		                    <div class="pos-absolute file-list">
								<div class="file-list-head" id="file-list-head"><span><i18n:I18n defaultValue="文件类型" key="i18n_common_title_filetype"/></span>
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
    <div class="p-zero" id="edit-line-three">
        <main class="grid-container">
            <div class="grid-100" id="receiptDiv">
                <table id="receiptTable"></table>
            </div>
        </main>
    </div>
    <div class="p-zero" id="edit-line-five">
        <main class="grid-container">
        <div class="grid-100" id="additionCostDiv">
            <table id="additionCostTable"></table>
        </div>
        </main>
    </div>
    <div class="p-zero" id="edit-line-six">
        <main class="grid-container">
            <div class="grid-100" id="deductionDiv">
                <table id="deductionTable"></table>
            </div>
        </main>
    </div>
    <div class="p-zero" id="edit-line-seven">
        <main class="grid-container" style="padding: 2px;">
            <div class="edit-box-wrap" style="padding: 2px;">
                <button id="invoiceAddBtn" class="button-wrap"><i18n:I18n defaultValue="新增" key="i18n_common_button_create"/></button>
                <!-- <button id="invoiceUpdBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update"/></button> -->
                <button id="invoiceDelBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete"/></button>
                <button id="invoiceSaveBtn" class="button-wrap"><i18n:I18n defaultValue="保存" key="i18n_button_save"/></button>
            </div>
            <div class="grid-100">
                <table id="invoiceTable"></table>
            </div>
        </main>
    </div>
</div>

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
	        <div class="grid-100" >
                <table id="select-principal-table"></table>
            </div>
	        <main class="bg-common p-6">
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

<div class="fixed-dialog" id="selectOrgCodeDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectOrgCodeDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div>
	    	 <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查询条件" key="i18n_additionCost_queryCondition"/></span>
	            <div class="common-box-line">
	            	<div class="dis-in-b input-and-tip"> 
						<input type="hidden" id="queryOrgCategoryId" />
						<input type="hidden" id="queryOrgCategoryDesc" />
						<input type="hidden" id="parentOrgId" />
					</div>
	            	<div class="dis-in-b input-and-tip"> 
						<span><i18n:I18n defaultValue="组织编码" key=""/>:</span>
						<input type="text" id="queryOrgId" />
					</div>
	            	<div class="dis-in-b input-and-tip"> 
						<span><i18n:I18n defaultValue="组织名称" key=""/>:</span>
						<input type="text" id="queryOrgDesc" />
					</div>
	            	<div class="dis-in-b input-and-tip"> 
						<button id="queryOrgCodeBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
					</div>
					<div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectOrgCodeOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectOrgCodeCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectOrgCodeTable"></table>
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

/****  自定义列编辑字段 start  *****/
//head自定义列编辑字段
function headElsAccountRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   }
	   return "<input type='text' id='elsAccount' name='elsAccount' readonly='readonly' value='"+val+"' />";
}

function headElsDescRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   }
	   return "<input type='text' id='elsDesc' name='elsDesc' readonly='readonly' value='"+val+"' />";
}

function headToElsAccountRender(val,item,rowIndex){
	   var html = "<input type='text' id='toElsAccount' name='toElsAccount' class='toElsAccount' value='"+val+"' readonly='readonly' />"
			+"<img class='toElsAccount dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' id='queryToElsAccount' />";
	   
	   return html;
}

function headToElsDescRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   }
	   return "<input type='text' id='toElsDesc' name='toElsDesc' readonly='readonly' value='"+val+"' />";
}

function headSaleBusReconNumberRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   }
	   return "<input type='text' id='saleBusReconNumber' name='saleBusReconNumber' readonly='readonly' value='"+val+"' />";
}

function headPurchaseBusReconNumberRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   }
	   return "<input type='text' id='purchaseBusReconNumber' name='purchaseBusReconNumber' readonly='readonly' value='"+val+"' />";
}

function headReconDateRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   } else {
		   val = new Date(val).format("yyyy-MM-dd");
	   }
	   return "<input type='text' id='reconDate' name='reconDate' readonly='readonly' value='"+val+"' />";
}

function headPostingDateRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   } else {
		   val = new Date(val).format("yyyy-MM-dd");
	   }
	   return "<input type='text' id='postingDate' name='postingDate' class='Wdate' onfocus='WdatePicker({dateFmt:\"yyyy-MM-dd\"})'  value='"+val+"' />";
}

function headReconStartDateRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   } else {
		   val = new Date(val).format("yyyy-MM-dd");
	   }
	   return "<input type='text' id='reconStartDate' name='reconStartDate' class='Wdate' onfocus='WdatePicker({dateFmt:\"yyyy-MM-dd\"})' value='"+val+"' />";
}

function headReconEndDateRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   } else {
		   val = new Date(val).format("yyyy-MM-dd");
	   }
	   return "<input type='text' id='reconEndDate' name='reconEndDate' class='Wdate' onfocus='WdatePicker({dateFmt:\"yyyy-MM-dd\"})' value='"+val+"' />";
}

function headTotalInvoiceAmountRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "0";
	   }
	   return "<input type='text' id='totalInvoiceAmount' name='totalInvoiceAmount' readonly='readonly' value='"+val+"' />";
}

function headTotalTaxAmountRender(val,item,rowIndex){
	debugger;
	   if("undefined"==typeof(val)){
		   val = "0";
	   }
	   return "<input type='text' id='totalTaxAmount' name='totalTaxAmount' readonly='readonly' value='"+val+"' />";
}

function headInvoiceNumberRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   }
	   return "<input type='text' id='invoiceNumber' name='invoiceNumber' readonly='readonly' value='"+val+"' />";
}

function headTotalAdditionAmountRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "0";
	   }
	   return "<input type='text' id='totalAdditionAmount' name='totalAdditionAmount' readonly='readonly' value='"+val+"' />";
}

function headTotalDeductionAmountRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "0";
	   }
	   return "<input type='text' id='totalDeductionAmount' name='totalDeductionAmount' readonly='readonly' value='"+val+"' />";
}

function headCurrencyRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "CNY"; 
	   }
	   return "<input type='text' id='currency' name='currency' value='"+val+"' />";
}

function headTaxCodeRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' id='taxCode' name='taxCode' value='"+val+"' />";
}

function headTaxRateRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "0"; 
	   }
	   return "<input type='text' id='taxRate' name='taxRate' value='"+val+"' />";
}

function headSalePersonRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   var html = "<input type='text' id='salePerson' name='salePerson' class='salePerson' value='"+val+"' readonly='readonly' />"
			+"<img class='salePerson dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' />";
	   
	   return html;
}

 function headPurchasePersonRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
		 val = ""; 
		}
		var html = "<input type='text' id='purchasePerson' name='purchasePerson' class='purchasePerson' value='"+val+"' readonly='readonly' />"
		+"<img class='purchasePerson dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' />";
		
		return html;
 }

function headPurchaseReceiveFactoryRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   var html = "<input type='text' id='purchaseReceiveFactory' name='purchaseReceiveFactory' class='purchaseReceiveFactory' value='"+val+"' readonly='readonly' />"
		+"<img class='purchaseReceiveFactory dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' />";
		
		return html;
}

function headRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		var html = "<input type='text' id='purchaseCompanyCode' name='purchaseCompanyCode' class='purchaseCompanyCode' value='"+val+"' readonly='readonly' />"
				+"<img class='purchaseCompanyCode dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' />";

		return html;
	}

function headPurchaseCompanyNameRender(val,item,rowIndex){
		if("undefined"==typeof(val)||'null'===val){
			val = "";
		}
		return "<input type='text' id='purchaseCompanyName' name='purchaseCompanyName' readonly='readonly' value='"+val+"' />";
	}

function headPaymentWayRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' id='paymentWay' name='paymentWay' value='"+val+"' />";
}

function headPaymentTimeRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "0"; 
	   }
	   return "<input type='text' id='paymentTime' name='paymentTime' onkeyup='paymentDateChange()' value='"+val+"' />";
}

function headPaymentBenchmarkDateRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   } else {
		   val = new Date(val).format("yyyy-MM-dd");
	   }
	   return "<input type='text' id='paymentBenchmarkDate' name='paymentBenchmarkDate' class='Wdate' onfocus='WdatePicker({readOnly:true,onpicked:paymentDateChange,dateFmt:\"yyyy-MM-dd\"})' value='"+val+"' />";
}

function paymentDateChange(){
	   var selectRow = getSelectedHeadRow();
	   var paymentTime = selectRow.find("input[name='paymentTime']").val();
	   var paymentBenchmarkDate = selectRow.find("input[name='paymentBenchmarkDate']").val();
	   
	   var paymentExpireDate = new Date(new Date(paymentBenchmarkDate).getTime()+paymentTime*24*60*60*1000).format("yyyy-MM-dd");
	   selectRow.find("input[name='paymentExpireDate']").val(paymentExpireDate);
}

function headPaymentExpireDateRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = "";
	   } else {
		   val = new Date(val).format("yyyy-MM-dd");
	   }
	   return "<input type='text' id='paymentExpireDate' name='paymentExpireDate' readonly='readonly' value='"+val+"' />";
}

function headReceiverCountryCodeRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' id='receiverCountryCode' name='receiverCountryCode' value='"+val+"' />";
}

function headReceiverBankAccountNameRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' id='receiverBankAccountName' name='receiverBankAccountName' value='"+val+"' />";
}

function headReceiverBankRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' id='receiverBank' name='receiverBank' value='"+val+"' />";
}

function headReceiverBankAccountRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' id='receiverBankAccount' name='receiverBankAccount' value='"+val+"' />";
}

function headRemarkRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' id='remark' name='remark' value='"+val+"' />";
}
//item自定义列编辑字段
function itemRemarkRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' name='saleRemark' class='saleRemarkChange' value='"+val+"' />";
}

$(".saleRemarkChange").live('keyup',function(){
	   var saleRemark = $(this).val();
	   var rowIndex = $(this).closest("tr").index();
	   var rowData = itemGrid.row(rowIndex);
	   rowData["saleRemark"] = saleTaxAmount;//将值赋给mmgrid对象对应属性
});

//file自定义列编辑字段
function fileRemarkRender(val,item,rowIndex){
	   if("undefined"==typeof(val)){
		   val = ""; 
	   }
	   return "<input type='text' name='remark' class='fileRemarkChange' value='"+val+"' />";
}

$(".fileRemarkChange").live('keyup',function(){
	   var remark = $(this).val();
	   var rowIndex = $(this).closest("tr").index();
	   var rowData = fileGrid.row(rowIndex);
	   rowData["remark"] = remark;//将值赋给mmgrid对象对应属性
});

	//invoice自定义列编辑字段
	$("#invoiceTable input[type='text']").live("keyup",function(){
		var input = $(this);
		var rowIndex = input.closest("tr").index();
		var inputName = input.attr("name");
		var inputValue = input.val();
		
		invoiceGrid.rows()[rowIndex][""+inputName] = inputValue;
	});
	
	function invoiceInvoiceDateRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
		 val = ""; 
		} else {
			   val = new Date(val).format("yyyy-MM-dd");
		   }
		return "<input type='text' name='invoiceDate' class='Wdate' onfocus='WdatePicker({readOnly:true,dateFmt:\"yyyy-MM-dd\"})' value='"+val+"' />";
	}
	
	function invoiceInvoiceNumberRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
		 val = ""; 
		}
		return "<input type='text' name='invoiceNumber' value='"+val+"' />";
	}
	
	function invoiceInvoiceTotalAmountRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
		 val = "0"; 
		}
		return "<input type='text' name='invoiceTotalAmount' value='"+val+"' />";
	}
	
	function invoiceTaxAmountRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
		 val = "0"; 
		}
		return "<input type='text' name='taxAmount' value='"+val+"' />";
	}
	
	function invoiceSaleRemarkRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
		 val = ""; 
		}
		return "<input type='text' name='saleRemark' value='"+val+"' />";
	}

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

//对账单头信息列
var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleBusReconAddHead_mt"/>;
var headGrid = $("#headTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/querySaleBusReconHead",
    method :  "POST",
	cols : headCols,
	autoLoad : false,
	height:<base:tableHeight tableCode="saleBusReconAddHead_mt"/>,
	root : "rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    indexCol : true
});

//对账单行信息列
var itemCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleBusReconAddItem_mt"/>;
var itemGrid = $("#itemTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/querySaleBusReconItem",
    method : "POST",
    cols : itemCols,
    height:<base:tableHeight tableCode="saleBusReconAddItem_mt"/>,
    root:"rows",
    autoLoad : false,
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    indexCol : true
});
//对账单文件信息列
var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleBusReconAddFile_mt"/>;
var fileGrid = $("#fileTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/querySaleBusReconFile",
    method : "post",
    cols : fileCols,
    root:"rows",
    autoLoad : false,
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    indexCol : true
});

//收货信息列
var receiptCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="queryReceipt_item_mt"/>;
var receiptGrid = $("#receiptTable").mmGrid({
    cols : receiptCols,
    height:<base:tableHeight tableCode="queryReceipt_item_mt"/>,
    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/queryReceiptItemForBusRecon",
    method : "post",
    root : "rows",
    autoLoad : false,
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    indexCol : true
});

//附加费用信息列
var additionCostCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageItem_mt"/>;
var additionCostGrid = $("#additionCostTable").mmGrid({
    cols : additionCostCols,
    height:<base:tableHeight tableCode="saleAdditionCostManageItem_mt"/>,
    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/queryAdditionCostItemForBusRecon",
    method : "post",
    root : "rows",
    autoLoad : false,
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    indexCol : true
});

//扣款信息列
var deductionCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageItem_mt"/>;
var deductionGrid = $("#deductionTable").mmGrid({
    cols : deductionCols,
    height:<base:tableHeight tableCode="saleAdditionCostManageItem_mt"/>,
    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/queryAdditionCostItemForBusRecon",
    method : "post",
    root : "rows",
    autoLoad : false,
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    indexCol : true
});

//发票信息列
var invoiceCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleBusReconAddInvoice_mt"/>;
var invoiceGrid = $("#invoiceTable").mmGrid({
    cols : invoiceCols,
    height:<base:tableHeight tableCode="saleBusReconAddInvoice_mt"/>,
    url : "${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/queryInvoiceItemForBusRecon",
    method : "post",
    root : "rows",
    autoLoad : false,
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    multiSelect : true,
    checkCol : true,
    indexCol : true
});


$(document).ready(function(){
    //初始化控件
    $("#add-enq-sheet").tabs();
    
    var elsAccount = "${param.elsAccount}";
	var toElsAccount = "${param.toElsAccount}";
    var saleBusReconNumber = "${param.saleBusReconNumber}";
	
	var queryParam = {
			elsAccount : elsAccount,
			toElsAccount : toElsAccount,
			saleBusReconNumber : saleBusReconNumber
		};
	
    headGrid.load(queryParam);
    
});
	
	headGrid.on("loadSuccess",function(e, data) {
		if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
			headGrid.select(0);//默认选中第一行
			var seled=headGrid.selectedRows();
			var record = data.rows[0];
	        //根据头表选中项加载对应行,文件等信息
			loadItem(record.elsAccount,record.toElsAccount,record.saleBusReconNumber);
			loadFile(record.elsAccount,record.toElsAccount,record.saleBusReconNumber);
			loadReceipt(record.elsAccount,record.toElsAccount,record.saleBusReconNumber,record.reconStartDate,record.reconEndDate);
			loadAdditionCost(record.elsAccount,record.toElsAccount,record.saleBusReconNumber,record.reconStartDate,record.reconEndDate);
			loadDeduction(record.elsAccount,record.toElsAccount,record.saleBusReconNumber,record.reconStartDate,record.reconEndDate);
			loadInvoice(record.elsAccount,record.toElsAccount,record.saleBusReconNumber);
			checkHeadStatus();
		}else{
			clearChildTables();
		}
	});

	var headSelectIndex;
	headGrid.on("cellSelected",function(e, item, rowIndex, colIndex){
		var _this=$(e.target);
		headSelectIndex = rowIndex;
		if(_this.hasClass("toElsAccount")) {
			showToElsAccount();
		} else if(_this.hasClass("salePerson")){
			showSalePerson();
		} else if(_this.hasClass("purchasePerson")){
			showPurchasePerson();
		} else if(_this.hasClass("purchaseReceiveFactory")){
			showOrgInfo("factory");
		} else if(_this.hasClass("purchaseCompanyCode")){
			showOrgInfo("company");
		} else {

		}
	});
	
	fileGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
		var filePath = item.filePath;
		if(currShowFile == filePath){//如果选中的为当前显示文件则不做其他操作
		} else {//如果选中的不是当前显示文件则重新刷新右侧显示文件
			currShowFile = filePath;
			previewFile(filePath);
		}
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
        	//$("#deductionTable input[type='checkbox']").attr("onclick","return false;");
    	}
  	});
	
	//==========================================
	 
	//单击添加表单文件事件
	$("#addFileBtn").click(function() {
		clearAddFileInfo();
		$("#addFileDialog").show();
		initFileUploader(fileUploader);
	});
	 
	$("#addFileBtnOK").click(function(){
		$("#addFileDialog").hide();
		var filePath = $("#filePath").val();
		if(filePath == ""){
			alert("<i18n:I18n defaultValue='请选择上传文件!' key='i18n_please_select_a_file_to_upload'/>",1);
			return false;
		}
		addFileTableRow();
		clearAddFileInfo();
		//$( "#add-enq-sheet").tabs({active:1});//tab切换
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
	
	//------------- 发票相关 ----------start----------------
	$("#invoiceAddBtn").click(function(){
		var rowLength = invoiceGrid.rowsLength();
		var headRecord = headGrid.row(0);
		var currDate = new Date();
		var busReconStatus = headRecord.busReconStatus;
		
		if("0" == busReconStatus || "1" == busReconStatus){
			parent.elsDeskTop.tip.init({type:"alert",displayType:2,message:"<i18n:I18n defaultValue='采购未全部确认,禁止开发票！' key='i18n_enquiry_title_purchaseNotConfirmAndProhibitInvoice'/>"});
		} else if("2" == busReconStatus || "3" == busReconStatus || "7" == busReconStatus){
			var newData = [{
		    	invoiceSequence : rowLength+1,
		    	checkStatus : "0",
		    	elsAccount : headRecord.elsAccount,
		    	elsDesc : headRecord.elsDesc,
		    	toElsAccount : headRecord.toElsAccount,
		    	toElsDesc : headRecord.toElsDesc,
		    	saleBusReconNumber : headRecord.saleBusReconNumber,
		    	purchaseBusReconNumber : headRecord.purchaseBusReconNumber,
		    	invoiceDate : currDate.format("yyyy-MM-dd"),
		    	invoiceNumber : "",
		    	invoiceTotalAmount : "0",
		    	taxAmount : "0",
		    	saleRemark : "",
		    	purchaseRemark : ""
		    }];
		    invoiceGrid.addRow(newData);
		} else if("4" == busReconStatus || "5" == busReconStatus || "6" == busReconStatus){
			alert("<i18n:I18n defaultValue='已经全部开票,禁止再开发票！' key='i18n_enquiry_title_InvoiceAllAndProhibitAgain'/>",2);
		} else {
			alert("<i18n:I18n defaultValue='已经退回,请待采购确认后再开发票！' key='i18n_enquiry_title_returnedAndConfirmAgainToInvoice'/>",2);
		}
	});
	
	//对账单-删除发票
	$("#invoiceDelBtn").click(function(){
		debugger;
		var busReconStatus = headGrid.rows()[0].busReconStatus;
		if(busReconStatus=='4'||busReconStatus=='5'){
			alert('<i18n:I18n defaultValue="发票全部确认,不能操作!" key="test"/>',1);
			return;
		}
		var invoiceItem = invoiceGrid.rowsLength() == 0 ? [] : invoiceGrid.rows();
		var selectedRowsIndex = invoiceGrid.selectedRowsIndex();
		var selectedRows = invoiceGrid.selectedRows();
		parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='对账单-删除发票中!' key='test'/>");
		debugger;
		//优化速度 @author jiangzhidong @date 20170111 begin
		var rows = invoiceGrid.rowsLength() == 0 ? [] : invoiceGrid.rows();
		var selectedRowsIndex = invoiceGrid.selectedRowsIndex();
		var dels = [];
		for(var i = 0 ; i < selectedRowsIndex.length; i++){
			dels.push(rows.splice(selectedRowsIndex[i]-i,1));
		}
		var str = JSON.stringify(dels);
		str = str.substring(1,str.length-1);
		//优化速度 @author jiangzhidong @date 20170111 end
		
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/delSaleBusReconInvoice",
			type :"post",
			contentType : "application/json",
			data : str,
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode == "-100") {
				     alert(data.message,3);
				 } else {
					 //优化速度 @author jiangzhidong @date 20170111 begin
					 invoiceGrid.load(rows);
					 //优化速度 @author jiangzhidong @date 20170111 end
					 alert("<i18n:I18n defaultValue='删除成功！' key='test'/>",1);
					 reGenerateHeadForInvoice();
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	
	//对账单-保存发票
	$("#invoiceSaveBtn").click(function(){
	   	var invoiceItem = invoiceGrid.rowsLength() == 0 ? [] : invoiceGrid.rows();
	   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='对账单-保存发票中!' key='i18n_label_additionCost_BusReconInvoiceInSave'/>");
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/saveSaleBusReconInvoice",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(invoiceItem),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode == "-100") {
				     alert(data.message,3);
				 } else {
					 alert("<i18n:I18n defaultValue='保存成功！' key='i18n_common_alert_savesuccess'/>",1);
					 reGenerateHeadForInvoice();
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	
	// 处理行金额-总发票金额 @author jiangzhidong @date 20170111 begin
	var reGenerateHeadForInvoice = function(){
		var invoiceItem = invoiceGrid.rowsLength() == 0 ? [] : invoiceGrid.rows();
		$.ajax({
		 url: '<%=basePath%>rest/SaleBusinessReconciliationService/reGenerateHeadForInvoice/',
		 type :"post",
		 contentType : "application/json",
		 data : JSON.stringify(invoiceItem),
		 dataType : "json",
		 success : function(data) {
				parent.elsDeskTop.hideLoading();
	 			debugger;
	 			if (data&&data.statusCode == "-100") {
	 			     alert(data.message,3);
	 			 } else {
	 				var totalInvoiceAmount = data.fbk4;
	 				var rows = headGrid.rows();
	 				rows[0]["totalInvoiceAmount"] = totalInvoiceAmount;
					headGrid.updateRow(rows[0],0);
	 			 }
	 		 },error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
    	});
	}
	// 处理行金额-总发票金额 @author jiangzhidong @date 20170111 end
	//------------- 发票相关---------- end ----------------
	
	function checkHeadStatus(){
		var busReconStatus = headGrid.rows()[0].busReconStatus;
		if(busReconStatus == "2"){
			$("#headTable").find("input").attr("readonly","readonly");
			$("#itemTable").find("input").attr("readonly","readonly");
			$("#fileTable").find("input").attr("readonly","readonly");
		}
	}
	
	function loadItem(elsAccount,toElsAccount,saleBusReconNumber) {
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	saleBusReconNumber : saleBusReconNumber
	    };
	    $.extend(itemGrid.opts.params,queryParam);
		itemGrid.load();
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
	
	var reconStartDate,reconEndDate,toElsAccount;
	function hasRequiredData(){
		var selectRow;
		if("undefined" == typeof(headSelectIndex)){
			selectRow = $("#headTable tbody tr").eq(0);//没有选中行默认选中第一行
		} else {
			selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		}
		reconStartDate = selectRow.find("input[name='reconStartDate']").val();
		reconEndDate = selectRow.find("input[name='reconEndDate']").val();
		toElsAccount = selectRow.find("input[name='toElsAccount']").val();
		if("undefined" != typeof(reconStartDate) && "" != reconStartDate
				&& "undefined" != typeof(reconEndDate) && "" != reconEndDate
				&& "undefined" != typeof(toElsAccount) && "" != toElsAccount){
			return true;
		} else {
			return false;
		}
	}
	
	//-------------业务对账明细   start----------
	itemGrid.on("loadSuccess",function(e,data){
		if(data.rows && data.rows.length > 0){
			reGenFileTypeSelect();
		}
	});
	
	function getSelectedHeadRow(){
		var selectRow;
		if("undefined" == typeof(headSelectIndex)){
			selectRow = $("#headTable tbody tr").eq(0);
		} else {
			selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		}
		return selectRow;
	}
	
	function formatNumeric(val,precision){
		if($.isNumeric(val)){
			if($.isNumeric(precision)){
				return parseFloat(val).toFixed(precision);
			} else {
				return parseFloat(val).toFixed(2);
			}
		} else {
			if($.isNumeric(precision)){
				return parseFloat("0").toFixed(precision);
			} else {
				return "0.00";
			}
		}
	}
	//-------------业务对账明细    end------------
	
	//提交保存数据
	$("#saveBtn").click(function(){
		var headRow = getSelectedHeadRow();
 		var saleBusReconHead = {
 	    		elsAccount : elsAccount,
 	    		elsDesc : elsDesc,
 	    		toElsAccount : headRow.find("input[name='toElsAccount']").val(),
 	    		toElsDesc : headRow.find("input[name='toElsDesc']").val(),
 	    		saleBusReconNumber : headRow.find("input[name='saleBusReconNumber']").val(),
 	    		purchaseBusReconNumber : headRow.find("input[name='purchaseBusReconNumber']").val(),
 	    		reconDate : headRow.find("input[name='reconDate']").val(),
 	    		postingDate : headRow.find("input[name='postingDate']").val(),
 	    		reconStartDate : headRow.find("input[name='reconStartDate']").val(),
 	    		reconEndDate : headRow.find("input[name='reconEndDate']").val(),
 	    		totalInvoiceAmount : headRow.find("input[name='totalInvoiceAmount']").val(),
 	    		totalTaxAmount : headRow.find("input[name='totalTaxAmount']").val(),
 	    		invoiceNumber : headRow.find("input[name='invoiceNumber']").val(),
 	    		totalAdditionAmount : headRow.find("input[name='totalAdditionAmount']").val(),
 	    		totalDeductionAmount : headRow.find("input[name='totalDeductionAmount']").val(),
 	    		currency : headRow.find("input[name='currency']").val(),
 	    		taxCode : headRow.find("input[name='taxCode']").val(),
 	    		taxRate : headRow.find("input[name='taxRate']").val(),
 	    		salePerson : headRow.find("input[name='salePerson']").val(),
 	    		purchasePerson : headRow.find("input[name='purchasePerson']").val(),
 	    		purchaseReceiveFactory : headRow.find("input[name='purchaseReceiveFactory']").val(),
 	    		fbk2 : headRow.find("input[name='purchaseCompanyCode']").val(),
 	    		fbk3 : headRow.find("input[name='purchaseCompanyName']").val(),
 	    		paymentWay : headRow.find("input[name='paymentWay']").val(),
 	    		paymentTime : headRow.find("input[name='paymentTime']").val(),
 	    		paymentBenchmarkDate : headRow.find("input[name='paymentBenchmarkDate']").val(),
 	    		paymentExpireDate : headRow.find("input[name='paymentExpireDate']").val(),
 	    		receiverCountryCode : headRow.find("input[name='receiverCountryCode']").val(),
 	    		receiverBankAccountName : headRow.find("input[name='receiverBankAccountName']").val(),
 	    		receiverBank : headRow.find("input[name='receiverBank']").val(),
 	    		receiverBankAccount : headRow.find("input[name='receiverBankAccount']").val(),
 	    		busReconStatus : headGrid.rows()[0].busReconStatus,
 	    		sendStatus : headGrid.rows()[0].sendStatus,
 	    		remark : headRow.find("input[name='remark']").val(),
 	    };
	   	
	   	var saleBusReconItem = itemGrid.rowsLength() == 0 ? [] : itemGrid.rows();
	   	var saleBusReconFile = fileGrid.rowsLength() == 0 ? [] : fileGrid.rows();
	   	var receiptItem = receiptGrid.rowsLength() == 0 ? [] : receiptGrid.selectedRows();
	   	var additionCostItem = additionCostGrid.rowsLength() == 0 ? [] : additionCostGrid.selectedRows();
	   	var deductionItem = deductionGrid.rowsLength() == 0 ? [] : deductionGrid.selectedRows();
	   	var invoiceItem = invoiceGrid.rowsLength() == 0 ? [] : invoiceGrid.selectedRows();
			   	
	   	var data = {
	   			saleBusReconHead : JSON.stringify(saleBusReconHead),
	   			saleBusReconItem : JSON.stringify(saleBusReconItem),
	   			saleBusReconFile : JSON.stringify(saleBusReconFile),
	   			receiptItem : JSON.stringify(receiptItem),
	   			additionCostItem : JSON.stringify(additionCostItem),
	   			deductionItem : JSON.stringify(deductionItem),
	   			invoiceItem : JSON.stringify(invoiceItem),
	   	}
	   	
	   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='对账单保存中!' key='i18n_label_additionCost_BusReconIsSaved'/>");
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/updSaleBusRecon",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存成功！' key='i18n_common_alert_savesuccess'/>",1);
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_returnParentPage" defaultValue="是否返回上级页面？" />',closeEvent:function(){
					parent.elsDeskTop.closeCurWin("saleBusReconUpd",callBack);
				}});
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存出错！' key='i18n_common_alert_saveError'/>",3);
			}
		});
	});
	
	//提交保存数据并发送
	$("#saveSendBtn").click(function(){
		var headRow = getSelectedHeadRow();
		var toElsAccount = headRow.find("input[name='toElsAccount']").val();
		if("undefined"==typeof(toElsAccount) || "" == toElsAccount){
	   		parent.elsDeskTop.tip.init({
			  type : 'alert',
			  displayType : 3,
			  message : "<i18n:I18n defaultValue='请选择对方ELS' key='i18n_label_additionCost_pleaseSelectToElsAccounts'/>"
			});
	   		return;
	   	}
		var saleBusReconHead = {
 	    		elsAccount : elsAccount,
 	    		elsDesc : elsDesc,
 	    		toElsAccount : headRow.find("input[name='toElsAccount']").val(),
 	    		toElsDesc : headRow.find("input[name='toElsDesc']").val(),
 	    		saleBusReconNumber : headRow.find("input[name='saleBusReconNumber']").val(),
 	    		purchaseBusReconNumber : headRow.find("input[name='purchaseBusReconNumber']").val(),
 	    		reconDate : headRow.find("input[name='reconDate']").val(),
 	    		postingDate : headRow.find("input[name='postingDate']").val(),
 	    		reconStartDate : headRow.find("input[name='reconStartDate']").val(),
 	    		reconEndDate : headRow.find("input[name='reconEndDate']").val(),
 	    		totalInvoiceAmount : headRow.find("input[name='totalInvoiceAmount']").val(),
 	    		totalTaxAmount : headRow.find("input[name='totalTaxAmount']").val(),
 	    		invoiceNumber : headRow.find("input[name='invoiceNumber']").val(),
 	    		totalAdditionAmount : headRow.find("input[name='totalAdditionAmount']").val(),
 	    		totalDeductionAmount : headRow.find("input[name='totalDeductionAmount']").val(),
 	    		currency : headRow.find("input[name='currency']").val(),
 	    		taxCode : headRow.find("input[name='taxCode']").val(),
 	    		taxRate : headRow.find("input[name='taxRate']").val(),
 	    		salePerson : headRow.find("input[name='salePerson']").val(),
 	    		purchasePerson : headRow.find("input[name='purchasePerson']").val(),
 	    		purchaseReceiveFactory : headRow.find("input[name='purchaseReceiveFactory']").val(),
 	    		fbk2 : headRow.find("input[name='purchaseCompanyCode']").val(),
 	    		fbk3 : headRow.find("input[name='purchaseCompanyName']").val(),
 	    		paymentWay : headRow.find("input[name='paymentWay']").val(),
 	    		paymentTime : headRow.find("input[name='paymentTime']").val(),
 	    		paymentBenchmarkDate : headRow.find("input[name='paymentBenchmarkDate']").val(),
 	    		paymentExpireDate : headRow.find("input[name='paymentExpireDate']").val(),
 	    		receiverCountryCode : headRow.find("input[name='receiverCountryCode']").val(),
 	    		receiverBankAccountName : headRow.find("input[name='receiverBankAccountName']").val(),
 	    		receiverBank : headRow.find("input[name='receiverBank']").val(),
 	    		receiverBankAccount : headRow.find("input[name='receiverBankAccount']").val(),
 	    		busReconStatus : headGrid.rows()[0].busReconStatus,
 	    		sendStatus : headGrid.rows()[0].sendStatus,
 	    		remark : headRow.find("input[name='remark']").val(),
 	    };
	   	
	   	var saleBusReconItem = itemGrid.rowsLength() == 0 ? [] : itemGrid.rows();
	   	var saleBusReconFile = fileGrid.rowsLength() == 0 ? [] : fileGrid.rows();
	   	var receiptItem = receiptGrid.rowsLength() == 0 ? [] : receiptGrid.selectedRows();
	   	var additionCostItem = additionCostGrid.rowsLength() == 0 ? [] : additionCostGrid.selectedRows();
	   	var deductionItem = deductionGrid.rowsLength() == 0 ? [] : deductionGrid.selectedRows();
	   	var invoiceItem = invoiceGrid.rowsLength() == 0 ? [] : invoiceGrid.selectedRows();
	   	if(receiptItem == 0){
	   		parent.elsDeskTop.tip.init({
			  type : 'alert',
			  displayType : 3,
			  message : "<i18n:I18n defaultValue='附加费用为空，不能发送' key=''/>"
			});
	   		return;
	   	}
		if(saleBusReconItem == 0){
	   		parent.elsDeskTop.tip.init({
			  type : 'alert',
			  displayType : 3,
			  message : "<i18n:I18n defaultValue='行项目为空，不能发送' key=''/>"
			});
	   		return;
	   	}	   	
	   	var data = {
	   			operate : "saveSend",
	   			saleBusReconHead : JSON.stringify(saleBusReconHead),
	   			saleBusReconItem : JSON.stringify(saleBusReconItem),
	   			saleBusReconFile : JSON.stringify(saleBusReconFile),
	   			receiptItem : JSON.stringify(receiptItem),
	   			//deliveryItem : JSON.stringify(deliveryItem),
	   			additionCostItem : JSON.stringify(additionCostItem),
	   			deductionItem : JSON.stringify(deductionItem),
	   			invoiceItem : JSON.stringify(invoiceItem),
	   	}
	   	
	   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='对账单保存发送中!' key='i18n_label_additionCost_BusReconIsTheSaveSent'/>");
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/SaleBusinessReconciliationService/sendSaleBusRecon",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存发送成功！' key='i18n_common_button_saveSendSuccess'/>",1);
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_returnParentPage" defaultValue="是否返回上级页面？" />',closeEvent:function(){
					parent.elsDeskTop.closeCurWin("saleBusReconUpd",callBack);
				}});
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存发送失败！' key='i18n_common_button_saveSendFail'/>",3);
			}
		});		
	});
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
	function callBack(){
		if(parent.frames['iframeApp_saleBusReconManage']) {
			parent.frames['iframeApp_saleBusReconManage'].init();
		}
	} 
	
	//选择负责人相关-----------------begin---------------
	var subAccountCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findSubAccountByNumber"/>;
	var queryPrincipalType = "sale";
	var queryPrincipalGrid;
	
	//本方负责人查询
	function showSalePerson(){
		$("#selectPrincipalDialog").show();
		
		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		var principal = selectRow.find("input[name='salePerson']").val();
		var principalArray = principal.split(";");//根据“;”获取以选择的负责人数组
		queryPrincipalType = "sale";
		
		if(queryPrincipalGrid){
			queryPrincipalGrid.load({elsAccount : elsAccount,station : "sale"});
		} else {
			queryPrincipalGrid = $("#select-principal-table").mmGrid({
			    cols: subAccountCols,
			    url: "${pageContext.request.contextPath}/rest/AccountService/subAccountList",
			    method: "post",
			    params : {elsAccount : elsAccount,station : "sale"},
			    root: "rows",
			    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
			    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
			    multiSelect: true,
			    checkCol: true,
			    indexCol:true
			});
		}
		
		var totalRows = queryPrincipalGrid.rows();
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
						queryPrincipalGrid.select(i);
						continue;
					}
				}
			}
		}
	}
	
	//选择负责人弹出框确认按钮单击事件
	$("#btnSelectPrincipalOK").click(function(){
		var selectedRows = queryPrincipalGrid.selectedRows();
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
			alert("<i18n:I18n defaultValue='至少选择一条记录！' key='i18n_common_title_selectAtLeastOneRecord'/>",2);
			return;
		}
		
		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		var principal = selectRow.find("input[name='salePerson']").val();
		if(queryPrincipalType == "sale"){
			selectRow.find("input[name='salePerson']").val(principals);
		} else if(queryPrincipalType == "purchase"){
			selectRow.find("input[name='purchasePerson']").val(principals);
		} else {
			// do nothing
		}
		
		$("#selectPrincipalDialog").hide();
	});
	
	$("#btnSelectPrincipalDialogClose").click(function(){
		$("#selectPrincipalDialog").hide();
	});
	
	$("#btnSelectPrincipalCancel").click(function(){
		$("#selectPrincipalDialog").hide();
	});
	
	//采购方负责人查询
	function showPurchasePerson(){
		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		var principal = selectRow.find("input[name='purchasePerson']").val();
		var principalArray = principal.split(";");//根据“;”获取已选择的负责人数组
		queryPrincipalType = "purchase";
		var toElsAccount = selectRow.find("input[name='toElsAccount']").val();
		if(toElsAccount == ""){
			alert("请先选择对方ELS！",2);
			return false;
		}
		
		$("#selectPrincipalDialog").show();
		if(queryPrincipalGrid){
			queryPrincipalGrid.load({elsAccount : toElsAccount,station : "purchase"});
		} else {
			queryPrincipalGrid = $("#select-principal-table").mmGrid({
			    cols: subAccountCols,
			    url: "${pageContext.request.contextPath}/rest/AccountService/subAccountList",
			    method: "post",
			    params : {elsAccount : toElsAccount,station : "purchase"},
			    root: "rows",
			    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
			    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
			    multiSelect: true,
			    checkCol: true,
			    indexCol:true
			});
		}
		
		var totalRows = queryPrincipalGrid.rows();
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
						queryPrincipalGrid.select(i);
						continue;
					}
				}
			}
		}
	}
	//选择负责人相关-----------------end---------------
	
	//查询对方ELS信息(只在好友列表中查询)
	var toElsCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
	var toElsGrid;
	function showToElsAccount(){
		$("#selectFriendElsAccountDialog").show();
		toElsGrid = $('#selectFriendElsAccountTable').mmGrid({
            cols : toElsCols,
            url : "${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsByType",
            params : {
            	elsAccount : elsAccount,
            	elsSubAccount : elsSubAccount,
            	groupIdAName : "<i18n:I18n defaultValue='客户' key='i18n_label_customer'/>"
            },
            method : "post",
            root : "rows",
            loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
            noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
            multiSelect : false,
            checkCol : true,
            indexCol :false
		});
		
		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		
		//var selectToElsAccount = $("#toElsAccount").val();
		var selectToElsAccount = selectRow.find("input[name='toElsAccount']").val();
		var totalRows = toElsGrid.rows();
		if(totalRows != null && totalRows != "" && selectToElsAccount){
			for(var i = 0 ; i < totalRows.length ; i ++){
					var toElsAccount = totalRows[i].friendElsAccount;
					var toElsDesc = totalRows[i].friendCompanyName;
					if(toElsAccount == selectToElsAccount){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
						toElsGrid.select(i);
						continue;
					}
			}
		}
	}
	
	//选择对方ELS确认按钮单击事件
	$("#selectFriendOKBtn").click(function(){
		var selectedRows = toElsGrid.selectedRows();
		if(selectedRows != "" ){
			$("#toElsAccount").val(selectedRows[0].friendElsAccount);
			$("#toElsDesc").val(selectedRows[0].friendCompanyName);
		}else{
			alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
			return;
		}
		$("#selectFriendElsAccountDialog").hide();
	});
	
	$("#selectFriendElsAccountDialogClose").click(function(){
		$("#selectFriendElsAccountDialog").hide();
	});
	
	$("#selectFriendCancelBtn").click(function(){
		$("#selectFriendElsAccountDialog").hide();
	});
	
	//查询采购工厂
	//var toElsCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
	var orgCols = [
	    	{title:"组织编码",name:"orgId",width:100,align:"left"},
	    	{title:"组织名称",name:"orgDesc",width:100,align:"left"},
	    ];
	var orgGrid,queryOrgType;
	function showOrgInfo(type){
		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		var principal = selectRow.find("input[name='purchasePerson']").val();
		var principalArray = principal.split(";");//根据“;”获取已选择的负责人数组
		queryPrincipalType = "purchase";
		var toElsAccount = selectRow.find("input[name='toElsAccount']").val();
		if(toElsAccount == ""){
			alert("<i18n:I18n defaultValue='请先选择对方ELS！' key='i18n_label_additionCost_pleaseSelectToElsAccounts'/>！",2);
			return false;
		}
		
		queryOrgType = type;
		$("#selectOrgCodeDialog").show();
		if("factory"==queryOrgType){
			$("#queryOrgCategoryId").val("factory");//默认组织类别为factory,可输入修改
			purchaseCompanyCode = $("#purchaseCompanyCode").val();
			$("#parentOrgId").val(purchaseCompanyCode);
		} else if("company"==queryOrgType){
			$("#queryOrgCategoryId").val("companyCode");//默认组织类别为companyCode,可输入修改
		} else {}
		orgGrid = $('#selectOrgCodeTable').mmGrid({
			cols : orgCols,
			url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/queryOrganizationInfo",
			method : "post",
			root : "rows",
			loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
			noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
			multiSelect : false,
			checkCol : true,
			indexCol :false
		});
	}
		
	$("#queryOrgCodeBtn").click(function(){
		queryOrgCode();
	});
	
	function queryOrgCode(){
		var queryOrgCategoryId = $("#queryOrgCategoryId").val();
		var queryOrgCategoryDesc = $("#queryOrgCategoryDesc").val();
		var queryOrgId = $("#queryOrgId").val();
		var queryOrgDesc = $("#queryOrgDesc").val();
		var parentOrgId = $("#parentOrgId").val();
		var params = {
			elsAccount : elsAccount,
			orgCategoryId : queryOrgCategoryId,
			orgCategoryDesc : queryOrgCategoryDesc,
			orgId : queryOrgId,
			orgDesc : queryOrgDesc,
			parentOrgId :parentOrgId,
			pageSize : 1000,
		};
		orgGrid.load(params);
		
		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		var selectOrg;
		if("factory"==queryOrgType){
			selectOrg = selectRow.find("input[name='purchaseReceiveFactory']").val();
		} else if("company"==queryOrgType){
			selectOrg = selectRow.find("input[name='purchaseCompanyCode']").val();
		} else {
		}
		var totalRows = orgGrid.rows();
		if(totalRows != null && totalRows != "" && "undefined"!=typeof(selectOrg)){
			for(var i = 0 ; i < totalRows.length ; i ++){
				var _orgId = totalRows[i].orgId;
				var _orgDesc = totalRows[i].orgDesc;
				if(selectOrg == _orgId){//判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
					orgGrid.select(i);
					continue;
				}
			}
		}
	}
		
	$("#selectOrgCodeOKBtn").click(function(){
		var selectedRows = orgGrid.selectedRows();
		if(selectedRows != "" ){
			$("#purchaseCompanyName").val(selectedRows[0].orgDesc);
			if("factory"==queryOrgType){
				$("#purchaseReceiveFactory").val(selectedRows[0].orgId);
			} else if("company"==queryOrgType){
				$("#purchaseCompanyCode").val(selectedRows[0].orgId);
			} else {
			}
		}else{
			alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
			return;
		}
		$("#selectOrgCodeDialog").hide();
	});

	$("#selectOrgCodeDialogClose").click(function(){
		$("#selectOrgCodeDialog").hide();
	});

	$("#selectOrgCodeCancelBtn").click(function(){
		$("#selectOrgCodeDialog").hide();
	});
	
    function clearAddFileInfo(){
    	$("#fileName").val("");
    	$("#filePath").val("");
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
   		var selectFileType = $("#selectFileType").val();
   		var saleBusReconItemNumber = "";
   		var fbk1 = "";
   		if("all" ==  selectFileType){//选择所有下拉列表时添加文件无行项目
   		} else if("common" == selectFileType){//选择公共下拉列表时添加文件无行项目
   		} else {//选择行项目添加时
   			saleBusReconItemNumber = selectFileType;
   			var theItemRow = itemGrid.row(parseInt(saleBusReconItemNumber)-1);
   			fbk1 = theItemRow.purchaseOrderNumber+"_"+theItemRow.purchaseOrderItemNumber+"_"
   				+theItemRow.additionCostNumber+"_"+theItemRow.additionCostItemNumber;
   		}
   		var maker = elsSubAccount+"_"+userName;
   		var fileTableRows = fileGrid.rowsLength();
   		var fileSequence = fileTableRows+1;
   		
   		var item = {
   				fileSequence : fileSequence,
   				fileName : fileName,
   				filePath : filePath,
   				maker : maker,
   				elsAccount : elsAccount,
   				toElsAccount : toElsAccount,
   				toElsDesc : toElsDesc,
   				saleBusReconItemNumber : saleBusReconItemNumber,
   				fbk1 : fbk1
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
    
    function reGenFileTypeSelect(){
		var itemRowSize = itemGrid.rowsLength();
		var fileTypeSelect = $("#selectFileType");
		fileTypeSelect.empty();
		$("<option value='all'><i18n:I18n defaultValue='所有文件' key='i18n_common_select_filetype_all'/></option>").appendTo(fileTypeSelect);
		$("<option value='common'><i18n:I18n defaultValue='公共文件' key='i18n_common_select_filetype_public'/></option>").appendTo(fileTypeSelect);
		for(var i=0;i<itemRowSize;i++){
			var saleBusReconItemNumber = itemGrid.row(i).saleBusReconItemNumber;
			$("<option value='"+saleBusReconItemNumber+"'>"+saleBusReconItemNumber+"</option>").appendTo(fileTypeSelect);//文件下拉列表添加行项目选项
		}
		
		reGentFileRow();
	}
    
    function reGentFileRow(){
    	var itemRows = itemGrid.rows();
    	var fileRows = [];
    	if (fileGrid) {
    		fileRows = fileGrid.rows();
    	}
    	var delFileIndexArr = [];
    	for(var i=0;i<fileGrid.rowsLength();i++){
    		var saleBusReconItemNumber = fileRows[i].saleBusReconItemNumber;
    		if(saleBusReconItemNumber!=""){
	    		var fbk1 = fileRows[i].fbk1;
	    		var isFileKeep = false;
	    		for(var j=0;j<itemRows.length;j++){
	    			var checkValue = itemRows[j].purchaseOrderNumber+"_"+itemRows[j].purchaseOrderItemNumber+"_"
	    				+itemRows[j].additionCostNumber+"_"+itemRows[j].additionCostItemNumber;
	    			if(fbk1 == checkValue ){
	    				isFileKeep = true;
	    			}
	    		}
	    		if(!isFileKeep){
	    			delFileIndexArr.push(i);
	    		}
    		}
    	}
    	if(delFileIndexArr.length > 0){
	    	fileGrid.removeRow(delFileIndexArr);
    		$("#viewerPlaceHolder").empty();
    	}
    	reGenerateFileSequence();
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
    		fileUploader.on( "uploadError", function( obj, reason  ) {
     	  	   	var errorMessage = response.message;
     	  	        alert(reason,3); 
     	  	});
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
				var itemNumber = fileGrid.row(index).saleBusReconItemNumber;
				if("" == itemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		} else {//显示指定行项目下的文件
			$("#fileTable tr").each(function(index,domElement){
				var itemNumber = fileGrid.row(index).saleBusReconItemNumber;
				if(selectFileType == itemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		}
	}
   
   $("#headDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleBusReconAddHead_mt&window=iframeApp_saleBusReconUpd",
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
			iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleBusReconAddItem_mt&window=iframeApp_saleBusReconUpd",
			showAdv : true,
			advArr : ["icon/test-car.png","icon/test-car2.png"],
			windowMinWidth : 480,
			windowMinHeight : 600,
			windowWidth :480,
			windowHeight :600,
			parentPanel : ".currDesktop"
		});
   });
	
</script>
</body>
</html>