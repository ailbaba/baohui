<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
	        <form id="requirementsplanningForm">
            <div class="common-box-line">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementsPlanning_table_demandPlanNumber" defaultValue="需求计划单号:" /></span>
			       <input id="requirementsPlanningNumber" name="requirementsPlanningNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_common_title_orderitemnumber" defaultValue="项目编号:" /></span>
			       <input id="projectNumber" name="projectNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementsPlanning_table_projectName" defaultValue="项目名称:" /></span>
			       <input id="projectDesc" name="projectDesc" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementsPlanning_table_projectStartDate" defaultValue="项目开始时间:" /></span>
			       <input class="Wdate" onfocus="WdatePicker()" id="actualStartDate" name="actualStartDate" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementsPlanning_table_projectEndDate" defaultValue="项目结束时间:" /></span>
			       <input class="Wdate" onfocus="WdatePicker()" id="actualEndDate" name="actualEndDate" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementsPlanning_table_projectSite" defaultValue="项目地点:" /></span>
			       <input id="projectAddress" name="projectAddress" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementsPlanning_table_responsiblePerson" defaultValue="责任人:" /></span>
			       <input id="projectLeader" name="projectLeader" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementsPlanning_documentStatus" defaultValue="单据状态:" /></span>
			       <select id="status" name="status">
			           <option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
			           <option value="0"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" /></option>
			           <option value="1"><i18n:I18n key="testssst" defaultValue="审批中" /></option>
			           <option value="2"><i18n:I18n key="i18n_requirementsPlanning_select_approvalBy" defaultValue="审批通过" /></option>
			           <option value="3"><i18n:I18n key="i18n_js_close" defaultValue="关闭" /></option>
			           <option value="4"><i18n:I18n key="test111k" defaultValue="拒绝" /></option>
			       </select>
		        </div>
            </div>
        	</form>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="物料属性条件" key="i18n_materialList_title_materialAttributeCondition"/></span>
            <div class="common-box-line" id="attrSelectDiv">
				<div class="dis-in-b input-and-tip"> 
					<span><select name="attr"></select></span>
					<input type="text" name="attr" />
				</div>
            	<button id="addAttrCondBtn" class="button-wrap">+</button>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="query-requirementsplanning" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="add-requirementsplanning" class="button-wrap"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" /></button>
                </div>
               <%--
		        <div class="dis-in-b input-and-tip">
                     <button id="sendBtn" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="submit-requirementsplanning" class="button-wrap"><i18n:I18n key="i18n_requirementsPlanning_button_Approval" defaultValue="报批" /></button>
                </div>
                 --%>
                <div class="dis-in-b input-and-tip">
                     <button id="close-requirementsplanning" class="button-wrap"><i18n:I18n key="i18n_js_close" defaultValue="关闭" /></button>
                </div>
                <%-- <base:auditConfig elsAccount="${elsAccount }" businessType="requirementplan">
					<button id="entryBtn" class="button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批" /></button>
					<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
					<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_approval_flow" defaultValue="流程" /></button>
				</base:auditConfig> --%>
				<button id="btnAuditConfig" class="button-wrap"><i18n:I18n key="xyz" defaultValue="创建审批" /></button>
                <%-- <div class="dis-in-b input-and-tip">
                     <button id="excel-import" class="button-wrap"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="excel-template-download" class="button-wrap"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="Excel模板下载" /></button>
                </div> --%>
            </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-requirementsPlanningHead"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
	</div>

<script>
var encode = window.btoa || Base64.encode,
decode = window.atob || Base64.decode;
var elsAccount="${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";

var requirementsPlanningHeadGrid;
var requirementsPlanningNumber ="${param.requirementsPlanningNumber}";

$().ready(function(){
	initMaterialAttrSelect();
	init();
});	

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//日期格式渲染 yyyy-MM-dd
function rendererDate(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
	return val;
}

var renderFormatStatus = function(val,item,rowIndex){
	if("0"==val){
		return "<i18n:I18n key='i18n_enquiry_select_enquirystatus_create' defaultValue='新建' />";
	} else if("1"==val){
		return "<i18n:I18n key='testssst' defaultValue='审批中' />";
	} else if("2"==val){
		return "<i18n:I18n key='i18n_requirementsPlanning_select_approvalBy' defaultValue='审批通过' />";
	} else if("3"==val){
		return "<i18n:I18n key='i18n_js_close' defaultValue='关闭' />";
	} else if("4"==val){
		return "拒绝";
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

function rendererOperation(val, item, rowIndex){      
	var text = '<span class="check-requirementsplanning" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	if(item.status == 0){
		text += '&nbsp;&nbsp;<span class="update-requirementsplanning" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
              +'&nbsp;&nbsp;<span class="delete-requirementsplanning" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
		      ;<%--+'&nbsp;&nbsp;<span class="recDetails" style="color:blue;cursor:pointer;"><i18n:I18n key="" defaultValue="供应商报回" /></span>';
	} else if(item.status == 1){
		text += '&nbsp;&nbsp;<span class="recDetails" style="color:blue;cursor:pointer;"><i18n:I18n key="" defaultValue="供应商报回" /></span>';
	--%>
	} else {
	}
	return text;
}

$('.check-requirementsplanning').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    showFrame(item,"check");
});

$('.update-requirementsplanning').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    showFrame(item,"update");
});

function showFrame(item,operation){
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'detailsRequirementsPlanning',
        'windowTitle':'<i18n:I18n key="i18n_requirementsPlanning_title_requirementPlanningDetail" defaultValue="需求计划明细项"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'${pageContext.request.contextPath}/projectmanage/requirementsplanning/detailsRequirementsPlanning.jsp?frameAppId=requirementsPlanningManage&operationType='
        		+operation+'&requirementsPlanningNumber='+item.requirementsPlanningNumber+'&projectNumber='+item.projectNumber+'&projectItemNumber='+item.projectItemNumber,
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
}


var requirementsPlanningHeadCols = [
		{ title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作"/>', name:'operation' , width:160, align:'center',clickDisable:true,renderer : rendererOperation},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_lable_demandPlanNumber" defaultValue="需求计划编号"/>', name:'requirementsPlanningNumber' , width:120, align:'center'},
		{ title:'<i18n:I18n key="i18n_common_title_orderitemnumber" defaultValue="项目编号"/>', name:'projectNumber' , width:120, align:'center'},
		{ title:'<i18n:I18n key="i18n_quotation_itemnumber" defaultValue="行项目编号"/>', name:'projectItemNumber' , width:120, align:'center'},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_table_projectName" defaultValue="项目名称"/>', name:'projectDesc' , width:120, align:'center'},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_lable_projectItemDescription" defaultValue="项目行描述"/>', name:'projectItemDesc' , width:120, align:'center'},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_table_responsiblePerson" defaultValue="责任人"/>', name:'projectLeader' , width:120, align:'center'},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_lable_startDate" defaultValue="开始日期"/>', name:'actualStartDate' , width:120, align:'center',renderer: rendererDate},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_lable_endDate" defaultValue="结束日期"/>', name:'actualEndDate' , width:120, align:'center',renderer: rendererDate},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_table_projectSite" defaultValue="项目地点"/>', name:'projectAddress' , width:120, align:'center'},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_documentStatus" defaultValue="单据状态"/>', name:'status' , width:120, align:'center',renderer :renderFormatStatus},
		{ title:'<i18n:I18n key="" defaultValue="审批状态"/>', name:'auditStatus' , width:120, align:'center',renderer :renderFormatApprove},
		{ title:'<i18n:I18n key="i18n_audit_lable_auditpersons" defaultValue="审批人"/>', name:'approvePerson' , width:120, align:'center'},
		{ title:'<i18n:I18n key="i18n_requirementsPlanning_lable_approvalTime" defaultValue="审批时间"/>', name:'approveDate' , width:120, align:'center',renderer:rendererTime},
		{ title:'<i18n:I18n key="i18n_label_remark" defaultValue="备注"/>', name:'remark' , width:120, align:'center'},
		{ title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
		{ title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
		{ title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
		{ title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime}
	];

function init(){
    
	$("#elsAccount").val(elsAccount);
	if(requirementsPlanningNumber != null && requirementsPlanningNumber != "null"){
		$("#requirementsPlanningNumber").val(requirementsPlanningNumber);
	}
	
	var frm = $("#requirementsplanningForm");
	
    requirementsPlanningHeadGrid=$('#table-requirementsPlanningHead').mmGrid({
	    cols: requirementsPlanningHeadCols,
	    url: '${pageContext.request.contextPath}/rest/RequirementsPlanningService/findHeadList',
	    params: frm.serializeJSON(),
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    multiSelect:false,
	    plugins: [
           	$('#pg').mmPaginator({
				style : "plain",
				totalCountName : "total",
				page : 1,
				pageParamName : "currentPage",
				limitParamName : "pageSize",
				limitLabel : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
				totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
				limit : null,
				limitList : [10,20,30,50]
           	})
       ]
	});
    
}

//增加
$("#add-requirementsplanning").click(function() {
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'addRequirementsPlanning',
        'windowTitle':'<i18n:I18n key="i18n_requirementsPlanning_title_newDemandPlan" defaultValue="新增需求计划"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'${pageContext.request.contextPath}/projectmanage/requirementsplanning/addRequirementsPlanning.jsp',
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
	
});

function queryRequirementsplanning() {
	var frm = $("#requirementsplanningForm");
	var queryDataObj = frm.serializeJSON();
	var attributeList = [];
    $("#attrSelectDiv div").each(function(){
    	var attrCode = $(this).find("select[name='attr']").eq(0).val();
    	var attrValue = $(this).find("input[name='attr']").eq(0).val();
    	attributeList.push({
    		materialAttrCode : attrCode,
    		materialAttrValue : attrValue,
    	});
    });
    queryDataObj["attrList"] = attributeList;
	
	requirementsPlanningHeadGrid.opts.params = queryDataObj;
	requirementsPlanningHeadGrid.load({page:1});
}

//查询
$("#query-requirementsplanning").click(function() {
	queryRequirementsplanning();
});


$('.delete-requirementsplanning').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除需求计划？" key="i18n_requirementsPlanning_alert_confirmDeleteRequirementPlan"/>',closeEvent:function(){
    	$.ajax({
			url :"${pageContext.request.contextPath}/rest/RequirementsPlanningService/delete",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(item),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryRequirementsplanning();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
    	
    }});
});

$('#close-requirementsplanning').live("click", function() {
	var selectRows = requirementsPlanningHeadGrid.selectedRows();
	if(selectRows.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var row = selectRows[0];
	if(row.status == 3){
		alert("该需求计划已经关闭，无需再次操作！",2);
		return;
	}
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭需求计划？" key="i18n_requirementsPlanning_alert_determineClosureRequirementsPlan"/>',closeEvent:function(){
    	$.ajax({
			url :"${pageContext.request.contextPath}/rest/RequirementsPlanningService/close",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(selectRows[0]),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryRequirementsplanning();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
    	
    }});
});

$(".recDetails").live("click", function() {
	var rowIndex = $(this).closest("tr").index();
	var row = requirementsPlanningHeadGrid.row(rowIndex);
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'purchaseRequirePlanDetail',
        'windowTitle':'<i18n:I18n key="" defaultValue="需求回复详情"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'${pageContext.request.contextPath}/projectmanage/requirementsplanning/purchase/purchaseRequirePlanDetail.jsp?frameAppId=requirementsPlanningManage'
    		+'&requirementsPlanningNumber='+row.requirementsPlanningNumber+'&projectNumber='+row.projectNumber+'&projectItemNumber='+row.projectItemNumber,
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
});

function initMaterialAttrSelect(){
	var select = $("#attrSelectDiv select[name='attr']");
    $.ajax({
		url : "${pageContext.request.contextPath}/rest/MaterialCateService/queryMaterialSpecList",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"elsAccount":elsAccount}),
		dataType : "json",
		success : function(data) {
			var rows = data.rows;
			if(typeof(rows)!="undefined" && rows.length>0){
				for(var i=0;i<rows.length;i++){
					var record = rows[i];
					$("<option value='"+record.materialSpecCode+"'>"+record.materialSpecName+"</option>").appendTo(select);
				}
			}
		},
		error : function(data) {
			alert("<i18n:I18n defaultValue='获取物料属性失败' key='i18n_alert_queryMaterialAttrFail'/>",3);
		}
	});
}

$("#addAttrCondBtn").click(function(){
	var attrParentDiv = $("#attrSelectDiv");
	var selectSize = attrParentDiv.children("div").length;
	var div = $(this).prev("div");
	$(this).before(div.clone());
});

$("#sendBtn").click(function(){
	var selectHeads = requirementsPlanningHeadGrid.selectedRows();
	if("undefined"==typeof(selectHeads) || selectHeads==null || selectHeads.length==0){
		alert("请先选择需求计划发送",2);
	} else {
		if(selectHeads[0] != null){
			var head = selectHeads[0];
			var auditStatus = head.status;
			if(auditStatus != null && auditStatus == 0){
				parent.elsDeskTop.showLoading("发送中...");
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/RequirementsPlanningService/sendToAllSuppplier",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(head),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						if("200"==data.statusCode){
							alert("发送成功",1);
						} else if(data.statusCode == "-200"){
							alert(data.message,2);
						} else {
							alert("发送失败:"+data.message,3);
						}
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("发送需求计划失败",3);
					}
				});
			} else {
				alert('创建审批的项目不能再发送！',2);
			}
		}
	}
});

$("#btnAuditConfig").click(function() {
	var selectRows = requirementsPlanningHeadGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		if(headRecord.status == 3) {
			alert("该需求计划已经关闭，不能再进行任何审批相关操作！",3);
			return;
		}
		var auditStatus = headRecord.auditStatus;
		if(auditStatus == null || auditStatus == "1"){
			var requirementsPlanningNumber = headRecord.requirementsPlanningNumber;
			var projectNumber = headRecord.projectNumber;
			var projectItemNumber = headRecord.projectItemNumber;
			var combJosnArrStr = JSON.stringify(retCombKeyArr(requirementsPlanningNumber,projectNumber,projectItemNumber));
			var jsonData = {
					"elsAccount" : elsAccount,
					"businessKey" : combJosnArrStr
				};
			$.ajax({
				url :"<%=basePath%>rest/RequirementsPlanningService/checkIsEntried",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(jsonData),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data > 0){
						alert('<i18n:I18n key="xx" defaultValue="单据已提交审批，不能重复创建审批" />',3);
					}else{
						selfCreateAuditConfig(combJosnArrStr);
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
			alert("已提交的审批不能再次创建审批！",2);
		}
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}
});

function selfCreateAuditConfig(businessKey){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'requireplanAuditConfig',
        'windowTitle':'<i18n:I18n key="xxx" defaultValue="创建审批" />',
        'iframSrc':'<%=basePath%>audit/requireplanAuditConfig.jsp?businessType=requirementplan&businessKey='
        		+ encode(businessKey),
        'windowWidth':800,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
}

$("#flowBtn").click(function(){
	var selectRows = requirementsPlanningHeadGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		if(headRecord.status == 3) {
			alert("该需求计划已经关闭，不能再进行任何审批相关操作！",3);
			return;
		}
		var requirementsPlanningNumber = headRecord.requirementsPlanningNumber;
		var projectNumber = headRecord.projectNumber;
		var projectItemNumber = headRecord.projectItemNumber;
		var flowCode = headRecord.flowCode;
		 if (flowCode == null || flowCode == "00") {
				alert('<i18n:I18n key="xx" defaultValue="需求计划尚未上报" />',2);
			} else {
				var combJosnArr = retCombKeyArr(requirementsPlanningNumber,projectNumber,projectItemNumber);
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'auditFlowList',
			        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
			        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount
			        		+ '&businessType=requirementplan&businessId=' + encode(JSON.stringify(combJosnArr)),
			        windowMinWidth: 480,
			        windowMinHeight: 600,
			        'windowWidth':680,
			        'windowHeight':500,
			        'parentPanel':".currDesktop"
			    });
			}
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}	
});

//提交审批
$("#entryBtn").click(function(){
	var selectRows = requirementsPlanningHeadGrid.selectedRows();
	if(selectRows && selectRows!="") {
		var headRecord = selectRows[0];
		if(headRecord.status == 3) {
			alert("该需求计划已经关闭，不能再进行任何审批相关操作！",2);
			return;
		}
		if(headRecord.status == 2) {
			alert("该需求计划已审批通过！",2);
			return;
		}
		if(headRecord.status == 4) {
			alert("该需求计划已被审批拒绝！",2);
			return;
		}
		var requirementsPlanningNumber = headRecord.requirementsPlanningNumber;
		var projectNumber = headRecord.projectNumber;
		var projectItemNumber = headRecord.projectItemNumber;
		var businessIdStr = retCombKeyArr(requirementsPlanningNumber,projectNumber,projectItemNumber);
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="xx" defaultValue="是否确认提交？" />',closeEvent: function(){
			var data = {
					"elsAccount" : elsAccount,
					"elsSubAccount" : elsSubAccount,
					"requirementsPlanningNumber" : requirementsPlanningNumber,
					"projectNumber" : projectNumber,
					"projectItemNumber" : projectItemNumber,
					"businessKey" : JSON.stringify(businessIdStr)
				};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/RequirementsPlanningService/entryProject",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.statusCode != "200") {
						alert(data.message,3);
						return;
					}
					alert("<i18n:I18n key="xx" defaultValue="提交成功" />");
					window.location.reload();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						if (data.status == "401") {
							alert("<i18n:I18n key="xx" defaultValue="项目已提交审批，不能重复提交" />",3);
						} else {
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						};
					}
				}
			});
		}});
	}
});

$("#cancelEntryBtn").click(function(){
	var selectRows = requirementsPlanningHeadGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		if(headRecord.status == 3) {
			alert("该需求计划已经关闭，不能再进行任何审批相关操作！",3);
			return;
		}
		var requirementsPlanningNumber = headRecord.requirementsPlanningNumber;
		var projectNumber = headRecord.projectNumber;
		var projectItemNumber = headRecord.projectItemNumber;
		var flowCode = headRecord.flowCode;
		if (flowCode == null || flowCode == "00") {
			alert("<i18n:I18n key="xx" defaultValue="需求计划尚未上报" />",2);
		} else {
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="xx" defaultValue="您确定要撤销审批吗？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				var businessIdStr = retCombKeyArr(requirementsPlanningNumber,projectNumber,projectItemNumber);
				var param = {
						"businessElsAccount": elsAccount,
						"requirementsPlanningNumber": requirementsPlanningNumber,
						"projectNumber": projectNumber,
						"projectItemNumber": projectItemNumber,
						"elsAccount": elsAccount,
						"elsSubAccount": elsSubAccount,
						"businessKey" : JSON.stringify(businessIdStr)
				};
				$.ajax({
					url :"<%=basePath%>rest/RequirementsPlanningService/cancelAudit",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(param),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n key="i18n_delivery_revokesuccess" defaultValue="撤销成功" />");
						window.location.reload();
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						if (!permissionError(data)) {
							if (data.status == "401") {
								alert("<i18n:I18n key="xx" defaultValue="流程结束的项目不能撤销审批" />",3);
							} else if (data.status == "403") {
								alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",3);
							} else {
								alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
							}
						}
					}
				});
			}});
		}
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}
});

function retCombKeyArr(key1,key2,key3) {
	return {
		"rpNO": key1,
		"pNO": key2,
		"piNO": key3
	};
}

</script>
</body>
</html>