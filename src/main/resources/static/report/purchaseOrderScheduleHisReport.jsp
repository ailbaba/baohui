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
				         <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_label_trackNumber" defaultValue="跟踪号" />： </span>
				         <input type="text" name="trackNumber"/>
				    </div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_materialRelation_title_saleName" defaultValue="销售方名称" />： </span>
						<input type="text" id="fullName" name="fullName" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="xxx" defaultValue="采购方ELS号" />： </span>
						<input type="text" id="purchaseElsAccount" name="purchaseElsAccount" value="${elsAccount}"/>
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="xxx" defaultValue="采购方名称" />： </span>
						<input type="text" id="companyName" name="companyName" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单" />：</span>
						<input id="purchaseOrderNumber" name="purchaseOrderNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_responserofpurchase" defaultValue="采购方负责人" />： </span>
						<input type="text" id="fbk4" name="fbk4" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_label_factory" defaultValue="工厂" />： </span>
						<input type="text" id="factory" name="factory" />
					</div>
					<br>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_orderdate" defaultValue="订单日期" />：</span>
					</div>
					<div class="dis-in-b input-and-tip">
						<input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span>
						<input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate" />
					</div>
					<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                    <button id="downloadBtn" class="button-wrap"><i18n:I18n key="i18n_common_lable_exportasexcel" defaultValue="导出到EXCEL" /></button>
					<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_purchase_schedulehisreport" defaultValue="订单进度历史变更记录报表" /></span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100" id="purchaseOrderScheduleReportGrid">
					<table id="purchaseOrderScheduleReportTable"></table>
					<div id="pg" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>
		</form>
	</div>
	<script type="text/javascript">
	
	var height=$(document).height()-212;
	$("#elsAccount").val(elsAccount);
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseOrderScheduleHisReport"/>;
	function installTable(){
		$('#purchaseOrderScheduleReportGrid').html('<table id="purchaseOrderScheduleReportTable"></table><div id="pg" style="text-align: right;"></div>');
		//本地示例
	     var headGrid= $('#purchaseOrderScheduleReportTable').mmGrid({
	    	 cols: cols,
	         url: "<%=basePath%>rest/PurchaseOrderService/findPurchaseOrderScheduleHisList",
	         params:$("#queryForm").serializeJSON(),
	         method:'post',
	         root:"rows",
	         loadingText: '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>',
	 		noDataText: '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>',
	         height:height,
	         remoteSort:true,
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
	             })
	         ]
	    });
		    headGrid.on('loadSuccess',function(e, data) {
		    	if (data.rows && data.rows.length > 0) {
					//高亮
			        $('#purchaseOrderScheduleReportTable').find("tr").each(function(){
			        	var item = $(this).data("item");
			        	var curr = new Date();
			        	var daoPaiEndDate = new Date(item.daoPaiEndDate);
			        	if(item.saleFactFinishTime && item.saleFactFinishTime != ""){
				        	var saleFactFinishDate = new Date(item.saleFactFinishTime);
					        if (saleFactFinishDate > daoPaiEndDate) {
					        	$(this).css("background-color","rgba(213, 58, 58, 0.0980392)");
					        }
			        	}else{
			        		daoPaiEndDate.setDate(daoPaiEndDate.getDate() - item.warningDays);
			        		if(curr >= daoPaiEndDate){
			        			$(this).css("background","yellow");
			        		}
			        	}
				   });
		    	}
			});
	}
	
	installTable();
	
	$("#queryBtn").click(function(){
		installTable();
	});
	
	$("#columnDefineBtn").click(function(){
		 $("#columnDefineBtn").click(function(){
		     parent.elsDeskTop.defineWin({
		    	    'iconSrc':'icon/els-icon.png',
		    	    'windowsId':'subAccountColumnSetting',
		    	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		    	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseOrderScheduleHisReport" + "&window=iframeApp_purchaseOrderScheduleHisReport",
		    	    windowMinWidth  : 480,
		    	    windowMinHeight : 600,
		    	    'windowWidth'   : 480,
		    	    'windowHeight'  : 600,
		    	    'parentPanel'   :".currDesktop"
		     });
		 });
	});
	
	function renderPurchaseType(val,item) {
		if(val == '0')
			return "<i18n:I18n key='i18n_common_select_procurementtype_standard' defaultValue='标准' />";
		else if(val == '1')
			return "<i18n:I18n key='i18n_common_select_procurementtype_restrict' defaultValue='限制' />";
		else if(val == '2')
			return "<i18n:I18n key='i18n_common_select_procurementtype_consignment' defaultValue='寄售' />";
		else if(val == '3')
			return "<i18n:I18n key='i18n_common_select_procurementtype_subcontract' defaultValue='分包' />";
		else if(val == '4')
			return "<i18n:I18n key='i18n_common_select_procurementtype_anunknowncommodity' defaultValue='未知的商品' />";
		else if(val == '5')
			return "<i18n:I18n key='i18n_common_select_procurementtype_thirdparty' defaultValue='第三方' />";
		else if(val == '6')
			return "<i18n:I18n key='i18n_common_select_procurementtype_text' defaultValue='文本' />";
		else if(val == '7')
			return "<i18n:I18n key='i18n_common_select_procurementtype_stocktransfer' defaultValue='库存转储' />";
		else if(val == '8')
			return "<i18n:I18n key='i18n_common_select_procurementtype_commoditytype' defaultValue='商品类目' />";
		else if(val == '9')
			return "<i18n:I18n key='i18n_common_select_procurementtype_service' defaultValue='服务' />";
		else
			return "";	
	}
	
	$("#downloadBtn").click(function(){
		var data = $("#queryForm").serializeJSON();
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/PurchaseOrderService/exportScheduleHisAsExcel",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
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
</script>
</body>
</html>