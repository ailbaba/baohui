<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/extend/colorpicker/evol.colorpicker.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/skin.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/extend/colorpicker/evol.colorpicker.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/app_tools/skins/skin.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script>
	var basePath = "<%=basePath %>";
	var path = '<%=path%>';
	var fileSystemPath = '<%=fileSystemPath%>'.substr(1)+'/';
</script>
<body>
<div class="bgArea"><span class="prev"><i18n:I18n key="i18n_skin_preview" defaultValue="预览"/></span>
	<div class="prevBgBox"></div>
	<div class="bg-box">
		<div class="bgList">
			<div class="bgSlide"></div>
		</div>
		<div class="controlArrow left"></div>
		<div class="controlArrow right"></div>
	</div>
</div>
<div class="barArea">
	<div class="bar-box">
		<div class="barC">
			<label><i18n:I18n key="i18n_skin_win_color" defaultValue="窗口栏颜色"/>
				<span id="cValue"></span>
			</label>
			<input id="barColor" type="text" readonly/>
		</div>
		<div class="barC">
			<label><i18n:I18n key="i18n_skin_window_transparency" defaultValue="窗口栏透明度"/>
				<span id="oValue"></span>
			</label>
			<input id="barOpacity" type="range" step="0.001" min="0.1" max="1" value="1"/></div>
		<div class="clear"></div>
	</div>
</div>
<div class="uploadImageBtn"><i18n:I18n key="i18n_skin_upload_a_picture" defaultValue="上传本地图片"/></div>
<div class="btnCancel"><i18n:I18n key="i18n_js_cancel" defaultValue="取消"/></div>
<div class="btnOk"><i18n:I18n key="i18n_skin_apply" defaultValue="应用"/></div>
<div class="clear"></div>
</body>
</html>