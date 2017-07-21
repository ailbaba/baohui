<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../sessionCheck.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>ELS物料关系管理</title>
<link rel="icon" href="images/logo.ico">
<link rel="shortcut icon" href="images/logo.ico"/>
<link rel="stylesheet" type="text/css" href="../alert/jquery.alerts.css">
<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../easyui/demo.css">
<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="../js/jquery.serializejson.js" type="text/javascript"></script>
<script src="../js/json2.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/popwin.js" type="text/javascript"></script>
<script src="../alert/jquery.alerts.js" type="text/javascript"></script>
<script src="../js/jquery-msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
	var elsAccount="<%=session.getAttribute("elsAccount") %>";

	$(function() {
		$("#elsAccount").val(elsAccount);
	});
	
	function materialRelationAdd(){
		var saleElsAccount = $("#saleElsAccount").val();
		var saleMaterial = $("#saleMaterial").val();
		var purchaseElsAccount = $("#purchaseElsAccount").val();
		var purchaseMaterial = $("#purchaseMaterial").val();
		
		if(saleElsAccount == null || saleElsAccount.length == 0){
			showMsg("请输入销售ELS账号!");
			return;
		}
		if(saleMaterial == null || saleMaterial.length == 0){
			showMsg("请输入销售物料号!");
			return;
		}
		if(purchaseElsAccount == null || purchaseElsAccount.length == 0){
			showMsg("请输入采购ELS账号!");
			return;
		}
		if(purchaseMaterial == null || purchaseMaterial.length == 0){
			showMsg("请输入采购物料号!");
			return;
		}
		 
		var frm = $("#materialRelationForm");
		
		$.ajax({
			url :"../rest/MaterialRelationService/materialRelationAdd/"+elsAccount,
			type :"POST",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				showMsg("新增物料关系成功!");
				setTimeout(function(){				     
					closeWin();
				 }, "3000"); 
			},
			error : function(data) {
				showMsg("新增失败!");
			}
		});
	}
	
	function closeWin(){
		$("#mask,#maskTop", window.parent.document).fadeOut(function() {
             $(this).remove();
             window.parent.QueryData();//刷新父窗口数据   
         });
	}
</script>
	
	
<body>


<form id="materialRelationForm" action="" method="post">
		<table>
			<tr>
				<td>销售ELS账号：</td>
				<td><input class="easyui-textbox" type="text" id="saleElsAccount" name="saleElsAccount" /></td>
			</tr>
			<tr>
				<td>采购ELS账号：</td>
				<td><input class="easyui-textbox" type="text" id="purchaseElsAccount" name="purchaseElsAccount" /></td>
			</tr>
			<tr>
				<td>销售物料号：</td>
				<td><input class="easyui-textbox" type="text" id="saleMaterial" name="saleMaterial" /></td>
			</tr>
			<tr>
				<td>销售物料描述：</td>
				<td><input class="easyui-textbox" type="text" id="saleMaterialDesc" name="saleMaterialDesc" /></td>
			</tr>
			<tr>
				<td>采购物料号：</td>
				<td><input class="easyui-textbox" type="text" id="purchaseMaterial" name="purchaseMaterial" /></td>
			</tr>
			<tr>
				<td>采购物料描述：</td>
				<td><input class="easyui-textbox" type="text" id="purchaseMaterialDesc" name="purchaseMaterialDesc" /></td>
			</tr>
			
		</table>
		<div style="text-align: center; padding: 5px">
			<input type="button" onclick="materialRelationAdd();"  value="确定"/>
			<input type="button" onclick="closeWin();" value="关闭 "/>				
		</div>
</form>

</body>
</html>