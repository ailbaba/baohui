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
	        <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
	    </div>
    </div>
</div>
<form id="form" onsubmit="return false;">
<input type="hidden" id="deliveryStatus" value="0"/>
<input type="hidden" name="companyShortName" value="<%=session.getAttribute("companyShortName")%>"/>
<!-- <input type="hidden" id="selectedItems" name="selectedItems" value=""/> -->
<input type="hidden" name="materialVoucherHeaderVO[elsAccount]" value="${elsAccount }"/>
<input type="hidden" name="materialVoucherHeaderVO[toElsAccount]" value="<%=request.getParameter("toElsAccount")%>"/>
<input type="hidden" name="materialVoucherHeaderVO[elsSubAccount]" value="${elsSubAccount }"/>
<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_deliveryorderhead" defaultValue="发货单抬头" /></span>
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
		<li><a href="#sheet-project-one"><i18n:I18n key="i18n_delivery_lable_deliveryorderitems" defaultValue="发货单行项目" /></a></li>
	    <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
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
<!-- 			<div id="sheet-project-two">
				<div class="box-wrap pos-relative bg-common">
					<div class="common-box-line p-zero">
						<div class="pos-relative upload-wrap">
							<div class="pos-absolute file-list">
								<div class="file-list-head">
									表单文件列表：<span></span>
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
										<button id="btnDownloadFile" class="button-wrap">下载文件</button>
										<button id="btnViewFile" class="button-wrap">在线预览文件</button>
										<button class="button-wrap" id="sendForm">发送表单文件</button>
									</div>
								</div>
								<div class="file-display" id="file-display">
									<a id="viewerPlaceHolder"></a>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div> -->
			   <div id="sheet-project-two">
                        <main class="grid-container">
		                    <div class="grid-100" id="fileGrid">
		                        <table id="table-file" ></table>
		                    </div>
		                </main>
               </div>
			</div>
		</div>
</form>
<script type="text/javascript">
	//列
	var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="deliveryHead"/>;
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editDelivery_mt"/>;
	
	$("#sheet-project").tabs();
	var blankRow;
	var itemGrid;
	var headGrid;
	var itemData;
	var fileGrid;
	var formId;
	var fileName;
	var mobileType;
	var fileStatus;
	var fileUploader;
	var orderItemNumber;
	var isTemp = true;
	var height = $(document).height() - 245;
	var itemNumberJson=new Object();
	$().ready(function() {
		init();
	    initFileGrid();
	});
	var flowCode = "";
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	var materialVoucherNumber = "<%=request.getParameter("materialVoucherNumber")%>";
if (materialVoucherNumber == "null") {
	materialVoucherNumber = "";
}
var deliveryStatus = "<%=request.getParameter("deliveryStatus")%>";
if (deliveryStatus != "0" && deliveryStatus != "null") {
	isTemp = false;
}
var selectedItems = "<%=request.getParameter("selectedItems")%>";

var itemRender = function(val, item, rowIndex){
    var thisRecord = $(this);
    var colName = thisRecord[0].name;
    if("undefined"==typeof(val) || null == val){
        val = ""; 
    }
    if("operation" == colName){
        var text = '<span class="copyAdd-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_button_copyAdd" defaultValue="复制新增" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
            +'&nbsp;&nbsp;<span class="remove-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        return text;
    } else if("attachmentFile" == colName){
        var text = '<span class="uploadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
                +'&nbsp;&nbsp;<span class="downloadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        return text;
    } else if("attachmentImage" == colName){
       	var text = '<span class="previewImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
               +'&nbsp;&nbsp;<span class="uploadImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
               +'&nbsp;&nbsp;<span class="downloadImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        return text;
    } else if("dateRequired"==colName){
        if(""!=val){
            return "<input typpe='text' name='"+colName+"' class='Wdate' onfocus=\"WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})\" value='"+new Date(val).format("yyyy-MM-dd hh:mm:ss")+"' />";
        } else {
            return "<input typpe='text' name='"+colName+"' class='Wdate' onfocus=\"WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})\" value='' />";
        }
    } else {
        return "<input typpe='text' name='"+colName+"' class='itemColsEdit' value='"+val+"' />";
    }
}

function closeCallback() {
	if (parent.frames["iframeApp_deliveryManage"]) {
		parent.frames["iframeApp_deliveryManage"].query();
	}
}

$("#exitBtn").click(function(){
	if (winId) {
		parent.elsDeskTop.closeCurWin(winId,closeCallback);
	} else {
		parent.elsDeskTop.closeCurWin("editDelivery",closeCallback);
	}
});

function init(){
	if (materialVoucherNumber == "") {
		var data = {"elsAccount":elsAccount,"selectedItems":selectedItems};
		//根据行项目获取信息
		$.ajax({
    		url : "<%=basePath%>rest/MaterialVoucherService/getInfoFromSale",
    		type : "post",
    		contentType : "application/json",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			itemData = data;
    			materialVoucherNumber = data.materialVoucherHeaderVO.materialVoucherNumber;
    			fillData(data);
    		},
    		error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
    		}
    	});
	} else {
		var url = "<%=basePath%>rest/MaterialVoucherService/getInfoFromTemp";
		if (!isTemp) {
			url = "<%=basePath%>rest/MaterialVoucherService/getInfo";
		}
		var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber};

		$.ajax({
    		url : url,
    		type : "post",
    		contentType : "application/json",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			itemData = data;
				if (data.materialVoucherHeaderVO.flowCode) {
					flowCode = data.materialVoucherHeaderVO.flowCode;
				}
    			fillData(data);
    		},
    		error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
    		}
    	});
	} 
}

function fillData(data){
	if (!data.materialVoucherHeaderVO.voucherDate) {
		data.materialVoucherHeaderVO.voucherDate=new Date().format("yyyy-MM-dd");
	}
	if (!data.materialVoucherHeaderVO.postDate) {
		data.materialVoucherHeaderVO.postDate=new Date().format("yyyy-MM-dd");
	}
	data.materialVoucherHeaderVO.mobileType=601;
	if (!data.materialVoucherHeaderVO.deliveryStatus) {
		data.materialVoucherHeaderVO.deliveryStatus="0";
	}
	$("#deliveryStatus").val(data.materialVoucherHeaderVO.deliveryStatus);
	var head = new Array();
	head.push(data.materialVoucherHeaderVO);
	if (!headGrid) {
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height:100,
	        items: head
	    });
	} else {
		headGrid.load(head);
	}
	headGrid.on('loadSuccess',function() {
		$("#table-head").find("input").not(":checkbox").each(function(){
			$(this).css("width",$(this).parent().parent().width()-15);
		});
		var materialVoucherNumber = headGrid.row(0).materialVoucherNumber;
		if(materialVoucherNumber != null && materialVoucherNumber != "")
			loadFileItem(materialVoucherNumber);
		if (flowCode != "" && flowCode != "00") {
			$("input").attr("readOnly",true);
			$("select").attr("readOnly",true);
		}
		changeButtonStatus();
		   $("#table-head").find("span input").attr("readOnly",true);

	});
	if (!itemGrid) {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols,
	        checkCol:true,
	        height:height,
	        items: data.materialVoucherItemList
	    });
	} else {
		itemGrid.load(data.materialVoucherItemList);
	}
	itemGrid.on('loadSuccess',function(e, d) {
		$("#table-item").find("input").not(":checkbox").each(function(){
			$(this).css("width",$(this).parent().parent().width()-15);
		});
		for (var i=0;i<data.materialVoucherItemList.length;i++) {
			if (data.materialVoucherItemList[i].saleOrderNumber == '') {
				var $tr = $("#table-item").find("tr").eq(i);
				var $purchaseMaterialNumber = $tr.find(".purchaseMaterialNumber");
				$purchaseMaterialNumber.show();
				$purchaseMaterialNumber.css("width",$purchaseMaterialNumber.parent().parent().width()-15);
				$purchaseMaterialNumber.prev("span").hide();
				var $purchaseMaterialDesc = $tr.find(".purchaseMaterialDesc");
				$purchaseMaterialDesc.show();
				$purchaseMaterialDesc.css("width",$purchaseMaterialDesc.parent().parent().width()-15);
				$purchaseMaterialDesc.prev("span").hide();
				
				var $saleMaterialNumber = $tr.find(".saleMaterialNumber");
				$saleMaterialNumber.show();
				$saleMaterialNumber.css("width",$saleMaterialNumber.parent().parent().width()-15);
				$saleMaterialNumber.prev("span").hide();
				var $saleMaterialDesc = $tr.find(".saleMaterialDesc");
				$saleMaterialDesc.show();
				$saleMaterialDesc.css("width",$saleMaterialDesc.parent().parent().width()-15);
				$saleMaterialDesc.prev("span").hide();
				$tr.find(".isFree").attr("checked","checked");
			}
		}
		if (flowCode != "" && flowCode != "00") {
			$("input").attr("readOnly",true);
			$("select").attr("readOnly",true);
		}
		changeButtonStatus();
		$("#table-item").find("span input").attr("readOnly",true);
	});
}

$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=editDelivery" + "&window=iframeApp_editDelivery",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
$("#headColumnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=deliveryHead" + "&window=iframeApp_editDelivery",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
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
/* var cols_file = [{ title:'文件id',name:'formId' ,width:200, align:'center',hidden:true},
                 { title:'文件类型', name:'materialVoucherItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return "凭证头文件";
	                	} else{
	                		return "凭证项文件";
	                	}
	              }},
                 { title:'订单项编号',name:'materialVoucherItemNumber' ,width:200, align:'center',hidden:true},
                 { title:'文件路径',name:'filePath' ,width:200, align:'center',hidden:true},
                 { title:'文件名称', name:'fileName' ,width:200, align:'center'},
                 { title:'移动类型',name:'mobileType' ,width:200, align:'center',hidden:true},
                 { title:'待发状态', name:'fileStatus' ,width:59, align:'center',renderer:function(val){
                	 var showText;
                	 if (val == "0") {
                		 showText = "未发送";
                	} else if (val == "1") {
                		showText = "已发送";
                	} else if (val == "2") {
                		showText = "已接收";
                	}
                 	return showText;
                 }},
                 { title:'创建者', name:'createBy' ,width:80, align:'center',renderer:function(val){
	                  	if (val == elsAccount) {
	                 		return "已方";
	                 	} else {
	                 		return "对方";
	                 	} 
	             }}
             ]; */

function getOrderItem(){
	$("#orderItemSelector").empty();
	var html = "";
	var trs = $("#table-item").find("tr");
	for (var i=0;i<trs.length;i++){
		var data = trs.eq(i).data("item");
		if (data.materialVoucherNumber != "") 
			html += "<option value='"+data.materialVoucherItemNumber+"'>" + data.materialVoucherItemNumber + "_" + data.saleMaterialDesc + "</option>";
	}
	$("#orderItemSelector").append(html);
	
}

function loadOrderItem(){
	var isOrderItem = $("#operTypeSelector").val();
	if("1" == isOrderItem){
		$("#divOrderItem").show();
		getOrderItem();
	}else{
		$("#divOrderItem").hide();
		$("#orderItemSelector").empty();
	}
}

function initFileGrid(){
	if(!fileGrid){
		fileGrid = $('#table-file').mmGrid({
	        cols: cols_file,
	        items: [],
	        checkCol: true
	    });
	}
}
function loadFileItem(materialVoucherNumber){
	var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":"601"};
		$.ajax({
			url :"<%=basePath%>rest/MaterialFormFileService/findMaterialFormFile",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(data),
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

function changeButtonStatus() {
	//根据flowCode改变各按钮状态
// 	if (flowCode != "" && flowCode != "00") {
// 		$("#entryBtn").hide();
// 		$("#cancelEntryBtn").show();
// 		$("#flowBtn").show();
// 		$(".edit-btn").hide();
// 	} else {
// 		$("#entryBtn").show();
// 		$("#cancelEntryBtn").hide();
// 		$("#flowBtn").hide();
// 	}
	
	
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
	var filePath = selectedRows[0].filePath;
	
	parent.elsDeskTop.showLoading();
	previewFile(filePath);
});

function renderItemIsConfirm(val,item){
	if(val && val == "1")
		return "已确认";
	else if(val && val == "2")
		return "系统自动";
	else 
		return "<input name='materialVoucherItemList[][fbk43]' type='checkbox' value='1' />";
}

function previewFile(filePath){
	var showDiv = $("#file-display");
	var viewerPlaceA = $("#viewerPlaceHolder");
	viewerPlaceA.empty();
	var param = {
			elsAccount : elsAccount,
			filePath : filePath
	};
	
	if(isSupportImage(filePath)){//系统支持的图片,直接显示
		showDiv.css("overflow","auto");
		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
	} else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
    	$.ajax({
			url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
			type :"POST",
			data : JSON.stringify(param),
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var resStatus = data.statusCode;
				var message = data.message;
				if("200" == resStatus){
					var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
					var width=$("#file-display").width();
					var height=$("#file-display").height();
					$("#viewerPlaceHolder").css("width",width+"px");  
					$("#viewerPlaceHolder").css("height",height+"px");  
					$("#viewerPlaceHolder").css("display","block" );  

					var fp = new FlexPaperViewer(
					            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
					            'viewerPlaceHolder', 
					            {config : {
					                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
					                Scale : 1.5,//初始化缩放比例(1=100%)
					                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
					                ZoomTime : 0.5,//切换缩放比例延迟显示时间
					                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
					                FitPageOnLoad : false,//初始化时自适应页面
					                FitWidthOnLoad : false,//初始化时自适应宽度
					                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
					                ProgressiveLoading : true,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
					                MinZoomSize : 0.2,//最小缩放比例
					                MaxZoomSize : 5,//最大缩放比例
					                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
					                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
					                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
					                ZoomToolsVisible : true,//工具浪是否显示缩放工具
					                NavToolsVisible : true,//工具栏是否显示导航工具
					                CursorToolsVisible : true,//工具栏是否显示光标
					                SearchToolsVisible : true,//工具栏是否显示搜索工具
					                localeChain: 'zh_CN'//地区语言(en_US:English,)
					            	}
					            });
				} else {
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : message});
				}
			},
			error : function(data) {
				parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
			}
		});
	} else {
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "不支持在线预览的文档类型!"});
	}
}

</script>
</body>
</html>