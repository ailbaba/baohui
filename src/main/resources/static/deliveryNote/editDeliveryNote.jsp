<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
			<button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
				<button class="button-wrap" id="saveBtn"><i18n:I18n key=" "
						defaultValue="保存" /></button>
				<%-- 				<button id="deliveryFlowBtn" class="button-wrap"><i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" /></button> --%>
				<button class="button-wrap" id="sendBtn"><i18n:I18n key=" "
						defaultValue="发送" /></button>
				<button class="button-wrap" id="exit"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<form id = "form" onsubmit="return false;">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key=" " defaultValue="送货通知抬头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<div class="grid-container">
							<div class="grid-100" id="deliveryNoteHeaderGrid">
								<table id="deliveryNoteHeaderTable"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key=" " defaultValue="通知单行项目" /></span>
		<br>
		<button id="itemcolumnDefineBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="行信息列自定义" /></button>
		 
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<div id="sheet-project-one">
						<div class="grid-container">
						 <div class="common-box-line">
                         		<!-- <strong>批量设置:</strong> -->
								<button id="acceptBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="接受" /></button>
								<button id="refuseBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="拒绝" /></button>
								<button id="againBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="重报" /></button>
			             </div>
							<div class="grid-100" id="deliveryNoteItemGrid">
								<table id="deliveryNoteItemTable"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
	</div>
	<script type="text/javascript">
	var deliveryNoteNo =<%=request.getParameter("deliveryNoteNo")%>;
	var elsAccount = <%=request.getParameter("elsAccount")%>;
	var headGrid;
	var itemGrid;
	var sendStatus;
	var pageData;
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="createDeliveryNote_head"/>;
	var cols_item =<base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="createDeliveryNote_item_mt"/>;
// 	var cols_item = [
// 	{title:"行号", name:'lineNo', width: 7*14, align: 'center'},
// 	{title:"ELS号", name:'elsAccount', width: 7*14, align: 'center'},
// 	{title:"对方ELS号", name:'toElsAccount', width: 7*14, align: 'center'},
// 	{title:"送货通知单号", name:'deliveryNoteNo', width: 7*14, align: 'center'},
// 	{title:"采购方物料编号", name:'purchaseMaterialNumber', width: 11*14, align: 'center'},
// 	{title:"采购方物料描述", name:'purchaseMaterialDesc', width: 11*14, align: 'center'},
// 	{title:"采购方物料规格", name:'purchaseMaterialSpec', width: 11*14, align: 'center'},
// 	{title:"采购方物料属性1", name:'purchaseMaterialAttr1', width: 11*14, align: 'center'},
// 	{title:"采购方物料属性2", name:'purchaseMaterialAttr2', width: 11*14, align: 'center'},
// 	{title:"采购方物料属性3", name:'purchaseMaterialAttr3', width: 11*14, align: 'center'},
// 	{title:"采购方物料属性4", name:'purchaseMaterialAttr4', width: 11*14, align: 'center'},
// 	{title:"采购方物料属性5", name:'purchaseMaterialAttr5', width: 11*14, align: 'center'},
// 	{title:"采购方订单单位", name:'purchaseOrderUnitPrice', width: 11*14, align: 'center'},
// 	{title:"销售方物料编号", name:'saleMaterialNumber', width: 11*14, align: 'center'},
// 	{title:"销售方物料描述", name:'saleMaterialDesc', width: 11*14, align: 'center'},
// 	{title:"销售方物料规格", name:'saleMaterialPesc', width: 11*14, align: 'center'},
// 	{title:"销售方物料属性1", name:'saleMaterialAttr1', width: 11*14, align: 'center'},
// 	{title:"销售方物料属性2", name:'saleMaterialAttr2', width: 11*14, align: 'center'},
// 	{title:"销售方物料属性3", name:'saleMaterialAttr3', width: 11*14, align: 'center'},
// 	{title:"销售方物料属性4", name:'saleMaterialAttr4', width: 11*14, align: 'center'},
// 	{title:"销售方物料属性5", name:'saleMaterialAttr5', width: 11*14, align: 'center'},
// 	{title:"销售方订单单位", name:'saleOrderUnitPrice', width: 11*14, align: 'center'},
// 	{title:"采购方需求数量", name:'purchaseMaterialQuantity', width: 7*14, align: 'center',renderer : function(val){return stringInput(val,'Y','deliveryNoteDtailList[][purchaseMaterialQuantity]')}},
// 	{title:"销售方确认数量", name:'saleMaterialQuantity', width: 7*14, align: 'center'},
// 	{title:"采购方工厂", name:'purchaseFactory', width: 7*14, align: 'center'},
// 	{title:"采购方仓库", name:'purchaseWareHouse', width: 7*14, align: 'center'},
// 	{title:"销售方工厂", name:'saleFactory', width: 7*14, align: 'center'},
// 	{title:"销售方仓库", name:'saleWareHouse', width: 7*14, align: 'center'},
// 	{title:"采购订单号", name:'purchaseOrderNumber', width: 7*14, align: 'center'},
// 	{title:"采购订单行", name:'saleGridValue', width: 7*14, align: 'center'},
// 	{title:"采购类型", name:'purchaseType', width: 7*14, align: 'center', renderer : function(val){switch(val!=null&&val!=''?parseInt(val):-1){case 0:val = "标准";	break;case 1:val = "限制";break;case 2:val = "寄售";break;
// 					case 3:val = "分包";break;case 4:val = "未知的商品";break;case 5:val = "第三方";break;case 6:val = "文本";break;case 7:val = "库存转储";break;case 8:val = "商品类目";break;case 9:val = "服务";break ;default:val = "";}return val;}},
// 	{title:"要求交期", name:'deliveryDate', width: 7*14, align: 'center', renderer:function(val){return dateFormat(val,"yyyy-MM-dd")}},
// 	{title:"销售订单号", name:'saleOrderNumber', width: 7*14, align: 'center'},
// 	{title:"销售订单行", name:'saleGridValue', width: 7*14, align: 'center'},
// 	{title:"行状态", name:'status', width: 7*14, align: 'center', renderer:function(val){return dictionaryInputFormat(val,"Y","deliveryNoteDtailList[][status]","0:新建;1:已确认;2:已发货;3:已取消")}},
// 	{title:"发货单号", name:'deliveryNo', width: 7*14, align: 'center'},
// 	{title:"用户", name:'user', width: 7*14, align: 'center'},
// 	{title:"用户名称", name:'username', width: 7*14, align: 'center'},
// 	{title:"更新时间戳", name:'deliveryNoteTime', width: 12*14, align: 'center'}

// ];
		
	$().ready(function() {
		initData();
	
		//退出
		$("#exit").click(function(){
			parent.elsDeskTop.closeCurWin((/_(.*)/.exec(frameElement.id)||[])[1],null);
		});

	});
		
	
	function initData(){
		var url = "<%=basePath%>rest/DeliveryNoteService/findDeliveryNote";
		var	params = {"deliveryNoteNo":deliveryNoteNo, "elsAccount":elsAccount};
		$.ajax({
			url : url,
			type: "POST",
			contentType : "application/json",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data)
			{
				if(data != null && data.statusCode == "-100")
				{
					alert(data.message);
				}
				else
				{
					fillData(data);
				}
			},
			error : function(){
				alert("请求出错了",2);
			}
		})
		
	}
	
function fillData(data)
{
	pageData = data;
	var head = new Array();
	head.push(pageData.deliveryNoteHeaderVO);
	var items =  pageData.deliveryNoteDtailList;
	if(!headGrid){
		headGrid= $('#deliveryNoteHeaderTable').mmGrid({
		     cols: cols,
	 	     items : head,
		     loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		     noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		})
		headGrid.on('loadSuccess', function(e, data){
			if(data.sendStatus == "1")
				{
					$("#sendBtn").attr('disabled',"true");
				}
		});
	}
	else{
		headGrid.load(head);
	}
	
	if(!itemGrid){
		itemGrid = $("#deliveryNoteItemTable").mmGrid({
			cols : cols_item,
			items :  items,
			loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		    noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		})
	}
	else{
		itemGrid.load(items)
	}
}

	$("#saveBtn").click(function(){
		debugger;
			var fr = $("#form");
			var formData = fr.serializeJSON();
			pageData =  $.extend(true,{},pageData,formData);
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
					fillData(data);
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="保存成功" />');
				},
				error : function(data) {
					//parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
					
				}
			});
		});
	 //修改
	 $("#updBtn").click(function(){
		 debugger;
	 	    var head = headGrid.selectedRows();
	 	    /* if(isReference(head[0])){
			 	alert('<i18n:I18n key="test" defaultValue="此条例已经被准入引用不能修改!" />',2);
			 	return;
			 } */
// 	 	    if(head.length<=0){
// 	 	    	alert("请选择行信息",2);
// 	 	    	return;
// 	 	    }
			parent.elsDeskTop.defineWin({
		        iconSrc : "icon/icon9.png",
		        windowsId : "deliveryNOteUpd",
		        windowTitle : "<i18n:I18n defaultValue='修改送货通知单' key='test'/>"   + "   " ,
		        iframSrc : "${pageContext.request.contextPath}/deliverNote/updateDeliveryNote.jsp?",
		        showAdv : true,
		        windowMinWidth : 800,
		        windowMinHeight : 300,
		        windowWidth : 800,
		        windowHeight : 500,
		        parentPanel : ".currDesktop"
		    });
		});

	$("#sendBtn").click(function(){
		debugger;
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
	});
	 //头信息列自定义
	$("#headcolumnDefineBtn").click(function(){
			 parent.elsDeskTop.defineWin({
			     'iconSrc':'icon/els-icon.png',
			     'windowsId':'subAccountColumnSetting',
			     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="头信息列自定义" />',
			     windowSubTitle: "",
			     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=createDeliveryNote_head" + "&window=iframeApp_mt_urchase_supply_header",
			     windowMinWidth: 480,
			     windowMinHeight: 600,
			     'windowWidth':480,
			     'windowHeight':600,
			     'parentPanel':".currDesktop"
			  });
	 });
	
	 //行信息列自定义
	$("#itemcolumnDefineBtn").click(function(){
			 parent.elsDeskTop.defineWin({
			     'iconSrc':'icon/els-icon.png',
			     'windowsId':'subAccountColumnSetting',
			     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="行信息列自定义" />',
			     windowSubTitle: "",
			     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=createDeliveryNote_item_mt" + "&window=iframeApp_mt_purchase_supply_item",
			     windowMinWidth: 480,
			     windowMinHeight: 600,
			     'windowWidth':480,
			     'windowHeight':600,
			     'parentPanel':".currDesktop"
			  });
	 });
	 
	//行表操作
	var initPriceSelected = function(val,item,index) {
		if(!val) {
			var name = this.name+"_"+index;
			var id0 = name+"_0";
			var id1 = name+"_1";
			var id2 = name+"_2";
			var checked0 = '';
			var checked1 = '';
			var checked2 = '';
			if(item.orderStatus==3 || (item.orderStatus==7&&item.auditStatus==0)) checked0 = checked0 + ' checked="checked"';
			if(item.orderStatus==6) checked1 = checked1 + ' checked="checked"';
			if(item.orderStatus==4) checked2 = checked2 + ' checked="checked"';
			var selected = '<div style="text-align:left;min-width: 160px; margin:0 auto;style="position: absolute;"">'
							+'<input type="radio" name="'+name+'" id="'+id0+'" '+checked0+' style="width: 14px !important; display:inline-block; margin-left:5px !important;" />'
							+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
							+'<label style="display:inline-block; margin-left:22px; font-size:12px;">接受</label>'
							+'<input type="radio" name="'+name+'" id="'+id1+'" '+checked1+' style="width: 14px !important; margin-left: 55px !important;display:inline-block;" />'
							+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
							+'<label style="display:inline-block; margin-left:25px; font-size:12px;">拒绝</label>'
							+'<input type="radio" name="'+name+'" id="'+id2+'" '+checked2+' style="width: 14px !important; margin-left: 105px !important;display:inline-block;" />'
							+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
							+'<label style="display:inline-block; margin-left:27px; font-size:12px;">重报</label>'
							+'</div>';
			return selected;
		}
	};
	
	</script>
</body>
</html>