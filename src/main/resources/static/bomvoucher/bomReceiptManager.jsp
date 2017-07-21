<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="updateBtn"><i18n:I18n key="i18n_delivery_button_updatereceipt"
						defaultValue="修改收货" /></button>
				<%-- 				<button id="deliveryFlowBtn" class="button-wrap"><i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" /></button> --%>
				<button class="button-wrap" id="toErpBtn"><i18n:I18n key="i18n_delivery_button_posttosap"
						defaultValue="过账到SAP" /></button>
				<button class="button-wrap" id="exit"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<form id="form">
					<input name="elsAccount" type="hidden" value="${elsAccount }" /> <input
						id="mobileType" name="mobileType" type="hidden" value="511" />
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n
								key="i18n_enquiry_title_purchaseordernumber"
								defaultValue="采购订单号" />：</span><input id="purchaseOrderNumber"
							name="purchaseOrderNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span>供应商名称：</span><input id="saleName" name="saleName"
							type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n
								key="i18n_delivery_lable_materialvouchernumber"
								defaultValue="发货单号" />：</span><input id="materialVoucherNumber"
							name="materialVoucherNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="i18n_delivery_lable_deliveryStatus"
								defaultValue="单据状态" />：</span> <select id="deliveryStatus"
							name="deliveryStatus">
							<option value="0"><i18n:I18n key="i18n_delivery_select_deliveronway" defaultValue="发货在途" /></option>
	                		<option value="2" selected><i18n:I18n key="i18n_delivery_lable_receipt" defaultValue="已收货" /></option>
	                		<option value="3"><i18n:I18n key="i18n_delivery_lable_scene" defaultValue="到货" /></option>
						</select>
					</div>
					<br>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="i18n_delivery_lable_estimatedscene"
								defaultValue="预计到货日期" />：</span><input type="text" class="Wdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							id="startReceiptDate" name="startReceiptDate" /> <span><i18n:I18n
								key="i18n_common_label_to" defaultValue="到" /> </span><input
							type="text" id="endReceiptDate" class="Wdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							name="endReceiptDate" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span>发货日期：</span><input type="text" class="Wdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							id="startDeliveryDate" name="startDeliveryDate" /> <span><i18n:I18n
								key="i18n_common_label_to" defaultValue="到" /> </span><input
							type="text" id="endDeliveryDate" class="Wdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							name="endDeliveryDate" />
					</div>

				</form>
				<button class="button-wrap" id="seachBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_delivery_lable_materialvoucherheader"
					defaultValue="物料凭证抬头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<div class="grid-container">
							<div class="grid-100" id="materialVoucherHeaderGrid">
								<table id="materialVoucherHeaderTable"></table>
								<div id="pg" style="text-align: right;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_delivery_lable_items" defaultValue="行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<div id="sheet-project-one">
						<div class="grid-container">
							<div class="grid-100" id="materialVoucherItemGrid">
								<table id="materialVoucherItemTable"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	var materialVoucherNumber;
	var mobileType="511";
	var headGrid;
	var itemGrid;
	var deliveryStatus;
	var cols=[{ "title": "els号",  "name": "elsAccount",  "align": "center", "width": 100, "sortable": true},
			     { "title": "对方els号",  "name": "toElsAccount",  "align": "center", "width": 100, "sortable": true},
			     { "title": "物料凭证号",  "name": "materialVoucherNumber",  "align": "center", "width": 130, "sortable": true},
			     { "title": "凭证年度",  "name": "voucherYear",  "align": "center", "width": 100, "sortable": true},
			     { "title": "凭证日期",  "name": "voucherDate",  "align": "center", "width": 100, "sortable": true,renderer:function(val){
		        	  if(!val||val==""){ return val="";}
			        	return new Date(val).format('yyyy-MM-dd');
		          }},
		          { "title": "过账日期",  "name": "postDate",  "align": "center", "width": 100, "sortable": true,renderer:function(val){
		        	  if(!val||val==""){ return val="";}
			        	return new Date(val).format('yyyy-MM-dd');
		          }},
		          { "title": "发货状态",  "name": "deliveryStatus",  "align": "center", "width": 100, "sortable": true,renderer:function(val){
			        	 if(!val||val==""){
			        		 return val="";
			        	 } else if(val=="0"){
			        		 return "未收货";
			        	 }else if(val=="1"){
			        		 return "发货在途";
			        	 }else if(val=="2"){
			        		 return "已收货";
			        	 }else if(val=="3"){
			        		 return "到货";
			        	 }
			          }},
		          { "title": "移动类型",  "name": "mobileType",  "align": "center", "width": 100, "sortable": true,renderer:function(val){
		        	 if(!val||val==""){
		        		 return val="收货";
		        	 } else if(val=="511"){
		        		 return "收货";
		        	 }
		          }},
		          { "title": "发货时间",  "name": "deliveryTime",  "align": "center", "width": 100, "sortable": true,renderer:function(val){
		        	  if(!val||val==""){ return val="";}
			        	return new Date(val).format('yyyy-MM-dd');
		          }},
		          { "title": "预计到达时间",  "name": "planArrivalTime",  "align": "center", "width": 100, "sortable": true,renderer:function(val){
		        	  if(!val||val==""){ return val="";}
			        	return new Date(val).format('yyyy-MM-dd');
		          }}];
		       
	var cols_item=[{ "title": "els号",  "name": "elsAccount",  "align": "center", "width": 100, "sortable": true},
			          { "title": "对方els号",  "name": "toElsAccount",  "align": "center", "width": 100, "sortable": true},
			          { "title": "物料凭证号",  "name": "materialVoucherNumber",  "align": "center", "width": 130, "sortable": true},
			          { "title": "物料凭证项",  "name": "materialVoucherItemNumber",  "align": "center", "width": 100, "sortable": true},
			          { "title": "批次",  "name": "orderBatch",  "align": "center", "width": 80, "sortable": true},
			          { "title": "采购物料号",  "name": "purchaseMaterialNumber",  "align": "center", "width": 100, "sortable": true},
			          { "title": "销售物料号",  "name": "saleMaterialNumber",  "align": "center", "width": 100, "sortable": true},
			          { "title": "数量",  "name": "wesbs",  "align": "center", "width": 100, "sortable": true},
			          { "title": "基本单位",  "name": "basicUnit",  "align": "center", "width": 100, "sortable": true},
			          { "title": "采购工厂",  "name": "purchaseFactory",  "align": "center", "width": 100, "sortable": true},
			          { "title": "销售工厂",  "name": "saleFactory",  "align": "center", "width": 100, "sortable": true},
			          { "title": "发货日期",  "name": "deliveryDate",  "align": "center", "width": 100, "sortable": true,renderer:function(val){
			        	  if(!val||val==""){ return val="";}
				        	return new Date(val).format('yyyy-MM-dd');
			          }},
			          { "title": "bom编号",  "name": "reserveNumber",  "align": "center", "width": 100, "sortable": true},
			          { "title": "bom项编",  "name": "reserveItemNumber",  "align": "center", "width": 100, "sortable": true},
			          { "title": "计划行号",  "name": "planItemNumber",  "align": "center", "width": 100, "sortable": true}];
		
	$().ready(function() {
		initData();
		
		//查询
		$("#seachBtn").click(function(){
			initData();
		});
		
		//修改收货
		$('#updateBtn').click(function(){
			toEditBomReceipt();
		});
		
		//退出
		$("#exit").click(function(){
			parent.elsDeskTop.closeCurWin((/_(.*)/.exec(frameElement.id)||[])[1],null);
		});
	});
		
	
	function initData(){
		if(!headGrid){
			headGrid= $('#materialVoucherHeaderTable').mmGrid({
			     cols: cols,
			     url :"<%=basePath%>rest/BomVoucherService/findReceiptBomVoucherHeader",
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
					itemGrid= $('#materialVoucherItemTable').mmGrid({
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
					    materialVoucherNumber=data.rows[0].materialVoucherNumber;
					    deliveryStatus=data.rows[0].deliveryStatus;
					    insertMaterialVoucherItemTable(materialVoucherNumber);
					}else{
						headGrid.removeRow();
					    insertMaterialVoucherItemTable(null);
					}
			   	}
			});
			
			headGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
			    materialVoucherNumber=item.materialVoucherNumber;
			    deliveryStatus=item.deliveryStatus;
			    insertMaterialVoucherItemTable(materialVoucherNumber);
			});
		}else{
			headGrid.opts.params = $("#form").serializeJSON();
	 		headGrid.load({});
		}
		
		
		
		
		
		
		//加载数据
		$.ajax({
				url :"<%=basePath%>rest/BomVoucherService/findReceiptBomVoucherHeader",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify( $("#form").serializeJSON()),
				dataType : "json",
				success : function(data) {
					 if(data!=null&&data.statusCode=="-100"){
					    	alert(data.message,2);
					    	return ;
					    }else{
					    	if(data.total>0){
					    		headGrid.select(0);
					    		headGrid.removeRow();
						    	headGrid.addRow(data.rows);
							    materialVoucherNumber=data.rows[0].materialVoucherNumber;
							    deliveryStatus=data.rows[0].deliveryStatus;
							    insertMaterialVoucherItemTable(materialVoucherNumber);
							}else{
								headGrid.removeRow();
							    insertMaterialVoucherItemTable(null);
							}
					   	}
				},
	    		error : function(data) {
	    			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    		}
			});
	}
		
	//插入凭证项数据
	function insertMaterialVoucherItemTable(materialVoucherNumber){
		if(materialVoucherNumber==null){
			itemGrid.removeRow();
			return ;
		}
		var paramStr={"elsAccount":elsAccount,"mobileType":mobileType,"materialVoucherNumber":materialVoucherNumber};
		itemGrid.opts.params = paramStr;
		itemGrid.opts.url="<%=basePath%>rest/BomVoucherService/findBomVoucherItem";
		itemGrid.load({});
	}
		
	//跳转到修改收货页面
	function toEditBomReceipt(){
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
		
	   
		if( headGrid.selectedRowsIndex().length<=0||materialVoucherNumber==null||materialVoucherNumber==""||materialVoucherNumber==undefined){
			alert("<i18n:I18n key='i18n_delivery_choosereceivevoucher' defaultValue='请选择收货凭证！' />",2);
			return;
		}

		var url="<%=basePath%>bomvoucher/editBomReceipt.jsp?materialVoucherNumber="+ materialVoucherNumber+"&deliveryStatus="+deliveryStatus;
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
	</script>
</body>
</html>