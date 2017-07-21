<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="confirmBtn"><i18n:I18n key="i18n_delivery_button_sceneconfirm" defaultValue="确认到场" /></button>
				<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_lable_deliverymaterialvouchernumber" defaultValue="发货单号" />：</span><input id="materialVoucherNumber" name="materialVoucherNumber" type="text" />
					<span><i18n:I18n key="i18n_delivery_lable_estimatedscene" defaultValue="预计到货日期" />：</span><input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="startReceiptDate" name="startReceiptDate"/>
                    <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span><input type="text" id="endReceiptDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="endReceiptDate"/>
<%-- 				    <span><i18n:I18n key="i18n_lable_deliverystatus" defaultValue="单据状态" />：</span>
				    <select id="deliveryStatus" name="deliveryStatus">
                		<option value="0"><i18n:I18n key="i18n_common_selector_unreceipt" defaultValue="未收货" /></option>
                		<option value="1" selected><i18n:I18n key="i18n_delivery_select_deliveronway" defaultValue="发货在途" /></option>
                		<option value="2"><i18n:I18n key="i18n_delivery_lable_receipt" defaultValue="已收货" /></option>
                		<option value="3"><i18n:I18n key="i18n_delivery_lable_scene" defaultValue="到货" /></option>
                	</select> --%>
				</div>
				<div class="dis-in-b input-and-tip">
					<button class="button-wrap" id="seachBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				    <button  id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_header" defaultValue="物料凭证抬头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<ul>
						<li><a id="tab-one" href="#sheet-item-one"><i18n:I18n key="i18n_common_selector_wattingforreceipt" defaultValue="待收货" /></a></li>
						<li><a id="tab-two" href="#sheet-item-two"><i18n:I18n key="i18n_delivery_selector_scene" defaultValue="到场" /></a></li>
					</ul>
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="materialVoucherHeaderGrid0">
							<table id="materialVoucherHeaderTable0"></table>
							<div id="pg1" style="text-align: right;"></div>
						</div>
						</main>
					</div>
					<div id="sheet-item-two">
						<main class="grid-container">
						<div class="grid-100" id="materialVoucherHeaderGrid3">
							<table id="materialVoucherHeaderTable3"></table>
							<div id="pg2" style="text-align: right;"></div>
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
					<div id="sheet-project-one">
						<button id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
						<main class="grid-container">
						<div class="grid-100" id="materialVoucherItemGrid">
							<table id="materialVoucherItemTable"></table>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		var toElsAccount=GetQueryString("toElsAccount");
		$("#toElsAccount").val(toElsAccount);
		$("#elsAccount").val(elsAccount);
		
		$("#sheet-head").tabs({active: 0});
		var mobileType="101"
		var materialVoucherNumber="";
		var deliveryStatus;
		var headGrid1;
		var headGrid3;
		 
		var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="sceneConfirm_head"/>;
		var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="sceneConfirm_item"/>;
		
		//将销售订单表头数据插入表格中
		function insertMaterialVoucherHeaderTable(deliveryStatus){
			$('#materialVoucherHeaderGrid'+deliveryStatus).html('<table id="materialVoucherHeaderTable'+deliveryStatus+'"></table><div id="pg'+deliveryStatus+'" style="text-align: right;"></div>');
	        var startReceiptDate = $("#startReceiptDate").val();
	        var endReceiptDate = $("#endReceiptDate").val();
	        //var status = $("#deliveryStatus").val();
		    if(deliveryStatus==0){
		    	 var paramStr={"startReceiptDate":startReceiptDate,"endReceiptDate":endReceiptDate,"mobileType":mobileType,"deliveryStatus":deliveryStatus,"elsAccount":elsAccount,"materialVoucherNumber":$("#materialVoucherNumber").val().trim()};
		    	 headGrid1= $('#materialVoucherHeaderTable'+deliveryStatus).mmGrid({
			    	 cols: cols,
			         url: "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherHeaderByStatus",
			         params:paramStr,
			         method:'post',
			         root:"rows",
			         remoteSort:true,
			         loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			         noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			         checkCol:true,
			         plugins: [
			             $('#pg0').mmPaginator({
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
		    }else{
		    	 var paramStr={"startReceiptDate":startReceiptDate,"endReceiptDate":endReceiptDate,"mobileType":mobileType,"deliveryStatus":deliveryStatus,"elsAccount":elsAccount,"materialVoucherNumber":$("#materialVoucherNumber").val().trim()};
		    	 headGrid3= $('#materialVoucherHeaderTable'+deliveryStatus).mmGrid({
			    	 cols: cols,
			         url: "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherHeaderByStatus",
			         params:paramStr,
			         method:'post',
			         root:"rows",
			         remoteSort:true,
			         loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			         noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			         plugins: [
			             $('#pg3').mmPaginator({
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
		    }
		    
		    if(deliveryStatus==0){
		    	 headGrid1.on('cellSelected', function(e, item, rowIndex, colIndex){
				    	materialVoucherNumber=item.materialVoucherNumber;
				    	deliveryStatus=item.deliveryStatus;
				    	insertMaterialVoucherItemTable(materialVoucherNumber)
				     });
		    }else{
		    	 headGrid3.on('cellSelected', function(e, item, rowIndex, colIndex){
				    	materialVoucherNumber=item.materialVoucherNumber;
				    	deliveryStatus=item.deliveryStatus;
				    	insertMaterialVoucherItemTable(materialVoucherNumber)
				     });
		    }
		    
		     insertMaterialVoucherItemTable(null);
		}
		
		insertMaterialVoucherHeaderTable(0);
		
		insertMaterialVoucherHeaderTable(3);
		
		
		//点击查询
		$("#seachBtn").click(function(){
			var attr=$("#sheet-head ").find('li[aria-selected=true]').attr("aria-controls");
			if(attr=="sheet-item-one"){
				materialVoucherNumber='';
				insertMaterialVoucherHeaderTable(0);
			}else{
				materialVoucherNumber="";
				insertMaterialVoucherHeaderTable(3);
			}
		});
		
		//将销售订单xiang数据插入表格中
		function insertMaterialVoucherItemTable(materialVoucherNumber){
			$('#materialVoucherItemGrid').html('<table id="materialVoucherItemTable"></table>')
			var paramStr={"elsAccount":elsAccount,"mobileType":mobileType,"materialVoucherNumber":materialVoucherNumber};
			if(materialVoucherNumber==null){
			    $('#materialVoucherItemTable').mmGrid({
			        cols: cols_item,
			        items:[],
			        remoteSort:true,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}else{
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
		
		$("#confirmBtn").click(function(){
			
			var attr=$("#sheet-head ").find('li[aria-selected=true]').attr("aria-controls");
			if(attr=="sheet-item-one"){
				var selectedIndexs1 = headGrid1.selectedRowsIndex();
				if(selectedIndexs1.length==0){
					alert("<i18n:I18n key='i18n_delivery_chooseorderscene' defaultValue='请选择到场发货订单' />",2);
					return;
				}else{
					materialVoucherNumber=headGrid1.row(selectedIndexs1[0]).materialVoucherNumber;
				}
			}else{
				alert("<i18n:I18n key='i18n_delivery_cantscenetwice' defaultValue='不能重复确定到场' />",2);
				return ;
			}
			
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_sceneconfirm" defaultValue="是否确认到场？" />',closeEvent:function(){

			var paramStr='{"elsAccount":"'+ elsAccount+ '","mobileType":"'+ mobileType+ '","deliveryStatus":"3","elsSubAccount":"'+ elsSubAccount+ '","materialVoucherNumber":"'+ materialVoucherNumber+ '"}';
			parent.elsDeskTop.showLoading();
			$.ajax({
	    		url :"<%=basePath%>rest/MaterialVoucherService/updateMaterialVoucherHeader",
	    		type :"post",
	    		contentType : "application/json",
	    		data : paramStr,
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			$("#sheet-head").tabs({active: 1});
	    			insertMaterialVoucherHeaderTable(3);
	    			insertMaterialVoucherHeaderTable(0);
	    			alert("<i18n:I18n key='i18n_delivery_updatesuccess' defaultValue='修改成功' />");
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
	    		}
	    	}); 
			}});
		});
		
		//退出
		$("#exitBtn").click(function(){
			if (winId) {
				parent.elsDeskTop.closeCurWin(winId,closeCallback());
			} else {
				parent.elsDeskTop.closeCurWin('scenConfirm',closeCallback);
			}
		});
		
		function closeCallback() {
// 			if (parent.frames["iframeApp_queryReceipt"]) {
// 				parent.frames["iframeApp_queryReceipt"].insertMaterialVoucherHeaderTable();
// 			}
		}
	});
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'subAccountColumnSetting',
	        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=sceneConfirm_head" + "&window=iframeApp_scenConfirm",
	        windowMinWidth: 480,
	        windowMinHeight: 600,
	        'windowWidth':480,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	
	function renderDeliveryStatus(val,item) {
		if(val == "0")
			return "<i18n:I18n key='i18n_common_selector_wattingforreceipt' defaultValue='待收货' />";
		else if(val == "3")
			return "<i18n:I18n key='i18n_delivery_selector_scene' defaultValue='到场' />";
	}

    $("#tab-one").click(function(){
    	$("#deliveryStatus").val(1);
    });
    $("#tab-two").click(function(){
    	$("#deliveryStatus").val(3);
    });
	$("#itemColumnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'subAccountColumnSetting',
	        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=sceneConfirm_item" + "&window=iframeApp_scenConfirm",
	        windowMinWidth: 480,
	        windowMinHeight: 600,
	        'windowWidth':480,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	</script>
</body>
</html>