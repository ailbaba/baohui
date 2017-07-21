<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

<%
%>

<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">'<i18n:I18n defaultValue="报价历史纪录" key="i18n_purchase_bargain_itemHistory"></i18n:I18n>'</span>
            <div class="common-box-line">
               <main class="grid-container nest-table">
                    <div class="grid-100">
                        <table id="table-item-his"></table>
                        <div id="pg-price" style="text-align: right;"></div>
                    </div>
               </main>
            </div>
        </div>
    </div>
    
<script>
var toElsAccount = GetQueryString("toElsAccount");
var elsAccount   = GetQueryString("elsAccount");
var purchaseEnquiryNumber = '<%=request.getParameter("purchaseEnquiryNumber")%>';
//  '<i18n:I18n defaultValue="价格有效期从" key="i18n_common_price_effective_begin_date"></i18n:I18n>'   <i18n:I18n defaultValue="价格有效期到" key="i18n_common_price_effective_end_date"></i18n:I18n>
var cols_item_his = [{ title:'<i18n:I18n defaultValue="时间截" key="i18n_label_logtime"></i18n:I18n>' ,  name:'logtime'            ,width:100, align:'center',renderer:function(val){
						if (!val) {val = "";}	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][logtime]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";}},				
			         { title:'<i18n:I18n defaultValue="物料编码" key="i18n_common_title_materialnumber"></i18n:I18n>'     ,  name:'materialNumber'     ,width:100, align:'center'},
			         { title:'<i18n:I18n defaultValue="物料描述" key="i18n_common_title_materialdescribe"></i18n:I18n>'   ,  name:'materialDesc'       ,width:100, align:'center'},
			         { title:'<i18n:I18n defaultValue="税率" key="i18n_common_title_taxRate"></i18n:I18n>'                ,  name:'taxesCode'          ,width:60, align:'center'},
 			         { title:'<i18n:I18n defaultValue="数量从" key="i18n_ladderprice_title_quantity"></i18n:I18n>'        ,  name:'beginQuantity'      ,width:80, align:'center'},
 			         { title:'<i18n:I18n defaultValue="数量到" key="i18n_ladderprice_title_quantityto"></i18n:I18n>'      ,  name:'endQuantity'        ,width:80, align:'center'},
			         { title:'<i18n:I18n defaultValue="单价" key="i18n_common_title_price"></i18n:I18n>'                  ,  name:'price'              ,width:70, align:'center'},
 			         { title:'<i18n:I18n defaultValue="价格有效期从" key="i18n_common_price_effective_begin_date"></i18n:I18n>' ,  name:'priceValidBeginDate' ,width:100, align:'center' ,renderer:function(val){
							if (!val) {val = "";}
							if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
							return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][priceValidBeginDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
						}},				
 			         { title:'<i18n:I18n defaultValue="价格有效期到" key="i18n_common_price_effective_end_date"></i18n:I18n>' ,  name:'priceValidEndDate'   ,width:100, align:'center',renderer:function(val){
							if (!val) {val = "";}
							if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
							return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][priceValidEndDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
						}}		
                    ];

$().ready(function()
{
	init();
});
function init() 
{
	//初始化控件
    //$("#sheet-project").tabs();
    var purchaseRequestNumber = "";
    var purchaseRequestLineProjectNumber = "";
    var materialNumber = "";  
    loadItemhis();
}

function loadItemhis() 
{
	var priceParam = {
	         'elsAccount':elsAccount,
			 'toElsAccount':toElsAccount,
			 'purchaseEnquiryNumber':purchaseEnquiryNumber
			 };
	var itemhisGrid= $('#table-item-his').mmGrid({
	cols: cols_item_his,
	url: "<%=basePath%>rest/SaleEnquiryService/findSeleEnquiryItemsHisList",
	params:priceParam,       
	method:'post',
	root:"rows",
	loadingText : '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>' ,
	noDataText  : '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>' ,
	indexCol: true,
	plugins: [
	$('#pg-price').mmPaginator({
	style: 'plain'
	, totalCountName: 'total'
	, page: 1
	, pageParamName: 'currentPage'
	, limitParamName: 'pageSize'
	, limitLabel: '<i18n:I18n defaultValue="每页{0}条" key="i18n_common_mmgrid_limitlabel"></i18n:I18n>'
	, totalCountLabel: '<i18n:I18n defaultValue="共<span>{0}</span>条记录" key="i18n_common_mmgrid_totalcountlabel"></i18n:I18n>'
	, limit:null
	, limitList: [10,20]
	})
	]
	});
}

</script>
</body>
</html>