<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String contractNumber = request.getParameter("contractNumber"); %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">
html, body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
}

#flashContent {
	display: none;
}

table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
				key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<button id="send" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
	
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_basicData" defaultValue="基本数据" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="add-enq-sheet">
					<ul>
						<li><a href="#edit-line-baseInfo"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></a></li>
						<li class = "materialcontent"><a href="#edit-line-bail"><i18n:I18n key="i18n_common_title_billofmaterials" defaultValue="物料清单" /></a></li>
						<li class="edit-line-content"><a href="#edit-line-content"><i18n:I18n key="i18n_common_title_contractterms" defaultValue="合同条款" /></a></li>
<!-- 						<li><a href="#edit-line-invited">受邀方</a></li>
        				<li class="add-file-sheet"><a href="#edit-line-file"><i18n:I18n key="test" defaultValue="表单文件" /></a></li> -->
					</ul>
					<form id="form" onsubmit="return false;">
					<!-- 基本信息 -->
					<div id="edit-line-baseInfo">
					 <table>
				    	<tbody>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_contractcode" defaultValue="合同编码" />:</td>
				    			<td colspan="1" align="left">
				    				<input id="contractNumber" name="contractNumber" type="text" style="width: 200px;" disabled="disabled" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型" />:</td>
				    			<td colspan="1" align="left">
									<input id="contractTypeCode" name="contractTypeCode" type="text" readonly="readonly" style="width: 300px;" placeholder="选择合同类型" class = "findTemplate"/>
									<!-- <img src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;left: 251px;top: 70px;cursor: pointer;" class="findTemplate" title="选择合同类型" /> -->
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_contracName" defaultValue="合同名称" />:</td>
				    			<td colspan="1" align="left">
									<input id="contractDesc" name="contractDesc" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_contractsigningdate" defaultValue="合同签订日期" />:</td>
				    			<td colspan="1" align="left">
				    			<input type="text" class="Wdate" onfocus="WdatePicker()" id="contractSignedDate" name="contractSignedDate" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_contractcommencementdate" defaultValue="合同生效日期" />:</td>
				    			<td colspan="1" align="left">
				    			<input type="text" class="Wdate" onfocus="WdatePicker()" id="contractStartDate" name="contractStartDate"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_contractterminationdate" defaultValue="合同终止日期" />:</td>
				    			<td colspan="1" align="left">
				    			<input type="text" class="Wdate" onfocus="WdatePicker()" id="contractEndDate" name="contractEndDate"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_label_currencyType" defaultValue="币种" />:</td>
				    			<td colspan="1" align="left">
									<input id="currency" name="currency" type="text" style="width: 200px;" />
								</td>
				    		</tr>
							<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_advancepaymentamount" defaultValue="预付款金额" />:</td>
				    			<td colspan="1" align="left">
									<input id="paymentAmount" name="paymentAmount" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_cumulativePaymentAmount" defaultValue="累计付款金额" />:</td>
				    			<td colspan="1" align="left">
									<input id="totalPaymentAmount" name="totalPaymentAmount" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_contracttotalamount" defaultValue="合同总金额" />:</td>
				    			<td colspan="1" align="left">
									<input id="totalContractAmount" name="totalContractAmount" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_contractstatus" defaultValue="合同状态" />:</td>
				    			<td colspan="1" align="left">
									<input id="contractStatus" name="contractStatus" type="text" style="width: 200px;" />
								</td>
				    		</tr>		
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_assesstemplate_table_templateVersionNumber" defaultValue="版本号" />:</td>
				    			<td colspan="1" align="left">
									<input id="contractVersion" name="contractVersion" type="text" style="width: 200px;" readonly = "readonly"/>
								</td>
				    		</tr>		
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_purchasecontactphone" defaultValue="采购联系人电话" />:</td>
				    			<td colspan="1" align="left">
									<input id="purchaseContactPhone" name="purchaseContactPhone" type="text" style="width: 200px;" />
								</td>
				    		</tr>				    		
				    		
				    	</tbody>
				      </table>
					</div>
					</form>
					
					<!-- 物料清单-->
				   <div id="edit-line-bail">
				  		<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line">
								<button id="addMaterialItem" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
 								<button id="removeMaterialItem" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
							</div>
							<main class="grid-container">
							<div class="grid-100">
								<table id="materialTable"></table>
							</div>
							</main>
						</div>
					</div>
					
					<!-- 合同条款 -->
					<div id="edit-line-content">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line">
								<button id="addItem" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
								<button id="removeItem" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
							</div>
							<main class="grid-container">
							<div class="grid-100">
								<table id="contractTable"></table>
							</div>
							</main>
						</div>
					</div>
					
					<!-- 受邀方 
					<div id="edit-line-invited">
						<div class="supplie-groud">
							<div class="bg-common contacts-box">
								<div class="tip-head pos-relative">
									 <span
										class="dialogTitle"><i18n:I18n
											key="i18n_common_title_addcontact" defaultValue="添加供应商" /></span> 
									<button class="button-wrap sure-selct"
										style="position: absolute; right: 44px; top: 11px;">
										<i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" />
									</button>
								</div>
								<div class="box-wrap pos-relative bg-common">
									<span class="dis-in-b pos-absolute" style="left: 16px;">可添加供应商列表：</span>
									<input class="dis-in-b pos-absolute contact-search" type="text"
										style="left: 16px; width: 220px; max-width: 220px; padding-right: 20px;"
										placeholder="输入查找关键字" /> <img class="dis-in-b pos-absolute"
										src="../../img/icon_search.png"
										style="width: 14px; left: 244px; top: 14px;" /> <span
										class="dis-in-b pos-absolute" style="left: 345px;"><i18n:I18n
 											key="i18n_common_title_alreadyaddcontact" 
 											defaultValue="已添加的供应商列表" />：</span> 
									<div class="fl-left box-left mt-27"></div>
									<div class="fl-left box-middle mt-27">
										<p class="all-pre text-center">
											<button class="contact-option-btn button-wrap" title="全部右移">>></button>
										</p>
										<p class="all-back text-center">
											<button class="contact-option-btn button-wrap" title="全部左移"><<</button>
										</p>
									</div>
									<div class="fl-left box-right mt-27"></div>
									<div class="clear-both"></div>
								</div>
							</div>
						</div>
					</div>-->
					
					<!-- 表单文件 
					<div class="p-zero" id="edit-line-file">
				        <div class="box-wrap pos-relative bg-common">
						            <div class="common-box-line p-zero">
						                <div class="pos-relative upload-wrap">
						                    <div class="pos-absolute file-list">
												<main class="grid-container">
													<div class="grid-100" id="reCreateFile">
														<table id="add-file-project"></table>
													</div>
												</main>
						                    </div>
							                 <div class="file-scan">
					   							 <div class="file-option-zoom">
								                  <div class="dis-in-b text-left">
								                  	<button id="uploadFile" class="button-wrap">上传</button>
								                  	<button id="downloadFile" class="button-wrap">下载</button>
										            <button id="lookFile" class="button-wrap">在线查看</button>
										         </div>
											     </div>
											     <div class="file-display" id="file-display">
											     <a id="viewerPlaceHolder"></a>
											     </div>
											</div>
									</div>
									</div>
						 </div>
				    </div> -->
					
				</div>
			</div>
		</div>
		
		<div class="fixed-dialog">
		<div class="dialog-tip bg-common" style="width: 353px;height: 200px;margin-left: -251px;margin-top: -190px;">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span>
							<input id="fileName" name="fileName" type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload">
							<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" />
							</div></span>
							<input id="filePath" name="filePath" type="hidden" />
							<input id="fileSize" name="fileSize" type="hidden" />
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
var editFileTable;
var rightScroll;
var leftScroll;
var uploader;
var fileUploader;
var contractTable;
var materialTable;
var editFileTable;
var elsAccount = "<%=session.getAttribute("elsAccount")%>" ;
var contractNumber = "<%= contractNumber %>";
var contractManageClauseVODelList = [];
var contractManageMaterialVODelList = [];
//用于判断内容是否一致匹配来判断是否修改
var beginFormJson = [];
var endFormJson = [];


//渲染   @author jiangzhidong 20160120  begin
	//合同状态
	function rendererBiddingStatus(val){
    	if(val==0){
    		return '<i18n:I18n key="i18n_common_lable_notstart" defaultValue="未开始" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
    	}else if(val==1){
    		return '<i18n:I18n key="i18n_requirementsPlanning_select_carriedOut" defaultValue="进行中" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
    	}else if(val==2){
    		return '<i18n:I18n key="i18n_common_title_alreadyBid" defaultValue="已定标" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
    	}else if(val==3){
    		return '<i18n:I18n key="i18n_label_alreadyFinish" defaultValue="已完成" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
    	}
	}
	//只允许数字输入框
	var initInputNumber = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+'"/>';
	};
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//允许任何字符输入框bak
	var initInputAnyBak = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'Bak" id="'+this.name+'_'+index+'Bak" value="'+val+'"/>';
	};
	//允许任何字符输入框  readonly
	var initInputAnyReadonly = function(val, item, index){
		if(!val) { val = '';}
		return '<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//企业名称
	var initCompanyName = function (val, item, index){
	 	if(!val) { val = '';}
	 	var name = this.name;
	 	var value = this.value;
			return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
	}
	//日期input
	var formatDateInput = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return '<input type="text" id="'+this.name+'_'+index+'" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
	};
	//时间input
	var formatDateTimeInput = function (val, item, index){
		if(!val) { val = '';}
		return '<input type="text" id="'+this.name+'_'+index+'" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
	};
	//转化日期格式
	var formatDate = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};
	//转化日期格式
	var formatDate = function (val){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};
	
	//模板下载 input
	var initFbk1 = function(val, item, index){
		if (!val) {val = "<i18n:I18n key="i18n_common_title_Pleaseselectorhandin" defaultValue="请选择或手工录入" />";}
		if(val) {var arr=val.split("_"); if(arr.length>=3) val = arr[2];}
		return '<input readonly="readonly" class="fbk1" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//模板提交input
	var initTemplatePath = function(val, item, index){
		if (!val) {val = "<i18n:I18n key="i18n_common_title_Pleaseselectorhandin" defaultValue="请选择或手工录入" />";}
		if(val) {var arr=val.split("_"); if(arr.length>=3) val = arr[2];}
		return '<input readonly="readonly" class="templatePath" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//审批方式 select
	var initAuditModeSelect = function(val,item,index) {
		//1-审批流 2-自动 3-人工
		var selected = '<select name="auditModeSelect" id="auditModeSelect"  style="color:blue; min-width:70px; padding:5px;">'
						+'<option value="1"><i18n:I18n key="i18n_title_auditflow" defaultValue="审批流" /></option>'
						+'<option value="2"><i18n:I18n key="i18n_title_autoaudit" defaultValue="自动" /></option>'
						+'<option value="3"><i18n:I18n key="i18n_title_artificialaudit" defaultValue="人工" /></option></select>'
		return selected;
	};
	
	//合同状态
	var initAuditStatus = function (val,item,index){
		//0:审批通过  1:未审批  2:审批中  3:审批拒绝
		if (val == "0") return '<i18n:I18n key="i18n_common_button_create" defaultValue="新建" />'
		else if (val == "1") return '<i18n:I18n key="i18n_requirementsPlanning_select_carriedOut" defaultValue="进行中" />'
		else if (val == "2") return '<i18n:I18n key="i18n_common_title_contractsigning" defaultValue="合同签订" />';
		else if (val == "3") return '<i18n:I18n key="i18n_js_close" defaultValue="关闭" />';
	};
	//合同状态 select
	var initcontractStatusSelect = function(val,item,index) {
		if(item.auditMode==3){
			var sel=' selected="true"';
			var selected = '<select name="auditStatusSelect" id="auditStatusSelect" style="color:blue; min-width:70px;"><option value="0"';
			if(val==0) selected = selected +sel;
			selected =selected + '><i18n:I18n key="i18n_common_button_create" defaultValue="新建" /></option><option value="1"'
			if(val==1) selected = selected +sel;
			selected =selected + '><i18n:I18n key="i18n_requirementsPlanning_select_carriedOut" defaultValue="进行中" /></option><option value="2"'
			if(val==2) selected = selected +sel;
			selected =selected + '><i18n:I18n key="i18n_common_title_contractsigning" defaultValue="合同签订" /></option><option value="3"'
			if(val==3) selected = selected +sel;
			selected =selected + '><i18n:I18n key="i18n_js_close" defaultValue="关闭" /></option></select>'
			return selected;
		}
		return initAuditStatus(val,item,index);
	};
	//总评分  人工
	var initTotalScore = function(val, item, index){
		if (!val) {val = "";}
		return '<div style="color: red;">' +val+ '</div>';
	};
	//发送状态
	var initSendStatus = function (val,item,index){
		//0:未发送 1:已发送
		if (val=="0") return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
	    else if (val == "1") return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
		
	};

	//供应商els帐号
	var initSupplierElsAccount = function (val,item,index){
		return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	
// 渲染   @author jiangzhidong 20160120  end

//===========================================物料清单===========================================    		
var material_item = [{ title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber', width: 100, align: 'center', renderer:initInputAny},
	                { title:'<i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />', name:'materialDesc', width: 100, align: 'center', renderer:initInputAny},
	  	            { title:'<i18n:I18n key="i18n_material_pinpai" defaultValue="品牌" />', name:'attribute1' ,width:100, align:'center', renderer:initInputAny},
	  	            { title:'<i18n:I18n key="i18n_material_color" defaultValue="颜色" />', name:'attribute2', width: 70, align: 'center',renderer:initInputAny},
	  	            { title:'<i18n:I18n key="i18n_material_long" defaultValue="长" />', name:'attribute3', width: 70, align: 'center',renderer:initInputAny},
	  		        { title:'<i18n:I18n key="i18n_material_width" defaultValue="宽" />', name:'attribute4', width: 70, align: 'center',renderer:initInputAny},
	  		        { title:'<i18n:I18n key="i18n_material_height" defaultValue="高" />', name:'attribute5', width: 70, align: 'center',renderer:initInputAny},
	  		        { title:'<i18n:I18n key="i18n_common_label_unitofmeasurement" defaultValue="计量单位" />', name:'measureUnit', width: 70, align: 'center',renderer:initInputAny},
	  		        { title:'<i18n:I18n key="i18n_common_label_deliverydate" defaultValue="需求日期" />', name:'requireDate',width:120, align:'center' ,renderer:formatDateInput},
	  		        { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_placeOfReceipt" defaultValue="收货地点" />', name:'receiptAddr',width:70, align:'center',renderer:initInputAny},
	  		        { title:'<i18n:I18n key="i18n_common_title_paymentTerms" defaultValue="付款条件" />', name:'paymentClause',width:120, align:'center' ,renderer:initInputAny},
	  		        { title:'<i18n:I18n key="i18n_common_title_price" defaultValue="单价" />', name:'price', width: 120, align: 'center',renderer:initInputAny},
	  				{ title:'<i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />', name:'quantity', width: 100, align: 'center',renderer:initInputAny},
	  				{ title:'<i18n:I18n key="i18n_common_title_taxRate" defaultValue="税率" />', name:'rate',width:70, align:'center',renderer:initInputNumber},
	  				{ title:'<i18n:I18n key="i18n_common_title_amount" defaultValue="金额" />', name:'amount',width:100, align:'center',renderer:initInputNumber},
	  				{ title:'<i18n:I18n key="i18n_common_title_quantity" defaultValue="采购订单数量" />', name:'purchaseOrderQuantity',width:100, align:'center',renderer:initInputNumber},
	  				{ title:'<i18n:I18n key="i18n_common_deliveredquantity" defaultValue="已发货数量" />', name:'deliveryQuantity',width:100, align:'center',renderer:initInputNumber},
	  				{ title:'<i18n:I18n key="i18n_common_title_receivedquantity" defaultValue="已收货数量" />', name:'receiveQuantity',width:100, align:'center',renderer:initInputNumber},
	  				{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark',width:150, align:'center',renderer:initInputAny}];

     		
//===========================================合同条款===========================================
var contract_item = [{ title:'<i18n:I18n key="i18n_common_title_contractclausecode" defaultValue="合同条款编码" />', name:'contractNumber', width: 200, align: 'center'},
                { title:'<i18n:I18n key="i18n_common_title_contracDescName" defaultValue="合同条款简称" />', name:'contractDesc', width: 200, align: 'center',renderer:initInputAnyBak},
 	            { title:'<i18n:I18n key="i18n_common_title_contracdetailcontent" defaultValue="合同条款明细内容" />', name:'detailContent' ,width:300, align:'center',renderer:initInputAny},
 	            { title:'<i18n:I18n key="i18n_common_title_superiorClauseCode" defaultValue="上级合同条款编码" />', name:'superiorClauseCode' ,width:150, align:'center',renderer:initInputAny},
 	            { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" /> ', name:'remark', width: 200, align: 'center',renderer:initInputAnyBak}];

	
//===========================================文件===========================================	
var file_cols = [
			{ title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' , width:100, align:'center',renderer:function(val){
				return "<input name='purchaseBiddingFileList[][fileName]' type='text'  value='"+val+"'/>";
			}},
			{ title:'<i18n:I18n key="i18n_common_label_filepath" defaultValue="文件路径" />', name:'filePath', width:100, align:'center',renderer:function(val){
				return "<input name='purchaseBiddingFileList[][filePath]' type='text'  value='"+val+"'/>";
			}},
			{ title:'<i18n:I18n key="i18n_common_label_filetype" defaultValue="文件类型" />', name:'fileType', width:100, align:'center',renderer:function(val){
				return "<input name='purchaseBiddingFileList[][fileType]' type='text'  value='"+val+"'/>";
			}},
			{ title:'<i18n:I18n key="i18n_common_lable_fliesize" defaultValue="文件大小" />', name:'fileSize', width:100, align:'center',renderer:function(val){
				return "<input name='purchaseBiddingFileList[][fileSize]' type='text'  value='"+val+"'/>";
			}},
			{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark', width:100, align:'center',renderer:function(val){
				return "<input name='purchaseBiddingFileList[][remark]' type='text'  value='"+val+"'/>";
			}}];


$(document).ready(function(){
	$( '#add-enq-sheet').tabs();
	init();
	//改变投标轮数
	$("#selectCount").change(function(){
		changeGride();
	});
	
	//添加合同内容项
	$("#addItem").click(function(){
		var contractNumber = $("#contractNumber").val();
		contractTable.addRow({"contractNumber":contractNumber});
	});
	
	//添加物料特性内容项
	$("#addMaterialItem").click(function(){
		materialTable.addRow({});
	});
	
	//显示上传弹框
	$("#uploadFile").click(function(){
		 initFileUploader(fileUploader);
		 $('.fixed-dialog').show();
	});
	
	//关闭上传弹框
	$("#btnFileCancel ,.dialog-close-btn").click(function(){
		 $('.fixed-dialog').hide();
	});
	
	//显示上传弹框
	$("#btnFileOK").click(function(){
		addFileItem();
	});
	
	//发送
	$("#send").click(function(){
		sendContract();
	});
	
});


//退出
$("#exitBtn").click(function(){
	endFormJson = $("#form").serializeJSON();
	var begin = JSON.stringify(beginFormJson);
	var end = JSON.stringify(endFormJson); 
	if(begin==end){
		parent.elsDeskTop.closeCurWin('contractManagerUpd');
	}else{
		
	parent.elsDeskTop.tip.init({
		type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>',
				closeEvent:function(){
					parent.elsDeskTop.closeCurWin('contractManagerUpd');
}});
	}
});

window.beforeClose = function(close){ 
	endFormJson = $("#form").serializeJSON();
	var begin = JSON.stringify(beginFormJson);
	var end = JSON.stringify(endFormJson); 
	if(begin==end){
		close();
	}else{
		
	parent.elsDeskTop.tip.init({
		type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>',
				closeEvent:function(){
					close();
}});
	}
}

//初始化
function init(){
	//加载对应的初始数据
	var contractParams = {"elsAccount":elsAccount,"contractNumber":contractNumber ,"toElsAccount":""}
	
	contractTable=$('#contractTable').mmGrid({
        cols: contract_item,
        url :"<%=basePath%>rest/ContractManageService/queryContractManageClauseByCondtion",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol:true,
    	method : 'post',
		root : "rows",
        params:contractParams,
    });
	
	var  materialParams = {"elsAccount":elsAccount,"contractNumber":contractNumber};
	if(!materialTable) {
		materialTable = $('#materialTable').mmGrid({
	        cols: material_item,
	        url :"<%=basePath%>rest/ContractManageService/queryContractManageMaterialByCondtion",
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        params:materialParams,
	    	method : 'post',
			root : "rows",
	    });
	}
	
	initFriend();
	iniContractHeadInfo();

}

//初始化合同表头信息
function iniContractHeadInfo(){
	var headerparams = {"elsAccount":elsAccount,"contractNumber":contractNumber ,"toElsAccount":""}
	$.ajax({
			url :"<%=basePath%>rest/ContractManageService/queryContractManageHeadByCondtion",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(headerparams),
			success : function(data) {
				debugger;
				$("#contractNumber").val(data.rows[0].contractNumber);
				$("#contractDesc").val(data.rows[0].contractDesc);
				var contractSignedDate = data.rows[0].contractSignedDate;
				contractSignedDate = formatDate(data.rows[0].contractSignedDate);
				$("#contractSignedDate").val(contractSignedDate);
				
				var contractStartDate = data.rows[0].contractStartDate;
				contractStartDate = formatDate(data.rows[0].contractStartDate);
				$("#contractStartDate").val(contractStartDate);
				
				var contractEndDate = data.rows[0].contractEndDate;
				contractEndDate = formatDate(data.rows[0].contractEndDate);
				$("#contractEndDate").val(contractEndDate);
				
				$("#currency").val(data.rows[0].currency);
				$("#paymentAmount").val(data.rows[0].paymentAmount);
				$("#totalPaymentAmount").val(data.rows[0].totalPaymentAmount);
				$("#totalContractAmount").val(data.rows[0].totalContractAmount);
				$("#contractVersion").val(data.rows[0].contractVersion);
				$("#purchaseContactPhone").val(data.rows[0].purchaseContactPhone);
				$("#contractStatus").val(data.rows[0].contractStatus);
				$("#contractTypeName").val(data.rows[0].contractTypeName);
				$("#contractTypeCode").val(data.rows[0].contractTypeCode);
				beginFormJson = $("#form").serializeJSON();
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
             alert(xhr.responseText, "Failed"); 
    		}
		});
}

//初始化文件上传控件
function initFileUploader(fileUploader){
   if(!fileUploader){
    //新增表单文件
  	fileUploader = WebUploader.create({
  	    // swf文件路径
  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
  	  	duplicate :true,
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
  	   		$("#filePath").val(filePath);
  	   	    $("#fileName").val(response.name);
  	   	    $("#fileSize").val(response.size);
  	  	}else{
  	  		alert(response.message,2);
  	  	}
  	});
  }
}

//在文件列表添加新添加的文件列
function addFileItem(){
	var filePath=$("#filePath").val();
	var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
	var fileName=$("#fileName").val();
	var fileSize = $("#fileSize").val();
	var fileBlackItem={fileName:fileName,fileType:fileType,filePath:filePath,fileSize:fileSize,remark:""};
	editFileTable.addRow(fileBlackItem);
	$('.fixed-dialog').hide();
}

//改变行数量
function changeGride(){
	var count=$("#selectCount").find("option:selected").val();
	var arr=new Array();
	for(var i=0;i<count;i++){
		var ind=parseInt(i)+parseInt(1);
		arr[i]={roundsNumber:ind,biddingBeginDate:"",biddingEndDate:"",biddingStatus:"0"};
	}
	materialTable.removeRow();
	materialTable.addRows(arr);
}

//初始化联系人弹窗,将联系人的列表传人
function initContact(list, dir, had) {
	if(list && list.length) {
		var oldArr = list;
		$('body').data('cacheOldArr',oldArr);
    	var txt ="";
    	if(dir == 'left') {
    		$('.box-left').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">left</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-left').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-left').find('.contact-people').eq(ind).hide();
    			}
    		}
    		leftScroll.resize();
    		
    	} 
    	else if(dir == 'right') {
    		$('.box-right').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="display:none;margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">right</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-right').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-right').find('.contact-people').eq(ind).show();
    			}
    		}
    		rightScroll.resize();
    	}
	}
};

//显示文件列表
function showFileList(){
	var fileParam = { 'elsAccount':elsAccount, 'elsSubAccount':elsSubAccount};
	editFileTable=$('#add-file-project').mmGrid({
	    cols: file_cols,
	    url: '<%=basePath%>rest/PurchaseEnquiryBargainService/queryReceiveEnquiryFileByCondtion',
	    params: fileParam,
	    method: 'post',
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
}

//添加供应商信息
function initFriend(){
		$.ajax({
 			url :"<%=basePath%>rest/FriendsService/findMyFriendsByType",
 			type :"POST",
 			contentType : "application/json",
 			dataType : "json",
 			data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
 			success : function(data) {
 				var rows = data.rows;
 				for(var i = 0 ; i < rows.length ; i ++){
 					rows[i]["fromIndex"]=i;
 				}
 				//首次进入初始化
 				initContact(rows,'left');
 				initContact(rows,'right');
 			},
 			error: function (xhr, type, exception) {//获取ajax的错误信息
                 alert(xhr.responseText, "Failed"); 
        }
 		});
    rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
    leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
}
;
//存储临时的选择数据
var cacheData = {};
$('.contact-people').live('mouseover',function() {
	$('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact');
});
$('.contact-people').live('click',function() {
    /* $('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact'); */
    //cacheData.text = JSON.parse($(this).find('.storeData').text());
    cacheData.index = parseInt($(this).find('.people-index').text());
    cacheData.dir = $(this).find('.storeData-from').text();
    $('body').data('cachePeople',cacheData);
    var oldObj = $('body').data('cachePeople');
    if(oldObj && oldObj.dir=='left') {
    	$('.box-left').find('.contact-people').eq(oldObj.index).hide();
    	$('.box-right').find('.contact-people').eq(oldObj.index).show();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	rightScroll.resize();
   } else if(oldObj && oldObj.dir=='right') {
       	$('.box-left').find('.contact-people').eq(oldObj.index).show();
    	$('.box-right').find('.contact-people').eq(oldObj.index).hide();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	leftScroll.resize();
	}
});

$('.contact-search').keyup(function() {
	var val = $(this).val();
	var all = $('.box-left').find('p').hide();
	if(!val){
		all.show();
	} else {
		all.filter(function(index,html) {
    		var oldText=$(html).find('.friend-name').text();
    		return oldText.indexOf(val) != -1;
    	}).show();
	}
});
//选择左边全部
$('.all-pre').click(function() {
	var left =$('.box-left').find('.contact-people');
	var right =$('.box-right').find('.contact-people');
	left.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.people-index').text();
            right.eq(showInd).show();
        }
	});
	$('.box-left').find('.contact-people').hide();
	//清空临时存储的数据
	$('body').data('cachePeople','right');
	rightScroll.resize();
});
//选择右边全部
$('.all-back').click(function() {
	var left =$('.box-left').find('.contact-people');
	var right =$('.box-right').find('.contact-people');
	right.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.people-index').text();
            left.eq(showInd).show();
        }
	});
	$('.box-right').find('.contact-people').hide();
	//清空临时存储的数据
	$('body').data('cachePeople','left');
	leftScroll.resize();
});

//处理数据
function inputMaterialValue(materialLine,index){
    //获取input 对象里面的值
    var materialNumber = document.getElementsByName("materialNumber")[index].value;
    materialLine["materialNumber"]=materialNumber;
    
    var materialDesc = document.getElementsByName("materialDesc")[index].value;
    materialLine["materialDesc"]=materialDesc;
    
    var attribute1 = document.getElementsByName("attribute1")[index].value;
    materialLine["attribute1"]=attribute1;
    
    var attribute2 = document.getElementsByName("attribute2")[index].value;
    materialLine["attribute2"]=attribute2;
    
    var attribute3 = document.getElementsByName("attribute3")[index].value;
    materialLine["attribute3"]=attribute3;
    
    var attribute4 = document.getElementsByName("attribute4")[index].value;
    materialLine["attribute4"]=attribute4;
    
    var attribute5 = document.getElementsByName("attribute5")[index].value;
    materialLine["attribute5"]=attribute5;
    
    var measureUnit = document.getElementsByName("measureUnit")[index].value;
    materialLine["measureUnit"]=measureUnit;
    
    var requireDate = document.getElementsByName("requireDate")[index].value;
    materialLine["requireDate"]=requireDate;
    
    var receiptAddr = document.getElementsByName("receiptAddr")[index].value;
    materialLine["receiptAddr"]=receiptAddr;
    
    var paymentClause = document.getElementsByName("paymentClause")[index].value;
    materialLine["paymentClause"]=paymentClause;
    
    var price = document.getElementsByName("price")[index].value;
    materialLine["price"]=price;
    
    var quantity = document.getElementsByName("quantity")[index].value;
    materialLine["quantity"]=quantity;
    
    var rate = document.getElementsByName("rate")[index].value;
    materialLine["rate"]=rate;
    
    var amount = document.getElementsByName("materialNumber")[index].value;
    materialLine["amount"]=amount;
    
    var purchaseOrderQuantity = document.getElementsByName("purchaseOrderQuantity")[index].value;
    materialLine["purchaseOrderQuantity"]=purchaseOrderQuantity;
    
    var deliveryQuantity = $("#deliveryQuantity" + index).val();
    var deliveryQuantity = document.getElementsByName("deliveryQuantity")[index].value;
    materialLine["deliveryQuantity"]=deliveryQuantity;
    
    var receiveQuantity = document.getElementsByName("receiveQuantity")[index].value;
    materialLine["receiveQuantity"]=receiveQuantity;
    
    var remark = document.getElementsByName("remark")[index].value;
    materialLine["remark"]=remark;
    
    return materialLine;
}


function inputContractValue(ContractLine,index){
    //获取input 对象里面的值
    var contractDesc = document.getElementsByName("contractDescBak")[index].value;
    ContractLine["contractDesc"]=contractDesc;
    
    var detailContent = document.getElementsByName("detailContent")[index].value;
    ContractLine["detailContent"]=detailContent;
    
    var superiorClauseCode = document.getElementsByName("superiorClauseCode")[index].value;
    ContractLine["superiorClauseCode"]=superiorClauseCode;
    
    var remark = document.getElementsByName("remarkBak")[index].value;
    ContractLine["remark"]=remark;
    
    return ContractLine;
}
	
//删除行 物料
$("#removeMaterialItem").click(function(){
	 debugger;
	 var items = materialTable.selectedRows();
	 var rowsIndex = materialTable.selectedRowsIndex();
	 	 materialTable.removeRow(rowsIndex);
	 if(items.length<=0){
		 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
		 return;
	 }
	 var row = items[0];
	 var createDate=row["createDate"];
	 if(createDate!=null){
		 contractManageMaterialVODelList.push(row);
	 }
 });

//删除行 合同条款
$("#removeItem").click(function(){
	 debugger;
	 var items = contractTable.selectedRows();
	 var rowsIndex = contractTable.selectedRowsIndex();
	 contractTable.removeRow(rowsIndex);
	 if(items.length<=0){
		 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
		 return;
	 }
	 var row = items[0];
	 var createDate=row["createDate"];
	 if(createDate!=null){
		 contractManageClauseVODelList.push(row);
	 }
 });

//合同修改
function sendContract(){
// 	var toElsAccounts="";
// 	var toElsDescs ="";
	
// 	$('.box-right').find(".contact-people").each(function(index ,val){
// 		if(jQuery(this).css("display")!="none"){ 
// 			var textObj = JSON.parse($(this).find('.storeData').text());
// 			toElsAccounts+=","+textObj.friendElsAccount;
// 			toElsDescs+=","+textObj.friendCompanyName;
// 		}
// 	});
//     if(toElsAccounts.length==0) {
//     	alert("请选择受邀方!",2);
//     	return ;
//     }

	debugger;
    var formObj = $("#form").serializeJSON();
    formObj["elsAccount"]=elsAccount;
    formObj["contractNumber"] = contractNumber;
    //封装物料信息和合同条款信息的json
    var materialListJson = [];
    var contractClauseJson = [];
    var materialRows = materialTable.rows();
    var contractRows = contractTable.rows();
    //遍历物料行信息组建json 
	if(materialRows.length > 0){
		for(var j = 0 ; j < materialRows.length ; j ++){
			var MaterialLine = materialRows[j];
			MaterialLine = inputMaterialValue(MaterialLine,j);//获得input修改后的值
			materialListJson.push(JSON.stringify(MaterialLine));				
		}
	}
    //遍历合同项行信息组建json 
	if(contractRows.length > 0){
		for(var j = 0 ; j < contractRows.length ; j ++){
			var ContractLine = contractRows[j];
			ContractLine = inputContractValue(ContractLine,j);//获得input修改后的值
			contractClauseJson.push(JSON.stringify(ContractLine));				
		}
	}
    
    formObj["contractManageMaterialVOList"] =  eval('['+materialListJson+']');
    formObj["contractManageClauseVOList"] = eval('['+contractClauseJson+']');
    formObj["contractManageMaterialVODelList"]=contractManageMaterialVODelList;
    formObj["contractManageClauseVODelList"]=contractManageClauseVODelList;
    
    console.log(formObj);
    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认发布？" />',closeEvent:function(){
    parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_contract_title_modifyingcontractinformation" defaultValue="合同信息修改中" />');
	$.ajax({
		url : "<%=basePath%>rest/ContractManageService/UpdateContract",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(formObj),
		dataType : "json",
		success : function(data) {
			debugger;
			parent.elsDeskTop.hideLoading();
 			if(data.statusCode=="-100"){
 				alert(data.message,2);
 			}else{
 				alert("<i18n:I18n key="i18n_common_alert_updatesuccess" defaultValue="修改成功！" />");
 				parent.elsDeskTop.closeCurWin('contractManagerUpd',callBack);
 			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		}
	});
	
    }});
}

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_contractManager']) {
		parent.frames['iframeApp_contractManager'].purchQuery();
	}

}

//文件下载
$("#downloadFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
	    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
	
 });
 
//在线预览
$("#lookFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
		previewFile(filePath);
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
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
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型" />!"});
	}
}


/////判断两个json对象是否一致////
//比较数组是否相同
  modeler.compArray=function(array1,array2)
  { 
   if((array1&&typeof array1 ==="object"&&array1.constructor===Array)&&(array2&&typeof array2 ==="object"&&array2.constructor===Array))
   {
      if(array1.length==array2.length)
      {
       for(var i=0;i<array1.length;i++)
       {
        var ggg=modeler.compObj(array1[i],array2[i]);
        if(!ggg)
        {
         return false;
        }

       }

      }
      else
      {
       return false;
      }
   }
   else
   {
    throw new Error("argunment is  error ;");
   }
    return true;
  };
  modeler.compObj=function(obj1,obj2)//比较两个对象是否相等，不包含原形上的属性计较
   {
    if((obj1&&typeof obj1==="object")&&((obj2&&typeof obj2==="object")))
    {   
      var count1=modeler.propertyLength(obj1);
      var count2=modeler.propertyLength(obj2);
      if(count1==count2)
      { 
       for(var ob in obj1)
       {
        if(obj1.hasOwnProperty(ob)&&obj2.hasOwnProperty(ob))
        {     

         if(obj1[ob].constructor==Array&&obj2[ob].constructor==Array)//如果属性是数组
         { 
          if(!k.compArray(obj1[ob],obj2[ob]))
          {
           return false;
          };
         }                  
         else if(typeof obj1[ob]==="string"&&typeof obj2[ob]==="string")//纯属性
         {  
         if(obj1[ob]!==obj2[ob])
        {
           return false;
        }
         }
         else if(typeof obj1[ob]==="object"&&typeof obj2[ob]==="object")//属性是对象
         {  
          if(!modeler.compObj(obj1[ob],obj2[ob]))
        {  
         return false;
        };
         }
         else
         {
        return false;
         }
        } 
        else
        {
         return false;
        }
       }
      }
      else
      {
       return false;
      } 
    }

    return true;
   };
   modeler.propertyLength=function(obj)//获得对象上的属性个数，不包含对象原形上的属性
   {  
    var count=0;
    if(obj&&typeof obj==="object") {
     for(var ooo in obj) {
       if(obj.hasOwnProperty(ooo)) {
         count++;
       }
     }
     return count;
    }else {
     throw new Error("argunment can not be null;");
    }

   };



////////////////////////////////////


</script>
</body>
</html>