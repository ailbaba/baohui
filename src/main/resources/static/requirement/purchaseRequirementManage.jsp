<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative ">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            	<button id="erpBtn" class="button-wrap">从ERP获取</button>
            	<button id="addBtn" class="button-wrap"><i18n:I18n key="i18n_button_create" defaultValue="新建" /></button>
                <button id="modifyBtn" class="button-wrap"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/PurchaseRequirementService/findPurchaseRequirement">
            	<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount}"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount" value="${elsSubAccount}"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span>需求单号：</span><input name="requirementNumber" type="text"/></div>
           		<div class="dis-in-b input-and-tip"><span>供应商ELS号: </span><input type="text" name="toElsAccount"/></div>
            	<div class="dis-in-b input-and-tip"><span>采购工厂: </span><input type="text" name="puchaseFactory"/></div>
            	<div class="dis-in-b input-and-tip"><span>采购方负责人: </span><input type="text" name="purchaseInCharge"/></div>
            	<div class="dis-in-b input-and-tip"><span>销售工厂: </span><input type="text" name="saleFactory"/></div>
            	<div class="dis-in-b input-and-tip"><span>销售方负责人: </span><input type="text" name="saleInCharge"/></div>
            	<div class="dis-in-b input-and-tip"><span>计划期间从: </span><input type="text" class="Wdate" onfocus="WdatePicker()" name="planDateStart"/></div>
            	<div class="dis-in-b input-and-tip"><span>到: </span><input type="text" class="Wdate" onfocus="WdatePicker()" name="planDateEnd"/></div>
            	<div class="dis-in-b input-and-tip"><span>期间类型: </span>
            		<select id='dateType' name='dateType'><option value="">全部</option><option value='D'>天</option><option value='W'>周</option><option value='M'>月</option></select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span>发布时间: </span><input type="text" class="Wdate" onfocus="WdatePicker()" name="publishDate"/></div>
            	<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">需求单</span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>

<!--         <div class="box-wrap pos-relative bg-common"> -->
<%--             <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_quotationitem" defaultValue="报价单行项目" /></span> --%>
<!--             <div class="common-box-line"> -->
<!--                 <div class="tab-wrap" id="sheet-project"> -->
<!--                     <ul> -->
<%--                         <li><a href="#sheet-project-one"><i18n:I18n key="i18n_lable_quotationitem" defaultValue="报价单行项目" /></a></li> --%>
<%--                         <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li> --%>
<!--                     </ul> -->
<!--                     <div id="sheet-project-one"> -->
<%--                     	<button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
<!--                         <main class="grid-container"> -->
<!-- 		                    <div class="grid-100"> -->
<!-- 		                        <table id="table-item"></table> -->
<!-- 		                    </div> -->
<!-- 		                </main> -->
<!--                     </div> -->
<!--                     <div id="sheet-project-two"> -->
<!--                         <main class="grid-container"> -->
<!-- 		                    <div class="grid-100"> -->
<!-- 		                        <table id="table-file"></table> -->
<!-- 		                    </div> -->
<!-- 		                </main> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->

    </div>
<script type="text/javascript">
var headGrid;
var itemGrid;
// var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleQuotationManageHeader"/>;
var cols_head = [{title:"需求单号",name:"requirementNumber",align:"center",width:98},
                 {title:"供应商ELS号",name:"toElsAccount",align:"center",width:98},
                 {title:"供应商名称",name:"companyShortName",align:"center",width:150},
                 {title:"计划期间从",name:"planDateStart",align:"center",width:150,renderer : function(val) {
  	               if (!val)
  	            	   val = "";
  		           else
  			           val = new Date(val).format("yyyy-MM-dd");
  		           return val;
  	             }},
                 {title:"计划期间到",name:"planDateEnd",align:"center",width:150,renderer : function(val) {
    	               if (!val)
      	            	   val = "";
      		           else
      			           val = new Date(val).format("yyyy-MM-dd");
      		           return val;
      	         }},
      	       {title:"期间类型",name:"dateType",align:"center",width:80,renderer : function(val) {
	               if (val=="D") {
	            	   return "天";
	               } else if (val=="W") {
	            	   return "周";
	               } if (val=="M") {
	            	   return "月";
	               } 
  	         }},
                 {title:"采购计划员",name:"purchasePlaner",align:"center",width:98},
                 {title:"采购方负责人",name:"purchaseInCharge",align:"center",width:98},
                 {title:"采购工厂",name:"puchaseFactory",align:"center",width:120},
                 {title:"销售方负责人",name:"saleInCharge",align:"center",width:98},
                 {title:"销售工厂",name:"saleFactory",align:"center",width:120},
                 {title:"发布时间",name:"publishDate",align:"center",width:150,renderer : function(val) {
    	               if (!val)
      	            	   val = "";
      		           else
      			           val = new Date(val).format("yyyy-MM-dd");
      		           return val;
      	         }}];
// var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleQuotationManageItem"/>;
// var cols_item = [{title:"<i18n:I18n key='i18n_quotation_number' defaultValue='报价单号' />",name:"quotationNumber",align:"center",width:98},
// //                 {title:"<i18n:I18n key='i18n_quotation_supplynumber' defaultValue='供货编号' />",name:"supplyNumber",align:"center",width:98},
//                  {title:"<i18n:I18n key='i18n_common_lable_materialnumber' defaultValue='物料编号' />",name:"materialNumber",align:"center",width:98},
//                  {title:"<i18n:I18n key='i18n_common_label_materialdescribe' defaultValue='物料描述' />",name:"materialDesc",align:"center",width:98},
//                  {title:"<i18n:I18n key='i18n_common_title_materialgroup' defaultValue='物料组' />",name:"materialGroup",align:"center",width:98},
//                  {title:"<i18n:I18n key='i18n_quotation_purchaseels' defaultValue='采购商ELS号' />",name:"elsAccount",align:"center",width:98},
//                  {title:"<i18n:I18n key='i18n_purchaser' defaultValue='采购商' />",name:"companyShortName",align:"center",width:168},
//                  {title:"<i18n:I18n key='i18n_quotation_saleels' defaultValue='供应商ELS号' />",name:"toElsAccount",align:"center",width:98},
//                  {title:"<i18n:I18n key='i18n_enquiry_label_supplier' defaultValue='供应商' />",name:"toCompanyShortName",align:"center",width:168}
//                  ];

var toElsAccount;
$().ready(function(){
	init();
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10));
	});
	$("#queryBtn").click(function(){
		query();
	});
	$("#addBtn").click(function(){
		addRequirement();
	});
	$("#modifyBtn").click(function(){
		modifyRequirement();
	});
});
function addRequirement() {
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'PurchaseRequirementUpdate',
        'windowTitle':'新建采购需求',
        'iframSrc':'<%=basePath%>requirement/publishPurchaseRequirement.jsp',
        windowMinWidth: 960,
        windowMinHeight: 700,
        windowStatus: 'maximized',
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function modifyRequirement() {
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	if (headGrid.selectedRows().length==0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var requirementNumber = headGrid.selectedRows()[0].requirementNumber;
	var toElsAccount = headGrid.selectedRows()[0].toElsAccount;
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editPurchaseRequirement',
        'windowTitle':'<i18n:I18n key="xx" defaultValue="修改采购需求计划" />',
        'iframSrc':'<%=basePath%>requirement/editPurchaseRequirement.jsp?requirementNumber=' + requirementNumber + "&toElsAccount=" + toElsAccount,
        windowMinWidth: 960,
        windowMinHeight: 700,
        windowStatus: 'maximized',
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function getDate(dates){
	var dd = new Date();
	dd.setDate(dd.getDate()+dates);
	return dd.format("yyyy-MM-dd");
}
function init(){
// 	$("#sheet-project").tabs();
	var frm = $("#queryForm");
	headGrid = $('#table-head').mmGrid({
        cols: cols_head,
        url : frm[0].action,
        params: frm.serializeJSON(),
        method:  frm[0].method,
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
//         height:"200px",
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
	// 加载明细项
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex){
//     	loadItem();
    });
// 	itemGrid = $('#table-item').mmGrid({
//         cols: cols_item,
//         items:[]
// 	});
}
function loadItem() {
	if (headGrid.selectedRows().length==0) {
		if (fileGrid) {
			fileGrid.load([]);
		}
		if (itemGrid) {
			itemGrid.load([]);
		}
		return;
	}
	var param={"elsAccount":elsAccount,"toElsAccount":headGrid.selectedRows()[0].toElsAccount,"quotationNumber":headGrid.selectedRows()[0].quotationNumber}
	var url = "<%=basePath%>rest/PurchaseQuotationService/findMaterialItem";
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(param),
		success : function(data) {
			itemGrid.load(data.rows);
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function query() {
	var frm = $("#queryForm");
// 	if (itemGrid) {
// 		itemGrid.load([]);
// 	}
	headGrid.opts.params = frm.serializeJSON();
	headGrid.load({});
}
</script>
</body>
</html>