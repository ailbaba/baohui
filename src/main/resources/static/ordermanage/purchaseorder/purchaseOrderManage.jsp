<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<base:supplierAuth elsAccount="${elsAccount }" authCode="order" toElsAccount="${param['toElsAccount'] }"></base:supplierAuth>
    <div class="pos-relative public-wrap ">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="getERPAll" class="button-wrap"><i18n:I18n key="test" defaultValue="全量同步" /></button>
                <button id="getERP" class="button-wrap"><i18n:I18n key="test" defaultValue="增量同步" /></button>
                <button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                <button id="modifyBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="详细(手工审批)" /></button>
		<!--    <button id="addBtn" class="button-wrap"><i18n:I18n key="i18n_button_create" defaultValue="新建" /></button>-->
       <!--     <button id="deleteBtn" class="button-wrap"><i18n:I18n key="i18n_button_del" defaultValue="作废" /></button>-->
                <button id="backBtn" class="button-wrap"><i18n:I18n key="i18n_button_back" defaultValue="撤回" /></button>
                <button id="sendBtn" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
           <!-- <button id="scheduleBtn" class="button-wrap"><i18n:I18n key="i18n_button_viewprogress" defaultValue="查看进度" /></button>
                <button id="scheduleERPBtn" class="button-wrap"><i18n:I18n key="" defaultValue="从ERP获取进度" /></button>
                <button id="printBtn" class="button-wrap"><i18n:I18n key="i18n_button_print" defaultValue="打印" /></button>-->
                <button id="columnDefineBtn" class="button-wrap">头<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="itemColumnDefineBtn" class="button-wrap">行<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
<!--                 <input type="checkbox" id="showDelete"/>显示删除行 -->
<%--            <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
<!-- 				<div class="dis-in-b input-and-tip" style="margin-left: 20px; cursor: pointer;" id="refurbishTmp">K3系统订单<span id="refurbishId" style="color: red;"></span>条</div> -->
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;">
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
<!--            <input type="hidden" id="type" name="type" value="0"/> -->
            	<input type="hidden" id="toElsAccount" name="toElsAccount" value="<%=request.getParameter("toElsAccount")%>"/>
            <div class="common-box-line">
              	<div id="div-fbk4" class="dis-in-b input-and-tip">
                    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_xxx" defaultValue="采购负责人" />： </span>
                    <input type="hidden" id="fbk4Param" name="fbk4Param"/>
                    <span id="fbk4Selector"></span>
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
                <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input id="poNum" name="purchaseOrderNumbers" type="text" style="width:100px;max-width:100px; "/></div>
		   <!-- <div class="dis-in-b"><span>供应商ELS: </span><input type="text" name="toElsAccount"/></div> -->
                <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchasegroup" defaultValue="采购组" />： </span><input id="purchaseGroup" type="text" name="purchaseGroup" style="width:80px;max-width:80px; "/></div>
           <!-- <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_materialgroup" defaultValue="物料组" />： </span><input type="text" name="materialGroup"/></div>
        		<div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_label_trackNumber" defaultValue="跟踪号" />： </span><input type="text" name="trackNumber"/></div>
       	        <div class="dis-in-b"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_showallorder" defaultValue="显示所有订单" />： </span><input name="isMyself" id="isMyself" type="checkbox" value="" /> </div> -->
              	  
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
                        <span><select id="formFileTypeSelector" onchange="loadFormFileByType()">
								  <option value="0"><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
								  <option value="1"><i18n:I18n key="i18n_common_select_head" defaultValue="按订单头" /></option>
								  <option value="2"><i18n:I18n key="i18n_common_select_item" defaultValue="按订单行" /></option>
						</select></span>
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
    
    <div class="fixed-dialog">
		<div class="dialog-tip bg-common" style="border:1px solid;height: 20px;">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
<!-- 				<img class="icon" src="../../icon/els.PNG" /> <span -->
					<i18n:I18n key="i18n_button_getfromerp" defaultValue="从ERP获取" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<div class="common-box-line">
						<div id="divOrderItem" class="input-and-tip">
							<span><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span> <input type="text" id="purchaseOrderNumberParam"/>
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
<script type="text/javascript">
var selector = '<base:subAccount role='purchase' elsAccount='${elsAccount }' type='multiple' id='fbk4' ></base:subAccount>';
var headGrid;
var itemGrid;
var fileGrid;
var deliveryGrid;
var itemIds;
var currentPurchaseOrderNumber;
var peopleList;
var $sob;
var chatFromUrlFlag = false;
var printData ={};
elsAccount='<%=session.getAttribute("elsAccount") %>';
elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
toElsAccount=GetQueryString("toElsAccount");
$(document).ready(function(){
	//获取查看消息采购订单号
	var initpurchaseOrderNumber = window.queryChats('q');
		if(initpurchaseOrderNumber && initpurchaseOrderNumber.length) {
			if(initpurchaseOrderNumber.lastIndexOf(',')!=-1 ) {
				$("#poNum").val(initpurchaseOrderNumber.substring(0,initpurchaseOrderNumber.length-1));
				$(':radio[name="dateArea"]').eq(0).attr("checked",false);
   				$(':radio[name="dateArea"]').eq(3).attr("checked",true);
			} else {
// 				$("#poNum").val(initpurchaseOrderNumber.substring(0,initpurchaseOrderNumber.length));
				$(':radio[name="dateArea"]').eq(0).attr("checked",false);
   				$(':radio[name="dateArea"]').eq(3).attr("checked",true);
			}
	}
	//获取用户采购组
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
	
    $('.grid-100').find('.checkAll').hide();
    
    $("#fbk4Selector").html(selector);
/*  $("#fbk4").find("option").each(function(){
    	$(this).attr("value",$(this).text().split("_")[0]);
    }); */
    $("#fbk4").val(elsSubAccount + "_" + username);
    $("#fbk4").attr("placeholder",'<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />');
    $("#fbk4").SumoSelect({optAfter:'#div-fbk4',optCancel:'#div-fbk4 .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
    $("#orderStatusSelector").SumoSelect({optAfter:'#div-orderStatus',optCancel:'#div-orderStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
    $("#orderSendStatusSelector").SumoSelect({optAfter:'#div-orderSendStatus',optCancel:'#div-orderSendStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
    $("#deliveryStatusSelector").SumoSelect({optAfter:'#div-deliveryStatus',optCancel:'#div-deliveryStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
    $("#auditStatusSelector").SumoSelect({optAfter:'#div-auditStatus',optCancel:'#div-auditStatus .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
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
	
	//获取参数
    init();
});
//初始化聊天窗口
//ELS账号+订单号 作为 businessID
function initChat(businessID,fbk5, hadSelected) {
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
var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseOrderManage_mt"/>;
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
                 { title:'<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" />', name:'filePath', width: 80, align: 'center',renderer:function(val,item,index){
                	 if(!item.fbk1){
                		 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/downloadServlet?filePath="+ val +"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
                	 }else{
                		 var fileType = item.fileType;
                 		 var fileName = item.fileName+"."+fileType;
                 		 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/download4OSSServlet?filePath="+ val +"&fileName="+fileName+"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
                	 }
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
	$sob = $('.saying-dialog .option-bar');
	//初始化控件
    $( "#sheet-project").tabs();
	changeDateArea();
    $("[name=dateArea]").click(changeDateArea);
    //加当前负责人查询
    var fbk4Param = $("#fbk4").val();
	$("#fbk4Param").val(fbk4Param);
    //订单头列表
    var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
    headGrid = $('#table-head').mmGrid({
        cols: cols,
        url : '<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderByCondtion',
        params: frm.serializeJSON(),
        method:  'post',
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:"250px",
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
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex){
    	//存储选中的的行数据，用作打印判断
    	$('body').data('selectHead',headGrid.selectedRows());
    	var hadSelected = headGrid.selectedRows();
    	currentPurchaseOrderNumber = item.purchaseOrderNumber;
    	itemIds="";
    	hadSelected.forEach(function(val){
    		itemIds=itemIds+","+val.purchaseOrderNumber;
    	});
    	if(itemIds!=""){
    		itemIds=itemIds.substring(1);
    	}
    	
/*     	loadItem(itemIds);
    	// 加载采购表单文件
    	loadFormFile(itemIds); */
    	
    	loadDetails(itemIds);
    	
    	// 动态加载聊天窗口
		if(hadSelected && hadSelected.length) {
			if(chatFromUrlFlag) {
				initChat(elsAccount+"_"+item.purchaseOrderNumber,item.fbk5,hadSelected);
			}
    	} else {
    		initChat();
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
    	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
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
    	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
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
    			if(chatString.lastIndexOf(',')!=-1 ) {
    				chatArr = chatString.substring(0,chatString.length-1).split(',');
    			} else {
    				chatArr = chatString.substring(0,chatString.length).split(',');
    			}
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
	       						headGrid.select(i)
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
    /**
     * 打印
     */
     $('#printBtn').click(function() {
    	 var hadSelected = headGrid.selectedRows();
 		if(hadSelected==null){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}else if(hadSelected.length<=0){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}else if(hadSelected.length>1){
 			alert('只能打印一个订单！',2);
 			return false;
 		}
 		currentPurchaseOrderNumber = hadSelected[0].purchaseOrderNumber;
    	 //判断是调用sap的合同，还是使用我们自己的模板打印
    	 $.ajax({
     		url : "<%=basePath%>rest/PurchaseOrderService/isMyself/"+elsAccount,
     		type : "get",
     		contentType : "application/json",
     		dataType : "json",
     		success : function(data) {
     			if (data!=null&&data.statusCode == "-100") {
     				alert(data.message,2);
     			}else{
     				if(data=="0"){//使用sap的合同
     					printERP();
     				}else{//使用我们自己的模板生成合同
     					printMyself();
     				}
     			}
     		},
     		error : function(data) {
 	    		alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
     		}
     	});
     });
    
    //打印erp合同
    function printERP(){
    	//打印采购订单
//         	var data = {"purchaseOrderNumber":purchaseOrderNumber,"elsAccount":elsAccount};
        	$.ajax({
        		url : "<%=basePath%>rest/PurchaseOrderService/printERPPurchaseOrde/"+currentPurchaseOrderNumber+"/"+elsAccount,
        		type : "get",
        		contentType : "application/json",
        		dataType : "json",
        		success : function(data) {
        			if (data!=null&&data.statusCode == "-100") {
        				alert(data.message,2);
        			}else{
        				window.location.href = data.fileName;
        			}
        		},
        		error : function(data) {
    	    		alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
        		}
        	});
    }
    
    //打印系统模板
    function printMyself(){
    	debugger;
    	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseOrderManage_mt"/>;
    	var bodyData = $('body').data();
    	var textH = bodyData.selectHead;
    	var rows  = itemGrid.rows();
    	if(textH && textH.length===1&&rows[0]) {
    		var data = $.extend(true,{},textH[0]);
    		debugger;
    		data.rows=[];
    		rows.forEach(function(r){
    			debugger;
    			//data.rows.push($.extend(true,{},r,textH[0]))
    			r.deliveryDate = new Date(r.deliveryDate).Format("yyyy-MM-dd");
    			data.rows.push(r)
    		})

    		//存储打印需要的数据
    		var printWin = parent.elsDeskTop.defineWin({
    	        'iconSrc':'icon/els-icon.png',
    	        'windowsId':'ePrintTemplatesManager',
    	        'windowTitle':'<i18n:I18n key="i18n_windowtitle_orderprint" defaultValue="订单打印" />',
    	        'iframSrc':'<%=basePath%>ePrintTemplatesManager.jsp',
    	        'windowStatus': 'maximized',
    	        'windowMinWidth': 960,
    	        'windowMinHeight': 700,
    	        'windowWidth':960,
    	        'windowHeight':700,
    	        'parentPanel':".currDesktop"
    	    });
			// 传入打印数据到打印窗口
			// 子窗口 通过loadIframeData 获取数据  onIframeDataLoad监听数据变化
			debugger;
			printWin.setIframeData([data]);
    	} else {
    		parent.elsDeskTop.tip.init({type: 'alert',displayType: 3, message:'<i18n:I18n key="i18n_message_whichordertoprint" defaultValue="您还没选择要打印的表单" />'});
    	}
    }
    
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
    $("#exitBtn").click(function(){
    	if (winId) {
			parent.elsDeskTop.closeCurWin(winId);
		} else {
    		parent.elsDeskTop.closeCurWin('OrderManage' + toElsAccount);
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
    $("#getERPAll").click(function(){
    	if(!(elsAccount == "160000" && elsSubAccount == "1001")){
    		alert("仅160000/1001账户可执行同步操作",2);
    		return;
    	}
    	$("#purchaseOrderNumberParam").val("");
    	$(".fixed-dialog").show();
    });
    
	$("#btnFileOK1").click(function(){
	    $(".fixed-dialog").hide();
	    debugger;
	    var purchaseOrderNumberParam=$("#purchaseOrderNumberParam").val();
	    getERPAll(purchaseOrderNumberParam);
	 });
	 $("#btnFileCancel1").click(function(){
	    $(".fixed-dialog").hide();
	 });
    
    $("#sendBtn").click(function(){
    	sendPurchaseOrder();
    });
    $("#modifyBtn").click(function(){
    	modifyPurchaseOrder();
    });
    $("#scheduleBtn").click(function(){
    	viewSchedule();
    });
    $("#scheduleERPBtn").click(function(){
    	if(!checkSelected()){
    		return;
    	}
    	var selected = headGrid.selectedRows()[0];
    	// 确认后才能获取
    	if (selected.orderStatus =="0"||selected.orderStatus =="2"||selected.orderStatus =="5") {
    		alert("订单尚未确认不能获取进度",2);
    		return;
    	}
    	parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/OrderScheduleService/getErpSchedule/"+elsAccount+"/" + selected.elsAccount + "/" + selected.purchaseOrderNumber,
    		contentType : "application/json",
    		type : "get",
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			if (data&&data.statusCode == "-100") {
     				alert(data.message,3);
     			} else {
     				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
     			}
    		},
    		error : function(data) {
    			parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
    			}
    		}
    	});
    });
    $("#deleteBtn").click(function(){
    	deletePurchaseOrder();
    });
    $("#backBtn").click(function(){
    	if(!checkSelected()){
    		return;
    	}
    	var selected = headGrid.selectedRows()[0];
    	if(selected.orderSendStatus == 0){
    		alert("未发送的订单无须撤回",2);
    		return;
    	}
    	if(selected.isDel == "Y"){
    		alert("已作废的订单无须撤回",2);
    		return;
    	}
    	if(selected.orderStatus != 0 && selected.orderStatus != 3){
    		alert("供应商操作过的订单不能撤回",2);
    		return;
    	}
    	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"purchaseOrderNumber":currentPurchaseOrderNumber};
    	//获取当前选中的
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
    		parent.elsDeskTop.showLoading();
        	$.ajax({
        		url : "<%=basePath%>rest/PurchaseOrderService/rollBackPurchaseOrder",
        		contentType : "application/json",
        		type : "post",
        		data : JSON.stringify(data),
        		dataType : "json",
        		success : function(data) {
        			parent.elsDeskTop.hideLoading();
        			alert("操作成功");
        			query();
        		},
        		error : function(data) {
        			parent.elsDeskTop.hideLoading();
        			if (!permissionError(data)) {
        				alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
        			}
        		}
        	});
    	}});
    });
    $("#columnDefineBtn").click(function(){
    	parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'subAccountColumnSetting',
            'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
            windowSubTitle: "",
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseOrderManage_mt" + "&window=iframeApp_OrderManage"+toElsAccount,
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
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseOrderItem_mt" + "&window=iframeApp_OrderManage"+toElsAccount,
            windowMinWidth: 480,
            windowMinHeight: 600,
            'windowWidth':480,
            'windowHeight':600,
            'parentPanel':".currDesktop"
        });
    });
/*     $("#isMyself").change(function(){
    	if($("#isMyself").is(":checked")){
    		$("#type").val("");
    	}else{
    		$("#type").val("1");
    	}
    }); */
}
/*
 * 从K3获取订单信息
 */
function getERP(purchaseOrderNumberParam){
	var btnERPImport = $("#getERP");
		btnERPImport.empty().append('<span style="color: red;">同步中...</span>');
	if(purchaseOrderNumberParam == null || purchaseOrderNumberParam == ""){
		alert("订单号不能为空",2);
		return;
	}
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
/*
 * 从K3获取订单信息
 */
function getERPAll(purchaseOrderNumberParam){
	var btnERPImport = $("#getERPAll");
		btnERPImport.empty().append('<span style="color: red;">同步中...</span>');
	var json={"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseOrderNumber":purchaseOrderNumberParam,"paramStr":"{\"PURCHASEORDER\" : \""+purchaseOrderNumberParam+"\"}"};
	var paramStr = JSON.stringify(json);
	$.ajax({
		url : "<%=basePath%>rest/PurchaseOrderService/getERPAll" ,
		contentType : "application/json",
 		type : "post",
 		dataType : "json",
 		data:paramStr,
 		success : function(data) {
 			if(data!=null&&(data.statusCode=="-100"||data.statusCode=="-200")){
 				alert(data.message,3);
 			}else{
 				btnERPImport.empty().append('<span style="color: red;">全量成功</span>');
 	 			query();
 			}
 		},
 		error : function(data) {
 			alert(data.message,3);
 		}
 	});
}
function deletePurchaseOrder(){
	if(!checkSelected()){
		return;
	}
	var selected = headGrid.selectedRows()[0];
	if(selected.orderSendStatus != 0){
		alert("已发送的订单不能作废",2);
		return;
	}
	if(selected.flowCode != null && selected.flowCode != "" && selected.flowCode != "00"){
		alert("审批流程中的订单不能作废",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
    		url : "<%=basePath%>rest/PurchaseOrderService/deletePurchaseOrder/" +currentPurchaseOrderNumber +"/" + elsAccount + "/" + elsSubAccount,
     		type : "get",
     		dataType : "json",
     		success : function(data) {
     			parent.elsDeskTop.hideLoading();
     			if (data&&data.statusCode == "-100") {
     				alert(data.message,3);
     			} else {
     				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
	}});
}
function sendPurchaseOrder(){
	if(!checkSelected()){
		return;
	}
	var selected = headGrid.selectedRows();
 	if(selected[0].orderSendStatus == 1){
		alert("已发送的订单不能再次发送",2);
		return;
	} 
	if(selected[0].isDel == "Y"){
		alert("已作废的订单不能发送",2);
		return;
	}
	if(selected[0].auditStatus == "1" || selected[0].auditStatus == "3"){
		alert("未审批通过的订单暂时不能发送",2);
		return;
	}
	if(selected[0].auditStatus == "2"){
		alert("审批中的订单暂时不能发送",2);
		return;
	}
	if(!selected[0].fbk4 || selected[0].fbk4==""){
		alert("<i18n:I18n key='i18n_alert_nopersoncannotsend' defaultValue='没有分配采购方负责人不能发送给供应商！' />",2);
		return;
	}
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"companyShortName":companyShortName,"purchaseOrderNumber":selected[0].purchaseOrderNumber};
	//获取当前选中的
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseOrderService/sendPurchaseOrderByNumber",
    		contentType : "application/json",
    		type : "post",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			if(data.statusCode==-100){
    				alert(data.message,3);
    			}else{
    				alert("<i18n:I18n key='i18n_common_sendsuccess' defaultValue='发送成功' />");
        			query();
    			}
    		}, error : function(data) {
    			debugger;
    			parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				if (data.status == "401") {
    					alert("<i18n:I18n key='i18n_alert_noauditcannotsend' defaultValue='未审批通过的订单不能发送' />",3);
				    }else {
				    	alert("<i18n:I18n key='i18n_common_request_error' defaultValue='请求出错' />",3);
				    }
    			}
    		}
    	});
	}});
}
function viewSchedule(){
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
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editOrderSchedule',
        'windowTitle':'<i18n:I18n key="i18n_button_viewprogress" defaultValue="查看进度" />',
        windowSubTitle: currentPurchaseOrderNumber,
        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderSchedule.jsp?businessElsAccount=' + elsAccount + "&purchaseOrderNumber="+currentPurchaseOrderNumber,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
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
	var selected = headGrid.selectedRows()[0];
// 	if(selected.isDel == "Y"){
// 		alert("已作废的订单不能修改",2);
// 		return;
// 	}
	//只有未发送状态的订单能修改
/* 	var hadSelected = headGrid.selectedRows();
	if(hadSelected.length && hadSelected[0].orderSendStatus != 0){
		alert("<i18n:I18n key="i18n_enquiry_xxxx" defaultValue="订单已发送,不能修改" />",2);
		return false;
	} */
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	//获取对方elsAccount
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
	debugger;
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'PurchaseOrderUpdate',
        'windowTitle':'<i18n:I18n key="test" defaultValue="采购订单详细" />',
        windowSubTitle: toCompanyName,
        'iframSrc':'<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?type=update&toElsAccount=' + toElsAccount + "&purchaseOrderNumber="+currentPurchaseOrderNumber+'&toCompanyName='+toCompanyName,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function insertPurchaseOrder(){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	//获取对方elsAccount
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	
	
	var toCompanyName='<%=request.getParameter("toCompanyName")%>';
	
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'PurchaseOrderUpdate',
        'windowTitle':'<i18n:I18n key="i18n_windowtitle_purchaseordercreate" defaultValue="新建采购订单" />',
        windowSubTitle: toCompanyName,
        'iframSrc':'<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?type=create&toElsAccount=' + toElsAccount +'&toCompanyName='+toCompanyName,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
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
			if (data.rows.length > 200) {
				loadPartItem(0,200,data.rows);
			} else {
				itemGrid.load(data.rows);
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function loadFormFile(purchaseOrderNumber) {
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

var getERPCount = function() {
	setInterval(function() {
// 		getERPCountData();
    }, 300000);
}

var getERPCountData = function() {
	debugger;
	// 迈腾-接口-运行中 @author jiangzhidong @date 20160809
    var frm = $("#queryForm");
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/getERPCount",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			debugger;
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

function query() {
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var orderStatusParam = $("#orderStatusSelector").val();
	var orderSendStatusParam = $("#orderSendStatusSelector").val();
	var deliveryStatusParam = $("#deliveryStatusSelector").val();
	var auditStatus = $("#auditStatusSelector").val();
	debugger;
	var fbk4Param = $("#fbk4").val();
	$("#fbk4Param").val(fbk4Param);
	$("#orderStatusParam").val(orderStatusParam);
	$("#orderSendStatusParam").val(orderSendStatusParam);
	$("#deliveryStatusParam").val(deliveryStatusParam);
	$("#auditStatus").val(auditStatus);
	var frm = $("#queryForm");
	if (fileGrid) {
		fileGrid.load([]);
	}
	if (itemGrid) {
		itemGrid.load([]);
	}
	debugger;
	headGrid.opts.params = frm.serializeJSON();
	headGrid.load({});
}

$('.dialog-close-btn').click(function(){
    $('.fixed-dialog').hide();
});
function renderProductionStatus(val,item) {
	if (!val) {
		return "";
	}
	return "<a href=\"javascript:showProductionStatus('"+item.elsAccount+"','"+item.purchaseOrderNumber+"','"+item.orderItemNumber+"');\">"+val+"</a>";
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
function loadFormFileByType() {
	var type = $("#formFileTypeSelector").val();
	if(currentPurchaseOrderNumber != null && currentPurchaseOrderNumber != "null" && currentPurchaseOrderNumber != ""){
		$.ajax({
			url :"<%=basePath%>rest/PurchaseFormFileService/order/selectByHeadOrItem/" + elsAccount + "/" + currentPurchaseOrderNumber + "/" + type,
			type :"get",
			contentType : "application/json",
			dataType : "json",
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
}

//判断是否显隐接口按钮
function isDisplayIntefaceButton(){
	//获取erp订单
	$.ajax({
		url :"<%=basePath%>rest/IntefaceService/isExit/" + elsAccount + "/GetERP",
		type :"get",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			if(data!=null&&data.statusCode=="-100"){
				$("#getERP").css("display","none");
				$("#addBtn").css("display","");
			}else{
				$("#getERP").css("display","");
				$("#addBtn").css("display","none");
			}
		},
		error : function(data) {
// 			if (!permissionError(data)) {
// 				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
// 			}
		}
	});
	$.ajax({
		url :"<%=basePath%>rest/IntefaceService/isExit/" + elsAccount + "/GetERPSchedule",
		type :"get",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			if(data!=null&&data.statusCode=="-100"){
				$("#scheduleERPBtn").css("display","none");
			}else{
				$("#scheduleERPBtn").css("display","");
			}
		},
		error : function(data) {
// 			if (!permissionError(data)) {
// 				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
// 			}
		}
	});
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
				$("#table-item").find("tr").eq(i).find("td").eq(parseInt(map[changeFields[j]])).css("background","yellow");
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

function renderOrderType(val,item){
	if(val && val == "71"){
		return "K3订单";
	}else if(val && val == "sample"){
		return "样品订单";
	}else{
		return "ELS订单";
	}
}
function renderAuditStatus(val,item){
	if("undefined"==typeof(val)){
		val = "";
	}
	if("0"==val){
		return "审批通过";
	} else if("1"==val){
		return "未审批";
	} else if("2"==val){
		return "审批中";
	} else {
		return "审批拒绝";
	}
}

//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.Format = function(fmt)   
{ //author: meizz   
var o = {   
 "M+" : this.getMonth()+1,                 //月份   
 "d+" : this.getDate(),                    //日   
 "h+" : this.getHours(),                   //小时   
 "m+" : this.getMinutes(),                 //分   
 "s+" : this.getSeconds(),                 //秒   
 "q+" : Math.floor((this.getMonth()+3)/3), //季度   
 "S"  : this.getMilliseconds()             //毫秒   
};   
if(/(y+)/.test(fmt))   
 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
for(var k in o)   
 if(new RegExp("("+ k +")").test(fmt))   
fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
return fmt;   
}  
</script>
</body>
</html>