<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative ">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form style="margin:0;" id="queryForm" onsubmit="return false;" method="POST">
            	<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount }"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount" value="${elsSubAccount }"/>
            	<input type="hidden" id="flag" name="flag"/>
            <div class="common-box-line">
            	<div class="dis-in-b input-and-tip"><span class=" text-right w-72"><i18n:I18n key="i18n_common_title_businesstype" defaultValue="单据类型" />：</span>
            	<select id="businessType" name="businessType"></select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class=" text-right w-72"><i18n:I18n key="test" defaultValue="对方els账号" />：</span>
            	<input name="toElsAccount" type="text"/>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class=" text-right w-72"><i18n:I18n key="test" defaultValue="对方公司简称" />：</span>
            	<input name="companyShortName" type="text"/>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class=" text-right w-72"><i18n:I18n key="i18n_enquiry_title_describe" defaultValue="描述" />：</span>
            	<input name="recordDesc" type="text"/>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class=" text-right w-72"><i18n:I18n key="test" defaultValue="创建人" />：</span>
            	<input name="createUser" type="text"/>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class=" text-right w-72"><i18n:I18n key="i18n_label_handleFlag" defaultValue="处理状态" />：</span>
            	<select id="handleFlag">
            		<option value=""><i18n:I18n key="" defaultValue="全部" /></option>
            		<option value="0" selected = "selected"><i18n:I18n key="i18n_label_todo" defaultValue="待处理" /></option>
            		<option value="1"><i18n:I18n key="i18n_label_done" defaultValue="已处理" /></option>
            	</select>
            	</div>
            	<button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <div class="common-box-line">
<%--             	<button id="auditBtn" class="button-wrap"><i18n:I18n key="i18n_label_audit" defaultValue="审批单据" /></button> --%>
<%--             	<button id="detailBtn" style="display:none;" class="button-wrap"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看单据" /></button> --%>
            	<button id="passBtn" class="button-wrap"><i18n:I18n key="i18n_button_batchPass" defaultValue="批量通过" /></button>
            	<button id="noPassBtn" class="button-wrap"><i18n:I18n key="i18n_button_batchNoPass" defaultValue="批量拒绝" /></button>
            	<button id="getAuditBtn" class="button-wrap"><i18n:I18n key="" defaultValue="同步审批列表到企业库" /></button>
            	<button id="viewRecordBatchBtn" class="button-wrap"><i18n:I18n key="" defaultValue="查看多条审批记录" /></button>
<%--             	<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button> --%>
                <main class="grid-container" style="margin-top:5px;">
                    <div class="grid-100">
                        <table id="table-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
        <div class="fixed-dialog">
			<div class="dialog-tip bg-common">
				<div class="dialog-close-btn"></div>
				<div class="tip-head">
					<img class="icon" src="../icon/els.PNG" /> <span
						id="dialogTitle"><i18n:I18n key="i18n_title_fillOpinion" defaultValue="填写审批意见" /></span>
				</div>
				<div>
					<div class="box-wrap pos-relative bg-common">
						<div class="common-box-line">
							<textarea id="auditOpinion" name="auditOpinion" style="width:95%;" rows="5" maxlength="200"></textarea>
							<div class="mt-20">
								<button id="btnFileOK1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
								<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
								<button id="btnFileCancel1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    </div>
<script type="text/javascript">
var businessType = GetQueryString("businessType");
var cols = [{title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'elsAccount', width: 80, align: 'center',renderer:function(val){
				return "<a href='javascript:void(0)' onclick='viewRecord(this)'>查看</a>&nbsp;&nbsp;<a href='javascript:void(0)' onclick='viewFlow(this)'>流程</a>";
			}},
            {title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />', name:'elsAccount', width: 80, align: 'center'},
            {title:'<i18n:I18n key="i18n_label_toElsAccount" defaultValue="对方ELS账号" />', name:'toElsAccount', width: 80, align: 'center'},
            {title:'<i18n:I18n key="i18n_common_title_tocompanyshortname" defaultValue="对方公司名称" />', name:'companyShortName', width: 150, align: 'center'},
            {title:'<i18n:I18n key="i18n_common_title_businesstype" defaultValue="单据类型" />', name:'businessType', width: 100, align: 'center',renderer:function(val){
            	if (val == "purchaseOrder") {
            		return "<i18n:I18n key="i18n_businesstype_purchaseOrder"  defaultValue="采购订单" />";
            	} else if (val == "delivery") {
            		return "<i18n:I18n key="i18n_businesstype_delivery"       defaultValue="发货单" />";
            	} else if (val == "saleEnquiry") {
            		return "<i18n:I18n key="i18n_businesstype_saleEnquiry"    defaultValue="报价单" />";
            	} else if (val == "bargainEnquiry") {
            		return "<i18n:I18n key="i18n_businesstype_bargainEnquiry" defaultValue="询价单" />";
            	} else if (val == "standardSupplier") {
            		return "<i18n:I18n key="i18n_common_access_to_suppliers"  defaultValue="供应商准入" />";
            	}  else if (val == "c2fo") {
            		return "<i18n:I18n key="i18n_businesstype_c2fo"  defaultValue="企利通" />";
            	}  else if (val == "project") {
            		return "<i18n:I18n key="test"  defaultValue="立项" />";
            	}  else if (val == "designDoc") {
            		return "<i18n:I18n key="test"  defaultValue="设计文档" />";
            	}  else if (val == "contract") {
            		return "<i18n:I18n key=""  defaultValue="采购合同" />";
            	}  else if (val == "bidding") {
            		return "<i18n:I18n key=""  defaultValue="定标审批" />";
            	} else if (val == "preBidding") {
            		return "<i18n:I18n key=""  defaultValue="招标发送前审批" />";
            	}
            }},
            {title:'<i18n:I18n key="i18n_common_label_describe" defaultValue="描述" />', name:'recordDesc', width: 250, align: 'center'},
            {title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="上报人"/>', name:'createUser', width: 150, align: 'center'},
            {title:'<i18n:I18n key="i18n_common_title_createdate" defaultValue="上报时间" />', name:'createDate', width: 150, align: 'center',renderer:timeFormat},
            {title:'<i18n:I18n key="i18n_label_currentNodeCode" defaultValue="当前节点编号" />', name:'flowCode', width: 80, align: 'center'},
            {title:'<i18n:I18n key="i18n_label_currentNodeName" defaultValue="当前节点名称" />', name:'flowName', width: 150, align: 'center'},
            {title:'<i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />', name:'auditStatus', width: 80, align: 'center',renderer:function(val){
            	if (val=="2") {
            		return "<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />";
            	} else if (val=="0") {
            		return "<i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" />";
            	} else if (val== "3") {
            		return "<i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" />";
            	}
            }}
            ];
var auditGrid;
$().ready(function(){
	$("input[name='dateArea']").click(function(){
		var dateArea = $(this).val();
		var currDate = new Date();

		if("lastMonth" == dateArea){
			$("#startCreateDate").parent().hide();
			$("#endCreateDate").parent().hide();

			var currDateMill = currDate.getTime();
			var startDate = new Date();
			startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
			var currMonthMaxDay = startDate.getDate();//本月天数
			startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));

			$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
			$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
		} else if("lastThreeMonth" == dateArea){
			$("#startCreateDate").parent().hide();
			$("#endCreateDate").parent().hide();

			var currDateMill = currDate.getTime();
			var startDate = new Date();
			startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
			var currMonthMaxDay = startDate.getDate();//本月天数
			startDate.setMonth(currDate.getMonth(), 0);//上月最后一日
			var lastMonthMaxDay = startDate.getDate();//上月天数
			startDate.setMonth(currDate.getMonth()-1, 0);//前第二月最后一日
			var last2MonthMaxDay = startDate.getDate();//前第二月天数

			startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay+lastMonthMaxDay+last2MonthMaxDay-1));
			$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
			$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
		} else if("defineDateArea" == dateArea) {
			$("#startCreateDate").val("");
			$("#endCreateDate").val("");
			$("#startCreateDate").parent().show();
			$("#endCreateDate").parent().show();
		} else {//默认查最近一月
			$("#startCreateDate").parent().hide();
			$("#endCreateDate").parent().hide();

			var currDateMill = currDate.getTime();
			var startDate = new Date();
			startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
			var currMonthMaxDay = startDate.getDate();//本月天数
			startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));

			$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
			$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
		}
	});
	$("#queryBtn").click(function(){
		query();
	});
	$("#passBtn").click(function(){
		batchAudit("pass");
	});
	$("#noPassBtn").click(function(){
		batchAudit("noPass");
	});
	$("#getAuditBtn").click(function(){
		getAudit("160000");
	});
	$("#viewRecordBatchBtn").click(function(){
		viewRecordBatch();
	});
	$("#auditBtn").click(function(){
		audit(0);
	});
	$("#detailBtn").click(function(){
		audit(1);
	});
	$("#flowBtn").click(function(){
		flow();
	});
	$('.dialog-close-btn').click(function(){
        $('.fixed-dialog').hide();
    });
    $('.tip-option-btn').click(function(){
        $('.dialog-close-btn').trigger('click');
    });
	$("#btnFileOK1").click(function(){
		if (currentBusinessType == "purchaseOrder") {
			batchAuditPurchaseOrder("pass");
		} else if (currentBusinessType == "c2fo") {
			batchAuditC2fo("pass");
		} else {
			alert("<i18n:I18n key="i18n_alert_nobatchAudit" defaultValue="此单据不支持批量审批" />",2);
			return;
		}
	});
	$("#btnFileOK2").click(function(){
		if (currentBusinessType == "purchaseOrder") {
			batchAuditPurchaseOrder("noPass");
		} else if (currentBusinessType == "c2fo") {
			batchAuditC2fo("noPass");
		} else {
			alert("<i18n:I18n key="i18n_alert_nobatchAudit" defaultValue="此单据不支持批量审批" />",2);
			return;
		}
	});
	$.ajax({
		url      : "<%=basePath%>rest/AuditService/getBusinessType",
 		type     : "get",
 		dataType : "json",
 		success  : function(data) {
 			if (data.rows && data.rows.length > 0) {
 				var html = "<option value='all'><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>";
 				for (var i=0;i<data.rows.length;i++) {
 					html += "<option value='"+data.rows[i].split(",")[0]+"'>" + data.rows[i].split(",")[1]+"</option>";
 				}
 				$("#businessType").html(html);
 				if (businessType && businessType != "") {
 					$("#businessType").val(businessType);
 				}
 				var frm = $("#queryForm");
 				var height = $(document).height()-240;
 				var url = "<%=basePath%>rest/AuditService/getTodoList";
 				var handleFlag = $("#handleFlag").val();
 				if (handleFlag == "1") {
 					url = "<%=basePath%>rest/AuditService/getDoneList";
 				}
 				auditGrid = $('#table-head').mmGrid({
 			        cols        : cols                ,
 			        height      : height              ,
 			       	multiSelect : true                ,
 			        url         : url                 ,
 			        params      : frm.serializeJSON() ,
 			        method      : frm[0].method       ,
 			        root        : "rows"              ,
 			        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
 			        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
 			        checkCol    : true                ,
 			        plugins     : [ $('#pg').mmPaginator({
 			                        style           : 'plain'
 			                      , totalCountName  : 'total'
 			                      , page            : 1
 			                      , pageParamName   : 'currentPage'
 			                      , limitParamName  : 'pageSize'
 			                      , limitLabel      : '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
 			                      , totalCountLabel : '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
 			                      , limit           : null
 			                      , limitList       : [200,100,50,10]})
 			                      ]
 			    });
 			}
 		},
 		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
 		}
 	});
});
function query(){
	debugger;
	var url = "<%=basePath%>rest/AuditService/getTodoList";
	var handleFlag = $("#handleFlag").val();
	if (handleFlag == "1") {
		url = "<%=basePath%>rest/AuditService/getDoneList";
		$("#passBtn").hide()   ;
		$("#noPassBtn").hide() ;
		$("#auditBtn").hide()  ;
		$("#detailBtn").show() ;
	} else {
		$("#passBtn").show()   ;
		$("#noPassBtn").show() ;
		$("#auditBtn").show()  ;
		$("#detailBtn").hide() ;
	}
	var frm = $("#queryForm").serializeJSON();
	if (handleFlag == ""){
		frm["flag"]='1';
	}
	auditGrid.opts.url = url   ;
	auditGrid.opts.params = frm;
	auditGrid.load({})         ;
}
function checkSelected(){
	var hadSelected = auditGrid.selectedRows();
	if(hadSelected==null){
		alert("<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />",2);
		return false;
	}else if(hadSelected.length<=0){
		alert("<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />",2);
		return false;
	}else if(hadSelected.length>1){
		alert("<i18n:I18n key="i18n_alert_onlyOneOrder" defaultValue="只能选择一条订单"/>",2);
		return false;
 	}
	return true;
}
function audit(type) {
	if (!checkSelected()) {
		return;
	}
	var rows = auditGrid.selectedRows();
	var targetElsAccount = rows[0].elsAccount;
	var businessType     = rows[0].businessType;
	var businessId = rows[0].businessId;
	var stretegyCode = rows[0].stretegyCode;
	var flowCode = rows[0].flowCode;
	var url = "";
	debugger;
	if (businessType == "purchaseOrder") {
		url = "<%=basePath%>ordermanage/purchaseorder/auditPurchaseOrder.jsp?businessElsAccount=" + targetElsAccount + "&purchaseOrderNumber="   + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "delivery") {
		url = "<%=basePath%>ordermanage/materialVoucher/auditDelivery.jsp?businessElsAccount="    + targetElsAccount + "&materialVoucherNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "saleEnquiry") {
		url = "<%=basePath%>enquirymanage/saleorder/auditQuotedManage.jsp?businessElsAccount="   + targetElsAccount + "&purchaseEnquiryNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "bargainEnquiry") {
		url = "<%=basePath%>enquirymanage/purchase/purchaseBargainAuditManage.jsp?businessElsAccount=" + targetElsAccount + "&purchaseEnquiryNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "standardSupplier") {
		url = "<%=basePath%>supplierstandard/purchase/purchaseSupplyManagerAudit.jsp?businessElsAccount=" + targetElsAccount + "&standardNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "c2fo") {
		var toElsAccount = rows[0].toElsAccount;
		url = "<%=financePath%>c2fo/#/c2fo/audit?businessElsAccount=" + targetElsAccount + "&toElsAccount="+toElsAccount+"&businessId=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "project") {
		url = "<%=basePath%>projectmanage/auditProject.jsp?businessElsAccount=" + targetElsAccount + "&projectNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "designDoc") {
		url = "<%=basePath%>designdoc/auditDesignDoc.jsp?businessElsAccount=" + targetElsAccount + "&designNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "contract") {
		url = "<%=basePath%>contractmanage/purchase/auditPurchaseContract.jsp?businessElsAccount=" + targetElsAccount + "&contractNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}
	var title = "<i18n:I18n key="i18n_label_audit" defaultValue="审批单据" />";
	if (type=="1") {
		title = "<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看单据" />";
		url += "&auditType=done";
	} else {
		url += "&auditType=todo";
	}
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditRecord',
        'windowTitle':title,
         windowSubTitle: "",
        'iframSrc':encodeURI(url),
         windowStatus: 'maximized',
         windowMinWidth: 960,
         windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function flow() {
	if (!checkSelected()) {
		return;
	}
	var rows = auditGrid.selectedRows();
	var targetElsAccount = rows[0].elsAccount;
	var businessType = rows[0].businessType;
	var businessId = rows[0].businessId;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />:',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
}
var currentBusinessId = "";
var currentBusinessElsAccount = "";
var currentBusinessType = "";
function batchAudit(type) { 
	var hadSelected = auditGrid.selectedRows();
	if(hadSelected==null){
		alert("<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />",2);
		return false;
	}else if(hadSelected.length<=0){
		alert("<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />",2);
		return false;
	}
	currentBusinessId = "";
	currentBusinessType = hadSelected[0].businessType;
	currentBusinessElsAccount = hadSelected[0].elsAccount;
	var multiType = false;
	var multiEls = false;
	//判断是否同一类单据
	hadSelected.forEach(function(val){
		if (val.businessType != currentBusinessType) {
			multiType = true;
		}
		if (val.elsAccount != currentBusinessElsAccount) {
			multiEls = true;
		}
		currentBusinessId=currentBusinessId+";"+val.businessId;
	});
	if (multiType) {
		alert("<i18n:I18n key="i18n_alert_selectsametype" defaultValue="请选择同一类型的单据" />",2);
		return;
	}
	if (multiEls) {
		alert("<i18n:I18n key="i18n_alert_selectsameaccount" defaultValue="请选择同一ELS账号的单据" />",2);
		return;
	}
	currentBusinessId = currentBusinessId.substring(1);
	if ("pass" == type) {
		if (currentBusinessType != "purchaseOrder" && currentBusinessType != "c2fo") {
			alert("<i18n:I18n key="i18n_alert_nobatchAudit" defaultValue="此单据不支持批量审批" />",2);
			return;
		}
		$(".fixed-dialog").show();
    	$(".dialog-tip").height(255);
    	$("#btnFileOK1").show();
    	$("#btnFileOK2").hide();
	} else {
		if (currentBusinessType != "purchaseOrder" && currentBusinessType != "c2fo") {
			alert("<i18n:I18n key="i18n_alert_nobatchAudit" defaultValue="此单据不支持批量审批" />",2);
			return;
		}
		$(".fixed-dialog").show();
    	$(".dialog-tip").height(255);
    	$("#btnFileOK1").hide();
    	$("#btnFileOK2").show();
	}
}
function getAudit(elsAccount){
	var param = {"elsAccount":elsAccount};
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="确认要同步到企业库吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/AuditService/getAudit",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
function batchAuditPurchaseOrder(type) {
	var auditOpinion = $("#auditOpinion").val();
	var param = {"purchaseOrderNumber":currentBusinessId,"businessElsAccount":currentBusinessElsAccount,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"auditOpinion":auditOpinion};
	if (type == "noPass") {
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditrefuse" defaultValue="确认要审批拒绝吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/PurchaseOrderService/batchSendPurchaseOrderNoPass",
				type :"post",
				contentType : "application/json",
				data:JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data&&data.statusCode&&data.statusCode != "200") {
						alert(data.message,3);
						return;
					}
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
					query();
					refreshNum();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}});
	} else {
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/PurchaseOrderService/batchSendPurchaseOrderPass",
				type :"post",
				contentType : "application/json",
				data:JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data&&data.statusCode&&data.statusCode != "200") {
						alert(data.message,3);
						return;
					}
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
					query();
					refreshNum();
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
}
function batchAuditC2fo(type) {
	var auditOpinion = $("#auditOpinion").val();
	var param = {"agreementNumber":currentBusinessId,"businessElsAccount":currentBusinessElsAccount,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"auditOpinion":auditOpinion};
	if (type == "noPass") {
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditrefuse" defaultValue="确认要审批拒绝吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=financePath%>rest/C2foService/batchSendNoPass",
				type :"post",
				contentType : "application/json",
				data:JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data&&data.statusCode&&data.statusCode != "200") {
						alert(data.message,3);
						return;
					}
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
	} else {
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=financePath%>rest/C2foService/batchSendPass",
				type :"post",
				contentType : "application/json",
				data:JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data&&data.statusCode&&data.statusCode != "200") {
						alert(data.message,3);
						return;
					}
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
}
function viewRecord(obj) {
	var item = $(obj).parent().parent().parent().data("item");
	var targetElsAccount = item.elsAccount;
	var businessType     = item.businessType;
	var businessId = item.businessId;
	var stretegyCode = item.stretegyCode;
	var flowCode = item.flowCode;
	var url = "";
	debugger;
	if (businessType == "purchaseOrder") {
		url = "<%=basePath%>ordermanage/purchaseorder/auditPurchaseOrder.jsp?businessElsAccount=" + targetElsAccount + "&purchaseOrderNumber="   + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "delivery") {
		url = "<%=basePath%>ordermanage/materialVoucher/auditDelivery.jsp?businessElsAccount="    + targetElsAccount + "&materialVoucherNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "saleEnquiry") {
		url = "<%=basePath%>enquirymanage/saleorder/auditQuotedManage.jsp?businessElsAccount="   + targetElsAccount + "&purchaseEnquiryNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "bargainEnquiry") {
		url = "<%=basePath%>enquirymanage/purchase/purchaseBargainAuditManage.jsp?businessElsAccount=" + targetElsAccount + "&purchaseEnquiryNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "standardSupplier") {
		url = "<%=basePath%>supplierstandard/purchase/purchaseSupplyManagerAudit.jsp?businessElsAccount=" + targetElsAccount + "&standardNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "c2fo") {
		var toElsAccount = rows[0].toElsAccount;
		url = "<%=financePath%>c2fo/#/c2fo/audit?businessElsAccount=" + targetElsAccount + "&toElsAccount="+toElsAccount+"&businessId=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "project") {
		url = "<%=basePath%>projectmanage/auditProject.jsp?businessElsAccount=" + targetElsAccount + "&projectNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "designDoc") {
		url = "<%=basePath%>designdoc/auditDesignDoc.jsp?businessElsAccount=" + targetElsAccount + "&designNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "contract") {
		url = "<%=basePath%>contractmanage/purchase/auditPurchaseContract.jsp?businessElsAccount=" + targetElsAccount + "&contractNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "bidding") {
		url = "<%=basePath%>biddingmanage/purchase/auditBiddingBargain.jsp?businessElsAccount=" + targetElsAccount + "&biddingNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "preBidding") {
		url = "<%=basePath%>biddingmanage/purchase/auditPreBidding.jsp?businessElsAccount=" + targetElsAccount + "&biddingNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}
	var title = "<i18n:I18n key="i18n_label_audit" defaultValue="审批单据" />";
	var type = $("#handleFlag").val();
	if (type=="1") {
		title = "<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看单据" />";
		url += "&auditType=done";
	} else {
		url += "&auditType=todo";
	}
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditRecord',
        'windowTitle':title,
         windowSubTitle: "",
        'iframSrc':encodeURI(url),
         windowStatus: 'maximized',
         windowMinWidth: 960,
         windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function viewFlow(obj) {
	debugger;
	var item = $(obj).parent().parent().parent().data("item");
	var targetElsAccount = item.elsAccount;
	var businessType = item.businessType;
	var businessId = item.businessId;
	var title = '<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程     " />';
	if(businessType=="purchaseOrder"){
		title = title +"  订单号："+businessId;
	}
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
}

//批量页面  @author jiangzhidong @date 20160920
function viewRecordBatch() {
	var auditRows = auditGrid.selectedRows();
	if(auditRows.length==0){
		alert('<i18n:I18n key="test" defaultValue="请选择操作" />',2);
		return;
	}

	if(auditRows.length>0){
		debugger;
		for(var i= 0; i<=auditRows.length-1; i++) {
			if(auditRows[0].businessType != auditRows[i].businessType){
				alert('<i18n:I18n key="test" defaultValue="所选单据不是同一类型!" />',2);
				return;
			}
		}
		var targetElsAccount = auditRows[0].elsAccount;
		var businessType = auditRows[0].businessType;
		var businessId = "";
		var stretegyCode = auditRows[0].stretegyCode;
		var flowCode = auditRows[0].flowCode;
		for(var i= 0; i<=auditRows.length-1; i++) {
			if(businessType == "bargainEnquiry"){
				businessId = businessId+auditRows[i].businessId+";";
			}else{
				businessId = businessId+auditRows[i].businessId+",";
			}
		}
	}else{
		var targetElsAccount = elsAccount;
		var businessType = "purchaseOrder";
		var businessId = "";
		var stretegyCode = "";
		var flowCode = "";
	}
	
	var url = "";
	if (businessType == "purchaseOrder") {
		url = "<%=basePath%>ordermanage/purchaseorder/auditPurchaseOrderBatch.jsp?businessElsAccount=" + targetElsAccount + "&purchaseOrderNumber="   + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "delivery") {
		url = "<%=basePath%>ordermanage/materialVoucher/auditDelivery.jsp?businessElsAccount="    + targetElsAccount + "&materialVoucherNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "saleEnquiry") {
		url = "<%=basePath%>enquirymanage/saleorder/auditQuotedManage.jsp?businessElsAccount="   + targetElsAccount + "&purchaseEnquiryNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "bargainEnquiry") {
		url = "<%=basePath%>enquirymanage/purchase/purchaseBargainAuditManageBatch.jsp?businessElsAccount=" + targetElsAccount + "&purchaseEnquiryNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "standardSupplier") {
		url = "<%=basePath%>supplierstandard/purchase/purchaseSupplyManagerAudit.jsp?businessElsAccount=" + targetElsAccount + "&standardNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "c2fo") {
		var toElsAccount = rows[0].toElsAccount;
		url = "<%=financePath%>c2fo/#/c2fo/audit?businessElsAccount=" + targetElsAccount + "&toElsAccount="+toElsAccount+"&businessId=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "project") {
		url = "<%=basePath%>projectmanage/auditProject.jsp?businessElsAccount=" + targetElsAccount + "&projectNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "designDoc") {
		url = "<%=basePath%>designdoc/auditDesignDoc.jsp?businessElsAccount=" + targetElsAccount + "&designNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}else if (businessType == "contract") {
		url = "<%=basePath%>contractmanage/purchase/auditPurchaseContract.jsp?businessElsAccount=" + targetElsAccount + "&contractNumber=" + businessId + "&stretegyCode="+stretegyCode + "&flowCode=" + flowCode;
	}
	var title = "<i18n:I18n key="i18n_label_audit" defaultValue="审批单据" />";
	var type = $("#handleFlag").val();
	if (type=="1") {
		title = "<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看单据" />";
		url += "&auditType=done";
	} else {
		url += "&auditType=todo";
	}
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditRecord',
        'windowTitle':title,
         windowSubTitle: "",
        'iframSrc':encodeURI(url),
         windowStatus: 'maximized',
         windowMinWidth: 960,
         windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
</script>
</body>
</html>