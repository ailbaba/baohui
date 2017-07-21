<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String businessElsAccount = request.getParameter("businessElsAccount");
String projectNumber = request.getParameter("projectNumber");
String flowCode = request.getParameter("flowCode");
String stretegyCode = request.getParameter("stretegyCode");
%>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
  <div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<base:audit elsSubAccount="${elsSubAccount }" businessElsAccount="${param.businessElsAccount }" businessId="${param.projectNumber }" elsAccount="${elsAccount }" businessType="project">
				<button id="passBtn" class="todo button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
				<button id="noPassBtn" class="todo button-wrap"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
				</base:audit>
				<button id="cancelBtn" class="done button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
				<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_approval_flow" defaultValue="流程" /></button>
				<button id="abandonBtn" class="button-wrap"><i18n:I18n key="" defaultValue="弃审" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	    <form id="auditForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="elsAccount" value="${elsAccount }">
		<input type="hidden" name="elsSubAccount" value="${elsSubAccount }">
		<input type="hidden" name="businessElsAccount" value="<%=businessElsAccount%>">
		<input type="hidden" name="projectNumber" value="<%=projectNumber%>">   
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="项目管理头" /></span>
            <div class="common-box-line">
                <main class="grid-container">
                    <div class="grid-100" id="headDiv">
                        <table id="headTable"></table>
                    </div>
                </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="项目管理明细" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                     <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="" defaultValue="项目管理行" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="" defaultValue="项目联系人" /></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n key="" defaultValue="项目文件" /></a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container">
                            <div class="grid-100" id="itemDiv">
                                <table id="itemTable"></table>
                            </div>
                        </main>
                    </div>
                    <div id="sheet-project-two">
                        <main class="grid-container">
                            <div class="grid-100" id="contactDiv">
                                <table id="contactTable"></table>
                            </div>
                        </main>
                    </div>
                    <div id="sheet-project-three">
                        <div class="box-wrap pos-relative bg-common">
				            <div class="common-box-line p-zero">
				                <div class="pos-relative upload-wrap">
				                    <div class="pos-absolute file-list">
										<%-- <div class="file-list-head">
											<select id="selectFileType" name="selectFileType" style="width: 165px;">
												<option value="all"><i18n:I18n defaultValue="所有文件" key="i18n_common_select_filetype_all"/></option>
												<option value="common"><i18n:I18n defaultValue="公共文件" key="i18n_common_select_filetype_public"/></option>
											</select>
						                </div> --%>
										<main class="grid-container">
											<div class="grid-100" id="fileDiv">
												<table id="fileTable" style="width: 300px;"></table>
											</div>
										</main>
				                    </div>
					                <div class="file-scan">
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
 </div>

<script type="text/javascript">
var auditType = "${param.auditType}";
var elsAccount = "<%=businessElsAccount%>";
var projectNumber = "<%=projectNumber%>";
var flowCode = "<%=flowCode%>";
var stretegyCode = "<%=stretegyCode%>";
var elsDesc = "${sessionScope.companyShortName}";
var elsSubAccount = "${sessionScope.elsSubAccount}";

var renderFormatDate = function(val,item,rowIndex){
	return new Date(val).format("yyyy-MM-dd");
};
var renderFormatStatus = function(val,item,rowIndex){
	if("0"==val){
		return "新建";
	} else if("1"==val){
		return "进行中";
	} else if("2"==val){
		return "完成";
	} else if("3"==val){
		return "关闭";
	} else {
		return "";
	}
};
var renderFormatApprove = function(val,item,rowIndex){
	if("0"==val){
		return "审批通过";
	} else if("1"==val){
		return "未审批";
	} else if("2"==val){
		return "审批中";
	} else if("3"==val){
		return "审批拒绝";
	} else {
		return "";
	}
};
var renderFormatMark = function(val,item,rowIndex){
	if("Y"==val){
		return "是";
	} else {
		return "否";
	}
};

var headCols = [
            	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
            	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
            	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
            	{ title:"项目描述", name:"projectDesc", width:100, align:"center"},
            	{ title:"项目概述", name:"projectSummary", width:100, align:"center"},
            	{ title:"外部参考项目编号", name:"refProjectNumber", width:100, align:"center"},
            	{ title:"项目类型", name:"projectType", width:100, align:"center"},
            	{ title:"项目状态", name:"projectStatus" , width:100, align:"center",renderer:renderFormatStatus},
            	{ title:"项目总负责人", name:"projectLeader" , width:100, align:"center"},
            	{ title:"审批状态", name:"auditStatus" , width:100, align:"center",renderer:renderFormatApprove},
            	{ title:"项目客户名称", name:"customerDesc" , width:100, align:"center"},
            	{ title:"项目地址", name:"projectAddress" , width:100, align:"center"},
            	{ title:"币别", name:"currency" , width:100, align:"center"},
            	{ title:"预算金额", name:"budgetAmount" , width:100, align:"center"},
            	{ title:"实际金额", name:"actualAmount" , width:100, align:"center"},
            	{ title:"计划周期(天)", name:"planCycle" , width:100, align:"center"},
            	{ title:"实际周期(天)", name:"actualCycle" , width:100, align:"center"},
            	{ title:"计划开始日期", name:"planStartDate" , width:100, align:"center",renderer:renderFormatDate},
            	{ title:"计划结束日期", name:"planEndDate" , width:100, align:"center",renderer:renderFormatDate},
            	{ title:"实际开始日期", name:"actualStartDate" , width:100, align:"center",renderer:renderFormatDate},
            	{ title:"实际结束日期", name:"actualEndDate" , width:100, align:"center",renderer:renderFormatDate},
            	{ title:"备注", name:"remark" , width:100, align:"center"},
            	{ title:"创建人", name:"createUser" , width:100, align:"center"},
            	{ title:"流程编码", name:"flowCode", width:100, align:"center",hidden:true}
            ];
      
var headGrid = $("#headTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageHead",
    method :  "POST",
    autoLoad : false,
    height : "200px",
    cols : headCols,
    root : "rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    multiSelect : false,
    checkCol : false,
    indexCol : false,
});

headGrid.on("loadSuccess",function(e, data){
	if(headGrid.rowsLength()>0){
		headGrid.select(0);//默认选中第一条数据
		loadItem(headGrid.selectedRows()[0]);
		loadContact(headGrid.selectedRows()[0]);
		loadFile(headGrid.selectedRows()[0]);
		var headRecord = headGrid.rows()[0];
		if(headRecord.auditStatus == 2){
			var param = {'elsAccount':elsAccount,'businessType':'project','businessId':projectNumber,'flowCode':flowCode,"stretegyCode":stretegyCode};
			$.ajax({
				url :"<%=basePath%>rest/AuditService/queryAuditUser",
				type :"post",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify(param),
				success : function(data) {
					if(data.flowCode == 1 || data.auditElsAccount != elsAccount || data.auditUser != elsSubAccount){
						$("#abandonBtn").hide();
					}else{
						$("#abandonBtn").show();
					}
				},
				error : function(data) {
		    		alert('<i18n:I18n key="i18n_common_request_error" defaultValue="查询审批人请求出错" />',3);
				}
			});
		}
	} else {
		clearItemTable();
		clearContactTable();
		clearFileTable();
	}
	
});

var itemCols = [
            	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
            	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
            	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
            	{ title:"项目行编号", name:"projectItemNumber", width:100, align:"center"},
            	{ title:"项目行描述", name:"projectItemDesc", width:100, align:"center"},
            	{ title:"外部参考项目行编号", name:"refProjectItemNumber", width:100, align:"center"},
            	{ title:"项目行状态", name:"projectItemStatus" , width:100, align:"center",renderer:renderFormatStatus},
            	{ title:"项目行负责人", name:"projectLeader" , width:100, align:"center"},
            	{ title:"里程碑标识", name:"milestoneMark" , width:100, align:"center",renderer:renderFormatMark},
            	{ title:"币别", name:"currency" , width:100, align:"center"},
            	{ title:"预算金额", name:"budgetAmount" , width:100, align:"center"},
            	{ title:"预算占比", name:"budgetPercentage" , width:100, align:"center"},
            	{ title:"实际金额", name:"actualAmount" , width:100, align:"center"},
            	{ title:"计划周期(天)", name:"planCycle" , width:100, align:"center"},
            	{ title:"实际周期(天)", name:"actualCycle" , width:100, align:"center"},
            	{ title:"计划开始日期", name:"planStartDate" , width:100, align:"center",renderer:renderFormatDate},
            	{ title:"计划结束日期", name:"planEndDate" , width:100, align:"center",renderer:renderFormatDate},
            	{ title:"实际开始日期", name:"actualStartDate" , width:100, align:"center",renderer:renderFormatDate},
            	{ title:"实际结束日期", name:"actualEndDate" , width:100, align:"center",renderer:renderFormatDate},
            	{ title:"完成百分比", name:"completePercentage" , width:100, align:"center"},
            	{ title:"备注", name:"remark" , width:100, align:"center"},
            ];
      
var itemGrid = $("#itemTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageItem",
    method :  "POST",
    autoLoad : false,
    height : "350px",
    cols : itemCols,
    root : "rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    multiSelect : true,
    checkCol : true,
    indexCol : false,
});

var contactCols = [
               	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
               	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
               	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
               	{ title:"项目行编号", name:"projectItemNumber", width:100, align:"center"},
               	{ title:"项目行描述", name:"projectItemDesc", width:100, align:"center"},
               	{ title:"联系人职责", name:"contactDuty", width:100, align:"center"},
               	{ title:"联系人岗位", name:"contactPosition" , width:100, align:"center"},
               	{ title:"联系人姓名", name:"contactName" , width:100, align:"center"},
               	{ title:"联系人姓名", name:"contactTelephone" , width:100, align:"center"},
               	{ title:"联系人固话", name:"contactTelephone" , width:100, align:"center"},
               	{ title:"联系人手机", name:"contactMobilePhone" , width:100, align:"center"},
               	{ title:"联系人邮箱", name:"contactEmail" , width:100, align:"center"},
               	{ title:"备注", name:"remark" , width:100, align:"center"},
               ];
      
var contactGrid = $("#contactTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageContact",
    method :  "POST",
    autoLoad : false,
    height : "350px",
    cols : contactCols,
    root : "rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    multiSelect : true,
    checkCol : true,
    indexCol : false,
});

var fileCols = [
            	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
            	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
            	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
            	{ title:"项目行编号", name:"projectItemNumber", width:100, align:"center"},
            	{ title:"项目行描述", name:"projectItemDesc", width:100, align:"center"},
            	{ title:"文件序号", name:"fileSequence", width:100, align:"center"},
            	{ title:"文件名称", name:"fileName" , width:100, align:"center"},
            	{ title:"文件描述", name:"fileDesc" , width:100, align:"center"},
            	{ title:"文件版本", name:"fileVersion" , width:100, align:"center"},
            	{ title:"文件路径", name:"filePath" , width:100, align:"center",hidden:true},
            	{ title:"备注", name:"remark" , width:100, align:"center"},
            ];
      
var fileGrid = $("#fileTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageFile",
    method :  "POST",
    autoLoad : false,
    height : "350px",
    cols : fileCols,
    root : "rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    multiSelect : true,
    checkCol : true,
    indexCol : false,
});
var currShowFile;
fileGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
	var filePath = item.filePath;
	if(currShowFile == filePath){//如果选中的为当前显示文件则不做其他操作
	} else {//如果选中的不是当前显示文件则重新刷新右侧显示文件
		currShowFile = filePath;
		previewFile(filePath);
	}
});
        
$(document).ready(function(){
    //初始化控件
    $("button").button();
    $("#sheet-project").tabs();
    $("#abandonBtn").hide();
    
    var queryParam = {
    		elsAccount : elsAccount,
    		projectNumber : projectNumber,
    };
	headGrid.load(queryParam);
	
});

$('.dialog-close-btn').click(function(){
    $('.fixed-dialog').hide();
});
$('.tip-option-btn').click(function(){
    $('.dialog-close-btn').trigger('click');
});

//关闭按钮处理
$("#dialogFileClose").click(function(){
	$("#addFileDialog").hide();
	clearAddFileInfo();
});
 
function loadItem(headRecord){
	var queryParam = {
	   	elsAccount : headRecord.elsAccount,
	   	projectNumber : headRecord.projectNumber
	   };
	itemGrid.load(queryParam);
}

function loadContact(headRecord){
	var queryParam = {
    	elsAccount : headRecord.elsAccount,
    	projectNumber : headRecord.projectNumber
    };
	contactGrid.load(queryParam);
}

function loadFile(headRecord){
	var queryParam = {
    	elsAccount : headRecord.elsAccount,
    	projectNumber : headRecord.projectNumber
    };
	fileGrid.load(queryParam);
}

function clearItemTable(){
	if(itemGrid.rowsLength() > 0){
		for(var i=itemGrid.rowsLength();i-1>=0;i--){
			itemGrid.removeRow(i-1);
		}
	}
}

function clearContactTable(){
	if(contactGrid.rowsLength() > 0){
		for(var i=contactGrid.rowsLength();i-1>=0;i--){
			contactGrid.removeRow(i-1);
		}
	}
}

function clearFileTable(){
	if(fileGrid.rowsLength() > 0){
		for(var i=fileGrid.rowsLength();i-1>=0;i--){
			fileGrid.removeRow(i-1);
		}
	}
}

function reGenItemNumber(){
	var itemRowLength = itemGrid.rowsLength();
	if(itemRowLength > 0){
		for(var i=0;i<itemRowLength;i++){
			var itemRecord = itemGrid.row(i);
			itemRecord["projectItemNumber"] = i+1;
			itemGrid.updateRow(itemRecord,i);
		}
	}
}

function reCalcBudgetAmount(){
	var itemRowsLength = itemGrid.rowsLength();
	var totalBudgetAmount = 0;
	var headRow = headGrid.row(0);
	if(itemRowsLength > 0){
		for(var i=0;i<itemRowsLength;i++){
			var recrod = itemGrid.row(i);
			totalBudgetAmount += parseFloat(recrod.budgetAmount);
		}
	}
	headRow["budgetAmount"] = totalBudgetAmount;
	//headGrid.updateRow(headRow,0);//直接更新gird将导致grid数据重新加载使得当前输入框失去焦点
	$("#headTable tr:eq(0)").find("input[name='budgetAmount']").val(totalBudgetAmount);
}

function reCalcBudgetPercentage(){
	var totalBudgetAmount = headGrid.row(0).budgetAmount;
	var itemRowsLength = itemGrid.rowsLength();
	if(itemRowsLength > 0){
		for(var i=0;i<itemRowsLength;i++){
			var recrod = itemGrid.row(i);
			var budgetAmount = recrod.budgetAmount;
			var budgetPercentage = (parseFloat(budgetAmount)/parseFloat(totalBudgetAmount))*100;
			recrod["budgetPercentage"] = budgetPercentage.toFixed(2);
			//itemGrid.updateRow(recrod,i);//直接更新gird将导致grid数据重新加载使得当前输入框失去焦点
			$("#itemTable tr:eq("+i+")").find("input[name='budgetPercentage']").val(budgetPercentage.toFixed(2));
		}
	}
}

function reCalcActualAmount(){
	var itemRowsLength = itemGrid.rowsLength();
	var totalActualAmount = 0;
	var headRow = headGrid.row(0);
	if(itemRowsLength > 0){
		for(var i=0;i<itemRowsLength;i++){
			var recrod = itemGrid.row(i);
			totalActualAmount += parseFloat(recrod.actualAmount);
		}
	}
	headRow["actualAmount"] = totalActualAmount;
	//headGrid.updateRow(headRow,0);//直接更新gird将导致grid数据重新加载使得当前输入框失去焦点
	$("#headTable tr:eq(0)").find("input[name='actualAmount']").val(totalActualAmount);
}

function clearAddFileInfo(){
	$("#fileName").val("");
	$("#filePath").val("");
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
					alert("文件预览转换失败",3); 
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

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_projectManage']) {
		parent.frames['iframeApp_projectManage'].init();
	}
}
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
function pass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/ProjectManageService/sendProjectPass",
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
			url :"<%=basePath%>rest/ProjectManageService/sendProjectNoPass",
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
			url :"<%=basePath%>rest/ProjectManageService/cancelAudit",
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
					alert("<i18n:I18n key="xx" defaultValue="流程结束的项目不能撤销审批" />",3);
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
function flow(){
	var targetElsAccount = "${param.businessElsAccount }";
	var businessType = "project";
	var businessId = "${param.projectNumber }";
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
function closeCallback() {
	if (parent.frames["iframeApp_auditList"]) {
		parent.frames["iframeApp_auditList"].query();
	}
}
function closeCurrWindow() {
	parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
}
/////////////////////////////////////////////////////////////////////////////////
$("#abandonBtn").click(function(){
	abandon();
});
function abandon(){
	var targetElsAccount = "${param.businessElsAccount }";
	var businessType = "project";
	var businessId = "${param.projectNumber }";
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'abandonAudit',
        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="弃审" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowAbandon.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId 
        		+ '&flowCode=' + flowCode + '&stretegyCode=' + stretegyCode,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
}
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/* if (hasRight) {
$("#itemPassBtn").show();
$("#itemNoPassBtn").show();
$("#itemPassBtn").click(function(){
	itemPass();
});
$("#itemNoPassBtn").click(function(){
	itemNoPass();
});
} */
<%-- function itemPass() {
	var allRows=itemGrid.rows();
	var rows = itemGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var itemIds = "";
	for (var i=0;i<rows.length;i++){
		itemIds += rows[i].orderItemNumber + ",";
	}
	itemIds = itemIds.substring(0,itemIds.length-1);
	$("#itemIds").val(itemIds);
	parent.elsDeskTop.showLoading();
	var frm = $("#auditForm");
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/itemPass",
		type :"post",
		contentType : "application/json",
		data:JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			changeStatus(allRows,rows,0);
			parent.elsDeskTop.hideLoading();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
} --%>
<%-- function itemNoPass() {
	var allRows=itemGrid.rows();
	var rows = itemGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var itemIds = "";
	for (var i=0;i<rows.length;i++){
		itemIds += rows[i].orderItemNumber + ",";
	}
	itemIds = itemIds.substring(0,itemIds.length-1);
	$("#itemIds").val(itemIds);
	parent.elsDeskTop.showLoading();
	var frm = $("#auditForm");
	$.ajax({
		url :"<%=basePath%>rest/PurchaseOrderService/itemNoPass",
		type :"post",
		contentType : "application/json",
		data:JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			changeStatus(allRows,rows,3);
			parent.elsDeskTop.hideLoading();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
} --%>
/* function changeStatus(allRows,rows ,status){
	var json=new Object();
	for(var i=0;i<rows.length;i++){
		json[rows[i].orderItemNumber]="1";
	}
	for(var i=0;i<allRows.length;i++){
		var orderItemNumber=allRows[i].orderItemNumber;
		if(json[orderItemNumber]=="1"){
			allRows[i].auditStatus=status;
		}
	}
	itemGrid.load(allRows);
} */
</script>
</body>
</html>