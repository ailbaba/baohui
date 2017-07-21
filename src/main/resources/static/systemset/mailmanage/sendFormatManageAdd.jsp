<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<style>
table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>

<script type="text/javascript" src="<%=basePath %>xheditor/xheditor-1.2.1.min.js"></script>

<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="邮件信息列表" /></span>
			  <div class="common-box-line" id="updateSupplyFormId">
			  <form id="addForm">
			   		<table>
			   		    <tr>
							<td align="right">邮件类型：</td>
							<td>
							   <select id="mailType" name="mailType" style="width:220px;max-width:220px;">
							      <option value="orderChange">订单变更</option>
							      <option value="orderSend">采购订单</option>
							      <option value="enquirySend">询价单</option>
							      <option value="deliveryNote">送货通知单</option>
							      <option value="deliveryNoteDel">送货通知单删除</option>
							   </select></td>
						</tr>
						<tr>
							<td align="right">邮件标题：</td>
							<td><input type="text" id="mailTitle" name="mailTitle" style="width:220px;max-width:220px;"/></td>
						</tr>
						<tr>
							<td align="right">邮件模板内容：</td>
							<td>
							<div style="border-left: solid 1px #ccc; border-right: solid 1px #ccc;">
								<textarea class="xContent" id="mailContent" name="mailContent" rows="12" style="width: 720px;"></textarea></div>
							</td>
						</tr>
						<tr>
							<td align="right">邮件模板描述：</td>
							<td><input type="text" id="mailDesc" name="mailDesc" style="width:220px;max-width:220px;" /></td>
						</tr>
						<tr>
							<td align="right" >备注：</td>
							<td>
								<textarea id="remark" name="remark" style="width:220px;max-width:220px;"></textarea>
							</td>
						</tr>
					</table>
					</form>
			  </div>
		</div>
		
</div>


<script type="text/javascript">
	
	$(document).ready(function() {
		var editor=$('.xContent').xheditor({
			tools:'Emot,Cut,Copy,Paste,Bold,Italic,Underline,Strikethrough,FontColor,Preview,'+
					 'Link,Unlink,BackColor,Fullscreen,Align,SelectAll,Underline',
			skin:'default'
		});
		
		$("#saveBtn").click(function(){
			debugger;
			
			//var sHtml=editor.getSource() 
			var frm = $("#addForm");
			var frmObj = frm.serializeJSON();
			frmObj["elsAccount"] = elsAccount;
		   	
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认保存？" />',closeEvent:function(){
			   	parent.elsDeskTop.showLoading('邮件模板保存中!');
				$.ajax({
					url :"${pageContext.request.contextPath}/rest/MailInfoManageService/addMailSendFormat",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(frmObj),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
		    			if(data.statusCode==-100){
		    				alert(data.message,3);
		    			}else{
		    				alert("<i18n:I18n key='test' defaultValue='保存成功' />",1);
		    				parent.elsDeskTop.closeCurWin('sendFormatManageAdd',callBack);
		    			}
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type: 'alert',message:'保存出错！'});
					}
				});
			}});
			
		  });
		
	});
	
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
	function callBack(){
		if(parent.frames['iframeApp_sendFormatManage']) {
			parent.frames['iframeApp_sendFormatManage'].purchQuery();
		}
	}
	
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('sendFormatManageAdd');
	});
</script>
</body>
</html>