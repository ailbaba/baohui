<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<form id="auditForm" onsubmit="return false;">
		<input type="hidden" name="elsAccount" value="<%=session.getAttribute("elsAccount")%>"/>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_audit_lable_auditconfig" defaultValue="审批配置" /></span>
			<div class="common-box-line">		
				<main class="grid-container">
				<div class="grid-100">
					<table id="table-head"></table>
				</div>
				</main>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_audit_lable_stretegy" defaultValue="审批策略" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_audit_lable_addstretegy" defaultValue="新增策略" /></button>
				<button class="button-wrap" id="editBtn"><i18n:I18n key="i18n_audit_lable_updatestretegy" defaultValue="修改策略" /></button>
				<button class="button-wrap" id="deleteBtn"><i18n:I18n key="i18n_audit_lable_removestretegy" defaultValue="删除策略" /></button>
				<main class="grid-container">
				<div class="grid-100">
					<table id="table-item"></table>
				</div>
				</main>
			</div>
		</div>
		</form>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
<script type="text/javascript">
    var checkedIndex = "";
	var cols_head = [
				        {title:'<i18n:I18n key="i18n_common_title_businesstype" defaultValue="单据类型" />', name:'businessType', width: 200, align: 'center',renderer:function(val){
				        	if (val == "purchaseOrder") {
				        		return "<i18n:I18n key='i18n_title_purchaseorder' defaultValue='采购订单' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "delivery") {
				        		return "<i18n:I18n key='i18n_audit_lable_delivery' defaultValue='发货单' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "saleEnquiry") {
				        		return "<i18n:I18n key='i18n_audit_lable_saleenquiry' defaultValue='销售报价单' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "bargainEnquiry") {
				        		return "<i18n:I18n key='i18n_audit_lable_bargainenquiry' defaultValue='议价报价单' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "standardSupplier") {
				        		return "<i18n:I18n key='i18n_common_access_to_suppliers' defaultValue='供应商准入评估' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "c2fo") {
				        		return "<i18n:I18n key='i18n_businesstype_c2fo' defaultValue='企利通' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "project") {
				        		return "<i18n:I18n key='xx' defaultValue='立项' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "designDoc") {
				        		return "<i18n:I18n key='xx' defaultValue='设计文档' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "contract") {
				        		return "<i18n:I18n key='xx' defaultValue='合同管理' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "bidding") {
				        		return "<i18n:I18n key='xx' defaultValue='定标前' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	} else if (val == "preBidding") {
				        		return "<i18n:I18n key='xx' defaultValue='发布招标前' />" + "<input type='hidden' name='configList[][businessType]' value='" + val + "'/>";
				        	}
				        	return "";
				        }},
				        { title:'<i18n:I18n key="i18n_audit_title_headaudit" defaultValue="抬头审批" />', name:'headAudit' ,width:100, align:'center',renderer:function(val,item){
				        	//处理询报价-议价-没有头审批 @author update/jiangzhidong @date 20160808 begin
				        	if(!(item.businessType == "bargainEnquiry")){
				        		if (val == "Y") {
					        		return "<input name='configList[][headAudit]' type='checkbox' value='Y' checked/>";
					        	} else {
					        		return "<input name='configList[][headAudit]' type='checkbox' value='Y' />";
					        	}
				        	}
				        	//处理询报价-议价-没有头审批 @author update/jiangzhidong @date 20160808 end
				        }},
				        { title:'<i18n:I18n key="i18n_audit_title_itemaudit" defaultValue="行项目审批" />', name:'itemAudit' ,width:100, align:'center',renderer:function(val,item){
				        	//准入/订单-没有行审批 @author update/jiangzhidong @date 20160818 begin
				        	if(!(item.businessType == "purchaseOrder" || item.businessType == "standardSupplier" || item.businessType == "bidding" || item.businessType == "preBidding")){
				        		if (val == "Y") {
					        		return "<input name='configList[][itemAudit]' type='checkbox' value='Y' checked/>";
					        	} else {
					        		return "<input name='configList[][itemAudit]' type='checkbox' value='Y' />";
					        	}
				        	}
				        	//准入/订单-没有行审批 @author update/jiangzhidong @date 20160818 end
				        }},
				        { title:'<i18n:I18n key="" defaultValue="发送前条件检查" />', name:'sendCheck' ,width:100, align:'center',renderer:function(val){
				        	if (val == "Y") {
				        		return "<input name='configList[][sendCheck]' type='checkbox' value='Y' checked/>";
				        	} else {
				        		return "<input name='configList[][sendCheck]' type='checkbox' value='Y' />";
				        	}
				        }}];
	var cols_item = [
                        { title:'<i18n:I18n key="i18n_label_sort" defaultValue="排序" />', name:'sortOrder' ,width:100, align:'center', hidden:true},
				        {title:'<i18n:I18n key="i18n_audit_title_stretegycode" defaultValue="策略编码" />', name:'stretegyCode', width: 200, align: 'center'},
				        {title:'<i18n:I18n key="i18n_audit_title_stretegyname" defaultValue="策略名称" />', name:'stretegyName', width: 200, align: 'center'}
				        ]
	var headGrid;
	var itemGrid;
	function saveAuditConfig() {
		debugger;
		var frm = $("#auditForm");
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/AuditService/saveAuditConfig",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				debugger;
				if (data&&data.statusCode == "-100") {
				     parent.elsDeskTop.showLoading();
				     alert(data.message,3);
				 } else {
					 parent.elsDeskTop.hideLoading();
					 alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				}
			},
			error : function(data) {
				debugger;
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	function loadItem(businessType) {
		debugger;
		$.ajax({
			url :"<%=basePath%>rest/AuditService/getAuditStretegy/" + elsAccount + "/" + businessType,
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				debugger;
				itemGrid.load(data.rows);
			}
		});
	}
	$().ready(function(){
		//退出
		$("#exitBtn").click(function(){
			parent.elsDeskTop.closeCurWin('auditConfig');
		});
		$("#saveBtn").click(function(){
			saveAuditConfig();
		});
		$("#addBtn").click(function(){
			addStretegy();
		});
		$("#editBtn").click(function(){
			editStretegy();
		});
		$("#deleteBtn").click(function(){
			deleteStretegy();
		});
		debugger;
		//读取配置
		$.ajax({
			url :"<%=basePath%>rest/AuditService/getAuditConfig/" + elsAccount,
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				//处理询报价-报价-没有审批 @author update/jiangzhidong @date 20160808 end
				var obj = [];
				for(var i=0;i<data.rows.length;i++){
					if("saleEnquiry"!=data.rows[i].businessType){
						obj.push(data.rows[i])
					}
				}
				debugger;
				headGrid= $('#table-head').mmGrid({
			    	 cols: cols_head,
			    	 checkCol:true,
			         items: obj
				});
				//处理询报价-报价-没有审批 @author update/jiangzhidong @date 20160808 end
				headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
			    	if(item && item.businessType) {
			    		checkedIndex = rowIndex;
			    		loadItem(item.businessType);
			    	}
				});
				headGrid.on('loadSuccess',function() {
					debugger;
					if (!itemGrid) {
			    	    itemGrid = $('#table-item').mmGrid({
			    	        cols: cols_item,
			    	        checkCol:true,
			    	        items: []
			    	    });
			    	}
 					if (data.rows && data.rows.length > 0) {
 						if(checkedIndex == ""){
 							//默认选中第一行
 							headGrid.select(0);
 							checkedIndex = 0;
 							loadItem(data.rows[0].businessType);
 						}else{
 							headGrid.select(checkedIndex);
 							loadItem(data.rows[checkedIndex].businessType);
 						}
					}
				});
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	});
	function query() {
		//读取配置
		$.ajax({
			url :"<%=basePath%>rest/AuditService/getAuditConfig/" + elsAccount,
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				headGrid.load(data.rows);
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	function addStretegy() {
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
		var index = headGrid.selectedRowsIndex();
		if (index.length == 0) {
			headGrid.select(0);
		}
	    var businessType = headGrid.row(index[0]).businessType;
		//取出最大的sortOrder
		var sortOrder = 0;
		for(var i=0;i<itemGrid.rowsLength();i++){
			var temCode = itemGrid.row(i).sortOrder;
			if(!isNaN(temCode)){
				temCode = parseInt(temCode);
				if(sortOrder <= temCode)
					sortOrder = temCode;
			}		
		}
		debugger;
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editStretegy',
	        'windowTitle':'<i18n:I18n key="i18n_audit_lable_addstretegy" defaultValue="新增策略" />',
	        'iframSrc':'<%=basePath%>audit/editAuditStretegy.jsp?businessType='+businessType+'&sortOrder='+sortOrder,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
	function editStretegy() {
		var index = itemGrid.selectedRowsIndex();
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
		var stretegyCode = itemGrid.row(index[0]).stretegyCode;
		var businessType = itemGrid.row(index[0]).businessType;
		debugger;
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editStretegy',
	        'windowTitle':'<i18n:I18n key="i18n_audit_lable_updatestretegy" defaultValue="修改策略" />',
	        'iframSrc':'<%=basePath%>audit/editAuditStretegy.jsp?stretegyCode=' + stretegyCode + "&businessType="+businessType,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
	function deleteStretegy() {
		var index = itemGrid.selectedRowsIndex();
		if (index.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
			var stretegyCode = itemGrid.row(index[0]).stretegyCode;
			var businessType = itemGrid.row(index[0]).businessType;
			var data = {"elsAccount":elsAccount,"businessType":businessType,"stretegyCode":stretegyCode};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/AuditService/deleteAuditStretegyByCode",
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
</script>
</html>