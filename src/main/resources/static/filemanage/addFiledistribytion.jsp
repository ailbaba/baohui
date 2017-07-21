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
        <input  type="hidden" id="elsAccount" name="elsAccount" /> 
        
        <div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_fileNumber" defaultValue="文档编号" />：</span>
			<input  class="" type="text" id="fileNumber" name="fileNumber" />
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
		    <span class="edit-sub-title"><i18n:I18n key="i18n_fileManage_title_stairObjectCode" defaultValue="一级编码 "/>：</span>                        
			<input  class="" type="text" id="stairObjectCode" name="stairObjectCode" />                                                          
		</div>    
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="二级编码" key="i18n_fileManage_title_secondObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="secondObjectCode" name="secondObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="三级编码" key="i18n_fileManage_title_thirdObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="thirdObjectCode" name="thirdObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="四级编码" key="i18n_fileManage_title_fourthObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="fourthObjectCode" name="fourthObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="五级编码" key="i18n_fileManage_title_fifthObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="fifthObjectCode" name="fifthObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="六级编码" key="i18n_fileManage_title_sixthObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="sixthObjectCode" name="sixthObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="七级编码" key="i18n_fileManage_title_seventhObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="seventhObjectCode" name="seventhObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="八级编码" key="i18n_fileManage_title_eighthObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="eighthObjectCode" name="eighthObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="九级编码" key="i18n_fileManage_title_ninthObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="ninthObjectCode" name="ninthObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="十级编码" key="i18n_fileManage_title_tenthObjectCode"></i18n:I18n>：</span>
			<input  class="" type="text" id="tenthobjcode" name="tenthObjectCode" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="文档说明" key="i18n_fileManage_title_allocationDeclare"></i18n:I18n>：</span>
			<input  class="" type="text" id="allocationDeclare" name="allocationDeclare" />
			<span style="color: red" id="allocationDeclare_span"></span>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="文档版本" key="i18n_fileManage_title_versionNumber"></i18n:I18n>：</span>
			<input  class="" type="text" id="versionNumber" name="versionNumber" />
		</div>
</form>	
		<div style="text-align: center; padding: 5px">
            <button id="addfildOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>
<script type="text/javascript">
var fileNumber=$("#fileNumber").val();
$().ready(function(){
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
});	
	$(function() {
		$("#elsAccount").val(elsAccount);
	}); 
	$("#addfildOK").click(function(){
		 fileNumber=$("#fileNumber").val();//88888;8888
		 if(fileNumber===null || fileNumber.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_fileNumberRequired" defaultValue="请输入文档编号" />',2);
			 $("#fileNumber").focus();
			 return;
		 }
		 var frm = $("#subAccountForm");//888888;88888;999999
		 
			 $.ajax({
					url :'../rest/ElsFileCenterService/saveFileAllocation',
					type :"POST",
					contentType : "application/json",
					data : JSON.stringify(frm.serializeJSON()),
					dataType : "json",
					success : function(data) {
						alert('<i18n:I18n key="i18n_account_alert_addfepei" defaultValue="新增成功"/>',1);
						setTimeout(function(){				     
							closeWin();},"1000"); 
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
		parent.frames['iframeApp_filedistribution'].queryFileList();
        parent.elsDeskTop.closeCurWin('addFiledistribytion');
	}
    
    $("#fileNumber").click(function(){
    	//兼容ie 冒泡事件
        if (event && event.preventDefault) {
            event.preventDefault();
            event.stopPropagation();
        } else {
            window.event.returnValue = false;
        }
        parent.elsDeskTop.defineWin({
            'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
            'windowsId':'findFileInfo',
            'windowTitle':'查看文档分配物料关系',
            'windowSubTitle': companyShortName,
            'iframSrc':'<%=basePath%>filemanage/findFileInfo.jsp?frameAppId=addFiledistribytion',
            'showAdv': false,
            'windowStatus': 'regular',
            'windowMinWidth': 960,
            'windowMinHeight': 550,
            'windowPositionTop':20,
            'windowWidth':960,
            'windowHeight':550,
            'parentPanel':".currDesktop"
        });
    });
    
    function setFileNumbers(fileNumbers){//7777_1.0v;55555_1.0v;7777
      
    	$("#fileNumber").val(fileNumbers);
    }
    
</script>
</body>
</html>