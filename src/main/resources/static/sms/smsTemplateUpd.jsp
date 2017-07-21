<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="short-message">
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" />
			</span>
			<div class="common-box-line">
				<button id="saveBtn" class="button-wrap"><i18n:I18n defaultValue="保存" key="i18n_button_save" /></button>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本信息</span>
			<div class="common-box-line">
				<div>
					<table>
						<tr>
							<td>短信模板编号：</td>
							<td><input type="text" id="templateNumber" name="templateNumber" readonly="readonly" /></td>
						</tr>
						<tr>
							<td>短信模板名称：</td>
							<td><input type="text" id="templateName" name="templateName" /></td>
						</tr>
						<tr>
							<td>短信模板描述：</td>
							<td><input type="text" id="templateDesc" name="templateDesc" width="200px;" /></td>
						</tr>
						<tr>
							<td>模板内容：</td>
							<td><textarea id="content" name="content" rows="5" cols="300"></textarea></td>
						</tr>
						<tr>
							<td>手机号码：</td>
							<td><input type="text" id="mobilePhones" name="mobilePhones" /></td>
						</tr>
						<tr class="red-tip">
							<td></td>
							<td><font color="red">多个手机号请用逗号(,)分隔</font></td>
						</tr>
						<tr>
							<td>邮箱：</td>
							<td><input type="text" id="emails" name="emails" /></td>
						</tr>
						<tr class="red-tip">
							<td></td>
							<td><font color="red">多个邮箱请用逗号(,)分隔</font></td>
						</tr>
						<tr>
							<td>备注：</td>
							<td><input type="text" id="remark" name="remark" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	
	$(document).ready(function(){
		initData();
	});
	
	function initData() {
	    var templateNumber = "${param.templateNumber}";
	    var queryParam = {templateNumber : templateNumber};
	    
	    $.ajax({
			url : "${pageContext.request.contextPath}/rest/ElsSmsTemplateService/querySmsTemplate",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(queryParam),
			dataType : "json",
			success : function(data, textStatus, jqXHR){
				var rows = data.rows;
				if("undefined" !=  rows && rows.length > 0){
					var head = rows[0];
					$("#templateNumber").val(head.templateNumber);
					$("#templateName").val(head.templateName);
					$("#templateDesc").val(head.templateDesc);
					$("#content").val(head.content);
					$("#mobilePhones").val(head.mobilePhones);
					$("#emails").val(head.emails);
					$("#remark").val(head.remark);
				} else {
					alert("短信模板查询异常!");
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown){
				alert(errorThrown);
			}
		});
	}
	
	$("#saveBtn").click(function(){
		var templateNumber = $("#templateNumber").val();
	   	var templateName = $("#templateName").val();
	   	var templateDesc = $("#templateDesc").val();
	   	var content = $("#content").val();
	   	var mobilePhones = $("#mobilePhones").val();
	   	var emails = $("#emails").val();
	   	var remark = $("#remark").val();
	   	
	   	var smsTemplate = {
	   			templateNumber : templateNumber,
	   			templateName : templateName,
	   			templateDesc : templateDesc,
	   			content : content,
	   			mobilePhones : mobilePhones,
	   			emails : emails,
	   			remark : remark
	   	};
	   	
	   	parent.elsDeskTop.showLoading('短信模板保存中!');
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/ElsSmsTemplateService/updSmsTemplate",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(smsTemplate),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				parent.elsDeskTop.tip.init({type: 'alert',displayType:1,message:'保存成功！'});
				parent.elsDeskTop.closeCurWin('smsTemplateUpd',callBack);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				parent.elsDeskTop.tip.init({type: 'alert',message:'保存出错！'});
			}
		});
	});
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
	function callBack(){
		if(parent.frames['iframeApp_smsTemplateManage']) {
			parent.frames['iframeApp_smsTemplateManage'].init();
		}
	}
</script>
</body>
</html>