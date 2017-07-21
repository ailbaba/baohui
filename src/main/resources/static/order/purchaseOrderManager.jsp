<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../sessionCheck.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>ELS互联网企业解决方案</title>
<link rel="icon" href="images/logo.ico">
<link rel="shortcut icon" href="images/logo.ico"/>
<link rel="stylesheet" type="text/css" href="../alert/jquery.alerts.css">
<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../easyui/demo.css">
<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
<script src="../js/jquery.serializejson.js" type="text/javascript"></script>
<script src="../js/json2.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/popwin.js" type="text/javascript"></script>
<script src="../alert/jquery.alerts.js" type="text/javascript"></script>
<script type="text/javascript">

toElsAccount=GetQueryString("toElsAccount");

elsAccount='<%=session.getAttribute("elsAccount") %>';
elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';

	var totalCount = 0;
	var pageSize = 20;
	var currentPage = 1;
	
	
	
	
	function QueryPurchaseOrderHeader() {

		
		
		var frm = $("#purchaseOrderForm");
		
		$.ajax({
			url : frm[0].action,
			type : frm[0].method,
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				
				totalCount = data.total;
				$("#dg").datagrid('loadData', data);
				
			},
			error : function(data) {
				$.messager.alert("提示", "查询出错");
				
			}
		});

	}
	

	
	$(function(){
		
		$('#purchaseOrderHeader').datagrid({
			pagination:true,
			singleSelect:true,
			pageSize:pageSize,
			pageList:[20,30,50,100],
			method:"post",
			//rownumbers:true,//行号 
			selectOnCheck: true,
			checkOnSelect: true,
			toolbar:[{ 
	             text:'新建订单',iconCls:'icon-add',handler:function(){  
	            	 var checkedItems = $('#purchaseOrderHeader').datagrid('getChecked');
	            	 if(checkedItems.length==0){
	            		 $.messager.alert("提示", "请选择至少一行！");
	            	 }
	            	 
	             }},
	             {text:'修改订单',iconCls:'icon-edit',handler:function(){  
	            	
	             }},
	             {text:'删除订单',iconCls:'icon-remove',handler:function(){  
		            	
	             }},
	             {text:'从SAP提取',iconCls:'icon-add',handler:function(){  
		            	
	             }}
			
			
			], 
			
			columns:[[
				{field:'id',title:'选择',checkbox:true},
				{field:'elsAccount',title:'采购凭证号',width:80},
				{field:'nature',title:'订单类型',width:80},
				{field:'fullName',title:'采购订单状态',width:80},
				{field:'shortName',title:'订单发送状态',width:100},
				{field:'nature',title:'采购凭证日期',width:100},
				{field:'industryDetail',title:'货币',width:80},
				{field:'countryCode',title:'订单交收状态',width:80},
				{field:'province',title:'备注',width:100},
				{field:'city',title:'时间戳',width:100},
				{field:'address',title:'备注1',width:100},
				{field:'address',title:'备注2',width:100},
				{field:'address',title:'备注3',width:100},
				{field:'address',title:'负责人',width:80},
				{field:'address',title:'对方负责人',width:80}
				
				
			]]
		});
		
		QueryPurchaseOrderHeader();   
		
		var pager = $('#purchaseOrderHeader').datagrid().datagrid('getPager');	
		 $(pager).pagination({ 
			 total:totalCount,
			 pageSize:pageSize,
	         onSelectPage: function (pageNumber, pageSize) { 
	            $("#pageSize").val(pageSize);
				$("#currentPage").val(pageNumber);
	             QueryPurchaseOrderHeader();   
	         } 
	     });
		
		 
		 
		 $('#purchaseOrderItem').datagrid({
				pagination:true,
				singleSelect:true,
				pageSize:pageSize,
				pageList:[20,30,50,100],
				method:"post",
				//rownumbers:true,//行号 
				selectOnCheck: true,
				checkOnSelect: true,
				toolbar:[{  
		            
		         }], 
				
				columns:[[
					{field:'id',title:'选择',checkbox:true},
					{field:'elsAccount',title:'项目编号',width:80},
					{field:'nature',title:'网格值',width:80},
					{field:'fullName',title:'物料号',width:80},
					{field:'shortName',title:'物料描述',width:100},
					{field:'nature',title:'采购订单数量',width:100},
					{field:'industryDetail',title:'单价',width:80},
					{field:'countryCode',title:'数量单位',width:80},
					{field:'province',title:'价格单位',width:100},
					{field:'city',title:'价格量度单位',width:100},
					{field:'address',title:'已经交货数量',width:100},
					{field:'address',title:'在途数量',width:100},
					{field:'address',title:'已经收货数量',width:100},
					{field:'address',title:'待检入库数量',width:80},
					{field:'address',title:'退货数量',width:80},
					
					{field:'address',title:'订单批次',width:80},
					{field:'address',title:'订单生产状态',width:80},
					{field:'address',title:'交货日期',width:80},
					{field:'address',title:'工厂',width:80},
					{field:'address',title:'退货数量',width:80},
					{field:'address',title:'退货数量',width:80},
					{field:'address',title:'退货数量',width:80},
					{field:'address',title:'退货数量',width:80}
					
				]]
			});
		 
		 
		 $('#purchaseOrderFile').datagrid({
				pagination:true,
				singleSelect:true,
				pageSize:pageSize,
				pageList:[20,30,50,100],
				method:"post",
				//rownumbers:true,//行号 
				selectOnCheck: true,
				checkOnSelect: true,
				toolbar:[{  
		            
		         }], 
				
				columns:[[
					{field:'id',title:'选择',checkbox:true},
					{field:'elsAccount',title:'本方ELS号',width:100},
					{field:'nature',title:'对方ELS号',width:100},
					{field:'fullName',title:'采购订单编号',width:150},
					{field:'shortName',title:'行项目编号',width:100},
					{field:'nature',title:'文件类型',width:100},
					{field:'industryDetail',title:'文件名称',width:150},
					{field:'countryCode',title:'收发状态',width:80}

				]]
			});
		 
		 
	});
	
</script>

<body>

<div id="purchaseOrderInfoContent">
	<form id="purchaseOrderForm" action="../rest/AccountService/findEnterpriseByCondition" method="post">
		<input type="hidden" id="pageSize" name="pageSize" value="20">
		<input type="hidden" id="currentPage" name="currentPage" value="1">
		<div>

			<table>
				<tr>
					<td>&nbsp;
					订单号：<input  class="easyui-textbox" size="15" type="text" id="elsAccount" name="elsAccount" />
					</td>
					<td>&nbsp;
					负责人：<input class="easyui-textbox" size="10" type="text" id="shortName" name="shortName" />
					</td>
					<td>&nbsp;
					备注：<input class="easyui-textbox" type="text" id="shortName" name="shortName" />
					</td>
					<td>&nbsp;
					订单状态：<select class="" id="purchaseOrderStatus" name="purchaseOrderStatus">
							<option value="0">0_对方未确认</option>
							<option value="1">1_对方已确认</option>
							<option value="2">2_对方退回</option>
							<option value="3">3_变更对方未确认</option>
							<option value="4">4_对方变更确认</option>
							<option value="5">5_对方变更退回</option>
							<option value="6">6_关闭</option>
							<option value="7">7_更新生成状态</option>
					</select>
					</td>
					<td>&nbsp;
					记录时间：<input class="easyui-datebox" value="" style="width:120px">
					到<input class="easyui-datebox" value="" style="width:100px">
					</td>
					<td>&nbsp;
					 <a id="btnQuery" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="QueryPurchaseOrderHeader()">查询</a>    
					</td>
				</tr>
			</table>
			
		</div>
	</form>




</div>
<br>

<div class="easyui-tabs" style="width:1268px;height:auto;">
		<div title="采购订单头"   style="padding:10px;">
			<table id="purchaseOrderHeader" title="" class="easyui-datagrid" style="width:1248px;height:auto"></table>
		</div>
</div>

<p><a id="btnSession" href="#" class="easyui-linkbutton"  onclick="">进入对话</a>    

</p>

<div class="easyui-tabs" style="width:1268px;height:auto;">
		<div title="采购行项目"   style="padding:10px;">
			<table id="purchaseOrderItem" title="" class="easyui-datagrid" style="width:1248px;height:auto"></table>
		</div>
		<div title="表单文件"  style="padding:10px;">
			<table id="purchaseOrderFile" title="" class="easyui-datagrid" style="width:1248px;height:auto"></table>
		</div>
</div>

</body>
</html>
