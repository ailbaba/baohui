<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>

<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
            </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_projectManage_title_projectHead" defaultValue="项目管理头" /></span>
            <div class="common-box-line">
                <main class="grid-container">
                    <div class="grid-100" id="headDiv">
                        <table id="headTable"></table>
                    </div>
                </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_projectManage_title_projectDetail" defaultValue="项目管理明细" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                     <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_projectManage_title_projectItem" defaultValue="项目管理行" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_projectManage_title_projectContact" defaultValue="项目联系人" /></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n key="i18n_projectManage_title_projectFile" defaultValue="项目文件" /></a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container">
                            <div class="edit-box-wrap">
                                <button class="button-wrap" id="addItemRowBtn"><i18n:I18n key="i18n_delivery_button_createaitem" defaultValue="新增行" /></button>
                                <button class="button-wrap" id="delItemRowBtn"><i18n:I18n key="i18n_delivery_button_removeaitem" defaultValue="删除行" /></button>
                            </div>
                            <div class="grid-100" id="itemDiv">
                                <table id="itemTable"></table>
                            </div>
                        </main>
                    </div>
                    <div id="sheet-project-two">
                        <main class="grid-container">
                            <div class="edit-box-wrap">
                                <button class="button-wrap" id="addContactRowBtn"><i18n:I18n key="i18n_projectManage_button_addContact" defaultValue="新增联系人" /></button>
                                <button class="button-wrap" id="delContactRowBtn"><i18n:I18n key="i18n_projectManage_button_deleteContact" defaultValue="删除联系人" /></button>
                            </div>
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
			   							<div class="file-option-zoom">
							                <div class="dis-in-b text-left">
										        <button class="button-wrap" id="addFileBtn"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button>
												<button class="button-wrap" id="delFileBtn"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button>
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
    </div>
    
    <div class="fixed-dialog" id="addFileDialog">
		<div class="dialog-tip bg-common" style="width: 262px;height: auto; margin-left: -131px;margin-top: -190px;">
		    <div class="dialog-close-btn" id="dialogFileClose"></div>
		    <div class="tip-head">
		        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
		        <span class="dialogTitle"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_title_chooseformfile"/></span>
		    </div>
		    <div class="">
		        <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
					<div class="common-box-line">
						<div class="input-and-tip"><span><i18n:I18n defaultValue="文件名称" key="i18n_common_label_filename"/>：</span><input id="fileName" name="fileName" type="text" /></div>
						<div class="input-and-tip"><span><i18n:I18n defaultValue="文件路径" key="i18n_common_label_filepath"/>：</span><input id="filePath" name="filePath" type="text" /></div>
						<div class="input-and-tip text-right">                 
							<div id="btnFileUpload" class="btn btnUpload">
								<i18n:I18n defaultValue="选择表单文件" key="i18n_common_button_chooseformfile"/>
							</div>           
							<input id="fileType" name="fileType" type="hidden" />
						</div>
						<div class="mt-20 text-center">
							<button id="addFileBtnOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
							<button id="addFileBtnCancel" class="button-wrap "><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
						</div>
					</div>
	            </div>
	       </div>
		</div>
	</div>
<script type="text/javascript">
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";
var fileUploader;

var parentId = '${param.parentId}';
var type = '${param.type}';
var headRecord;
var itemRecords;
var contactRecords;
var fileRecords;

var projectStatusSelect = $("<select name='projectStatus'><option value='0'>新建</option><option value='1'>进行中</option><option value='2'>完成</option><option value='3'>关闭</option></select>");
var auditStatusSelect = $("<select name='auditStatus'><option value='0'>审批通过</option><option value='1'>未审批</option><option value='2'>审批中</option><option value='3'>审批拒绝</option></select>");
var itemStatusSelect = $("<select name='projectItemStatus'><option value='0'>新建</option><option value='1'>进行中</option><option value='2'>完成</option><option value='3'>关闭</option></select>");
var markSelect = $("<select name='milestoneMark'><option value='Y'>是</option><option value='N'>否</option></select>");

var headEditCols = function(val,item,rowIndex){
	var thisRecord = $(this);
	var colName = thisRecord[0].name;
	if("undefined"==typeof(val)){
		val = ""; 
	}
	if("projectStatus" == colName){
		if("0"==val){
			val = "新建";
		} else if("1"==val){
			val = "进行中";
		} else if("2"==val){
			val = "完成";
		} else if("3"==val){
			val = "关闭";
		} else {
			val = "新建";
		}
		return val;
	} else if("auditStatus" == colName){
		if("0"==val){
			val = "审批通过";
		} else if("1"==val){
			val = "未审批";
		} else if("2"==val){
			val = "审批中";
		} else if("3"==val){
			val = "审批拒绝";
		} else {
			val = "未审批";
		}
		return val;
	} else if("planStartDate"==colName){
		return "<input typpe='text' name='"+colName+ "' id='plans'" +
		" class='Wdate' onfocus=\"WdatePicker({minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\\'plane\\')}'})\" value='"+val+"' />";
	} else if("planEndDate"==colName){
		return "<input typpe='text' name='"+colName+ "' id='plane'" +
		" class='Wdate' onfocus=\"WdatePicker({minDate:'#F{$dp.$D(\\'plans\\')}'})\" value='"+val+"' />";
	}else if("actualStartDate"==colName){
		return "<input typpe='text' name='"+colName+ "' id='actuals'" +
		" class='Wdate' onfocus=\"WdatePicker({minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\\'actuale\\')}'})\" value='"+val+"' />";
	}else if("actualEndDate"==colName){
		return "<input typpe='text' name='"+colName+ "' id='actuale'" +
		" class='Wdate' onfocus=\"WdatePicker({minDate:'#F{$dp.$D(\\'actuals\\')}'})\" value='"+val+"' />";
	} else if("budgetAmount"==colName){
		return "<input typpe='text' name='"+colName+"' readonly='readonly' class='headColsEdit' value='"+val+"' />";
	} else {
		return "<input typpe='text' name='"+colName+"' class='headColsEdit' value='"+val+"' />";
	}
}

$(".headColsEdit").live('keyup',function(){
	var thisVal = $(this).val();
	var thisName = $(this).attr("name");
	var rowIndex = $(this).closest("tr").index();
	var rowData = headGrid.row(rowIndex);
	rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
});

var headCols = [
    { title:"ELS号", name:"elsAccount", width:100, align:"center",renderer:headEditCols},
    { title:"ELS描述", name:"elsDesc", width:100, align:"center"},
    { title:"项目编号", name:"projectNumber", width:100, align:"center",renderer:headEditCols},
    { title:"项目描述", name:"projectDesc", width:100, align:"center",renderer:headEditCols},
    { title:"项目概述", name:"projectSummary", width:100, align:"center",renderer:headEditCols},
    { title:"外部参考项目编号", name:"refProjectNumber", width:100, align:"center",renderer:headEditCols},
    { title:"项目类型", name:"projectType", width:100, align:"center",renderer:headEditCols},
    { title:"项目状态", name:"projectStatus" , width:100, align:"center",renderer:headEditCols,hidden:true},
    { title:"项目总负责人", name:"projectLeader" , width:100, align:"center",renderer:headEditCols},
    { title:"审批状态", name:"auditStatus" , width:100, align:"center",renderer:headEditCols,hidden:true},
    { title:"项目客户名称", name:"customerDesc" , width:100, align:"center",renderer:headEditCols},
    { title:"项目地址", name:"projectAddress" , width:100, align:"center",renderer:headEditCols},
    { title:"币别", name:"currency" , width:100, align:"center",renderer:headEditCols},
    { title:"预算金额", name:"budgetAmount" , width:100, align:"center",renderer:headEditCols},
    { title:"实际金额", name:"actualAmount" , width:100, align:"center",renderer:headEditCols,hidden:true},
    { title:"计划周期(天)", name:"planCycle" , width:100, align:"center",renderer:headEditCols},
    { title:"实际周期(天)", name:"actualCycle" , width:100, align:"center",renderer:headEditCols,hidden:true},
    { title:"计划开始日期", name:"planStartDate" , width:100, align:"center",renderer:headEditCols},
    { title:"计划结束日期", name:"planEndDate" , width:100, align:"center",renderer:headEditCols},
    { title:"实际开始日期", name:"actualStartDate" , width:100, align:"center",renderer:headEditCols,hidden:true},
    { title:"实际结束日期", name:"actualEndDate" , width:100, align:"center",renderer:headEditCols,hidden:true},
    { title:"备注", name:"remark" , width:100, align:"center",renderer:headEditCols},
    { title:"创建人", name:"createUser" , width:100, align:"center",renderer:headEditCols},
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

var itemEditCols = function(val,item,rowIndex){
	var thisRecord = $(this);
	var colName = thisRecord[0].name;
	if("undefined"==typeof(val)){
		val = ""; 
	}
	if("elsAccount"==colName || "elsDesc"==colName 
			|| "projectNumber"==colName || "projectItemNumber"==colName){
		return val;
	} else if("projectItemStatus" == colName){
		if("0"==val){
			val = "新建";
		} else if("1"==val){
			val = "进行中";
		} else if("2"==val){
			val = "完成";
		} else if("3"==val){
			val = "关闭";
		} else {
			val = "新建";
		}
		return val;
	} else if("milestoneMark"==colName){
		var milestoneSelect = markSelect.clone();
		milestoneSelect.find("option[value='"+val+"']").attr("selected",true);
		return milestoneSelect.prop("outerHTML");
	} else if("planStartDate"==colName){
		return "<input typpe='text' name='"+colName+ "' id='plans_" + rowIndex + "'" +
		" class='Wdate' onfocus=\"WdatePicker({minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\\'plane_"+rowIndex+"\\')}'})\" value='"+val+"' />";
	} else if("planEndDate"==colName){
		return "<input typpe='text' name='"+colName+ "' id='plane_" + rowIndex + "'" +
		" class='Wdate' onfocus=\"WdatePicker({minDate:'#F{$dp.$D(\\'plans_"+rowIndex+"\\')}'})\" value='"+val+"' />";
	}else if("actualStartDate"==colName){
		return "<input typpe='text' name='"+colName+ "' id='actuals_" + rowIndex + "'" +
		" class='Wdate' onfocus=\"WdatePicker({minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\\'actuale_"+rowIndex+"\\')}'})\" value='"+val+"' />";
	}else if("actualEndDate"==colName){
		return "<input typpe='text' name='"+colName+ "' id='actuale_" + rowIndex + "'" +
		" class='Wdate' onfocus=\"WdatePicker({minDate:'#F{$dp.$D(\\'actuals_"+rowIndex+"\\')}'})\" value='"+val+"' />";
	}else if("budgetPercentage"==colName){
		return "<input typpe='text' name='"+colName+"' readonly='readonly' class='itemColsEdit' value='"+val+"' />";
	} else {
		return "<input typpe='text' name='"+colName+"' class='itemColsEdit' value='"+val+"' />";
	}
}
$(".itemColsEdit").live('keyup',function(){
	var thisVal = $(this).val();
	var thisName = $(this).attr("name");
	var rowIndex = $(this).closest("tr").index();
	var rowData = itemGrid.row(rowIndex);
	rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
	
	if("budgetAmount"==thisName){
		reCalcBudgetAmount();
		reCalcBudgetPercentage();
	}
});
var itemCols = [
    { title:"ELS号", name:"elsAccount", width:100, align:"center",renderer:itemEditCols},
    { title:"ELS描述", name:"elsDesc", width:100, align:"center",renderer:itemEditCols},
    { title:"项目编号", name:"projectNumber", width:100, align:"center",renderer:itemEditCols,hidden:true},
    { title:"项目行编号", name:"projectItemNumber", width:100, align:"center",renderer:itemEditCols},
    { title:"项目行描述", name:"projectItemDesc", width:100, align:"center",renderer:itemEditCols},
    { title:"外部参考项目行编号", name:"refProjectItemNumber", width:100, align:"center",renderer:itemEditCols},
    { title:"项目行状态", name:"projectItemStatus" , width:100, align:"center",renderer:itemEditCols,hidden:true},
    { title:"项目行负责人", name:"projectLeader" , width:100, align:"center",renderer:itemEditCols},
    { title:"里程碑标识", name:"milestoneMark" , width:100, align:"center",renderer:itemEditCols},
    { title:"币别", name:"currency" , width:100, align:"center",renderer:itemEditCols},
    { title:"预算金额", name:"budgetAmount" , width:100, align:"center",renderer:itemEditCols},
    { title:"预算占比", name:"budgetPercentage" , width:100, align:"center",renderer:itemEditCols},
    { title:"实际金额", name:"actualAmount" , width:100, align:"center",renderer:itemEditCols,hidden:true},
    { title:"计划周期(天)", name:"planCycle" , width:100, align:"center",renderer:itemEditCols},
    { title:"实际周期(天)", name:"actualCycle" , width:100, align:"center",renderer:itemEditCols,hidden:true},
    { title:"计划开始日期", name:"planStartDate" , width:100, align:"center",renderer:itemEditCols},
    { title:"计划结束日期", name:"planEndDate" , width:100, align:"center",renderer:itemEditCols},
    { title:"实际开始日期", name:"actualStartDate" , width:100, align:"center",renderer:itemEditCols,hidden:true},
    { title:"实际结束日期", name:"actualEndDate" , width:100, align:"center",renderer:itemEditCols,hidden:true},
    { title:"完成百分比", name:"completePercentage" , width:100, align:"center",renderer:itemEditCols},
    { title:"备注", name:"remark" , width:100, align:"center",renderer:itemEditCols},
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

var contactEditCols = function(val,item,rowIndex){
	var thisRecord = $(this);
	var colName = thisRecord[0].name;
	if("undefined"==typeof(val)){
		val = ""; 
	}
	if("elsAccount"==colName || "elsDesc"==colName || "projectNumber"==colName || "projectItemDesc"==colName){
		return "<input typpe='text' name='"+colName+"' class='contactColsEdit' readonly='readonly' value='"+val+"' />";
	} else {
		return "<input typpe='text' name='"+colName+"' class='contactColsEdit' value='"+val+"' />";
	}
}
$(".contactColsEdit").live('keyup',function(){
	var thisVal = $(this).val();
	var thisName = $(this).attr("name");
	var rowIndex = $(this).closest("tr").index();
	var rowData = contactGrid.row(rowIndex);
	rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
});
var contactCols = [
    { title:"ELS号", name:"elsAccount", width:100, align:"center",renderer:contactEditCols,hidden:true},
    { title:"ELS描述", name:"elsDesc", width:100, align:"center",renderer:contactEditCols,hidden:true},
    { title:"项目编号", name:"projectNumber", width:100, align:"center",renderer:contactEditCols,hidden:true},
    { title:"项目行编号", name:"projectItemNumber", width:100, align:"center",renderer:contactEditCols},
    { title:"项目行描述", name:"projectItemDesc", width:100, align:"center",renderer:contactEditCols,hidden:true},
    { title:"联系人职责", name:"contactDuty", width:100, align:"center",renderer:contactEditCols},
    { title:"联系人岗位", name:"contactPosition" , width:100, align:"center",renderer:contactEditCols},
    { title:"联系人姓名", name:"contactName" , width:100, align:"center",renderer:contactEditCols},
    { title:"联系人固话", name:"contactTelephone" , width:100, align:"center",renderer:contactEditCols},
    { title:"联系人手机", name:"contactMobilePhone" , width:100, align:"center",renderer:contactEditCols},
    { title:"联系人邮箱", name:"contactEmail" , width:100, align:"center",renderer:contactEditCols},
    { title:"备注", name:"remark" , width:100, align:"center",renderer:contactEditCols},
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

var fileEditCols = function(val,item,rowIndex){
	var thisRecord = $(this);
	var colName = thisRecord[0].name;
	if("undefined"==typeof(val)){
		val = ""; 
	}
	if("elsAccount"==colName || "elsDesc"==colName || "projectNumber"==colName || "projectItemDesc"==colName){
		return "<input typpe='text' name='"+colName+"' class='fileColsEdit' readonly='readonly' value='"+val+"' />";
	} else {
		return "<input typpe='text' name='"+colName+"' class='fileColsEdit' value='"+val+"' />";
	}
}
$(".fileColsEdit").live('keyup',function(){
	var thisVal = $(this).val();
	var thisName = $(this).attr("name");
	var rowIndex = $(this).closest("tr").index();
	var rowData = fileGrid.row(rowIndex);
	rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
});
var fileCols = [
    { title:"ELS号", name:"elsAccount", width:100, align:"center",renderer:fileEditCols,hidden:true},
    { title:"ELS描述", name:"elsDesc", width:100, align:"center",renderer:fileEditCols,hidden:true},
    { title:"项目编号", name:"projectNumber", width:100, align:"center",renderer:fileEditCols,hidden:true},
    { title:"项目行编号", name:"projectItemNumber", width:100, align:"center",renderer:fileEditCols},
    { title:"项目行描述", name:"projectItemDesc", width:100, align:"center",renderer:fileEditCols,hidden:true},
    { title:"文件序号", name:"fileSequence", width:100, align:"center",renderer:fileEditCols},
    { title:"文件名称", name:"fileName" , width:100, align:"center",renderer:fileEditCols},
    { title:"文件描述", name:"fileDesc" , width:100, align:"center",renderer:fileEditCols},
    { title:"文件版本", name:"fileVersion" , width:100, align:"center",renderer:fileEditCols},
    { title:"文件路径", name:"filePath" , width:100, align:"center",renderer:fileEditCols,hidden:true},
    { title:"备注", name:"remark" , width:100, align:"center",renderer:fileEditCols},
];
      
var fileGrid = $("#fileTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageFile",
    method :  "POST",
    autoLoad : false,
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
    var currDate = new Date().format("yyyy-MM-dd");
    var tempArr = [];
    
    if(type == "copyAdd"){//复制新增
    	headRecord = getIframeData().headRecord;
    	itemRecords = getIframeData().itemRecords;
    	contactRecords = getIframeData().contactRecords;
    	fileRecords = getIframeData().fileRecords;
    	
    	if(headRecord != null && typeof(headRecord) != "undefined"){    		
	    	headRecord["projectNumber"] = "";
	    	headRecord["projectStatus"] = 0;
	    	headRecord["auditStatus"] = 1;
	    	headRecord["planStartDate"] = currDate;
	    	headRecord["planEndDate"] = currDate;
	    	headRecord["actualStartDate"] = currDate;
	    	headRecord["actualEndDate"] = currDate;
	    	tempArr.push(headRecord);
	    	headGrid.load(tempArr);
    	}
    	if(itemRecords.length > 0){
    		for(var i=0;i<itemRecords.length;i++){
    			itemRecords[i]["planStartDate"] = currDate;
    			itemRecords[i]["planEndDate"] = currDate;
    			itemRecords[i]["actualStartDate"] = currDate;
    			itemRecords[i]["actualEndDate"] = currDate;
    		}
    		itemGrid.load(itemRecords);
    	}
    	if(contactRecords && contactRecords != ""){
    		contactGrid.load(contactRecords);
    	}
    	if(fileRecords && fileRecords != ""){
    		fileGrid.load(fileRecords);
    	}
    	
    }else{//新增
	    var record = [{
			elsAccount : elsAccount,
			elsDesc : elsDesc,
			projectNumber : "",
			projectDesc : "",
			projectSummary : "",
			refProjectNumber : "",
			projectType : "",
			projectStatus : "0",
			projectLeader : userName,
			customerDesc : "",
			projectAddress : "",
			currency : "CNY",
			budgetAmount : "0",
			actualAmount : "0",
			planCycle : "0",
			actualCycle : "0",
			planStartDate : currDate,
			planEndDate : currDate,
			actualStartDate : "",
			actualEndDate : "",
			remark : "",
			createUser : userName,
		}];
		headGrid.load(record);
    }
});

$("#addItemRowBtn").click(function(){
	var currDate = new Date();
	var itemRowLength = itemGrid.rowsLength();
	var newItemRecord = {
			elsAccount : elsAccount,
			elsDesc : elsDesc,
			projectNumber : "",
			projectItemNumber : itemRowLength+1,
			projectItemDesc : "",
			refProjectItemNumber : "",
			projectItemStatus : "0",
			projectLeader : userName,
			milestoneMark : "N",
			currency : "CNY",
			budgetAmount : "0",
			budgetPercentage : "0",
			actualAmount : "0",
			planCycle : "0",
			actualCycle : "0",
			planStartDate : currDate.format("yyyy-MM-dd"),
			planEndDate : currDate.format("yyyy-MM-dd"),
			actualStartDate : "",
			actualEndDate : "",
			completePercentage : "0",
			remark : "",
	};
	itemGrid.addRow(newItemRecord);
});

$("#delItemRowBtn").click(function(){
	var selectedItems = itemGrid.selectedRowsIndex();
	itemGrid.removeRow(selectedItems);
	reGenItemNumber();
	reCalcBudgetAmount();
	reCalcBudgetPercentage();
});

$("#addContactRowBtn").click(function(){
	var currDate = new Date();
	var contactRowLength = contactGrid.rowsLength();
	var newContactRecord = {
			elsAccount : elsAccount,
			elsDesc : elsDesc,
			projectNumber : "",
			projectItemNumber : "",
			projectItemDesc : "",
			contactDuty : "",
			contactPosition : "",
			contactName : userName,
			contactTelephone : "",
			contactMobilePhone : "",
			contactEmail : "",
			remark : "",
	};
	contactGrid.addRow(newContactRecord);
});

$("#delContactRowBtn").click(function(){
	var selectedItems = contactGrid.selectedRowsIndex();
	contactGrid.removeRow(selectedItems);
});

$("#saveBtn").click(function(){
    var headRows = headGrid.rows();
    var headRecord = headRows[0];
    var itemRecords = itemGrid.rows();
    /* var contactRecords = contactGrid.rows(); */

    if(headRecord.projectNumber == "" || headRecord.projectNumber == null || typeof(headRecord.projectNumber) == "undefined"){
    	alert("项目编号不能为空",2);
    	return;
    }
    if(headRecord.projectDesc == "" || headRecord.projectDesc == null || typeof(headRecord.projectDesc) == "undefined"){
    	alert("项目描述不能为空",2);
    	return;
    }
    if(headRecord.projectLeader == "" || headRecord.projectLeader == null || typeof(headRecord.projectLeader) == "undefined"){
    	alert("项目总负责人不能为空",2);
    	return;
    }
    
    var planstart = $("#plans").val();
    var planend = $("#plane").val();
    if(planstart == "" || planend == ""){
    	alert("头表计划日期不能为空！",2);
    	return;
    }
    
    //启用WdatePicker时,选择时间作改变时不会触发时间值变更事件,headGrid中还是最初的赋值,需自己再重新赋值一次
    headRecord["planStartDate"] = $("#headTable tbody tr:eq(0)").find("input[name='planStartDate']").val();
    headRecord["planEndDate"] = $("#headTable tbody tr:eq(0)").find("input[name='planEndDate']").val();
    headRecord["actualStartDate"] = $("#headTable tbody tr:eq(0)").find("input[name='actualStartDate']").val();
    headRecord["actualEndDate"] = $("#headTable tbody tr:eq(0)").find("input[name='actualEndDate']").val();
    
    headRecord["parentId"] = parentId;
    
    var itemRowLength = itemGrid.rowsLength();
    var itemRows = itemRowLength==0?[]:itemGrid.rows();
    for(var i=0;i<itemRowLength;i++){
    	var itemRecord = itemRows[i];
    	itemRecord["planStartDate"] = $("#itemTable tbody tr:eq("+i+")").find("input[name='planStartDate']").val();
    	itemRecord["planEndDate"] = $("#itemTable tbody tr:eq("+i+")").find("input[name='planEndDate']").val();
    	itemRecord["actualStartDate"] = $("#itemTable tbody tr:eq("+i+")").find("input[name='actualStartDate']").val();
    	itemRecord["actualEndDate"] = $("#itemTable tbody tr:eq("+i+")").find("input[name='actualEndDate']").val();
    }
    
    if(itemRecords && itemRecords != ""){    	
	    for(var i=0;i<itemRecords.length;i++){
	    	var itemPlanStart = itemRecords[i].planStartDate;
	    	var itemPlanEnd = itemRecords[i].planEndDate;
	    	if(itemPlanStart == "" || itemPlanEnd == ""){
	        	alert("行项目计划日期不能为空！",2);
	        	return;
	        }
	    }
    }else{
    	alert("行项目不能为空！",2);
    	return;
    }
    /* if(!contactRecords || contactRecords == ""){    	
		alert("项目联系人不能为空！",2);
	    return;
    } */
    
    var contactRowLength = contactGrid.rowsLength();
    var contactRows = contactRowLength==0?[]:contactGrid.rows();
    
    var fileRowLength = fileGrid.rowsLength();
    var fileRows = fileRowLength==0?[]:fileGrid.rows();
    
    var data = {
			projectManageHead : JSON.stringify(headRecord),
			projectManageItem : JSON.stringify(itemRows),
			projectManageContact : JSON.stringify(contactRows),
			projectManageFile : JSON.stringify(fileRows),
		};

	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='项目管理保存中' key='i18n_alert_projectManageSaving'/>");
	$.ajax({
		url :"${pageContext.request.contextPath}/rest/ProjectManageService/addProjectManage",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.statusCode=="-200"){
				alert(data.message,3);
			}else{				
				alert("<i18n:I18n defaultValue='保存成功！' key='i18n_common_alert_savesuccess'/>",1);
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_returnParentPage" defaultValue="是否返回上级页面？" />',closeEvent:function(){
					parent.elsDeskTop.closeCurWin("projectManageAdd",callBack);
				}});
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n defaultValue='保存失败' key='i18n_common_alert_saveFail'/>",3);
		}
	});
});

$("#addFileBtn").click(function(){
	clearAddFileInfo();
	$("#addFileDialog").show();
	initFileUploader(fileUploader);
});

$("#addFileBtnOK").click(function(){
	$("#addFileDialog").hide();
	var filePath = $("#filePath").val();
	if(filePath == ""){
		alert("<i18n:I18n defaultValue='请选择上传文件！' key='i18n_please_select_a_file_to_upload'/>",1);
		return false;
	}
	addFileTableRow();
	clearAddFileInfo();
	//$( '#add-enq-sheet').tabs({active:1});//tab切换
	//预览文件内容
	currShowFile = filePath;
	previewFile(filePath);
});

//添加文件弹出框取消按钮
$("#addFileBtnCancel").click(function(){
	$("#addFileDialog").hide();
	clearAddFileInfo();
});

//关闭按钮处理
$("#dialogFileClose").click(function(){
	$("#addFileDialog").hide();
	clearAddFileInfo();
});
 
 //删除选择文件行事件
 $("#delFileBtn").click(function(){
     var selectedIndexes = fileGrid.selectedRowsIndex();
     var selectedRows = fileGrid.selectedRows();
     fileGrid.removeRow(selectedIndexes);
     
     var viewerPlaceA = $("#viewerPlaceHolder");
 	 viewerPlaceA.empty();//清空当前预览框
     reGenerateFileSequence();//删除文件行后,重新生成文件序号
 });

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

//增加文件到表单文件table
function addFileTableRow(){
	var fileName = $("#fileName").val();
	var filePath = $("#filePath").val();
	var fileTableRows = fileGrid.rowsLength();
	var fileSequence = fileTableRows+1;
	var item = {
			elsAccount : elsAccount,
			elsDesc : elsDesc,
			projectNumber : "",
			projectItemNumber : "",
			projectItemDesc : "",
			fileSequence : fileSequence,
			fileName : fileName,
			fileDesc : "",
			fileVersion : "",
			filePath : filePath,
			remark : "",
	};
	fileGrid.addRow(item);
}

function reGenerateFileSequence(){
	var fileTableRows = fileGrid.rowsLength();
	if(fileTableRows > 0){
    	for(var i=0;i<fileTableRows;i++){
    		var fileRow = fileGrid.row(i);
    		fileRow["fileSequence"] = i+1;
    	}
    	fileGrid.load(fileGrid.rows());
	}
}

function initFileUploader(fileUploader){
    //新增表单文件
    if (!fileUploader) {
  	fileUploader = WebUploader.create({
  	    swf : "${pageContext.request.contextPath}/jsLib/webuploader/Uploader.swf",// swf文件路径
  	    auto : true,//是否选择文件后自动上传
  	    server : "${pageContext.request.contextPath}/servlet/UploadServlet",// 文件接收服务端。
  	    pick : "#btnFileUpload",//选择文件的按钮,可选.内部根据当前运行时创建,可能是input元素,也可能是flash/
  	    resize : false,// 不压缩image,默认如果是jpeg,文件上传前会压缩再上传.
  	    formData : {
	     	elsAccount : elsAccount
	    }
  	});
  	
 	// 当有文件添加进来的时候
	fileUploader.on("fileQueued",function(file){
		var fileName = file.name;
		$("#fileName").val(fileName);
		$("#fileType").val(file.ext);
	});
 	//上传到服务器响应后触发
	fileUploader.on("uploadAccept", function( obj, response ) {
		var errorNumber = response.error;
		if(errorNumber == 0){
			var filePath = response.url;
			$("#filePath").val(filePath);
		} else {
   			var errorMessage = response.message;
   			alert(errorMessage,3);
		}
	  	});
	//上传出错时触发
	fileUploader.on( "uploadError", function( obj, reason  ) {
	  	   	var errorMessage = response.message;
	  	        alert(reason,3); 
	  	});
    }
}

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_projectManage']) {
		parent.frames['iframeApp_projectManage'].init();
	}
}
</script>
</body>
</html>