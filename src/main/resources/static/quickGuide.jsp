<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <script>
	    $(document).ready(function() {
		    var pdfSrc = (getIframeData()||{}).pdfSrc||'<%=basePath%>quickGuide/quick_guide_cn.pdf';
		    document.body.innerHTML = ''
				    + '<object id="object" style="width:100%; height:100% "  data="' + pdfSrc + '" type="application/pdf">'
				    + '<span>该浏览器不支持PDF在线预览或者没有安装Adobe Reader</span>'
				    + '<span>您可以直接下载此PDF文件<a href="' + pdfSrc + '">企企通SRM简易操作手册</a></span>'
				    + '<span>或者安装Adobe Reader软件后再预览<a href="http://get.adobe.com/reader/">安装 Adobe Reader 软件</a></span>'
				    + '<embed  id ="embed" type="application/pdf" src="' + pdfSrc + '"/>'
				    + '</object>';
	    });
    </script>
</body>