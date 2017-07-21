<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="receiptBtn"><i18n:I18n key="i18n_delivery_button_receipt" defaultValue="收货" /></button>
				<button id="deliveryFlowBtn" class="button-wrap"><i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" /></button>
				<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input id="purchaseOrderNumber" name="purchaseOrderNumber" type="text" />
					<span><i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="发货单号" />：</span><input id="materialVoucherNumber" name="materialVoucherNumber" type="text" />
					<span><i18n:I18n key="i18n_common_title_suppliername" defaultValue="供应商名称" />：</span><input id="companyShortName" name="companyShortName" type="text" />
					<span><i18n:I18n key="i18n_delivery_lable_estimatedscene" defaultValue="预计到货日期" />：</span><input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="startReceiptDate" name="startReceiptDate"/>
                    <span><i18n:I18n key="i18n_common_label_to" defaultValue="到" /></span><input type="text" id="endReceiptDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="endReceiptDate"/>
				    <span><i18n:I18n key="i18n_delivery_lable_deliveryStatus" defaultValue="单据状态" />：</span>
				    <select id="deliveryStatus" name="deliveryStatus">
                		<option value="0"><i18n:I18n key="i18n_delivery_select_deliveronway" defaultValue="发货在途" /></option>
                		<option value="2"><i18n:I18n key="i18n_delivery_lable_receipt" defaultValue="已收货" /></option>
                		<option value="3"><i18n:I18n key="i18n_delivery_lable_scene" defaultValue="到货" /></option>
                	</select>
				</div>
				<div class="dis-in-b input-and-tip">
					<button class="button-wrap" id="seachBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
					<button  id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_materialvoucherheader" defaultValue="物料凭证抬头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="materialVoucherHeaderGrid">
							<table id="materialVoucherHeaderTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_items" defaultValue="行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_title_purchaseOrder_item" defaultValue="采购行项目" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                    </ul>
                    <div id="sheet-project-one">
                    	<button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                        <main class="grid-container">
		                    <div class="grid-100"  id="materialVoucherItemGrid">
		                        <table id="table-item" id="materialVoucherItemTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two">
                       <span><select id="formFileTypeSelector" onchange="loadFormFileByType()">
								  <option value="0"><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
								  <option value="1"><i18n:I18n key="i18n_common_select_bymaterialheader" defaultValue="按凭证头" /></option>
								  <option value="2"><i18n:I18n key="i18n_common_select_bymaterialitem" defaultValue="按凭证行" /></option>
						</select></span>
                        <main class="grid-container">
		                    <div class="grid-100" id="fileGrid">
		                        <table id="fileTable" ></table>
		                    </div>
		                </main>
                    </div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
// 	$(document).ready(function(){
		var toElsAccount=GetQueryString("toElsAccount");
		$("#elsAccount").val(elsAccount);
		$("#sheet-project").tabs({active: 0});
		var materialVoucherNumber="";
		var mobileType="101";
		var fileGrid;
		var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="queryReceipt_head"/>;
		var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="queryReceipt_item"/>;
		var headGrid;
		//将销售订单表头数据插入表格中
		function insertMaterialVoucherHeaderTable(){
			$('#materialVoucherHeaderGrid').html('<table id="materialVoucherHeaderTable"></table><div id="pg" style="text-align: right;"></div>');
	
	        var startReceiptDate = $("#startReceiptDate").val();
	        var endReceiptDate = $("#endReceiptDate").val();
	        var deliveryStatus = $("#deliveryStatus").val();
	        var companyName = $("#companyShortName").val();
	        /* "isQueryDelivery":"1", */
			var paramStr={"companyShortName":companyName,"elsAccount":elsAccount,"startReceiptDate":startReceiptDate,"endReceiptDate":endReceiptDate,"deliveryStatus":deliveryStatus,"mobileType":mobileType,"purchaseOrderNumber":$("#purchaseOrderNumber").val(),"materialVoucherNumber":$("#materialVoucherNumber").val().trim()};

		    //本地示例
		     headGrid= $('#materialVoucherHeaderTable').mmGrid({
		    	 cols: cols,
		         url: "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherHeaderByStatus",
		         params:paramStr,
		         method:'post',
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
		    
		     headGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
		    	materialVoucherNumber=item.materialVoucherNumber;
		    	insertMaterialVoucherItemTable(materialVoucherNumber)
		    	insertDeliveryFile(materialVoucherNumber)
		     });
		    
		     headGrid.on('loadSuccess',function(e, data) {
			    	if(data.total>0){
			    		headGrid.select(0);
			    		materialVoucherNumber=data.rows[0].materialVoucherNumber;
			    		insertMaterialVoucherItemTable(materialVoucherNumber);
			    		insertDeliveryFile(materialVoucherNumber)
			    	}else{
			    		insertMaterialVoucherItemTable(null);
			    		insertDeliveryFile(null);
			    	}
			    });
		}
		
		insertMaterialVoucherHeaderTable();
		
		//点击查询
		$("#seachBtn").click(function(){
			insertMaterialVoucherHeaderTable();
		});
		//将销售订单xiang数据插入表格中
		function insertMaterialVoucherItemTable(materialVoucherNumber){
			$('#materialVoucherItemGrid').html('<table id="materialVoucherItemTable"></table>')
			var paramStr={"elsAccount":elsAccount,"mobileType":mobileType,"materialVoucherNumber":materialVoucherNumber};
			
			if(materialVoucherNumber==null){
				//本地示例
			    $('#materialVoucherItemTable').mmGrid({
			        cols: cols_item,
			        items:[],
			        remoteSort:true,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}else{
				//本地示例
			    $('#materialVoucherItemTable').mmGrid({
			        cols: cols_item,
			        url : "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherItem",
			        params:paramStr,
			        method:'post',
			        root:"rows",
			        remoteSort:true,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}
		    
		}
		$("#deliveryFlowBtn").click(function(){
			if (headGrid.selectedRows().length==0) {
				alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
				return;
			}
			var fbk1=headGrid.selectedRows()[0].fbk1;
			var fbk2=headGrid.selectedRows()[0].fbk2;
			if (fbk1==""||fbk2=="") {
				alert("<i18n:I18n key="i18n_alert_deliveryflowcannotnull" defaultValue="物流商和物流单号不能为空" />",2);
				return;
			}
			pattern =new RegExp("\\((.| )+?\\)","igm");
			var id = fbk1.match(pattern);
			if (!id || id == "") {
				alert("<i18n:I18n key="i18n_alert_deliveryFlownotsupport" defaultValue="该物流商不支持物流跟踪" />",2);
				return;
			}
			id = id[0].substring(1,id[0].length-1);
			fbk2 = fbk2.replace(/\s/g,"");
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'deliveryFlowList',
		        'windowTitle':'<i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" />',
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>ordermanage/materialVoucher/deliveryFlowList.jsp?id=' + id + '&order='+fbk2,
		        windowMinWidth: 520,
		        windowMinHeight: 500,
		        'windowWidth':520,
		        'windowHeight':500,
		        'parentPanel':".currDesktop"
		    });
		});
		 $('#receiptBtn').click(function(){
				//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }

			    if(materialVoucherNumber==null||materialVoucherNumber==""||materialVoucherNumber==undefined){
					alert("<i18n:I18n key='i18n_refund_choosereunditem' defaultValue='请选择收货项' />",2);
					return;
				}
				
			    var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'receiptConfirm',
			        'windowTitle':'<i18n:I18n key="i18n_delivery_windowtitle_querydelivery" defaultValue="发货单查询" />',
			        windowSubTitle: companyShortName,
			        'iframSrc':"<%=basePath%>ordermanage/materialVoucher/receiptConfirm.jsp?materialVoucherNumber="+materialVoucherNumber,
			        windowStatus: 'maximized',
			        windowMinWidth: 960,
			        windowMinHeight: 700,
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop"
			    });
			});
		 
		//退出
			$("#exitBtn").click(function(){
				if (winId) {
					parent.elsDeskTop.closeCurWin(winId,closeCallback());
				} else {
					parent.elsDeskTop.closeCurWin('queryDelivery',closeCallback);
				}
			});
			
			function closeCallback(){}
// 	});



			$("#columnDefineBtn").click(function(){
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'subAccountColumnSetting',
			        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
			        windowSubTitle: "",
			        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryReceipt_head" + "&window=iframeApp_queryDelivery",
			        windowMinWidth: 480,
			        windowMinHeight: 600,
			        'windowWidth':480,
			        'windowHeight':600,
			        'parentPanel':".currDesktop"
			    });
			});

			$("#itemColumnDefineBtn").click(function(){
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'subAccountColumnSetting',
			        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
			        windowSubTitle: "",
			        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryReceipt_item" + "&window=iframeApp_queryDelivery",
			        windowMinWidth: 480,
			        windowMinHeight: 600,
			        'windowWidth':480,
			        'windowHeight':600,
			        'parentPanel':".currDesktop"
			    });
			});
			
			
	function insertDeliveryFile(materialVoucherNumber){
		$('#fileGrid').html('<table id="fileTable"></table>')
		var cols_file = [
		                 {title:'<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" />', name:'filePath', width: 80, align: 'center',renderer:function(val){
		                	 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/downloadServlet?filePath="+ val +"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
		                 }},
		                 {title:'<i18n:I18n key="i18n_common_title_myelsaccount" defaultValue="本方ELS号" />', name:'elsAccount', width: 150, align: 'center'},
		                 { title:'<i18n:I18n key="i18n_label_additionCost_toElsAccount" defaultValue="对方ELS号" />', name:'toElsAccount' ,width:150, align:'center'},
		                 { title:'<i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="物料凭证编号" />', name:'materialVoucherNumber' ,width:180, align:'center'},
		                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'materialVoucherItemNumber' ,width:90, align:'center',renderer:function(val){
			                 	if (val == ""||val== null) {
			                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialheader" defaultValue="凭证头文件" />';
			                	} else{
			                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialitem" defaultValue="凭证项文件" />';
			                	}
			                }},
		                 { title:'<i18n:I18n key="i18n_common_title_materialvoucheritemnumber" defaultValue="物料凭证项编号" />', name:'materialVoucherItemNumber' ,width:150, align:'center'},
		                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'fileType' ,width:150, align:'center'},
		                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
		                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="待发状态" />', name:'fileStatus' ,width:150, align:'center',renderer:function(val){
		                 	if (val == "0") {
		                		return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
		                	} else if (val == "1") {
		                		return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
		                	} else if (val == "2") {
		                		return '<i18n:I18n key="i18n_common_title_sendstatus_received" defaultValue="已接收" />';
		                	}
		                }},
		                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
			                  	if (val == elsAccount) {
			                 		return '<i18n:I18n key="i18n_label_self" defaultValue="已方" />';
			                 	} else {
			                 		return '<i18n:I18n key="i18n_label_otherSide" defaultValue="对方" />';
			                 	} 
			            }}
		             ];
		
		if(materialVoucherNumber==null){
			fileGrid = $('#fileTable').mmGrid({
		        cols: cols_file,
		        items:[],
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
		    });
		}else{
			var paramStr={"materialVoucherNumber":materialVoucherNumber,"elsAccount":elsAccount,"mobileType":"101"}
			fileGrid = $('#fileTable').mmGrid({
		        cols: cols_file,
		        url : "<%=basePath%>rest/MaterialFormFileService/findMaterialFormFile",
		        params:paramStr,
		        method:'post',
		        root:"rows",
		        remoteSort:true,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
		    });
		}
	}
	function loadFormFileByType() {
		var type = $("#formFileTypeSelector").val();
		if(materialVoucherNumber != null && materialVoucherNumber != "null" && materialVoucherNumber != ""){
			$.ajax({
				url :"<%=basePath%>rest/MaterialFormFileService/selectByHeadOrItem/" + elsAccount + "/" + materialVoucherNumber + "/101/" + type,
				type :"get",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					fileGrid.load(data.rows);
				},
				error : function(data) {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}
	}
	</script>
</body>
</html>