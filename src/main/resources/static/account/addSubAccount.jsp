<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 130px;
		padding-left: 20px;
		padding-top: 3px ;
		text-align: right;
	}
</style>

<form id="subAccountForm" action="" method="post">
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</span>
			<input readonly class="" type="text" id="elsAccount" name="elsAccount" />
		</div>

		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_isadmin" defaultValue="是否管理员" />：</span>
			<select class="" id="isAdmin" name="isAdmin">
				<option value="N"><i18n:I18n key="i18n_common_no" defaultValue="否" /></option>
				<option value="Y"><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
			</select>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="" defaultValue="工作性质" />：</span>
			<select class="" id="station" name="station">
							<option value="purchase"><i18n:I18n key="i18n_account_select_stationtype_purchase" defaultValue="采购岗位" /></option>
							<option value="sale"><i18n:I18n key="i18n_account_select_stationtype_sell" defaultValue="销售岗位" /></option>
			</select>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_common_title_username" defaultValue="姓名" />：</span>
			<input  class="" type="text" id="name" name="name" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_label_password" defaultValue="密码" /></span>
			<input  class="" type="password" id="elsSubAccountPassword" name="elsSubAccountPassword" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_email" defaultValue="邮箱" />：</span>
			<input  class="" type="text" id="email" name="email" />
			<span style="color: red" id="email_span"></span>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_phonenumber" defaultValue="手机" />：</span>
			<input  class="" type="text" id="telphone1" name="telphone1" />
			<span style="color: red" id="telphone1_span"></span>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_telephone" defaultValue="电话" />：</span>
			<input  class="" type="text" id="telphone2" name="telphone2" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_nickname" defaultValue="昵称" />：</span>
			<input  class="" type="text" id="nickname" name="nickname" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_employeenumber" defaultValue="工号" />：</span>
			<input  class="" type="text" id="employeeNumber" name="employeeNumber" />
			<span style="color: red" id="employeeNumber_span"></span>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_wxaccount" defaultValue="微信账号" />：</span>
			<input  class="" type="text" id="wxAccount" name="wxAccount" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_qqaccount" defaultValue="QQ账号" />：</span>
			<input  class="" type="text" id="qqAccount" name="qqAccount" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_faxnumber" defaultValue="传真" />：</span>
			<input  class="" type="text" id="fax" name="fax" />
		</div>
</form>	
		<!-- <div style="text-align: center; padding: 5px">
		<input type="button" onclick="addSubAccount();" value="确定"/>
		<input type="button" onclick="closeWin();" value="关闭 "/>
		</div> -->
		<div style="text-align: center; padding: 5px">
            <button id="addSubAccountOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>

<script type="text/javascript">
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	$(function() {
		$("#elsAccount").val(elsAccount);
	});
	$("#addSubAccountOK").click(function(){
		var name=$("#name").val();
		var email=$("#email").val();
		var telphone1 = $("#telphone1").val();
		 if(name===null || name.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_nameRequired" defaultValue="请输入姓名" />',2);
			 $("#name").focus();
			 return;
		 }
		 if(email===null || email.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_emailRequired" defaultValue="请输入邮箱" />',2);
			 $("#email").focus();
			 return;
		 }else if(!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)){
			 alert('<i18n:I18n key="" defaultValue="电子邮箱格式不正确！" />',2);
			 $("#email").focus();
			 return;
		 }
		 if(telphone1===null || telphone1.length==0){
			 alert('<i18n:I18n key="" defaultValue="请输入手机号码!" />',2);
			 $("#telphone1").focus();
			 return;
		 }else if(!/^[0-9]*$/.test(telphone1)){
			 alert('<i18n:I18n key="" defaultValue="手机号码格式不正确!" />',2);
			 $("#telphone1").focus();
			 return;
		 }
		 var frm = $("#subAccountForm");
		 $.ajax({
				url :"../rest/AccountService/createSubaccount",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					if(data.statusCode==200){
					alert('<i18n:I18n key="i18n_account_alert_addSuccess" defaultValue="新增成功,子账号为:" />'+data.elsSubAccount,1);
					setTimeout(function(){				     
						closeWin();
					 }, "3000"); 
					}else{
						alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />'+data.message,3);
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
		parent.frames['iframeApp_accountManage'].queryAccountInfo();
        parent.elsDeskTop.closeCurWin('addSubAccount');
	}
	
    $('#email').live('keyup',function() {
       var email = $('#email').val();
       if(email != null && email != ""){
    	   data = {"elsAccount":elsAccount,"email":email};
    	   checkExist(data,"email",'<i18n:I18n key="i18n_account_title_email" defaultValue="邮箱" />');
       }
    });
    
    $('#telphone1').live('keyup',function() {
        var telphone1 = $('#telphone1').val();
        if(telphone1 != null && telphone1 != ""){
     	   data = {"elsAccount":elsAccount,"telphone1":telphone1};
     	   checkExist(data,"telphone1",'<i18n:I18n key="i18n_account_title_phonenumber" defaultValue="手机号" />');
        }
     });
    
    $('#employeeNumber').live('keyup',function() {
        var employeeNumber = $('#employeeNumber').val();
        if(employeeNumber != null && employeeNumber != ""){
     	   data = {"elsAccount":elsAccount,"employeeNumber":employeeNumber};
     	   checkExist(data,"employeeNumber",'<i18n:I18n key="i18n_account_title_employeenumber" defaultValue="工号" />');
        }
     });
    
    function checkExist(data,name,fieldName){
    	 $.ajax({
    			url :"<%=basePath%>rest/AccountService/checkInfoIsExist",
    			type :"POST",
    			contentType : "application/json",
    			dataType : "json",
    			data:JSON.stringify(data),
    			success : function(data) {
    				if(data == "1"){
    					$('#'+name+"_span").html(fieldName+'<i18n:I18n key="i18n_account_alert_isExisting" defaultValue="已存在，请重新输入" />');
      					$('#'+name).focus();
      					$('body').data(name,true);
      					$("#addSubAccountOK").attr('disabled',true);
    				}else{
    					operation(name);
    				}
    			},
    			error: function (xhr, type, exception) {//获取ajax的错误信息
                    alert(xhr.responseText, "Failed"); 
                }
    		});
    }
    
    function operation(name){
    	$('#'+name+"_span").html('');
    		$('body').data(name,false);
    		var email = $('body').data('email');
    		var telphone1 = $('body').data('telphone1');
    		var employeeNumber = $('body').data('employeeNumber');
    		if(!email&&!telphone1&&!employeeNumber){
    			$("#addSubAccountOK").attr('disabled',false);
    		}
    }
</script>

</body>
</html>