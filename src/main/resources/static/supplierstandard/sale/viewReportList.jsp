<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<!--         <div class="box-wrap pos-relative bg-common"> -->
<%--         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span> --%>
<!--             <div class="common-box-line"> -->
<%--             	<button style="margin-left: 20px;" id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
<!--             </div>  -->
<!--         </div> -->
        <div class="box-wrap pos-relative bg-common">
        <form id="queryForm" onsubmit="return false;" method="POST" ">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="考核报表" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                    </div>
                </main>
            </div>
        </form>
        </div>
<script type="text/javascript">
var itemGrid;
var cols_item = [
                 {title:'<i18n:I18n key="" defaultValue="日期" />', name:'vaildDate', width: 130, align: 'center', renderer:timeFormat},
                 {title:'<i18n:I18n key="" defaultValue="供应商编码" />', name:'supplierCode', width: 60, align: 'center'},
                 {title:'<i18n:I18n key="" defaultValue="供应商名称" />', name:'supplierName' ,width:190, align:'center'},
                 {title:'<i18n:I18n key="" defaultValue="订单号" />', name:'purchaseOrderNumber' ,width:120, align:'center'},
                 {title:'<i18n:I18n key="" defaultValue="数量" />', name:'quantity' ,width:80, align:'center'},
                 {title:'<i18n:I18n key="" defaultValue="物料编码" />', name:'materialNumber' ,width:110, align:'center'},
                 {title:'<i18n:I18n key="" defaultValue="物料描述" />', name:'materialDesc' ,width:100, align:'center'},
                 {title:'<i18n:I18n key="" defaultValue="检验结果" />', name:'decisionResult', width: 50, align: 'center',},
                 {title:'<i18n:I18n key="" defaultValue="检验人" />', name:'checker' ,width:60, align:'center'},
                 {title:'<i18n:I18n key="" defaultValue="准入单" />', name:'fbk1' ,width:80, align:'center'}
             ];
$().ready(function(){
	init();
});
var elsAccount = "<%=request.getParameter("elsAccount")%>";
var standardNumber = "<%=request.getParameter("standardNumber")%>";
var standardItemNumber = "<%=request.getParameter("standardItemNumber")%>";
var fbk3 = "<%=request.getParameter("fbk3")%>";
function init(){
	//初始化控件
    var height = $(document).height()-50;
    var param = {'elsAccount':elsAccount,'fbk1':standardNumber,'fbk2':standardItemNumber,'fbk3':'1'};
	if (!itemGrid) {
		 itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        url : "<%=basePath%>rest/SupplierStandardService/queryQuanlityReport",
	        method:  "POST",
	        params:param,
	        height: height,
	        root:"rows",
	        indexCol:true,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    });
	}
	
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('auditFlowList');
	});
}
</script>
</body>
</html>