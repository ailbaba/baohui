<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
    <div class="box-wrap pos-relative bg-common">
    	 <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		 <input type="hidden" name="elsAccount" value="${elsAccount}" />
		 <input type="hidden" name="elsSubAccount" value="${elsSubAccount}" />
		 <input type="hidden" name="saleCompany" value="${companyShortName}" />
         <div class="common-box-line">
         	    <div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchssseordernumber" defaultValue="销售订单号" />：</span>
					<input id="saleOrderNumber" name="saleOrderNumber" type="text" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_lable_materialnuxx" defaultValue="物料编号" />： </span>
					<input type="text" id="materialNumber" name="materialNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_lable_materialnuxx" defaultValue="物料描述" />： </span>
					<input type="text" id="materialDesc" name="materialDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span>
					<input id="purchaseOrderNumber" name="purchaseOrderNumber" type="text" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="采购方ELS" />： </span>
					<input type="text" id="toElsAccount" name="toElsAccount" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="采购方名称" />： </span>
					<input type="text" id="companyShortName" name="companyShortName" />
				</div>
				<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
 			    <button id="downloadBtn" class="button-wrap"><i18n:I18n key="i18n_common_lable_exportasexcel" defaultValue="导出到EXCEL" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
         </div>
     </div>
     </form>
     <div class="box-wrap pos-relative bg-common">
     	   <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_lable_purchaseorxxrreport" defaultValue="销售订单外协库存报表" /></span>
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
var height=$(document).height()-220;
var itemGrid;
var cols = [       { title:'<i18n:I18n key="i18n_common_lable_toElsAccount" defaultValue="销售方ELS号" />', name:'elsAccount' ,width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_xxxt" defaultValue="销售方名称" />', name:'saleCompany' ,width:150, align:'center', renderer:function(val){
         	           return companyShortName; 
                   }},
                   { title:'<i18n:I18n key="i18n_common_lable_elsAccount" defaultValue="采购方ELS号" />', name:'toElsAccount' ,width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_xxxt" defaultValue="采购方名称" />', name:'companyShortName' ,width:150, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_salesOrderNumber" defaultValue="销售订单号" />', name:'saleOrderNumber' ,width:150, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_purchaseOrderNumber" defaultValue="采购订单号" />', name:'purchaseOrderNumber' ,width:150, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_orderItemNumberx" defaultValue="采购订单行号" />', name:'orderItemNumber' ,width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_xxx" defaultValue="类型" />', name:'type' ,width:80, align:'center', renderer:function(val){
         	           var showText = "";
                	   if(val == "0")
                		   showText = "组件";
                	   else
                		   showText = "成品";
                	   return showText; 
                   }},
                   { title:'<i18n:I18n key="i18n_common_lable_xxx" defaultValue="物料编号" />', name:'materialNumber' ,width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_xxx" defaultValue="物料描述" />', name:'materialDesc' ,width:100, align:'center'},
/*                    { title:'<i18n:I18n key="i18n_common_lable_xxx" defaultValue="采购方物料编号" />', name:'purchaseMaterialNumber' ,width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_xxx" defaultValue="采购方物料描述" />', name:'purchaseMaterialDesc' ,width:100, align:'center'}, */
                   
                   { title:'收货工厂', name:'receiptFactory' ,width:100, align:'center'},
                   { title:'收货库存地', name:'receiptInventoryLocation' ,width:100, align:'center'},
                   
                   { title:'收货/入库', name:'rq' ,width:100, align:'center'},
                   { title:'耗用/发货', name:'dq' ,width:100, align:'center'},
                  
                   { title:'结存数量', name:'balanceQuantity' ,width:100, align:'center'},
                   { title:'基本单位', name:'basicUnit' ,width:100, align:'center'}
               ];

$().ready(function(){
	init();
});
function init(){
	initDataGrid();
}
function initDataGrid(){
	itemGrid = $('#table-item').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/SaleOrderService/findSaleBomStocksReport",
        params : $("#form").serializeJSON(),
        method: "POST",
        root: "rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:height,
        checkCol:true,
        plugins: [
 	             $('#pg').mmPaginator({
 	                 style: 'plain'
 	                 , totalCountName: 'total'
 	                 , page: 1
 	                 , pageParamName: 'currentPage'
 	                 , limitParamName: 'pageSize'
 	                	 , limitLabel: '<i18n:I18n defaultValue="每页{0}条" key="i18n_common_mmgrid_limitlabel"></i18n:I18n>'
 	     					, totalCountLabel: '<i18n:I18n defaultValue="共<span>{0}</span>条记录" key="i18n_common_mmgrid_totalcountlabel"></i18n:I18n>'
 	                 , limit:null
 	                 , limitList: [10,20]
 	             })]
    });
}
$("#downloadBtn").click(function(){
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/SaleOrderService/exportBomStocksReportAsExcel",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify($("#form").serializeJSON()),
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
$("#queryBtn").click(function(){
	itemGrid.opts.params = $("#form").serializeJSON();
	itemGrid.load({});
});
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('saleBomStocksReport',null);
});
</script>
</body>
</html>