<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="editRoleBtn"><i18n:I18n key="i18n_label_updaterole" defaultValue="修改角色" /></button>
				<button id="addRoleBtn" class="button-wrap"><i18n:I18n key="i18n_label_addrole" defaultValue="添加角色" /></button>
				<button id="deleteBtn" class="button-wrap"><i18n:I18n key="i18n_label_deleterole" defaultValue="删除角色" /></button>
				<button class="button-wrap" id="toOperateBtn"><i18n:I18n key="i18n_account_button_assignpermission" defaultValue="分配权限" /></button>
				<button class="button-wrap" id="toDateRuleBtn"><i18n:I18n key="i18n_account_button_assigndatapermission" defaultValue="分配数据权限" /></button>
				<button id="toAppBtn" class="button-wrap"><i18n:I18n key="i18n_account_button_assignapp" defaultValue="分配应用" /></button>
				<button id="refreshBtn" class="button-wrap"><i18n:I18n key="i18n_account_button_flushpermission" defaultValue="刷新权限" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_rolelist" defaultValue="角色列表" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="roleGrid">
							<table id="roleTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 对话框 -->
	<div class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="icon/els.PNG" /> <span
					id="dialogTitle"><i18n:I18n key="i18n_label_updaterole" defaultValue="修改角色" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_label_roleCode" defaultValue="角色编码" />：</span><input id="roleCode" name="roleCode"
								type="text" />
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_label_rolename" defaultValue="角色名称" />：</span><input id="roleName" name="roleName"
								type="text" />
						</div>
					</div>
					<div class="mt-20">
						<button id="okBtn" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="cancelBtn" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	 var roleGrid;
	 var type="";
	 var roleCode="";
	$(document).ready(function() {
		$('button').button();
	});
	function insertRoleTable(){
		$('#roleGrid').html('<table id="roleTable"></table><div id="pg" style="text-align: right;"></div>');
		//列
	    var cols = [
	        {title:'<i18n:I18n key="i18n_label_roleCode" defaultValue="角色编码" />', name:'roleCode', width: 120, align: 'center'},
	        { title:'<i18n:I18n key="i18n_label_rolename" defaultValue="角色名称" />', name:'roleName' ,width:120, align:'center' },
	        { title:'<i18n:I18n key="i18n_label_roleType" defaultValue="角色类型" />', name:'elsAccount' ,width:120, align:'center',renderer:function(val){
	        	if(val=="sys"){
	        		return '<i18n:I18n key="i18n_label_systemdefinition" defaultValue="系统定义" />';
	        	}else{
	        		return '<i18n:I18n key="i18n_label_companydefinition" defaultValue="公司自定义" />';
	        	}
	        }},
	    ];

		var paramStr={"elsAccount":elsAccount};

		var height=$(document).height()-155;
	    //ch
	     roleGrid= $('#roleTable').mmGrid({
	    	 cols: cols,
	         url: "<%=basePath%>rest/RoleService/getAllRoleList",
					params : paramStr,
					method : 'post',
					root : "rows",
					loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
					noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
					checkCol : true,
					plugins : [ $('#pg').mmPaginator({
						style : 'plain',
						totalCountName : 'total',
						page : 1,
						pageParamName : 'currentPage',
						limitParamName : 'pageSize',
						height:height,
						limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />',
				        totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />',
						limit : null,
						limitList : [ 10, 20 ]
					}) ]
				});

				roleGrid.on('loadSuccess', function(e, data) {
					if (data.total > 0) {
						roleGrid.select(0);
					}
				});
			}

			insertRoleTable();

			//添加角色
			$("#addRoleBtn").click(function() {
				type="add";
				initDig(null);
			});

			//修改角色
			$("#editRoleBtn").click(function() {
				type="edit"
				initDig(1);
			});
			$("#refreshBtn").click(function(){
				$.ajax({
		    		url :"<%=basePath%>rest/RoleService/refreshPermission/" + elsAccount,
		    		type :"get",
		    		contentType : "application/json",
		    		dataType : "json",
		    		success : function(data) {
		    			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
		    		},
		    		error : function(data) {
		    			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		    		}
		    	}); 
			});
			//删除角色
			$("#deleteBtn").click(function() {
				var selectedIndexs=roleGrid.selectedRowsIndex();
				if(selectedIndexs.length<=0){
					alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
					return;
				}
				var roleType=roleGrid.row(selectedIndexs[0]).elsAccount;
				if(roleType=="sys"){
					alert('<i18n:I18n key="i18n_label_systemrolecannotbedeleted" defaultValue="系统角色不能删除！" />',2);
					return;
				}
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除" />',closeEvent:function(){
				var roleCode=roleGrid.row(selectedIndexs[0]).roleCode;
				var paramStr='{"elsAccount":"'+ elsAccount+ '","roleCode":"'+ roleCode+'"}';
				$.ajax({
		    		url :"<%=basePath%>rest/RoleService/delRole",
		    		type :"post",
		    		contentType : "application/json",
		    		data : paramStr,
		    		dataType : "json",
		    		success : function(data) {
		    			insertRoleTable();
		    			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
		    		},
		    		error : function(data) {
		    			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		    		}
		    	}); 
				}});
				
			});
			
			$("#okBtn").click(function() {
				if(type=="add"){
					addProc();
				}else if(type=="edit"){
					editProc();
				}
			});
			
			//关闭对话框
			$("#cancelBtn,.dialog-close-btn").click(function() {
				$('.fixed-dialog').hide();
			});
			
			//初始化对话框
			function initDig(status){
				if(status==null){//添加
					$("#dialogTitle").html('<i18n:I18n key="i18n_label_addrole" defaultValue="添加角色" />');
					$("#roleCode").attr("readonly",false);
					$("#roleCode").val('');
					$("#roleName").val('');
				}else{//修改
					var selectedIndexs=roleGrid.selectedRowsIndex();
					var roleType=roleGrid.row(selectedIndexs[0]).elsAccount;
					if(roleType=="sys"){
						alert('<i18n:I18n key="i18n_label_systemrolecannotbeupdated" defaultValue="系统角色不能修改！" />',2);
						return;
					}
					$("#dialogTitle").html('<i18n:I18n key="i18n_label_updaterole" defaultValue="修改角色" />');
					$("#roleCode").attr("readonly",true);
					$("#roleCode").val(roleGrid.row(selectedIndexs[0]).roleCode);
					$("#roleName").val(roleGrid.row(selectedIndexs[0]).roleName);
				}
				$('.fixed-dialog').show();
				$(".dialog-tip").height(200);
			}
			
			//添加过程
			function addProc(){
				var roleCode=$("#roleCode").val().trim();
				var roleName=$("#roleName").val().trim();
				if(roleCode.length<=0||roleCode==null){
					alert('<i18n:I18n key="i18n_label_rolecodecannotbeempty" defaultValue="角色编码不能为空！" />',2);
					return;
				}
				if(roleName.length<=0||roleName==null){
					alert('<i18n:I18n key="i18n_label_rolenamecannotbeempty" defaultValue="角色名称不能为空！" />',2);
					return;
				}
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){

				var paramStr='{"elsAccount":"'+ elsAccount+ '","roleCode":"'+ roleCode+ '","roleName":"'+ roleName+ '"}';
				$.ajax({
		    		url :"<%=basePath%>rest/RoleService/addRole",
		    		type :"post",
		    		contentType : "application/json",
		    		data : paramStr,
		    		dataType : "json",
		    		success : function(data) {
						if(data.statusCode==-100){
		    				alert(data.message);
		    			}else{
		    				insertRoleTable();
		    				$('.fixed-dialog').hide();
		    				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
		    			}
		    		},
		    		error : function(data) {
		    			alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',3);
		    		}
		    	}); 
				}});
			}
			
			//修改过程 
			function editProc(){
				var roleCode=$("#roleCode").val();
				var roleName=$("#roleName").val().trim();
				if(roleName.length<=0||roleName==null){
					alert('<i18n:I18n key="i18n_label_rolenamecannotbeempty" defaultValue="角色名称不能为空！" />',2);
					return;
				}
				
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_label_confirmmodification" defaultValue="是否确认修改?" />',closeEvent:function(){

				var paramStr='{"elsAccount":"'+ elsAccount+ '","roleCode":"'+ roleCode+ '","roleName":"'+ roleName+ '"}';
				$.ajax({
		    		url :"<%=basePath%>rest/RoleService/updateRole",
		    		type :"post",
		    		contentType : "application/json",
		    		data : paramStr,
		    		dataType : "json",
		    		success : function(data) {
		    			if(data.statusCode==-100){
		    				alert(data.message,2);
		    			}else{
		    				insertRoleTable();
		    				$('.fixed-dialog').hide();
		    				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
		    			}
		    		},
		    		error : function(data) {
		    			alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',3);
		    		}
		    	}); 
				}});
			}
			
			//分配权限
			$("#toOperateBtn").click(function() {
				var selectedIndexs=roleGrid.selectedRowsIndex();
				var roleCode=roleGrid.row(selectedIndexs[0]).roleCode;
<%--            var url="<%=basePath%>roleResourceManage.jsp?roleCode="+roleCode; --%>
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'roleResourceManage',
			        'windowTitle':'<i18n:I18n key="i18n_account_button_assignpermission" defaultValue="分配权限" />',
			        windowSubTitle: companyShortName,
			        'iframSrc':"<%=basePath%>roleResourceManage.jsp?roleCode="+roleCode,
			        'windowWidth':350,
			        'windowHeight':640,
			        'parentPanel':".currDesktop"
			    });
			});
			
			//分配应用
			$("#toAppBtn").click(function() {
				var selectedIndexs=roleGrid.selectedRowsIndex();
				var roleCode=roleGrid.row(selectedIndexs[0]).roleCode;
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'roleAppManage',
			        'windowTitle':'<i18n:I18n key="i18n_account_button_assignapp" defaultValue="分配应用" />',
			        windowSubTitle: companyShortName,
			        'iframSrc':"<%=basePath%>roleAppManage.jsp?roleCode="+roleCode,
			        'windowWidth':350,
			        'windowHeight':450,
			        'parentPanel':".currDesktop"
			    });
			});
			
			//分配数据权限
			$("#toDateRuleBtn").click(function() {
				var selectedIndexs=roleGrid.selectedRowsIndex();
				var roleCode=roleGrid.row(selectedIndexs[0]).roleCode;
				 parent.elsDeskTop.defineWin({
     		        'iconSrc':'icon/els-icon.png',
     		        'windowsId':'dataRuleManage',
     		        'windowTitle':'<i18n:I18n key="i18n_account_button_assigndatapermission" defaultValue="分配数据权限" />',
     		        windowSubTitle: companyShortName,
     		        'iframSrc':'<%=basePath%>datapermission/dataRuleManage.jsp?ruleType=1&ruleTarget=' +roleCode,
     		        'windowWidth':800,
     		        'windowHeight':500,
     		        'parentPanel':".currDesktop"
     		    });
			});
			
			
			//退出
			$("#exitBtn").click(function(){
				parent.elsDeskTop.closeCurWin('roleManager',closeCallback);
			});
			
			function closeCallback() {
//	 			if (parent.frames["iframeApp_queryReceipt"]) {
//	 				parent.frames["iframeApp_queryReceipt"].insertMaterialVoucherHeaderTable();
//	 			}
			}
		</script>
</body>
</html>