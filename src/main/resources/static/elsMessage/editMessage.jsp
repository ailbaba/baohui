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

<form id="editMessage" action="" method="post">  
 <input  type="hidden" id="elsAccount" name="elsAccount" /> 
 <input  type="hidden" id="id" name="id" /> 
		<div class="input-and-tip text-left ">
			         <span class="edit-sub-title"><i18n:I18n defaultValue="业务区分：" key="i18n_elsMessage_list_businessToDistinguish"/></span>
			         <select class="" id="businessType" name="businessType">
			                     <option value="0"><i18n:I18n defaultValue="账号密码管理" key="i18n_label_passWordManage"/></option>
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
			<input  class="" type="checkbox" id="elsMessage" name="elsMessage" checked="checked" disabled="disabled"/>
		</div>
		  
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="企企通APP" key="i18n_elsMessage_lable_qqtAPP"></i18n:I18n>：</span>
			<input  class="" type="checkbox" id="qqtApp" name="qqtApp" checked="checked" disabled="disabled"/>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="短信" key="i18n_elsMessage_lable_sms"></i18n:I18n>：</span>
			<input  class="" type="checkbox" id="sms" name="sms"/>
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
            <button id="editfildOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>   
<script type="text/javascript">
var businessType ="<%=request.getParameter("businessType") %>";
var elsMessage ="<%=request.getParameter("elsMessage") %>";
var qqtApp ="<%=request.getParameter("qqtApp") %>";
var sms ="<%=request.getParameter("sms") %>";
var weChat ="<%=request.getParameter("weChat") %>";
var email ="<%=request.getParameter("email") %>";
var id ="<%=request.getParameter("id") %>";
var elsAccount="<%=request.getParameter("elsAccount") %>";

$(document).ready(function(){
	  init(); 
	  	$("#editfildOK").click(function(){
	  		/*  var frm = $("#editMessage");  */
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
			
			var da={"qqtApp":"Y","elsMessage":"Y","sms":sms,"weChat":weChat,"email":email,"elsAccount":elsAccount,"businessType":businessType,"id":id}; 
			var  myselect=document.getElementById("businessType");
			var index=myselect.selectedIndex ;
			if( myselect.options[index].value!=businessType){
				alert("<i18n:I18n key="i18n_common_alert_TheBusinessRange" defaultValue="业务区间已经存在，请重新选择" />",2);
				return;
			}
			$.ajax({
	  				url :"<%=basePath%>rest/ElsMessageService/UpdateElsMessage",
	  				type :"POST",
	  				contentType : "application/json",
	  				data : JSON.stringify(da),
	  				dataType : "json",
	  				success : function(data){
	  					if(data.statusCode == "-100"){
	  						alert(data.message,3);
	  					}else{
	  						alert('<i18n:I18n key="i18n_delivery_updatesuccess" defaultValue="修改成功" />',1);
	  						setTimeout(function(){				     
	  							closeWin();
	  						 }, "1000"); 
	  					}					
	  				},
	  				error : function(data) {
	  					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
	  				}
	  		});		 
	  	});
	  	
 });
$("#closeWin").click(function(){
	closeWin();
});

function closeWin(){
	parent.frames['iframeApp_elsMessage'].queryAccountInfo();
    parent.elsDeskTop.closeCurWin('editMessage');
}

function init(){
	if(elsAccount=="100000"){
		$("#businessType").attr("disabled", true);
		$("#elsMessage").attr("disabled", true);
		$("#qqtApp").attr("disabled", true);
		$("#sms").attr("disabled", true);
		$("#weChat").attr("disabled", true);
		$("#email").attr("disabled", true);
		$("#id").attr("disabled", true);
	    $("#elsAccount").attr("disabled", true);
	    var div = document.getElementById('editfildOK');
	    div.style.display = 'none';
	    return;
	}
				$("#businessType").val(businessType);
				$("#elsMessage").val(elsMessage);
				$("#qqtApp").val(qqtApp);
				$("#sms").val(sms);
				$("#weChat").val(weChat);
				$("#email").val(email); 
				$("#id").val(id);
			    $("#elsAccount").val(elsAccount);
		     	if(email=='Y'){
					$("#email").attr("checked", true);
				}if(weChat=='Y'){
					$("#weChat").attr("checked", true);
				}if(sms=='Y'){
					$("#sms").attr("checked", true);
				}
}
</script>
</body>
</html>