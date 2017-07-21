<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap ">
	<form id="queryForm" onsubmit="return false;" method="POST">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<input type="hidden" id="elsAccount" name="elsAccount" />
			<div class="common-box-line">
					<div class="dis-in-b input-and-tip">
						<span  class = "dis-in-b text-right w-72"><i18n:I18n key="i18n_materialRelation_title_purchaseElsAccount" defaultValue="采购商ELS"/>:</span>
						<input type  = "text" id="toElsAccount"  name="toElsAccount" />
					</div> 
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_purchaser" defaultValue="采购商公司名"/>:</span><input
							type="text" id="toFullName"	name="toFullName" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_label_enquirynumber"  defaultValue="询价单号" />:</span><input
							id="purchaseEnquiryNumber"	name="purchaseEnquiryNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_saleorder_title_purchasematerialnumber"  defaultValue="物料号" />:</span><input
							type="text" id="materialNumber" name="materialNumber" />
					</div>
					<br>
					<div class="dis-in-b input-and-tip">&nbsp;&nbsp;
						<span><i18n:I18n key="i18n_enquiry_label_enquirydate"    defaultValue="询价日期" />：</span><input  type="text"  id="priceValidBeginDate" name="priceValidBeginDate" class="Wdate" onfocus="WdatePicker()" />
						<span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" />&nbsp;</span><input  type="text" id="priceValidEndDate" name="priceValidEndDate" class="Wdate" onfocus="WdatePicker()" />
					</div>
				
					<div class="dis-in-b input-and-tip">
					    &nbsp;&nbsp;
						<button id="queryBtn"  class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
						<button id="columnDefineBtn"  class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义"/></button>
					</div>						
			</div>			
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_saleEnquiryOrderReport" defaultValue="销售询价单报表"/></span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100" id="saleEnquiryOrderReportGrid">
					<table id="saleEnquiryOrderReportTable"></table>
					<div id="pg" style="text-align:right;"></div>
				</div>
				</main>
			</div>
		</div>
		</form>
	</div>

<script type="text/javascript">
	var height=$(document).height()-212;
	$("#elsAccount").val(elsAccount)  ;
	var frm = $("#queryForm")         ;
	var headGrid                      ; 
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleEnquiryOrderReport"/>;

	$(document).ready(function()
	{
		$('button').button();
		headGrid= $('#saleEnquiryOrderReportTable').mmGrid({
		cols                          : cols          ,
		url                           : "<%=basePath%>rest/SaleEnquiryService/order/findSaleEnquiryOrderReport",
		params                        : $("#queryForm").serializeJSON(),
		method                        : frm[0].method ,
		root                          : "rows"        ,
        loadingText                   : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
        noDataText                    : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
		height                        : height        ,
		remoteSort                    : true          ,
		plugins: [
					$('#pg').mmPaginator({
				      style           : 'plain'
					, totalCountName  : 'total'
					, page            : 1
					, pageParamName   : 'currentPage'
					, limitParamName  : 'pageSize'
					, limitLabel      : '<i18n:I18n key = "i18n_common_mmgrid_limitlabel"  defaultValue="每页{0}条" />'
					, totalCountLabel : '<i18n:I18n key = "i18n_common_mmgrid_totalcountlabel"  defaultValue="共<span>{0}</span>条记录" />'
					, limit           : null
					, limitList       : [10,20]
					})
				 ]
		});

		$("#columnDefineBtn").click(function()
		{
			parent.elsDeskTop.defineWin({
				'iconSrc'             : 'icon/els-icon.png',
				'windowsId'           : 'subAccountColumnSetting',
				'windowTitle'         : '<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
				 windowSubTitle       : "",
				'iframSrc'            : '<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleEnquiryOrderReport" + "&window=iframeApp_saleEnquiryOrderReport",
			 	 showAdv              : true,
				 advArr               : ['icon/test-car.png','icon/test-car2.png'],
				 windowMinWidth       : 480,
				 windowMinHeight      : 600,
				'windowWidth'         : 480,
				'windowHeight'        : 600,
				'parentPanel'         : ".currDesktop"
			});
		});

		$("#queryBtn").click(function()
		{
	   		var paramStr={"elsAccount":elsAccount,"toElsAccount":$("#toElsAccount").val().trim(),"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val().trim(),"materialNumber":$("#materialNumber").val().trim(),"priceValidBeginDate":$("#priceValidBeginDate").val().trim(),"priceValidEndDate":$("#priceValidEndDate").val().trim()};
	   		//$('#saleEnquiryOrderReportTable').html('<table id="saleEnquiryOrderReportTable"></table><div id="pg" style="text-align:right;"></div>');
	 		headGrid.load(paramStr)   ;
	   		<%-- headGrid= $('#saleEnquiryOrderReportTable').mmGrid({
	 			cols                  : cols,
	 			url                   : "<%=basePath%>rest/SaleEnquiryService/order/findSaleEnquiryOrderReport",
		        params                : paramStr,       
		        method                : 'post',
	 			root                  : "rows",
				loadingText           : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
				noDataText            : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
	 			height                : height,
	 			remoteSort            : true,
	 			plugins               : [
	 				$('#pg').mmPaginator({
	 					         style: 'plain'
	 				  , totalCountName: 'total'
	 				  , page		  : 1
	 				  , pageParamName : 'currentPage'
	 				  , limitParamName: 'pageSize'
					  , limitLabel    : '<i18n:I18n key = "i18n_common_mmgrid_limitlabel"  defaultValue="每页{0}条" />'
					  , totalCountLabel : '<i18n:I18n key = "i18n_common_mmgrid_totalcountlabel"  defaultValue="共<span>{0}</span>条记录" />'
	 				  , limit         : null
	 				  , limitList     : [10,20]
	 				})
	 			]
	 			}); --%>	         
		});
	});
</script>
</body>
</html>