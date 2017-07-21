<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String contractNumber = request.getParameter("contractNumber"); %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style  type="text/css" media="screen" >
html, body {
	height: 100%;
}
body {
	margin  : 0;
	padding : 0;
	overflow: auto;
}
#flashContent {
	display: none;
}
table tbody tr td{
	padding-top   : 1px;
	padding-bottom: 1px;
}
</style>
<body>
<div class="box-wrap pos-relative bg-common">
	<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
	<div class="common-box-line"> <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> </div>
</div>
<div class="box-wrap pos-relative bg-common">
	<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_basicData" defaultValue="基本数据" /></span>
	<div class="common-box-line">
		<div class="tab-wrap" id="sheet-head">
			<div id="sheet-item-one">
				<main class="grid-container">
				<div class="grid-100" id="headTable">
					<table id="headTable"></table>
					<div id="enquiryPage" style="text-align: right;display: inline-block;position: absolute;top: -49px;right: 19px;"></div>
				</div>
				</main>
			</div>
		</div>
	</div>
</div>
<form id="form" onsubmit="return false;">
	<input type="hidden" id="elsAccount"     name="elsAccount"/>
	<input type="hidden" id="elsSubAccount"  name="elsSubAccount"/>
	<input type="hidden" id="toElsAccounts"  name="toElsAccounts"/>
	<input type="hidden" id="toElsDescs"     name="toElsDescs"/>
	<input type="hidden" id="biddingNumber1" name="biddingNumber"/>
	<div class="box-wrap pos-relative bg-common">
	<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_basicData" defaultValue="基本数据" /></span>
	<div class="common-box-line">
	<div class="tab-wrap" id="add-enq-sheet">
	<ul>
		<li><a href="#edit-line-bail"><i18n:I18n key="i18n_common_title_billofmaterials" defaultValue="物料清单" /></a></li>
		<li class="edit-line-content"><a href="#edit-line-content"><i18n:I18n key="i18n_common_title_contractterms" defaultValue="合同条款" /></a></li>
	</ul>
	<!-- 物料清单-->
	<div id="edit-line-bail">
		<div class="box-wrap pos-relative bg-common">
			<table>
			</table>
			<main class="grid-container">
			<div class="grid-100">
				<table id="materialTable"></table>
			</div>
			</main>
		</div>
	</div>
					
	<!-- 合同条款 -->
	<div id="edit-line-content">
		<div class="box-wrap pos-relative bg-common">
			<main class="grid-container">
			<div class="grid-100">
				<table id="contractTable"></table>
			</div>
			</main>
		</div>
	</div>
				
	</div>
	</div>
	</div>
</form>
		
	
<script type="text/javascript">
$( '#add-enq-sheet').tabs();

var elsAccount       = "<%=session.getAttribute("elsAccount")%>"       ;
var companyName      = "<%=session.getAttribute("companyShortName")%>" ;
var contractNumber   = "<%=contractNumber%>" ;

//渲染   @author jiangzhidong 20160307  begin
	//时间
	var formatDateTime = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
		return val;
	};
	//日期
	var formatDate = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};
// 渲染   @author jiangzhidong 20160307  end
   		
var material_item = [{ title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />'        , name:'elsAccount'    , hidden:true, width:100, align: 'center'},
	                 { title:'<i18n:I18n key="i18n_label_toElsAccount" defaultValue="对方els帐号" />'    , name:'toElsAccount'  , hidden:true, width:100, align: 'center'},
	  	             { title:'<i18n:I18n key="i18n_common_title_contractcode" defaultValue="合同编码" />'       , name:'contractNumber'             , width:100, align: 'center'},
	  	             { title:'<i18n:I18n key="i18n_common_title_contracName" defaultValue="合同名称" />'       , name:'contractDesc'               , width:70 , align: 'center'},
	  	             { title:'<i18n:I18n key="i18n_common_lable_contractmaterialitemnumber" defaultValue="合同物料行编号" />' , name:'contractMaterialItemNumber' , width:70 , align: 'center'},
	  		         { title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />'       , name:'materialNumber'             , width:70 , align: 'center'},
	  		         { title:'<i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />'       , name:'materialDesc'               , width:70 , align: 'center'},
	  		         { title:'<i18n:I18n key="i18n_material_pinpai" defaultValue="属性1(品牌)" />'    , name:'attribute1'                 , width:70 , align: 'center'},
	  		         { title:'<i18n:I18n key="i18n_material_color" defaultValue="属性2(颜色)" />'    , name:'attribute2'                 , width:70 , align: 'center'},
	  		         { title:'<i18n:I18n key="i18n_material_long" defaultValue="属性3(长)" />'      , name:'attribute3'                 , width:70 , align: 'center'},
	  		         { title:'<i18n:I18n key="i18n_material_width" defaultValue="属性4(宽)" />'      , name:'attribute4'                 , width:120, align: 'center'},
	  		         { title:'<i18n:I18n key="i18n_material_height" defaultValue="属性5(高)" />'      , name:'attribute5'                 , width:120, align: 'center'},
	  				 { title:'<i18n:I18n key="i18n_common_label_unitofmeasurement" defaultValue="计量单位" />'       , name:'measureUnit'                , width:100, align: 'center'},
	  				 { title:'<i18n:I18n key="i18n_common_label_deliverydate" defaultValue="需求日期" />'       , name:'requireDate'                , width:100 , align: 'center',renderer:formatDate},
	  				 { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_placeOfReceipt" defaultValue="收货地点" />'       , name:'receiptAddr'                , width:100, align: 'center'},
	  				 { title:'<i18n:I18n key="i18n_common_title_paymentTerms" defaultValue="付款条件" />'       , name:'paymentClause'              , width:100, align: 'center'},
	  				 { title:'<i18n:I18n key="i18n_common_title_price" defaultValue="单价" />'           , name:'price'                      , width:100, align: 'center'},
	  				 { title:'<i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />'           , name:'quantity'                   , width:100, align: 'center'},
	  				 { title:'<i18n:I18n key="i18n_common_title_taxRate" defaultValue="税率" />'           , name:'rate'                       , width:150, align: 'center'},
	 				 { title:'<i18n:I18n key="i18n_common_title_amount" defaultValue="金额" />'           , name:'amount'                     , width:100, align: 'center'},
		             { title:'<i18n:I18n key="i18n_common_title_quantity" defaultValue="采购订单数量" />'   , name:'purchaseOrderQuantity'      , width:100, align: 'center'},
		             { title:'<i18n:I18n key="i18n_common_deliveredquantity" defaultValue="已发货数量" />'     , name:'deliveryQuantity'           , width:150, align: 'center'},
	 				 { title:'<i18n:I18n key="i18n_common_title_receivedquantity" defaultValue="已收货数量" />'     , name:'receiveQuantity'            , width:100, align: 'center'},
		             { title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />'         , name:'logtime'         , hidden:true, width:100, align: 'center',renderer:formatDateTime},
		             { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />'           , name:'remark'                     , width:150, align: 'center'}];	  				 

//===========================================合同信息(表单文件)===========================================
var contract_item = [{ title:'<i18n:I18n key="i18n_common_title_contractclausecode" defaultValue="合同条款编码" />'    , name:'contractNumber'            , width: 200,align: 'center'},
                     { title:'<i18n:I18n key="i18n_common_title_contracDescName" defaultValue="合同条款简称" />'    , name:'contractDesc'              , width: 200,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_common_title_contracdetailcontent" defaultValue="合同条款明细内容" />', name:'detailContent'             , width: 300,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />'            , name:'remark'                    , width: 200,align: 'center'}];	
//===========================================合同信息(表单文件)===========================================
var contract_head = [{ title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />'         , name:'elsAccount'          , width: 100,align: 'center'},
                     { title:'<i18n:I18n key="i18n_label_additionCost_accountName" defaultValue="ELS名称" />'         , name:'elsDesc'             , width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_label_toElsAccount" defaultValue="对方els帐号" />'     , name:'toElsAccount'        , width: 100,align: 'center'},
                     { title:'<i18n:I18n key="i18n_label_additionCost_toElsAccountName" defaultValue="对方ELS名称" />'     , name:'toElsDesc'           , width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_common_title_contractcode" defaultValue="合同编码" />'        , name:'contractNumber'      , width: 100,align: 'center'},
                     { title:'<i18n:I18n key="i18n_common_title_contracName" defaultValue="合同名称" />'        , name:'contractDesc'        , width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型编码" />'    , name:'contractTypeCode'    , width: 100,align: 'center'},
                     { title:'<i18n:I18n key="i18n_common_title_contracttypename" defaultValue="合同类型名称" />'    , name:'contractTypeName'    , width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_common_title_contractsigningdate" defaultValue="合同签订日期" />'    , name:'contractSignedDate'  , width: 100,align: 'center',renderer:formatDate},
                     { title:'<i18n:I18n key="i18n_common_title_contractcommencementdate" defaultValue="合同生效日期" />'    , name:'contractStartDate'   , width: 100,align: 'center',renderer:formatDate},
 	                 { title:'<i18n:I18n key="i18n_common_title_contractterminationdate" defaultValue="合同终止日期" />'    , name:'contractEndDate'     , width: 100,align: 'center',renderer:formatDate},
                     { title:'<i18n:I18n key="i18n_common_title_currency" defaultValue="币别" />'            , name:'currency'            , width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_common_title_advancepaymentamount" defaultValue="预付款金额" />'      , name:'paymentAmount'       , width: 100,align: 'center'},
                     { title:'<i18n:I18n key="i18n_common_title_cumulativePaymentAmount" defaultValue="累计付款金额" />'    , name:'totalPaymentAmount'  , width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_common_title_contracttotalamount" defaultValue="合同总金额" />'      , name:'totalContractAmount' , width: 100,align: 'center'},
                     { title:'<i18n:I18n key="i18n_common_title_contractstatus" defaultValue="合同状态" />'        , name:'contractStatus'      , width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_contract_lable_versionNumber" defaultValue="合同版本号" />'      , name:'contractVersion'     , width: 100,align: 'center'},
                     { title:'<i18n:I18n key="i18n_common_title_suppliercontactphone" defaultValue="供应商联系人电话" />', name:'saleContactPhone'    , width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_common_title_purchasecontactphone" defaultValue="采购联系人电话" />'  , name:'purchaseContactPhone', width: 100,align: 'center'},
 	                 { title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />'          , name:'logtime'            , hidden:true , width: 100,align: 'center',renderer:formatDateTime}, 	                 
 	                 { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />'            , name:'remark'              , width: 100,align: 'center'}];
$().ready(function(){
	var GobalparamStr={"elsAccount":elsAccount,"contractNumber":contractNumber};
  	var height=$(document).height()-155;

  	headTable= $('#headTable').mmGrid({
  	    	 		cols: contract_head,
  	         		url: '<%=basePath%>rest/ContractManageService/queryContractManageHeadByCondtion',
  					params : GobalparamStr,
  					method : 'post',
  					root : "rows",
  					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
  			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
  			        multiSelect : false,
  			        checkCol : true,
  			        indexCol : false,
  			     	height: 200,
  					plugins : [ 
 					           $('#enquiryPage').mmPaginator({
 					                style: 'plain'
 					                , totalCountName: 'total'
 					                , page: 1
 					                , pageParamName: 'currentPage'
 					                , limitParamName: 'pageSize'
 					                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
 					                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
 					                , limit: null
 					                , limitList: [10, 30, 40, 50]
 					            })
				]
  	});
  	  
  	headTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
	   	rowIndexSelect=rowIndex;
	   	//loadItem();
	   	//loadMaterialItem();
	});
  	 
  	headTable.on('loadSuccess', function(e, data) {
  		//clauseTable.removeRow();
  		//if (data.total > 0) {
  		//	headTable.select(rowIndexSelect);
  		//	loadMaterialItem();
  		//	loadClause();
  		//} 
  	});	
  	
  	materialTable= $('#materialTable').mmGrid({
	 		cols: material_item,
     		url: '<%=basePath%>rest/ContractManageService/queryContractManageMaterialByCondtion',
			params : GobalparamStr,
			method : 'post',
			root : "rows",
			loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        multiSelect : false,
	        checkCol : true,
	        indexCol : false,
	     	height: 200,
			plugins : [ 
			           $('#enquiryPage').mmPaginator({
			                style: 'plain'
			                , totalCountName: 'total'
			                , page: 1
			                , pageParamName: 'currentPage'
			                , limitParamName: 'pageSize'
			                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
			                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
			                , limit: null
			                , limitList: [10, 30, 40, 50]
			            })
		]
	});
  	
  	contractTable= $('#contractTable').mmGrid({
 		cols: contract_item,
 		url: '<%=basePath%>rest/ContractManageService/queryContractManageClauseByCondtion',
		params : GobalparamStr,
		method : 'post',
		root : "rows",
		loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        multiSelect : false,
        checkCol : true,
        indexCol : false,
     	height: 200,
		plugins : [ 
		           $('#enquiryPage').mmPaginator({
		                style: 'plain'
		                , totalCountName: 'total'
		                , page: 1
		                , pageParamName: 'currentPage'
		                , limitParamName: 'pageSize'
		                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
		                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
		                , limit: null
		                , limitList: [10, 30, 40, 50]
		            })
	]
});  	
  	
  	
});

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('contractManagerDetail');
});

</script>
</body>
</html>