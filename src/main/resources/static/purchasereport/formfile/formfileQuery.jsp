<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ include file="../../header.jsp"%>

<script>	
	var totalCount = 0;
	var pageSize = 15;
	var currentPage = 1;
	
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	
	function QueryData() 
	{
		var frm = $("#FormFilesForm");
		
		$("#elsAccount").val(elsAccount);	
		var toelsaccount = $("#toelsaccount").val();
		var purchaseordernumber = $("#purchaseordernumber").val();
		var logtime  = $("#logtime").val();
		var logtime1 = $("#logtime1").val();		
		var filename = $("#filename").val();		

		
		$.ajax
		(
			{
				url : frm[0].action,
				type : frm[0].method,
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) 
				{
					totalCount = data.total;
					$("#FormfileList").datagrid('loadData', data);
				},

				error : function(data) 
				{
					$.messager.alert("提示", "查询出错");
				}
			}
		);
	}	
	
	$(function()
		{		
			QueryData();
			
			$('#FormfileList').datagrid
			(
				{
					singleSelect:true,
					pageSize:pageSize,
					pageList:[20,30,50,100],
					method:"post",
					rownumbers:true,
					selectOnCheck: true,
					checkOnSelect: true,					

					columns:[[
								{field:'_id'                 ,title:'选择'     ,checkbox:true},
								{field:'formId'              ,title:'ID'     ,width:60},
								{field:'elsAccount'          ,title:'ELS账号'  ,width:83},
								{field:'toElsAccount'        ,title:'ELS对方账号' ,width:85},
								{field:'purchaseOrderNumber' ,title:'采购订单号'     ,width:100},
								{field:'orderItemNumber'     ,title:'订单项编号'  ,width:100},
								{field:'fileType'            ,title:'文件类型' ,width:85},
								{field:'fileName'            ,title:'文件名称'     ,width:85},
								{field:'fileContent'         ,title:'文件内容'  ,width:200},
								{field:'filePath'            ,title:'文件路径' ,width:100},
								{field:'fileStatus'          ,title:'文件状态 '     ,width:80},
								{field:'logtime'             ,title:'时间戳'  ,width:120},
								{field:'ckdm1'               ,title:'备注' ,width:120}
							]]							
				}
			);			
		}
	);

</script>

<body>
	<div id="Formfilesrecord">
		<form id="FormFilesForm" action="../../rest/ROrderFormFileService/queryOrderFormFile" method="POST">
		<input type="hidden" id="pageSize"    name="pageSize"    value="20">
		<input type="hidden" id="currentPage" name="currentPage" value="1">
		<input type="hidden" id="elsAccount"  name="elsAccount">
		
			<table>
				<tr>
					<td>&nbsp;
					对方ELS号：<input  class="easyui-textbox" type="text" id="toelsaccount" name="toelsaccount" />
					</td>
					<td>
					
					<td>&nbsp;
					订单号：<input  class="easyui-textbox" type="text" id="purchaseordernumber" name="purchaseordernumber" />
					</td>
					<td>
					
					<td>&nbsp;
					上载日期：<input  class="easyui-textbox" type="date" id="logtime" name="logtime" />
					</td>
					<td>
					到<input  class="easyui-textbox" type="date" id="logtime1" name="logtime1" />
					</td>
					<td>
				    </tr>

				    <tr>
					<td>&nbsp;
					备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：<input  class="easyui-textbox" type="text" id="ckdm1" name="ckdm1" />
					</td>
					<td>

					<td>&nbsp;
					文件名：<input  class="easyui-textbox" type="text" id="filename" name="filename" />
					</td>
					<td>	
					
					<td>&nbsp;
					<a id="btnQuery" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="QueryData()">查询</a>    
					</td>
				</tr>
			</table>		
		</form>
	</div>

	<p>

	<table id="FormfileList" title="" class="easyui-datagrid" style="width:1280px;height:auto">
	</table>
</body>

</html>
