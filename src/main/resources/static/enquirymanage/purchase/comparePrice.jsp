<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<style>
 .diffentTr{
    background: #B9DABF;
}
.line{
	height: 24px;
	line-height: 24px;
}
b{
  font-weight: normal;
  width:80px;
  display: inline-block;
  border:1px solid #eee;
  /*text-align: center;*/
  /*border-bottom: none;*/
}
.LH30{
	line-height: 24px;
}
</style>
<body>
<div class="box-wrap pos-relative bg-common">
  <div class="box-wrap pos-relative bg-common">
    <div class="common-box-line row-fluid">
        <button class="span1 padClear button-wrap width_2text" id="sendBtn"><i18n:I18n key="" defaultValue="发送" /></button>
         <button id="passBtn" class="span12 padClear button-wrap width_4text isAudit"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
		<button id="noPassBtn" class="span12 padClear button-wrap width_4text isAudit"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
		<button id="cancelBtn" class="span12 padClear button-wrap width_4text isAudit"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
	    <button id="flowBtn" class="span12 padClear button-wrap width_2text isAudit"><i18n:I18n key="i18n_approval_flow" defaultValue="流程" /></button>
    </div>
</div>
<form id="editEnquiryForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
  <input id="elsAccount" name="elsAccount"  type="hidden"/>
  <input id="elsSubAccount" name="elsSubAccount"  type="hidden"/>
  <input id="enquiryNumber" name="enquiryNumber"  type="hidden"/>
  <input id="toResponsible" name="toResponsible"  type="hidden"/>
  <div class="box-wrap pos-relative bg-common" >
           <div class="p-zero" id="edit-line-one">
               <main class="grid-container">
                  <div class="grid-100">
                      <table id="item-table"></table>
                  </div>
                </main>
            </div>
    </div>
</form>
</div>

<div class="fixed-dialog">
	<div class="dialog-tip bg-common" style="width: 362px;height: 222px; margin-left: -131px;margin-top: -190px;">
	   <div class="dialog-close-btn"></div>
	   <div class="tip-head" style="padding-top: 16px;padding-left: 16px;">
           <span id="dialogTitle"><i18n:I18n key="i18n_title_fillOpinion" defaultValue="填写审批意见" /></span>
	   </div>
	   <div>
		   <div class="box-wrap pos-relative bg-common" style="height: 224px;">
			  <div class="common-box-line">
				  <textarea id="auditOpinion" name="auditOpinion" style="width:95%;" rows="7" maxlength="200"></textarea>
			      <div>
			         <button id="btnFileOK1" class="span12 padClear button-wrap width_4text"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="同意" /></button>
			         <button id="btnFileOK2" class="span12 padClear button-wrap width_4text"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="拒绝" /></button>
			         <button id="btnFileCancel1" class="span12 padClear button-wrap width_2text"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
		          </div>
	           </div>
			</div>
		</div>
	</div>
</div>
<script>
var itemGrid;
var enquiryNumber ='<%=request.getParameter("enquiryNumber") %>';
var enquiryType ='<%=request.getParameter("enquiryType") %>';
var openType ='<%=request.getParameter("openType") %>';
var businessElsAccount = '<%=request.getParameter("businessElsAccount")%>';
var stretegyCode = '<%=request.getParameter("stretegyCode")%>';
var flowCode = '<%=request.getParameter("flowCode")%>';

var itemCols;

$(document).ready(function(){
	$('#add-enq-sheet').tabs();
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	$("#enquiryNumber").val(enquiryNumber);
	$("#toResponsible").val(toResponsible);
	$.ajax({
	    url :"<%=basePath%>rest/PurchaseEnquiryBargainService/getComparePriceCols",
	    type :"post",
	    contentType : "application/json",
	    data : JSON.stringify({"elsAccount":elsAccount,"enquiryNumber":enquiryNumber,"enquiryType":enquiryType}),
	    dataType : "json",
	    success : function(data) {
	    	console.log(data)
	    	itemCols = eval('(' + data.cols + ')');
	    	init(itemCols);
	    }
    });
});

function init(itemCols){
	var queryType = "all";
	if(openType == "audit"){
		queryType = "audit";
		$("#sendBtn").hide();
	}else{
		$(".isAudit").hide();
	}
	var param = {"elsAccount":elsAccount,"enquiryNumber":enquiryNumber,"queryType":queryType};
	itemGrid=$('#item-table').mmGrid({
	    cols: itemCols,
	    url: '<%=basePath%>rest/inquiry/EnquiryService/getComparePriceDetail',
	    params: param,
	    height: document.documentElement.clientHeight - 110,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    multiSelect:true,
	    checkCol:true
	});
	itemGrid.on('loadSuccess',function(e, data){
		$(".checkAll").hide();
	});
	itemGrid.on('cellSelected',function(e, item, rowIndex, colIndex){
		initFlowBtn();
	});
}

//只能2位数字
function clearNoNum(obj) {  
    obj.value = obj.value.replace(/[^(\d)]/g,'');
    obj.value = obj.value.length > 2 ?obj.value.substring(0,2):obj.value;
}

//渲染不可编辑Input
function rendNotEditInput(val){
	if(!val) val="";
	var name = $(this)[0].name;
	return val+"<input name='enquiryItemList[]["+name+"]'  type='hidden' value='"+val+"'/>";
}

function rendQuoteDetail(val,item,index){
	var toElsAccount = $(this)[0].name;
	var itemsJsonStr = item.fbk2;
	var items = JSON.parse(itemsJsonStr);
	for(var i in items){
		var item = items[i];
		if(toElsAccount == item.toElsAccount){//该供应商在该物料有报价
			var text="";
			var quoteMethod = item.quoteMethod;//报价方式
			if(quoteMethod == "1" && item.ladderPriceJson != ""){//阶梯报价
				  text = "<div class='line'><b>阶梯级</b><b>含税价</b><b>不含税价</b></div>";
				  var ladderPriceJson = item.ladderPriceJson;
			    var ladderObjs = JSON.parse(ladderPriceJson);
			    var ladderGrade = " ";
			    var priceIncludingTax = " ";
			    var priceExcludingTax = " ";
			    for(var j in ladderObjs){
			    	var ladderObj = ladderObjs[j];
			    	ladderGrade = ladderObj.ladderQuantity;
			    	priceIncludingTax = ladderObj.priceIncludingTax?ladderObj.priceIncludingTax:"";
			    	priceExcludingTax = ladderObj.priceExcludingTax?ladderObj.priceExcludingTax:"";
			    	text += "<div class='line'><b>" + ladderGrade + "</b>" + "<b>" + priceIncludingTax + "</b>"+ "<b>" + priceExcludingTax + "</b></div>";
			    }
			    
			}else{//常规报价
				var priceIncludingTax = item.priceIncludingTax?item.priceIncludingTax:"";
				var priceExcludingTax = item.priceExcludingTax?item.priceExcludingTax:"";
				text += "<div class='LH30'>" + "含税价："+priceIncludingTax + "</div>";
				text += "<div class='LH30'>" + "不含税价："+priceExcludingTax + "</div>";
			}
			var priceBase = item.priceBase?item.priceBase:"";//价格基数
			var unitPrice = item.unitPrice?item.unitPrice:"";//价格单位
			var unitQuantity = item.unitQuantity?item.unitQuantity:"";//数量单位
			var currency = item.currency?item.currency:"";//币种
			var taxRate = item.taxRate?item.taxRate:"";//税率
			var purchaseCycle = item.purchaseCycle?item.purchaseCycle:"";//采购周期
			var minPackQuantity = item.minPackQuantity?item.minPackQuantity:"";//最小包装量
			var minOrderQuantity = item.minOrderQuantity?item.minOrderQuantity:"";//最小订单量
			var quoteUnit = item.quoteUnit?item.quoteUnit:0;//报价单位
			var departSite = item.departSite?item.departSite:"";//出发地
			var destination = item.destination?item.destination:"";//目的地
			var weight = item.weight?item.weight:"";//重量（KG）
			var volume = item.volume?item.volume:"";//体积（M3）
			var fbk10 = item.fbk10?item.fbk10:"";//上次价格
			var fbk12 = item.fbk12?item.fbk12:"";//上次价格日期
			var quoteUnits = ["","票","件","公斤","立方米"];
			
			text += "<div class='LH30'>" + "币种："+currency+"</div>";
			text += "<div class='LH30'>" + "税率："+taxRate+"</div>";
			var quotaPlanFactor = item.quotaPlanFactor?item.quotaPlanFactor:"";
			if(enquiryType == "1"){
				text += "<div class='LH30'>" + "上次价格："+fbk10+"</div>";
				text += "<div class='LH30'>" + "上次价格日期："+fbk12+"</div>";
				text += "<div class='LH30'>" + "价格基数："+priceBase+"</div>";
				text += "<div class='LH30'>" + "价格单位："+unitPrice+"</div>";
				text += "<div class='LH30'>" + "数量单位："+unitQuantity+"</div>";
				text += "<div class='LH30'>" + "采购周期："+purchaseCycle+"</div>";
				text += "<div class='LH30'>" + "最小包装量："+minPackQuantity+"</div>";
				text += "<div class='LH30'>" + "最小订单量："+minOrderQuantity+"</div>";
				text += "<div class='LH30' style='position: relative;width: 80px;'>" + "配额：<input onkeyup='clearNoNum(this)' readonly='readonly' class='inDisabled'  type='text' id='quotaPlanFactor_"+toElsAccount+"_"+item.itemNumber+"' value='"+quotaPlanFactor+"' style='left: 58%;background-color: #D0EFD0;height: 26px !important;    line-height: 26px !important;'/></div>";
			}else{
				text += "<div class='LH30'>" + "出发地："+departSite+"</div>";
				text += "<div class='LH30'>" + "目的地："+destination+"</div>";
				text += "<div class='LH30'>" + "重量（KG）："+weight+"</div>";
				text += "<div class='LH30'>" + "体积（M3）："+volume+"</div>";
				text += "<div class='LH30'>" + "报价单位："+quoteUnits[quoteUnit]+"</div>";
			}
			var costConstituteJson = item.costConstituteJson;
			if(costConstituteJson && costConstituteJson !=""){
				var itemJsons = JSON.parse(costConstituteJson);
				var costItemCode = " ";
		    	var costItemName = " ";
		    	var amount = " ";
		    	var remark = " ";
		    	text += "<div class='line'><b>成本项目</b><b>成本金额</b></div>";
		    	for(var j in itemJsons){
		    		var itemJson = itemJsons[j];
		    		costItemCode = itemJson.costItemCode;
		    		costItemName = itemJson.costItemName;
		    		amount = itemJson.amount?itemJson.amount:"";
			    	remark = itemJson.remark?itemJson.remark:"";
			    	text += "<div class='line'><b>" + costItemName + "</b>" + "<b>" + amount + "</b></div>";
		    	}
			}
			if(item.noQuoted == "Y"){//不能报价
				text += '<div class="LH30"><span style="color: red">不能报价：是</span></div>';
			}
			var fbk2 = item.fbk2?item.fbk2:"";//排名
			if(fbk2 == "1"){
				text += '<div class="LH30"><span style="color: red">最低报价</span></div>';
			}else{
				text += "<div class='LH30'>排名："+fbk2+"</div>";
			}
			var itemStatus = item.itemStatus;//行状态
			var noQuoted = item.noQuoted;//不能报价
			var checked0 = "";
			var checked1 = "";
			var checked2 = "";
			if(itemStatus == "4"){
				checked0 = 'checked="checked"';
			}else if(itemStatus == "5"){
				checked1 = 'checked="checked"';
			}else if(itemStatus == "3"){
				checked2 = 'checked="checked"';
			}
			if(itemStatus == "6"){
				$("#sendBtn").hide();
			}
			var disabled = ' ';
			if(item.itemStatus == "6" || item.auditStatus == "2" || openType == "audit"  || item.auditStatus == "0"){//作废或审批中的不能编辑
				disabled = ' disabled="disabled" ';
			}
			text += '<label class="tdLbSty dis-in-b fs-12"><input style="margin:0 10px;" type="radio" class="opt-click" value="4" name="itemStatus_'+toElsAccount+'_'+item.itemNumber+'" '+checked0+disabled+' ><span style="display: none;">'+toElsAccount+'_'+item.itemNumber+'_'+itemStatus+'_'+noQuoted+'_'+quotaPlanFactor+'_'+item.toResponsible+'</span>接受</label>'+
			        '<label class="tdLbSty dis-in-b fs-12"><input style="margin:0 10px;" type="radio" class="opt-click" value="5" name="itemStatus_'+toElsAccount+'_'+item.itemNumber+'" '+checked1+disabled+' ><span style="display: none;">'+toElsAccount+'_'+item.itemNumber+'_'+itemStatus+'_'+noQuoted+'_'+quotaPlanFactor+'_'+item.toResponsible+'</span>拒绝</label>'+
			        '<label class="tdLbSty dis-in-b fs-12"><input style="margin:0 10px;" type="radio" class="opt-click" value="3" name="itemStatus_'+toElsAccount+'_'+item.itemNumber+'" '+checked2+disabled+' ><span style="display: none;">'+toElsAccount+'_'+item.itemNumber+'_'+itemStatus+'_'+noQuoted+'_'+quotaPlanFactor+'_'+item.toResponsible+'</span>重报</label>';
			return text;
		}
	}
}
   
function rendLowPrice(val , item , index){
	var fbk8 = item.fbk8?item.fbk8:"";//当前有效最低价
	var fbk9 = item.fbk9?item.fbk9:"";//最低价供应商
	var fbk11 = item.fbk11?item.fbk11:"";//最低价生效日期
	var text = "";
	text += "<div class='LH30'>" + "当前有效最低价："+fbk8+"</div>";
	text += "<div class='LH30'>" + "最低价供应商："+fbk9+"</div>";
	text += "<div class='LH30'>" + "最低价生效日期："+fbk11+"</div>";
	return text;
}


//操作单击事件
$(".opt-click").live("click",function(){
	 var spanText = $(this).next().text();
	 var toElsAccount = spanText.split("_")[0];
	 var itemNumber = spanText.split("_")[1];
	 var itemStatus = spanText.split("_")[2];
	 var noQuoted = spanText.split("_")[3];
	 if(itemStatus == "1"){//报价中
		 alert("供应商未报价，不能操作",2);
		 $("input[name='itemStatus_"+toElsAccount+"_"+itemNumber+"']").removeAttr("checked");
	 }else if(noQuoted == "Y" && $(this).val() == "4"){
		 alert("供应商不能报价，不能进行接受操作",2);
		 $("input[name='itemStatus_"+toElsAccount+"_"+itemNumber+"']").removeAttr("checked");
	 }else if($(this).val() == "4"){
		 $("#quotaPlanFactor_"+toElsAccount+"_"+itemNumber).removeAttr("readonly");
		 $("#quotaPlanFactor_"+toElsAccount+"_"+itemNumber).removeAttr("class");
	 }else if($(this).val() == "3" || $(this).val() == "5"){
		 $("#quotaPlanFactor_"+toElsAccount+"_"+itemNumber).attr("readonly","readonly");
		 $("#quotaPlanFactor_"+toElsAccount+"_"+itemNumber).attr("class","inDisabled");
		 $("#quotaPlanFactor_"+toElsAccount+"_"+itemNumber).val("");
	 }
});

//发送
$("#sendBtn").click(function(){
	var frmObj = $("#editEnquiryForm").serializeJSON();
	var rows = itemGrid.rows();
	var enquiryItemList = [];
	for(var i in rows){
		var row = rows[i];
		var itemNumber = row.itemNumber;
		var toElsAccountList = row.toElsAccountList;//105002_xxx;105001_yyyy
		var toElsAccountArray = toElsAccountList.split(";");
		for(var j in toElsAccountArray){
			var toElsAccount = toElsAccountArray[j].split("_")[0];
			var itemStatus = $("input[name='itemStatus_"+toElsAccount+"_"+itemNumber+"']:checked").val();
			var quotaPlanFactor = $("#quotaPlanFactor_"+toElsAccount+"_"+itemNumber).val();
			if(itemStatus){
				var spanText = $("input[name='itemStatus_"+toElsAccount+"_"+itemNumber+"']:checked").next().text();
				var oldItemStatus = spanText.split("_")[2];
				var oldQuota = spanText.split("_")[4];
				var toResponsible = spanText.split("_")[5];
				if(itemStatus != oldItemStatus || quotaPlanFactor != oldQuota){
					var item={"itemNumber":itemNumber,"toElsAccount":toElsAccount,"itemStatus":itemStatus,"quotaPlanFactor":quotaPlanFactor,"toResponsible":toResponsible};
					enquiryItemList.push(item);
				}
			}
		}
	}
	if(enquiryItemList.length == 0){
		alert("您未做任何操作，不能发送",2);
		return;
	}
	frmObj["enquiryItemList"]=enquiryItemList;
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:"确认发送？",closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : "<%=basePath%>rest/inquiry/EnquiryService/bargainOpt",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(frmObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data.statusCode == "-100"){
					alert(data.message,3);
					return;
				}
				alert("发送成功！",1);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert(data.responseText,3);
			}
		});
	}});
});

$("#passBtn").click(function(){
	var selectedRowsIndex = itemGrid.selectedRowsIndex();
	if(selectedRowsIndex.length < 1){
	    alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
	    return;
	}
	$(".fixed-dialog").show();
	$("#auditOpinion").attr("readOnly",false);
	$("#btnFileOK1").show();
	$("#btnFileOK2").hide();
});
$("#noPassBtn").click(function(){
	var selectedRowsIndex = itemGrid.selectedRowsIndex();
	if(selectedRowsIndex.length < 1){
	    alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
	    return;
	}
	$(".fixed-dialog").show();
	$("#auditOpinion").attr("readOnly",false);
	$("#btnFileOK1").hide();
	$("#btnFileOK2").show();
});
$("#btnFileOK1").click(function(){
	auditOpt("0",'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />');//通过
});
$("#btnFileOK2").click(function(){
	auditOpt("1",'<i18n:I18n key="i18n_common_confirm_auditrefuse" defaultValue="确认要审批拒绝吗？" />');//拒绝
});
$("#cancelBtn").click(function(){
	var selectedRowsIndex = itemGrid.selectedRowsIndex();
	if(selectedRowsIndex.length < 1){
	    alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
	    return;
	}
	cancel();
});
$("#btnFileCancel1").click(function(){
	$('.fixed-dialog').hide();
});
$('.dialog-close-btn').click(function(){
    $('.fixed-dialog').hide();
});
$('.tip-option-btn').click(function(){
    $('.dialog-close-btn').trigger('click');
});

function auditOpt(auditResult,msg) {
	var auditOpinion = $("#auditOpinion").val();
	if($.trim(auditOpinion) == ""){
		alert("请填写审批意见！",2);
		return;
	}
	var frmObj = $("#editEnquiryForm").serializeJSON();
	var rows = itemGrid.selectedRows();//选择的行项目
	frmObj["enquiryItemList"]=rows;
	frmObj["auditOpinion"]=auditOpinion;
	frmObj["auditResult"]=auditResult;
	frmObj["businessElsAccount"]=businessElsAccount;
	frmObj["stretegyCode"]=stretegyCode;
	frmObj["flowCode"]=flowCode;
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:msg,closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/inquiry/EnquiryService/auditOpt",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frmObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				$('.fixed-dialog').hide();
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
				refreshNum();
				setTimeout(function(){
					parent.elsDeskTop.closeCurWin("comparePrice");
					parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
				},100);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "403") {
					alert('<i18n:I18n key="i18n_audit_noauthority" defaultValue="没有审批权限" />',3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}

function closeCallback() {
	if (parent.frames["iframeApp_auditList"]) {
		parent.frames["iframeApp_auditList"].query();
	}
}

function cancel() {
	var frmObj = $("#editEnquiryForm").serializeJSON();
	var rows = itemGrid.selectedRows();//选择的行项目
	frmObj["enquiryItemList"]=rows;
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditcancel" defaultValue="确认要撤销审批吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/inquiry/EnquiryService/cancelAudit",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frmObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
				refreshNum();
				setTimeout(function(){
					parent.elsDeskTop.closeCurWin("comparePrice");
					parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
				},100);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "401") {
					alert('<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />',3);
				} else if (data.status == "403") {
					alert('<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />',3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}
function initFlowBtn(){
	var selectedRowsIndex = itemGrid.selectedRowsIndex();
	if(selectedRowsIndex.length != 1){
		$("#flowBtn").hide();
	    return;
	}
	if(openType == "audit"){
		$("#flowBtn").show();
	}
}
//查看流程
$("#flowBtn").click(function(){
	var selectedRowsIndex = itemGrid.selectedRowsIndex();
	if(selectedRowsIndex.length < 1){
	    alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
	    return;
	}
	var targetElsAccount = elsAccount;
	var businessType="bargainEnquiry";
	var rows = itemGrid.selectedRows();//选择的行项目
	var businessId = enquiryNumber+'-'+rows[0].itemNumber;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
        'windowSubTitle': "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
        'windowMinWidth': 480,
        'windowMinHeight': 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
</script>
</body>
</html>