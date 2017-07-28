<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.Properties"%>

<%-- <%@ include file="sessionCheck.jsp"%> --%>
<%
	response.addHeader("Access-Control-Allow-Origin", "https://www.51qqt.com");
   	response.addHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
   	response.addHeader("Access-Control-Allow-Headers", "Origin, No-Cache, X-Requested-With, If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type, X-E4M-With");
   	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
	//正式环境
	//String basePath="https://www.51qqt.com"+path + "/";
	String fileSystemPath = "D:/FileSystem";//文件系统根路径
	fileSystemPath = fileSystemPath.substring(fileSystemPath.indexOf("/"));
	request.setAttribute("fileSystemPath", fileSystemPath);
	request.setAttribute("path", path);
	String version = "0.2.5";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link
	href="<%=basePath%>extend/jquery-ui/themes/base/jquery.ui.all.css?version=<%=version%>"
	rel="stylesheet" />
<%-- <link href="<%=basePath%>extend/public.css" rel="stylesheet" /> --%>
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/css/normalize.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/src/mmGrid.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/src/mmPaginator.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/bootstrap/css/bootstrap.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/src/theme/bootstrap/mmGrid-bootstrap.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/src/theme/bootstrap/mmPaginator-bootstrap.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/public.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/multiselect/sumoselect.css?version=<%=version%>">
<script type="text/javascript"
	src="<%=basePath%>lib/js/jquery/jquery-1.8.2.min.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>lib/js/jquery/jquery.nicescroll.min.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.core.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.widget.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.button.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.tabs.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.position.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.tooltip.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.mouse.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.draggable.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.droppable.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/multiselect/jquery.sumoselect.min.js?version=<%=version%>"></script>
<!-- <script type="text/javascript" -->
<script language="javascript" type="text/javascript" src="<%=basePath%>extend/wdatepicker/WdatePicker.js?version=<%=version%>"></script>
<!--[if lt IE 9]>
    <script src="<%=basePath%>extend/mmGrid/js/vendor/html5shiv.js?version=<%=version%>"></script>
    <script src="<%=basePath%>extend/mmGrid/js/vendor/css3-mediaqueries.js?version=<%=version%>"></script>
    <![endif]-->
<script src="<%=basePath%>extend/mmGrid/js/vendor/modernizr-2.6.2.min.js?version=<%=version%>"></script>
<script src="<%=basePath%>extend/mmGrid/js/plugins.js?version=<%=version%>"></script>
<script src="<%=basePath%>extend/mmGrid/js/vendor/json2.js?version=<%=version%>"></script>
<script src="<%=basePath%>extend/mmGrid/src/mmGrid.js?version=<%=version%>"></script>
<script src="<%=basePath%>extend/mmGrid/src/mmPaginator.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>js/jquery.serializejson.js?version=<%=version%>"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js?version=<%=version%>"></script>
<script type="text/javascript" src="<%=basePath%>js/tableColumn.js?version=<%=version%>"></script>
<script type="text/javascript">

<!-- 登录时获得变量的值  -->
elsBasePath = "<%=basePath%>";
currentElsAccount='<%=session.getAttribute("elsAccount")%>';
elsAccount='<%=session.getAttribute("elsAccount")%>';
elsSubAccount='<%=session.getAttribute("elsSubAccount")%>';
username='<%=session.getAttribute("username")%>';
role='<%=session.getAttribute("role")%>';
companyShortName='<%=session.getAttribute("companyShortName")%>';
language='<%=session.getAttribute("language") %>';	
var winId = "<%=request.getParameter("winId")%>";
if (winId == "null") {
	winId = null;
}

//超级管理员
superAdmin='100000';

var _alert = window.alert;
window.alert = function(msg,type) {
	if(!parent.elsDeskTop||!parent.elsDeskTop.tip){
		return _alert(msg+(type||''));
	}
	var displayType = 1;
	if (type) {
		displayType = type;
	}
	parent.elsDeskTop.tip.init({type: 'alert',displayType: displayType, message:msg});
};
//获取聊天窗口的参数
window.queryChats = function(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]); return null;
};
 $(function(){
	//按钮提示
	$('button').not('.none-title').each(function(i,b){
			var txt = $(b).text();
			if(txt && txt.length) {
				b.title=b.title||$(b).text();
				$(b).text(textClip(txt,9));
			}
		});
	if($('button') && $('button').height()) {
		$('button').button();
	}
	//dilog-tip 拖曳
	$('.dialog-tip').each(function(index,html){
		var parent = $(html).parent();
		$(html).draggable({ containment: parent, scroll: false,cursor: "move" }).bind("drag",function(event,ui){
			//console.log($(this));
			//$(this).find("div.iframeFix").show();
		})
		.bind("dragstop", function(event, ui) {
			if(window.leftScroll) {
				window.leftScroll.resize();
			}
			if(window.rightScroll) {
				window.rightScroll.resize();
			}

		});
	});
	
	//处理页面自定义弹窗皮肤
	if(parent.elsDeskTop.loginStore && parent.elsDeskTop.loginStore.shemeType) {
		var subShemeType = parent.elsDeskTop.loginStore.shemeType; 
		$('.dialog-tip .tip-head').css({'background-color':'rgba('+subShemeType.r+','+subShemeType.g+','+subShemeType.b+','+subShemeType.a+')'});
	}
});
 function permissionError(data) {
	 if (data && data.responseText) {
		 var regex = /<ns1\:faultstring\s+xmlns\:ns1="http:\/\/cxf.apache.org\/bindings\/xformat">java.lang.IllegalArgumentException\:([^]+)<\/ns1\:faultstring>/;
		 var group =  regex.exec(data.responseText);
	     if (group && group[1]) {
	    	 alert(group[1],3);
	    	 return true;
	     }
	 }
     return false;
 }
 
//将编码转换成字符  
 function utf8ToChar(str) {  
	var returnStr="";
	for(var i=0;i<str.length;){
	     var iCode, iCode1, iCode2;  
	     iCode = parseInt("0x" + str.substr(i+1, i+2));  
	     iCode1 = parseInt("0x" + str.substr(i+4, i+2));  
	     iCode2 = parseInt("0x" + str.substr(i+7, i+2));  
	     returnStr+=String.fromCharCode(((iCode & 0x0F) << 12) | ((iCode1 & 0x3F) << 6) | (iCode2 & 0x3F)); 
	     i=i+9;
	     tag=true;
	     while (i<str.length&&tag==true)
	     {
	    	 console.log(str.substr(i,1));
	    	 if(str.substr(i,1)=="%"){
	    		 tag=false;
	    	 }else{
	    		 returnStr+=str.substr(i,1);
	    		 i++;
	    	 }
	     }
	}
	return returnStr;
     
 }  
</script>

</head>