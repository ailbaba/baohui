<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>

<script>	

	var totalCount = 0;
	var pageSize = 15;
	var currentPage = 1;

	function QueryData() {

		var frm = $("#form");
		
		
		
		$.ajax({
			url : frm[0].action,
			type : frm[0].method,
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				if(data.statusCode=="-100")
					$.messager.alert("提示", "没有符合条件的数据!");
				else
					$("#dgSubList").datagrid('loadData', data);
				
			},
			error : function(data) {
				$.messager.alert("提示", data.responseText);
				
			}
		});

	}
	
	
		

	$(function(){	
		
		
		$.ajax({
			url : "rest/DataDictionaryService/queryTablesBySchem",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var tableName = $("#tableName");
				tableName.empty();
				
				tableName.append($("<option>").text('ALL_表').val(''));
				
				for (var i = 0; i < data.length; i++) {

					var option = $("<option>").text(data[i]).val(data[i])

					tableName.append(option);
				}
				
			},
			error : function(data) {
				
			}
		});
		
		QueryData();   
		
		$('#dgSubList').datagrid({
			
			singleSelect:true,
			pageSize:pageSize,
			pageList:[20,30,50,100],
			method:"post",
			rownumbers:true,//行号 
			selectOnCheck: true,
			checkOnSelect: true,
			
			columns:[[
				{field:'_id',title:'选择',checkbox:true},
				{field:'tableSchem',title:'数据库',width:80},
				{field:'tablename',title:'表名称',width:250},
				{field:'columnName',title:'数据元素',width:250},
				{field:'typeName',title:'元素类型',width:100},
				{field:'columnSize',title:'长度',width:60},
				{field:'nullable',title:'是否可空',width:60},
				{field:'remarks',title:'短文本',width:350},
				{field:'dataType',title:'数据类型',hidden:true,width:100}
				
				
			]]
		});
		
		
		
		
	});
		
		
	
		

	
</script>



<body>

<div>
	<form id="form" action="rest/DataDictionaryService/queryDataDictionary" method="post">
		<input type="hidden" id="pageSize" name="pageSize" value="20">
		<input type="hidden" id="currentPage" name="currentPage" value="1">
		
			<table>
				<tr>
					<td>表名称：
					<!-- <input  class="easyui-textbox" type="text" id="tableName" name="tableName" /> -->
					<select id="tableName" name="tableName">
							<option value="">ALL_表</option>
					</select>
					
					
					&nbsp;字段名称：
					<input  class="easyui-textbox" type="text" id="columnName" name="columnName" />
					&nbsp;短文本[支持模糊匹配]：<input  class="easyui-textbox" type="text" id="remarks" name="remarks" />
					</td>
					<td>
					<td>&nbsp;
					 <a id="btnQuery" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="QueryData()">查询</a>    
					</td>
				</tr>
			</table>
			
		</div>
	</form>

<p>
<table id="dgSubList" title="" class="easyui-datagrid" style="width:1248px;height:600px"></table>
<p>
</body>
</html>
