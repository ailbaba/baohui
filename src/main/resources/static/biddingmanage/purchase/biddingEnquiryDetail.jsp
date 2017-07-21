<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String biddingNumber = request.getParameter("biddingNumber");
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>

<style>
table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>

<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="sendToSupplier" class="button-wrap"><i18n:I18n key="test" defaultValue="发送至投标方" /></button>
                <base:auditConfig elsAccount="${elsAccount}" businessType="bargainEnquiry">
					<button id="entryBtn" class="button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批" /></button>
					<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
					<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
				</base:auditConfig>
				<button id="uploadToERP" class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_uploadToERP" defaultValue="发送至ERP" /></button>
				<%-- <button id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="列自定义" /></button> --%>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_purchase_bargain_item" defaultValue="询价单行项目" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                     <ul>
                     	<li><a href="#edit-line-baseInfo">基本信息</a></li>
				    	<li class="add-file-sheet"><a href="#edit-line-connType"><i18n:I18n key="test" defaultValue="联系方式" /></a></li>
				    	<li class="add-file-sheet"><a href="#edit-line-bail"><i18n:I18n key="test" defaultValue="保证金" /></a></li>
				    	<li><a href="#sheet-project-one"><i18n:I18n key="test" defaultValue="招标内容" /></a></li>
				    	<li class="add-supplie-sheet"><a href="#edit-line-three"><i18n:I18n key="test" defaultValue="受邀方" /></a></li>
                        <li><a class="scan-file-sheet" href="#edit-line-file"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                    </ul>
                    
                <!-- 基本信息 -->
				<div id="edit-line-baseInfo">
					<div class="box-wrap pos-relative bg-common">
					  <table>
				    	<tbody>
				    		<tr>
				    			<td colspan="1" align="right"><span style="color: red;">*</span><i18n:I18n key="test" defaultValue="招标类型:" /></td>
				    			<td colspan="1" align="left">
									<select id="biddingType" name="biddingType" style="width: 164px; max-width: 164px;" disabled="disabled">
									<option value="">ALL_类型</option>
									<option value="0">邀请招标</option>
									<option value="1">公开招标</option>
									<option value="2">项目招标</option>
					            </select>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标编码:" /></td>
				    			<td colspan="1" align="left">
									<input id="biddingNumber" name="biddingNumber" type="text" style="width: 200px;"  readonly = "readonly"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><span style="color: red;">*</span><i18n:I18n key="test" defaultValue="招标名称:" /></td>
				    			<td colspan="1" align="left">
									<input id="biddingName" name="biddingName" type="text" style="width: 200px;"  readonly = "readonly"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标说明:" /></td>
				    			<td colspan="1" align="left">
									<textarea id="remark" name="remark" style="width:500px;height:80px" readonly = "readonly"></textarea>
								</td>
				    		</tr>
				    	</tbody>
				       </table>
						<main class="grid-container">
						<div class="grid-100">
							<table id="baseTable"></table>
						</div>
						</main>
					</div>
				</div>
                    
                <!-- 联系方式 -->
				<div id="edit-line-connType">
					<div class="input-and-tip">
						<span>招标单位:</span> 
						<input id="tenderCompany" name="tenderCompany" type="text" style="width: 500px;"  readonly = "readonly"/>
					</div>
					<div class="input-and-tip">
						<span>负  责  人:</span>&nbsp;
						<input id="principal" name="principal" type="text" style="width: 500px;"  readonly = "readonly"/>
					</div>
					<div class="input-and-tip">
						<span>联系电话:</span> 
						<input id="telephone" name="telephone" type="text" style="width: 500px;" readonly = "readonly"/>
					</div>
					<div class="input-and-tip">
						<span>电子邮箱:</span> 
						<input id="email" name="email" type="text" style="width: 500px;" readonly = "readonly"/>
					</div>
					<div class="input-and-tip">
						<span>电子传真:</span> 
						<input id="fax" name="fax" type="text" style="width: 500px;" readonly = "readonly"/>
					</div>
					<div class="input-and-tip">
						<span>联系地址:</span> 
						<input id="address" name="address" type="text" style="width: 500px;" readonly = "readonly"/>
					</div>
				</div>
				
				<!-- 保证金-->
				<div id="edit-line-bail">
				  <table>
			    	<tbody>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="收取保证金:" /></td>
			    			<td colspan="1" align="left">
								<input id="" name="radio1" type="radio"/>是
								<input id="" name="radio1" type="radio" checked="true"/>否
							</td>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="退还保证金:" /></td>
			    			<td colspan="1" align="left">
								<input id="" name="radio2" type="radio" checked="true"/>是
								<input id="" name="radio2" type="radio"/>否
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金金额:" /></td>
			    			<td colspan="3" align="left">
								<input id="" name="" type="text" style="width: 300px;" value="10000" readonly = "readonly"/>
								<select id="" name="">
									<option>CNY</option>
									<option>HK</option>
									<option>USD</option>
									<option>GBP</option>
								</select>
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="缴纳日期(从):" /></td>
			    			<td colspan="3" align="left">
								<input type="text" class="Wdate" onfocus="WdatePicker({lang:'<%=session.getAttribute("language") %>'})" id="beginDate" name="beginDate" value="2016-02-24" readonly = "readonly"/>
				  				<span><i18n:I18n key="test" defaultValue="到" /></span>
	                    		<input type="text" class="Wdate" onfocus="WdatePicker({lang:'<%=session.getAttribute("language") %>'})" id="endDate" name="endDate" value="2016-02-27" readonly = "readonly"/>
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金细节规则:" /></td>
			    			<td colspan="3" align="left">
								<textarea style="width: 500px; height: 80px" readonly = "readonly">招标细节管理规则如下：1、公开原则 2、数据真实性</textarea>
							</td>
			    		</tr>
			    	</tbody>
			      </table>
				</div>
                    
                 <!-- 招标内容 -->
                 <div id="sheet-project-one">
                  	   <table>
					    	<tbody>
					    		<tr>
					    			<td colspan="1" align="right">招标内容&nbsp;<br/>总体描述:</td>
					    			<td colspan="1" align="left">
										<textarea id="contentremark" name="contentremark" style="width: 800px; height: 80px" readonly="readonly"></textarea>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="所属项目:" /></td>
					    			<td colspan="1" align="left">
										<input id="contentbiddingProjectNumber" name="biddingProjectNumber" type="text" style="width: 200px;" readonly="readonly"/>
										<input id="contentfbk1" name="fbk1" type="text" style="width: 300px;" readonly="readonly"/>
									</td>
					    		</tr>
					    	</tbody>
					   </table>
                       <main class="grid-container nest-table">
		                    <div class="grid-100" id="reCreate">
		                        <table id="table-item"></table>
		                        <div id="pg-price" style="text-align: right;"></div>
		                    </div>
                	   </main>
                  </div>
                  
                 <!-- 受邀方 -->
                  <div class="p-zero" id="edit-line-three">
                     <div class="fixed-dialog supplie-groud" >
                     </div>
                     <main class="bg-common p-6">
                        <div class="edit-box-wrap">
                        </div>
                        <div class="grid-100" >
                              <table id="add-supplie-project"></table>
                               <div id="enquirySuppliePage" style="text-align: left;"></div>
                               </div>
                     </main>
                    </div>
                    
                  <!-- 表单文件 -->
                  <div id="edit-line-file">
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
					                     <button id="downloadFile" class="button-wrap">下载</button>
					                     <!-- <button id="lookFile" class="button-wrap">在线查看</button> -->
							             <button id="fileColumnDefineBtn" class="button-wrap">列自定义</button>
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
<script>

var materialGrid;
var itemGrid;
var itemRounds;
var chatIfr;
var isloadItemGrid = false;
var editFileTable;
var editSupplieTable;
var biddingNumber='<%=biddingNumber%>';
var currentPurchaseOrderNumber;
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var rowIndexSelect=0;
var peopleList;
var $sob;

$(document).ready(function(){
	init();
});

//发送至投标方
$("#sendToSupplier").click(function() {
	var yes = false;
	var yes2 = 0;
	var itemRows = itemGrid.selectedRows();
	var itemRowsIndex=itemGrid.selectedRowsIndex();
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_alert_bargain_pleaseSelectItem" defaultValue="请选择行项目!" />!',2);
		return;
	}
	
	for(var i= 0; i<=itemRows.length-1; i++) {
		var ind = itemRowsIndex[i];
		var selectvalue =document.getElementsByName("selected")[ind].value;
		if(selectvalue != null){
			if(selectvalue.indexOf('接受') != -1 
					|| selectvalue.indexOf('淘汰') != -1){
				yes = true;
			}
		}
	}
	if(!yes){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_reallySent" defaultValue="是否确认发送?" />',closeEvent:function(){
		debugger;
		for(var i= 0; i<=itemRows.length-1; i++) {
			var ind = itemRowsIndex[i];
			var selectvalue =document.getElementsByName("selected")[ind].value;
			if(selectvalue != null){
				if(selectvalue.indexOf('接受') != -1){
					itemRows[i].auditStatus = 0; 
				}else if(selectvalue.indexOf('淘汰') != -1){
					itemRows[i].auditStatus = 3;
				}
			}
		}
		
		parent.elsDeskTop.showLoading();
		//发送至供应商
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/enquiryContentItemsSendToSuppliers' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRows),
			dataType : "json",
			success : function(data) {
    			alert('<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />',1);
    		},error : function(data) {
    			alert('<i18n:I18n key="i18n_common_sendfail" defaultValue="发送失败" />',3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    			loadItem();
    		}
		});
		

	}});
	
});

//提交审批
$("#entryBtn").click(function(){

	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_confirmReportAudit" defaultValue="是否确定提交审批?" />!',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToAudit' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRows),
			dataType : "json",
			success : function(data) {
    			alert(data.message,1);
    			query();
    		},error : function(data) {
    			alert("发送失败",3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}});
});

//撤销审批
$("#cancelEntryBtn").click(function(){
	
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

//发送至ERP
$("#uploadToERP").click(function(){
	var itemRows = itemGrid.selectedRows();
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_title_sendToErp" defaultValue="是否确定发送ERP?" />!',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		//发送至供应商
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToERP' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRows),
			dataType : "json",
			success : function(data) {
    			alert(data.message,1);
    			query();
    		},error : function(data) {
    			alert(data.message,3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}});
});

//招标内容  列自定义
$("#itemColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainItem" + "&window=iframeApp_PurchaseEnquiryDetail",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});


//表单文件  列自定义
$("#fileColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainFile" + "&window=iframeApp_PurchaseEnquiryDetail",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});


// 渲染   @author jiangzhidong 20160113  begin
//类型 
var rendererPurchaseType = function (val,item,index){
	if(val==0) return "外购";
	else if(val==1) return "外协";
	else if(val==2) return "寄售票员";
	else if(val==3) return "其他";
	else return "未说明";
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
//招标状态
function rendererBiddingStatus(val){
    	if(val==0){
    		return '<i18n:I18n key="test" defaultValue="未开始" />';
    	}else if(val==1){
    		return '<i18n:I18n key="test" defaultValue="进行中" />';
    	}else if(val==2){
    		return '<i18n:I18n key="test" defaultValue="已定标" />';
    	}else if(val==3){
    		return '<i18n:I18n key="test" defaultValue="已完成" />';
    	}
}
//评标状态
var rendererAuditStatus = function (val,item,index){
	if (val == "0") return '<i18n:I18n key="test" defaultValue="接受" />';
	else if (val == "3") return '<i18n:I18n key="test" defaultValue="淘汰" />';
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
//时间
var formatTime = function (val,item,index){
	if (!val) {val = "";}
	return new Date(val).format("hh:mm:ss");
};
//附件需求
var initAccessoryRequire = function (val,item,index){
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
		var selected = '<select name="selected" id="selected"  style="color:blue; min-width:70px; padding:5px;">'
						+'<option value =""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>'
						+'<option value ="接受"><i18n:I18n key="i18n_common_title_accept" defaultValue="接受" /></option>'
						+'<option value ="淘汰"><i18n:I18n key="test" defaultValue="淘汰" /></option></select>'
		return selected;
	}
};
//时间戳
var formatDateTime = function (val,item,index){
	if (!val) {val = "";}
	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
};


//渲染   @author jiangzhidong 20160113  end

var cols_rounds = [
     			{title:'轮次',name:'roundsNumber', width: 100, align: 'center'},
     			{title:'投标开始日期',name:'biddingBeginDate', width: 160, align: 'center', renderer:formatDateTime},
     			{title:'投标结束日期', name:'biddingBeginDate', width: 160, align: 'center', renderer:formatDateTime},
     			{title:'状态',name:'biddingStatus', width: 120, align: 'center', renderer:rendererBiddingStatus}
     		];

//招标内容
var item_cols = 
	   [{ title:'项目编号' , name:'materialLineNumber', width: 100, align:'center'},
		{ title:'招标内容', name:'materialNumber' ,width:100, align:'center'},
		{ title:'项目名称描述', name:'materialDesc' ,width:100, align:'center'},
		{ title:'型号', name:'fbk2' ,width:100, align:'center'},
	    { title:'规格&性能', name:'materialSpecification', width: 80, align: 'center'},
	    { title:'单位', name:'unitQuantity', width: 120, align: 'center'},
	    { title:'数量', name:'quantity' ,width:100, align:'center'},
	    { title:'品牌', name:'property1' ,width:100, align:'center'},
	    { title:'颜色', name:'property2' ,width:100, align:'center'},
	    { title:'长', name:'property3' ,width:100, align:'center'},
	    { title:'宽', name:'property4' ,width:100, align:'center'},
	    { title:'高', name:'property5' ,width:100, align:'center'},
// 	    { title:'报价价格', name:'priceIncludingVat' ,width:70, align:'center'},
	    { title:'完成日期', name:'deliveryDate' ,width:100, align:'center',renderer:formatDate },
		{ title:'备注', name:'remark', width: 90, align: 'center'},
];
			

//表单文件
var file_cols = [
		{ title:'文件名称', name:'fileName' , width:100, align:'center'},
		{ title:'文件路径', name:'filePath', width:200, align:'center'},
		{ title:'文件类型', name:'fileType', width:100, align:'center'},
		{ title:'文件大小', name:'fileSize', width:100, align:'center'},
		{ title:'备注', name:'remark', width:100, align:'center'}];
  
//初始化控件
function init() {
    		
    //头表purchase_bidding_header
    var headParam = {
    	'elsAccount':elsAccount,
    	'biddingNumber':biddingNumber
    };
	
    //加载头
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/getPurchaseEnquiryBidding' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(headParam),
		dataType : "json",
		success : function(data) {
			//招标编号
			$("#biddingNumber").val(data.biddingNumber);
			//招标名称
			$("#biddingName").val(data.biddingName);
			//招标日期
			var beginDate = data.beginDate;
			if (beginDate!=null&&beginDate.length!=10)
        		beginDate = new Date(beginDate).format("yyyy-MM-dd");
        	var endDate = data.endDate;
        	if (endDate!=null&&endDate.length!=10)
        		endDate = new Date(endDate).format("yyyy-MM-dd");
			$("#beginDate").text(beginDate);
			$("#endDate").text(endDate);
			//招标类型
			var biddingType="错误";
			if(data.biddingType==0)
				biddingType='<i18n:I18n key="test" defaultValue="邀请招标" />';
			else if(data.biddingType==1)
				biddingType='<i18n:I18n key="test" defaultValue="公开招标" />';
			else if(data.biddingType==2)
				biddingType='<i18n:I18n key="test" defaultValue="项目招标" />';
			$("#biddingType").val(data.biddingType);
			
			//招标说明
			$("#remark").val(data.remark);
			
			//采购方招标轮次信息
			itemRounds.load(data.purchaseBiddingRounds);
			//采购方招标联系人信息
			$("#tenderCompany").val(data.purchaseBiddingLinkMan[0].fbk1);
			$("#principal").val(data.purchaseBiddingLinkMan[0].principal);
			$("#telephone").val(data.purchaseBiddingLinkMan[0].telephone);
			$("#email").val(data.purchaseBiddingLinkMan[0].email);
			$("#fax").val(data.purchaseBiddingLinkMan[0].fax);
			$("#address").val(data.purchaseBiddingLinkMan[0].address);
			//采购方投标内容行编号
			loadItem();
			//采购方招标内容信息
			if(data.purchaseBiddingContent!=null&&data.purchaseBiddingContent!=''){
				$("#contentremark").val(data.purchaseBiddingContent.remark);
				$("#contentbiddingProjectNumber").val(data.purchaseBiddingContent.biddingProjectNumber);
				$("#contentfbk1").val(data.purchaseBiddingContent.fbk1);
			}
		},
		error : function(data) {
			alert("加载失败",3);
		}
	});
    
	 //招标轮次信息
    itemRounds = $('#baseTable').mmGrid({
        cols: cols_rounds,
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol: false,
        multiSelect: true
    });
    
    //加载  表单文件
    var tab=$( "#sheet-project").tabs();
    $('.scan-file-sheet').click(function() {
    	debugger;
    	$('#selectFileType').empty();
     	$('#selectFileType').append('<option value=0><i18n:I18n key="i18n_common_select_filetype_all" defaultValue="所有文件" /></option>');
 		$('#selectFileType').append('<option value=1><i18n:I18n key="i18n_common_select_filetype_public" defaultValue="公共文件" /></option>');
     	loadFile();
    })

}
 	
//招标内容
itemGrid = $('#table-item').mmGrid({
	        cols: item_cols,
	        height: 300,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        indexCol: true
	    });

//采购方投标内容行编号表purchase_bidding_content_item
var biddingContentItemParam = {
	'elsAccount':elsAccount,
	'biddingNumber':'<%=biddingNumber%>'
};

//加载 招标内容
function loadItem() {
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryPurchaseBiddingContentItemByCondtion' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(biddingContentItemParam),
			dataType : "json",
			success : function(data) {
				itemGrid.load(data.rows);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
			}
		});
		 
}

//表单文件
function loadFile() {
    
	var fileParam = {
		'elsAccount':elsAccount,
    	'biddingNumber':biddingNumber
	};
     
	if(!editFileTable){
		editFileTable=$('#add-file-project').mmGrid({
		    cols: file_cols,
		    url: '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryReceiveBiddingFileByCondtion',
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
	
	//刷新
	$("#flushFileBtn").click(function() {
		editFileTable.load({});
	})
	
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
    		parent.elsDeskTop.tip.init({type: 'alert',displayType: 3, message: '<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型!" />'});
    	}
    }
      //---------------文件展示----end------------------
	
}

//加载供应商列表-------------------begin---------------------
var colsSupplie = [
                   { title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS账号"/>', name:'toElsAccount' , width:150, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_title_suppliername" defaultValue="供应商名称"/>', name:'toElsDesc' , width:130, align:'center'}
               ];

$(".add-supplie-sheet").click(function() {
	 if(!editSupplieTable){
		 editSupplieTable=$('#add-supplie-project').mmGrid({
            cols: colsSupplie,
            url: "<%=basePath%>rest/PurchaseEnquiryBiddingService/queryPurchaseBiddingSupplieList",
            params:{"biddingNumber":biddingNumber,"elsAccount":elsAccount},
            width:400,
            method: 'post',
            root: 'rows',
            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
            fullWidthRows:true,
            plugins: [
                      $('#enquirySuppliePage').mmPaginator({
                          style: 'plain'
                          , totalCountName: 'total'
                          , page: 1
                          , pageParamName: 'currentPage'
                          , limitParamName: 'pageSize'
                          , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                          , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                          , limit: null
                          , limitList: [10, 30, 40, 50]
                      })
                  ]
          });
	 }
});
//加载供应商列表-------------------end---------------------

</script>

</body>
</html>