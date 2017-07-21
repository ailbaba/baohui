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
                                                                                                                                                 
<form id="editFlieFrom" action="" method="post">  
         <input  type="hidden" id="id" name="id" />    
         <input  type="hidden" id="elsAccount" name="elsAccount" />         
         <div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_fileNumber" defaultValue="文档编号" />：</span>                           
			<input  class="" type="text"  readonly="readonly"  id="fileNumber" name="fileNumber" />                                                                    
			<span style="color: red" id="fileNumber_span"></span>                                                                                
		 </div> 
		                                                                                          
		 <div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n defaultValue="所属对象" key="i18n_fileManage_title_pertainObject"></i18n:I18n>：</span>
				<select class="" id="pertainObject" name="pertainObject">
						<option value="Material"><i18n:I18n defaultValue="物料" key="i18n_purchase_bargain_materialName"/></option>
						<option value="Vendor"><i18n:I18n defaultValue="供应商" key="i18n_enquiry_label_supplier"/></option>
						<option value="Customer"><i18n:I18n defaultValue="客户" key="i18n_label_customer"/></option>
						<option value="Manual"><i18n:I18n defaultValue="手册" key="i18n_label_manual"/></option>
						<option value="Purchaseorder"><i18n:I18n defaultValue="采购订单" key="i18n_label_ObjInventory"/></option>
						<option value="Quotation"><i18n:I18n defaultValue="询价单" key="i18n_businessType_bargainEnquiry"/></option>
						<option value="Salesorder"><i18n:I18n defaultValue="销售单" key="i18n_label_SalesList"/></option>
					    <option value="BusinessStatements"><i18n:I18n defaultValue="销售订单" key="i18n_title_saleOrder"/></option>
				</select>
	    </div>                                                                                                                                  
		                                                                                                            
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_stairObjectCode" defaultValue="1级编码格式" />：</span>                        
			<input  class="" type="text" id="stairObjectCode" name="stairObjectCode" />                                                          
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_secondObjectCode" defaultValue="2级编码格式" />：</span>                       
			<input  class="" type="text" id="secondObjectCode" name="secondObjectCode" />                                                        
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_thirdObjectCode" defaultValue="3级编码格式" />：</span>                        
			<input  class="" type="text" id="thirdObjectCode" name="thirdObjectCode" />                                                          
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_fourthObjectCode" defaultValue="4级编码格式" />：</span>                       
			<input  class="" type="text" id="fourthObjectCode" name="fourthObjectCode" />                                                        
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_fifthObjectCode" defaultValue="5级编码格式" />：</span>                        
			<input  class="" type="text" id="fifthObjectCode" name="fifthObjectCode" />                                                          
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_sixthObjectCode" defaultValue="6级编码格式" />：</span>                        
			<input  class="" type="text" id="sixthObjectCode" name="sixthObjectCode" />                                                          
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_seventhObjectCode" defaultValue="7级编码格式" />：</span>                      
			<input  class="" type="text" id="seventhObjectCode" name="seventhObjectCode" />                                                      
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_eighthObjectCode" defaultValue="8级编码格式" />：</span>                       
			<input  class="" type="text" id="eighthObjectCode" name="eighthObjectCode" />                                                        
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_ninthObjectCode" defaultValue="9级编码格式" />：</span>                               
			<input  class="" type="text" id="ninthObjectCode" name="ninthObjectCode" />                                                          
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_tenthObjectCode" defaultValue="10级编码格式" />：</span>                       
			<input  class="" type="text" id="tenthObjectCode" name="tenthObjectCode" />                                                             
		</div>                                                                                                                                   
		                                                                                                                                         
		<div class="input-and-tip text-left ">                                                                                                   
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_allocationDeclare" defaultValue="文档说明" />：</span>                    
			<input  class="" type="text" id="allocationDeclare" name="allocationDeclare" />                                                      
			<span style="color: red" id="allocationDeclare_span"></span>                                                                         
		</div>                                                                                                                                   
		                                                                                                                                                                                                                                                                     
</form>	                                                                                                                                         
		<div style="text-align: center; padding: 5px">                                                                                           
            <button id="editfildOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>                     
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_js_close" defaultValue="关闭 " /></button>                 
        </div>                                                                                                                                   
                                                                                                                                                 
<script type="text/javascript">                                                                                                                  
var pertainObject ="<%=request.getParameter("pertainObject") %>";
var stairObjectCode ="<%=request.getParameter("stairObjectCode") %>";
var secondObjectCode ="<%=request.getParameter("secondObjectCode") %>";
var thirdObjectCode ="<%=request.getParameter("thirdObjectCode") %>";
var fourthObjectCode ="<%=request.getParameter("fourthObjectCode") %>";
var fifthObjectCode ="<%=request.getParameter("fifthObjectCode") %>";
var sixthObjectCode ="<%=request.getParameter("sixthObjectCode") %>";
var seventhObjectCode ="<%=request.getParameter("seventhObjectCode") %>";
var eighthObjectCode ="<%=request.getParameter("eighthObjectCode") %>";
var ninthObjectCode ="<%=request.getParameter("ninthObjectCode") %>";
var tenthObjectCode ="<%=request.getParameter("tenthObjectCode") %>";
var fileNumber ="<%=request.getParameter("fileNumber") %>";
var allocationDeclare ="<%=request.getParameter("allocationDeclare") %>";
var createUser ="<%=request.getParameter("createUser") %>";
var createDate ="<%=request.getParameter("createDate") %>";


var id ="<%=request.getParameter("id") %>";
  
$(document).ready(function(){
	  init(); 
			window.beforeClose = function(close){
			    top.elsDeskTop.tip.init({
			        type            : 'confirm',
			        displayType     : 2, 
			        message         : '<i18n:I18n key="i18n_common_alert_confirmTheShutDown" defaultValue="确认关闭" />?',
			        closeEvent : function () {
			           close();
			        }
			    });
			};
	$("#editfildOK").click(function(){
		var key=$("#fileNumber").val();
		 if(key===null || key.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_ValueRequired" defaultValue="请输入文档编号" />',2);
			 $("#key").focus();
			 return;
		 }
		 var frm = $("#editFlieFrom");
		 $.ajax({
				url :"<%=basePath%>rest/ElsFileCenterService/updateFileAllocation",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
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
	parent.frames['iframeApp_filedistribution'].queryFileList();
    parent.elsDeskTop.closeCurWin('editFiledistribytion');

}

 function init(){
				$("#pertainObject").val(pertainObject);
				$("#stairObjectCode").val(stairObjectCode);
				$("#secondObjectCode").val(secondObjectCode);
				$("#thirdObjectCode").val(thirdObjectCode);
				$("#fourthObjectCode").val(fourthObjectCode);
				$("#fifthObjectCode").val(fifthObjectCode);
				$("#sixthObjectCode").val(sixthObjectCode);
				$("#seventhObjectCode").val(seventhObjectCode);
				$("#eighthObjectCode").val(eighthObjectCode);
				$("#ninthObjectCode").val(ninthObjectCode);
				$("#tenthObjectCode").val(tenthObjectCode);
				$("#fileNumber").val(fileNumber);
				$("#allocationDeclare").val(allocationDeclare);
				$("#createUser").val(createUser);
				$("#createDate").val(createDate);				
			    $("#id").val(id);
			    $("#elsAccount").val(elsAccount);
				
		}; 


</script>                                                                                                                                        
                                                                                                                                                 
</body>                                                                                                                                          
</html>                                                                                                                                          