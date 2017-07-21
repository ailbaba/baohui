<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String businessElsAccount = request.getParameter("businessElsAccount");
String contractNumber = request.getParameter("contractNumber");
%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<script type="text/javascript">
</script>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<base:audit elsSubAccount="${elsSubAccount }" businessElsAccount="${param.businessElsAccount }" businessId="${param.contractNumber }" elsAccount="${elsAccount }" businessType="contract">
				<button id="passBtn" class="todo button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
				<button id="noPassBtn" class="todo button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
				<script type="text/javascript">
					hasRight = true;
				</script>
				</base:audit>
				<button id="cancelBtn" class="done button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
				<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_approval_flow" defaultValue="查看流程" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	<form id="auditForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="elsAccount" value="${elsAccount }">
		<input type="hidden" name="elsSubAccount" value="${elsSubAccount }">
		<input type="hidden" name="businessElsAccount" value="<%=businessElsAccount%>">
		<input type="hidden" name="contractNumber" value="<%=contractNumber%>">
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="采购合同头信息" key="i18n_common_title_purchaseContractHeadInfo"/></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="headTable"></table>
                    </div>
               </main>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="采购合同详细信息" key="i18n_common_title_purchaseContractDetailInfo"/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="合同条款信息" key="i18n_common_title_contractClauseInfo"/></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n defaultValue="合同物料信息" key="i18n_common_title_contractMaterialInfo"/></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n defaultValue="合同附件" key="i18n_common_title_contractFile"/></a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="reCreate">
		                        <table id="clauseTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="receiptDiv">
		                        <table id="materialTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-three">
	                  <div class="box-wrap pos-relative bg-common">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<div class="file-list-head">
					                   <select id="selectFileType" name="selectFileType" style="width: 165px;">
					                   <option value="all"><i18n:I18n defaultValue="所有文件" key="i18n_common_select_filetype_all"/></option>
					                   <option value="common"><i18n:I18n defaultValue="公共文件" key="i18n_common_select_filetype_public"/></option>
					                   <%-- <option value="2"><i18n:I18n defaultValue="行项目文件" key="i18n_busRecon_select_fileType_line"/></option> --%>
					                   </select>
					                 </div>
									<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="fileTable" style="width: 300px;"></table>
										</div>
									</main>
			                    </div>
				                 <div class="file-scan">
		   							<div class="file-option-zoom">
					                  <div class="dis-in-b text-left">
							             <button id="addFileBtn" class="btn"><i18n:I18n defaultValue="刷新" key="i18n_common_button_refresh"/></button>
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
					<img class="icon" src="../../icon/els.PNG" /> <span
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
var auditType = "${param.auditType}";
var elsAccount = "<%=businessElsAccount%>";
var contractNumber = "<%=contractNumber%>";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var headGrid;
var itemGrid;
var fileGrid;
if (contractNumber == "null") {
	contractNumber = "";
}

//表格渲染

	//业务类型
var showBusinessTypeRenderer = function (val,item,index){
	//0:业务类型0  1:业务类型1 2:业务类型2
	if (val == "0") return '<i18n:I18n key="" defaultValue="机械" />'
	else if(val == "1") return '<i18n:I18n key="" defaultValue="电商" />'
	else return '<i18n:I18n key="" defaultValue="农业" />'
};

	//合同状态
var showContractStatusRenderer = function (val,item,index){
		//0:新建 1:提交审批 2:采购方已确认 3:销售方已确认 4:已归档 5:已完结
	if (val == "0") return '<i18n:I18n key="i18n_common_button_create" defaultValue="新建" />'
	else if(val == "1") return '<i18n:I18n key="i18n_approval_report" defaultValue="提交审批" />'
	else if(val == "2") return '<i18n:I18n key="i18n_additionCost_additionCostStatus_purchaseConfirm" defaultValue="采购方已确认" />'
	else if(val == "3") return '<i18n:I18n key="i18n_additionCost_additionCostStatus_saleConfirm" defaultValue="销售方已确认" />'
	else if(val == "4") return '<i18n:I18n key="i18n_additionCost_additionCostStatus_pigeonholed" defaultValue="已归档" />'
	else return '<i18n:I18n key="i18n_additionCost_additionCostStatus_end" defaultValue="已完结" />'
};

	//发送状态
var showSendStatusRenderer = function (val,item,index){
		//0:未发送 1:已发送 2:新接收
	if (val == "0") return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />'
	else if(val == "1") return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />'
	else return '<i18n:I18n key="i18n_common_select_sendstatus_newReception" defaultValue="新接收" />'
};

	//审批状态
var showAuditStatusRenderer = function (val,item,index){
		//0:审批通过 1:未审批 2:审批中 3:审批拒绝
	if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" />'
	else if(val == "1") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />'
	else if(val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />'
	else return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />'
};

//采购合同头表格
var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractHeadManage"/>;
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractHead",
	method :  "POST",
	cols : headCols,
	autoLoad : false,
	root : "rows",
	height : 120,
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
});

var clauseCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractClauseManage"/>;
var clauseGrid = $("#clauseTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractClause",
    method:  "POST",
    cols : clauseCols,
    autoLoad : false,
    root:"rows",
    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
});

var materialCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractMaterialManage"/>;
var materialGrid = $('#materialTable').mmGrid({
    cols : materialCols,
    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractMaterial",
    method : 'post',
    root : "rows",
    autoLoad : false,
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
});

var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractFileManage"/>;
var fileGrid = $("#fileTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractFile",
    method : "post",
    cols : fileCols,
    autoLoad : false,
    root : "rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    fullWidthRows :true,
});

$().ready(function(){
	$("button").button();
    $("#sheet-project").tabs();

	var queryParam = {
			elsAccount : elsAccount,
			contractNumber : contractNumber
		};
	$.extend(headGrid.opts.params,queryParam);
	headGrid.load();
	
	if (auditType == "todo") {
		$(".todo").show();
		$(".done").hide();
	} else {
		$(".todo").hide();
		$(".done").show();
	}
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
	$("#flowBtn").click(function(){
		flow();
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
	$('.dialog-close-btn').click(function(){
        $('.fixed-dialog').hide();
    });
    $('.tip-option-btn').click(function(){
        $('.dialog-close-btn').trigger('click');
    });

});
function closeCallback() {
	if (parent.frames["iframeApp_auditList"]) {
		parent.frames["iframeApp_auditList"].query();
	}
}

headGrid.on("loadSuccess",function(e, data) {
	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
		headGrid.select(0);//默认选中第一行
		var record = data.rows[0];
        //根据头表选中项加载对应行,文件等信息
		loadClause(record.elsAccount,record.contractNumber);
		loadFile(record.elsAccount,record.contractNumber);
		loadMaterial(record.elsAccount,record.contractNumber);
	}else{
		clearChildTables();
	}
});
fileGrid.on("loadSuccess", function(e, data){
	reGenFileTypeSelect();
});
fileGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
	var filePath = item.contractFilePath;
	previewFile(filePath);
});

function loadClause(elsAccount,contractNumber) {
var queryParam = {
	elsAccount : elsAccount,
	contractNumber : contractNumber
};
$.extend(clauseGrid.opts.params,queryParam);
clauseGrid.load();
}

function loadFile(elsAccount,contractNumber) {
var queryParam = {
	elsAccount : elsAccount,
	contractNumber : contractNumber
};
$.extend(fileGrid.opts.params,queryParam);
fileGrid.load();
}

function loadMaterial(elsAccount,contractNumber){
var queryParam = {
	elsAccount : elsAccount,
	contractNumber : contractNumber
};
$.extend(materialGrid.opts.params,queryParam);
materialGrid.load();
}

function clearChildTables(){
if(clauseGrid.rowsLength() > 0){
	for(var i=clauseGrid.rowsLength();i-1>=0;i--){
		clauseGrid.removeRow(i-1);
	}
}	
if(fileGrid.rowsLength() > 0){
	for(var i=fileGrid.rowsLength();i-1>=0;i--){
		fileGrid.removeRow(i-1);
	}
}	
if(materialGrid.rowsLength() > 0){
	for(var i=materialGrid.rowsLength();i-1>=0;i--){
		materialGrid.removeRow(i-1);
	}
}
}

function reGenFileTypeSelect(){
var fileTypeSelect = $("#selectFileType");
fileTypeSelect.empty();
$("<option value='all'><i18n:I18n defaultValue='所有' key='i18n_common_option_all'/></option>").appendTo(fileTypeSelect);
$("<option value='common'><i18n:I18n defaultValue='公共' key='i18n_common_option_common'/></option>").appendTo(fileTypeSelect);
for(var i=0;i<materialGrid.rowsLength();i++){
	var contractItemNumber = materialGrid.row(i).contractItemNumber;
	$("<option value='"+contractItemNumber+"'>"+contractItemNumber+"</option>").appendTo(fileTypeSelect);//文件下拉列表添加行项目选项
}
}


function pass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/ContractManageService/sendPurchaseContractPass",
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
					alert("<i18n:I18n key="i18n_audit_afteritemsallpass" defaultValue="订单行项目未全部通过不能审批通过" />",3);
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
			url :"<%=basePath%>rest/ContractManageService/sendPurchaseContractNoPass",
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
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditcancel" defaultValue="确认要撤销审批吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/ContractManageService/cancelAudit",
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
					alert("<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />",3);
				} else if (data.status == "403") {
					alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}

function flow() {
	var targetElsAccount = "${param.businessElsAccount }";
	var businessType = "contract";
	var businessId = "${param.contractNumber }";
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
}
//在线预览文件
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
					alert(message,3); 
				}
			},
			error : function(data) {
				alert(data.message,3); 
			}
		});
	} else {
		alert("<i18n:I18n defaultValue='不支持在线预览的文档类型' key='i18n_alert_filetypenotsupport'/>!",3);
	}
}
</script>
</body>
</html>