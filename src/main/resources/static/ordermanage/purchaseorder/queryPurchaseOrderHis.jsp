<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderHis">
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
            	<input type="hidden" id="toElsAccount" name="toElsAccount" value="<%=request.getParameter("toElsAccount")%>"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input name="purchaseOrderNumber" type="text"/></div>
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料号" />： </span><input type="text" name="materialNumber"/></div>
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_lable_changedate" defaultValue="变更日期" />：</span><input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="startOrderDate" name="startOrderDate"/></div>
                <div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span><input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="endOrderDate"/></div>
            	<button style="margin-left: 20px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            	<button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
            	<button style="margin-left: 20px;" id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
            </form>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_lable_result" defaultValue="查询结果" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
<script type="text/javascript">
var itemGrid;
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="queryPurchaseOrderHis"/>;
$().ready(function(){
	init();
});

function init(){
	//初始化控件
    
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
    var frm = $("#queryForm");
    var height = $(document).height()-160;
	if (!itemGrid) {
		 itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        url : frm[0].action,
	        params: frm.serializeJSON(),
	        method:  frm[0].method,
	        height: height,
	        root:"rows",
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
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
	                , limitList: [10,20]
	            })
	        ]
	    });
	}
	
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback());
		} else {
			parent.elsDeskTop.closeCurWin('queryPurchaseOrderHis',closeCallback());
		}
	});
	$("#queryBtn").click(function(){
		query();
	});
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

function closeCallback() {
// 	if (parent.frames["iframeApp_OrderManage"]) {
// 		parent.frames["iframeApp_OrderManage"].query();
// 	}
}
function query() {
	var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#queryForm");
	itemGrid.opts.params = frm.serializeJSON();
	itemGrid.load({});
}
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryPurchaseOrderHis" + "&window=iframeApp_queryPurchaseOrderHis",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
</script>
</body>
</html>