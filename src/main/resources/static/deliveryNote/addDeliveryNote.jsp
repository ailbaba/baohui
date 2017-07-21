<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
  <div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
	    <div>
	    	<button id="saveBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
	    	<button id="sendBtn" class="button-wrap"><i18n:I18n key="" defaultValue="发送" /></button>
	    </div>
    </div>
</div>
<form id="form" onsubmit="return false;">
<input type="hidden" id="deliveryStatus" value="0"/>
<input type="hidden" name="companyShortName" value="<%=session.getAttribute("companyShortName")%>"/>
<!-- <input type="hidden" id="selectedItems" name="selectedItems" value=""/> -->
<input type="hidden" name="elsAccount" value="${elsAccount }"/>
<input type="hidden" name="toElsAccount" value="<%=request.getParameter("toElsAccount")%>"/>
<input type="hidden" name="elsSubAccount" value="${elsSubAccount }"/>
<input type='hidden' name='purchaseInCharge' id="purchaseInChargeParam" />
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="送货通知头" /></span>
	<div class="common-box-line">
		<div class="tab-wrap" id="sheet-head">
			<main class="grid-container">
			<div class="grid-100">
				<table id="table-head"></table>
			</div>
			</main>
		</div>
	</div>
</div>
 <div class="box-wrap pos-relative bg-common">
 <div class="tab-wrap" id="sheet-project">
    <ul>
		<li><a href="#sheet-project-one"><i18n:I18n key="" defaultValue="送货通知行" /></a></li>
	</ul>
	<div id="sheet-project-one">
    <div class="common-box-line">
       <main class="grid-container">
            <div class="grid-100">
                <table id="table-item"></table>
            </div>
        </main>
    </div>
    </div>

</div>
</div>
		
</form>
	
<script type="text/javascript">
	
	//列
 	var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="createDeliveryNote_head"/>;
	var cols = [
	{title:"行号", name:'lineNo', width: 7*14, align: 'center'},
	{title:"ELS号", name:'elsAccount', width: 7*14, align: 'center'},
	{title:"对方ELS号", name:'toElsAccount', width: 7*14, align: 'center'},
	{title:"送货通知单号", name:'deliveryNoteNo', width: 7*14, align: 'center'},
	{title:"采购方物料编号", name:'purchaseMaterialNumber', width: 11*14, align: 'center'},
	{title:"采购方物料描述", name:'purchaseMaterialDesc', width: 11*14, align: 'center'},
	{title:"采购方物料规格", name:'purchaseMaterialSpec', width: 11*14, align: 'center'},
	{title:"采购方物料属性1", name:'purchaseMaterialAttr1', width: 11*14, align: 'center'},
	{title:"采购方物料属性2", name:'purchaseMaterialAttr2', width: 11*14, align: 'center'},
	{title:"采购方物料属性3", name:'purchaseMaterialAttr3', width: 11*14, align: 'center'},
	{title:"采购方物料属性4", name:'purchaseMaterialAttr4', width: 11*14, align: 'center'},
	{title:"采购方物料属性5", name:'purchaseMaterialAttr5', width: 11*14, align: 'center'},
	{title:"采购方订单单位", name:'purchaseOrderUnitPrice', width: 11*14, align: 'center'},
	{title:"销售方物料编号", name:'saleMaterialNumber', width: 11*14, align: 'center'},
	{title:"销售方物料描述", name:'saleMaterialDesc', width: 11*14, align: 'center'},
	{title:"销售方物料规格", name:'saleMaterialPesc', width: 11*14, align: 'center'},
	{title:"销售方物料属性1", name:'saleMaterialAttr1', width: 11*14, align: 'center'},
	{title:"销售方物料属性2", name:'saleMaterialAttr2', width: 11*14, align: 'center'},
	{title:"销售方物料属性3", name:'saleMaterialAttr3', width: 11*14, align: 'center'},
	{title:"销售方物料属性4", name:'saleMaterialAttr4', width: 11*14, align: 'center'},
	{title:"销售方物料属性5", name:'saleMaterialAttr5', width: 11*14, align: 'center'},
	{title:"销售方订单单位", name:'saleOrderUnitPrice', width: 11*14, align: 'center'},
	{title:"采购方需求数量", name:'purchaseMaterialQuantity', width: 7*14, align: 'center', renderer:function(val){return stringInput(val,"Y","deliveryNoteDtailList[][purchaseMaterialQuantity]")}},
	{title:"销售方确认数量", name:'saleMaterialQuantity', width: 7*14, align: 'center'},
	{title:"采购方工厂", name:'purchaseFactory', width: 7*14, align: 'center'},
	{title:"采购方仓库", name:'purchaseWareHouse', width: 7*14, align: 'center'},
	{title:"销售方工厂", name:'saleFactory', width: 7*14, align: 'center'},
	{title:"销售方仓库", name:'saleWareHouse', width: 7*14, align: 'center'},
	{title:"采购订单号", name:'purchaseOrderNumber', width: 7*14, align: 'center'},
	{title:"采购订单行", name:'saleGridValue', width: 7*14, align: 'center'},
	{title:"采购类型", name:'purchaseType', width: 7*14, align: 'center', renderer : function(val){switch(val!=null&&val!=''?parseInt(val):-1){case 0:val = "标准";	break;case 1:val = "限制";break;case 2:val = "寄售";break;
					case 3:val = "分包";break;case 4:val = "未知的商品";break;case 5:val = "第三方";break;case 6:val = "文本";break;case 7:val = "库存转储";break;case 8:val = "商品类目";break;case 9:val = "服务";break ;default:val = "";}return val;}},
	{title:"要求交期", name:'deliveryDate', width: 7*14, align: 'center', renderer:function(val){return dateFormat(val,"yyyy-MM-dd")}},
	{title:"销售订单号", name:'saleOrderNumber', width: 7*14, align: 'center'},
	{title:"销售订单行", name:'saleGridValue', width: 7*14, align: 'center'},
	{title:"行状态", name:'status', width: 7*14, align: 'center', renderer:function(val){return dictionaryFormat(val,"0:新建;1:已确认;2:已发货;3:已取消;")}},
	{title:"发货单号", name:'deliveryNo', width: 7*14, align: 'center'},
	{title:"用户", name:'user', width: 7*14, align: 'center'},
	{title:"用户名称", name:'username', width: 7*14, align: 'center'},
	{title:"更新时间戳", name:'deliveryNoteTime', width: 12*14, align: 'center'},

];
	
	var itemGrid;
	var headGrid;
	var itemData;
	var height = $(document).height() - 400;
	var itemNumberJson=new Object();
	$().ready(function() {
		init();
	});
	
	var pageData = {};
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	var selectedItems = "<%=request.getParameter("selectedItems")%>";
	var purchaseOrderNumber = "<%=request.getParameter("purchaseOrderNumber")%>";

function init(){
	//初始化控件
    $("#sheet-project").tabs();
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback);
		} else {
			parent.elsDeskTop.closeCurWin("editDelivery",closeCallback);
		}
	});	
	
	query();
	
	$("#saveBtn").click(function(){
		$("#purchaseInChargeParam").val($("#purchaseInCharge").val());
		var frm = $("#form");
		var formData = frm.serializeJSON();
		pageData = $.extend(true,{},pageData,formData);
		var url = "<%=basePath%>rest/DeliveryNoteService/saveDeliveryNote";
		//parent.elsDeskTop.showLoading();
		$.ajax({
			url :url,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(pageData),
			dataType : "json",
			success : function(data) {
				//parent.elsDeskTop.hideLoading();
				if(null != data&&data.statusCode == "-100")
				{
					alert(data.message,3);
					return ;
				}
				pageData = data;
				fillData(data);
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="保存成功" />');
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",4);
				
			}
		});
	});
	$("#sendBtn").click(function(){
		//订单状态
		var sendStatus = headGrid.row(0).sendStatus
		var deliveryNoteNo = headGrid.row(0).deliveryNoteNo
		if(!deliveryNoteNo)
		{
			alert("<i18n:I18n key='' defaultValue = '请先保存在发送'/>");
			return ;
		}
		if(sendStatus == "1")
		{
			alert("<i18n:I18n key='' defaultValue='已经发送正在等对方确认'/>");
			return;
		}
		else if(sendStatus == "0")
		{
			var frm = $("#form");
			var formData = frm.serializeJSON();
			pageData = $.extend(true,{},pageData,formData);
			var url = "<%=basePath%>rest/DeliveryNoteService/sendDeliveryNote";
			$.ajax({
				url :url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(pageData),
				dataType : "json",
				success : function(data) {
					fillData(data);
					alert('<i18n:I18n key="" defaultValue="发送成功" />');
				},
				error : function(data) {
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
					
				}
			});
		}
		else if(sendStaus == "3")
		{
			
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				var frm = $("#form");
				var formData = frm.serializeJSON();
				pageData = $.extend(true,{},pageData,formData);
				var url = "<%=basePath%>rest/DeliveryNoteService/sendDeliveryNote";
				parent.elsDeskTop.showLoading();
				$.ajax({
					url :url,
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(pageData),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
						fillData(data);
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
						
					}
				});
			}});
		}
	});
	
	$('#printBtn').click(function() {
		
		if(!materialVoucherNumber){
			alert("请先保存订单或发送订单！",2);
			return;
		}
		
		//存储打印需要的数据
		var printWin = parent.elsDeskTop.defineWin({
			'iconSrc':'icon/els-icon.png',
			'windowsId':'ePrintTemplatesManager',
			'windowTitle':'<i18n:I18n key="i18n_windowtitle_orderprint" defaultValue="订单打印" />',
			'iframSrc':'<%=basePath%>ePrintTemplatesManager.jsp',
			'windowStatus': 'maximized',
			'windowMinWidth': 960,
			'windowMinHeight': 700,
			'windowWidth':960,
			'windowHeight':700,
			'parentPanel':".currDesktop"
		});
		// 传入打印数据到打印窗口
		// 子窗口 通过loadIframeData 获取数据  onIframeDataLoad监听数据变化

		var fbk1=$("#fbk1").val();
		printWin.setIframeData({
			dataFrom:'editDelivery',
			businessType:'delivery',
			cData:[$.extend(true,itemData,{"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"toElsAccount":toElsAccount,"fbk1":fbk1})],
			tUrlPrefix:"<%=basePath%>rest/MaterialVoucherService/findDeliveryItem",
			tUrlKey:'purchaseOrderNumber'
		});
	});
	
	
	
}//end init()

function query(){
	
		var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"itemIds":selectedItems, "purchaseOrderNumber":purchaseOrderNumber};
		//根据行项目获取信息
		$.ajax({
    		url : "<%=basePath%>rest/DeliveryNoteService/getDeliveryNote",
    		type : "post",
    		contentType : "application/json",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			pageData = data;
    			itemData = data;
    			fillData(data);
    			
    		},
    		error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
    		}
    	});	
}

function fillData(data){
	pageData = data;
	var head = new Array();
	head.push(data.deliveryNoteHeaderVO);
	var items = data.deliveryNoteDtailList;
	if (!headGrid) {
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height:100,
	        items: head,
	        cellSelected:function(){alert("Hello")}
	    });
	} else {
		headGrid.load(head);
	}
	
	if (!itemGrid) {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols,
	        height:height,
	        //multiSelect: true,
            //checkCol: true,
	        items: items
	    });
	} else {
		itemGrid.load(items);
	}
	
}

</script>
</body>
</html>