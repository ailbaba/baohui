<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
<%-- 				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
				<button id="saveBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="btnSend" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="saleQuotationHeaderVO[companyShortName]"
			value="<%=session.getAttribute("companyShortName")%>" /> <input
			type="hidden" name="saleQuotationHeaderVO[elsAccount]"
			value="${elsAccount }" /> <input type="hidden"
			name="saleQuotationHeaderVO[elsSubAccount]" value="${elsSubAccount }" />
			<input type="hidden" id="toElsAccount"
			name="saleQuotationHeaderVO[toElsAccount]" value="" />
			<input type="hidden" id="quotationNumber"
			name="saleQuotationHeaderVO[quotationNumber]" />
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_quotationheader" defaultValue="报价单头" /></span>
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
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_quotationitem" defaultValue="报价单行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<ul>
						<li><a href="#sheet-item-one"><i18n:I18n key="i18n_lable_quotationitem" defaultValue="报价单行项目" /></a></li>
						<li><a href="#sheet-item-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
					</ul>
					<div id="sheet-item-one">
						<div class="edit-box-wrap">
<%-- 							<button id="itemColumnDefineBtn" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
							<button id="btnAdd" class="edit-btn button-wrap add-bottom-btn elsEdit"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
							<button id="btnRemove" class="edit-btn button-wrap del-btn elsEdit"><i18n:I18n key="i18n_common_button_removeline" defaultValue="删除一行" /></button>
						</div>
						<main id="item-container" class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
						</div>
						</main>
					</div>
					<div id="sheet-item-two">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line p-zero">
								<div class="pos-relative upload-wrap">
									<div class="pos-absolute file-list">
										<div class="file-list-head">
											<i18n:I18n key="i18n_common_lable_filelist" defaultValue="表单文件列表" />：<span>
											<select id="formFileTypeSelector" onchange="loadFormFileByType()">
											    <option value="0"><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
								                <option value="1"><i18n:I18n key="i18n_lable_quotationheadfile" defaultValue="报价单头文件" /></option>
								                <option value="2"><i18n:I18n key="i18n_lable_quotationitemfile" defaultValue="报价单项文件" /></option>
							                </select></span>
										</div>
										<main class="grid-container">
										<div class="grid-100">
											<table id="table-file"></table>
										</div>
										</main>
									</div>
									<div class="file-scan">
										<div class="file-option-zoom">
											<div class="dis-in-b text-left">
												<button id="btnAddFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button>
												<button id="btnModifyFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改文件" /></button>
												<button id="btnDeleteFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button>
											</div>
											<div class="dis-in-b text-right">
												<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
												<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
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
	</form>
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
	<div class="fixed-dialog">
		<div class="dialog-tip bg-common">
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
							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件分类" />：</span> 
							<select id="operTypeSelector" onchange="loadOrderItem()" >
								<option value="0"><i18n:I18n key="i18n_lable_quotationheadfile" defaultValue="报价单头文件" /></option>
								<option value="1"><i18n:I18n key="i18n_lable_quotationitemfile" defaultValue="报价单项文件" /></option>
							</select>
						</div>
						<div id="divOrderItem" class="input-and-tip">
							<span><i18n:I18n key="i18n_formfile_chooseitem" defaultValue="行项目" />：</span> 
							<select id="orderItemSelector"
								name="orderItemNumber">
							</select>
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span>
							<input id="fileName" name="fileName" type="text" />
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
var initData;
var $sob;
var chatFromUrlFlag;
var peopleList=[];
var headGrid;
var materialGrid;
var itemGrid;
var fileGrid;
var fileUploader;
var toElsAccount = GetQueryString("toElsAccount");
var quotationNumber = GetQueryString("quotationNumber");
// var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editSaleQuotationHeader"/>;
var cols_head = [{title:"<i18n:I18n key='i18n_quotation_number' defaultValue='报价单号' />",name:"quotationNumber",align:"center",width:98},
//                 {title:"<i18n:I18n key='i18n_quotation_supplynumber' defaultValue='供货编号' />",name:"supplyNumber",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_lable_materialnumber' defaultValue='物料编号' />",name:"materialNumber",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_title_materialdescribe' defaultValue='物料描述' />",name:"materialDesc",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_title_materialgroup' defaultValue='物料组' />",name:"materialGroup",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_quotation_purchaseels' defaultValue='采购商ELS号' />",name:"toElsAccount",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_purchaser' defaultValue='采购商' />",name:"toCompanyShortName",align:"center",width:168},
                 {title:"<i18n:I18n key='i18n_quotation_saleels' defaultValue='供应商ELS号' />",name:"elsAccount",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_enquiry_label_supplier' defaultValue='供应商' />",name:"companyShortName",align:"center",width:168}
                 ];
// var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editSaleQuotationItem"/>;
var cols_item = [{title:"<i18n:I18n key='i18n_common_title_lineitemnumber' defaultValue='行项目号' />",name:"orderItemNumber",hidden:true,align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][orderItemNumber]")}},
                 {title:"<i18n:I18n key='i18n_quotation_supplynumber' defaultValue='供货编号' />",name:"supplyNumber",hidden:true,align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][supplyNumber]")}},
                 {title:"<i18n:I18n key='i18n_common_lable_materialnumber' defaultValue='物料编号' />",name:"materialNumber",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][materialNumber]")}},
                 {title:"<i18n:I18n key='i18n_common_label_materialdescribe' defaultValue='物料描述' />",name:"materialDesc",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][materialDesc]")}},
                 {title:"<i18n:I18n key='i18n_common_title_materialgroup' defaultValue='物料组' />",name:"materialGroup",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][materialGroup]")}},
                 {title:"<i18n:I18n key='i18n_material_cate' defaultValue='物料分类' />",name:"materialCategory",hidden:true,align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][materialCategory]")}},
                 {title:"<i18n:I18n key='i18n_material_pinpai' defaultValue='品牌' />",name:"attribute1",align:"center",width:98,renderer:attrRenderer},
                 {title:"<i18n:I18n key='i18n_material_long' defaultValue='长度' />",name:"attribute2",align:"center",width:98,renderer:attrRenderer},
                 {title:"<i18n:I18n key='i18n_material_width' defaultValue='宽度' />",name:"attribute3",align:"center",width:98,renderer:attrRenderer},
                 {title:"<i18n:I18n key='i18n_material_texture' defaultValue='材质' />",name:"attribute4",align:"center",width:98,renderer:attrRenderer},
                 {title:"<i18n:I18n key='i18n_material_color' defaultValue='颜色' />",name:"attribute5",align:"center",width:98,renderer:attrRenderer},
                 {title:"<i18n:I18n key='i18n_salequotation_price' defaultValue='基准价格' />",name:"price",align:"center",width:98,renderer:function(val){return stringInput2(val,"Y","itemList[][price]","price")}},
              	 {title:"<i18n:I18n key='i18n_delivery_lable_unit' defaultValue='单位' />",name:"unitMeasure",align:"center",width:98,renderer:function(val){return stringInput2(val,"Y","itemList[][unitMeasure]","unitMeasure")}},
                 {title:"<i18n:I18n key='i18n_salequotation_pricestartdate' defaultValue='价格起始日期' />",name:"fbk7",align:"center",width:98,renderer:function(val){return dateInputFormat2(val,"Y","itemList[][fbk7]","","fbk7")}},
                 {title:"<i18n:I18n key='i18n_salequotation_priceenddate' defaultValue='价格截止日期' />",name:"fbk8",align:"center",width:98,renderer:function(val){return dateInputFormat2(val,"Y","itemList[][fbk8]","","fbk8")}},
                 {title:"<i18n:I18n key='i18n_salequotation_predeliverdate' defaultValue='交货提前期' />",name:"fbk10",align:"center",width:98,renderer:function(val){return stringInput2(val,"Y","itemList[][fbk10]","fbk10")}},
                 {title:"<i18n:I18n key='i18n_salequotation_minorderquantity' defaultValue='最小订货量' />",name:"fbk9",align:"center",width:98,renderer:function(val){return stringInput2(val,"Y","itemList[][fbk9]","fbk9")}},
                 {title:"<i18n:I18n key='i18n_salequotation_maxorderquantity' defaultValue='最大订货量' />",name:"quantity",align:"center",width:98,renderer:function(val){return stringInput2(val,"Y","itemList[][quantity]","quantity")}},
                 {title:"<i18n:I18n key='i18n_common_title_remarks' defaultValue='备注' />",name:"fbk11",align:"center",width:98,renderer:function(val){return stringInput2(val,"Y","itemList[][fbk11]","fbk11")}}
//                  {title:"货币",name:"currency",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][currency]")}},
//                  {title:"价格单位",name:"unitPrice",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][unitPrice]")}},
//                  {title:"数量单位",name:"unitQuantity",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][unitQuantity]")}}
                 ];
var cols_file = [
	             { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
	                 	if (val == elsAccount) {
	                 		return "<i18n:I18n key="i18n_common_sale" defaultValue="销售方" />";
	                	} else {
	                		return "<i18n:I18n key="i18n_common_purchase" defaultValue="采购方" />";
	                	} 
	             }},
                 { title:'id',name:'formId' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'orderItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return '<i18n:I18n key="i18n_lable_quotationheadfile" defaultValue="报价单头文件" />';
	                	} else{
	                		return '<i18n:I18n key="i18n_lable_quotationitemfile" defaultValue="报价单项文件" />';
	                	}
	                }},
                 { title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />',name:'orderItemNumber' ,width:80, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />',name:'filePath' ,width:200, align:'center',hidden:true}
             ];
function stringInput2(val,type,property,id) {
	if (!val&& val!="") {val = "";}
	if (type == "R") {
		return "<span class='showText'>" + val + "</span>" + "<input name='"+property+"' class='noEdit' type='text' style='display:none' value='"+val+"'/>";
	} else {
	    return "<input name='"+property+"' type='text' value='"+val+"' class='syncJson' sid='"+id+"' />";
	}
}
function dateInputFormat2(val,type,property,pattern,id) {
	val = dateFormat(val,pattern);
	if (type == "R") {
		return "<span class='showText'>" + val + "</span>" + "<input name='"+property+"' class='noEdit' type='text' style='display:none' value='"+val+"'/>";
	} else {
		return "<input name='"+property+"' class='syncJson' onfocus='WdatePicker()' type='text' value='"+val+"' sid='"+id+"'/>";
	}
}
//初始化聊天窗口
//ELS账号+订单号 作为 businessID
function initChat() {
		var businessID = initData.saleQuotationHeaderVO.quotationNumber;
		//采购凭证号
		var quotationNumberList = [];
		//订单号
		var bIdList = [];
		//聊天显示列表
		var chatList = [];
		var obj ={};
		obj[initData.saleQuotationHeaderVO.quotationNumber] = '' ;
		bIdList.push(obj); 
		chatList.push(initData.saleQuotationHeaderVO.quotationNumber);
		chatList=chatList.map(function(d){
			return {name:d}
		});
		//初始化iframe
		 var toElsSubAccount;
	  	//多人聊天  type=multi 一对一 type=single  list 用来显示列表人
	  	bIdString = bIdList&&bIdList.length?'['+bIdList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	chatListString = chatList&&chatList.length?'['+chatList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	var url = "multiChatTest.jsp?type=multi&fromElsAccount="
				+ elsAccount
				+ "&fromElsSubAccount="
				+ elsSubAccount
				+ "&toElsAccount="
				+ toElsAccount
				+ "&toElsSubAccount="+peopleListString
				+ "&businessType=quotation"
				+ "&businessID="+bIdString
            + "&list="+ (chatListString&&chatListString.length?chatListString : peopleListString)
				+"&t="+new Date().getTime();
	   
	   $('.testIframe').attr('src','<%=basePath%>'+ url);
	   //滚动条美化niceScroll
	   $('.public-wrap').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
}
$().ready(function(){
	init();
	$sob = $('.saying-dialog .option-bar');
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10),closeCallback());
	});
	$("#saveBtn").click(function(){
		if(checkParam()){
			saveData();
		}
	});
	$("#btnSend").click(function(){
		if(checkParam()){
			sendData();
		}
	});
	$("#btnAdd").click(function(){
		addItem();
	});
	$("#btnRemove").click(function(){
		removeItem();
	});
});
function closeCallback() {
	if (parent.frames["iframeApp_saleQuotationManage"]) {
		parent.frames["iframeApp_saleQuotationManage"].query();
	}
}
function addItem() {
	if (itemGrid.selectedRows().length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var row = $.extend({}, itemGrid.selectedRows()[0]);
	row.orderItemNumber="";
	var selectedIndexs = itemGrid.selectedRowsIndex();
	itemGrid.addRow(row,selectedIndexs[0]+1);
	initData.itemList.splice(selectedIndexs[0]+1,0,row);
}
function attrRenderer(val,item,index,name) {
	if (!val) {
		val = "";
	}
	if (name == "attribute1") {
		if (item.fbk1 == "Y") {
			return val + "<input  type='hidden'name='itemList[][attribute1]' value='"+val+"' readOnly/><input  type='hidden'name='itemList[][fbk1]' value='Y' readOnly/>";
		} else {
			return "<input name='itemList[][attribute1]' value='"+val+"' class='syncJson' sid='attribute1' />";
		}
	} else if (name == "attribute2") {
		if (item.fbk2 == "Y") {
			return val + "<input type='hidden' name='itemList[][attribute2]' value='"+val+"' readOnly/><input  type='hidden'name='itemList[][fbk2]' value='Y' readOnly/>";
		} else {
			return "<input name='itemList[][attribute2]' value='"+val+"' class='syncJson' sid='attribute2' />";
		}
	}  else if (name == "attribute3") {
		if (item.fbk3 == "Y") {
			return val + "<input type='hidden' name='itemList[][attribute3]' value='"+val+"' readOnly/><input  type='hidden'name='itemList[][fbk3]' value='Y' readOnly/>";
		} else {
			return "<input name='itemList[][attribute3]' value='"+val+"' class='syncJson' sid='attribute3' />";
		}
	}  else if (name == "attribute4") {
		if (item.fbk4 == "Y") {
			return val + "<input type='hidden' name='itemList[][attribute4]' value='"+val+"' readOnly/><input  type='hidden'name='itemList[][fbk4]' value='Y' readOnly/>";
		} else {
			return "<input name='itemList[][attribute4]' value='"+val+"' class='syncJson' sid='attribute4' />";
		}
	}  else if (name == "attribute5") {
		if (item.fbk5 == "Y") {
			return val + "<input type='hidden' name='itemList[][attribute5]' value='"+val+"' readOnly/><input  type='hidden'name='itemList[][fbk5]' value='Y' readOnly/>";
		} else {
			return "<input name='itemList[][attribute5]' value='"+val+"' class='syncJson' sid='attribute5' />";
		}
	} else if (name == "materialSpecification") {
		if (item.fbk6 == "Y") {
			return val + "<input type='hidden' name='itemList[][materialSpecification]' value='"+val+"' readOnly/><input  type='hidden'name='itemList[][fbk6]' value='Y' readOnly/>";
		} else {
			return "<input name='itemList[][materialSpecification]' value='"+val+"' class='syncJson' sid='materialSpecification' />";
		}
	} 
}
Array.prototype.remove=function(dx) 
{ 
    if(isNaN(dx)||dx>this.length){return false;} 
    for(var i=0,n=0;i<this.length;i++) 
    { 
        if(this[i]!=this[dx]) 
        { 
            this[n++]=this[i] 
        } 
    } 
    this.length-=1 ;
} 
function removeItem() {
	if (itemGrid.selectedRows().length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var selectedIndexs = itemGrid.selectedRowsIndex();
	itemGrid.removeRow(selectedIndexs[0]);
	initData.itemList.remove(selectedIndexs[0]);
}
function saveData() {
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/SaleQuotationService/saveData",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			var quotationNumber = data.saleQuotationHeaderVO.quotationNumber;
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			window.location="<%=basePath%>quotation/sale/editSaleQuotation.jsp?quotationNumber=" + quotationNumber + "&toElsAccount="+toElsAccount;
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function sendData() {
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/SaleQuotationService/sendData",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			var quotationNumber = data.saleQuotationHeaderVO.quotationNumber;
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			window.location="<%=basePath%>quotation/sale/editSaleQuotation.jsp?quotationNumber=" + quotationNumber + "&toElsAccount="+toElsAccount;
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function init(){
	$("#sheet-project").tabs();
	if (quotationNumber == null || quotationNumber == '') {
		
	} else {
		$.ajax({
    		url : "<%=basePath%>rest/SaleQuotationService/getSaleQuotation/"+elsAccount+"/"+toElsAccount+"/"+quotationNumber,
    		type : "get",
    		contentType : "application/json",
    		dataType : "json",
    		success : function(data) {
    			fillData(data);
//     			toElsAccount = data.saleQuotationHeaderVO.toElsAccount;
    		},
    		error : function(data) {
    			parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
	    			alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
    			}
    		}
		});
	}
}
function fillData(data) {
	initData = data;
	$("#quotationNumber").val(data.saleQuotationHeaderVO.quotationNumber);
	$("#toElsAccount").val(toElsAccount);
	if (!itemGrid) {
		itemGrid  = $('#table-item').mmGrid({
	        cols: cols_item,
	        checkCol:true,
	        items:data.itemList
	    });
	}
	if (!headGrid) {
		headGrid  = $('#table-head').mmGrid({
	        cols: cols_head,
	        height: 200,
	        checkCol:true,
// 	        items:[data.saleQuotationHeaderVO]
			items:data.materialList
	    });
		headGrid.on("loadSuccess",function(e, d){
			initChat();
			headGrid.select(0);
			filterItem(initData.materialList[0].materialNumber,initData.materialList[0].materialCategory);
			//打开聊天行选择开关
    		chatFromUrlFlag = true;
            //初始化聊天控制状态
            if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
            $sob.click();
		});
		headGrid.on('cellSelected',function(e, item, rowIndex, colIndex){
			filterItem(item.materialNumber,item.materialCategory);
		});
	}
	if (!fileGrid) {
		fileGrid = $('#table-file').mmGrid({
	        cols: cols_file,
	        items: data.fileList,
	    });
	}
}
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
	var orderItemNumber = $("#orderItemSelector").val();
	var fileType = $("#fileType").val();
	var logtime = new Date();
	var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"quotationNumber":quotationNumber,"orderItemNumber":orderItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/SaleQuotationService/addFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data.statusCode == "401") {
				alert("<i18n:I18n key='i18n_delivery_filenameexist' defaultValue='该文件名已存在' />",2);
		    }else{
		    	alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				fileGrid.addRow(data,fileGrid.rowsLength());
				$('.fixed-dialog').hide();
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
	var orderItemNumber = $("#orderItemSelector").val();
	var fileType = $("#fileType").val();
	var filePath = $("#filePath").val();
	var logtime = new Date();
	var data = {"elsAccount":elsAccount,"formId":formId,"fileStatus":fileStatus,"quotationNumber":quotationNumber,"orderItemNumber":orderItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/SaleQuotationService/updateFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
$('#btnAddFile').click(function() {
    $('.fixed-dialog').show();
    initAddFileDialog();
    initFileUploader(fileUploader);
});
$('#btnModifyFile').click(function() {
	var selectedIndexs = fileGrid.selectedRowsIndex();
	if (selectedIndexs.length == 0) {
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
		return;
	}
	var selectedRow = fileGrid.row(selectedIndexs[0]);
	if(selectedRow.createBy != elsAccount){
		alert("<i18n:I18n key='i18n_delivery_cantmodifytofile' defaultValue='对方文件不能修改' />",2);
		return;
	}
	formId = selectedRow.formId;
	fileName = selectedRow.fileName;
	fileStatus = selectedRow.fileStatus;
	orderItemNumber = selectedRow.orderItemNumber;
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
	var selectedRow = fileGrid.row(selectedIndexs[0]);
	if(selectedRow.createBy != elsAccount){
		alert("<i18n:I18n key='i18n_delivery_cantdeletetofile' defaultValue='对方文件不能删除' />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
	var data = {"formId":selectedRow.formId,"elsAccount":elsAccount};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/SaleQuotationService/deleteFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
function getOrderItem(){
	$("#orderItemSelector").empty();
	var html = "";
	var trs = $("#table-item").find("tr");
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		if (data.materialNumber != "") 
			html += "<option value='"+data.materialNumber+"'>" + data.materialNumber + "_" + data.materialDesc + "</option>";
	}
	$("#orderItemSelector").append(html);
}
function loadFormFileByType(){
	var type = $("#formFileTypeSelector").val();
	$("#table-file").find("tr").each(function(){
		var orderItemNumber = $(this).data("item").orderItemNumber;
		if(type == "0")
			$(this).css("display","");
		else if(type == "1"){
			if(orderItemNumber != null && orderItemNumber != "")
				$(this).css("display","none");
			else
				$(this).css("display","");
		}else{
			if(orderItemNumber != null && orderItemNumber != "")
				$(this).css("display","");
			else
				$(this).css("display","none");
		}
	});
}
$('.dialog-close-btn').click(function(){
    $('.fixed-dialog').hide();
});
$('.tip-option-btn').click(function(){
    $('.dialog-close-btn').trigger('click');
});
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editSaleQuotationHeader" + "&window=iframeApp_editSaleQuotation",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
$("#itemColumnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editSaleQuotationItem" + "&window=iframeApp_editSaleQuotation",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
function filterItem(materialNumber,materialCategory) {
	//根据物料分类动态获取特性，重新初始化表格
	var param = {"elsAccount":toElsAccount,"materialCateCode":materialCategory};
	$.ajax({
		url : "<%=basePath%>rest/MaterialCateService/queryMaterialSpec",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(param),
		success : function(data) {
			if (data.rows.length > 0) {
				//从6开始
				for (var i=6;i<11;i++) {
					var showFlag = false;
					for (var j=0;j<data.rows.length;j++) {
						if (i-5 == data.rows[j].attrIndex) {
							showFlag = true;
							cols_item[i].title = data.rows[j].materialSpecName;
						}
					}
					if (showFlag) {
						cols_item[i].hidden = false;
					} else {
						cols_item[i].hidden = true;
					}
				}
				syncJson();
				$("#item-container").html('<div class="grid-100"><table id="table-item"></table></div>');
				itemGrid  = $('#table-item').mmGrid({
			        cols: cols_item,
			        checkCol:true,
			        items:initData.itemList
			    });
				itemGrid.on("loadSuccess",function(e,d){
					$("#table-item").find("tr").each(function(){
						if ($(this).data("item").materialNumber != materialNumber) {
							$(this).hide();
						} else {
							$(this).show();
						}
					});
				});
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function syncJson() {
	var index = 0;
	$("#table-item").find("tr").each(function(){
		$(this).find(".syncJson").each(function(){
			var sid = $(this).attr("sid");
			initData.itemList[index][sid] = $(this).val();
		});
		index++;
	});
}
function checkParam(){
	$("#table-item").find("tr").each(function(e,obj){
		console.log("-----: "+obj);
		var price= $(obj).find("input[name='itemList[][price]']").val();
		var fbk9= $(obj).find("input[name='itemList[][fbk9]']").val();
		var	quantity=$(obj).find("input[name='itemList[][quantity]']").val();
		if(!price){
			alert("基准价格不能为空！",2);
			return false;
		}else if(!fbk9){
			alert("最小订货量不能为空！",2);
			return false;
		}else if(!quantity){
			alert("最大订货量不能为空！",2);
			return false;
		}
	});
	return true;
}

</script>
</body>
</html>