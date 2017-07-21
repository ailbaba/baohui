<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../../elsHeader.jsp"%>
<body>
	<style type="text/css">
.edit-sub-title {
	display: inline-block;
	width: 130px;
	padding-left: 20px;
	padding-top: 10px;
	text-align: right;
}
</style>
	<div id="group">
		<form id="iForm" action="" method="post">
			<input type="hidden" id="elsAccount" name="elsAccount"
				value="<%=session.getAttribute("elsAccount")%>"> <input
				type="hidden" id="elsDesc" name="elsDesc"
				value="<%=session.getAttribute("companyShortName")%>">
			<div class="input-and-tip text-left">
				<span class="edit-sub-title"> <i18n:I18n key=""
						defaultValue="类型" />：
				</span> <select class="" id="regulationType" name="regulationType">
					<option value="">请选择</option>
					<option value="0">条例</option>
					<option value="1">条例组</option>
				</select>&nbsp;
			</div>
			<div class="input-and-tip text-left">
				<span class="edit-sub-title"> <i18n:I18n key=""
						defaultValue="类型名称" />：
				</span> <input type="text" id="typeName" name="typeName" />
			</div>
			<div class="input-and-tip text-left">
				<span class="edit-sub-title"> <i18n:I18n key=""
						defaultValue="类型描述" />：
				</span> <input size=30 type="text" id="typeDesc" name="typeDesc" />
			</div>
		</form>

		<div style="text-align: center; padding: 5px">
			<button id="addType" class="button-wrap">
				<i18n:I18n key="i18n_common_button_ok" defaultValue="确定" />
			</button>
			<button onclick="cancel();" class="button-wrap">
				<i18n:I18n key="i18n_common_button_cancel" defaultValue="取消 " />
			</button>
		</div>

	</div>

	<script type="text/javascript">
	//初始化记载信息 
	 $(document).ready(function(){
		 $("#regulationType").val("0");
	 });
	
	 
	var pid = GetQueryString("pid");
	$("#addType").click(function(){
		var typeName = $("#typeName").val();
		if (typeName.length == 0) {
			 alert('<i18n:I18n key="i18n_account_alert_typeNameRequired" defaultValue="请输入类型名称" />',2);
			 $("#typeName").focus();
			 return;
		}
	 	var type = $("#regulationType").val();
		if (type.length == 0) {
			 alert('<i18n:I18n key="" defaultValue="请选择类型" />',2);
			 $("#regulationType").focus();
			 return;
		}
		var frm = $("#iForm");
		var frmData = JSON.stringify(frm.serializeJSON());
		  $.ajax({
			url : '<%=basePath%>rest/RegulationService/insertRegulationType',
										type : "POST",
										contentType : "application/json",
										data : frmData,
										dataType : "json",
										success : function(data) {
											alert(
													'<i18n:I18n key="test" defaultValue="操作成功" />',
													1);
											setTimeout(function() {
												closeWin();
											}, "1000");
										},
										error : function(data) {
											if (data.responseText
													.indexOf('<i18n:I18n key="i18n_account_alert_noPermissionOperation" defaultValue="你没有权限进行此操作" />') > 0) {
												alert(
														'<i18n:I18n key="i18n_account_alert_noPermissionOperation" defaultValue="你没有权限进行此操作" />',
														3);
											} else {
												alert(
														'<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',
														3);
											}
										}
									});
						});

		function cancel() {
			parent.elsDeskTop.closeCurWin('addType');

		}

		function closeWin() {
		
			if (pid == "RegulationAdd") {
				parent.frames['iframeApp_' + pid].initType();
			} else {
				parent.frames['iframeApp_' + pid].headTable.load();
				if (pid == "regulationType") {
					parent.frames['iframeApp_' + pid].queryRegulation();
				}

			}

			parent.elsDeskTop.closeCurWin('addType');

		}
	</script>

</body>
</html>