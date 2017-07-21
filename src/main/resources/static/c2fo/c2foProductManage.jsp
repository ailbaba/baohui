<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button id="addBtn" class="button-wrap"><i18n:I18n key="i18n_button_create" defaultValue="新建" /></button>
            <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
        </div>
    </div>
<form id="queryForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;" action="<%=basePath%>rest/C2foService/findProduct">
	<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount }"/>
	<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
         <div class="common-box-line">
       		<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_c2foOrderNumber" defaultValue="产品订单号" />：</span><input type="text" name="orderNumber"/></div>
       		<button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
           	<button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
          </div>
     </div>
     <div class="box-wrap pos-relative bg-common">
          <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_purchaseOrder_head" defaultValue="采购订单头" /></span>
          <div class="common-box-line">
          	<main class="grid-container">
                  <div class="grid-100">
                      <table id="table"></table>
                      <div id="pg" style="text-align: right;"></div>
                  </div>
              </main>
       	</div>
	</div>
</form>
<script type="text/javascript">
var grid;
var cols = [
            { title:'产品订单号', name:'orderNumber' ,width:100, align:'center'},
            { title:'总提前支付金额', name:'totalAmount' ,width:100, align:'center'},
            { title:'参考折扣率（年）', name:'discountRateYear' ,width:100, align:'center'},
            { title:'参考折扣率（日）', name:'discountRateDay' ,width:100, align:'center'},
            { title:'最短期限', name:'term' ,width:100, align:'center'},
            { title:'有效截止日', name:'validDate' ,width:100, align:'center'},
            { title:'预期支付日', name:'planPayDate' ,width:100, align:'center'}
        ];

$().ready(function(){
	init();
// 	initFileUploader();
});
function init(){
	var height=$(document).height()-295;
	var frm = $("#queryForm");
	grid = $('#table').mmGrid({
        cols: cols,
        url : frm[0].action,
        params: frm.serializeJSON(),
        method: "POST",
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
	 $("#queryBtn").click(function(){
	    	query();
	    });
	 $("#addBtn").click(function(){
	    	addProduct();
	    });
}
function addProduct() {
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editC2foProduct',
        'windowTitle':'<i18n:I18n key="i18n_title_addC2foProduct" defaultValue="新建C2FO产品" />',
        'iframSrc':'<%=basePath%>c2fo/editC2foProduct.jsp',
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
//获取数据
function query(){
	var frm = $("#queryForm");
	grid.opts.params = frm.serializeJSON();
	grid.load({});
}

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10));
});

</script>
</body>
</html>