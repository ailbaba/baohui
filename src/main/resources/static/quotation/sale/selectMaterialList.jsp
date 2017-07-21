<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="confirmBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/SaleMaterialListService/querySaleMaterialList">
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />：</span><input name="materialNumber" type="text"/></div>
            	<button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_quotationheader" defaultValue="报价单头" /></span>
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
var headGrid;
var cols_head=<base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="supplierMatertialListManage"/>;;
$().ready(function(){
	init();
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10));
	});
	$("#queryBtn").click(function(){
		query();
	});
	$("#confirmBtn").click(function(){
		selectMaterial();
	});
});
function selectMaterial() {
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
//     parent.elsDeskTop.defineWin({
//         'iconSrc':'icon/els-icon.png',
//         'windowsId':'PurchaseOrderUpdate',
//         'windowTitle':'选择货源清单',
<%--         'iframSrc':'<%=basePath%>quotation/sale/selectMaterialList.jsp', --%>
//         windowMinWidth: 960,
//         windowMinHeight: 700,
//         'windowWidth':960,
//         'windowHeight':700,
//         'parentPanel':".currDesktop"
//     });
}
function init(){
	var frm = $("#queryForm");
	headGrid = $('#table-head').mmGrid({
        cols: cols_head,
        url : frm[0].action,
        params: frm.serializeJSON(),
        method:  frm[0].method,
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:"200px",
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
                , limitList: [10,20]
            })
        ]
    });
}
function query() {
	var frm = $("#queryForm");
	headGrid.opts.params = frm.serializeJSON();
	headGrid.load({});
}
</script>
</body>
</html>