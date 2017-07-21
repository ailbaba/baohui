<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String toElsAccount = request.getParameter("toElsAccount");
String companyShortName = request.getParameter("companyShortName");
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

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            	 <div class="dis-in-b input-and-tip">
                    	<button id="addFrozenOK" class="button-wrap" ><i18n:I18n key="test" defaultValue="提交ERP" /></button>
                 </div>
                  <div class="dis-in-b input-and-tip">
                    	<button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
                 </div>
        	</div>
            </div>
        </div>
 <div class="box-wrap pos-relative bg-common">
<form id="ForzenForm" action="" method="post">
<table>
		<tr>
			<td align ="left"  style="width: 80px;"> <i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="elsAccount" name="elsAccount" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align ="left"  style="width:150px;"><i18n:I18n key="test" defaultValue="对方ELS账号" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="toElsAccount" name="toElsAccount" style="width: 130px; max-width: 180px;"/></td>
		</tr>

		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="公司名称" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="toCompanyShortName" name="toCompanyShortName" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="采购组织" />：</td>
			<td align ="left"><input  class="" type="text" id="purchaseOrganize" name="purchaseOrganize" style="width: 100px; max-width: 100px;"/></td>
			<td align ="left"  style="width:150px;"><i18n:I18n key="test" defaultValue="采购组织名称 " />：</td>
			<td align ="left"  style="width:100px;">
			<select class="" id="purchaseOrganizeName" name="purchaseOrganizeName">
						<option  value = "">全部</option>
			</select>
			</td>
		</tr>

		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="公司代码" />：</td>
			<td align ="left"><input  class="" type="text" id="company" name="company" style="width: 100px; max-width: 100px;"/></td>
			<td align ="left"  style="width:150px;"><i18n:I18n key="test" defaultValue="公司名称  " />：</td>
			<td align ="left"  style="width:100px;">
			<select class="" id="companyName" name="companyName">
						<option  value = "">全部</option>
			</select>
			</td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="工厂" />：</td>
			<td align ="left"><input  class="" type="text" id="factory" name="factory" style="width: 100px; max-width: 100px;"/></td>
			<td align ="left"  style="width:150px;"><i18n:I18n key="test" defaultValue="工厂名称  " />：</td>
			<td align ="left"  style="width:100px;">
			<select class="" id="factoryName" name="factoryName">
						<option  value = "">全部</option>
			</select>
			</td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:130px;"><i18n:I18n key="test" defaultValue="ERP记账冻结(全部公司代码)" />：</td>
			<td align ="left">
					<input type="checkbox" id="frozenAllCompanyTally"  width="20px;">
					<input type="hidden" id = "fbk2"  name  = "fbk2" width="20px;">
			</td>
			<td align ="left"  style="width:150px;"><i18n:I18n key="test" defaultValue="ERP采购冻结(全部采购组织)" />：</td>
			<td align ="left"  style="width:100px;">
					<input type="checkbox" id="frozenAllPurchaseGroupPurchase" width="20px;"></td>
					<input type="hidden"  id = "fbk3" name  = "fbk3" width="20px;">
			</td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="ERP记账冻结(指定公司代码)" />：</td>
			<td align ="left">
					<input type="checkbox" id="frozenCompanyTally" width="20px;">
			</td>
			<td align ="left"  style="width:150px;"><i18n:I18n key="test" defaultValue="ERP采购冻结(指定采购组织)" />：</td>
			<td align ="left"  style="width:100px;">
					<input type="checkbox" id="frozenPurchaseGroupPurchase"  width="20px;"></td>
			</td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:180px;"><i18n:I18n key="test" defaultValue="质量原因冻结" />：</td>
			<td align ="left">
			<select class="" id="qualityFrozen" >
						<option  value = "00">无 </option>
						<option  value = "01">采购订单冻结</option>
						<option  value = "02">请购单和采购订单冻结 </option>
						<option  value = "03">冻结报价请求,订单和收货 </option>
						<option  value = "04">源确定冻结 </option>
						<option  value = "99">总冻结 </option>
			</select>
			<input type="hidden"  id = "fbk4"  name  = "fbk4" width="20px;">
			</td>
		</tr>
		
		</tr>
				<td align ="left"  style="width:180px;"><i18n:I18n key="test" defaultValue="系统功能冻结" />：</td>
		<tr>
			<td align ="left"  style="width:100px;">
				 <span align ="left" ><i18n:I18n key="test" defaultValue="整体" />：</span>
			<input type="checkbox" id="entirety" name="entirety" width="20px;"></td>
			</td>
			<td align ="left"  style="width:100px;">
				<span align ="left" ><i18n:I18n key="test" defaultValue="对账" />：</span>
				<input type="checkbox" id="busRecon" name="busRecon" width="20px;"></td>
			</td>
			<td align ="left"  style="width:100px;">
					  <span align ="left" ><i18n:I18n key="test" defaultValue="询报价" />：</span>
						<input type="checkbox" id="enquiry" name="enquiry" width="20px;"></td>
			</td>
			<td align ="left"  style="width:100px;">
					 <span align ="left" ><i18n:I18n key="test" defaultValue="招投标" />：</span>
					<input type="checkbox" id="bidding" name="bidding" width="20px;"></td>
			</td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;">
				 <span align ="left" ><i18n:I18n key="test" defaultValue="收发货" />：</span>
			<input type="checkbox" id="voucher" name="voucher" width="20px;"></td>
			</td>
			<td align ="left"  style="width:100px;">
				 <span align ="left" ><i18n:I18n key="test" defaultValue="聊天" />：</span>
			<input type="checkbox" id="chat" name="chat" width="20px;"></td>
			</td>
			<td align ="left"  style="width:100px;">
					 <span align ="left" ><i18n:I18n key="test" defaultValue="订单" />：</span>
					<input type="checkbox" id="orders" name="orders" width="20px;"></td>
			</td>
		</tr>
	
</table>	

</form>	
</div>
		

<script type="text/javascript">
	
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	var toElsAccount = '<%=toElsAccount%>';
	var toCompanyShortName = '<%=companyShortName%>';
	var GobalparamStr = {"elsAccount":elsAccount,"toElsAccount":toElsAccount};
	$(function() {
		$("#elsAccount").val(elsAccount);
		$("#toElsAccount").val(toElsAccount);
		$("#toCompanyShortName").val(toCompanyShortName);
		getOrganization();
	});
	$("#addFrozenOK").click(function(){
		var companyCode = $("#company").val();
		if(companyCode==""){
			alert("公司代码不允许为空",2)
			return;
		}
		 var frm = $("#ForzenForm");
		 changeValue("#entirety");
		 changeValue("#busRecon");
		 changeValue("#enquiry");
		 changeValue("#bidding");
		 changeValue("#voucher");
		 changeValue("#chat");
		 changeValue("#orders"); 
		 //全公司冻结
		 if($("#frozenAllCompanyTally").attr("checked")=="checked"){
		 	$("#fbk2").val("1");
		 }
		 //全采购组织冻结
		 if($("#frozenAllPurchaseGroupPurchase").attr("checked")=="checked"){
			$("#fbk3").val("1");
		 }
		 //质量冻结
		 $("#fbk4").val($("#qualityFrozen").val());
		 //添加等待提示框 
		 parent.elsDeskTop.showLoading();
		 $.ajax({
				url : '<%=basePath%>rest/SupplierFreezeOptService/insertSupplierFreezeOpt',
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					//ajax请求后判断状态码 
					if(data!=null&&data.statusCode=="-100"){
						alert(data.message,3);
						parent.elsDeskTop.hideLoading();
					}else{
						//判断下返回的数据信息 
							parent.elsDeskTop.tip.init({type: 'confirm',message:data.message});
						//alert(data.message,3);
						parent.elsDeskTop.hideLoading();
						closeWin();
						supplierForzenGrid.load(GobalparamStr);
					}
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					parent.elsDeskTop.hideLoading();
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
	
	
	//根据els账号获取组织架构
	function getOrganization(){
		var params = {"elsAccount":toElsAccount};
		 $.ajax({
				url : '<%=basePath%>rest/ElsOrganizationService/queryOrganizationInfo',
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if(data.rows.length!=0){
						for(var i = 0;i<data.rows.length;i++){
							if(data.rows[i].orgCategoryId=="purchaseOrganization"){
								$("#purchaseOrganizeName").append('<option value = ' + data.rows[i].orgId+'> ' + data.rows[i].orgDesc +' </option>');
							}
							if(data.rows[i].orgCategoryId=="companyCode"){
								$("#companyName").append('<option value = ' + data.rows[i].orgId+'> ' + data.rows[i].orgDesc +' </option>');
							}
							if(data.rows[i].orgCategoryId=="factory"){
								$("#factoryName").append('<option value = ' + data.rows[i].orgId+'> ' + data.rows[i].orgDesc +' </option>');
							}
						}
					}
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});
	}
	
	//对应的组织结构控件更改之后
	$("#purchaseOrganizeName").change(function(e) {
		var options=$("#purchaseOrganizeName option:selected"); 
		$("#purchaseOrganize").val(options.val());
	});
	
	$("#companyName").change(function(e) {
		var options=$("#companyName option:selected"); 
		$("#company").val(options.val());
	});
	
	$("#frozenAllCompanyTally").click(function(){
		//判断冻结所有公司 
		if($("#frozenAllCompanyTally").attr("checked")=="checked"){
			$("#company").val("");
			$("#company").attr("readonly","readonly");         //添加readonly属性 & $("#ID").attr({ readonly: 'true' });
		}else{
			 $("#company").removeAttr("readonly");    //去除readonly属性
		}
	});
	
	$("#frozenAllPurchaseGroupPurchase").click(function(){
		//判断冻结所有采购组织
		if($("#frozenAllPurchaseGroupPurchase").attr("checked")=="checked"){
			$("#purchaseOrganize").val("");
			$("#purchaseOrganize").attr("readonly","readonly");         //添加readonly属性 & $("#ID").attr({ readonly: 'true' });
		}else{
			 $("#purchaseOrganize").removeAttr("readonly");    //去除readonly属性
		}
	});
	
	$("#frozenCompanyTally").click(function(){
		//判断冻结指定公司 

	});
	
	$("#frozenAllPurchaseGroupPurchase").click(function(){
		//判断冻结指定采购组织 

	});
	
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