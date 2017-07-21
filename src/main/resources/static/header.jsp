<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="base" uri="/WEB-INF/tld/web-base.tld" %>
<%@taglib prefix="i18n" uri="/WEB-INF/tld/i18n.tld" %>

<%@ include file="sessionCheck.jsp"%>
<%
	response.addHeader("Access-Control-Allow-Origin", "http://www.51qqt.com");
	response.addHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
	response.addHeader("Access-Control-Allow-Headers", "Origin, No-Cache, X-Requested-With, If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type, X-E4M-With");
	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
	//正式环境
	//String basePath="http://www.51qqt.com"+path + "/";


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>ELS互联网企业解决方案</title>
<link rel="icon" href="<%=basePath %>images/logo.ico">
<link rel="shortcut icon" href="<%=basePath %>images/logo.ico"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>easyui/demo.css">
<script src="<%=basePath %>js/jquery-1.7.2.min.js" type="text/javascript"></script> 
<%-- <script type="text/javascript" src="<%=basePath %>easyui/jquery.min.js"></script> --%>
<script type="text/javascript" src="<%=basePath %>easyui/jquery.easyui.min.js"></script>
<script src="<%=basePath %>js/jquery.serializejson.js" type="text/javascript"></script>
<script src="<%=basePath %>js/common.js" type="text/javascript"></script>
<script src="<%=basePath %>js/jquery.messager.js" type="text/javascript"></script>
<script src="<%=basePath %>js/json2.js" type="text/javascript"></script>
<script src="<%=basePath %>js/popwin.js" type="text/javascript"></script>
<script src="<%=basePath %>js/jquery-msgbox.js" type="text/javascript"></script>

<script type="text/javascript">

<!-- 登录时获得变量的值  -->
currentElsAccount='<%=session.getAttribute("elsAccount") %>';
elsAccount='<%=session.getAttribute("elsAccount") %>';
elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
username='<%=session.getAttribute("username") %>';
role='<%=session.getAttribute("role") %>';
companyShortName='<%=session.getAttribute("companyShortName") %>';
language='<%=session.getAttribute("language") %>';	
</script>
 
</head>