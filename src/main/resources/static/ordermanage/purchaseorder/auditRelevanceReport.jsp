<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
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

<style>
.noPass{ background-color: #FFCC22;}
.pass{ background-color: #66FFFF;}
</style>

<script type="text/javascript">

var purchaseOrderNumber = GetQueryString("purchaseOrderNumber");
var headGrid;

$(document).ready(function(){
	
	function rendCompanyShortName(val,item,index){
		if(val){
			return val;
		}else if(item.companyShortNameAuditPass){
			return item.companyShortNameAuditPass;
		}else{
			if(item.toElsAccount){
				return item.toElsAccount;
			}else if(item.toElsAccountAuditPass){
				return item.toElsAccountAuditPass;
			}else{
			    return "";
			}
		}
	}
	
	function rendShowOrHide(val,item,index){
		if(item.materialNumber == item.mrMaterialNumber){
			return "";
		}else{
			return val;
		}
	}
	
	function rendPrice(val){
		if(val&&val!=""){
			var price = new Number(val);
			return price.toFixed(4);
		}else{
			return "";
		}
	}

	var headCols = [
	            	{ title:"<i18n:I18n key='' defaultValue='采购订单号' />", name:"purchaseOrderNumber", width:120, align:"center"},
	            	{ title:"<i18n:I18n key='' defaultValue='物料号' />", name:"materialNumber", width:120, align:"center"},
	            	{ title:"<i18n:I18n key='' defaultValue='物料描述' />", name:"materialDesc", width:150, align:"center"},
	            	{ title:"<i18n:I18n key='' defaultValue='替代料号' />", name:"mrMaterialNumber", width:120, align:"center",renderer:rendShowOrHide},
	            	{ title:"<i18n:I18n key='' defaultValue='替代描述' />", name:"mrMaterialDesc", width:200, align:"center",renderer:rendShowOrHide},
	            	{ title:"<i18n:I18n key='' defaultValue='供应商名称' />", name:"companyShortName", width:100, align:"center",renderer:rendCompanyShortName},
	            	{ title:"<i18n:I18n key='' defaultValue='平均单价(未审核)' />", name:"avgPrice" , width:90, align:"center",setClass:'noPass',renderer:rendPrice},
	            	{ title:"<i18n:I18n key='' defaultValue='金额(未审核)' />", name:"totalAmount", width:90, align:"center",setClass:'noPass'},
	            	{ title:"<i18n:I18n key='' defaultValue='数量(未审核)' />", name:"quantity", width:90, align:"center",setClass:'noPass'},
	            	{ title:"<i18n:I18n key='' defaultValue='订单数(未审核)' />", name:"poQuantity", width:90, align:"center",setClass:'noPass'},
	            	{ title:"<i18n:I18n key='' defaultValue='最早订单日期(未审核)' />", name:"createTime" , width:120, align:"center",setClass:'noPass'},
	            	{ title:"<i18n:I18n key='' defaultValue='最新单价' />", name:"auditOpinion" , width:90, align:"center",renderer:rendPrice},
	            	{ title:"<i18n:I18n key='' defaultValue='最低单价' />", name:"businessCode" , width:90, align:"center",renderer:rendPrice},
	            	{ title:"<i18n:I18n key='' defaultValue='平均单价(已审核)' />", name:"avgPriceAuditPass" , width:90, align:"center",setClass:'pass',renderer:rendPrice},
	            	{ title:"<i18n:I18n key='' defaultValue='金额(已审核)' />", name:"totalAmountAuditPass", width:90, align:"center",setClass:'pass'},
	            	{ title:"<i18n:I18n key='' defaultValue='数量(已审核)' />", name:"quantityAuditPass", width:90, align:"center",setClass:'pass'},
	            	{ title:"<i18n:I18n key='' defaultValue='订单数(已审核)' />", name:"poQuantityAuditPass", width:90, align:"center",setClass:'pass'},
	            	{ title:"<i18n:I18n key='' defaultValue='最早订单日期(已审核)' />", name:"createTimeAuditPass" , width:120, align:"center",setClass:'pass'}
	            ];
	            var h= parseInt($('body').height())-80;
	            headGrid = $("#headTable").mmGrid({
	            	url : "<%=basePath%>rest/MaterialReplaceService/getPOAuditRelevanceReport",
	            	method :  "POST",
	            	height : h,
	            	cols : headCols,
	            	params:{"elsAccount":elsAccount,"purchaseOrderNumber":purchaseOrderNumber},
	            	root : "rows",
	            	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	            	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	            	multiSelect : false,
	            	checkCol : false,
	            	indexCol : true,
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
	            	        limitList : [50,100]
	            	    })
	            	]
	            });
});


</script>
</body>
</html>