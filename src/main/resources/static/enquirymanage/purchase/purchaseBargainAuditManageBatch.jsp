<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String businessElsAccount = request.getParameter("businessElsAccount");
String purchaseEnquiryNumberApp = request.getParameter("purchaseEnquiryNumber");
String stretegyCode = request.getParameter("stretegyCode");
String flowCode = request.getParameter("flowCode");
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript">
var hasSelected = false;
</script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
				<button id="materialColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_materialName" defaultValue="物料" /><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<button id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_itemName" defaultValue="行" /><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
           		<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
           		<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
           		<base:audit elsSubAccount="${elsSubAccount }" businessElsAccount="${param.businessElsAccount }" businessId="${param.purchaseEnquiryNumber }" elsAccount="${elsAccount }" businessType="bargainEnquiry">
				<script type="text/javascript">
				hasSelected = true;
				</script>
				</base:audit>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="i18n_enquiry_label_enquirynumber" defaultValue="询价单号" />：</strong><span id="purchaseEnquiryNumber"/></div>
<%--                 <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="i18n_enquiry_title_enquirytype" defaultValue="询价单类型" />：</strong><span id="orderType"/></div> --%>
<%--                 <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="i18n_purchase_bargain_beginEndDate" defaultValue="询价起止日期" />: </strong><span id="beginDate"></span><strong><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" />: </strong><span id="endDate"/></div> --%>
            </div>
            
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_purchase_bargain_material" defaultValue="询价单物料项目" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100" id="materialTotal">
                        <table id="table-materialItem"></table>
                        <div id="pg" style="text-align: right; display: inline-block; position: absolute;top: -49px;right: 19px;"></div>
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
                         		&nbsp;&nbsp;
								<button id="acceptBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="批量通过" /></button>
								<button id="refuseBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="批量拒绝" /></button> 
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
			                    <div class="pos-absolute file-list">
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
				                 <div class="file-scan">
		   							<div class="file-option-zoom">
					                  <div class="dis-in-b text-left">
							             <button id="fileColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
							             <button id="flushFileBtn" class="button-wrap"><i18n:I18n key="i18n_common_title_flush" defaultValue="刷新" /></button>
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
    </div>
    
    
    <!-- 对话框 -->
<div class="fixed-dialog" id="sendMsgDialog">
           <div class="dialog-tip bg-common" style="width: 420px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="<%=basePath%>/icon/destop-icon/desktop_icon_09.gif" />
                   <span class="dialogTitle"><i18n:I18n key="test" defaultValue="填写审批意见" /></span>
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

<div class="fixed-dialog" id="sendMsgDialog2">
           <div class="dialog-tip bg-common" style="width: 420px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose2"></div>
               <div class="tip-head">
                   <img class="icon" src="<%=basePath%>/icon/destop-icon/desktop_icon_09.gif" />
                   <span class="dialogTitle"><i18n:I18n key="test" defaultValue="填写审批意见" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <textarea id="msgArea2" style="width: 100%; box-sizing: border-box;margin: 0; display: block;resize: none;height: 150px;"></textarea>
	                       <div class="mt-20 text-center">
	                          <button id="sendMsgBtnOK2" class="button-wrap "><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>


<script>
var headGrid;
var materialGrid;
var itemGrid;
var chatIfr;
var isloadItemGrid = false;
var editFileTable;

var businessElsAccount='<%=businessElsAccount%>';
var purchaseEnquiryNumberApp='<%=purchaseEnquiryNumberApp%>';
var stretegyCode= '<%=stretegyCode%>';
var flowCode='<%=flowCode%>';
var purchaseOrderNumberTemp = purchaseEnquiryNumberApp.slice(0,purchaseEnquiryNumberApp.length-1);
var purchaseEnquiryNumberApps = purchaseOrderNumberTemp.split(";");
var toElsAccount = "";
var purchaseEnquiryNumber = "";
var materialLineNumber = "";
for (var i in purchaseEnquiryNumberApps) {
	
	var test = purchaseEnquiryNumberApps[i].split(",");
	toElsAccount += test[0]+",";
	purchaseEnquiryNumber += test[1]+",";
	materialLineNumber += test[2]+",";
}
toElsAccount = toElsAccount.slice(0,toElsAccount.length-1);
purchaseEnquiryNumber = purchaseEnquiryNumber.slice(0,purchaseEnquiryNumber.length-1);
materialLineNumber = materialLineNumber.slice(0,materialLineNumber.length-1);
var taxRate=[];
var orderType;
var beginDate;
var endDate;
var currentPurchaseOrderNumber;
//销售方负责人
var rowIndexSelect=0;
var peopleList;
var $sob;
var checkAudit = false;

$(document).ready(function(){
	init();
	debugger;
//     materialGrid.load({});
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
        'windowTitle':'查看流程',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});

//物料列自定义
$("#materialColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'列自定义',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainMaterial_mt" + "&window=iframeApp_auditRecord",
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
	     'windowTitle':'列自定义',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainItem_mt" + "&window=iframeApp_auditRecord",
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
	     'windowTitle':'列自定义',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainFile" + "&window=iframeApp_auditRecord",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});

//渲染   @author jiangzhidong 20160113  begin
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
	else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
	else if (val == "4") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价" />';
	else if (val == "5") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价" />';
	else if (val == "6") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝" />';
	else if (val == "7") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束" />';
	else if (val == "8") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价" />';
};
//审批状态
var rendererAuditStatus = function (val,item,index){
	//审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
	if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
	else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
	else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
	else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';
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
function formatDate(val,item,index){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	     return val;
};
//附件需求
function initAccessoryRequire(val,item,index){
	if (val == "0") return '<i18n:I18n key="i18n_common_select_accessoryrequire_choosable" defaultValue="附件可选" />';
	else if (val == "1") return '<i18n:I18n key="i18n_common_select_accessoryrequire_require" defaultValue="必须附件" />';
};
//价格有效期
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
	debugger;
	if(!val) {
		var name = this.name+"_"+index;
		var id0 = name+"_0";
		var id1 = name+"_1";
		var checked0 = '';
		var checked1 = '';
		if(item.auditStatus==0) checked0 = checked0 + ' checked="checked"';
		if(item.auditStatus==3) checked1 = checked1 + ' checked="checked"';
		var selected = '';
		if(hasSelected&&item.auditStatus==2&&item.FBK33==''){
			selected = '<div style="text-align:left;min-width: 160px; margin:0 auto;style="position: absolute;"">'
				+'<input type="radio" name="'+name+'" id="'+id0+'" '+checked0+' style="width: 14px !important; display:inline-block; margin-left:5px !important;" />'
				+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
				+'<label style="display:inline-block; margin-left:22px; font-size:12px;">通过</label>'
				+'<input type="radio" name="'+name+'" id="'+id1+'" '+checked1+' style="width: 14px !important; margin-left: 55px !important;display:inline-block;" />'
				+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
				+'<label style="display:inline-block; margin-left:25px; font-size:12px;">拒绝</label>'
				+'</div>';
		}else{
			/*if(item.FBK12!=null&&item.FBK12!=''){
				var strs= [];
				if(item.FBK12.indexOf("@")!=-1){
					strs=item.FBK12.split("@");
				}else{
					strs.push(item.FBK12);
				}
				for(var i= 0; i<=strs.length-1; i++) {
					var fbk12 = strs[i];
					if(fbk12.indexOf(elsSubAccount)!=-1){
						var test = fbk12.split(":")[1];
						if(test==0) selected='已通过';
						if(test==3) selected='已拒绝';
					}
			 	}
			}else{
				selected='未提交';
			}*/
			selected=item.FBK33;
	   }
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
	else return val;
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
	    var sel = '<div><p style="display: none;">'+JSON.stringify(item)+'</p><select onchange="changeTaxCode(this.id, '+index+')" name="'+this.name+'" id="'+name+'_'+index+'" class="taxType" style="padding: 0;height: 25px;width: 100px;">';
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
//渲染   @author jiangzhidong 20160113  end

//订单状态: orderStatus 0-新建1-报价中2-议价中(废弃)3-审批中4-重报价5-已定价6-已拒绝7-已结束8-已报价9-已选择(废弃)
//中标状态：selectStatus 0：暂无  1：已中标 2：未中标  
//审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
var obj_this;
var obj_item;
var itemGridLoadSuccess = function(){
	$('[id^=priceSelected]').off('click').on('mousedown',function(){
	    updateItem(this);
	}).click(function(){
		if(this._v&&this.checked)this.checked=false;
	});
}

var updateItem = function (obj){
	var scanCol = $(obj).next('span').text();
	var item = JSON.parse(scanCol);
	var selectvalue = $(obj).next().next('label').text();
	if(checkAudit){
		alert("作废单据,不能执行操作!",2);
		loadItem();
		return;
	}
	if(item.auditStatus!=2){
		alert("审批中,才能执行操作!",2);
		loadItem();
		return;
	}
	if(selectvalue.indexOf('通过') != -1){
		item.auditStatus = 0;
		item.elsSubAccount = elsSubAccount;
		resetYes();
	}else if(selectvalue.indexOf('拒绝') != -1){
		item.auditStatus = 3;
		item.elsSubAccount = elsSubAccount;
		resetNo();
	}
	$("#sendMsgDialog").show();
	obj_this=this;
	obj_item=item;
}

//更新行
$("#sendMsgBtnOK").click(function() {
	var msgArea = $("#msgArea").val();
	obj_item.remark = msgArea;
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemSendToState' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(obj_item),
		dataType : "json",
		success : function(data) {
			//hasSelected = false;
			//loadItem();
			reset();
			obj_this._v=obj_this.checked;
			obj_this=null;
			obj_item=null;
			$("#sendMsgDialog").hide();
			alert(data.message,1);
			parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
		},error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});

});

//关闭
$("#dialogFileClose").click(function(){
	 $("#sendMsgDialog").hide();
	 reset();
});

$("#dialogFileClose2").click(function(){
	 $("#sendMsgDialog2").hide();
	 reset();
});

//重新加载
var reset = function() {
	 $("#msgArea").val('');
}
var resetYes = function() {
	 $("#msgArea").val('同意\n');
}
var resetNo = function() {
	 $("#msgArea").val('拒绝\n');
}

//--------------------------------------------------------------批量------------------------------------------------------
//接受
$("#acceptBtn").click(function(){
	debugger;
	var itemRows = itemGrid.rows();
	var itemRowsTo = [];
	for(var i= 0; i<=itemRows.length-1; i++) {
		if(itemRows[i].auditStatus==2){
			$('input[id="priceSelected_'+i+'_0"]').attr("checked", true);
			itemRows[i].auditStatus = 0;
			itemRows[i].elsSubAccount = elsSubAccount;
			if(itemRows[i].FBK33==null||itemRows[i].FBK33==""){
				itemRowsTo.push(itemRows[i]);
			}
		}
 	}
	updateItems(itemRowsTo);
});

//拒绝
$("#refuseBtn").click(function(){
	debugger;
	var itemRows = itemGrid.rows();
	var itemRowsTo = [];
	for(var i= 0; i<=itemRows.length-1; i++) {
		if(itemRows[i].auditStatus==2){
			$('input[id="priceSelected_'+i+'_1"]').attr("checked", true);
			itemRows[i].auditStatus = 3;
			itemRows[i].elsSubAccount = elsSubAccount;
			if(itemRows[i].FBK33==null||itemRows[i].FBK33==""){
				itemRowsTo.push(itemRows[i]);
			}
		}
 	}
	updateItems(itemRowsTo);
});

//更新行
var updateItems = function (obj){
	debugger;
	if(obj == null){
		return;
	}
	$("#sendMsgDialog2").show();
// 	obj_this=this;
// 	obj_item=item;
	$('body').data('selectCel',obj);
}

//更新行
$("#sendMsgBtnOK2").click(function() {
	debugger;
	$("#sendMsgDialog2").hide();
	var obj = $('body').data('selectCel');
	var itemRows = obj;
	//提交赋值
	for(var i= 0; i<=itemRows.length-1; i++) {
		itemRows[i].elsSubAccount = elsSubAccount;
		itemRows[i].remark = $("#msgArea2").val();
	}
	var frmObj = itemRows;
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToState' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(frmObj),
		dataType : "json",
		success : function(data) {
			if(data.message==null || data.message==''){
				//
			}else{
				alert(data.message,1);
			}
			query();
		},error : function(data) {
			alert(data.message,3);
		}
	});

});
//加载数据物料表
function query() {
	debugger;
	materialGrid.load({});
}

//物料表purchase_enquiry_material
var material_cols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryBargainMaterial"/>;

//行表purchase_enquiry_item  阶梯表purchase_enquiry_ladder_price  成本表purchase_receive_enquiry_cost_constitute
var item_cols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryBargainItem_mt"/>;
item_cols[0].width=102;
	
//我方文件(即接收我方的文件)：sale_receive_enquiry_file  对方文件(即接收对方的文件)：purchase_receive_enquiry_file
var file_cols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryBargainFile"/>;
    
//初始化控件
function init() {
	//头表head
    var headParam = {
    	'elsAccount':currentElsAccount,
    	'toElsAccount':toElsAccount,
    	'purchaseEnquiryNumber':purchaseEnquiryNumber
    };
    //加载头
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryOtherService/queryEnquiryHeadByCondtionBatch' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(headParam),
		dataType : "json",
		success : function(data) {
			var arr = new Array();
			for(var i= 0; i<=data.rows.length-1; i++){
				arr.push(data.rows[i].purchaseEnquiryNumber);
			}
// 			//报价单作废，领导审批不可以通过
// // 			if(data.orderStatus==10) checkAudit = true;
			$("#purchaseEnquiryNumber").text(arr);
// 			var beginDate = data.beginDate;
// 			if (beginDate!=null&&beginDate.length!=10)
//         		beginDate = new Date(beginDate).format("yyyy-MM-dd");
//         	var endDate = data.endDate;
//         	if (endDate!=null&&endDate.length!=10)
//         		endDate = new Date(endDate).format("yyyy-MM-dd");
// 			$("#beginDate").text(beginDate);
// 			$("#endDate").text(endDate);
			
// 			var orderTypeName="错误询价";
// 			if(data.orderType==0)
// 				orderTypeName='<i18n:I18n key="i18n_enquiry_select_enquirytype_market" defaultValue="行情询价" />';
// 			else if(data.orderType==1)
// 				orderTypeName='<i18n:I18n key="i18n_enquiry_select_enquirytype_material" defaultValue="物料询价" />';
// 			else if(data.orderType==2)
// 				orderTypeName='<i18n:I18n key="i18n_enquiry_select_enquirytype_texture" defaultValue="材质询价" />';
// 			$("#orderType").text(orderTypeName);
		},
		error : function(data) {
			alert('<i18n:I18n key="i18n_js_load_fail" defaultValue="数据加载失败" />',3);
		}
	});
	debugger;
	//头表head
    var materialParam = {
    	'elsAccount':currentElsAccount,
    	'elsSubAccount':elsSubAccount,
    	'purchaseEnquiryNumber':purchaseEnquiryNumber,
    	'fbk1':materialLineNumber
    };
	debugger;

	//物料表material
    materialGrid = $('#table-materialItem').mmGrid({
        cols: material_cols,
        height: 200,
        url : '<%=basePath%>rest/PurchaseEnquiryOtherService/queryMaterialByCondtionBatch',
        params: materialParam,
        method:  'POST',
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol: true,
        multiSelect: true,
        plugins: [
            $('#pg').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                , limit:null
                , limitList: [10,20]
            })
        ]
    });
    
    // 加载明细项
    materialGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	rowIndexSelect=rowIndex;
    	loadItem();
    });
    
    materialGrid.on('loadSuccess',function(e, data) {
    	debugger;
		if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			materialGrid.select('all');
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
    		debugger;
    		materialGrid.deselect('all');
    		loadItem();
    	}
    });
    
    //查看历史报价纪录
    $('.col-price-his').live("click", function() {
        var scanCol = $(this).next().text();
        var item = JSON.parse(scanCol);
        parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'PurchaseEnHisPrice',
            'windowTitle':'查看历史报价记录',
            windowSubTitle: '报价记录',
            'iframSrc':'<%=basePath%>enquirymanage/purchase/purchaseBargainHisManage.jsp?'+JSON.stringify(item),
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
     	var headRows = materialGrid.rows();
     	for(var i= 0; i<=headRows.length-1; i++) {
     		var selVal = headRows[i].materialNumber+'-'+headRows[i].materialDesc;
     		$('#selectFileType').append('<option value='+selVal+'>'+selVal+'</option>');
     	}
     	
     	loadFile();
    });
    //我方的文件  对方的文件
    $('#selectPurchaseSale').change(function(){
    	loadFile();
    });
     //所有文件  公共文件  物料文件
     $('#selectFileType').change(function(){
     	loadFile();
    });
}

//行表item
itemGrid = $('#table-item').mmGrid({
			        cols: item_cols,
			        height: 300,
			        //items:data.rows,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        checkCol: true,
			        multiSelect: true
			    }).on('loadSuccess',itemGridLoadSuccess);
			    
function loadItem() {
	debugger;
	    var material = materialGrid.selectedRows();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/queryEnquiryItemsByCondtion' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(material),
			dataType : "json",
			success : function(data) {
				debugger;
				var arr = new Array();
				var dat = data.rows;
				//只查询"审批中"
				if(dat!=null){
				for(var i= 0; i<=dat.length-1; i++){
					if(dat[i].auditStatus==0 || dat[i].auditStatus==null){
						
					}
					arr.push(dat[i]);
				}
				}
				itemGrid.load(arr);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_js_load_fail" defaultValue="数据加载失败" />',3);
			}
		});
}

//刷新
$("#flushFileBtn").click(function() {
	editFileTable.load({});
})

//加载表单文件列表
function loadFile() {

    var items = itemGrid.rows();
    var toElsAccounts = '';
 	for(var i= 0; i<=items.length-1; i++) {
 		if (i==0) 
 			toElsAccounts = items[i].toElsAccount;
 		else 
 			toElsAccounts = toElsAccounts+'-'+items[i].toElsAccount;
 	}
    
    //文件参数
    var sft = $('#selectFileType').val().split("-");
	var sps = $('#selectPurchaseSale').val();
	var fileParam = {
		'elsAccount':currentElsAccount,
		'elsSubAccount':elsSubAccount,
		'purchaseEnquiryNumber':purchaseEnquiryNumber,
		'purchaseMaterialNumber':sft[0],
      	'purchaseMaterialDesc':sft[1],
      	'FBK1':sps,
      	'FBK3':toElsAccounts
	};
     
	//$('#reCreateFile').html('<table id="add-file-project"></table><div id="enquiryFilePage" style="text-align: right;"></div>');
	if(!editFileTable){
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
	} else {
		editFileTable.load(fileParam);
	}
	
	 //---------------文件展示----begin------------------
    editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
  		previewFile(filePath);
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
    		parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "不支持在线预览的文档类型!"});
    	}
    }
      //---------------文件展示----end------------------
	
}

$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
});

function closeCallback() {
	if (parent.frames["iframeApp_auditList"]) {
		parent.frames["iframeApp_auditList"].query();
	}
}
</script>

</body>
</html>