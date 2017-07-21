<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
    <div class="pos-relative public-wrap ">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            	<button id="getERP" class="button-wrap"><i18n:I18n key="test" defaultValue="增量同步" /></button>
                <button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                <button id="sendBtn" class="button-wrap"><i18n:I18n key="i18n_purchaseorder_button_sendbatch" defaultValue="批量发送" /></button>
                <button id="backBtn" class="button-wrap"><i18n:I18n key="" defaultValue="批量撤回" /></button>
                <button id="entryBtn" class="button-wrap"><i18n:I18n key="" defaultValue="批量提交审批" /></button>
                <button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="" defaultValue="批量撤销审批" /></button>
                <button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
                <button id="modifyBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="详细(手工审批)" /></button>
                <button id="batchsetting" class="button-wrap"><i18n:I18n key="i18n_purchaseorder_button_assignbatch" defaultValue="批量分配负责人" /></button>
<%--                 <button id="modifyBtn" class="button-wrap"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button> --%>
<!--                 <button id="uploadPurchaseOrder" class="button-wrap">上传采购订单</button> -->
                <button id="downloadBtn" class="button-wrap"><i18n:I18n key="" defaultValue="导出EXCEL" /></button>
                <button id="columnDefineBtn" class="button-wrap">头<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="itemColumnDefineBtn" class="button-wrap">行<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
<!--                 <input type="checkbox" id="showDelete"/>显示删除行 -->
                <input name="isMyself" id="isMyself" type="checkbox" value="" /><i18n:I18n key="i18n_label_showallorder" defaultValue="显示所有订单" />
<%--            <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
<!-- 				<div class="dis-in-b input-and-tip" style="margin-left: 20px; cursor: pointer;" id="refurbishTmp">K3系统订单<span id="refurbishId" style="color: red;"></span>条</div> -->
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;">
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
<!--             	<input type="hidden" id="type" name="type" value="0"/> -->
            	<input name="itemIds" type="hidden"/>
            	<input type="hidden" id="toElsAccount" name="toElsAccount" value="<%=request.getParameter("toElsAccount")%>"/>
            <div class="common-box-line">
            	<div id="div-fbk4" class="dis-in-b" style="position:relative;top:-6px;">
                    <span class="dis-in-b text-right w-72  fs-12"><i18n:I18n key="i18n_label_xxx" defaultValue="采购负责人" />： </span>
            		<div class="dis-in-b  input-select" id="fbk4Selector"></div>
                    <input type="hidden" id="fbk4Param" name="fbk4Param"/>
<!--                     <span id="fbk4Selector"></span> -->
                </div>
                <div id="div-orderStatus" class="dis-in-b input-and-tip">
                    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_purchaseOrderStatus" defaultValue="采购订单状态" />： </span>
                    <input type="hidden" id="orderStatusParam" name="orderStatusParam"/>
                    <select id="orderStatusSelector" multiple="multiple">
                		<option value="0"><i18n:I18n key="i18n_label_notConfirmed" defaultValue="对方未确认" /></option>
                		<option value="1"><i18n:I18n key="i18n_label_confirmed" defaultValue="对方已确认" /></option>
                		<option value="2"><i18n:I18n key="i18n_label_return" defaultValue="对方退回" /></option>
                		<option value="7"><i18n:I18n key="i18n_label_updateProductionStatus" defaultValue="到更新生产状态" /></option>
                	</select>
                </div>
                <div id="div-orderSendStatus" class="dis-in-b input-and-tip">
                    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_orderSendStatus" defaultValue="订单发送状态" />： </span>
                    <input type="hidden" id="orderSendStatusParam" name="orderSendStatusParam"/>
                    <select id="orderSendStatusSelector" multiple="multiple">
                		<option value="0"><i18n:I18n key="i18n_label_notSent" defaultValue="未发送" /></option>
                		<option value="1"><i18n:I18n key="i18n_label_Sent" defaultValue="已发送" /></option>
                	</select>
                </div>
                <div id="div-deliveryStatus" class="dis-in-b input-and-tip">
                    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_orderDeliveryStatus" defaultValue="订单交收状态" />： </span>
                    <input type="hidden" id="deliveryStatusParam" name="deliveryStatusParam"/>
                	<select id="deliveryStatusSelector" multiple="multiple">
                		<option value="0"><i18n:I18n key="i18n_label_noDelivery" defaultValue="未交收" /></option>
                		<option value="1"><i18n:I18n key="i18n_label_deivery" defaultValue="订单发货在途" /></option>
                		<option value="2"><i18n:I18n key="i18n_label_partDeivery" defaultValue="部分交收" /></option>
                		<option value="3"><i18n:I18n key="i18n_label_allDeivery" defaultValue="全部交收" /></option>
                		<option value="4"><i18n:I18n key="i18n_label_superDeivery" defaultValue="超量交收" /></option>
                	</select>
                </div>
                <div id="div-auditStatus" class="dis-in-b input-and-tip">
                    <span class="dis-in-b text-right w-72"><i18n:I18n key="test" defaultValue="订单审批状态" />： </span>
                    <input type="hidden" id="auditStatus" name="auditStatus"/>
                	<select id="auditStatusSelector">
                		<option value=""><i18n:I18n key="test" defaultValue="全部" /></option>
                		<option value="1"><i18n:I18n key="test" defaultValue="未审批" /></option>
                		<option value="2"><i18n:I18n key="test" defaultValue="审批中" /></option>
                		<option value="0"><i18n:I18n key="test" defaultValue="审批通过" /></option>
                		<option value="3"><i18n:I18n key="test" defaultValue="审批拒绝" /></option>
                	</select>
                </div>
                <br/> 
                <div class="dis-in-b"><span class="dis-in-b text-right"><i18n:I18n key="test" defaultValue="对方els账号" />：</span><input type="text" name="toElsAccount" style="width:80px;max-width:80px;"/></div>
                <div class="dis-in-b"><span class="dis-in-b text-right"><i18n:I18n key="test" defaultValue="对方公司简称" />：</span><input type="text" name="toElsAccountShortName" style="width:80px;max-width:80px;"/></div>
                <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input id="purchaseOrderNumber" name="purchaseOrderNumber" type="text" style="width:110px;max-width:110px;"/></div>
                <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchasegroup" defaultValue="采购组" />： </span><input type="text" id="purchaseGroup" name="purchaseGroup" style="width:80px;max-width:80px;"/></div>
<%--                 <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_label_factory" defaultValue="工厂" />： </span><input type="text" name="factory"/></div> --%>
               <!--<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_label_trackNumber" defaultValue="跟踪号" />： </span><input type="text" name="trackNumber"/></div> -->
                <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_orderdate" defaultValue="订单日期" />：</span></div>
                <input type="radio" name="dateArea" value="week"><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" />
                <input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
                <input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
                <input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate"/></div>
                <div class="dis-in-b" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate" /></div>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_purchaseOrder_head" defaultValue="采购订单头" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_purchaseOrder_item" defaultValue="采购行项目" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_title_purchaseOrder_item" defaultValue="采购行项目" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n key="i18n_label_deliverySchedule" defaultValue="交货计划" /></a></li>
                    </ul>
                    <div id="sheet-project-one" style="padding: 0px;">
                        <main class="grid-container">
		                    <div class="grid-100">
		                        <table id="table-item"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two" style="padding: 0px;">
                        <main class="grid-container">
		                    <div class="grid-100">
		                        <table id="table-file"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-three" style="padding: 0px;">
						<div class="dis-in-b input-and-tip">
							<select id="itemSelector" onchange="filterDeliveryPlan()">
							<option value="">显示全部</option>
							</select>
						</div>
						<main class="grid-container">
							<div class="grid-100" id="deliveryGrid">
								<table id="table-delivery"></table>
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
    </div>
    <!-- 批量设置弹窗 -->
     <div  id="dialog1" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" /> <span
					id="dialogTitle"><i18n:I18n key="i18n_label_batchsetting" defaultValue="批量设置" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<div class="common-box-line">
						<div id="divOrderItem" class="input-and-tip">
							<span><i18n:I18n key="i18n_common_title_responserofpurchase" defaultValue="采购方负责人" />：</span> 
							<span id="selectedfbk4"></span>
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFileOK1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div id="dialog2" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_selectStrategy" defaultValue="请选择审批策略" /></span>
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
<script type="text/javascript">
var headGrid;
var itemGrid;
var fileGrid;
var deliveryGrid;
var peopleList;
var $sob;
var chatFromUrlFlag = false;
var currentPurchaseOrderNumber;
var toElsAccount = "";
var uploadOrder;
var flowCode = "";
var selector = '<base:subAccount role='purchase' elsAccount='${elsAccount }' type='array' name='fbk4' id='fbk4' ></base:subAccount>';
var selector2 = '<base:subAccount role='purchase' elsAccount='${elsAccount }' type='select' name='fbk4' id='fbk4' ></base:subAccount>';

selector2 = selector2.replace('全部');
$().ready(function(){
	var select = selector.split(",");
	$(".input-select").inputSelect(select);
	// 获取用户采购组
// 	var params = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"orgCategoryId":"purchaseGroup"};
// 	 $.ajax({
<%--      		url : "<%=basePath%>rest/ElsOrganizationService/querySubaccountOrganizationInfo", --%>
//      		type : "post",
//      		data:JSON.stringify(params),
//      		contentType : "application/json",
//      		async:false,
//      		dataType : "json",
//      		success : function(data) {
//      			if (data && data.rows && data.rows.length > 0) {
//      				$("#purchaseGroup").val(data.rows[0].orgId);
//      			}
//      		}
// 	 });
   
//     $("#fbk4Selector").html(selector);
// 	   $("#fbk4").find("option").each(function(){
// 	     	$(this).attr("value",$(this).text().split("_")[0]);
// 	     }); 
// 	     $("#fbk4").val(elsSubAccount + "_" + username);
	     var fbk4 = $(".store-value").val();
	     if(fbk4=="全部"){
	    	 fbk4="";
	     }else{
		     fbk4 =$(".store-value").val();
	     }
	     $("#fbk4").val(fbk4);
// 	     $("#fbk4").attr("placeholder",'<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />');
// 	     $("#fbk4").SumoSelect({optAfter:'#div-fbk4',optCancel:'#div-fbk4 .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	     $("#orderStatusSelector").SumoSelect({optAfter:'#div-orderStatus',optCancel:'#div-orderStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	     $("#orderSendStatusSelector").SumoSelect({optAfter:'#div-orderSendStatus',optCancel:'#div-orderSendStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	     $("#deliveryStatusSelector").SumoSelect({optAfter:'#div-deliveryStatus',optCancel:'#div-deliveryStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	 	 $(".SlectBox").each(function(){
	 		$(this).css({ "padding-top": "0",
	 		              "padding-bottom": "0",
	 		              "line-height": "20px",
	 		              "height": "21px",
	 		              "font-size": "12px",
	 		              "max-width": "150px",
	 		              "border-radius": "2px"
	 		              });
	 	});
	 init();
	 initUploader();
});


//初始化聊天窗口
//ELS账号+订单号 作为 businessID
function initChat(businessID,fbk5, hadSelected) {
		if (toElsAccount == "") {
			$('.testIframe').attr('src','');
			return;
		}
		//采购凭证号
		var purchaseOrderNumberList = [];
		//订单号
		var bIdList = [];
		//聊天显示列表
		var chatList = [];
		if(hadSelected && hadSelected.length) {
			hadSelected.forEach(function(d,i){
				var obj ={};
				obj[d.purchaseOrderNumber] = d.fbk5 || '' ;
				bIdList.push(obj); 
				chatList.push(d.purchaseOrderNumber);
			});
			chatList=chatList.map(function(d){
				return {name:d}
			}); 
		};
		//初始化iframe
		 var toElsSubAccount;
		 //fbk5 为对方负责人
		/* if(!fbk5 || fbk5===null|| !businessID || businessID===null){
			toElsSubAccount="";
		}else{
			toElsSubAccount=fbk5.split("_")[0];
			
		} */
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
				+ "&businessType=order"
				+ "&businessID="+bIdString
              + "&list="+ (chatListString&&chatListString.length?chatListString : peopleListString)
				+"&t="+new Date().getTime();
	   
	   $('.testIframe').attr('src','<%=basePath%>'+ url);
	   //滚动条美化niceScroll
	   $('.public-wrap').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
}
//列
var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseOrderBatchManage_mt"/>;
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseOrderItem_mt"/>;
//增加删除标识
cols_item.push({
	"title":"删除标识",
	"name":"deleteFlag",
	"align":"center",
	renderer:function(val){
		var txt = "";
		if(!val) val="";
		if (val=="C") {
			txt = "删除待确认";
		} else if (val=="X") {
			txt = "已删除";
		}
		return txt;
	}
});
var cols_file = [
                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
                   	if (val != "" && val!=null&& val!=elsAccount) {
                  		return "<i18n:I18n key="i18n_common_sale" defaultValue="销售方" />";
                  	} else {
                  		return "<i18n:I18n key="i18n_common_purchase" defaultValue="采购方" />";
                  	} 
                 }},
                 { title:'<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" />', name:'filePath', width: 80, align: 'center',renderer:function(val){
                	 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/downloadServlet?filePath="+ val +"'><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></a>";
                 }},
                 { title:'<i18n:I18n key="i18n_common_purchaseels" defaultValue="采购方ELS号" />', name:'elsAccount', width: 150, align: 'center'},
                 { title:'<i18n:I18n key="i18n_common_saleels" defaultValue="销售方ELS号" />', name:'toElsAccount' ,width:150, align:'center'},
                 { title:'<i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />', name:'purchaseOrderNumber' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_label_filetype" defaultValue="文件类型" />', name:'orderItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return "<i18n:I18n key="i18n_label_headfile" defaultValue="订单头文件" />";
	                	} else{
	                		return "<i18n:I18n key="i18n_label_itemfile" defaultValue="订单项文件" />";
	                	}
	                }},
                 { title:'<i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="行项目编号" />', name:'orderItemNumber' ,width:150, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_label_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态" />', name:'fileStatus' ,width:150, align:'center',renderer:function(val){
                 	if (val == "0") {
                		return "<i18n:I18n key="i18n_label_notSent" defaultValue="未发送" />";
                	} else {
                		return "<i18n:I18n key="i18n_label_sent" defaultValue="已发送" />";
                	} 
                }}];
                
var cols_delivery = [
                     {title:'<i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />', name:'purchaseOrderNumber' ,width:200, align:'center'},
      				{title:'行项目号',name:'orderItemNumber', width: 120, align: 'center'},
      				{title:'计划行号',name:'orderDeliveryItem', width: 120, align: 'center'},
      				{title:'网格值', hidden:true,name:'gridValue', width: 120, align: 'center'},
                     {title:'<i18n:I18n key="i18n_purchaseorder_deliverytime" defaultValue="计划交货时间" />', name:'deliveryTime', width: 120, align: 'center',renderer:function(val){
                       	if (!val) {val = "";}
                       	val = dateFormat(val);
                       	return val;
                     }},
                     { title:'<i18n:I18n key="i18n_purchaseorder_deliveryquantity" defaultValue="计划交货数量" />', name:'deliveryQuantity' ,width:200, align:'center',renderer:function(val){
                       	if (!val) {val = "0.00";}
                       	return val;
                     }},
                     {title:'<i18n:I18n key="i18n_purchaseorder_purchasedeliverytimePlan" defaultValue="计划交货时间(供应商)" />', name:'purchaseDeliveryTimePlan', width: 120, align: 'center',renderer:function(val){
                        	if (!val) {val = "";}
                        	val = dateFormat(val);
                         return val;
                     }},
                     { title:'<i18n:I18n key="i18n_purchaseorder_purchasedeliveryquantityPlan" defaultValue="计划交货数量(供应商)" />', name:'purchaseDeliveryQuantityPlan' ,width:200, align:'center',renderer:function(val){
                      	if (!val) {val = "0.00";}
                      	return val;
                     }}];
                
function getDate(dates){
	var dd = new Date();
	dd.setDate(dd.getDate()+dates);
	return dd.format("yyyy-MM-dd");
}
function renderProductionStatus(val,item) {
	if (!val) {
		return "";
	}
	return "<a href=\"javascript:showProductionStatus('"+item.elsAccount+"','"+item.purchaseOrderNumber+"','"+item.orderItemNumber+"');\">"+val+"</a>";
}
function showProductionStatus(els,orderNumber,orderItemNumber) {
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editOrderSchedule',
        'windowTitle':'<i18n:I18n key="i18n_button_viewprogress" defaultValue="查看进度" />',
        windowSubTitle: orderNumber,
        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderSchedule.jsp?businessElsAccount=' + els + "&purchaseOrderNumber="+orderNumber+"&orderItemNumber="+orderItemNumber,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
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
function init() {
// 	isDisplayIntefaceButton();
	//初始化控件
    $sob = $('.saying-dialog .option-bar');
    $( "#sheet-project").tabs();
   // $( document ).tooltip();
//     $( "#startOrderDate" ).datepicker();
//     $( "#endOrderDate" ).datepicker();
	changeDateArea();
    $("[name=dateArea]").click(changeDateArea);
    //订单头列表
    var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var paramJson=frm.serializeJSON();
	paramJson.purchaseOrderNumbers=$("#purchaseOrderNumber").val();
    headGrid = $('#table-head').mmGrid({
        cols: cols,
        height:<base:tableHeight tableCode="purchaseOrderBatchManage_mt"/>,
        url : '<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderByCondtion',
        params: frm.serializeJSON(),
        method:  'post',
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        multiSelect:true,
        checkCol:true,
        remoteSort:true,
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
                , limitList: [100, 50, 30 , 10]
            })
        ]
    });
    // 加载明细项
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	if(item && item.purchaseOrderNumber) {
    		// 获取审批流flowCode
    		if (item.flowCode) {
					flowCode = item.flowCode;
				}
    		// add @author zhongbaohui 20160919
    		toElsAccount = item.toElsAccount;
    		currentPurchaseOrderNumber = item.purchaseOrderNumber;
    		var itemIds="";
    		var hadSelected = headGrid.selectedRows();
    		var multiToEls = false;
        	hadSelected.forEach(function(val){
        		if (val.toElsAccount != toElsAccount) {
        			multiToEls = true;
        		}
        		itemIds=itemIds+","+val.purchaseOrderNumber;
        	});
        	if(itemIds!=""){
        		itemIds=itemIds.substring(1);
        	} else {
        		toElsAccount = "";
        	}
        	if (multiToEls) {
        		toElsAccount = "";
        	}
        	loadItem(itemIds);
        	
        	loadDetails(itemIds);
        	// 加载采购表单文件
        	loadFormFile(itemIds);
        	// 动态加载聊天窗口
    		if(hadSelected && hadSelected.length) {
    			if(chatFromUrlFlag) {
    				initChat(elsAccount+"_"+item.purchaseOrderNumber,item.fbk5,hadSelected);
    			}
        	} else {
        		initChat();
        	}
    	}
    });
    headGrid.on('loadSuccess',function(e, data) {
//     	getERPCount();
    	//已作废的订单高亮显示
        $('#table-head').find("tr").each(function(){
        	var item = $(this).data("item");
	        if (item && item.isDel == "Y") {
	        	$(this).css("background-color","rgba(213, 58, 58, 0.1)");
	        }});
    	if (!itemGrid) {
    	    itemGrid = $('#table-item').mmGrid({
    	        cols: cols_item,
    	        height:<base:tableHeight tableCode="purchaseOrderItem_mt"/>,
    	        items: []
    	    });
    	    itemGrid.on("loadSuccess",function(e,d){
    	    	if(d){
    	    		initModifyFiled(itemGrid.rows());
    	    	}
    	    });
    	}
    	if (!fileGrid) {
    	    fileGrid = $('#table-file').mmGrid({
    	        cols: cols_file,
    	        items: []
    	    });
    	}
    	if (!deliveryGrid) {
    		deliveryGrid = $('#table-delivery').mmGrid({
    	        cols: cols_delivery,
    	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
    	        items: []
    	    });
    		deliveryGrid.on("loadSuccess",function(e,d){
    			getDeliveryItem();
    			
    	    });
    	}
    	if (data.rows && data.rows.length > 0) {
    		//初始化聊天参数
    		var flag = window.queryChats('flag');
    		var chatString = window.queryChats('q');
    		var chatArr =[];
    		if(chatString && chatString.length) {
				chatArr = chatString.substring(0,chatString.length-1).split(',');
			}
    		var hadSelected = [];
    		if(flag !='businessObj' || !flag) {
 					chatArr=chatArr.map(function(d){
 	   					return {name:d}
 	   				}); 
   				var listName = [];
   				data.rows.forEach(function(d){
    				if(d.fbk5&&listName.indexOf(d.fbk5)===-1){
    					listName.push(d.fbk5);
    				}
    			});
   				listName=listName.map(function(d){
   					return {name:d}
   				}); 
   				peopleList = chatArr && chatArr.length?chatArr:listName;
   				initChat();
    		} else if(flag == 'businessObj') {
    			//订单
    			var rows = data.rows;
    			for(var i=0;i < rows.length;i++) {
	   				for(var j=0;j<chatArr.length;j++) {
	       					if(rows[i].purchaseOrderNumber==chatArr[j]) {
	       						headGrid.select(i);
	       					}
	       				}
    			}
    			//存储选中的的行数据，用作打印判断
    			if(headGrid.selectedRows() && headGrid.selectedRows().length) {
    				$('body').data('selectHead',headGrid.selectedRows());
    				hadSelected = headGrid.selectedRows()
    			} else {
    				hadSelected = chatArr.map(function(d){
    					return {purchaseOrderNumber:d,fbk5:''};
    				});
    			}
    			peopleList = [];
    			data.rows.forEach(function(d){
    				if(d.fbk5&&peopleList.indexOf(d.fbk5)===-1){
    					peopleList.push(d.fbk5);
    				}
    			});
    			peopleList=peopleList.map(function(d){
   					return {name:d}
   				}); 
    			initChat('','',hadSelected);
    		}
    		//打开聊天行选择开关
    		chatFromUrlFlag = true;
			currentPurchaseOrderNumber = data.rows[0].purchaseOrderNumber;
// 			loadItem(currentPurchaseOrderNumber);
// 			loadFormFile(currentPurchaseOrderNumber);
			// 动态加载聊天窗口
        	//initChat(elsAccount+"_"+data.rows[0].purchaseOrderNumber,data.rows[0].fbk5);
            //初始化聊天控制状态
            if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
            $sob.click();
		}
    });
    
    //功能操作
    $("#queryBtn").click(function(){
    	query();
    });
    $("#showDelete").click(function(){
    	var itemList = itemGrid.rows();
    	if($(this).attr("checked")=="checked") {
    		for (var i in itemList) {
    			var deleteFlag = itemList[i].deleteFlag;
    			if (deleteFlag && deleteFlag == "X") {
    				$("#table-item").find("tr").eq(i).show();
    			}
    		}
    	} else {
    		for (var i in itemList) {
    			var deleteFlag = itemList[i].deleteFlag;
    			if (deleteFlag && deleteFlag == "X") {
    				$("#table-item").find("tr").eq(i).hide();
    			}
    		}
    	}
    });
    $("#addBtn").click(function(){
    	insertPurchaseOrder();
    });
    $("#modifyBtn").click(function(){
    	modifyPurchaseOrder();
    });
    $("#exitBtn").click(function(){
    	if (winId) {
			parent.elsDeskTop.closeCurWin(winId);
		} else {
	    	parent.elsDeskTop.closeCurWin('purchaseOrderBatchManage');
		}
    });
    
    $("#getERP").click(function(){
    	if(!(elsAccount == "160000")){
    		alert("仅160000账户可执行同步操作",2);
    		return;
    	}
    	$("#purchaseOrderNumberParam").val("");
    	var purchaseOrderNumberParam=$("#purchaseOrderNumberParam").val();
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认增量ERP导入？" />',closeEvent:function(){	
    		getERP(purchaseOrderNumberParam);
    	}});
    });
    $("#sendBtn").click(function(){
    	sendPurchaseOrder();
    });
    $("#entryBtn").click(function(){
    	entryPurchaseOrder();
    });
    $("#cancelEntryBtn").click(function(){
    	cancelEntryPurchaseOrder();
    });
    $("#backBtn").click(function(){
    	backPurchaseOrder();
    });
    $("#assignBtn").click(function(){
    	assignPurchaseOrder();
    });
    $("#modifyBtn").click(function(){
    	modifyPurchaseOrder();
    });
    $("#deleteBtn").click(function(){
    	deletePurchaseOrder();
    });
    $("#columnDefineBtn").click(function(){
    	parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'subAccountColumnSetting',
            'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
            windowSubTitle: "",
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseOrderBatchManage_mt" + "&window=iframeApp_purchaseOrderBatchManage",
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
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseOrderItem_mt" + "&window=iframeApp_purchaseOrderBatchManage",
            windowMinWidth: 480,
            windowMinHeight: 600,
            'windowWidth':480,
            'windowHeight':600,
            'parentPanel':".currDesktop"
        });
    });
    
    $("#isMyself").change(function(){
    	if($("#isMyself").is(":checked")){
    		$("#type").val("");
    	}else{
    		$("#type").val("1");
    	}
    });
    //$('#uploadPurchaseOrder').click(initUploader)
}

    function getDeliveryItem() {
    	$("#itemSelector").empty();
    	var html = "";
    	var trs = $("#table-item").find("tr");
    	var strArray = new Array();
    	strArray.push("<option value=''>显示全部</option>");
    	for (var i=0;i<trs.length;i++){
    		var data = trs.eq(i).data("item");
    		if (data && data.purchaseOrderNumber && data.orderItemNumber != "") {
    			strArray.push("<option value='");
    			strArray.push(data.purchaseOrderNumber);
    			strArray.push("_");
    			strArray.push(data.orderItemNumber);
    			strArray.push("'>");
    			strArray.push(data.purchaseOrderNumber);
    			strArray.push("_");
    			strArray.push(data.orderItemNumber);
    			strArray.push("_");
    			strArray.push(data.materialDesc);
    			strArray.push("</option>");
    		}
    	}
    	$("#itemSelector").append(String.prototype.concat.apply("", strArray));
    /* 	filterDeliveryPlan(); */
    } 
    function filterDeliveryPlan() {
    	if(deliveryGrid.rowsLength() > 0){
    		var orderItemNumber = $("#itemSelector").val();
    		if(orderItemNumber == ""){
    			$("#table-delivery").find("tr").each(function(){
    				$(this).css("display","");
    			});
    		}else{
    			$("#table-delivery").find("tr").each(function(){
    				var data = $(this).data("item");
    				var matchNumber = data.purchaseOrderNumber + "_" + data.orderItemNumber;
    				if (matchNumber == orderItemNumber) {
    					$(this).css("display","");
    				} else {
    					$(this).css("display","none");
    				}
    			});
    		}
    		deliveryGrid.deselect("all");
    	}
    }
    
function initUploader(){
	if(!uploadOrder){
		uploadOrder = WebUploader.create({
		    // swf文件路径
		    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		    auto: true,
		    duplicate :true,
		    accept:{
		    	extensions:"xls,xlsx"
		    },
		    // 文件接收服务端。
		    server: '<%=basePath%>rest/PurchaseOrderService/uploadPurchaseOrder',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#uploadPurchaseOrder',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false
		});
		uploadOrder.on( 'uploadStart', function( file, response ) {
			parent.elsDeskTop.showLoading();
		});
		
		uploadOrder.on( 'uploadAccept', function( file, response ) {
			parent.elsDeskTop.hideLoading();
			if(response!=null&&response.statusCode=="-100"){
				alert(response.message,2);
			}else if(response!=null&&response.statusCode=="-200"){
				alert(response.message,3);
			}else {
				alert("请求成功！");
			}
// 			uploadPurchaseOrder(response._raw);
		});
		
		uploadOrder.on( 'uploadError', function( file, response ) {
			alert("请求出错！",3);
			parent.elsDeskTop.hideLoading();
		});
	}
}

function uploadPurchaseOrder(fileName){
	var paramStr='{"elsAccount":"'+elsAccount+'","fileName":"'+fileName+'"}';
	$.ajax({
		url : "<%=basePath%>rest/PurchaseOrderService/createPurchaseOrder",
		type : "post",
		contentType : "application/json",
		dataType : "json",
		data:paramStr,
		success : function(data) {
			if(data!=null&&data.statusCode=="-100"){
				alert(data.message,2);
			}else{
// 				fillDeliveryPlan(data);
				alert("<i18n:I18n key="i18n_alert_uploadSuccess" defaultValue="上传成功" />");
				query();
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

/*
 * 从K3获取订单信息
 */
function getERP(purchaseOrderNumberParam){
	var btnERPImport = $("#getERP");
		btnERPImport.empty().append('<span style="color: red;">同步中...</span>');
	var json={"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseOrderNumber":purchaseOrderNumberParam,"paramStr":"{\"PURCHASEORDER\" : \""+purchaseOrderNumberParam+"\"}"};
	var paramStr = JSON.stringify(json);
	$.ajax({
		url : "<%=basePath%>rest/PurchaseOrderService/getERP" ,
		contentType : "application/json",
 		type : "post",
 		dataType : "json",
 		data:paramStr,
 		success : function(data) {
 			if(data!=null&&(data.statusCode=="-100"||data.statusCode=="-200")){
 				alert(data.message,3);
 			}else{
 				btnERPImport.empty().append('<span style="color: red;">增量成功</span>');
 	 			query();
 			}
 		},
 		error : function(data) {
 			alert(data.message,3);
 		}
 	});
}
function assignPurchaseOrder(){
	var rows = headGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	
}
function sendPurchaseOrder(){
	var rows = headGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var purchaseOrderNumbers = "";
	for (var i = 0;i<rows.length;i++){
		purchaseOrderNumbers += rows[i].purchaseOrderNumber + ","; 
		if(!rows[i].fbk4 || rows[i].fbk4 == ""){
			alert(rows[i].purchaseOrderNumber+"<i18n:I18n key="i18n_alert_nopersoncannotsend" defaultValue="没有分配采购方负责人不能发送给供应商" />",2);
			return;
		}
		if(rows[i].orderSendStatus == 1){
			var errMsg = "已发送的订单"+rows[i].purchaseOrderNumber+"不能再次发送";
			alert(errMsg,2);
			return;
		} 
		if(rows[i].isDel == "Y"){
			alert("已作废的订单不能发送",2);
			return;
		}
		if(rows[i].auditStatus == "2"){
			var errMsg = "审批中的订单"+rows[i].purchaseOrderNumber+"暂时不能发送";
			alert(errMsg,2);
			return;
		}
		if(rows[i].auditStatus == "1" || rows[i].auditStatus == "3"){
			var errMsg = "未审批通过的订单"+rows[i].purchaseOrderNumber+"暂时不能发送";
			alert(errMsg,2);
			return;
		}
	}
	purchaseOrderNumbers = purchaseOrderNumbers.substring(0,purchaseOrderNumbers.length-1);
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"companyShortName":companyShortName,"purchaseOrderNumber":purchaseOrderNumbers};
	//获取当前选中的
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseOrderService/batchSendPurchaseOrderByNumber",
    		contentType : "application/json",
    		type : "post",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			alert("<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />");
    			query();
    		},
    		error : function(data) {
    			parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
    		}
    	});
	}});
}
function showStretegySelector(stretegyList) {
	$(".dialog-tip").height(40);
	var html = "";
	for (var i=0;i<stretegyList.length;i++){
		html += "<option value='"+stretegyList[i].stretegyCode+"'>"+stretegyList[i].stretegyName+"</option>";
	}
	$("#stretegySelctor").empty().html(html);
	$('#dialog2').show();
	$("#btnFileOK2").unbind("click").click(function(){
		var stretegyCode=$("#stretegySelctor").val();
		$("#entryBtn").click();
		$('#dialog2').hide();
	});
}
function closeCallback() {
	if (parent.frames["iframeApp_OrderManage_"+toElsAccount]) {
		parent.frames["iframeApp_OrderManage_"+toElsAccount].query();
	}
	if (parent.frames["iframeApp_purchaseOrderBatchManage"]) {
		parent.frames["iframeApp_purchaseOrderBatchManage"].query();
	}
}
function entryPurchaseOrder(){
	var rows = headGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var purchaseOrderNumbers = "";
	for (var i = 0;i<rows.length;i++){
		purchaseOrderNumbers += rows[i].purchaseOrderNumber + ","; 
		if(!rows[i].fbk4 || rows[i].fbk4 == ""){
			alert(rows[i].purchaseOrderNumber+"<i18n:I18n key="i18n_alert_nopersoncannotsend" defaultValue="没有分配采购方负责人不能提交审批" />",2);
			return;
		}
		if(rows[i].orderSendStatus == 1){
			var errMsg = "已经发送的订单"+rows[i].purchaseOrderNumber+"不能提交";
			alert(errMsg,2);
			return;
		} 
		if(rows[i].isDel == "Y"){
			alert("已作废的订单不能提交",2);
			return;
		}
		if(rows[i].auditStatus == "2"){
			var errMsg = "审批中的订单"+rows[i].purchaseOrderNumber+"不能再次提交";
			alert(errMsg,2);
			return;
		}
		if(rows[i].auditStatus == "0"){
			var errMsg = "审批通过的订单"+rows[i].purchaseOrderNumber+"不能再次提交";
			alert(errMsg,2);
			return;
		}
	}
	var stretegyCode=$("#stretegySelctor").val();
	purchaseOrderNumbers = purchaseOrderNumbers.substring(0,purchaseOrderNumbers.length-1);
	var data = {"stretegyCode":stretegyCode,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"companyShortName":companyShortName,"purchaseOrderNumber":purchaseOrderNumbers};
	//获取当前选中的
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseOrderService/batchEntryPurchaseOrderByNumber",
    		contentType : "application/json",
    		type : "post",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			if(data !=null){
                if(data.statusCode == "E"){
					alert(data.message,3);
					return;
				}else if(data.statusCode == "Other"){
					console.log(data.errMessage);
					alert('请求不允许执行',3);
					return;
				}else if (data.statusCode == "-100") {
					console.log(data.message);
					alert(data.message,3);
					return;
				}
             	// 匹配的审批策略有多条，让用户选择
    			if (data.rows) {
					showStretegySelector(data.rows);
					return;
				}}else{
				alert("<i18n:I18n key="i18n_common_report_success" defaultValue="上报成功" />");
				query();
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					if (data.status == "401") {
						alert("<i18n:I18n key="i18n_common_orders_cannot_be_repeated_to_report" defaultValue="订单不能重复上报" />",3);
					} else {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					};
				}
			}
		});
	}});
}
	function cancelEntryPurchaseOrder(){
	var rows = headGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var purchaseOrderNumbers = "";
	for (var i = 0;i<rows.length;i++){
		purchaseOrderNumbers += rows[i].purchaseOrderNumber + ","; 
		if(!rows[i].fbk4 || rows[i].fbk4 == ""){
			alert(rows[i].purchaseOrderNumber+"<i18n:I18n key="i18n_alert_nopersoncannotsend" defaultValue="没有分配采购方负责人不能发送给供应商" />",2);
			return;
		}
		if(rows[i].orderSendStatus == 1){
			var errMsg = "已发送的订单"+rows[i].purchaseOrderNumber+"不能撤销审批";
			alert(errMsg,2);
			return;
		} 
		if(rows[i].isDel == "Y"){
			alert("已作废的订单不能撤销审批",2);
			return;
		}
		if(rows[i].auditStatus == "0"){
			var errMsg = "审批通过的订单"+rows[i].purchaseOrderNumber+"不能撤销审批";
			alert(errMsg,2);
			return;
		}
		if(rows[i].auditStatus == "1"){
			var errMsg = "未提交审批的订单"+rows[i].purchaseOrderNumber+"不能撤销审批";
			alert(errMsg,2);
			return;
		}
		if(rows[i].auditStatus == "3"){
			var errMsg = "未提交审批的订单"+rows[i].purchaseOrderNumber+"不能撤销审批";
			alert(errMsg,2);
			return;
		}
	}
	purchaseOrderNumbers = purchaseOrderNumbers.substring(0,purchaseOrderNumbers.length-1);
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"companyShortName":companyShortName,"purchaseOrderNumber":purchaseOrderNumbers};
	//获取当前选中的
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseOrderService/batchCancelAuditByNumber",
    		contentType : "application/json",
    		type : "post",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			alert("<i18n:I18n key="" defaultValue="撤销成功" />");
    			query();
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
function backPurchaseOrder(){
		var rows = headGrid.selectedRows();
		if (rows.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		var purchaseOrderNumbers = "";
		for (var i = 0;i<rows.length;i++){
			purchaseOrderNumbers += rows[i].purchaseOrderNumber + ","; 
			if(!rows[i].fbk4 || rows[i].fbk4 == ""){
				alert(rows[i].purchaseOrderNumber+"<i18n:I18n key="i18n_alert_nopersoncannotsend" defaultValue="没有分配采购方负责人不能撤回" />",2);
				return;
			}
			if(rows[i].fbk4.split("_")[0] != elsSubAccount){
				var errMsg = "订单："+rows[i].purchaseOrderNumber+"当前用户不是负责人不能撤回";
				alert(errMsg,2);
				return;
			}
			if(rows[i].orderSendStatus == 0){
				var errMsg = "未发送的订单"+rows[i].purchaseOrderNumber+"不能撤回";
				alert(errMsg,2);
				return;
			} 
			if(rows[i].isDel == "Y"){
				alert("已作废的订单不能撤回",2);
				return;
			}
			if(rows[i].auditStatus != "0"){
				var errMsg = "未审批的订单"+rows[i].purchaseOrderNumber+"暂时不能撤回";
				alert(errMsg,2);
				return;
			}
		}
		purchaseOrderNumbers = purchaseOrderNumbers.substring(0,purchaseOrderNumbers.length-1);
		var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"companyShortName":companyShortName,"purchaseOrderNumber":purchaseOrderNumbers};
		//获取当前选中的
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url : "<%=basePath%>rest/PurchaseOrderService/batchBackPurchaseOrderByNumber",
	    		contentType : "application/json",
	    		type : "post",
	    		data : JSON.stringify(data),
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n key="" defaultValue="撤回成功" />");
	    			query();
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
	    		}
	    	});
		}});
	}
	
function loadDetails(itemIds){
	if(itemIds==""){
		itemGrid.load([]);
		fileGrid.load([]);
		deliveryGrid.load([]);
		return;
	}
	var param={"elsAccount":elsAccount,"itemIds":itemIds}
	var url = "<%=basePath%>rest/PurchaseOrderService/findPurchaseOrderDetails";
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(param),
		success : function(data) {
			//加载订单项
			if (data.purchaseOrderItemList.length > 200) {
				loadPartItem(0,200,data.purchaseOrderItemList);
			} else {
				itemGrid.load(data.purchaseOrderItemList);
			}
			//加载表单文件
			fileGrid.load(data.purchaseFormFileList);
			//加载交货计划
			deliveryGrid.load(data.purchaseDeliveryPlanList);
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function loadItem(itemIds) {
	if(itemIds==""){
		itemGrid.load([]);
		return;
	}
	var param={"elsAccount":elsAccount,"itemIds":itemIds,"elsSubAccount":elsSubAccount}
	var url = "<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderItem";
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(param),
		success : function(data) {
			if (data&&data.statusCode == "-100") {
			     alert(data.message, 3);
			 } else {
				 if (data.rows.length > 200) {
					 loadPartItem(0,200,data.rows);
				 } else {
					 itemGrid.load(data.rows);
				 }
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function loadPartItem(start,size,data) {
	var array = [];
	for (var i=0;i<size;i++) {
		array[i] = data[start+i];
	}
	start = start + size;
	itemGrid.addRows(array);
	if (start < data.length) {
		setTimeout(function(){
			if (data.length - start > 200) {
				loadPartItem(start,200,data);
			} else {
				loadPartItem(start,data.length-start,data);
			}
		},200);
	}
}
function loadFormFile(itemIds) {
	if(itemIds==""){
		fileGrid.load([]);
		return;
	}
	var param={"elsAccount":elsAccount,"itemIds":itemIds}
	$.ajax({
		url : "<%=basePath%>rest/PurchaseFormFileService/order/findPurchaseFormFile",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(param),
		success : function(data) {
			fileGrid.load(data.rows); 
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function checkSelected(){
	var hadSelected = headGrid.selectedRows();
	if(hadSelected==null){
		alert("<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />",2);
		return false;
	}else if(hadSelected.length<=0){
		alert("<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />",2);
		return false;
	}else if(hadSelected.length>1){
		alert("<i18n:I18n key="i18n_alert_onlyOneOrder" defaultValue="只能选择一条订单"/>",2);
		return false;
 	}else{
 		currentPurchaseOrderNumber=hadSelected[0].purchaseOrderNumber;
 	}
	return true;
}
function modifyPurchaseOrder(){
	if(!checkSelected()){
		return;
	}
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	//获取对方elsAccount
	toElsAccount = headGrid.selectedRows()[0].toElsAccount;
	var toCompanyName = headGrid.selectedRows()[0].companyShortName;
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'PurchaseOrderUpdate',
        'windowTitle':'<i18n:I18n key="i18n_windowtitle_purchaseorderupdate" defaultValue="采购订单详细"/>',
        windowSubTitle: toCompanyName,
        'iframSrc':'<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=' + toElsAccount + "&purchaseOrderNumber="+currentPurchaseOrderNumber,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function query() {
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var orderStatusParam = $("#orderStatusSelector").val();
	var orderSendStatusParam = $("#orderSendStatusSelector").val();
	var deliveryStatusParam = $("#deliveryStatusSelector").val();
	var auditStatus = $("#auditStatusSelector").val();
	 var fbk4 = $(".store-value").val();
     if(fbk4=="全部"){
    	 fbk4="";
     }else{
	     fbk4 =$(".store-value").val();
     }
     $("#fbk4").val(fbk4);
 	$("#fbk4Param").val(fbk4);
// 	var fbk4Param = $("#fbk4").val();
// 	$("#fbk4Param").val(fbk4Param);
	$("#orderStatusParam").val(orderStatusParam);
	$("#orderSendStatusParam").val(orderSendStatusParam);
	$("#deliveryStatusParam").val(deliveryStatusParam);
	$("#auditStatus").val(auditStatus);
	var frm = $("#queryForm");
	var paramJson=frm.serializeJSON();
	paramJson.purchaseOrderNumbers=$("#purchaseOrderNumber").val();
	headGrid.opts.params = paramJson;
	headGrid.load({});
}

function renderPurchaseType(val,item) {
	if(val == '0')
		return "<i18n:I18n key='i18n_common_select_procurementtype_standard' defaultValue='标准' />";
	else if(val == '1')
		return "<i18n:I18n key='i18n_common_select_procurementtype_restrict' defaultValue='限制' />";
	else if(val == '2')
		return "<i18n:I18n key='i18n_common_select_procurementtype_consignment' defaultValue='寄售' />";
	else if(val == '3')
		return "<i18n:I18n key='i18n_common_select_procurementtype_subcontract' defaultValue='分包' />";
	else if(val == '4')
		return "<i18n:I18n key='i18n_common_select_procurementtype_anunknowncommodity' defaultValue='未知的商品' />";
	else if(val == '5')
		return "<i18n:I18n key='i18n_common_select_procurementtype_thirdparty' defaultValue='第三方' />";
	else if(val == '6')
		return "<i18n:I18n key='i18n_common_select_procurementtype_text' defaultValue='文本' />";
	else if(val == '7')
		return "<i18n:I18n key='i18n_common_select_procurementtype_stocktransfer' defaultValue='库存转储' />";
	else if(val == '8')
		return "<i18n:I18n key='i18n_common_select_procurementtype_commoditytype' defaultValue='商品类目' />";
	else if(val == '9')
		return "<i18n:I18n key='i18n_common_select_procurementtype_service' defaultValue='服务' />";
	else
		return "";	
}
//修改企业负责人
function updateFbk4(){
	var purchaseOrderNumbers="";
	var selecteds=headGrid.selectedRows();
	for(var i=0;i<selecteds.length;i++){
		purchaseOrderNumbers+=selecteds[i].purchaseOrderNumber+",";
	}
	purchaseOrderNumbers=purchaseOrderNumbers.substring(0, purchaseOrderNumbers.length-1);
	if (!$("#selectedfbk4 #fbk4").val()||$("#selectedfbk4 #fbk4").val()=="" || $("#selectedfbk4 #fbk4").val()==null) {
		alert("<i18n:I18n key="i18n_label_selectthepersoninchargeoftheorder" defaultValue="请选择订单负责人" />",2);
		return;
	}
	var fbk4=$("#selectedfbk4 #fbk4").val();
	fbk4Str=fbk4;
	var json={"elsAccount":elsAccount,"fbk4":fbk4Str,"itemIds":purchaseOrderNumbers}
	console.log(JSON.stringify(json));
	
	$.ajax({
		url : "<%=basePath%>rest/PurchaseOrderService/setFbk4",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(json),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
 			if(data!=null&&data.statusCode=="-100"){
 				alert(data.message,2);
 			}else{
 				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
 				$("#fbk4Selector #fbk4").val("");
 	 			query();
 			}
 			$("#dialog1").hide();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			$("#dialog1").hide();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
//批量设置
$("#batchsetting").click(function(){
	var selecteds=headGrid.selectedRows();
	if(selecteds.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return ;
	}
	
	$("#selectedfbk4").html(selector2);
	$("#fbk4").find("option").each(function(){
		if (elsSubAccount.indexOf($(this).val().split("_")[0]) != -1) {
			$(this).attr("selected","selected");
		}
	});
	
	$(".SlectBox").each(function(){
		$(this).css("width",$(this).parent().parent().parent().width()-18);
	});
	$("#dialog1").show();
	$(".dialog-tip").height(175);
	$("#selectedfbk4 #fbk4").SumoSelect({
		floatWidth: 100
	});
});
//保存批量设置
$("#btnFileOK1").click(function(){
// 	getERP(purchaseOrderNumberParam);
	updateFbk4();
});
//取消批量设置
 $("#btnFileCancel1").click(function(){
    $("#dialog1").hide();
 });
 
 $('.dialog-close-btn').click(function(){
	   $('#dialog1').hide();
});

 // 查看流程
 $("#flowBtn").click(function(){
		if(!checkSelected()){
				return;
		}
		if (purchaseOrderNumber == "") {
			alert("<i18n:I18n key="i18n_delivery_notreport" defaultValue="单据尚未上报" />",2);
		} else if (flowCode == "") {
			alert("<i18n:I18n key="i18n_delivery_notreport" defaultValue="单据尚未上报" />",2);
		} else {
			var title = '<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程     " />'+"  订单号："+currentPurchaseOrderNumber;
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'auditFlowList',
		        'windowTitle':title,
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=purchaseOrder&businessId='+currentPurchaseOrderNumber,
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':680,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		}
		
	});

//判断是否显隐接口按钮
function isDisplayIntefaceButton(){
	//批量获取erp订单按钮
	$.ajax({
		url :"<%=basePath%>rest/IntefaceService/isExit/" + elsAccount + "/GetBatchERP",
		type :"get",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			if(data!=null&&data.statusCode=="-100"){
				$("#getERP").css("display","none");
			}else{
				$("#getERP").css("display","");
			}
		},
		error : function(data) {
//			if (!permissionError(data)) {
//				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
//			}
		}
	});
	
	//上传excl生成采购单订单
	$.ajax({
		url :"<%=basePath%>rest/IntefaceService/isExit/" + elsAccount + "/CreateERPPurchaseOrder",
		type :"get",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			if(data!=null&&data.statusCode=="-100"){
				$("#uploadPurchaseOrder").css("display","none");
			}else{
				$("#uploadPurchaseOrder").css("display","");
			}
		},
		error : function(data) {
//			if (!permissionError(data)) {
//				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
//			}
		}
	});
	
	
}
function initModifyFiled(itemList) {
	var map = {};
	for (var i in cols_item) {
		map[cols_item[i].name] = i;
	}
	var showDeleteFlag = false;
	if ($("#showDelete").attr("checked") == "checked") {
		showDeleteFlag = true;
	}
	for (var i in itemList) {
		var fbk50 = itemList[i].fbk50;
		if (fbk50) {
			var changeFields = fbk50.split(",");
			for (var j in changeFields) {
				$("#table-item").find("tr").eq(i).find("td").eq(parseInt(map[changeFields[j]])+1).css("background","yellow");
			}
		}
		// 删除待确认的标识
		if (itemList[i].deleteFlag && itemList[i].deleteFlag=="C") {
			$("#table-item").find("tr").eq(i).find("td").css("background","yellow");
		}
		if (itemList[i].deleteFlag && itemList[i].deleteFlag=="X") {
			$("#table-item").find("tr").eq(i).css("background-color","rgba(213, 58, 58, 0.0980392)");
			if (!showDeleteFlag) {
				$("#table-item").find("tr").eq(i).hide();
			}
		}
	}
}

function renderIsUnlimited(val,item){
	if(val && val == "X")
		return "是";
	else
		return "否";
}

function renderIsFinish(val,item){
	if(val && val == "X")
		return "是";
	else
		return "否";
}

function renderItemIsFinish(val,item){
	if(val && val == "X")
		return "是";
	else
		return "否";
}

var getERPCount = function() {
	setInterval(function() {
// 		getERPCountData();
    }, 300000);
}

var getERPCountData = function() {
	//迈腾-接口-运行中 @author jiangzhidong @date 20160809
	var frm = $("#queryForm");
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/getERPCount",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			if(data!=null&&data.statusCode=="-100"){
					alert(data.message,2);
				}else{
					$("#refurbishId").text(data.message);
				}
		},
		error : function(data) {
			if (!permissionError(data)) {
				 //alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

//刷新 @author jiangzhidong @date 20160401
$("#refurbishTmp").click(function(){
	getERPCountData();
});  

function renderAuditStatus(val,item,index){
	var fbk22 = item.fbk22;
	//审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
	if(val != "2" || (fbk22 == "" || fbk22 == null) ){
		if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
		else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
 		else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
 		else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';
	}else{
		return '<span class="flowBtn" style="color:blue;white-space: normal;"><i18n:I18n key="test" defaultValue="'+fbk22+'" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	}
}

function renderOrderType(val,item){
	if(val && val == "71"){
		return "K3订单";
	}else if(val && val == "sample"){
		return "样品订单";
	}else{
		return "ELS订单";
	}
}

//显示当前待审批节点 @author jiangzhidong @date 20160524  begin
$('.flowBtn').live("click", function() {
    var scanCol = $(this).next().text();
    var head = JSON.parse(scanCol);
	var targetElsAccount = head.elsAccount;
	var businessType = "purchaseOrder";
	var businessId = head.purchaseOrderNumber;
	var title = '<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程     " />'+"  订单号："+businessId;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':title,
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

$("#downloadBtn").click(function(){
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var orderStatusParam = $("#orderStatusSelector").val();
	var orderSendStatusParam = $("#orderSendStatusSelector").val();
	var deliveryStatusParam = $("#deliveryStatusSelector").val();
	var auditStatus = $("#auditStatusSelector").val();
 	/* var fbk4Param = $("#fbk4").val();
	$("#fbk4Param").val(fbk4Param); */
	var fbk4 = $(".store-value").val();
    if(fbk4=="全部"){
   	 fbk4="";
    }else{
	     fbk4 =$(".store-value").val();
    }
    $("#fbk4").val(fbk4);
	$("#fbk4Param").val(fbk4);
	$("#orderStatusParam").val(orderStatusParam);
	$("#orderSendStatusParam").val(orderSendStatusParam);
	$("#deliveryStatusParam").val(deliveryStatusParam);
	$("#deliveryStatusParam").val(deliveryStatusParam);
	$("#auditStatus").val(auditStatus);
	var data = $("#queryForm").serializeJSON();
	data["purchaseOrderNumbers"]=$("#purchaseOrderNumber").val();
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/order/exportOrderToExcel",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(data),
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
});
</script>
</body>
</html>