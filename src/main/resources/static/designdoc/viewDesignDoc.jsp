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
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">数据刷新时间: </span>&nbsp;<span id="lastUpdateDate"></span></div>
                &nbsp;&nbsp;
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单号: </span>&nbsp;<span id="designNum"></span></div>
                &nbsp;&nbsp;
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单状态: </span>
                &nbsp;<span id="status" style="color:blue;cursor:pointer" onclick="showHis();"></span>
                </div>
                &nbsp;&nbsp;
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">审批状态: </span>
                &nbsp;<span id="audit" style="color:blue;cursor:pointer" onclick="showFlow();"></span>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_sry" defaultValue="设计文档" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计师: </span>
                <input type="text" id="designer" readonly /></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">采购员: </span>
                <input type="text" id="purchaseInCharge" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">物料编码: </span>
            	<input type="text" id="materialNumber" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">物料名称: </span>
            	<input type="text" id="materialDesc" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">尺寸: </span>
            	<input type="text" id="attribute1" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">材质工艺: </span>
            	<input type="text" id="attribute2" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">改版内容: </span>
            	<select id="changeContent" disabled>
            	   <option value="0">图案文字</option>
            	   <option value="1">材质工艺</option>
            	   <option value="2">尺寸</option>
            	   <option value="3">其他</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">版次: </span>
            	<input type="text" id="revision" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">变更编号: </span>
            	<input type="text" id="changeNumber" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">是否打样: </span>
            	<select id="makeSample" disabled>
            	   <option value="0">打样</option>
            	   <option value="1">不打样</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">制版处理: </span>
            	<select id="plateProcess" disabled>
            	   <option value="0">新制版</option>
            	   <option value="1">改版原版保留</option>
            	   <option value="2">改版原版作废</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">制版数量: </span>
            	<input type="text" id="plateQuantity" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">规格: </span>
            	<input type="text" id="materialSpec" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">产品经理: </span>
            	<input type="text" id="productManager" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">特殊要求: </span>
            	<input type="text" id="specRequirement" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">业务日期: </span>
            	<input type="text" id="orderDate" readonly /></div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
           <div class="tab-wrap" id="sheet-project">
           <ul>
	          <li><a href="#sheet-project-one"><i18n:I18n key="i18n_enquiry_title_fossfile" defaultValue="设计文件" /></a></li>
	          <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_fosss" defaultValue="供应商" /></a></li>
	       </ul>
		   <div id="sheet-project-one">
				<div class="box-wrap pos-relative bg-common">
					<div class="common-box-line p-zero">
						<div class="pos-relative upload-wrap">
							<div class="pos-absolute file-list">
								<main class="grid-container">
								<div class="grid-100">
									<table id="table-file"></table>
								</div>
								</main>
							</div>
							<div class="file-scan">
								<div class="file-option-zoom">
									<div class="dis-in-b text-left">
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
			<div id="sheet-project-two">
				<div class="box-wrap pos-relative bg-common">
					<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
					<input type="hidden" name="companyShortName" value="${companyShortName}"/>
					<input type="hidden" name="elsAccount" value="${elsAccount}"/>
            	    <input type="hidden" name="elsSubAccount" value="${elsSubAccount}"/>
            	    <input type="hidden" name="designNumber" id="designNumber" />
            	    <input type="hidden" name="stretegyCode" id="stretegyCode" />
					<main class="grid-container">
					    <div class="grid-100">
						    <table id="table-sale"></table>
					    </div>
					</main>
					</form>
				</div>
			</div>
			</div>
        </div>
<!--    <div id="sayingDialog" class="saying-dialog">
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
       </div> -->
    </div>
<script type="text/javascript">
var designNumber = "<%=request.getParameter("designNumber")%>";
var chatFromUrlFlag = false;
var flowCode = "";
var peopleList;
var $sob;
var itemGrid;
var saleGrid;
var cols_item = [
                 {title:"文件编号",name:"fileNumber",align:"center",width:80,hidden:true},
                 {title:"文件名称",name:"fileName",align:"center",width:120},
                 {title:"文件路径",name:"filePath",align:"center",width:120,hidden:true},
                 {title:"文件类别",name:"fileType",align:"center",width:120,renderer:function(val){
                	 if(val == "0")
                	     return "设计文件";
                	 else
                		 return "图片文件"; }
                 },
                 {title:"文件备注",name:"fbk1",align:"center",width:120},
                 {title:"上传人",name:"createUser",align:"center",width:100},
                 {title:"上传时间",name:"createDate",align:"center",width:130,renderer:function(val){
                	 if(!val)
                	     return "";
                	 else
                		 return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }
                 }
                ];
var cols_sale = [
                 {title:"ELS",name:"elsAccount",align:"center",width:120,hidden:true,renderer:function(){
                	 return elsAccount + "<input type='hidden' name='purchaseSupplierList[][elsAccount]' value='" + elsAccount + "'/>";}
                 },
                 {title:"供应商ELS",name:"toElsAccount",align:"center",width:120,renderer:function(val){
                	 return val + "<input type='hidden' name='purchaseSupplierList[][toElsAccount]' value='" + val + "'/>";}
                 },
                 {title:"供应商名称",name:"companyShortName",align:"center",width:140},
                 {title:"设计单号",name:"designNumber",align:"center",width:120,renderer:function(){
                	 return designNumber + "<input type='hidden' name='purchaseSupplierList[][designNumber]' value='" + designNumber + "'/>";}
                 },
                 {title:"供应商响应状态",name:"statusConfirm",align:"center",width:120,renderer:function(val){
                     var text = "";
                     if(val == 1)
                    	 text = "已接受";
                	 else if(val == 2)
                		 text = "已拒绝";
                     return text; }
                 }
                ];

$().ready(function(){
    $("#sheet-project").tabs();
/*  $sob = $('.saying-dialog .option-bar'); */
	init();
});

function init() {
	//加载数据
	initData();
	
	$("#btnDownloadFile").click(function(){
		var selectedRows = itemGrid.selectedRows();
		if(selectedRows.length == 0){
			alert("<i18n:I18n key="i18n_delivery_choosefilesssease" defaultValue="请选择文件" />",2);
			return;
		}
		var filePath = selectedRows[0].filePath;
		window.location.href = "<%=basePath%>servlet/downloadServlet?filePath=" + filePath;
	});
    
    $("#btnViewFile").click(function(){
    	var selectedRows = itemGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key="i18n_delivery_choossssplease" defaultValue="请选择文件" />",2);
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
					alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
				}
			}
		});
    	}else {
    		alert("该文件不支持在线预览，请下载查看",2);
    	}
    });
}

function initData(){
	var data = {"elsAccount":elsAccount,"designNumber":designNumber};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/DesignDocService/getDesignDoc",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			flowCode = data.flowCode;
			if(data.lastUpdateDate)
				$("#lastUpdateDate").text(new Date(data.lastUpdateDate).format("yyyy-MM-dd hh:mm:ss"));
			$("#designNum").text(data.designNumber);
			var status = "";
       	    if (data.orderStatus == 0) {
       	    	status = "设计师新建文档";
       	    	$("#abandBtn").show();
       	    }else if(data.orderStatus == 1){
    	    	status = "采购分配供应商";
    	    	$("#cancelBtn").show();
    	    	$("#abandBtn").hide();
    	    } else if(data.orderStatus == 2) 
    	    	status = "内部流程审核中";
    	      else if(data.orderStatus == 3) 
    	    	status = "供应商处理中";
    	      else if(data.orderStatus == 4) 
    	    	status = "已完结";
    	      else if(data.orderStatus == 5) 
    	    	status = "作废";
			$("#status").text(status);
       	    var audit = "";
    	    if (data.auditStatus == 0) 
    	    	audit = "审核通过";
    	    else if(data.auditStatus == 1) 
    	    	audit = "未开始审核";
    	    else if(data.auditStatus == 2) 
    	    	audit = "审核中";
    	    else if(data.auditStatus == 3) 
    	    	audit = "审核拒绝";
    	    $("#audit").text(audit);
			$("#designer").val(data.designer);
			$("#purchaseInCharge").val(data.purchaseInCharge);
			$("#materialNumber").val(data.materialNumber);
			$("#materialDesc").val(data.materialDesc);
			$("#attribute1").val(data.attribute1);
			$("#attribute2").val(data.attribute2);
			$("#changeContent").val(data.changeContent);
			$("#revision").val(data.revision);
			$("#changeNumber").val(data.changeNumber);
			$("#makeSample").val(data.makeSample);
			$("#plateProcess").val(data.plateProcess);
			$("#plateQuantity").val(data.plateQuantity);
			$("#materialSpec").val(data.materialSpec);
			$("#productManager").val(data.productManager);
			$("#specRequirement").val(data.specRequirement);
			if(data.orderDate)
				$("#orderDate").val(new Date(data.orderDate).format("yyyy-MM-dd"));
			//初始化文件列表
			initItemGrid(data.purchaseDesignFileList);
			//初始化分配供应商列表
			initSaleGrid(data.purchaseSupplierList);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function showFlow(){
    if (flowCode == null || flowCode == "" || flowCode == "00") {
		alert("<i18n:I18n key="i18n_delivery_nsssport" defaultValue="单据尚未开始审核" />",2);
	} else {
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'auditFlowList',
	        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
	        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=designDoc&businessId=' + designNumber,
	        windowMinWidth: 480,
	        windowMinHeight: 600,
	        'windowWidth':680,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
	}
}

function showHis(){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'viewDesignDocHis',
        'windowTitle':'<i18n:I18n key="ll" defaultValue="设计文档历史记录" />',
        'iframSrc':'<%=basePath%>designdoc/viewDesignDocHis.jsp?designNumber='+designNumber,
        'windowWidth':730,
        'windowHeight':450,
        'parentPanel':".currDesktop"
    });
}

function initItemGrid(fileList){
	var height=$(document).height()-368;
	if(!itemGrid){
		itemGrid = $('#table-file').mmGrid({
	        cols        : cols_item,
	        height      : height,
	        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items       : fileList
	    });
	}
}

function initSaleGrid(supplierList){
	var height=$(document).height()-368;
	if(!saleGrid){
		saleGrid = $('#table-sale').mmGrid({
	        cols        : cols_sale,
	        height      : height,
	        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items       : supplierList,
	        multiSelect:true,
	        checkCol:true
	    });
	}
/* 	saleGrid.on('loadSuccess',function(e, data) {
		if(saleGrid.rowsLength() > 0){
			saleGrid.select(0);//默认选中第一行
			var selectedRows = saleGrid.selectedRows();
			if(selectedRows && selectedRows.length) {
				initChat(selectedRows);// 动态加载聊天窗口
				if($sob[0].toggleState)
					$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
	            $sob.click();
			}
		}
	});
	saleGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
		// 动态加载聊天窗口
		var hadSelected = saleGrid.selectedRows();
		if(hadSelected && hadSelected.length) {
			initChat(hadSelected);
    	}
	}); */
}

//初始化聊天窗口
//ELS账号+设计单号 作为 businessID
//TODO: 多人聊天需要传值 peopleList
function initChat(data) {
	var elsAccount ='<%=session.getAttribute("elsAccount") %>',
	  elsSubAccount ='<%=session.getAttribute("elsSubAccount") %>',
	  toElsAccount = '',
	  toElsSubAccount ='';
	  var businessId = '';
	  var peopleList = [];
	  if(data) {
		  data.forEach(function(d,i){
			  toElsAccount = d.toElsAccount;
			  toElsSubAccount = d.fbk1?d.fbk1:"";
			  businessId=''+ designNumber;
			  var obj={};
			  obj.name = d.companyShortName;
			  peopleList.push(obj);
			});
	  }
	  var peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  var url = "multiChat.jsp?type=multi&fromElsAccount=" + elsAccount
				+ "&fromElsSubAccount=" + elsSubAccount
				+ "&toElsAccount=" + toElsAccount
				+ "&toElsSubAccount="+toElsSubAccount
				+ "&businessType=designDoc"
				+ "&businessID="+businessId
              + "&list="+encodeURI(peopleListString)
				+ "&t="+new Date().getTime();
	   
	   $(".testIframe").attr("src","${pageContext.request.contextPath}/"+ url);
	   //滚动条美化niceScroll
	   $(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
}
</script>
</body>
</html>