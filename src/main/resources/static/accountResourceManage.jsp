<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>

<script>	

	var totalCount = 0;
	var pageSize = 15;
	var currentPage = 1;

	function QueryData() {

		var frm = $("#accoutForm");
		
		$("#elsAccount2").val(currentElsAccount);
		
		$.ajax({
			url : frm[0].action,
			type : frm[0].method,
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				
				totalCount = data.total;
				$("#dgSubList").datagrid('loadData', data);
				
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',3);
				
			}
		});

	}
	
	
		

	$(function(){	
		
		
		QueryData();   
		
		$('#dgSubList').datagrid({
			
			singleSelect:true,
			pageSize:pageSize,
			pageList:[20,30,50,100],
			method:"post",
			rownumbers:true,//行号 
			selectOnCheck: true,
			checkOnSelect: true,
			<base:permission needPermission="permissionManage-updateAccountResource" elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}">
			toolbar:[
	             {
                	text:'<i18n:I18n key="i18n_label_updatepermission" defaultValue="修改权限!" />',iconCls:'icon-edit',handler:function(){  
	            	 var checkedItems = $('#dgSubList').datagrid('getChecked');
	            	 if(checkedItems.length==0){
	            		 alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
	            	 }
	            	 $.each(checkedItems, function(index, item){
	            		
	            		 var url="resource/editAccountResource.jsp?elsAccount="+item.elsAccount+"&elsSubAccount="+item.elsSubAccount;
	            		 popWin.showWin("350","450",'<i18n:I18n key="i18n_label_updatesubaccountpermission" defaultValue="编辑子账号权限" />',url);
	            		
	            		 
	            		 });
	             }},
	             {
	                	text:'<i18n:I18n key="i18n_label_updaterole" defaultValue="修改角色" />',iconCls:'icon-edit',handler:function(){  
		            	 var checkedItems = $('#dgSubList').datagrid('getChecked');
		            	 if(checkedItems.length==0){
		            		 alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
		            	 }
		            	 $.each(checkedItems, function(index, item){
		            		
		            		 var url="resource/editAccountRole.jsp?elsAccount="+item.elsAccount+"&elsSubAccount="+item.elsSubAccount;
		            		 popWin.showWin("350","450",'<i18n:I18n key="i18n_label_updatesubaccountrole" defaultValue="编辑子账号角色" />',url);
		            		
		            		 
		            		 });
		             }}
	         ], 
			</base:permission>
			columns:[[
				{field:'_id',title:'<i18n:I18n key="i18n_label_choose" defaultValue="选择" />',checkbox:true},
				{field:'elsAccount',title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />',width:80},
				{field:'elsSubAccount',title:'<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号" />',width:80},
				{field:'isAdmin',title:'<i18n:I18n key="i18n_account_title_isadmin" defaultValue="是否管理员" />',width:180},
				{field:'station',title:'<i18n:I18n key="i18n_account_title_station" defaultValue="岗位" />',width:120,
					formatter: function(value, row, index){
					    if (value == "sale") {
					        return '<i18n:I18n key="i18n_account_select_stationtype_sell" defaultValue="销售岗位" />';
					    }
					    else {
					        return '<i18n:I18n key="i18n_account_select_stationtype_purchase" defaultValue="采购岗位" />';
					    }
					}	
				
				},
				{field:'name',title:'<i18n:I18n key="i18n_common_title_username" defaultValue="姓名" />',width:100},
				{field:'email',title:'<i18n:I18n key="i18n_account_title_email" defaultValue="邮箱" />',width:120},
				{field:'telphone1',title:'<i18n:I18n key="i18n_account_title_phonenumber" defaultValue="手机号" />',width:100},
				{field:'telphone2',title:'<i18n:I18n key="i18n_account_title_telephone" defaultValue="电话" />',width:100},
				{field:'fax',title:'<i18n:I18n key="i18n_account_title_faxnumber" defaultValue="传真" />',width:100}
				
				
			]]
		});
		
		
		
		
	});
		
		
	
		

	
</script>



<body>

<div id="accountManagerContent">
	<form id="accoutForm" action="rest/AccountService/subAccountList" method="post">
		<input type="hidden" id="pageSize" name="pageSize" value="20">
		<input type="hidden" id="currentPage" name="currentPage" value="1">
		<input type="hidden" id="elsAccount2" name="elsAccount">
		

			<table>
				<tr>
					<td>&nbsp;
					<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号" />：<input  class="easyui-textbox" type="text" id="elsSubAccount" name="elsSubAccount" />
					</td>
					<td>
					<td>&nbsp;
					 <a id="btnQuery" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="QueryData()"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></a>    
					</td>
				</tr>
			</table>
			
		</div>
	</form>

<p>
<table id="dgSubList" title="" class="easyui-datagrid" style="width:1248px;height:auto"></table>
</body>
</html>
