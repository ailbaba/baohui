<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative ">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="saveBtn" class="button-wrap">保存</button>
                <button id="commitBtn" class="button-wrap">发送</button>
                <button id="abandBtn" class="back button-wrap">作废</button>
                <button id="cancelBtn" class="back button-wrap">撤回</button>
            </div>
        </div>
        <div class="showText box-wrap pos-relative bg-common">
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">数据刷新时间: </span>&nbsp;<span id="lastUpdateDate"></span></div>
                &nbsp;&nbsp;
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单号: </span>&nbsp;<span id="designNum"></span></div>
                &nbsp;&nbsp;
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单状态: </span>
                &nbsp;<span id="status" style="color:blue;cursor:pointer" onclick="showHis();"></span>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <form style="margin:0;" id="form" onsubmit="return false;">
            	<input type="hidden" name="elsAccount" value="${elsAccount}"/>
            	<input type="hidden" name="elsSubAccount" value="${elsSubAccount}"/>
            	<input type="hidden" name="userName" value="${username}"/>
            	<input type="hidden" id="designNumber" name="designNumber"/>
            	<input type="hidden" id="orderStatus" name="orderStatus"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计师: </span>
                <select id="designerSelector" name="designer">
				</select>
                </div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">采购员: </span>
                <select id="purchaseInChargeSelector" name="purchaseInCharge">
				</select>
                </div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">物料编码: </span><input type="text" id="materialNumber" name="materialNumber"/></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">物料名称: </span><input type="text" id="materialDesc" name="materialDesc" readonly/></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">尺寸: </span><input type="text" id="attribute1" name="attribute1" readonly/></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">材质工艺: </span><input type="text" id="attribute2" name="attribute2" readonly/></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">改版内容: </span>
            	<select id="changeContent" name="changeContent" onchange="fillChangeNumber()">
            	   <option value="">请选择</option>
            	   <option value="0">图案文字</option>
            	   <option value="1">材质工艺</option>
            	   <option value="2">尺寸</option>
            	   <option value="3">其他</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">版次: </span><input type="text" id="revision" name="revision" readonly/></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">变更编号: </span><input type="text" id="changeNumber" name="changeNumber" readonly/></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">是否打样: </span>
            	<select id="makeSample" name="makeSample">
            	   <option value="0">打样</option>
            	   <option value="1">不打样</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">制版处理: </span>
            	<select id="plateProcess" name="plateProcess">
            	   <option value="0">新制版</option>
            	   <option value="1">改版原版保留</option>
            	   <option value="2">改版原版作废</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">制版数量: </span><input type="text" id="plateQuantity" name="plateQuantity"/></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">规格: </span><input type="text" id="materialSpec" name="materialSpec"/></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">产品经理: </span><input type="text" id="productManager" name="productManager"/></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">特殊要求: </span><input type="text" id="specRequirement" name="specRequirement"/></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">业务日期: </span><input type="text" id="orderDate" name="orderDate" class="Wdate" onfocus="WdatePicker()"/></div>
            </div>
            </form>
        </div>
        <div class="box-wrap pos-relative bg-common">
           <div class="tab-wrap" id="sheet-project">
           <ul>
	          <li><a href="#sheet-project-one"><i18n:I18n key="i18n_enquiry_title_fossfile" defaultValue="设计文件" /></a></li>
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
										<button id="btnAddFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button>
<%-- 									<button id="btnModifyFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改文件" /></button> --%>
										<button id="btnDeleteFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button>
									</div>
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
    <div class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../icon/els.PNG" /> <span
					id="dialogTitle"><i18n:I18n key="i18n_common_button_asile" defaultValue="上传设计文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_ssme" defaultValue="文件详情" /></span>
					<form style="margin:0;" id="fileForm" onsubmit="return false;">
					    <input type="hidden" name="elsAccount" value="${elsAccount}"/>
            	        <input type="hidden" name="elsSubAccount" value="${elsSubAccount}"/>
            	        <input type="hidden" id="designNumber_file" name="designNumber"/>
            	        <input type="hidden" id="fileNumber" name="fileNumber" value="0"/>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_ssename" defaultValue="文件名称" />：</span>
							<input id="fileName" name="fileName" type="text" />
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_ssename" defaultValue="文件备注" />：</span>
							<input id="fbk1" name="fbk1" type="text" />
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_fsssetype" defaultValue="文件类别" />：</span> 
            	            <input type="radio" name="fileType" value="0" checked>设计文件
            	            <input type="radio" name="fileType" value="1">图片文件
						</div>
						<div class="input-and-tip">
						<span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_sormfile" defaultValue="选择文件" /></div></span>
<!-- 							<button id="btnFileUpload" class="btn btnUpload"></button> -->
							&nbsp;
							<span id="file"></span>
							<input id="filePath" name="filePath" type="hidden" />
						</div>
					</div>
					</form>
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
var designNumber = "<%=request.getParameter("designNumber")%>";
var lastFileName = "";
var date = new Date().format("yyyy-MM-dd");
var itemGrid;
var cols_item = [/* {title:"操作",name:"fileNumber",align:"center",width:154,renderer:function(val,item,rowIndex){
	             return "<a style='color:blue;' href=\"javascript:downLoadFile('"+item.filePath+"');\">下载</a>" + 
	                    "&nbsp;&nbsp;" +
	                    "<a style='color:red;' href=\"javascript:deleteFile("+val+","+rowIndex+");\">删除</a>";
                 }}, */
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
                 }];
var fileUploader;
                 
$().ready(function(){
    $("#sheet-project").tabs();
    $(".back").hide();
    $(".showText").hide();
	init();
});
function checkValid() {
	if ($("#materialNumber").val()==""){
		alert("请选择物料",2);
		return false;
	}
	if ($("#changeContent").val()==""){
		alert("请选择改版内容",2);
		return false;
	}
	var plateQuantity = $("#plateQuantity").val();
	if (plateQuantity==""||isNaN(plateQuantity)) {
		alert("请输入有效的制版数量",2);
		return false;
	}
	return true;
}
function init() {
	if(designNumber && designNumber != "")
		initData();
	else{
		$("#orderDate").val(date);
		var height=$(document).height()-368;
		if(!itemGrid){
			itemGrid = $('#table-file').mmGrid({
		        cols        : cols_item,
		        height      : height,
		        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        items       : []
		    });
		}
		//初始化下拉框
	    initDesignerSelector("");
	    initPurchaseInChargeSelector("");
	}
	$("#saveBtn").click(function(){
		if (!checkValid()) {
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_xx" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			var url = "<%=basePath%>rest/DesignDocService/createDesignDoc";
			var designNumber = $("#designNumber").val();
			if(designNumber != "")
				url = "<%=basePath%>rest/DesignDocService/updateDesignDoc";
			$("#orderStatus").val(0);
			var frm = $("#form");
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					$("#designNumber").val(data.designNumber);
					$("#designNumber_file").val(data.designNumber);
					alert("<i18n:I18n key="i18n_alert_xxx" defaultValue="操作成功" />");
					parent.elsDeskTop.closeCurWin('createDesignDoc',closeCallback);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		}});
	});
	
	$("#commitBtn").click(function(){
		if (!checkValid()) {
			return;
		}
		if (itemGrid.rowsLength() == 0) {
			alert("请上传设计文件",2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认提交？',closeEvent:function(){
			var url = "<%=basePath%>rest/DesignDocService/createDesignDoc";
			var designNumber = $("#designNumber").val();
			if(designNumber != "")
				url = "<%=basePath%>rest/DesignDocService/updateDesignDoc";
			$("#orderStatus").val(1);
			var frm = $("#form");
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					$("#designNumber").val(data.designNumber);
					$("#designNumber_file").val(data.designNumber);
					alert("<i18n:I18n key="i18n_alert_stretegyxxx" defaultValue="操作成功" />");
					parent.elsDeskTop.closeCurWin('createDesignDoc',closeCallback);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		}});	
	});
	
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('createDesignDoc',closeCallback);
	});
	
	$("#cancelBtn").click(function(){
		var param = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"userName":username,"designNumber":designNumber,"orderStatus":0};
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/DesignDocService/rollBackDesignDoc",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key="i18n_delivery_revoksssuccess" defaultValue="操作成功" />");
					parent.elsDeskTop.closeCurWin('createDesignDoc',closeCallback);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						if (data.status == "401")
							alert("<i18n:I18n key="i18n_audit_sssantcancel" defaultValue="采购员已分配供应商,不能撤回" />",2);
						else
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		}});
	});
	
	$("#abandBtn").click(function(){
		var param = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"designNumber":designNumber,"userName":username,"orderStatus":5};
		updateDesignDocStatus(param);
	});
	
	$("#materialNumber").click(function(){
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'chooseMaterial',
	        'windowTitle':'<i18n:I18n key="ll" defaultValue="选择物料" />',
	        'iframSrc':'<%=basePath%>designdoc/chooseMaterial.jsp',
	        'windowWidth':680,
	        'windowHeight':430,
	        'parentPanel':".currDesktop"
	    });
	});
	
	$("#attribute2").click(function(){
		var readonly = $(this).attr("readonly");
		if(readonly)
			return;
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'chooseMaterialTechnics',
	        'windowTitle':'<i18n:I18n key="ll" defaultValue="选择材质工艺" />',
	        'iframSrc':'<%=basePath%>designdoc/chooseMaterialTechnics.jsp',
	        'windowWidth':580,
	        'windowHeight':430,
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
	
	$('#btnAddFile').click(function() {
		var designNumber = $("#designNumber_file").val();
		if(designNumber == ""){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'请先保存设计文档,是否确认保存？',closeEvent:function(){
				setTimeout(function(){
					if (!checkValid()) {
						return;
					}
					var url = "<%=basePath%>rest/DesignDocService/createDesignDoc";
					var designNumber = $("#designNumber").val();
					if(designNumber != "")
						url = "<%=basePath%>rest/DesignDocService/updateDesignDoc";
					$("#orderStatus").val(0);
					var frm = $("#form");
					parent.elsDeskTop.showLoading();
					$.ajax({
						url : url,
						type :"post",
						contentType : "application/json",
						data : JSON.stringify(frm.serializeJSON()),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							$("#designNumber").val(data.designNumber);
							$("#designNumber_file").val(data.designNumber);
                            //显示新增文件窗口
					        $('.fixed-dialog').show();
					        initAddFileDialog();
					        initFileUploader();
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							if (!permissionError(data)) {
								alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
							}
						}
					});
				},200);
			}});
		}else{
	        $('.fixed-dialog').show();
	        initAddFileDialog();
	        initFileUploader();
		}
	});
	
    $("#btnDeleteFile").click(function(){
    	var selectedIndexs = itemGrid.selectedRowsIndex();
    	if (selectedIndexs.length == 0) {
    		alert("<i18n:I18n key="i18n_delivery_choosefilepsse" defaultValue="请选择文件" />",2);
    		return;
    	}
		var rowIndex = selectedIndexs[0];
    	var selectedRow = itemGrid.row(rowIndex);
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认删除?',closeEvent:function(){
			var designNumber = $("#designNumber").val();
			var fileNumber = selectedRow.fileNumber;
			var data = {"elsAccount":elsAccount,"designNumber":designNumber,"fileNumber":fileNumber};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/DesignDocService/deleteDesignFile",
				dataType : "json",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					itemGrid.removeRow(rowIndex);
					alert("操作成功");
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		}});
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
	
    $('.dialog-close-btn').click(function(){
        $('.fixed-dialog').hide();
    });
    $('.tip-option-btn').click(function(){
        $('.dialog-close-btn').trigger('click');
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
			$(".showText").show();
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
    	    	$("#saveBtn").hide();
    	    	$("#commitBtn").hide();
    	    } else if(data.orderStatus == 2) 
    	    	status = "内部流程审核中";
    	      else if(data.orderStatus == 3) 
    	    	status = "供应商处理中";
    	      else if(data.orderStatus == 4) 
    	    	status = "已完结";
    	      else if(data.orderStatus == 5) 
    	    	status = "作废";
			$("#status").text(status);
			$("#designNumber").val(data.designNumber);
			$("#designNumber_file").val(data.designNumber);
			$("#materialNumber").val(data.materialNumber);
			$("#materialDesc").val(data.materialDesc);
			$("#attribute1").val(data.attribute1);
			$("#attribute2").val(data.attribute2);
			$("#changeContent").val(data.changeContent);
			if(data.changeContent == 1 || data.changeContent == 2){
				if(data.changeContent == 1){
					$("#attribute2").attr("readonly",false);
					$("#attribute2").unbind("click").click(function(){
						//兼容ie 冒泡事件
					    if (event && event.preventDefault) {
					        event.preventDefault();
					        event.stopPropagation();
					    } else {
					        window.event.returnValue = false;
					    }
					    parent.elsDeskTop.defineWin({
					        'iconSrc':'icon/els-icon.png',
					        'windowsId':'chooseMaterialTechnics',
					        'windowTitle':'<i18n:I18n key="ll" defaultValue="选择材质工艺" />',
					        'iframSrc':'<%=basePath%>designdoc/chooseMaterialTechnics.jsp',
					        'windowWidth':580,
					        'windowHeight':430,
					        'parentPanel':".currDesktop"
					    });
					});
					$("#attribute1").attr("readonly",true);
				}else{
					$("#attribute2").unbind("click");
					$("#attribute2").attr("readonly",true);
					$("#attribute1").attr("readonly",false);
				}
			}
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
			//初始化下拉框
		    initDesignerSelector(data.designer);
		    initPurchaseInChargeSelector(data.purchaseInCharge);
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

function initDesignerSelector(designer){
	$("#designerSelector").empty();
	var html = "";
	var data = {"elsAccount":elsAccount,"roleCode":"designer"};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/AccountService/findSubAccountsByRole",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			var rows = data.rows;
			for (var i=0;i<rows.length;i++){
				var row = rows[i];
				html += "<option value='"+row.elsSubAccount+"_"+row.name+"'>" + row.elsSubAccount+"_"+row.name + "</option>";
			}
			$("#designerSelector").append(html);
			if(designer != "")
				$("#designerSelector").val(designer);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function initPurchaseInChargeSelector(purchaseInCharge){
	$("#purchaseInChargeSelector").empty();
	var html = "";
	var data = {"elsAccount":elsAccount,"roleCode":"purchase"};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/AccountService/findSubAccountsByRole",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			var rows = data.rows;
			for (var i=0;i<rows.length;i++){
				var row = rows[i];
				html += "<option value='"+row.elsSubAccount+"_"+row.name+"'>" + row.elsSubAccount+"_"+row.name + "</option>";
			}
			$("#purchaseInChargeSelector").append(html);
			if(purchaseInCharge != "")
				$("#purchaseInChargeSelector").val(purchaseInCharge);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function fillChangeNumber() {
	var revision = $("#revision").val();
	var changeContent = $("#changeContent").val();
	if(changeContent == 1 || changeContent == 2){
		$("#changeNumber").val(revision + "SIZE/ART");
		if(changeContent == 1){
			$("#attribute2").attr("readonly",false);
			$("#attribute2").unbind("click").click(function(){
				//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'chooseMaterialTechnics',
			        'windowTitle':'<i18n:I18n key="ll" defaultValue="选择材质工艺" />',
			        'iframSrc':'<%=basePath%>designdoc/chooseMaterialTechnics.jsp',
			        'windowWidth':580,
			        'windowHeight':430,
			        'parentPanel':".currDesktop"
			    });
			});
			$("#attribute1").attr("readonly",true);
		}else{
			$("#attribute2").unbind("click");
			$("#attribute2").attr("readonly",true);
			$("#attribute1").attr("readonly",false);
		}
	}else {
		if(changeContent != "")
			$("#changeNumber").val(revision + "OTHER");
		else
			$("#changeNumber").val("");
	}	
}

function fillMaterialInfo(item) {
	$("#materialNumber").val(item.materialNumber);
	$("#materialDesc").val(item.materialName);
	$("#attribute1").val(item.fbk3);
	$("#attribute2").val(item.fbk4);
	$("#changeNumber").val("");
	var revisionNum = item.fbk8.replace(/[^0-9]/ig,"");
	revisionNum = parseInt(revisionNum) + 1;
	var revision = item.fbk8.replace(/\d+/g,revisionNum);
	$("#revision").val(revision);
	fillChangeNumber();
}

function fillMaterialTechnic(item) {
	$("#attribute2").val(item.materialNumber + "_" + item.materialName);
}

function closeCallback(){
 	if (parent.frames["iframeApp_designDocManageForDesigner"]) {
		parent.frames["iframeApp_designDocManageForDesigner"].query();
	}
}

function initFileUploader(){
  	fileUploader = WebUploader.create({
  	    // swf文件路径
  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
  	  	duplicate :true,
  	    auto: true,
  	    // 文件接收服务端。
  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
  	    // 选择文件的按钮。可选。
  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
  	    pick: '#btnFileUpload',
  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
  	    resize: false
  	});
  	fileUploader.on('uploadAccept', function( obj, response ) {
  	  	if(0 == response.error){
  	  	   var fileName = $("#fileName").val();
  	  	   if(fileName == "" || fileName == lastFileName){
  	  		 $("#fileName").val(obj.file.name);  
  	  		 lastFileName = obj.file.name;
  	  	   }
/*   	   $("#file").text(obj.file.name); */
   	       $("#filePath").val(response.url);
/*  	   var filePath = response.url;
   	       var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
  	       $("#fileType").val(fileType);*/
  	  	}else{
  	  		alert(response.message,2);
  	  	}
  	});
}

function initAddFileDialog(){
	$(".dialog-tip").height(240);
	$("#fileName").attr("readonly",false);
    $("#filePath").val("");
    $("#file").text("");
    $("input[name='fileType']").eq(0).attr("checked","checked");
    $("input[name='fileType']").eq(1).removeAttr("checked");
    $("#fileName").val("");
	$("#fbk1").val("");
	lastFileName = "";
    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_xx" defaultValue="上传设计文件" />');
    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_choosssmfile" defaultValue="选择文件" />');
    $("#btnFileOK").unbind("click");
    $("#btnFileOK").click(function(){addFile();});
}

function addFile(){
	var fileName = $("#fileName").val();
	if (!fileName) {
		alert("<i18n:I18n key='i18n_delivery_enterfilename' defaultValue='请填写文件名称' />",2);
		return;
	}
	var filePath = $("#filePath").val();
	if(!filePath){
		alert("<i18n:I18n key='i18n_delivery_uploasssplease' defaultValue='请选择文件' />",2);
		return;
	}
	var fileNumber = $("#fileNumber").val();
	$("#fileNumber").val(parseInt(fileNumber)+1);
	var frm = $("#fileForm");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/DesignDocService/addDesignFile",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			itemGrid.addRow(data,itemGrid.rowsLength());
			alert("操作成功");
			$('.fixed-dialog').hide();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function initModifyFileDialog(){
	$("#fileName").attr("readonly",true);
    $("#filePath").val();
    $("#fileType").val();
    if(orderItemNumber){
    	$(".dialog-tip").height(270);
    	$("#operTypeSelector").val("1");
    	loadOrderItem();
    	$("#orderItemSelector").val(orderItemNumber);
    }else{
    	$(".dialog-tip").height(240);
    	$("#operTypeSelector").val("0");
        $("#orderItemSelector").empty();
        $("#divOrderItem").hide();
    }
	$("#fileName").val(fileName);
    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改表单文件" />');
    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_rechooseformfile" defaultValue="重传文件" />');
    $("#btnFileOK").unbind("click");
    $("#btnFileOK").click(function(){modifyFormFile();});
}
function updateDesignDocStatus(param){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/DesignDocService/updateDesignDoc",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key="i18n_delivery_revoksssuccess" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('createDesignDoc',closeCallback);
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
</script>
</body>
</html>