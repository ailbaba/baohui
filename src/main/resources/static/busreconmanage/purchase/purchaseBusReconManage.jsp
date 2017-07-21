<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<base:supplierAuth elsAccount="${elsAccount }" authCode="busRecon" toElsAccount="${param['toElsAccount'] }"></base:supplierAuth>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">  
html, body   { height:100%; }  
body { margin :0; padding:0; overflow:auto ; }    
#flashContent { display :none; } 
</style> 
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
			        <span><i18n:I18n key="i18n_common_label_operationType" defaultValue="操作类型" />：</span>
			        <select id="operationType">
			           <option value="2"><i18n:I18n key="i18n_busRecon_select_busReconStatus_allConfirm" defaultValue="采购方已确认" /></option>
			           <option value="6" ><i18n:I18n key="i18n_busRecon_select_busReconStatus_invoiceAllConfirm" defaultValue="发票已确认" /></option>
			           <option value="7"><i18n:I18n key="i18n_busRecon_select_busReconStatus_reject" defaultValue="退回" /></option>
			        </select>
                     <button id="btnConfirm" class="button-wrap" ><i18n:I18n key="i18n_common_button_submit" defaultValue="提交" /></button>
                     <button id="queryBusRecon" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                <!-- <button id="btnRefresh" class="button-wrap"><i18n:I18n key="i18n_common_button_refresh" defaultValue="刷新" /></button>
				     <i18n:I18n key="" defaultValue="ERP预制发票" /> 
                     <i18n:I18n key="" defaultValue="取消ERP发票" />
                     <button id="delInvoiceBtn" class="button-wrap">冲销ERP</button> -->
					 <button id="parkingInvoiceBtn" class="button-wrap">预制发票</button>
                     <button class="button-wrap" id="columnDefineBtn"><i18n:I18n defaultValue="帐单头列自定义" key="test"/></button>
	                 <button class="button-wrap" id="itemDefineBtn"><i18n:I18n defaultValue="帐单行列自定义" key="test"/></button>
			         <button class="button-wrap" id="receiptDefineBtn"><i18n:I18n defaultValue="收货列自定义" key="test"/></button>
			         <button class="button-wrap" id="additionalDefineBtn"><i18n:I18n defaultValue="附加费列自定义" key="test"/></button>
			          <button class="button-wrap" id="deductDefineBtn"><i18n:I18n defaultValue="扣款费列自定义" key="test"/></button>
                 </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_busRecon_label_purchaseBusReconNumber" defaultValue="采购对账单号" />：</span><input id="purchaseBusReconNumber" name="purchaseBusReconNumber" type="text" style="width:200px;"/>
			       <span><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input id="purchaseOrderNumber" name="purchaseOrderNumber" type="text" style="width:200px;"/>
			       <span><i18n:I18n key="" defaultValue="ERP发票凭证号" />：</span><input id="erpInvoiceVoucherNumber" name="erpInvoiceVoucherNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip pos-relative">
			       <span><i18n:I18n key="i18n_enquiry_label_supplier" defaultValue="供应商" />：</span><input id="toElsAccount" name="toElsAccount" type="text" style="width:200px;padding-right:20px;" onkeyup="value=value.replace(/[^(\d,)]/g,'')"/>
			       <img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="querySupplier" title='<i18n:I18n key="i18n_common_title_querySupplier" defaultValue="查找供应商" />' />
		        </div>
		        <br>
		        <div id="div-busReconStatus" class="dis-in-b input-and-tip">
                    <span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="对账单状态" />： </span>
<!--                     <input type="hidden" id="busReconStatusParam" name="busReconStatusParam"/> -->
                    <select id="busReconStatusSelector" multiple="multiple">
                		<option value="0"><i18n:I18n key="" defaultValue="新建" /></option>
                		<option value="1"><i18n:I18n key="" defaultValue="采购方部分确认" /></option>
                		<option value="2"><i18n:I18n key="" defaultValue="采购方全部确认" /></option>
                		<option value="3"><i18n:I18n key="" defaultValue="部分开票" /></option>
                		<option value="4"><i18n:I18n key="" defaultValue="全部开票" /></option>
                		<option value="5"><i18n:I18n key="" defaultValue="发票部分确认" /></option>
                		<option value="6"><i18n:I18n key="" defaultValue="发票全部确认" /></option>
                		<option value="7"><i18n:I18n key="" defaultValue="退回" /></option>
                		<option value="8"><i18n:I18n key="" defaultValue="取消" /></option>
                	</select>
                </div>
                <div id="div-sendStatus" class="dis-in-b input-and-tip">
                    <span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="发送状态" />： </span>
                    <input type="hidden" id="sendStatusParam" name="sendStatusParam"/>
                    <select id="sendStatusSelector" multiple="multiple">
                		<option value="0"><i18n:I18n key="i18n_label_notSent" defaultValue="未发送" /></option>
                		<option value="1"><i18n:I18n key="i18n_label_Sent" defaultValue="已发送" /></option>
                	</select>
                </div>
		        <div class="dis-in-b">
            		<span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="是否上传ERP" />： </span><input name="isUploadERP" id="isUploadERP" type="checkbox" value="" />
            	</div>
		        <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="对账日期" />：</span></div>
                <input type="radio" name="dateArea" value="week" checked><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" />
                <input type="radio" name="dateArea" value="month" checked="checked"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
                <input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
                <input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate"/></div>
                <div class="dis-in-b input-and-tip" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate" /></div>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_busRecon_title_busReconHeadInfo" defaultValue="业务对账单头" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-busrecon-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="对账单明细信息" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="test" defaultValue="对账单行项目" /></a></li>
                        <li><a href="#sheet-project-two" class="scan-file-sheet"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n key="i18n_busRecon_title_receiptDetail" defaultValue="收货明细" /></a></li>
                        <li><a href="#sheet-project-five"><i18n:I18n key="i18n_busRecon_title_additionalChargeDetail" defaultValue="附加费明细" /></a></li>
                        <li><a href="#sheet-project-six"><i18n:I18n key="i18n_busRecon_title_deductMoneyDetail" defaultValue="扣款明细" /></a></li>
                        <li><a href="#sheet-project-seven"><i18n:I18n key="i18n_busRecon_title_invoiceDetail" defaultValue="发票明细" /></a></li>
                    </ul>
                    <div id="sheet-project-one" style="padding: 1px;">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="reCreate">
		                        <table id="table-busrecon-item"></table>
		                        <div id="pg-item" style="text-align: right;"></div>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two" style="padding: 1px;">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="add-file-project"></table>
											<div id="enquiryFilePage" style="text-align: right;"></div>
										</div>
									</main>
			                    </div>
				                 <div class="file-scan">
		   							 <div class="file-option-zoom">
		   							     <button id="btnAddFile" class="button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增" /></button>
		   							     <button id="downloadFile" class="button-wrap"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
				                         <button id="btnDeleteFile" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button>
				                         <button id="btnSendFile" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
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
		                    <div class="grid-100" id="reCreateInvoice">
		                        <table id="table-busrecon-invoice"></table>
		                        <div id="pg-invoice" style="text-align: right;"></div>
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
        
        
        
  <div class="fixed-dialog" id="selectSupplierDialog" >
	<div class="dialog-tip bg-common" style="width: 480px;height:400px;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectSupplierDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectSupplierDialog"><i18n:I18n key="i18n_enquiry_title_supplierinformation" defaultValue="供应商选择" /></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="select-supplier-table"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="btnSelectSupplierOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnSelectSupplierCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<div class="fixed-dialog" id="addFileDialog">
           <div class="dialog-tip bg-common" style="width: 322px;height: 220px; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <div class="input-and-tip">
                                <span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件分类" />：</span>
                                <select id="tableFileType">
                                     <option value="0"><i18n:I18n key="i18n_busRecon_select_fileType_head" defaultValue="按订单头" /></option>
                                     <option value="1"><i18n:I18n key="i18n_busRecon_select_fileType_line" defaultValue="按订单行" /></option>
                                </select>
                           </div>
                           <div class="input-and-tip" id="lineItmeSelect">
                              <!--  <span>行项目：</span>
                                <select id="tableFileType1">
                                     <option value="0">按订单头按订单头按订单头按订单头按订单头</option>
                                     <option value="1">按订单行按订单头按订单头按订单头按订单头按</option>
                                </select> -->
                           </div>
	                       <div class="input-and-tip text-right">
		                       <input id="fileType" name="fileType" type="hidden" />
		                       <input id="fileName" name="fileName" type="hidden" />
		                       <input id="filePath" name="filePath" type="hidden" />
	                       </div>
	                       <div class="mt-20 text-center">
	                          <span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></div></span>
	                       </div>
                       </div>
                   </div>
               </div>
          </div>
      </div>
</div>
<div class="fixed-dialog" id="selectPrincipalDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectPrincipalDialogClose"></div>
	    <input type="hidden" id="rowIndex"/>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectPrincipalDialog"><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filtercondition" defaultValue="过滤条件" /></span>
	            <input type="hidden" id="purchasePersonBak">
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td width="80px"><input  type="text" id="principalName" name="principalName" /></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="select-principal-table"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="btnSelectPrincipalOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnSelectPrincipalCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>  


<script>
var headGrid;
var itemGrid;
var editFileTable;
var selectSupplierTable; 
var selectPrincipalTable;
var invoiceTable;
var receiptGrid;
var additionCostGrid;
var deductionGrid;
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var userName = "<%=session.getAttribute("username")%>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var toElsAccount =<%=request.getParameter("toElsAccount")%>;
var purchaseBusReconNumber =<%=request.getParameter("purchaseBusReconNumber")%>;
var rowIndexSelect=0; 
var $sob;

$().ready(function(){
	$sob = $('.saying-dialog .option-bar');
	init();
	$("#busReconStatusSelector").SumoSelect({optAfter:'#div-busReconStatus',optCancel:'#div-busReconStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
    $("#sendStatusSelector").SumoSelect({optAfter:'#div-sendStatus',optCancel:'#div-sendStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	window.beforeClose = function(close){
	    top.elsDeskTop.tip.init({
	        type            : 'confirm',
	        displayType     : 2, 
	        message         : '<i18n:I18n key="i18n_common_alert_confirmTheShutDown" defaultValue="确认关闭" />?',
	        closeEvent : function () {
	           close();
	        }
	    });
	};
});

/****  自定义列编辑字段 start  *****/
var initQuantity = function(val,item,index) {
}
//获取日期
function getDate(dates){
	var dd = new Date();
	dd.setDate(dd.getDate()+dates);
	return dd.format("yyyy-MM-dd");
}
//查询时的日期点击事件
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
//日期格式渲染 yyyy-MM-dd
function rendererDate(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
	return val;
}
//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}
//日期格式渲染 yyyy-MM-dd 如果为空默认当前日期
function initInputDate(val,item,index){
	if(!val){
		val = new Date().format("yyyy-MM-dd");
	}else{
		val = new Date(val).format("yyyy-MM-dd");
	}
	var name = $(this)[0].name;
	if(item.busReconStatus == "0"){ //只有对账单状态为新建时才允许修改
		return '<input class="Wdate" onfocus="WdatePicker({minDate: \'%y-%M-%d\'})" style="width:46px;height: 14px;"  name="'+name+'_'+index+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	}else{
		return val;
	}
	
}
//渲染input框 可任意输入
function initInput(val,item,index){
	if(!val) { val = '';}
	var name = $(this)[0].name;
	if(name == "purchaseRemark" && item.itemStatus == "0" || name == "purchaseReceiveFactory" && item.busReconStatus == "0"  ){
	   return '<input class="nest-report" style="width:100px;height: 20px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
    }else{
    	return val;
    }
}

//渲染input框 可任意输入
function initInvoicePurchaseRemark(val,item,index){
	if(!val) { val = '';}
	if(item.checkStatus == "0"){ //只有发票状态为未核对时才允许编辑
	    return '<input class="nest-report-remark" style="width:100px;height: 20px;"  name="invoicePurchaseRemark" id="invoicePurchaseRemark_'+index+'" type="text" value="'+val+'"/>';
	}else{
		return val;
	}
}

function initItemPurchaseRemark(val,item,index){
	if(!val) { val = '';}
	if(item.itemStatus == "0" ){ 
	    return '<input class="nest-report-remark" style="width:100px;height: 20px;"  name="purchaseRemark" id="purchaseRemark_'+index+'" type="text" value="'+val+'"/>';
	}else{
		return val;
	}
}

//单纯输入框失去焦点事件
$('.nest-report-remark').live('blur',function(e) {
	var val = $(this).val();
	if(val != "" && val != null){
		$('body').data('marker',true);
	}
});

//单纯输入框失去焦点事件
$('.nest-report-remark').live('click',function(e) {
	var val = $(this).val();
	if(val != "" && val != null){
		$('body').data('marker',true);
	}
});

//渲染input框 仅可输入小数点跟数字
function initInputDouble(val,item,index){
	if(!val) { val = '';}
	var name = $(this)[0].name;
	if(item.busReconStatus == "0"){ //只有对账单状态为新建时才允许修改
	   return '<input class="nest-report" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:100px;height: 20px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	}else{
		return val;
	}
}

//渲染税码 默认J1
function initTaxCode(val,item,index){
	val = 'J1';
	var name = $(this)[0].name;
	if(item.busReconStatus == "0"){ //只有对账单状态为新建时才允许修改
	    return '<input class="nest-report" style="width:100px;height: 20px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	}else{
	    return val;
	}
}
//渲染税率 默认17
function initTaxRate(val,item,index){
	val = '17';
	var name = $(this)[0].name;
	if(item.busReconStatus == "0"){ //只有对账单状态为新建时才允许修改
	    return '<input class="nest-report" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:100px;height: 20px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	}else{
		return val;
	}
}

//渲染订单发送状态
function rendererSendStatus(val){
	if(val == 0){
		return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
	}else if(val == 1){
		return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
	}else{
		return "";
	}
}
//渲染订单状态
function rendererBusReconStatus(val){
	if(val == 0){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_new" defaultValue="新建" />';
	}else if(val == 1){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_partConfirm" defaultValue="采购方部分确认" />';
	}else if(val == 2){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_allConfirm" defaultValue="采购方已确认" />';
	}else if(val == 3){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_partBilling" defaultValue="部分开票" />';
	}else if(val == 4){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_allBilling" defaultValue="全部开票" />';
	}else if(val == 5){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_invoicePartConfirm" defaultValue="发票部分确认" />';
	}else if(val == 6){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_invoiceAllConfirm" defaultValue="发票全部确认" />';
	}else if(val == 7){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_reject" defaultValue="退回" />';
	}else if(val == 8){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_cancelOrDelete" defaultValue="取消或删除" />';
	}
}
//渲染查看对账单历史按钮
function rendererBusReconHis(val, item, rowIndex){
	return '<span class="busReconHis-detail" style="cursor: pointer;color:blue;"><i18n:I18n key="i18n_common_label_history" defaultValue="历史" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
}
/****  自定义列编辑字段 end  *****/

//打开询价单明细页面
$('.busReconHis-detail').live("click", function() {
     var scanCol = $(this).next();
     var sanContent = scanCol.text();
     var item = JSON.parse(sanContent);
    	//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_03.gif',
	        'windowsId':'PurchaseBusReconHis',
	        'windowTitle':'<i18n:I18n key="i18n_busRecon_label_purchaseBusReconHistoryCheck" defaultValue="采购对账单历史记录查看"/>',
	        'windowSubTitle': companyShortName,
	        'iframSrc':'<%=basePath%>busreconmanage/purchase/purchaseBusReconHis.jsp?purchaseBusReconNumber='+item.purchaseBusReconNumber+
    		'&elsAccount='+elsAccount+  
    		'&toElsAccount='+item.toElsAccount,
	        'showAdv': false,
	         windowStatus: 'maximized',
	        'windowMinWidth': 960,
	        'windowMinHeight': 600,
	        'windowPositionTop':10,
	        'windowWidth':960,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
    	
 });
 
 
//选择负责人相关-----------------begin---------------
var colsPrincipal = [
	                { title:'<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号"/>', name:'elsSubAccount' , width:110, align:'center'},
	                { title:'<i18n:I18n key="i18n_common_title_username" defaultValue="用户名称"/>', name:'name' , width:100, align:'center'}
	                
	            ];

function selectPrincipal(val, item, rowIndex){
	if(item.busReconStatus == "0"){ //只有对账单状态为新建时才允许修改
	   return '<input class="selectPrincipal" style="width:100px;height: 20px;"  name="purchasePerson" id="purchasePerson_'+rowIndex+'" type="text" value="'+val+'"/>';
	}else{
		return val;
	}
}

//触发负责人弹出框事件，并用负责人文本框数据初始化窗口table的选中数据
$('.selectPrincipal').live("click", function() {
	$("#selectPrincipalDialog").show();
	if(selectPrincipalTable == null){
		selectPrincipalTable=$('#select-principal-table').mmGrid({
		    cols: colsPrincipal,
		    url: "<%=basePath%>rest/AccountService/subAccountList",
		    params: {"elsAccount":elsAccount,"station":"purchase","pageSize":"10000"},
		    method: 'post',
		    root: 'rows',
		    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
		    noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
		    multiSelect: true,
		    checkCol: true,
		    indexCol:true
		});
		
		selectPrincipalTable.on('loadSuccess', function(e, data){
	    	selectedByInput();
		});
	}
	var rowIndex = $(this).closest("tr").index();
	$("#rowIndex").val(rowIndex);
	var purchasePerson = $("#purchasePerson_"+rowIndex).val();
	$("#purchasePersonBak").val(purchasePerson);
	selectedByInput();
});

//用责任人框值初始化选中责任人列表的值
function selectedByInput(){
	var purchasePerson = $("#purchasePersonBak").val();
	var principalArray = purchasePerson.split(";");//根据“;”获取以选择的负责人数组
	var totalRows = selectPrincipalTable.rows();
	selectPrincipalTable.deselect('all');
	if(totalRows != "" &&totalRows != null && principalArray){
		for(var i = 0 ; i < totalRows.length ; i ++){
			for(var j = 0 ; j < principalArray.length ; j ++ ){
				var elsSubAccount = totalRows[i].elsSubAccount;
				var name = totalRows[i].name;
				var _principal = principalArray[j];
				var _principalArray = _principal.split("_");
				var _elsSubAccount = _principalArray[0];
				var _name = _principalArray[1];
				if(elsSubAccount == _elsSubAccount && name == _name){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
					selectPrincipalTable.select(i);
					continue;
				}
			}
		}
	}
}

//模糊查询键入事件
$("#principalName").keyup(function(){
	var principalName = $("#principalName").val();
	selectPrincipalTable.load({"elsAccount":elsAccount,"station":"purchase","name":principalName,"pageSize":"10000"});
});

//选择负责人弹出框确认按钮单击事件
$("#btnSelectPrincipalOK").click(function(){
	var selectedRows = selectPrincipalTable.selectedRows();
	var principals ="";
	var fbk4 = $("#purchasePersonBak").val();
	var fbk4Array = fbk4.split(";");
	
	 //循环去重
	for(var i = 0 ; i < fbk4Array.length ; i ++){
		for(var j = 0 ; j < selectedRows.length ; j ++){
			var _principal = fbk4Array[i];
			var _principalArray = _principal.split("_");
			var _elsSubAccount = _principalArray[0];
			var elsSubAccount = selectedRows[j].elsSubAccount;
			if(elsSubAccount == _elsSubAccount){ //判断该行数据是否已经在负责人文本框中，如果有则去除重复数据
				selectedRows.splice(j,1);
				continue;
			}
		}
	}
	//移除已选中的数据，判断依据若责任人在fbk4input框中且又在过滤后的责任人的列表中且状态不是选中状态，则认为该责任人是要从fbk4责任人框中移除的
	var rows = selectPrincipalTable.rows();
	var selectedRowsIndex = selectPrincipalTable.selectedRowsIndex();
	for(var i = selectedRowsIndex.length-1 ; i >= 0 ; i --){
		rows.splice(selectedRowsIndex[i],1); //去掉选中的行
	}
	for(var i = 0 ; i < rows.length ; i ++){
		for(var j = 0 ; j < fbk4Array.length ; j ++){
			var _principal = fbk4Array[j];
			var _principalArray = _principal.split("_");
			var _elsSubAccount = _principalArray[0];
			var elsSubAccount = rows[i].elsSubAccount;
			if(elsSubAccount == _elsSubAccount){ //判断该行数据是否已经在负责人文本框中，如果有则移除
				fbk4Array.splice(j,1);
				continue;
			}
		}
	}
	for(var i = 0 ; i < fbk4Array.length ; i ++){
		if(i == 0){
			principals += fbk4Array[i];
		}else{
			principals += ";"+fbk4Array[i];
		}
	}
	for(var i = 0 ; i < selectedRows.length ; i ++){
		var singleRow = selectedRows[i];
		var elsSubAaccount = singleRow.elsSubAccount;
		var name = singleRow.name;
		if(i == 0){
			if(principals == ""){
				principals += elsSubAaccount+"_"+name;
			}else{
				principals += ";"+elsSubAaccount+"_"+name;
			}
		}else{
		    principals += ";"+elsSubAaccount+"_"+name;
		}
	}
	
    if(principals != ""){
    	var rowIndex = $("#rowIndex").val();
    	$("#purchasePerson_"+rowIndex).val(principals);
    }else{
    	alert('<i18n:I18n key="i18n_common_alert_selectAtLeastOneRecord" defaultValue="至少选择一条记录！" />',0);
	    return;
    }
	$("#selectPrincipalDialog").hide();
});

$("#btnSelectPrincipalDialogClose").click(function(){
	$("#selectPrincipalDialog").hide();
});
$("#btnSelectPrincipalCancel").click(function(){
	$("#selectPrincipalDialog").hide();
});
//选择负责人相关-----------------end---------------

//行项目确认状态渲染
function rendererItemStatus(val,item,rowIndex) {
	if(val == "1"){
	    return '<i18n:I18n key="i18n_common_select_confirmStatus_confirmed" defaultValue="已确认"/>';
	}else if(val == "2"){
        return '<i18n:I18n key="i18n_common_select_confirmStatus_rejected" defaultValue="已拒绝"/>'
    }else{
        return '<i18n:I18n key="i18n_common_select_confirmStatus_unconfirmed" defaultValue="未确认"/>';
    }
}
//发票核对状态渲染
function rendererCheckStatus(val,item,rowIndex) {
	if(val == "1"){
	    return '<i18n:I18n key="i18n_common_select_checkStatus_checked" defaultValue="已核对"/>';
	}else{
        return '<i18n:I18n key="i18n_common_select_checkStatus_unchecked" defaultValue="未核对"/>';
    }
}

//根据所选择的对账单头状态初始化操作类型下拉框  0新建、1采购方部分确认、2采购方已确认、3部分开票、4全部开票、5发票部分确认、6发票全部确认、7退回、8取消或删除
function initOperationTypeSelect(busReconStatus){
	$("#operationType").empty();
	var option = '';
	var option1 ='<option value="2"><i18n:I18n key="i18n_busRecon_select_busReconStatus_allConfirm" defaultValue="采购方已确认"/></option>';
	var option2 ='<option value="6" ><i18n:I18n key="i18n_busRecon_select_busReconStatus_invoiceAllConfirm" defaultValue="发票已确认"/></option>';
	var option3 ='<option value="7"><i18n:I18n key="i18n_busRecon_select_busReconStatus_reject" defaultValue="退回"/></option>';
	$("#btnConfirm").attr('disabled',false);
	$("#operationType").attr('disabled',false);
	if(busReconStatus == "0" || busReconStatus == "1" ){
		option += option1;
		option += option3;
	}else if(busReconStatus == "2" || busReconStatus == "3"){
		option += option3;
	}else if(busReconStatus == "4" || busReconStatus == "5"){
		option += option2;
	}else{
		$("#btnConfirm").attr('disabled',true);
		$("#operationType").attr('disabled',true);
	}
	$("#operationType").append(option);
}

//采购方对账单头信息表
var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseBusRecon_head_mt"/>;

//采购方对账单行信息表
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseBusRecon_item_mt"/>;

var colsfile = [
                { title:'<i18n:I18n key="i18n_busRecon_title_purchaseBusReconItemNumber" defaultValue="对账单行项目号"/>', name:'purchaseBusReconItemNumber' , width:60, align:'center'},
                { title:'<i18n:I18n key="i18n_common_title_fileSequence" defaultValue="表单文件行编号"/>', name:'fileSequence' , width:100, align:'center'},
                { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>', name:'fileName' ,width:90, align:'center'},
                { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>', name:'filePath' ,width:90, align:'center',hidden:true},
                { title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳"/>', name:'logtime' ,width:140, align:'center',renderer:rendererTime},
                { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="文件发送状态"/>', name:'sendStatus' ,width:120, align:'center',renderer:rendererSendStatus},
                { title:'<i18n:I18n key="i18n_enquiry_title_maker" defaultValue="制单人"/>', name:'maker' ,width:100, align:'center'}
         ];
           
//初始化控件
function init() {
	 //初始化控件
    $( '#sheet-project').tabs();
	 //初始化时间
    changeDateArea();
    $("[name=dateArea]").click(changeDateArea);
    //初始化ERP是否上传的值
    $("#isUploadERP").change(function(){
    	var isUploadERPs = (''+~~this.checked);
    	$("#isUploadERP").val(isUploadERPs);
    });
   //对账单头列表
    var param = {'elsAccount':elsAccount,'toElsAccount':toElsAccount,'purchaseBusReconNumber':purchaseBusReconNumber};
    //初始化文件列表
    editFileTable=$('#add-file-project').mmGrid({
	    cols: colsfile,
	    url: '<%=basePath%>rest/PurchaseBusinessReconciliationService/findPurchaseBusReconFileList',
	    params: param,
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    indexCol: true,
	    checkCol:true,
	    multiSelect:false,
	    plugins: [
              $('#enquiryFilePage').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                  , limit: null
                  , limitList: [10,15,20]
              })
          ]
	});
    editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
  		var seled=editFileTable.selectedRows();
		if(seled && seled.length) {
			var filePath = item.filePath;
			if(filePath && filePath.length) {
				previewFile(filePath);
			} else {
				alert('<i18n:I18n key="i18n_enquiry_alert_notfoundfilepath" defaultValue="服务器异常，找不到文件上传的路径"/>',3);
			}
		}
  	}); 
    //初始化表单发票列表
    var colsInvoice = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseBusRecon_invoice_mt"/>; 
    invoiceTable=$('#table-busrecon-invoice').mmGrid({
	    cols: colsInvoice,
	    url: '<%=basePath%>rest/PurchaseBusinessReconciliationService/findPurchaseBusReconInvoiceList',
	    params: param,
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    indexCol: true,
	    multiSelect:false,
	    plugins: [
              $('#pg-invoice').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                  , limit: null
                  , limitList: [10,15,20]
              })
          ]
	});
  //收货信息列
	var receiptCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="queryReceipt_item_mt"/>;
	receiptGrid = $('#receiptTable').mmGrid({
	    cols : receiptCols,
	    url : "<%=basePath%>rest/SaleBusinessReconciliationService/queryReceiptItemForBusRecon",
	    method : 'post',
	    root : "rows",
	    autoLoad : false,
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
	    checkCol : true,
	    indexCol : false
	});
	
	receiptGrid.on("loadSuccess", function(e, data){
		debugger;
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
	
	//附加费用信息列
	var additionCostCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageItem_mt"/>;
	additionCostGrid = $('#additionCostTable').mmGrid({
	    cols : additionCostCols,
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
	
	additionCostGrid.on("loadSuccess", function(e, data){
		debugger;
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

	//扣款信息列
	var deductionCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageItem_mt"/>;
	deductionGrid = $('#deductionTable').mmGrid({
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
	
    deductionGrid.on("loadSuccess", function(e, data){
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
    		var rows = data.rows;
    		for(var i=0;i<rows.length;i++){
    			var saleBusReconNo = rows[i].saleBusReconNumber;
    			if("undefined"!=typeof(saleBusReconNo) && saleBusReconNo != null &&  saleBusReconNo != ""){
    				deductionGrid.select(i);
    			}
    		}
    		$("#deductionTable input[type='checkbox']").attr("disabled","disabled");
        	//$("#deductionTable input").attr("onclick","return false;");
    	}
  	});
	
	//初始化对账单行信息表
    itemGrid = $('#table-busrecon-item').mmGrid({
        cols: cols_item,
        height:<base:tableHeight tableCode="purchaseBusRecon_item_mt"/>,
        url : '<%=basePath%>rest/PurchaseBusinessReconciliationService/findPurchaseBusReconItemList',
        params: param,
        method:  'POST',
        root:"rows",
        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",       
        indexCol:true,
        plugins: [
            $('#pg-item').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                , limit:null
                , limitList: [5,10,15,20]
            })
        ]
    });
    //初始化对账单头信息表
    window.headGrid = $('#table-busrecon-head').mmGrid({
        cols: cols_head,
        height:<base:tableHeight tableCode="purchaseBusRecon_head_mt"/>,
        url : '<%=basePath%>rest/PurchaseBusinessReconciliationService/findPurchaseBusReconHeadList',
        params: param,
        method:  'POST',
        root:"rows",
        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",       
        indexCol:true,
        checkCol:true,
        plugins: [
            $('#pg').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                , limit:null
                , limitList : [10,20,50,100]
            })
        ]
    });
    // 加载明细项
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	//加载行表
    	rowIndexSelect=rowIndex;
    	var selectRows = headGrid.selectedRows();
    	//判断行上是否有输入
    	var marker = $('body').data('marker');
   		if(marker){
   			debugger;
   			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_alert_unsaved" defaultValue="您有未保存的编辑项，切换后将清空，是否继续？"/>',closeEvent:function(){
   				load(item.elsAccount,item.toElsAccount,item.purchaseBusReconNumber);
   	    		// 动态加载聊天窗口
   	    		var hadSelected = headGrid.selectedRows();
   	    		if(hadSelected && hadSelected.length) {
   	    			initChat(hadSelected);
   	        	}
   	    		$('body').data('currentIndex',rowIndex);
       			$('body').data('marker',false);
   			},cancelEvent:function(){
       			var oldIndex = $('body').data('currentIndex');
       			headGrid.deselect(rowIndex);
       			headGrid.select(oldIndex);
       		  }});
   		}else{
    		// 动态加载聊天窗口
    		var hadSelected = headGrid.selectedRows();
    		if(hadSelected && hadSelected.length) {
    			debugger;
				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
				if(!ableToggleInit()) {
					$sob[0].storeInitChat=function(){initChat(hadSelected)};
				} else {
					initChat(hadSelected);
				}
				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 end
				load(item.elsAccount,item.toElsAccount,item.purchaseBusReconNumber,item.saleBusReconNumber,item.reconStartDate,item.reconEndDate);
        	} else {
        		debugger;
        		itemGrid.removeRow();
        		editFileTable.removeRow();
        		invoiceTable.removeRow();
        	}
    		$('body').data('currentIndex',rowIndex);
   			$('body').data('marker',false);
   		}
   		initOperationTypeSelect(item.busReconStatus);
    });
    headGrid.on('loadSuccess',function(e, data) {
    	if (data.rows && data.rows.length > 0) {
			$('body').data('currentIndex',0);//存放当前选择行
			var seled=headGrid.selectedRows();
			if(seled && seled.length) {
				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 begin
				$sob[0].storeInitChat=function(){initChat(seled)};
				// 1003-1578 展开加载聊天窗口 @author update/jiangzhidong @date 20170110 end
				if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
	            $sob.click();
			}
    	}else{
    		itemGrid.removeRow();
    		editFileTable.removeRow();
    		invoiceTable.removeRow();
    	}
    });
    
    
}

//加载item表
function load(elsAccount,toElsAccount,purchaseBusReconNumber,saleBusReconNumber,reconStartDate,reconEndDate) {
	var param = {
    	'elsAccount':elsAccount,
    	'toElsAccount':toElsAccount,
    	'purchaseBusReconNumber':purchaseBusReconNumber
    };
    itemGrid.opts.params = param;
    itemGrid.load({});
    editFileTable.opts.params = param;
    editFileTable.load({});
    invoiceTable.opts.params = param;
    invoiceTable.load({});
    loadReceipt(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate);
    loadAdditionCost(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate);
    loadDeduction(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate);
    
}
//加载收获列表
function loadReceipt(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate){
	var queryParam = {
			elsAccount : elsAccount,
			toElsAccount : toElsAccount,
			voucherType : "receipt",
			reconStartDate : new Date(reconStartDate).format("yyyy-MM-dd"),
			reconEndDate : new Date(reconEndDate).format("yyyy-MM-dd"),
			saleBusReconNumber : saleBusReconNumber
	};
	$.extend(receiptGrid.opts.params,queryParam);
	receiptGrid.load();
}
//费用单
function loadAdditionCost(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate){
	var queryParam = {
			elsAccount : toElsAccount,
			toElsAccount : elsAccount,
			additionCostType : "add",
			reconStartDate : new Date(reconStartDate).format("yyyy-MM-dd"),
			reconEndDate : new Date(reconEndDate).format("yyyy-MM-dd"),
			saleBusReconNumber : saleBusReconNumber
	};
	$.extend(additionCostGrid.opts.params,queryParam);
	additionCostGrid.load();
}
//扣款明细
function loadDeduction(elsAccount,toElsAccount,saleBusReconNumber,reconStartDate,reconEndDate){
	var queryParam = {
			elsAccount : toElsAccount,
			toElsAccount : elsAccount,
			additionCostType : "ded",
			reconStartDate : new Date(reconStartDate).format("yyyy-MM-dd"),
			reconEndDate : new Date(reconEndDate).format("yyyy-MM-dd"),
			saleBusReconNumber : saleBusReconNumber
	};
	$.extend(deductionGrid.opts.params,queryParam);
	deductionGrid.load();
}

$('#queryBusRecon').click(function() {
	var purchaseBusReconNumber = $("#purchaseBusReconNumber").val();
	var erpInvoiceVoucherNumber = $("#erpInvoiceVoucherNumber").val();
	var toElsAccount = $("#toElsAccount").val();
	var purchaseOrderNumber = $("#purchaseOrderNumber").val();
	var busReconStatusParam = $("#busReconStatusSelector").val();
	if(busReconStatusParam==null){
		busReconStatusParam= "";
	}else{
		busReconStatusParam = busReconStatusParam +"";
	}
	var sendStatusParam = $("#sendStatusSelector").val();
	if(sendStatusParam==null){
		sendStatusParam = "";
	}else{
		sendStatusParam=sendStatusParam +"";
	}
	var isUploadERP = $("#isUploadERP").val();
	var startOrderDate = $("#startOrderDate").val();
	var endOrderDate = $("#endOrderDate").val();
	var headParam = {
			"elsAccount":elsAccount,
			"toElsAccount":toElsAccount,
			"purchaseBusReconNumber":purchaseBusReconNumber,
			"erpInvoiceVoucherNumber":erpInvoiceVoucherNumber,
			"busReconStatusParam":busReconStatusParam,
			"sendStatusParam":sendStatusParam,
			"isUploadERP":isUploadERP,
			"startOrderDate":startOrderDate,
			"endOrderDate":endOrderDate,
			"purchaseOrderNumber":purchaseOrderNumber
		};
	headGrid.load(headParam);
});

$('#btnRefresh').click(function() {
	$("#queryBusRecon").trigger('click');
});
//初始化聊天窗口
//ELS账号+订单号 作为 businessID
//TODO: 聊天
function initChat(data) {
	debugger;
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
	  var url = "multiChat.jsp?type=multi&fromElsAccount="
				+ elsAccount
				+ "&fromElsSubAccount="
				+ elsSubAccount
				+ "&toElsAccount="
				+ toElsAccount
				+ "&toElsSubAccount="+toElsSubAccount
				+ "&businessType=busRecon"
				+ "&businessID="+businessId
                + "&list="+encodeURI(peopleListString)
				+"&t="+new Date().getTime();
	   
	   $(".testIframe").attr("src","${pageContext.request.contextPath}/"+ url);
	   //滚动条美化niceScroll
	   //$(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"10px"});
}
//---------------文件展示----begin------------------
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
//---------------文件展示----end------------------

//选择供应商相关-----------------begin---------------
    
    function i18n(val,item,index){
	   if(val){
		   var arrayVal = val.split(":");
		   if(arrayVal.length == 2){
			   return '<i18n:I18n key="'+arrayVal[0]+'" defaultValue="'+arrayVal[1]+'"/>';
		   }else{
			   return val;
		   }
	   }else{
		   return "";
	   }
    }
    
    var colsSupplier = [
		                { title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="对方ElS帐号"/>', name:'friendElsAccount' , width:120, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_suppliername" defaultValue="对方公司名称"/>', name:'friendCompanyName' , width:100, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_supplierStairType" defaultValue="对方公司一级类型"/>', name:'groupIdAName' , width:100, align:'center',renderer:i18n},
		                { title:'<i18n:I18n key="i18n_common_title_supplierSecondType" defaultValue="对方公司二级类型"/>', name:'groupIdBName' , width:100, align:'center'}
		            ];
    //触发供应商弹出框事件，并用供应商文本框数据初始化窗口table的选中数据
    $("#querySupplier").click(function(){
    	$("#selectSupplierDialog").show();
    	if(!selectSupplierTable){
    		selectSupplierTable=$('#select-supplier-table').mmGrid({
    	        cols: colsSupplier,
    	        url: "<%=basePath%>rest/FriendsService/findMyFriendsByType",
    	        params: {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"},
    	        method: 'post',
    	        height:280,
    	        root: 'rows',
    	        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    	        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    	        multiSelect: true,
    	        checkCol: true,
    	        indexCol:true
    	    });
    	}
    });
    //选择供商弹出框确认按钮单击事件
    $("#btnSelectSupplierOK").click(function(){
    	var selectedRows = selectSupplierTable.selectedRows();
    	var suppliers ="";
    	if(selectedRows != "" ){
    		for(var i = 0 ; i < selectedRows.length ; i ++){
    			var singleRow = selectedRows[i];
    			var elsAccount = singleRow.friendElsAccount;
    			if(i == 0){
    				suppliers += elsAccount;
    			}else{
    				suppliers += ","+elsAccount;
    			}
    		}
    	}
    	$("#toElsAccount").val(suppliers);
    	$("#selectSupplierDialog").hide();
    });
    $("#btnSelectSupplierDialogClose").click(function(){
    	$("#selectSupplierDialog").hide();
    });
    $("#btnSelectSupplierCancel").click(function(){
    	$("#selectSupplierDialog").hide();
    });
//选择供应商相关-----------------end---------------

$("#parkingInvoiceBtn").click(function(){
	var headRows = headGrid.selectedRows();//获取所选择行数据数组
    var headIndexs = headGrid.selectedRowsIndex();//获取所选择行索引数组
    if("undefined" != typeof(headRows) && headRows != ""){
    	var headRow = headRows[0];// 获取对账单头信息，因为表格设置为单选，所以这里最多是一行数据
    	debugger;
    	headRow['elsSubAccount'] = elsSubAccount;
/*     	<i18n:I18n key="i18n_alert_confirmParkingInvoice" defaultValue="是否确认预制发票"/> */
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认上传ERP',closeEvent:function(){
			parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_sending" defaultValue="预制中"/>');
			$.ajax({
    			url :"${pageContext.request.contextPath}/rest/PurchaseBusinessReconciliationService/generateErpInvoice",
    			type :"post",
    			contentType : "application/json",
    			data : JSON.stringify(headRow),
    			dataType : "json",
    			success : function(data) {
    				parent.elsDeskTop.hideLoading();
    				if("200"==data.statusCode){
/*     					<i18n:I18n key="i18n_alert_parkingInvoiceSuccess" defaultValue="ERP预制发票成功"/> */
	    				if(data.integrateCode && data.integrateCode == "purchaseGenerateErpInvoice")
	    					alert('上传ERP成功',1);
	    				else
	    					alert('上传ERP成功.发票号:'+data.invoiceNumber,1);
	    				$("#queryBusRecon").trigger('click');//刷新数据显示
    				} else {
    					alert(data.message,3);
    				}
    			},
    			error : function(data) {
    				parent.elsDeskTop.hideLoading();
    				alert('<i18n:I18n key="i18n_alert_parkingInvoiceFail" defaultValue="ERP预制发票失败"/>',3);
    			}
    		});
		}});
    }else{
    	alert("请选择一行对账单",2);
    }
});

$("#delInvoiceBtn").click(function(){
	var headRows = headGrid.selectedRows();//获取所选择行数据数组
    var headIndexs = headGrid.selectedRowsIndex();//获取所选择行索引数组
    if("undefined" != typeof(headRows) && headRows != ""){
    	var headRow = headRows[0];// 获取对账单头信息，因为表格设置为单选，所以这里最多是一行数据
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_confirmDeleteInvoice" defaultValue="是否确认删除ERP预制发票"/>',closeEvent:function(){
			parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_sending" defaultValue="发送中"/>');
			$.ajax({
    			url :"${pageContext.request.contextPath}/rest/PurchaseBusinessReconciliationService/delErpInvoice",
    			type :"post",
    			contentType : "application/json",
    			data : JSON.stringify(headRow),
    			dataType : "json",
    			success : function(data) {
    				parent.elsDeskTop.hideLoading();
    				if("200"==data.statusCode){
	    				alert('<i18n:I18n key="i18n_alert_deleteInvoiceSuccess" defaultValue="删除ERP预制发票成功"/>',1);
	    				$("#queryBusRecon").trigger('click');//刷新数据显示
    				} else {
    					alert(data.message,3);
    				}
    			},
    			error : function(data) {
    				parent.elsDeskTop.hideLoading();
    				alert('<i18n:I18n key="i18n_alert_deleteInvoiceFail" defaultValue="删除ERP预制发票失败"/>',3);
    			}
    		});
		}});
    }
});

//答复供应商对账结果--------------begin--------------
//TODO 提交对账单
$("#btnConfirm").click(function(){
	
    var selectHeadRows = headGrid.selectedRows();//获取所选择行数据数组
    var indexs = headGrid.selectedRowsIndex();//获取所选择行索引数组
	var busReconItemVOs = [];//用于存放对账单行数据
	var busReconInvoiceVOs = [];//用于存放对账单发票数据
    if(selectHeadRows != ""){
    	var headRow = selectHeadRows[0];// 获取对账单头信息，因为表格设置为单选，所以这里最多是一行数据
    	var index = indexs[0];//获取所选行索引
    	var operationType = $("#operationType").val();//获取操作类型
    	if(headRow.busReconStatus == "0"){ //只有单据状态为0的时候才允许有输入值
    	   headRow = headInputSetValue(headRow,index);//获取表单中input框输入值
    	}
    	headRow["elsAccount"]=elsAccount;
		//headRow["elsDesc"]=userName;
    	var itemRows = itemGrid.rows();//获取对账单头下所有行数据
    	var fielRows = editFileTable.rows(); //获取对账单下所有文件信息
    	var invoiceRows = invoiceTable.rows();//获取对账单下所有发票信息
    	if(itemRows != ""){
    		for( var i = 0 ; i < itemRows.length ; i ++ ){
    			var itemRow = itemRows[i];
    			if(itemRow.itemStatus == "0"){//只有状态为0的时候才允许有输入
    			    itemRow = itemInputSetValue(itemRow,i);//获取表单中input框输入值
    			}
    			busReconItemVOs.push(itemRow);
    		}
    		headRow["busReconItemVOs"]=busReconItemVOs;
    		headRow["busReconFileVOs"]=fielRows;
    		if(invoiceRows != ""){
    			for(var i = 0 ; i < invoiceRows.length ; i ++){
    				var invoiceRow = invoiceRows[i];
    				if(invoiceRow.checkStatus == "0"){ //只有状态为0的时候才允许有输入
    				    invoiceRow = invoiceInputSetValue(invoiceRow,i);//获取表单中input框输入值
    				}
    				busReconInvoiceVOs.push(invoiceRow);
    			}
    		}
    		headRow["busReconInvoiceVOs"]=busReconInvoiceVOs;
    		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_alert_reallySent" defaultValue="是否确认发送"/>',closeEvent:function(){
    			headRow["busReconStatus"]=operationType;
    			parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_sending" defaultValue="发送中"/>');
    			$.ajax({
        			url :"<%=basePath%>rest/PurchaseBusinessReconciliationService/replySaleBusRecon",
        			type :"post",
        			contentType : "application/json",
        			data : JSON.stringify(headRow),
        			dataType : "json",
        			success : function(data) {
        				parent.elsDeskTop.hideLoading();
        				alert('<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功"/>！',1);
        				$("#queryBusRecon").trigger('click');
        			},
        			error : function(data) {
        				parent.elsDeskTop.hideLoading();
        				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错"/>',0);
        			}
        		});
    		}});
    	} else {
    		parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="" defaultValue="没有业务对账单行信息！"/>'});
    	}
    }else{
    	parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选需要择操作的对账单！"/>'});
    }
    
});

function itemInputSetValue(itemLine,index){
    //获取采购方填写备注信息
    var purchaseRemark = $("#purchaseRemark_"+index).val();
    itemLine["purchaseRemark"]=purchaseRemark;
    return itemLine;
}

function invoiceInputSetValue(ivoiceLine,index){
    //获取采购方填写发票备注信息
    var purchaseRemark = $("#invoicePurchaseRemark_"+index).val();
    ivoiceLine["purchaseRemark"]=purchaseRemark;
    return ivoiceLine;
}

function headInputSetValue(headLine,index){
    //获取过账日期
    var postingDate = $("#postingDate_"+index).val();
    headLine["postingDate"]=postingDate;
    //获取税额
    var totalTaxAmount = $("#totalTaxAmount_"+index).val();
    headLine["totalTaxAmount"]=totalTaxAmount;
    //获取采购方负责人
    var purchasePerson = $("#purchasePerson_"+index).val();
    headLine["purchasePerson"]=purchasePerson;
    //获取采购方收获工厂
    var purchaseReceiveFactory = $("#purchaseReceiveFactory_"+index).val();
    headLine["purchaseReceiveFactory"]=purchaseReceiveFactory;
    //获取税码
    var taxCode = $("#taxCode_"+index).val();
    headLine["taxCode"]=taxCode;
    //获取税率
    var taxRate = $("#taxRate_"+index).val();
    headLine["taxRate"]=taxRate;
    return headLine;
}
//答复供应商对账结果--------------end--------------

//新增文件----------------begin-----------------
var fileUploader;
$("#btnAddFile").click(function(){
	var selectHeadRows = headGrid.selectedRows();
	if(selectHeadRows != ""){
		$('body').data('headRow',selectHeadRows[0]);
		$("#addFileDialog").show();
		initFileUploader(fileUploader);
		$("#tableFileType").find("option[value='0']").attr("selected",true);
		$('#lineItmeSelect').html("");
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选需要择操作的对账单！"/>'});
	}
});

$("#tableFileType").change(function(){
 	var tableFileType = $("#tableFileType").val();
 	//if lineItmeSelect
 	if(tableFileType == "1"){
 		var itemRows = itemGrid.rows();
 		if(itemRows != "" && itemRows != null){
 			$('#lineItmeSelect').html('<span>表单行项目：</span><select id="itemLineNumber"></select>');
 			var option ="";
 			for(var i = 0 ; i < itemRows.length ; i ++ ){
 				var itemRow = itemRows[i];
 				option += '<option value='+ itemRow.purchaseBusReconItemNumber+' >'+itemRow.purchaseBusReconItemNumber+"_"+itemRow.purchaseMaterialNumber+"_"+itemRow.purchaseMaterialDesc+'</option>';
 			}
 			$('#itemLineNumber').append(option);
 		}
 	}else{
 		$('#lineItmeSelect').html("");
 	}
});

$("#addFileBtnOK").click(function(){
 	$("#addFileDialog").hide();
 	var filePath = $("#filePath").val();
});

function initFileUploader(fileUploader){
    //新增表单文件
    if (!fileUploader) {
  	fileUploader = WebUploader.create({
  	    // swf文件路径
  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
  	    auto: true,
  	    // 文件接收服务端。
  	    server: '<%=basePath%>servlet/UploadServlet',
  	    // 选择文件的按钮。可选。
  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
  	    pick: '#btnFileUpload',
  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
  	    resize: false,
  	    formData : {
	     	elsAccount : elsAccount	    
	     	 }
  	});
    // 当有文件添加进来的时候
	fileUploader.on("fileQueued",function(file){
		var fileName = file.name;
		$("#fileName").val(fileName);
	});
    //文件上传成功
	fileUploader.on( 'uploadAccept', function( obj, response ) {
	  	   var filePath = response.url;
	  	   var size = response.size;
	  	   var fileName = $("#fileName").val();
	  	   var headRow = $('body').data('headRow');
	  	   var elsAccount = headRow.elsAccount;
	  	   var toElsAccount = headRow.toElsAccount;
	  	   var purchaseBusReconNumber = headRow.purchaseBusReconNumber;
	  	   var toElsDesc = headRow.toElsDesc;
	  	   var tableFileType = $("#tableFileType").val();
	  	   var purchaseBusReconItemNumber = "";
	       if(tableFileType == "1"){
	    	   purchaseBusReconItemNumber = $('#itemLineNumber').val();
	       }
	       var param = {"filePath":filePath,"fileName":fileName,"elsAccount":elsAccount,"toElsAccount":toElsAccount,
	    		   "purchaseBusReconNumber":purchaseBusReconNumber,"toElsDesc":toElsDesc,"purchaseBusReconItemNumber":purchaseBusReconItemNumber,
	    		   "sendStatus":"0","maker":userName};
	       $.ajax({
				url :"<%=basePath%>rest/PurchaseBusinessReconciliationService/addPurchaseBusReconFile",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify(param),
				success : function(data) {
					var param = {
					    	'elsAccount':elsAccount,
					    	'toElsAccount':toElsAccount,
					    	'purchaseBusReconNumber':purchaseBusReconNumber
					    };
					editFileTable.load(param);
					$("#addFileDialog").hide();
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
	                parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错"/>'});
	            }
			});
	       
	});
  }
}
//移除表单文件按钮
$("#btnDeleteFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	var elsAccount;
	var toElsAccount;
	var purchaseBusReconNumber;
	if(selectRows.length != 0){
		for(var i = 0 ; i < selectRows.length ; i++ ){
			singleRow = selectRows[i];
			var sendStatus = singleRow.sendStatus;
			if(sendStatus != "0"){
				selectRows.splice(i,1);//只能移除状态等于0的 也就是新建未发送的文件
			}
		}
		if(selectRows.length == 0){
			parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_common_alert_onlyRemoveNotSend" defaultValue="Only remove the state is not send file !"/>'});
			return;
		}
		elsAccount = selectRows[0].elsAccount;
		toElsAccount = selectRows[0].toElsAccount;
		purchaseBusReconNumber = selectRows[0].purchaseBusReconNumber;
		$.ajax({
			url :"<%=basePath%>rest/PurchaseBusinessReconciliationService/removePurchaseBusReconFile",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(selectRows),
			success : function(data) {
				var param = {
				    	'elsAccount':elsAccount,
				    	'toElsAccount':toElsAccount,
				    	'purchaseBusReconNumber':purchaseBusReconNumber
				    };
				editFileTable.load(param);
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
                parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错"/>'});
            }
		});
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选需要择操作的数据！"/>'});
	}
});
//发送表单文件按钮
$("#btnSendFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	var elsAccount;
	var toElsAccount;
	var purchaseBusReconNumber;
	if(selectRows.length != 0){
		for(var i = 0 ; i < selectRows.length ; i++ ){
			singleRow = selectRows[i];
			var sendStatus = singleRow.sendStatus;
			if(sendStatus != "0"){
				selectRows.splice(i,1);//只能发送状态等于0的 也就是新建未发送的文件
			}
		}
		if(selectRows.length == 0){
			parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_common_alert_onlySendNotSend" defaultValue="Only send the state is not send file !"/>'});
			return;
		}
		elsAccount = selectRows[0].elsAccount;
		toElsAccount = selectRows[0].toElsAccount;
		purchaseBusReconNumber = selectRows[0].purchaseBusReconNumber;
		$.ajax({
			url :"<%=basePath%>rest/PurchaseBusinessReconciliationService/sendPurchaseBusReconFile2Seller",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(selectRows),
			success : function(data) {
				var param = {
				    	'elsAccount':elsAccount,
				    	'toElsAccount':toElsAccount,
				    	'purchaseBusReconNumber':purchaseBusReconNumber
				    };
				editFileTable.load(param);
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
                parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错"/>'});
            }
		});
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选需要择操作的数据！"/>'});
	}
});
//关闭按钮处理
$("#dialogFileClose").click(function(){
	$("#addFileDialog").hide();
});
//新增文件----------------end-----------------

$("#columnDefineBtn").click(function(){
parent.elsDeskTop.defineWin({
    'iconSrc':'icon/els-icon.png',
    'windowsId':'subAccountColumnSetting',
    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
    windowSubTitle: "",
    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseBusRecon_head_mt" + "&window=iframeApp_PurchaseBus",
    windowMinWidth: 480,
    windowMinHeight: 600,
    'windowWidth':480,
    'windowHeight':600,
    'parentPanel':".currDesktop"
 });
});
$("#itemDefineBtn").click(function(){
  parent.elsDeskTop.defineWin({
    'iconSrc':'icon/els-icon.png',
    'windowsId':'subAccountColumnSetting',
    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
    windowSubTitle: "",
    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseBusRecon_item_mt" + "&window=iframeApp_PurchaseBus",
    windowMinWidth: 480,
    windowMinHeight: 600,
    'windowWidth':480,
    'windowHeight':600,
    'parentPanel':".currDesktop"
  });
});
$("#receiptDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
		iconSrc : "icon/els-icon.png",
		windowsId :"subAccountColumnSetting",
		windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		windowSubTitle : "",
		iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryReceipt_item_mt&window=iframeApp_PurchaseBus",
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
		iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryDelivery_item_mt&window=iframeApp_PurchaseBus",
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
		iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageItem_mt&window=iframeApp_PurchaseBus",
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
		iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageItem_mt&window=iframeApp_PurchaseBus",
		showAdv : true,
		advArr : ["icon/test-car.png","icon/test-car2.png"],
		windowMinWidth : 480,
		windowMinHeight : 600,
		windowWidth :480,
		windowHeight :600,
		parentPanel : ".currDesktop"
	});
});

$("#downloadFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
	    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选需要择操作的数据！"/>'});
	}
	
 });
</script>

</body>
</html>