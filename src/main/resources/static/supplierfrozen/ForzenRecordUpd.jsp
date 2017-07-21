<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String toElsAccount = request.getParameter("toElsAccount");
String companyShortName = request.getParameter("companyShortName");
String purchaseOrganize = request.getParameter("purchaseOrganize");
String company = request.getParameter("company");
String factory = request.getParameter("factory");
%>
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

<form id="ForzenForm" action="" method="post">
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</span>
			<input readonly class="" type="text" id="elsAccount" name="elsAccount" />
		</div>
	
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="对方ELS账号" />：</span>
			<input readonly class="" type="text" id="toElsAccount" name="toElsAccount" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="公司名称" />：</span>
			<input readonly class="" type="text" id="toCompanyShortName" name="toCompanyShortName" />
		</div>

		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="采购组织" />：</span>
			<input readonly  class="" type="text" id="purchaseOrganize" name="purchaseOrganize" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="采购组织名称 " />：</span>
			<!-- <input  class="" type="text" id="purchaseOrganizeName" name="purchaseOrganizeName"  readonly = "readonly"/> -->
			<select class="" id="purchaseOrganizeName" name="purchaseOrganizeName">
						<option  value = "">全部</option>
			</select>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="公司" />：</span>
		    
			<input  readonly class="" type="text" id="company" name="company" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="公司名称 " />：</span>
		    <select class="" id="companyName" name="companyName">
		    		<option value = "">全部</option>
			</select>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="工厂" />：</span>
			<input readonly  class="" type="text" id="factory" name="factory" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="工厂名称 " />：</span>
		     <select class="" id="factoryName" name="factoryName">
		     	<option value = "">全部</option>
			</select>
		</div>
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="整体" />：</span>
			<input type="checkbox" id="entirety" name="entirety" width="20px;"></td>
		</div>
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="对账" />：</span>
			<input type="checkbox" id="busRecon" name="busRecon" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="询报价" />：</span>
			<input type="checkbox" id="enquiry" name="enquiry" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="招投标" />：</span>
			<input type="checkbox" id="bidding" name="bidding" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="收发货" />：</span>
			<input type="checkbox" id="voucher" name="voucher" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="聊天" />：</span>
			<input type="checkbox" id="chat" name="chat" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="订单" />：</span>
			<input type="checkbox" id="orders" name="orders" width="20px;"></td>
		</div>
		
															<!-- SAP  冻结字段 start-->
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="SAP 采购订单冻结" />：</span>
			<input type="checkbox" id="fbk1" name="fbk1" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="SAP 请购单和采购订单冻结" />：</span>
			<input type="checkbox" id="fbk2" name="fbk2" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue=" SAP 冻结报价请求,订单和收货" />：</span>
			<input type="checkbox" id="fbk3" name="fbk3" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="SAP 源确定冻结 " />：</span>
			<input type="checkbox" id="fbk4" name="fbk4" width="20px;"></td>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="SAP 总冻结 " />：</span>
			<input type="checkbox" id="fbk5" name="fbk5" width="20px;"></td>
		</div>
															<!-- SAP  冻结字段 end-->
</form>	
		<!-- <div style="text-align: center; padding: 5px">
		<input type="button" onclick="addSubAccount();" value="确定"/>
		<input type="button" onclick="closeWin();" value="关闭 "/>
		</div> -->
		<div style="text-align: center; padding: 5px">
            <button id="addFrozenOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>

<script type="text/javascript">
	
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	var toElsAccount = '<%=toElsAccount%>';
	var toCompanyShortName = '<%=companyShortName%>';
	var purchaseOrganize = '<%=purchaseOrganize%>';
	var company = '<%=company%>';
	var factory = '<%=factory%>';
	var GobalparamStr = {"elsAccount":elsAccount,"toElsAccount":toElsAccount};
	$(function() {
		$("#elsAccount").val(elsAccount);
		$("#toElsAccount").val(toElsAccount);
		$("#toCompanyShortName").val(toCompanyShortName);
		$("#purchaseOrganize").val(purchaseOrganize);
		$("#company").val(company);
		$("#factory").val(factory);
	});
	$("#addFrozenOK").click(function(){
		 var frm = $("#ForzenForm");
		 changeValue("#entirety");
		 changeValue("#busRecon");
		 changeValue("#enquiry");
		 changeValue("#bidding");
		 changeValue("#voucher");
		 changeValue("#chat");
		 changeValue("#orders"); 
		 $.ajax({
				url : '<%=basePath%>rest/SupplierFreezeOptService/updateSupplierFreezeOpt',
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					//ajax请求后判断状态码 
					if(data!=null&&data.statusCode=="-100"){
						alert(data.message,3);
					}else if(data.statusCode=="200"){
						alert(data.message,1);
						closeWin();
						supplierForzenGrid.load(GobalparamStr);
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
		parent.frames['iframeApp_supplierFrozen'].queryIntegrationInfo();
        parent.elsDeskTop.closeCurWin('addFrozenRecord');
	}
	
	function changeValue(id){
		if( $(id).val()=="on"){
			$(id).val(1);
		}else{
			$(id).val(0);
		}
	}
	
	$("#entirety").click(function(){
		//if(true == $("#id").attr("checked"))
			$("#company").attr("checked","true");
			$("#busRecon").attr("checked","true");
			$("#enquiry").attr("checked","true");
			$("#bidding").attr("checked","true");
			$("#voucher").attr("checked","true");
			$("#chat").attr("checked","true");
			$("#orders").attr("checked","true");
		}
	
	);
	
</script>

</body>
</html>