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
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_agented_subaccount" defaultValue="被代理子帐号" />：</span>
			<input  class="" type="text" id="elsSubAccount" name="elsSubAccount" />
			<span style="color: red" id="agentSubAccount_span"></span>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_agent_subaccount" defaultValue="代理子帐号" />：</span>
			<input  class="" type="text" id="agentSubAccount" name="agentSubAccount" />
			<span style="color: red" id="elsSubAccount_span"></span>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_startdate" defaultValue="开始时间" />：</span>
		    	    <input style="max-width:100%;"   type="text" class="Wdate" onfocus="WdatePicker()" id="startDate" name="startDate" />
		</div>
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_account_title_enddate" defaultValue="结束时间" />：</span>
		    <input style="max-width:100%;"   type="text" class="Wdate" onfocus="WdatePicker()" id="endDate" name="endDate" />
		
		</div>
		
</form>	
		
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
		var agentSubAccount=$("#agentSubAccount").val();
		var elsSubAccount=$("#elsSubAccount").val();
		var startDate=$("#startDate").val();
		var endDate=$("#endDate").val();
		 if(agentSubAccount===null || agentSubAccount.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_agentSubAccountRequired" defaultValue="请输入被代理帐号" />',2);
			 $("#agentSubAccount").focus();
			 return;
		 }
		 if(elsSubAccount===null || elsSubAccount.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_agentedSubAccountRequired" defaultValue="请输入代理帐号" />',2);
			 $("#elsSubAccount").focus();
			 return;
		 }
		 var frm = $("#subAccountForm");
		 	
		 $.ajax({
				url :"../rest/AccountService/agentSubaccount",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="i18n_account_alert_agentSuccess" defaultValue="代理授权成功！" />',1);
					setTimeout(function(){				     
						closeWin();
					 }, "3000"); 
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
        parent.elsDeskTop.closeCurWin('agentSubAccount');
	}
	
    $('#agentSubAccount').live('keyup',function() {
       var agentSubAccount = $('#agentSubAccount').val();
       if(agentSubAccount != null && agentSubAccount != ""){
    	   data = {"elsAccount":elsAccount,"elsSubAccount":agentSubAccount};
    	   checkExist(data,"agentSubAccount",'<i18n:I18n key="i18n_account_alert_agentSubAccountRequired" defaultValue="被代理子帐号" />');
       }
    });
    
    $('#elsSubAccount').live('keyup',function() {
        var elsSubAccount = $('#elsSubAccount').val();
        if(elsSubAccount != null && elsSubAccount != ""){
     	   data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
     	  checkExist(data,"elsSubAccount",'<i18n:I18n key="i18n_account_alert_agentedSubAccountRequired" defaultValue="代理子帐号" />');
        }
     });
    
  
    function checkExist(data,name,fieldName){
    	 $.ajax({
    			url :"<%=basePath%>rest/AccountService/checkSubAccountIsExist",
    			type :"POST",
    			contentType : "application/json",
    			dataType : "json",
    			data:JSON.stringify(data),
    			success : function(data) {
    				if(data == "1"){
    					operation(name);
    				}else{
    					
    					$('#'+name+"_span").html(fieldName+'<i18n:I18n key="i18n_account_alert_isNotExisting" defaultValue="子帐号不存在，请从新输入" />');
      					$('#'+name).focus();
      					$('body').data(name,true);
      					$("#addSubAccountOK").attr('disabled',true);
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
    		var elsSubAccount = $('body').data('elsSubAccount');
    		var agentSubAccount = $('body').data('agentSubAccount');
    		var startDate = $('body').data('startDate');
    		var endDate = $('body').data('endDate');
    		if(!elsSubAccount&&!agentSubAccount&&!startDate&&!endDate){
    			$("#addSubAccountOK").attr('disabled',false);
    		}
    }
</script>

</body>
</html>