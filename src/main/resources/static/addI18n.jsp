<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
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
<script src="../js/jquery.serializejson.js" type="text/javascript"></script>
<script src="../js/json2.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/popwin.js" type="text/javascript"></script>
<script src="../alert/jquery.alerts.js" type="text/javascript"></script>
<script src="../js/jquery-msgbox.js" type="text/javascript"></script>
<script type="text/javascript">


 var dateTimeString ='2015-12-02 11:25:33';
//document.write(dateTimeString.getTimezoneOffset());

var dateTimeObject = new Date(dateTimeString);
//得到本地(系统)时区
var timezoneOffset = new Date().getTimezoneOffset()/60*-1;
timezoneOffset=parseInt(timezoneOffset);
alert(timezoneOffset);

 if(timezoneOffset>=0)
	timezoneOffset="+"+timezoneOffset;


	
document.write('本计算机时区: UTC'+timezoneOffset+':00<br/>');
//得到时间
document.write('原时间字符串: '+dateTimeString+'<br/>');
document.write('转换为本地时间: '+dateTimeObject.toLocaleString()); 




var iscount = 0 ;

function addI18n()
{
	var resourceKey   = $("#resourceKey").val()  ;
	var resourceValue = $("#resourceValue").val();
	
	if(resourceKey===null || resourceKey.length==0)
	{
		showMsg("请输入资源 Key");
		return;
	}
	
	if(resourceValue===null || resourceValue.length==0)
	{
		showMsg("请输入资源Value");
		return;
	}
	
	var frm = $("#subI18nForm");
	
	if (iscount == 0 )
	
	$.ajax
	(
		{
			url :"../rest/I18nService/saveResource",
			type :"POST",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) 
			{			
				showMsg("新增成功");
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
<form id="subI18nForm" action="" method="post">

	<div class="">语言选择：
	<select class="" id="language" name="language">
		<option value="cn">中文</option>
		<option value="en">英文</option>
	</select>
	</div>

	<br>
	<div class="">资源 Key：  
		<input  class="easyui-textbox" type="text" id="resourceKey" name="resourceKey" />
	</div>

	<br>
	<div class="">资源Value：
		<input  class="easyui-textbox" type="text" id="resourceValue" name="resourceValue" />
	</div>

	<div style="text-align: center; padding: 5px">
	<input type="button" onclick="addI18n();"  value="确定"/>
	<input type="button" onclick="closeWin();" value="关闭 "/>				
	</div>
</form>
<%
 java.util.Date timeZone=new java.util.Date();
out.println(timeZone.getTimezoneOffset());
out.print(java.util.TimeZone.getDefault().getDisplayName()); 
%>
</body>
</html>