<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../sessionCheck.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>ELS互联网企业解决方案</title>
<link rel="icon" href="images/logo.ico">
<link rel="shortcut icon" href="images/logo.ico"/>
<link rel="stylesheet" type="text/css" href="../../alert/jquery.alerts.css">
<link rel="stylesheet" type="text/css" href="../../easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../../easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../../easyui/demo.css">
<script src="../../js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="../../js/jquery.serializejson.js" type="text/javascript"></script>
<script src="../../js/json2.js" type="text/javascript"></script>
<script src="../../js/common.js" type="text/javascript"></script>
<script src="../../js/popwin.js" type="text/javascript"></script>
<script src="../../alert/jquery.alerts.js" type="text/javascript"></script>
<script src="../../js/jquery-msgbox.js" type="text/javascript"></script>
<script type="text/javascript">

var telsid   = GetQueryString("elsid");
var telsdfid = GetQueryString("elsdfid");
var tvender  = GetQueryString("vender");

$(function() 
	{	
		//$("#language").val(tlanguage);
		//$("#key").val(tkey);
		//$("#value").val(tvalue);
		
		 $.ajax
		 (
		 	{
				url :"../../rest/SupplierService/getSupplierVender/"+telsid+"/"+telsdfid+"/"+tvender,
				type :"GET",
				contentType : "application/json",
				dataType : "json",
				success : function(data) 
				{	
					$("#elsid").val(data.elsid);
					$("#elsdfid").val(data.elsdfid);
					$("#vender").val(data.vender);				
				},
				error : function(data) 
				{	
					showMsg("请求出错");	
				}
			}
		 );
	}
);

function editSupplier()
{
	var elsdfid   = $("#elsdfid").val()  ;
	var vender = $("#vender").val();
	
	if(elsdfid == null || elsdfid.length == 0)
	{
		showMsg("请输入销售方ELS");
		return;
	}
	
	if(vender ==null || vender.length==0)
	{
		showMsg("请输入供应商编码");
		return;
	}
	
	var frm = $("#editSupplierForm");
	 
	$.ajax
	(
		{
			url :"../../rest/SupplierService/updateSupplier",
			type :"POST",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) 
			{			
				showMsg("修改成功");
				setTimeout
				(
					function()
					{				     
						closeWin();
					}
					, "1000"
				); 	
			},
			
			error : function(data) 
			{
				showMsg("请求出错");
			}
		}
	);
	
}	
	
function closeWin()
{
	$("#mask,#maskTop", window.parent.document).fadeOut
	(
		function() 
		{
			$(this).remove();
			window.parent.QueryData();//刷新父窗口数据   
		}
	);
}

</script>
	
	
<body>
<form id="editSupplierForm" action="" method="post">
	<input type="hidden" id="elsid" name="elsid" >
	<br>
	<div class="">销售方ELS：  
		<input  class="easyui-textbox" type="text" id="elsdfid" name="elsdfid" />
	</div>

	<br>
	<div class="">供应商编码：
		<input  class="easyui-textbox" type="text" id="vender" name="vender" />
	</div>
<br>
	<div style="text-align: center; padding: 5px">
	<input type="button" onclick="editSupplier();"  value="确定"/>
	<input type="button" onclick="closeWin();" value="关闭 "/>				
	</div>

</form>
</body>
</html>