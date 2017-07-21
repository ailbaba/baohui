<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script>

var fbk5 = getIframeData()

$(document).ready(function() {
	$("#span").html(fbk5);
})

</script>
<body>
	<div class="pos-relative public-wrap" align="center">
	<br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<h1>
	<span id="span"></span>
	</h1>
	</div>
</body>
</html>