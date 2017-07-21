<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative ">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form style="margin:0;" id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/MsgService/findModuleMsg">
            	<input type="hidden" id="toElsAccount" name="toElsAccount" value="${elsAccount }"/>
            	<input type="hidden" id="toElsSubAccount" name="toElsSubAccount" value="${elsSubAccount }"/>
            <div class="common-box-line">
            	<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_moduleName" defaultValue="模块名称" />：</span>
            	<select id="module" name="module"></select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_handleFlag" defaultValue="处理状态" />：</span>
            	<select id="handleFlag" name="handleFlag">
            		<option value="2"><i18n:I18n key="test" defaultValue="全部" /></option>
            		<option value="0"><i18n:I18n key="i18n_label_todo" defaultValue="待处理" /></option>
            		<option value="1"><i18n:I18n key="i18n_label_done" defaultValue="已处理" /></option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_sendELS" defaultValue="发送方ELS号" />：</span><input type="text" name="elsAccount"/></div>
            	<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="test" defaultValue="发送方名称" />：</span><input type="text" name="fromName"/></div>
            	<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_sendELSSubaccount" defaultValue="发送方子账号" />：</span><input type="text" name="elsSubAccount"/></div>
                <br><div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_sendTime" defaultValue="发送时间" />&nbsp;<i18n:I18n key="i18n_label_from" defaultValue="从" />：</span><input type="text" class="Wdate" onfocus="WdatePicker()" name="sendTimeStart"/></div>
                <div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_label_to" defaultValue="到" />：</span><input type="text" class="Wdate" onfocus="WdatePicker()" name="sendTimeEnd"/></div>
            	<button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
           		<button style="margin-left: 9px;" id="batchHandleBtn" class="button-wrap"><i18n:I18n key="i18n_button_batchHandle" defaultValue="转为已处理" /></button>
           		<button style="margin-left: 9px;" id="batchNoHandleBtn" class="button-wrap"><i18n:I18n key="i18n_button_batchNoHandle" defaultValue="转为待处理" /></button>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_msgrecord" defaultValue="消息记录" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
    </div>
<script type="text/javascript">
var module = GetQueryString("module");
var handleFlag=GetQueryString("handleFlag");

if (handleFlag && handleFlag != "") {
		$("#handleFlag").attr("value",handleFlag);
	}
	
var cols = [{title:'<i18n:I18n key="i18n_label_sendELS" defaultValue="发送方ELS号" />', name:'elsAccount', width: 80, align: 'center'},
            {title:'<i18n:I18n key="i18n_label_sendname" defaultValue="发送方名称" />', name:'fromName', width: 150, align: 'center'},
            {title:'<i18n:I18n key="i18n_label_sendELSSubaccount" defaultValue="发送方子账号" />', name:'elsSubAccount', width: 80, align: 'center'},
            {title:'<i18n:I18n key="i18n_label_businessType" defaultValue="单据类型" />', name:'businessType', width: 150, align: 'center',renderer:function(val){
            	if (val == "order") {
            		return "<i18n:I18n key="i18n_label_busniessType_order" defaultValue="订单" />";
            	}if (val == "materialVoucher") {
            		return "<i18n:I18n key="i18n_label_busniessType_materialVoucher" defaultValue="收发货" />";
            	}if (val == "c2fo") {
            		return "<i18n:I18n key="i18n_label_busniessType_c2fo" defaultValue="企利通" />";
            	}if (val == "enquiry") {
            		return "<i18n:I18n key="i18n_label_busniessType_enquiry" defaultValue="询报价" />";
            	}if (val == "additionCost") {
            		return "<i18n:I18n key="i18n_label_busniessType_additionCost" defaultValue="附加费用" />";
            	}if (val == "busrecon") {
            		return "<i18n:I18n key="i18n_label_busniessType_busrecon" defaultValue="业务对账" />";
            	}if (val == "quotation") {
            		return "<i18n:I18n key="i18n_label_busniessType_quotation" defaultValue="供应商自助报价" />";
            	}if (val == "standard") {
            		return "<i18n:I18n key="i18n_label_busniessType_standard" defaultValue="准入单" />";
            	}if (val == "sampleOrder") {
            		return "<i18n:I18n key="i18n_label_busniessType_sampleOrder" defaultValue="样品单" />";
            	}if (val == "inventory") {
            		return "<i18n:I18n key="i18n_label_busniessType_inventory" defaultValue="盘点单" />";
            	}if (val == "contract") {
            		return "<i18n:I18n key="i18n_label_busniessType_contract" defaultValue="合同" />";
            	}if (val == "bargain") {
            		return "<i18n:I18n key="i18n_label_busniessType_bargain" defaultValue="议价单" />";
            	}if (val == "sale") {
            		return "<i18n:I18n key="i18n_label_busniessType_sale" defaultValue="报价单" />";
            	}if (val == "bidding") {
            		return "<i18n:I18n key="i18n_businessType_bidding" defaultValue="招投标" />";
            	}else {
            		return "";
            	}
            }},
            {title:'<i18n:I18n key="i18n_label_businessID" defaultValue="单据号" />', name:'businessID', width: 150, align: 'center'},
            {title:'<i18n:I18n key="i18n_label_sendTime" defaultValue="发送时间" />', name:'sendTime', width: 150, align: 'center',renderer:timeFormat},
            {title:'<i18n:I18n key="i18n_label_handleTime" defaultValue="处理时间" />', name:'handleTime', width: 150, align: 'center',renderer:timeFormat},
            {title:'<i18n:I18n key="i18n_label_msgcontent" defaultValue="消息内容" />', name:'msgContent', width: 350, align: 'center',renderer:function(val,item){
            	if (!item.msgUrl || item.msgUrl == "" || item.msgUrl.indexOf("msgManage.jsp")!=-1) {
            		return val;
            	}
            	return val + "&nbsp;&nbsp;<a href='javascript:void(0)' onclick='openUrl(this)'>【"+"<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看"/>"+"】</a>";
            }},
            {title:'<i18n:I18n key="i18n_label_handleFlag" defaultValue="处理状态" />', name:'handleFlag', width: 150, align: 'center',renderer:function(val){
            	if (val == "0") {
            		return "<i18n:I18n key="i18n_label_todo" defaultValue="待处理" />";
            	} else {
            		return "<i18n:I18n key="i18n_label_done" defaultValue="已处理" />";
            	}
            }},
            ];
var msgGrid;
$().ready(function(){
	$("#queryBtn").click(function(){
		query();
	});
	$("#batchHandleBtn").click(function(){
		handleMsg(1);
	});
	$("#batchNoHandleBtn").click(function(){
		handleMsg(0);
	});
	$.ajax({
		url : "<%=basePath%>rest/MsgService/findMsgModule",
 		type : "get",
 		dataType : "json",
 		success : function(data) {
 			if (data.rows && data.rows.length > 0) {
 				var html = "<option value=''><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>";
 				for (var i=0;i<data.rows.length;i++) {
 					html += "<option value='"+data.rows[i].split(",")[0]+"'>" + data.rows[i].split(",")[1]+"</option>";
 				}
 				$("#module").html(html);
 				if (module && module != "") {
 					$("#module").val(module);
 				}
 				var frm = $("#queryForm");
 				var tableHeight = $(document).height()-190;
 				var pageSizeArr=[];
 				var baseSize =  parseInt(tableHeight/25)>10?(parseInt(tableHeight/25)%10>0?(parseInt(tableHeight/25) + (10-parseInt(tableHeight/25)%10)):parseInt(tableHeight/25)):parseInt(tableHeight/25);
 				pageSizeArr[0]=baseSize;
 				pageSizeArr[1]=baseSize * 2;
 				msgGrid = $('#table-head').mmGrid({
 			        cols: cols,
 			        height:tableHeight,
 			       multiSelect:true,
 			        url : frm[0].action,
 			        params: frm.serializeJSON(),
 			        method:  frm[0].method,
 			        root:"rows",
 			       loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
 			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
 			        checkCol:true,
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
 			                , limitList: pageSizeArr
 			            })
 			        ]
 			    });
 			}
 		},
 		error : function(data) {
 			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
 		}
 	});
});
function handleMsg(handleFlag) {
	var rows = msgGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var msgId = "";
	for (var i = 0;i<rows.length;i++){
		msgId += rows[i].msgId + ","; 
	}
	msgId = msgId.substring(0,msgId.length-1);
	var data = {"msgId":msgId,"handleFlag":handleFlag};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MsgService/batchHandle",
		contentType : "application/json",
		type : "post",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
	 			query();
 		},
 		error : function(data) {
 			parent.elsDeskTop.hideLoading();
 			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
 		}
	});
}
function query(){
	var frm = $("#queryForm");
	msgGrid.opts.params = frm.serializeJSON();
	msgGrid.load({});
}
function openUrl(obj) {
	var data = $(obj).parent().parent().parent().data("item");
	if (!data.msgUrl || data.msgUrl == "") {
		alert("<i18n:I18n key="i18n_label_msgnourl" defaultValue="此消息没有查看地址" />",2);
		return;
	}
	parent.openMsgWindow(data.msgId,data.msgType,data.elsAccount,data.elsSubAccount,data.fromName,data.msgUrl);
}
</script>
</body>
</html>