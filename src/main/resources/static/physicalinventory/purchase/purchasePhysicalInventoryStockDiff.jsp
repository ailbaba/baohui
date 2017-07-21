<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String voucherNumber = request.getParameter("voucherNumber");
%>
<body>
<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
        </div>
    </div>

       <div class="box-wrap pos-relative bg-common">
           <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
           <div class="common-box-line">
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="盘点单号" key=""/>:</span>
				<input type="text" id="voucherNumber" name="voucherNumber" />
			</div>	
            <div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="对方账号/名称" key=""/>:</span>
				<input type="text" id="toElsDesc" name="toElsDesc" />
			</div>	
            <div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="物料号/名称" key=""/>:</span>
				<input type="text" id="purchaseMaterialDesc" name="purchaseMaterialDesc" />
			</div>	
			<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="盘点日期" key=""/>:</span>
				<input type="text" id="planStartDate" name="planStartDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			</div>	
           	<div class="dis-in-b input-and-tip"> 
				<span><i18n:I18n defaultValue="到" key="i18n_common_label_to"/>:</span>
				<input type="text" id="planEndDate" name="planEndDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			</div>

           </div>
       </div>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_projectManagerHead" defaultValue="项目管理头" /></span>
		<div class="common-box-line">
			<main class="grid-container">
				<div class="grid-100" id="headDiv">
					<table id="headTable"></table>
					<div id="headPage" style="text-align: right;"></div>
				</div>
			</main>
		</div>
	</div>
</div>

<script type="text/javascript">
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";
var voucherNumber = "<%=voucherNumber%>";

if("undefined"!=typeof(voucherNumber) && ""!=voucherNumber && "null" != voucherNumber){
	$("#voucherNumber").val(voucherNumber);
}

var renderStockType = function(val,item,rowIndex){
	
	if("undefined"==typeof(val) || "null"==val){
		val = "";
	}
	
	if("K"==val){
		return "寄售";
	} else if("M"==val){
		return "供应商可退回包装";
	} else if("O"==val){
		return "供应商分包库存";
	} else if("E"==val){
		return "现有订单";
	} else if("W"==val){
		return "寄售";
	} else if("V"==val){
		return "客户处可退回包装";
	} else if("C"==val){
		return "客户供应物料";
	} else if("Q"==val){
		return "项目库存";
	} else {
		return val;
	} 
}; 
var renderStockStatus = function(val,item,rowIndex){
	
	if("undefined"==typeof(val) || "null"==val){
		val = "";
	}
	
	if("S"==val){
		return "冻结";
	} else if("X"==val){
		return "质检";
	} else {
		return "非限制";
	} 
}; 

var renderPostTag = function(val,item,rowIndex){
	
	if("undefined"==typeof(val) || "null"==val){
		val = "";
	}
	
	if("1"==val){
		return "√";
	} else {
		return "";
	} 
}; 

var renderSettleTag = function(val,item,rowIndex){
	
	if("undefined"==typeof(val) || "null"==val){
		val = "";
	}
	
	if("1"==val){
		return "√";
	} else {
		return "";
	} 
};

var headCols = [
	{ title:"<i18n:I18n key='i18n_common_title_elsaccount' defaultValue='本方账号' />", name:"elsAccount", width:100, align:"center",hidden:true},
	{ title:"<i18n:I18n key='i18n_common_title_elsDesc' defaultValue='本方名称' />", name:"elsDesc", width:100, align:"center",hidden:true},
	{ title:"<i18n:I18n key='' defaultValue='对方账号' />", name:"toElsAccount", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='对方名称' />", name:"toElsDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='盘点单号' />", name:"voucherNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='行号' />", name:"voucherItemNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方物料号' />", name:"purchaseMaterialNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方物料描述' />", name:"purchaseMaterialDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方物料规格' />", name:"purchaseMaterialSpec", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方物料属性1' />", name:"purchaseMaterialAttr1", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方物料属性2' />", name:"purchaseMaterialAttr2", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方物料属性3' />", name:"purchaseMaterialAttr3", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方物料属性4' />", name:"purchaseMaterialAttr4", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方物料属性5' />", name:"purchaseMaterialAttr5", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方物料号' />", name:"saleMaterialNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方物料描述' />", name:"saleMaterialDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方物料规格' />", name:"saleMaterialSpec", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方物料属性1' />", name:"saleMaterialAttr1", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方物料属性2' />", name:"saleMaterialAttr2", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方物料属性3' />", name:"saleMaterialAttr3", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方物料属性4' />", name:"saleMaterialAttr4", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方物料属性5' />", name:"saleMaterialAttr5", width:100, align:"center"},	
	{ title:"<i18n:I18n key='' defaultValue='库存类型' />", name:"stockType", width:100, align:"center",renderer:renderStockType},
	{ title:"<i18n:I18n key='' defaultValue='库存状态' />", name:"stockStatus", width:100, align:"center",renderer:renderStockStatus},
	{ title:"<i18n:I18n key='' defaultValue='结存数量' />", name:"stockQuantity", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='实盘数量' />", name:"actualQuantity", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='数量差异' />", name:"quantityDiff", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='基本单位' />", name:"basicUnit", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='结算单价' />", name:"unitPrice", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='金额差异' />", name:"amountDiff", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='币别' />", name:"currency", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='差异已记账' />", name:"postTag", width:100, align:"center",renderer:renderPostTag},
	{ title:"<i18n:I18n key='' defaultValue='结算标识' />", name:"settleTag", width:100, align:"center",renderer:renderSettleTag},
	{ title:"<i18n:I18n key='' defaultValue='ERP凭证号' />", name:"erpVoucherNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='ERP凭证行号' />", name:"erpVoucherItemNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购订单号' />", name:"purchaseOrderNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购订单行号' />", name:"purchaseOrderItemNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售订单号' />", name:"saleOrderNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售订单行号' />", name:"saleOrderItemNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方工厂代码' />", name:"purchaseFactory", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方工厂' />", name:"purchaseFactoryDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方库存地代码' />", name:"purchaseStorageLocation", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='采购方库存地' />", name:"purchaseStorageLocationDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方工厂代码' />", name:"saleFactory", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方工厂' />", name:"saleFactoryDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方库存地代码' />", name:"saleStorageLocation", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='销售方库存地' />", name:"saleStorageLocationDesc", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='项目号' />", name:"projectNumber", width:100, align:"center"},
	{ title:"<i18n:I18n key='' defaultValue='项目WBS号' />", name:"projectWBSNumber", width:100, align:"center"}
];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/PhysicalInventoryService/queryPhysicalInventoryStockDiff",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : headCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : true,
	checkCol : true,
	indexCol : false,
	plugins : [
	    $("#headPage").mmPaginator({
	        style : "plain",
	        totalCountName : "total",
	        page : 1,
	        pageParamName : "currentPage",
	        limitParamName : "pageSize",
	        limitLabel : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	        totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	        limit : null,
	        limitList : [10,20]
	    })
	]
});

$(document).ready(function(){
	//初始化控件
	$("button").button();
    refreshData();
});

$("#queryBtn").click(function(){
	refreshData();
});

function refreshData(){
	
	if("undefined"==typeof(toElsAccountparameter) || ""==toElsAccountparameter 
			|| "null" == toElsAccountparameter){
		var toElsAccount = $("#toElsAccount").val();
	} else {
		toElsAccount = toElsAccountparameter;
	}

	var queryParam = {
    	elsAccount : elsAccount,
    	purchaseMaterialDesc : $("#purchaseMaterialDesc").val(),
    	toElsDesc : $("#toElsDesc").val(),
    	planStartDate : $("#planStartDate").val(),
    	planEndDate : $("#planEndDate").val(),
    	voucherNumber : $("#voucherNumber").val()
    };
    $.extend(headGrid.opts.params,queryParam);
    headGrid.load();
} 
</script>
</body>
</html>