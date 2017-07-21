<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_schedule_button_addtemplate" defaultValue="新增模板" /></button>
				<button class="button-wrap" id="editBtn"><i18n:I18n key="i18n_schedule_button_updatetemplate" defaultValue="修改模板" /></button>
				<button class="button-wrap" id="deleteBtn"><i18n:I18n key="i18n_schedule_button_deletetemplate" defaultValue="删除模板" /></button>
				<button class="button-wrap" id="assignBtn"><i18n:I18n key="i18n_schedule_button_assigntemplate" defaultValue="分配模板" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/OrderScheduleService/queryTemplate">
		<input type="hidden" name="elsAccount" value="<%=session.getAttribute("elsAccount")%>"/>
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">	
            <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />：</span><input name="templateCode" type="text"/></div>
            <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />：</span><input name="templateName" type="text"/></div>
            <button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
        	</div>
        </div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_schedule_lable_scheduletemplate" defaultValue="进度模板" /></span>
			<div class="common-box-line">		
				<main class="grid-container">
				<div class="grid-100">
					<table id="table-head"></table>
					 <div id="pg" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_schedule_lable_step" defaultValue="步骤" /></span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100">
					<table id="table-item"></table>
				</div>
				</main>
			</div>
		</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	
	var cols_head = [
				        {title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />', name:'templateCode', width: 100, align: 'center'},
				        { title:'<i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />', name:'templateName' ,width:150, align:'center'},
				        { title:'<i18n:I18n key="i18n_schedule_title_stepdesc" defaultValue="步骤简述" />', name:'stepsName' ,width:300, align:'center'}
				        ];
	var cols_item = [
				        {title:'<i18n:I18n key="i18n_schedule_title_stepcode" defaultValue="步骤编码" />', name:'stepCode', width: 200, align: 'center'},
				        {title:'<i18n:I18n key="i18n_label_stepName" defaultValue="步骤名称" />', name:'stepName', width: 200, align: 'center'}
				        ]
	var headGrid;
	var itemGrid;
	function loadItem(templateCode) {
		$.ajax({
			url :"<%=basePath%>rest/OrderScheduleService/getTemplateStep/" + elsAccount + "/" + templateCode,
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				itemGrid.load(data.rows);
			}
		});
	}
	$().ready(function(){
		//退出
		$("#exitBtn").click(function(){
			parent.elsDeskTop.closeCurWin('orderScheduleTemplateManage');
		});
		$("#addBtn").click(function(){
			addTemplate();
		});
		$("#editBtn").click(function(){
			editTemplate();
		});
		$("#assignBtn").click(function(){
			assignTemplate();
		});
		$("#deleteBtn").click(function(){
			deleteTemplate();
		});
		$("#queryBtn").click(function(){
			query();
		});
		var frm = $("#queryForm");
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        url : frm[0].action,
	        params: frm.serializeJSON(),
	        method:  frm[0].method,
	        root:"rows",
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        remoteSort:true,
	        plugins: [
	            $('#pg').mmPaginator({
	                style: 'plain'
	                , totalCountName: 'total'
	                , page: 1
	                , pageParamName: 'currentPage'
	                , limitParamName: 'pageSize'
	                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
	                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
	                , limit:null
	                , limitList: [10,20]
	            })
	        ]
	    });
		headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
	    	if(item && item.templateCode) {
	    		loadItem(item.templateCode);
	    	}
		});
		headGrid.on('loadSuccess',function(e,data) {
			if (!itemGrid) {
	    	    itemGrid = $('#table-item').mmGrid({
	    	        cols: cols_item,
	    	        checkCol:true,
	    	        items: []
	    	    });
	    	}
// 			if (data.rows && data.rows.length > 0) {
// 				//默认选中第一行
// 				headGrid.select(0);
// 				loadItem(data.rows[0].businessType);
// 			}
		});
	});
	function addTemplate() {
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editOrderScheduleTemplate',
	        'windowTitle':'<i18n:I18n key="i18n_schedule_button_addtemplate" defaultValue="新增模板" />',
	        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderScheduleTemplate.jsp',
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
	function assignTemplate(){
		var index = headGrid.selectedRowsIndex();
		if (index.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
		var templateCode = headGrid.row(index[0]).templateCode;
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'assignOrderScheduleTemplate',
	        'windowTitle':'<i18n:I18n key="i18n_schedule_button_assigntemplate" defaultValue="分配模板" />',
	        'iframSrc':'<%=basePath%>ordermanage/schedule/assignOrderScheduleTemplate.jsp?templateCode=' + templateCode,
	        windowMinWidth: 960,
	        windowMinHeight: 600,
	        'windowWidth':820,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	}
	function editTemplate() {
		var index = headGrid.selectedRowsIndex();
		if (index.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
		var templateCode = headGrid.row(index[0]).templateCode;
		var templateName = headGrid.row(index[0]).templateName;
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editOrderScheduleTemplate',
	        'windowTitle':'<i18n:I18n key="i18n_schedule_button_updatetemplate" defaultValue="修改模板" />',
	        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderScheduleTemplate.jsp?templateCode=' + templateCode + '&templateName=' + templateName,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
	function deleteTemplate() {
		var index = headGrid.selectedRowsIndex();
		if (index.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_schedule_confirm_deletetemplate" defaultValue="删除模板会导致该模板下所有未填报完成的进度丢失，是否确认删除？" />',closeEvent:function(){
			var templateCode = headGrid.row(index[0]).templateCode;
			var data = {"elsAccount":elsAccount,"templateCode":templateCode};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/OrderScheduleService/deleteTemplate",
				dataType : "json",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
					query();
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
	function query() {
		var frm = $("#queryForm");
		headGrid.opts.params = frm.serializeJSON();
		headGrid.load({});
	}
</script>
</html>