<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
<!--                 <button class="button-wrap" id="saveBtn">保存</button> -->
<%--                 <button class="button-wrap" id="reverseBtn"><i18n:I18n key="i18n_label_writeoff" defaultValue="冲销" /></button> --%>
<%--                 <button id="headColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
                <button id="receiptBtn" class="button-wrap">收货</button>
                <button id="deliveryFlowBtn" class="button-wrap"><i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" /></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>
	<form id="form" onsubmit="return false;">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_receiptheader" defaultValue="收货单抬头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<main class="grid-container">
					<div class="grid-100">
						<table id="table-head"></table>
					</div>
					</main>
				</div>
			</div>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
                    <div id="sheet-project-one">
					<main class="grid-container">
					<div class="grid-100" id="materialVoucherItemGrid">
						<table id="materialVoucherItemTable"></table>
					</div>
					</main>
                    </div>
				</div>
			</div>
		</div>
	</form>
	</div>
	<script type="text/javascript">
	var materialVoucherNumber=GetQueryString("materialVoucherNumber");
	var deliveryStatus=GetQueryString("deliveryStatus");
	var headGrid;
	var fbk1 = "";
	var fbk2 = "";
	var itemGrid;
	var mobileType="511";
	var cols=[{ "title": "els号",  "name": "elsAccount",  "align": "center", "width": 100,renderer:function(val){
				  	return val+'<input type="hidden"  name="bomVoucherHeader[elsAccount]"  value="'+val+'" />';
				 }},
			     { "title": "对方els号",  "name": "toElsAccount",  "align": "center", "width": 100,renderer:function(val){
					  	return val;
				 }},
			     { "title": "物料凭证号",  "name": "materialVoucherNumber",  "align": "center", "width": 130,renderer:function(val){
					  	return val+'<input type="hidden"  name="bomVoucherHeader[materialVoucherNumber]"  value="'+val+'" />';
				 }},
			     { "title": "凭证年度",  "name": "voucherYear",  "align": "center", "width": 100},
			     { "title": "凭证日期",  "name": "voucherDate",  "align": "center", "width": 100,renderer:function(val){
		        	  if(!val||val==""){ return val="";}
			        	return new Date(val).format('yyyy-MM-dd');
		          }},
		          { "title": "过账日期",  "name": "postDate",  "align": "center", "width": 100, renderer:function(val){
		        	  if(!val||val==""){ return val="";}
			        	return new Date(val).format('yyyy-MM-dd');
		          }},
		          { "title": "发货状态",  "name": "deliveryStatus",  "align": "center", "width": 100, renderer:function(val){
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
		          { "title": "移动类型",  "name": "mobileType",  "align": "center", "width": 100,renderer:function(val){
		        	  var showVal="";
		        	  if(!val||val==""){
		        		 return val=""+'<input type="hidden"  name="bomVoucherHeader[toElsAccount]" val=""/>';
		        	 } else if(val=="511"){
		        		 return "收货"+'<input type="hidden"  name="bomVoucherHeader[mobileType]" value="'+val+'" />';
		        	 }

		          }},
		          { "title": "发货时间",  "name": "deliveryTime",  "align": "center", "width": 100, renderer:function(val){
		        	  if(!val||val==""){ return val="";}
			        	return new Date(val).format('yyyy-MM-dd');
		          }},
		          { "title": "预计到达时间",  "name": "planArrivalTime",  "align": "center", "width": 100, renderer:function(val){
		        	  if(!val||val==""){ return val="";}
			        	return new Date(val).format('yyyy-MM-dd');
		          }}];
		       
	var cols_item=[{ "title": "els号",  "name": "elsAccount",  "align": "center", "width": 100},
			          { "title": "对方els号",  "name": "toElsAccount",  "align": "center", "width": 100},
			          { "title": "物料凭证号",  "name": "materialVoucherNumber",  "align": "center", "width": 130},
			          { "title": "物料凭证项",  "name": "materialVoucherItemNumber",  "align": "center", "width": 100,renderer:function(val){
						  	return val+'<input type="hidden"  name="bomVoucherItemList[][materialVoucherItemNumber]"  value="'+val+'" />';
					  }},
			          { "title": "批次",  "name": "orderBatch",  "align": "center", "width": 80,},
			          { "title": "采购物料号",  "name": "purchaseMaterialNumber",  "align": "center", "width": 100},
			          { "title": "销售物料号",  "name": "saleMaterialNumber",  "align": "center", "width": 100},
			          { "title": "数量",  "name": "wesbs",  "align": "center", "width": 100,renderer:function(val){
						  	return '<input type="text"  name="bomVoucherItemList[][wesbs]"  value="'+val+'" />';
					  }},
			          { "title": "基本单位",  "name": "basicUnit",  "align": "center", "width": 100},
			          { "title": "采购工厂",  "name": "purchaseFactory",  "align": "center", "width": 100},
			          { "title": "销售工厂",  "name": "saleFactory",  "align": "center", "width": 100},
			          { "title": "发货日期",  "name": "deliveryDate",  "align": "center", "width": 100,renderer:function(val){
			        	  if(!val||val==""){ return val="";}
				        	return new Date(val).format('yyyy-MM-dd');
			          }},
			          { "title": "bom编号",  "name": "reserveNumber",  "align": "center", "width": 100},
			          { "title": "bom项编",  "name": "reserveItemNumber",  "align": "center", "width": 100},
			          { "title": "计划行号",  "name": "planItemNumber",  "align": "center", "width": 100}];

	$(document).ready(function() {
		init();
		
		//收货
		$('#receiptBtn').click(function(){
			confirmReceipt();
		});
		
		//退出
		$("#exitBtn").click(function(){
			parent.elsDeskTop.closeCurWin('editBomReceipt',closeCallback);
		});
	});
	
	//初始化
	function init(){
		initData();
		$("#deliveryFlowBtn").click(function(){
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
	}
	
	//初始化数据
	function initData(){
		var param='{"elsAccount":"'+elsAccount+'","mobileType":"'+mobileType+'","materialVoucherNumber":"'+materialVoucherNumber+'"}';
		//加载数据
		$.ajax({
				url :"<%=basePath%>rest/BomVoucherService/getBomVoucherDetail",
				type :"POST",
				contentType : "application/json",
				data : param,
				dataType : "json",
				success : function(data) {
					 if(data!=null&&data.statusCode=="-100"){
					    	alert(data.message,2);
					    	return ;
					    }else{
					    	deliveryStatus=data.bomVoucherHeader.deliveryStatus;
					    	if(deliveryStatus=="2"){
					    		$('#receiptBtn').css("display","none");
					    	}
					    	if (data.bomVoucherHeader.logistics) {
								fbk1 = data.bomVoucherHeader.logistics;
							}
							if (data.bomVoucherHeader.logisticsNumber) {
								fbk2 = data.bomVoucherHeader.logisticsNumber;
							}
					    	var head = [];
					    	head.push(data.bomVoucherHeader);
					    	headGrid= $('#table-head').mmGrid({
							     cols: cols,
							     items: head,
							     remoteSort:true,
							     loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
							     noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
							});
								
							itemGrid= $('#materialVoucherItemTable').mmGrid({
							   cols: cols_item,
							   items:data.bomVoucherItemList,
							   remoteSort:true,
							   loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
							   noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
							});
// 					    	headGrid.removeRow();
// 					    	itemGrid.removeRow();
// 					    	headGrid.addRow(data.bomVoucherHeader);
// 					    	itemGrid.addRow(data.bomVoucherItemList);
					   	}
				},
	    		error : function(data) {
	    			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    		}
			});
	}
	
	//确认收货
	function confirmReceipt(){
		if(deliveryStatus=="2"){
			alert("该批发货已全部收货！",2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认收货',closeEvent:function(){
		    parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/BomVoucherService/confirmReceipt",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify($("#form").serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data!=null&&data.statusCode=="-100"){
					    alert(data.message,2);
					    return ;
					}else{
						initData();
						alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
// 						parent.elsDeskTop.closeCurWin('editBomReceipt',closeCallback);
					}
				},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    		}
			});
		}});
	}
	
	//退出回调方法
	function closeCallback() {
		parent.frames["iframeApp_bomReceiptManager"].initData();
	}
</script>
</body>
</html>