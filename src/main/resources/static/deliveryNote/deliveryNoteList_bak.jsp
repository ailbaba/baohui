<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="SameBtn">
					<i18n:I18n key=" " defaultValue="同步" />
				</button>
				<button class="button-wrap" id="updateBtn">
					<i18n:I18n key=" " defaultValue="详情" />
				</button>
				<button class="button-wrap" id="sendBtn">
					<i18n:I18n key=" " defaultValue="发送" />
				</button>
				<button class="button-wrap" id="exit">
					<i18n:I18n key="i18n_button_exit" defaultValue="退出" />
				</button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<form id="form">
					<input name="elsAccount" type="hidden" value="${elsAccount }" />
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="送货通知单号" />：</span><input
							id="deliveryNoteNo" name="deliveryNoteNo" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="发送状态" />：</span> <select
							id="sendStatus" name="sendStatus">
							<option value="0"><i18n:I18n key=" " defaultValue="未发送" /></option>
							<option value="1" selected><i18n:I18n key=" "
									defaultValue="已发送未接收" /></option>
							<option value="2"><i18n:I18n key=" " defaultValue="待接收" /></option>
							<option value="3"><i18n:I18n key=" " defaultValue="已接收" /></option>
							<option value=""><i18n:I18n key=" " defaultValue="全部" /></option>
						</select>
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="订单状态" />：</span> <select
							id="status" name="status">
							<option value="0"><i18n:I18n key=" " defaultValue="新建" /></option>
							<option value="1"><i18n:I18n key=" "
									defaultValue="对方已确认" /></option>
							<option value="2"><i18n:I18n key=" " defaultValue="已发货" /></option>
							<option value="3"><i18n:I18n key=" " defaultValue="已取消" /></option>
							<option value="2"><i18n:I18n key=" " defaultValue="部分确认" /></option>
							<option value="3"><i18n:I18n key=" " defaultValue="部分发货" /></option>
							<option value="" selected><i18n:I18n key=" "
									defaultValue="全部" /></option>
						</select>
					</div>
					<button class="button-wrap" type="button" style="margin-left: 2%"
						id="seachBtn">
						<i18n:I18n key="i18n_common_button_query" defaultValue="查询" />
					</button>
				</form>
			</div>
		</div>
		<form id="frm" onsubmit="return false;">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
						key=" " defaultValue="送货通知抬头" /></span> <br>
				<button id="headcolumnDefineBtn" class="button-wrap">
					<i18n:I18n key="test" defaultValue="头信息列自定义" />
				</button>
				<div class="common-box-line">
					<div class="tab-wrap" id="sheet-head">
						<div id="sheet-item-one">
							<div class="grid-container">
								<div class="grid-100" id="deliveryNoteHeaderGrid">
									<table id="deliveryNoteHeaderTable"></table>
									<div id="pg" style="text-align: right;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
						key=" " defaultValue="通知单行项目" /></span> <br>
				<button id="itemcolumnDefineBtn" class="button-wrap">
					<i18n:I18n key="test" defaultValue="行信息列自定义" />
				</button>
				<div class="common-box-line">
					<div class="tab-wrap" id="sheet-project">
						<div id="sheet-project-one">
							<div class="grid-container">
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
	var deliveryNoteNo;
	var headGrid;
	var itemGrid;
	var sendStatus;
	var pageData;
	
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="createDeliveryNote_head"/>;
	var cols_item =<base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="createDeliveryNote_item_mt"/>;
// 	 var cols_item = [
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
// 	{title:"采购方需求数量", name:'purchaseMaterialQuantity', width: 7*14, align: 'center'},
// 	{title:"销售方确认数量", name:'saleMaterialQuantity', width: 7*14, align: 'center'},
// 	{title:"采购方工厂", name:'purchaseFactory', width: 7*14, align: 'center'},
// 	{title:"采购方仓库", name:'purchaseWareHouse', width: 7*14, align: 'center'},
// 	{title:"销售方工厂", name:'saleFactory', width: 7*14, align: 'center'},
// 	{title:"销售方仓库", name:'saleWareHouse', width: 7*14, align: 'center'},
// 	{title:"采购订单号", name:'purchaseOrderNumber', width: 7*14, align: 'center'},
// 	{title:"采购订单行", name:'purchaseGridValue', width: 7*14, align: 'center'},
// 	{title:"采购类型", name:'purchaseType', width: 7*14, align: 'center', renderer : function(val){switch(val!=null&&val!=''?parseInt(val):-1){case 0:val = "标准";	break;case 1:val = "限制";break;case 2:val = "寄售";break;
// 					case 3:val = "分包";break;case 4:val = "未知的商品";break;case 5:val = "第三方";break;case 6:val = "文本";break;case 7:val = "库存转储";break;case 8:val = "商品类目";break;case 9:val = "服务";break ;default:val = "";}return val;}},
// 	{title:"要求交期", name:'deliveryDate', width: 7*14, align: 'center', renderer:function(val){return dateFormat(val,"yyyy-MM-dd")}},
// 	{title:"销售订单号", name:'saleOrderNumber', width: 7*14, align: 'center'},
// 	{title:"销售订单行", name:'saleGridValue', width: 7*14, align: 'center'},
// 	{title:"行状态", name:'status', width: 7*14, align: 'center', renderer:function(val){return dictionaryFormat(val,"0:新建;1:已确认;2:已发货;3:已取消;")}},
// 	{title:"发货单号", name:'deliveryNo', width: 7*14, align: 'center'},
// 	{title:"用户", name:'user', width: 7*14, align: 'center'},
// 	{title:"用户名称", name:'username', width: 7*14, align: 'center'},
// 	{title:"更新时间戳", name:'deliveryNoteTime', width: 12*14, align: 'center'},
// ]; 
	$().ready(function() {
		debugger;
		initData();
		//同步
		$("#SameBtn").click(function(){
			SimpleDeleteDeliveryNote();
		});
		//查询
		$("#seachBtn").click(function(){
				initData();
		});
		
		//详情页面
	$('#updateBtn').click(function(){
			toEditDeliveryNote();
		}); 
		
		//删除
// 		$("#deleteBtn").click(function(){
// 			toDeleteDeliveryNote();
// 		});
		
		//确认接收
// 		$("#receBtn").click(function(){
// 			receDeliveryNote();
// 		});
		
		//退出
		$("#exit").click(function(){
			parent.elsDeskTop.closeCurWin((/_(.*)/.exec(frameElement.id)||[])[1],null);
		});
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
	
	function initData(){
		if(!headGrid){
			headGrid= $('#deliveryNoteHeaderTable').mmGrid({
			     cols: cols,
			     url :"<%=basePath%>rest/DeliveryNoteService/findDeliveryNoteHeader",
		 	     params: $("#form").serializeJSON(),
		 	     method:  "post",
		 	     root:"rows",
			     remoteSort:true,
			     checkCol:true,
			     loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			     noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
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
			
			headGrid.on('loadSuccess',function(e, data) {
				if(!itemGrid){
					itemGrid= $('#deliveryNoteItemTable').mmGrid({
						   cols: cols_item,
						   items:[],
						   remoteSort:true,
						   loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
						   noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
						});
				}
				
			    if(data!=null&&data.statusCode=="-100"){
			    	alert(data.message,2);
			    	return ;
			    }else{
					if(data.total>0){
					    headGrid.select(0);
					    deliveryNoteNo =data.rows[0].deliveryNoteNo;
					    insertDeliveryNoteItemTable(deliveryNoteNo);
					}else{
						headGrid.removeRow();
					    insertDeliveryNoteItemTable(null);
					}
			   	}
			});
			
			headGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
			    deliveryNoteNo=item.deliveryNoteNo;
			    insertDeliveryNoteItemTable(deliveryNoteNo);
			});
		}else{
			headGrid.opts.params = $("#form").serializeJSON();
	 		headGrid.load({});
		}
		
	}
	
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
		
	//插入通知行数据
	function insertDeliveryNoteItemTable(deliveryNoteNo){
		if(deliveryNoteNo==null){
			itemGrid.removeRow();
			return ;
		}
		var paramStr={"elsAccount":elsAccount, "deliveryNoteNo":deliveryNoteNo};
		itemGrid.opts.params = paramStr;
		itemGrid.opts.url="<%=basePath%>rest/DeliveryNoteService/findDeliveryNoteItem";
		itemGrid.load({});
	}
	
	//跳转到修改收货页面
	function toEditDeliveryNote(){
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
		
	   
		if( headGrid.selectedRowsIndex().length<=0){
			alert("<i18n:I18n key=' ' defaultValue='请选择通知单！' />",3);
			return;
		}

		var url= "<%=basePath%>deliveryNote/editDeliveryNote.jsp?deliveryNoteNo="+ deliveryNoteNo + "&elsAccount="+elsAccount;
		
	    var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editBomReceipt',
	        'windowTitle':'<i18n:I18n key="i18n_delivery_windowtitle_queryreceipt" defaultValue="收货单查询" />',
	        'windowSubTitle': companyShortName,
	        'iframSrc':url,
			'windowStatus' : 'maximized',
			'windowMinWidth' : 960,
			'windowMinHeight' : 700,
			'windowWidth' : 960,
			'windowHeight' : 700,
			'parentPanel' : ".currDesktop"
		});
	}
	
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	//同步k3数据
	function SimpleDeleteDeliveryNote(){
		debugger;
		var json={"elsAccount":elsAccount,"toElsAccount":toElsAccount};
		var paramStr = JSON.stringify(json);
		$.ajax({
			url : "<%=basePath%>rest/DeliveryNoteService/simpleDeliveryNote" ,
			contentType : "application/json",
	 		type : "post",
	 		dataType : "json",
	 		data:paramStr,
	 		success : function(data) {
	 			if(data!=null&&data.statusCode=="-100"){
	 				alert(data.message,2);
	 			}else if(data!=null&&data.statusCode=="-200"){
	 				alert(data.message,3);
	 			}else{
	 				alert("<i18n:I18n key="i18n_message_getfromerpsuccess" defaultValue="从ERP获取数据成功" />");
	 				initData();
	 			}
	 		},
	 		error : function(data) {
	 			alert("<i18n:I18n key="i18n_message_getfromerpfailure" defaultValue="从ERP获取数据失败" />",3);
	 		}
	 	});

	}
	
	
	
	function toDeleteDeliveryNote()
	{
		var url= "<%=basePath%>rest/DeliveryNoteService/deleteDeliveryNote";
		var item = headGrid.selectedRows()[0];
		var sendStatus = item.sendStatus;
		var deliveryNoteNo = item.deliveryNoteNo;
		var params = {"deliveryNoteNo" : deliveryNoteNo, "elsAccount" : elsAccount, "sendStatus" : sendStatus};
		if(sendStatus == "0")
		{
			$.ajax({				
				url : url,
				type : "POST",
				contentType : "application/json",
				dataType : "json",
				data : JSON.stringify(params),
				success : function(data){
					if(data != null && data.statusCode == "-100"){
						alert("<i18n:I18n key = '' defaultValue='系统出错无法删除'/>",4);
						return ;
					}
					else if( data!=null && data.statusCode == "200")
					{
						alert("<i18n:I18n key = '' defaultValue= '删成功'/>",5);
						initData();
					}
				},
				error : function(){
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",6);
				}
				
			});
		}
		else
		{
			alert("已经发送的通知单，无法删除！",4);	
		}
	}
	
	$("#sendBtn").click(function(){
		debugger;
		//订单状态
		var items = headGrid.selectedRows();
		var item = items[0];
		var sendStatus = item.sendStatus;
		var deliveryNoteNo = item.deliveryNoteNo;
		if(sendStatus == "1"){
			alert("<i18n:I18n key='' defaultValue='已经发送正在等对方确认'/>");
			return;
		}else if(sendStatus == "0"){
			var headRows = headGrid.selectedRows();
			if(headRows.length != 1){
				alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
				return;
			}
			var url = "<%=basePath%>rest/DeliveryNoteService/sendDeliveryNote";
								$.ajax({
											url : url,
											type : "post",
											contentType : "application/json",
											data : JSON.stringify(headRows[0]),
											dataType : "json",
											success : function(data) {
												fillData(data);
												alert('<i18n:I18n key="" defaultValue="发送成功" />');
											},
											error : function(data) {
												alert(	"<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
											}
										});
							}
		});
	</script>
</body>
</html>