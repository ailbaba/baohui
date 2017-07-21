<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="base" uri="/WEB-INF/tld/web-base.tld"%>
<%@taglib prefix="i18n" uri="/WEB-INF/tld/i18n.tld"%>
<%@page import="com.els.common.SysProperties"%>
<%@page import="java.util.Properties"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>找不到网页404</title>
<style>
	body{
		font-family: Microsoft YaHei, "黑体", "宋体", "幼圆", Helvetica Neue, Helvetica, Arial, sans-serif
	}
	p {
        font-size: 20px;
	    font-weight: 500;
	    letter-spacing: 1px;
	    margin-top: 10px;
	    margin-bottom: 4px;
	}
	.text-index { text-indent: 42px; }
	.font-weight { font-weight: bolder; }
	.page404-wrap {
		position: relative;
		width: 810px;
		height: 530px;
		margin: 0 auto;
	    margin-top: 80px;
	}
	.page404-img {
	    position: absolute;
	    display: inline-block;
	    width: 260px;
	    height: 254px;
	    left: 0;
	}
	.page404-content {
	    padding-left: 282px;
        padding-top: 30px;
	}
</style>
</head>
<body>
	<div class="page404-wrap">
		<img class="page404-img" alt="" src="<%=path %>/images/404.png">
		<div class="page404-content">
			<p class="font-weight">尊敬的用户：</p>
			<p class="text-index">您好！</p>
			<p class="text-index">当前页面正在建设中，页面将在近期发布更新，感谢</p>
			<p>您的光临与关注！</p>
		</div>
	</div>
</body>
</html>