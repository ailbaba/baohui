<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
<%-- 				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="companyShortName"
			value="<%=session.getAttribute("companyShortName")%>" /> <input
			type="hidden" name="saleQuotationHeaderVO[elsAccount]"
			value="${elsAccount }" /> <input type="hidden"
			name="saleQuotationHeaderVO[elsSubAccount]" value="${elsSubAccount }" />
			<input type="hidden" id="toElsAccount"
			name="purchaseQuotationHeaderVO[toElsAccount]" value="" />
			<input type="hidden" id="quotationNumber"
			name="purchaseQuotationHeaderVO[quotationNumber]" />
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_quotationheader" defaultValue="报价单头" /></span>
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
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_quotationitem" defaultValue="报价单行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<ul>
						<li><a href="#sheet-item-one"><i18n:I18n key="i18n_lable_quotationitem" defaultValue="报价单行项目" /></a></li>
						<li><a href="#sheet-item-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
					</ul>
					<div id="sheet-item-one">
<!-- 						<div class="edit-box-wrap"> -->
<%-- 							<button id="itemColumnDefineBtn" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
<!-- 						</div> -->
						<main id="item-container" class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
						</div>
						</main>
					</div>
					<div id="sheet-item-two">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line p-zero">
								<div class="pos-relative upload-wrap">
									<div class="pos-absolute file-list">
										<div class="file-list-head">
											<i18n:I18n key="i18n_common_lable_filelist" defaultValue="表单文件列表" />：<span>
											<select id="formFileTypeSelector" onchange="loadFormFileByType()">
											    <option value="0"><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
								                <option value="1"><i18n:I18n key="i18n_lable_quotationheadfile" defaultValue="报价单头文件" /></option>
								                <option value="2"><i18n:I18n key="i18n_lable_quotationitemfile" defaultValue="报价单项文件" /></option>
							                </select></span>
										</div>
										<main class="grid-container">
										<div class="grid-100">
											<table id="table-file"></table>
										</div>
										</main>
									</div>
									<div class="file-scan">
										<div class="file-option-zoom">
											<div class="dis-in-b text-right">
												<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
												<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
											</div>
										</div>
										<div class="file-display" id="file-display">
											<a id="viewerPlaceHolder"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="saying-dialog">
           <div class="fl-left left-content pos-relative">
               <div class="dis-block pos-absolute option-bar pre-active next"></div>
           </div>
           <div class="fl-left right-content pos-relative none-active">
               <div class="saying-box-wrap">
                  <iframe class="testIframe" id="chatIframe" frameborder="0" width="100%">
                  </iframe>
               </div>
           </div>
           <div class="clear-both"></div>
   	</div>
   	</div>
<script type="text/javascript">
var initData;
var $sob;
var chatFromUrlFlag;
var peopleList=[];
var headGrid;
var itemGrid;
var fileGrid;
var fileUploader;
var toElsAccount = GetQueryString("toElsAccount");
var quotationNumber = GetQueryString("quotationNumber");
//var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editSaleQuotationHeader"/>;
var cols_head = [{title:"<i18n:I18n key='i18n_quotation_number' defaultValue='报价单号' />",name:"quotationNumber",align:"center",width:98},
//                  {title:"供货编号",name:"supplyNumber",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_lable_materialnumber' defaultValue='物料编号' />",name:"materialNumber",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_label_materialdescribe' defaultValue='物料描述' />",name:"materialDesc",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_title_materialgroup' defaultValue='物料组' />",name:"materialGroup",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_quotation_purchaseels' defaultValue='采购商ELS号' />",name:"elsAccount",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_purchaser' defaultValue='采购商' />",name:"companyShortName",align:"center",width:168},
                 {title:"<i18n:I18n key='i18n_quotation_saleels' defaultValue='供应商ELS号' />",name:"toElsAccount",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_enquiry_label_supplier' defaultValue='供应商' />",name:"toCompanyShortName",align:"center",width:168}
                 ];
// var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editSaleQuotationItem"/>;
var cols_item = [{title:"<i18n:I18n key='i18n_common_title_lineitemnumber' defaultValue='行项目号' />",name:"orderItemNumber",hidden:true,align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][orderItemNumber]")}},
                 {title:"<i18n:I18n key='i18n_quotation_supplynumber' defaultValue='供货编号' />",name:"supplyNumber",hidden:true,align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][supplyNumber]")}},
                 {title:"<i18n:I18n key='i18n_common_lable_materialnumber' defaultValue='物料编号' />",name:"materialNumber",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][materialNumber]")}},
                 {title:"<i18n:I18n key='i18n_common_label_materialdescribe' defaultValue='物料描述' />",name:"materialDesc",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][materialDesc]")}},
                 {title:"<i18n:I18n key='i18n_common_title_materialgroup' defaultValue='物料组' />",name:"materialGroup",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][materialGroup]")}},
                 {title:"<i18n:I18n key='i18n_material_cate' defaultValue='物料分类' />",name:"materialCategory",hidden:true,align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][materialCategory]")}},
                 {title:"<i18n:I18n key='i18n_material_pinpai' defaultValue='品牌' />",name:"attribute1",align:"center",width:98,renderer:attrRenderer},{title:"长度",name:"attribute2",align:"center",width:98,renderer:attrRenderer},
                 {title:"<i18n:I18n key='i18n_material_width' defaultValue='宽度' />",name:"attribute3",align:"center",width:98,renderer:attrRenderer},
                 {title:"<i18n:I18n key='i18n_material_texture' defaultValue='材质' />",name:"attribute4",align:"center",width:98,renderer:attrRenderer},{title:"颜色",name:"attribute5",align:"center",width:98,renderer:attrRenderer},
                 {title:"<i18n:I18n key='i18n_salequotation_price' defaultValue='基准价格' />",name:"price",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][price]")}},
              	 {title:"<i18n:I18n key='i18n_delivery_lable_unit' defaultValue='单位' />",name:"unitMeasure",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][unitMeasure]")}},
                 {title:"<i18n:I18n key='i18n_salequotation_pricestartdate' defaultValue='价格起始日期' />",name:"fbk7",align:"center",width:98,renderer:function(val){return dateInputFormat(val,"R","itemList[][fbk7]")}},
                 {title:"<i18n:I18n key='i18n_salequotation_priceenddate' defaultValue='价格截止日期' />",name:"fbk8",align:"center",width:98,renderer:function(val){return dateInputFormat(val,"R","itemList[][fbk8]")}},
                 {title:"<i18n:I18n key='i18n_salequotation_predeliverdate' defaultValue='交货提前期' />",name:"fbk10",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][fbk10]")}},
                 {title:"<i18n:I18n key='i18n_salequotation_minorderquantity' defaultValue='最小订货量' />",name:"fbk9",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][fbk9]")}},
                 {title:"<i18n:I18n key='i18n_salequotation_maxorderquantity' defaultValue='最大订货量' />",name:"quantity",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][quantity]")}},
                 {title:"<i18n:I18n key='i18n_common_title_remarks' defaultValue='备注' />",name:"fbk11",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][fbk11]")}}
//                  {title:"货币",name:"currency",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][currency]")}},
//                  {title:"价格单位",name:"unitPrice",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][unitPrice]")}},
//                  {title:"数量单位",name:"unitQuantity",align:"center",width:98,renderer:function(val){return stringInput(val,"R","itemList[][unitQuantity]")}}
                 ];
var cols_file = [
	             { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
	                 	if (val == elsAccount) {
	                		return "<i18n:I18n key="i18n_common_purchase" defaultValue="采购方" />";
	                	} else {
	                 		return "<i18n:I18n key="i18n_common_sale" defaultValue="销售方" />";
	                	} 
	             }},
                 { title:'id',name:'formId' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'orderItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return '<i18n:I18n key="i18n_lable_quotationheadfile" defaultValue="报价单头文件" />';
	                	} else{
	                		return '<i18n:I18n key="i18n_lable_quotationitemfile" defaultValue="报价单项文件" />';
	                	}
	                }},
                 { title:'<i18n:I18n key="i18n_quotation_itemnumber" defaultValue="行项目编号" />',name:'orderItemNumber' ,width:80, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />',name:'filePath' ,width:200, align:'center',hidden:true}
             ];
//初始化聊天窗口
//ELS账号+订单号 作为 businessID
function initChat() {
		var businessID = initData.purchaseQuotationHeaderVO.quotationNumber;
		//采购凭证号
		var quotationNumberList = [];
		//订单号
		var bIdList = [];
		//聊天显示列表
		var chatList = [];
		var obj ={};
		obj[initData.purchaseQuotationHeaderVO.quotationNumber] = '' ;
		bIdList.push(obj); 
		chatList.push(initData.purchaseQuotationHeaderVO.quotationNumber);
		chatList=chatList.map(function(d){
			return {name:d}
		});
		//初始化iframe
		 var toElsSubAccount;
	  	//多人聊天  type=multi 一对一 type=single  list 用来显示列表人
	  	bIdString = bIdList&&bIdList.length?'['+bIdList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	chatListString = chatList&&chatList.length?'['+chatList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	var url = "multiChatTest.jsp?type=multi&fromElsAccount="
				+ elsAccount
				+ "&fromElsSubAccount="
				+ elsSubAccount
				+ "&toElsAccount="
				+ toElsAccount
				+ "&toElsSubAccount="+peopleListString
				+ "&businessType=quotation"
				+ "&businessID="+bIdString
          + "&list="+ (chatListString&&chatListString.length?chatListString : peopleListString)
				+"&t="+new Date().getTime();
	   
	   $('.testIframe').attr('src','<%=basePath%>'+ url);
	   //滚动条美化niceScroll
	   $('.public-wrap').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
}
$().ready(function(){
	init();
	$sob = $('.saying-dialog .option-bar');
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10),closeCallback());
	});
});
function closeCallback() {
}
function init(){
	$("#sheet-project").tabs();
	$.ajax({
   		url : "<%=basePath%>rest/PurchaseQuotationService/getPurchaseQuotation/"+elsAccount+"/"+toElsAccount+"/"+quotationNumber,
   		type : "get",
   		contentType : "application/json",
   		dataType : "json",
   		success : function(data) {
   			fillData(data);
   		},
   		error : function(data) {
   			parent.elsDeskTop.hideLoading();
   			if (!permissionError(data)) {
    			alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
   			}
   		}
	});
}
function attrRenderer(val,item,index,name) {
	if (!val) {
		val = "";
	}
	return val;
}
function fillData(data) {
	initData = data;
	$("#quotationNumber").val(data.purchaseQuotationHeaderVO.quotationNumber);
	$("#toElsAccount").val(toElsAccount);
	if (!headGrid) {
		headGrid  = $('#table-head').mmGrid({
	        cols: cols_head,
	        height: 200,
	        checkCol:true,
// 	        items:[data.purchaseQuotationHeaderVO]
			items:data.materialList
	    });
		headGrid.on("loadSuccess",function(e, d){
			initChat();
			headGrid.select(0);
			filterItem(initData.materialList[0].materialNumber,initData.materialList[0].materialCategory);
			//打开聊天行选择开关
    		chatFromUrlFlag = true;
            //初始化聊天控制状态
            if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
            $sob.click();
		});
		headGrid.on('cellSelected',function(e, item, rowIndex, colIndex){
			filterItem(item.materialNumber,item.materialCategory);
		});
	}
	if (!itemGrid) {
		itemGrid  = $('#table-item').mmGrid({
	        cols: cols_item,
	        checkCol:true,
	        items:data.itemList
	    });
	}
	if (!fileGrid) {
		fileGrid = $('#table-file').mmGrid({
	        cols: cols_file,
	        items: data.fileList,
	    });
	}
}

$("#btnDownloadFile").click(function(){
	var selectedRows = fileGrid.selectedRows();
	if(selectedRows.length == 0){
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
		return;
	}
	window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + selectedRows[0].filePath;
});
$("#btnViewFile").click(function(){
	var selectedRows = fileGrid.selectedRows();
	if(selectedRows.length == 0){
		alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
		return;
	}
	var showDiv = $("#file-display");
	var viewerPlaceA = $("#viewerPlaceHolder");
	viewerPlaceA.empty();
	var filePath = selectedRows[0].filePath;
	var data = {"elsAccount":elsAccount,"filePath":filePath};
	if(isSupportImage(filePath)){//系统支持的图片,直接显示
		showDiv.css("overflow","auto");
		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
	}else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
	    parent.elsDeskTop.showLoading();
	    $.ajax({
		url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			var resStatus = data.statusCode;
			var filePath = data.message;
			if("200" == resStatus){
				var width=$("#file-display").width();
				var height=$("#file-display").height();
				$("#viewerPlaceHolder").css("width",width*0.94+"px");  
				$("#viewerPlaceHolder").css("height",height+"px");  
				$("#viewerPlaceHolder").css("padding-left",width*0.03+"px");  
				$("#viewerPlaceHolder").css("display","block" );  

				var fp = new FlexPaperViewer(
				            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
				            'viewerPlaceHolder', 
				            {config : {
				                SwfFile : filePath,
				                Scale : 1.5,
				                ZoomTransition : 'easeOut',
				                ZoomTime : 0.5,
				                ZoomInterval : 0.2,
				                FitPageOnLoad : false,
				                FitWidthOnLoad : false,
				                FullScreenAsMaxWindow : false,
				                ProgressiveLoading : false,
				                MinZoomSize : 0.2,
				                MaxZoomSize : 5,
				                SearchMatchAll : false,
				                InitViewMode : 'SinglePage',
				                ViewModeToolsVisible : true,
				                ZoomToolsVisible : true,
				                NavToolsVisible : true,
				                CursorToolsVisible : true,
				                SearchToolsVisible : true,
				                localeChain: 'zh_CN'
				            	}
				            });
			}else{
				alert(data.message,2);
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
	}else {
		alert('<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型!" />',2);
	}
});
function loadOrderItem(){
	var isOrderItem = $("#operTypeSelector").val();
	if("1" == isOrderItem){
		$(".dialog-tip").height(270);
		$("#divOrderItem").show();
		getOrderItem();
	}else{
		$(".dialog-tip").height(240);
		$("#divOrderItem").hide();
		$("#orderItemSelector").empty();
	}
}
function getOrderItem(){
	$("#orderItemSelector").empty();
	var html = "";
	var trs = $("#table-item").find("tr");
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		if (data.orderItemNumber != "") 
			html += "<option value='"+data.orderItemNumber+"'>" + data.orderItemNumber + "_" + data.materialDesc + "</option>";
	}
	$("#orderItemSelector").append(html);
	
}
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editSaleQuotationHeader" + "&window=iframeApp_editSaleQuotation",
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
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editSaleQuotationItem" + "&window=iframeApp_editSaleQuotation",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
function filterItem(materialNumber,materialCategory) {
	//根据物料分类动态获取特性，重新初始化表格
	var param = {"elsAccount":elsAccount,"materialCateCode":materialCategory};
	$.ajax({
		url : "<%=basePath%>rest/MaterialCateService/queryMaterialSpec",
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(param),
		success : function(data) {
			if (data.rows.length > 0) {
				//从6开始
				for (var i=6;i<11;i++) {
					var showFlag = false;
					for (var j=0;j<data.rows.length;j++) {
						if (i-5 == data.rows[j].attrIndex) {
							showFlag = true;
							cols_item[i].title = data.rows[j].materialSpecName;
						}
					}
					if (showFlag) {
						cols_item[i].hidden = false;
					} else {
						cols_item[i].hidden = true;
					}
				}
				$("#item-container").html('<div class="grid-100"><table id="table-item"></table></div>');
				itemGrid  = $('#table-item').mmGrid({
			        cols: cols_item,
			        checkCol:true,
			        items:initData.itemList
			    });
				itemGrid.on("loadSuccess",function(e,d){
					$("#table-item").find("tr").each(function(){
						if ($(this).data("item").materialNumber != materialNumber) {
							$(this).hide();
						} else {
							$(this).show();
						}
					});
				});
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
</script>
</body>
</html>