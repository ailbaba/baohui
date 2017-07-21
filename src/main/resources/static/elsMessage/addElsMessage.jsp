<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 100px;
		padding-left: 30px;
		padding-top: 3px ;
		text-align: right;
	}
</style>
<form id="subAccountForm" action="" method="post">  
 <input  type="hidden" id="elsAccount" name="elsAccount" /> 
		<div class="input-and-tip text-left ">
			     <span class="edit-sub-title"> <i18n:I18n defaultValue="业务区分：" key="i18n_elsMessage_list_businessToDistinguish"/></span>
			       <select class="" id="businessType" name="businessType">
	                     <option value="0"><i18n:I18n defaultValue="密码管理" key="i18n_label_passWordManage"/></option>
						 <option value="1"><i18n:I18n defaultValue="好友管理" key="i18n_label_friendmanager"/></option>
						 <option value="2"><i18n:I18n defaultValue="询价单" key="i18n_businessType_bargainEnquiry"/></option>
						 <option value="3"><i18n:I18n defaultValue="报价单" key="i18n_businessType_saleEnquiry"/></option>
						 <option value="4"><i18n:I18n defaultValue="采购订单" key="i18n_title_purchaseorder"/></option>
						 <option value="5"><i18n:I18n defaultValue="销售订单" key="i18n_title_saleOrder"/></option>
						 <option value="6"><i18n:I18n defaultValue="送货单" key="i18n_elsMessage_lable_deliveryNote"/></option>
						 <option value="7"><i18n:I18n defaultValue="入库单" key="i18n_elsMessage_lable_godownEntry"/></option>
						 <option value="8"><i18n:I18n defaultValue="对账单" key="i18n_elsMessage_lable_statementOfAccount"/></option>
						 <option value="9"><i18n:I18n defaultValue="准入评估单" key="test"/></option>
	              </select>	
		 </div>
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="Els消息" key="i18n_elsMessage_lable_elsAPP"></i18n:I18n>：</span>
			<input  class="" type="checkbox" id="elsMessage" name="elsMessage" checked="checked" disabled/>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="企企通APP" key="i18n_elsMessage_lable_qqtAPP"></i18n:I18n>：</span>
			<input  class="" type="checkbox" id="qqtApp" name="qqtApp" checked="checked" disabled/>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="短信" key="i18n_elsMessage_lable_sms"></i18n:I18n>：</span>
			<input  class="" type="checkbox" id="sms" name="sms"  />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="微信" key="i18n_elsMessage_lable_weChat"></i18n:I18n>：</span>
			<input  class="" type="checkbox" id="weChat" name="weChat" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="邮件" key="i18n_enterprise_email"></i18n:I18n>：</span>
			<input  class="" type="checkbox" id="email" name="email" />
		</div>
</form>	
		<div style="text-align: center; padding: 5px">
            <button id="addfildOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>
<script type="text/javascript">
var elsAccount='<%=session.getAttribute("elsAccount") %>';
$(function() {
	$("#elsAccount").val(elsAccount);
	
}); 
	$("#addfildOK").click(function(){
		$("#elsAccount").val(elsAccount);
		var businessType=$("#businessType").val();
		 if(businessType===null || businessType.length==0){
			 alert('<i18n:I18n key="i18n_elsMessage_Message_selectConfiguratioType" defaultValue="请选择配置类型" />',2);
			 $("#businessType").focus();
			 return;
		 }
		 var weChat="N";
		 var sms ="N";
		 var email="N";
		 if( $("#sms").is(':checked')){
			 sms='Y';
		 }
		 if($("#weChat").is(':checked')){
			 weChat='Y';
		 }
		 if($("#email").is(':checked')){
			 email='Y';
		 }
		 var da={"qqtApp":"Y","elsMessage":"Y","sms":sms,"weChat":weChat,"email":email,"elsAccount":elsAccount,"businessType":businessType};
			 $.ajax({
					url :'../rest/ElsMessageService/saveElsMessage',
					type :"POST",
					contentType : "application/json",
					data :JSON.stringify(da),
					dataType : "json",
					success : function(data) {
					if(data.statusCode == "-100"){
							alert(data.message,3);
					}else{
						alert('<i18n:I18n key="i18n_account_alert_addfepei" defaultValue="新增成功"/>',1);
						setTimeout(function(){				     
							closeWin();},"1000"); 
					   }
					},
					error : function(data) {
						alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					}
			});
	});
	$("#closeWin").click(function(){
		closeWin();
	});
	
	function closeWin(){
		parent.frames['iframeApp_elsMessage'].queryAccountInfo();
        parent.elsDeskTop.closeCurWin('addElsMessage');
	}
    
</script>
</body>
</html>