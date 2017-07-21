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
				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<base:audit elsSubAccount="${elsSubAccount }" businessElsAccount="${param.businessElsAccount }" businessId="${param.designNumber }" elsAccount="${elsAccount }" businessType="designDoc">
				<button id="passBtn" class="todo button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
				<button id="noPassBtn" class="todo button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
				</base:audit>
				<button id="cancelBtn" class="done button-wrap"><i18n:I18n key="i18n_undo_Ress" defaultValue="撤回" /></button>
				<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_approval_flow" defaultValue="流程" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		   </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_sry" defaultValue="设计文档" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计师: </span>
                <input type="text" id="designer" readonly /></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">采购员: </span>
                <input type="text" id="purchaseInCharge" readonly /></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单号: </span>
                <input type="text" id="designNum" readonly /></div>
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
	          <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_fosss" defaultValue="分配供应商" /></a></li>
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
					<main class="grid-container">
					    <div class="grid-100">
						    <table id="table-sale"></table>
					    </div>
					</main>
				</div>
			</div>
			</div>
        </div>
    </div>
    <form id="auditForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
	<input type="hidden" name="companyShortName" value="${companyShortName}"/>
	<input type="hidden" name="elsAccount" value="${elsAccount}"/>
    <input type="hidden" name="elsSubAccount" value="${elsSubAccount}"/>
    <input type="hidden" name="userName" value="${username}"/>
    <input type="hidden" name="designNumber" id="designNumber" />
    <input type="hidden" name="businessElsAccount" id="businessElsAccount">
    <input type="hidden" name="purchaseInCharge" id="purchaseInChargeHidden"> 
	<div class="fixed-dialog">
			<div class="dialog-tip bg-common">
				<div class="dialog-close-btn"></div>
				<div class="tip-head">
					<img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" /> <span
						id="dialogTitle"><i18n:I18n key="i18n_title_fillOpinion" defaultValue="填写审批意见" /></span>
				</div>
				<div>
					<div class="box-wrap pos-relative bg-common">
						<div class="common-box-line">
							<textarea id="auditOpinion" name="auditOpinion" style="width:95%;" rows="5" maxlength="200"></textarea>
							<div class="mt-20">
								<button id="btnFileOK1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
								<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
								<button id="btnFileCancel1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
	</form>
<script type="text/javascript">
var designNumber = "<%=request.getParameter("designNumber")%>";
var businessElsAccount = "<%=request.getParameter("businessElsAccount")%>";
var auditType = "<%=request.getParameter("auditType")%>";
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
                 }
                ];

$().ready(function(){
    $("#sheet-project").tabs();
    $("#designNumber").val(designNumber);
    $("#businessElsAccount").val(businessElsAccount);
    if (auditType == "todo") {
    	$(".todo").show();
    	$(".done").hide();
    } else {
    	$(".todo").hide();
    	$(".done").show();
    }
	init();
});

function init() {
	//加载数据
	initData();
	
	$('.dialog-close-btn').click(function(){
	    $('.fixed-dialog').hide();
	});
	
	$('.tip-option-btn').click(function(){
	    $('.dialog-close-btn').trigger('click');
	});
	
	$("#passBtn").click(function(){
		$(".fixed-dialog").show();
		$(".dialog-tip").height(275);
		$("#auditOpinion").attr("readOnly",false);
		$("#btnFileOK1").show();
		$("#btnFileOK2").hide();
	});
	
	$("#noPassBtn").click(function(){
		$(".fixed-dialog").show();
		$(".dialog-tip").height(275);
		$("#auditOpinion").attr("readOnly",false);
		$("#btnFileOK1").hide();
		$("#btnFileOK2").show();
	});
	
	$("#btnFileOK1").click(function(){
		pass();
	});
	
	$("#btnFileOK2").click(function(){
		nopass();
	});
	
	$("#cancelBtn").click(function(){
		cancel();
	});
	
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback());
		} else {
			parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
		}
	});
	
	$("#flowBtn").click(function(){
		var targetElsAccount = businessElsAccount;
		var businessType = "designDoc";
		var businessId = designNumber;
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'auditFlowList',
	        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
	        windowMinWidth: 480,
	        windowMinHeight: 600,
	        'windowWidth':680,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	
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
	var data = {"elsAccount":businessElsAccount,"designNumber":designNumber};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/DesignDocService/getDesignDoc",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			$("#designer").val(data.designer);
			$("#purchaseInCharge").val(data.purchaseInCharge);
			$("#designNum").val(data.designNumber);
			$("#purchaseInChargeHidden").val(data.purchaseInCharge);
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
	        items       : supplierList
	    });
	}
}

function pass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/DesignDocService/sendPass",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "401") {
					alert("<i18n:I18n key="xxx" defaultValue="行项目未全部通过不能审批通过" />",3);
				} else if (data.status == "403") {
					alert("<i18n:I18n key="i18n_audit_noauthority" defaultValue="没有审批权限" />",3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}

function nopass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditrefuse" defaultValue="确认要审批拒绝吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/DesignDocService/sendNoPass",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}});
}

function cancel() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confisssuditcancel" defaultValue="确认要撤回吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var param = {"businessElsAccount":businessElsAccount,"designNumber":designNumber,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"orderStatus":2};
		$.ajax({
			url :"<%=basePath%>rest/DesignDocService/cancelAudit",
			type :"post",
			contentType : "application/json",
			data: JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "401") {
					alert("<i18n:I18n key="xx" defaultValue="流程结束的单据不能撤回" />",2);
				} else if (data.status == "403") {
					alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤回" />",2);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}
function closeCallback() {
	if (parent.frames["iframeApp_auditList"]) {
		parent.frames["iframeApp_auditList"].query();
	}
}
</script>
</body>
</html>