<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">
table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>
	<div class="pos-relative public-wrap">
	    <div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="saveStandard"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button class="button-wrap" id="sendStandard"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
				<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
				&nbsp;&nbsp;&nbsp;&nbsp;评分账户：
				<input id="scoreAccountBegin" name="scoreAccountBegin" type="text" style="width: 80px; max-width: 180px;" />
				<button class="button-wrap" id="replaceBtn"><i18n:I18n key="test" defaultValue="替换为" /></button>
				<input readonly id="scoreAccountEnd" name="scoreAccountEnd" type="text" style="width: 80px; max-width: 180px;" />  <img id = "searchSubAccount" class="scoreAccount dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;right: 2px;top: 2px;cursor: pointer;" id='+index+' title="<i18n:I18n key="" defaultValue="查找帐号" />" />
			</div>
		</div>
	<form id="form" onsubmit="return false;">
		<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_basicData" defaultValue="基本数据" /></span>
		<div class="common-box-line">
		<div class="tab-wrap" id="add-enq-sheet">
			<ul>
				<li><a href="#edit-line-header"><i18n:I18n key="i18n_common_title_headerinformation" defaultValue="头信息" /></a></li>
				<li><a href="#edit-line-item"><i18n:I18n key="i18n_requirementsPlanning_table_projectInformation" defaultValue="行信息" /></a></li>
			</ul>
			
			<!-- 头信息 -->
			<div id="edit-line-header">
				<input type="hidden" id="elsAccount" name="elsAccount"/>
				<input type="hidden" id="standardNumber" name="standardNumber"/>
				<table>
				    	<tbody>
				    		<tr>
				    			<td colspan="1" align="right" "><i18n:I18n key="test" defaultValue="准入单类型" />:</td>
				    			<td colspan="1" align="left" ">
				    				<select class="standardType" id="standardType" name="standardType" style="width: 194px; max-width: 194px; height:24px;">
										<option value="1"><i18n:I18n key="test" defaultValue="新增准入" /></option>
										<option value="6"><i18n:I18n key="test" defaultValue="新增评估" /></option>
<%-- 										<option value="2"><i18n:I18n key="test" defaultValue="变更准入" /></option> --%>
<%-- 										<option value="3"><i18n:I18n key="test" defaultValue="公开招标准入" /></option> --%>
<%-- 										<option value="4"><i18n:I18n key="test" defaultValue="新增准入模板" /></option> --%>
<%-- 										<option value="5"><i18n:I18n key="test" defaultValue="变更准入模板" /></option> --%>
									</select>
								</td>
								</tr>
				    		<tr>
								<td colspan="1" align="right" style="width: 160px;"><i18n:I18n key="test" defaultValue="单据描述" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="standardDesc" name="standardDesc" type="text" style="width: 180px; max-width: 180px;" />
								</td>
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_applyDate" defaultValue="申请日期" />:</td>
				    			<td colspan="1" align="left">
								<input type="text" class="Wdate" onfocus="WdatePicker()" id="applyDate" name="applyDate" style="width: 180px; max-width: 180px;"/>
								</td>
				    		</tr>
				    		<tr>
				    			
								<td colspan="1" align="right"><i18n:I18n key="" defaultValue="Sourcing负责人" />:</td>
				    			<td colspan="1" align="left">
			<!-- 	    					<input id="person" name="person" type="text" style="width: 180px; max-width: 180px;"/> -->
				    					<select class="" id="person" name="person">
												<option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
										</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="采购组" />:</td>
				    			<td colspan="1" align="left">
									<input id="purchaseGroup" name="purchaseGroup" type="text" style="width: 180px; max-width: 180px;" />
								</td>
				    		</tr>
				    		
				    		<tr>
				    			
								<td colspan="1" align="right"><i18n:I18n key="" defaultValue="Buyer负责人" />:</td>
				    			<td colspan="1" align="left">
			<!-- 	    					<input id="person" name="person" type="text" style="width: 180px; max-width: 180px;"/> -->
				    					<select class="" id="fbk4" name="fbk4">
												<option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
										</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="" defaultValue="付款方式" />:</td>
								<td colspan="1" align="left">
				    					<select class="" id="fbk5" name="fbk5">
												<option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
										</select>
								</td>
				    		</tr>
				    		<tr>
				    		
				    		<td colspan="1" align="right"><i18n:I18n key="i18n_common_auditmode" defaultValue="审批方式" />:</td>
				    			<td colspan="1" align="left">
									<select  id="auditMode" name="auditMode" style="width: 194px; max-width: 194px; height:24px;">
										<option value="1" selected="selected"><i18n:I18n key="i18n_title_auditflow" defaultValue="审批流" /></option>
										<!-- <option value="2"><i18n:I18n key="i18n_title_autoaudit" defaultValue="自动" /></option> -->
										<option value="3"><i18n:I18n key="i18n_title_artificialaudit" defaultValue="人工" /></option>
									</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="" defaultValue="供应商类别" />:</td>
								<td colspan="1" align="left">
				    					<select class="" id="fbk31" name="fbk31">
												<option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
										</select>
								</td>
								<td colspan="1" align="right"style="display:none;"><i18n:I18n key="i18n_common_title_Supplierlevel" defaultValue="供应商分类" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
									<select id="groupName" name="groupName" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="test" defaultValue="供应商" /></option>
										<option value="1"><i18n:I18n key="test" defaultValue="潜在供应商" /></option>
										<option value="2" selected="selected"><i18n:I18n key="test" defaultValue="陌生供应商" /></option>
										<option value="3"><i18n:I18n key="test" defaultValue="失效供应商" /></option>
									</select>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_enquiry_label_toElsAccount" defaultValue="供应商els帐号" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="toElsAccount" name="toElsAccount" type="text" onkeyup="addEnterpriseName(this.value,' + index+')" style="width: 180px; max-width: 180px;"/>
								<button id = "supplierList">添加供应商</button>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_supplieelsDesc" defaultValue="供应商els名称" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="supplierElsDesc" name="supplierElsDesc" type="text" style="width: 180px; max-width: 180px;"/>
								</td>
				    			<td colspan="1" align="right"style="display:none;"><i18n:I18n key="i18n_common_title_Supplierlevel" defaultValue="供应商级别" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
									<select id="fbk1" name="fbk1" style="width: 194px; max-width: 194px; height:24px;">
										<option value="A"><i18n:I18n key="test" defaultValue="A" /></option>
										<option value="B"><i18n:I18n key="test" defaultValue="B" /></option>
										<option value="C"><i18n:I18n key="test" defaultValue="C" /></option>
										<option value="D"><i18n:I18n key="test" defaultValue="D" /></option>
										<option value="E"><i18n:I18n key="test" defaultValue="E" /></option>
										<option value="F"><i18n:I18n key="test" defaultValue="F" /></option>
									</select>
								</td>
								<td colspan="1" align="right"style="display:none;"><i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
				    				<select  disabled="disabled"  id="sendStatus" name="sendStatus" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="i18n_label_notSent" defaultValue="未发送" /></option>
										<option value="1"><i18n:I18n key="i18n_label_Sent" defaultValue="已发送" /></option>
									</select>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"style="display:none;"><i18n:I18n key="i18n_lable_deliverystatus" defaultValue="单据状态" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
				    				<select  disabled="disabled"  id="standardStatus" name="standardStatus" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" /></option>
										<option value="1"><i18n:I18n key="i18n_common_fillIn" defaultValue="填写中" /></option>
										<option value="2"><i18n:I18n key="i18n_common_inEvaluation" defaultValue="评估中" /></option>
										<option value="3"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option>
									</select>
								</td>
								
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"style="display:none;"><i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
									<select disabled="disabled"  id="auditStatus" name="auditStatus" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" /></option>
										<option value="1" selected="selected"><i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" /></option>
										<option value="2"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option>
										<option value="3"><i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" /></option>
									</select>
								</td>
								
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"style="display:none;"><i18n:I18n key="test" defaultValue="供应商分类" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
									<select disabled="disabled" id="groupName" name="groupName" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="test" defaultValue="供应商" /></option>
										<option value="1"><i18n:I18n key="test" defaultValue="潜在供应商" /></option>
										<option value="2" selected="selected"><i18n:I18n key="test" defaultValue="陌生供应商" /></option>
										<option value="3"><i18n:I18n key="test" defaultValue="失效供应商" /></option>
									</select>
								</td>
								<td colspan="1" align="right"style="display:none;"><i18n:I18n key="test" defaultValue="ERP供应商编码" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
									<input id="vender" name="vender" type="text" style="width: 180px; max-width: 180px;"/>
								</td>
				    		</tr>
				    		<tr style="display:none;">
				    			<td colspan="1" align="right"><i18n:I18n key="i18n__supplierrassessreport_table_totalscore" defaultValue="总评分" />:</td>
				    			<td colspan="1" align="left">
									<input id="totalScore" name="totalScore" type="text" maxlength="20" onkeyup="value=value.replace(/[^0-9.]/g,'')" style="width: 180px; max-width: 180px;"/>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="i18n_password_title_updateUser" defaultValue="更新用户" />:</td>
				    			<td colspan="1" align="left">
									<input id="createUser" name="createUser" type="text" style="width: 180px; max-width: 180px;"/>
								</td>
				    		</tr>
				    		
				    		
				    		<tr>
<%-- 				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="通过后供应商类型" />:</td> --%>
<!-- 				    			<td colspan="1" align="left"> -->
<!-- 				    				<select id="" name="fbk3" style="width: 194px; max-width: 194px; height:24px;"> -->
<%-- 										<option value="0"selected="selected"><i18n:I18n key="test" defaultValue="供应商" /></option> --%>
<%-- 										<option value="1"><i18n:I18n key="test" defaultValue="潜在供应商" /></option> --%>
<%-- 										<option value="2"><i18n:I18n key="test" defaultValue="陌生供应商" /></option> --%>
<%-- 										<option value="3"><i18n:I18n key="test" defaultValue="失效供应商" /></option> --%>
<!-- 									</select> -->
<!-- 								</td> -->
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="选择模板" />:</td>
				    			<td colspan="1" align="left">
				    				<input readonly  id="templateName"  name = "templateName" type="text" style="width: 180px; max-width: 180px;"/>
				    				<input id="templateNumber"  name = "templateNumber" type="hidden" style="width: 180px; max-width: 180px;"/>
				    				<button id = "modelList">选择模板</button>
								</td>
								
				    		</tr>
				    		
				    		<tr>
								<td colspan="1" align="right"style="display:none;"><i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
									<textarea id="remark" name="remark" rows="5" cols="300"></textarea>
								</td>
				    		</tr>	
				    	</tbody>
				      </table>
				      
			</div>
		
			<!-- 更改成模板链接  -->
			<div id="edit-line-item">
	                <div class="tab-wrap" id="sheet-project">
	                    <div id="sheet-project-one">
	                         <main class="grid-container nest-table">
			                    <div class="grid-100" id="reCreate">
			                        <table id="itemTable"></table>
			                        <div id="enquiryPage" style="text-align: right;"></div>
			                    </div>
			                </main>
	                    </div>
	                </div>
	        </div>
	        
	      </div>
	      </div>
	      </div>
		</form>
<!-- 账号选择窗口 -->
		<div class="fixed-dialog" id="selectAccountDialog" >
			<div class="dialog-tip bg-common" style="width: 480px;height:400px;margin-left: -215px;margin-top: -270px;">
			    <div class="dialog-close-btn" id="btnSelectAccountDialogClose"></div>
		        <div class="tip-head">
			        <img class="icon" src="../../icon/els.PNG" />
			        <span class="dialogTitle" id="titleSelectAccountDialog"><i18n:I18n key="" defaultValue="帐号选择" /></span>
			    </div>
			    <input type="hidden" id="selectAccountIndex">
			    <div class="">
			        <div class="box-wrap pos-relative bg-common">
			            <main class="bg-common p-6">
		                    <div class="grid-100" >
		                        <table id="select-supplier-table"></table>
		                    </div>
		                    <div class="mt-40 text-center" style="margin-top: 14px;">
			                    <button id="selectAccountOKBtn" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
			                    <button id="btnSelectAccountCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
			                </div>
		                 </main>
			        </div>
			    </div>
		    </div>
		</div>
		<!-- 添加供应商窗口 -->
		<div class="fixed-dialog supplie-groud" >
           <div class="dialog-tip bg-common contacts-box">
               <div class="dialog-close-btn" id="contactClose"></div>
               <div class="tip-head pos-relative">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="test" defaultValue="添加供应商" /></span>
                   <button class="button-wrap sure-selct" style="position: absolute;right: 44px;top: 11px;"><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
               </div>
               <div class="box-wrap pos-relative bg-common">
               <!-- <span class="dis-in-b pos-absolute" style="left: 16px;">可添加供应商列表：</span> -->
               <input class="dis-in-b pos-absolute contact-search" type="text" style="left: 16px;width: 220px;max-width: 220px;padding-right: 20px;" placeholder="输入查找关键字" />
               <img class="dis-in-b pos-absolute" src="../../img/icon_search.png" style="width:14px; left: 244px;top:14px;" />
               <span class="dis-in-b pos-absolute" style="left: 345px;"><i18n:I18n key="i18n_common_title_alreadyaddcontact" defaultValue="已添加的供应商列表" />：</span>
                   <div class="fl-left box-left mt-27"></div>
                   <div class="fl-left box-middle mt-27">
                        <p class="all-pre text-center">
                            <button class="contact-option-btn button-wrap" title="全部右移" >&gt;&gt;</button>
                        </p>
                        <p class="all-back text-center">
                            <button class="contact-option-btn button-wrap"  title="全部左移" >&lt;&lt;</button>
                        </p>
                    </div>
                   <div class="fl-left box-right mt-27"></div>
                   <div class="clear-both"></div>
               </div>
           </div>
	</div>

	</div>

	<script>
	 var headTable;
	 var itemTable;
	 var type="";
	 var roleCode="";
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	 var rowIndexSelect=0;
	 var excelUploader;
	 var rightScroll;           //供应商列表右栏
	 var leftScroll;				//供应商列表左栏
	 var rowIndex;
	 var selectFbk1;
	
	 // 渲染   @author jiangzhidong 20160120  begin
		//只允许数字输入框
		var initInputNumber = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
		};
		//允许任何字符输入框
		var initInputAny = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		//允许任何字符输入框  readonly
		var initInputAnyReadonly = function(val, item, index){
			if(!val) { val = '';}
			return '<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		//日期input
		var formatDateInput = function (val, item, index){
			if(!val) { val = '';}
			return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
		};
		//时间input
		var formatDateTimeInput = function (val, item, index){
			if(!val) { val = '';}
			return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
		};
		//模板下载-文件名称
		var initFbk1 = function(val, item, index){
			if (!val) {val = "<i18n:I18n key="i18n_common_title_Pleaseselectorhandin" defaultValue="请选择或手工录入" />";}
			return '<input readonly="readonly" class="fbk1" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		//模板提交-文件名称
		var initTemplatePath = function(val, item, index){
			if (!val) {val = "<i18n:I18n key="i18n_common_title_Pleaseselectorhandin" defaultValue="请选择或手工录入" />";}
			return '<input readonly="readonly" class="templatePath" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		//模板名称
		var initTemplateName = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'" placeholder="请选择或手工录入" />'
			+'<img src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;left: 132px;top: 4px;cursor: pointer;" class="findTemplate" title="选择模板类型"  id = ' + index +' />';
		};
		//参与对象   1-采购方 2-销售方
		var initParticipants = function(val,item,index) {
			var selected = '';
			if(val=='purchese'){
				selected = '采购方';
			}else if(val=='sale'){
				selected = '销售方';
			}
			return selected;
		};
		//评分账户
		var initScoreAccount = function(val, item, index){
			if(!val) {
				val = $('#person').val();
			}else{
				var scoreAccount = item.scoreAccount.split("_")[0];
			}
			return '<input type="text" id="'+this.name+'_'+index+'" value="'+scoreAccount+'" style="width:200px;padding-right:20px;" onkeyup="value=value.replace(/[^(\d,)]/g,"")"/>'+
			'<img class="scoreAccount dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 2px;cursor: pointer;" id='+index+' title="<i18n:I18n key="" defaultValue="查找帐号" />" />';
			
		};
		//行状态   1-模板上传、2-已提交、3-已评分
		var initItemStatus = function(val,item,index) {
			var selected = '<select name="standardSupplierItemList[][itemStatus]" id="standardSupplierItemList[][itemStatus]"  style="min-width:70px; padding:5px;">'
							+'<option value="1" selected="true"><i18n:I18n key="test" defaultValue="模板上传" /></option>'
							+'<option value="2"><i18n:I18n key="test" defaultValue="已提交" /></option>'
							+'<option value="3"><i18n:I18n key="test" defaultValue="已评分" /></option></select>'
			return selected;
		};
		
		//评分类型   1-合格/不合格 2-通过/不通过 3-记分制
		var initsScoreType = function(val,item,index) {
			var selected = '<select name="standardSupplierItemList[][scoreType]" id="standardSupplierItemList[][scoreType]"  style="min-width:80px; padding:5px;">'
							+'<option value="1"><i18n:I18n key="test" defaultValue="合格/不合格" /></option>'
							+'<option value="3"><i18n:I18n key="test" defaultValue="记分制" /></option></select>'
			return selected;
		};
		
	 // 渲染   @author jiangzhidong 20160120  end
	 
	  var cols_item = [{ title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />', name:'templateNumber', width: 130, align: 'center',hidden:true},
		  	            { title:'<i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />', name:'templateName', width: 150, align: 'center'},
		  		        { title:'<i18n:I18n key="i18n_common_title_templatedesc" defaultValue="模板描述" />', name:'templateDesc', width: 120, align: 'center'},
		  		     	{ title:'<i18n:I18n key="test" defaultValue="条例编号" />', name:'regulationNumber', width: 150, align: 'center'},
		  	         	{ title:'<i18n:I18n key="test" defaultValue="条例名称" />', name:'regulationName', width: 150, align: 'center'},
		  	         	{ title:'<i18n:I18n key="test" defaultValue="条例描述" />', name:'regulationDetail', width: 200, align: 'center'},
		  		        { title:'<i18n:I18n key="i18n_common_title_participants" defaultValue="参与对象" />', name:'participants',width:70, align:'center', renderer: initParticipants},
		  		      	{ title:'评分账户', name:'scoreAccount' ,width:200, align:'center' ,renderer:initScoreAccount},
		  				{ title:'<i18n:I18n key="i18n_assesstemplate_table_weight" defaultValue="权重%" />', name:'weight',width:100, align:'center'},
		  				{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreStandard" defaultValue="评分标准说明" />', name:'scoreStandard', width: 120, align: 'center'}];

	 
	 //初始化记载信息 
	 $(document).ready(function(){
		 $( '#add-enq-sheet').tabs();
		 $("#applyDate").val(new Date().format("yyyy-MM-dd"));
		 
		 itemTable = $('#itemTable').mmGrid({
		        cols: cols_item,
		        height: 300,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		    });
		 initSubAcount();//sourcing负责人
		 initBuyerSubAcount()// buyer负责人
		 initsupplierClassification();// 供应商类别
		 initPaymentType(); // 付款方式
	 });
	 
	 $("#searchSubAccount").click(function(){
		 $("#selectAccountDialog").show();
	    	if(!selectAccountable){
	    		selectAccountable=$('#select-supplier-table').mmGrid({
	    	        cols: accountCols,
	    	        url: "<%=basePath%>rest/AccountService/subAccountList",
	    	        params: {"elsAccount":elsAccount},
	    	        method: 'post',
	    	        height:280,
	    	        root: 'rows',
	    	        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    	        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    	        multiSelect: false,
	    	        checkCol: true,
	    	    });
	    	} 
	});
	 //模板初始化
	$("#modelList").click(function(){
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
	        'windowsId':'findModelInfo',
	        'windowTitle':'<i18n:I18n key="test" defaultValue="选择模板信息" />',
	        'windowSubTitle': companyShortName,
	        'iframSrc':'<%=basePath%>regulation/template/templateCallBack.jsp?frameAppId=purchaseSupplyManagerAdd',
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
	 
	 //加载模板条例
	 function initModelRegion(){
		 var templateNumber= $("#templateNumber").val();
		 var params = {"elsAccount":elsAccount,"templateNumber":templateNumber};
 		$.ajax({
 			url : '<%=basePath%>rest/RegulationService/getTemplateByNumber' + "?t="+new Date().getTime(),
 			type : 'POST',
 			contentType : "application/json",
 			data : JSON.stringify(params),
 			dataType : "json",
 			success : function(data) {
 				itemTable.load(data.rows);
 			},
 			error : function(data) {
 				if (!permissionError(data)) {
 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
 				}
 			}
 		});
 		 itemTable.on('cellSelected',function(e, item, rowIndex, colIndex){
				var _this=$(e.target);
				if(_this.hasClass("scoreAccount")) {
					showAccount('#itemTable',rowIndex,colIndex);
				} 
			});
	 }
	 
	 
	 //加载负责人
	 function initSubAcount(){
		 $.ajax({
				url :"<%=basePath%>rest/AccountService/subAccountList",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount}),
				success : function(data) {
					//var obj = JSON.parse(data);
					var option ="";
					if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							if(data.rows[i].elsSubAccount == elsSubAccount){
								option += '<option value='+ data.rows[i].elsSubAccount+' selected>'+data.rows[i].name+'</option>';
							}else{
							    option += '<option value='+ data.rows[i].elsSubAccount+'>'+data.rows[i].name+'</option>';
							}
						}
					}
					$('#person').append(option);
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(xhr.responseText, "Failed"); 
	        }
			});
		}
	 
	//加载Buyer负责人
	 function initBuyerSubAcount(){
		 $.ajax({
				url :"<%=basePath%>rest/AccountService/subAccountList",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount}),
				success : function(data) {
					//var obj = JSON.parse(data);
					var option ="";
					if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							if(data.rows[i].elsSubAccount == elsSubAccount){
								option += '<option value='+ data.rows[i].elsSubAccount+' selected>'+data.rows[i].name+'</option>';
							}else{
							    option += '<option value='+ data.rows[i].elsSubAccount+'>'+data.rows[i].name+'</option>';
							}
						}
					}
					$('#fbk4').append(option);
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(xhr.responseText, "Failed"); 
	        }
			});
		}
	 
	 function initsupplierClassification(){
		 var tableName = "supplierClassification";
		 var fieldName = "supplierClassification";
		 $.ajax({
			 	url:"<%=basePath%>rest/ElsSearchDictionaryService/findValueList",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount,"tableName":tableName,"fieldName":fieldName}),
				success : function(data) {
					//var obj = JSON.parse(data);
					var option ="";
					if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							if(data.rows[i].elsSubAccount == elsSubAccount){
								option += '<option value='+ data.rows[i].fieldValue+' selected>'+data.rows[i].fieldValue+"-"+data.rows[i].fieldValueText+'</option>';
							}else{
							    option += '<option value='+ data.rows[i].fieldValue+'>'+data.rows[i].fieldValue+"-"+data.rows[i].fieldValueText+'</option>';
							}
						}
					}
					$('#fbk31').append(option);
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(xhr.responseText, "Failed"); 
	        }
			});
	 }
	 // 加载付款方式
	 function initPaymentType(){
		 $("#elsAccount").val(elsAccount);
		 var formObj2 = $("#form").serializeJSON();
		 $.ajax({
			 	url : "<%=basePath%>rest/SupplierStandardService/queryPaymentType",
				type:"POST",
				contentType: "application/json",
				dataType: "json",
// 				async:false,
				data:JSON.stringify(formObj2),
				success : function(data) {
					//var obj = JSON.parse(data);
					var option ="";
					if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							if(data.rows[i].elsSubAccount == elsSubAccount){
								option += '<option value='+ data.rows[i].fbk6+' selected>'+data.rows[i].fbk5+'</option>';
							}else{
							    option += '<option value='+ data.rows[i].fbk5+'>'+data.rows[i].fbk5+'</option>';
							}
						}
					}
					$('#fbk5').append(option);
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(xhr.responseText, "Failed"); 
	        }
			});
	 }
	//添加企业名称
	var addEnterpriseName = function(elsAccount,index){
		if(elsAccount.length>=6){
			$.ajax({
				url :"<%=basePath%>rest/AccountService/queryPurchaseEnquirySupplyByCondtion",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount}),
				success : function(data) {
					var option ="";
					if(data.statusCode==-100){
						 var error = "该els账号为空";
						 $ ("#supplierElsDesc").val(error);
	    			}
					if(data!=null&&data!="" ){
						enterpriseName =  data["shortName"];
						$ ("#supplierElsDesc").val(enterpriseName);
					}
				},
				error: function (xhr, type, exception) {
	            	alert(xhr.responseText, "Failed"); 
	        	}
			});
		}
	}
	//更改评分账号
	$("#btnSelectAccountDialogClose").click(function(){
    	$("#selectAccountDialog").hide();
    });
    $("#btnSelectAccountCancel").click(function(){
    	$("#selectAccountDialog").hide();
    });
    var selectAccountable;
    var accountCols = [
                       { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:80, align:'center'},
                       { title:'<i18n:I18n defaultValue="子账号" key="i18n_common_title_elssubaccount"></i18n:I18n>', name:'elsSubAccount' , width:100, align:'center'},
                       { title:'<i18n:I18n defaultValue="姓名" key="i18n_common_title_username"></i18n:I18n>', name:'name' ,width:140, align:'center'},
                ];

    
    function showAccount(belond,index,colIndex){
    	$("#selectAccountDialog").show();
    	var sParam= belond+','+index+','+ colIndex;
    	$("#selectAccountIndex").val(sParam);
    	if(!selectAccountable){
    		selectAccountable=$('#select-supplier-table').mmGrid({
    	        cols: accountCols,
    	        url: "<%=basePath%>rest/AccountService/subAccountList",
    	        params: {"elsAccount":elsAccount},
    	        method: 'post',
    	        height:280,
    	        root: 'rows',
    	        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    	        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    	        multiSelect: true,
    	        checkCol: true,
    	    });
    	} 
    };
    $("#selectAccountOKBtn").click(function(){
		var selectedRows = selectAccountable.selectedRows();
		var indexArr = $("#selectAccountIndex").val().split(',');
		if(selectedRows != "" ){
			var subAccounts = selectedRows[0].elsSubAccount;
			for(var i=1;i<selectedRows.length;i++){
				subAccounts = subAccounts+","+selectedRows[i].elsSubAccount;
			}
			//$("#scoreAccount_"+index).val(subAccounts);
			if(indexArr != "" || indexArr != null){
				$("#scoreAccountEnd").val(subAccounts);
			}else{
				$(''+indexArr[0]).find('tr').eq(indexArr[1]).find('td').eq(indexArr[2]).find('input').val(subAccounts);
			}
		}else{
			alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
			return;
		}
		$("#selectAccountDialog").hide();
	});
  	//替换评分账号
	$("#replaceBtn").click(function(){
		    var itemTableRows = itemTable.rows();
		    var begin = $("#scoreAccountBegin").val();
		    var end = $("#scoreAccountEnd").val();
		    if(end==null || end ==""){
	       	 		alert('评分账号帐号不能为空!',2);
	       	 		return;
	    		}
	        //判断评分账号格式
	        	if(end.length!=4){
	        		alert("评分账号格式不正确",2);
	        		return;
	        	}
		    for(var i = 0 ; i < itemTableRows.length ; i ++ ){
				var item = itemTableRows[i];
				var fbk10End = $('#scoreAccount_'+i).val();
				if(fbk10End==null||fbk10End=='')
					fbk10End = item.fbk10;
				$('#scoreAccount_'+i).val(fbk10End.replace(begin,end));
			}
 	});
    
	//保存准入
    $("#saveStandard").click(function(){
    	var select = document.getElementById("standardType");
        var val = select.options[select.selectedIndex].value;
       
        if(val==1||val==2||val==3||val==6){
        	if(!($("#toElsAccount").val()!=null&&$("#toElsAccount").val()!='')){
       	 		alert('供应商els帐号不能为空!',2);
       	 		return;
    		}
        	//判断els账号是否为自身
        	if($("#toElsAccount").val()==elsAccount){
        		alert("供应商账号不能为自身",2);
        		return;
        	}
        	if(!($("#templateName").val()!= null && $("#templateName").val()!='')){
        		alert("模板不能为空",2);
        		return;
        	}
        }
        if(findSupplyStatus()){
    	$("#elsAccount").val(elsAccount);
	    var formObj = $("#form").serializeJSON();
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	    parent.elsDeskTop.showLoading('<i18n:I18n key="test" defaultValue="准入评估信息保存中" />');
			var itemTableRows = itemTable.rows();
			if(itemTableRows != "" && itemTableRows != null && itemTableRows.length > 0){
				for(var i = 0 ; i < itemTableRows.length ; i ++ ){
					var item = itemTableRows[i];
					var scoreAccount = $('#scoreAccount_'+i).val();
					item["fbk10"]=scoreAccount;
				}
			}
			formObj["standardTemplateVOs"]=itemTableRows;
// 			var flag = checkval(formObj);
// 			if(!flag){
		 	$.ajax({
		 		url : "<%=basePath%>rest/SupplierStandardService/saveStandard",
		 		type : "post",
		 		contentType : "application/json",
		 		data : JSON.stringify(formObj),
		 		dataType : "json",
		 		success : function(data) {
		 			parent.elsDeskTop.hideLoading();
		 			if(data.statusCode=="-100"){
		 				alert(data.message,3);
		 			}else{
		 				alert('<i18n:I18n key="i18n_common_title_createsuccess" defaultValue="创建成功!" />');
		 				parent.elsDeskTop.closeCurWin('purchaseSupplyManagerAdd',callBack);
		 			}
		 		},
		 		error : function(data) {
		 			parent.elsDeskTop.hideLoading();
		 			if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
		 		}
		 	});
// 			}
	 	
	     }}); 
        }
	 });
	
	//查询供应商准入状态名称
		function findSupplyStatus(){
		var flag = true;
		$("#elsAccount").val(elsAccount);
		var formObj2 = $("#form").serializeJSON();
			$.ajax({
					url:"<%=basePath%>rest/SupplierStandardService/querySupplyStatusByCondtion",
					type:"POST",
					contentType: "application/json",
					dataType: "json",
					async:false,
					data:JSON.stringify(formObj2),
					success: function(data) {
						if (data.errMessage && data.errMessage != "") {
				    		flag=false;
				    		alert(data.errMessage,2);
				    	}
					},
					error: function (xhr, type, exception) {
		            	alert(xhr.responseText, "Failed"); 
		        	}
				});
			return flag;
		}
	//发送准入
    $("#sendStandard").click(function(){
    	var select = document.getElementById("standardType");
        var val = select.options[select.selectedIndex].value;
        if(val==1||val==2||val==3||val==6){
        	if(!($("#toElsAccount").val()!=null&&$("#toElsAccount").val()!='')){
       	 		alert('供应商els帐号不能为空!',2);
       	 		return;
    		}
        	//判断els账号是否为自身
        	if($("#toElsAccount").val()==elsAccount){
        		alert("供应商账号不能为自身",2);
        		return;
        	}
        	if(!($("#templateName").val()!= null && $("#templateName").val()!='')){
        		alert("模板不能为空",2);
        		return;
        	}
        }
        if(findSupplyStatus()){
    	$("#elsAccount").val(elsAccount);
	    var formObj = $("#form").serializeJSON();
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认准入评估发布？" />',closeEvent:function(){
	    parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_title_accessinformationrelease" defaultValue="准入评估信息发布中" />');
		
		var itemTableRows = itemTable.rows();
		if(itemTableRows != "" && itemTableRows != null && itemTableRows.length > 0){
			for(var i = 0 ; i < itemTableRows.length ; i ++ ){
				var item = itemTableRows[i];
				var scoreAccount = $('#scoreAccount_'+i).val();
				item["fbk10"]=scoreAccount;
			}
		}
		formObj["standardTemplateVOs"]=itemTableRows;
	    $.ajax({
		 		url : "<%=basePath%>rest/SupplierStandardService/sendStandard",
		 		type : "post",
		 		contentType : "application/json",
		 		data : JSON.stringify(formObj),
		 		dataType : "json",
		 		success : function(data) {
		 			parent.elsDeskTop.hideLoading();
		 			if(data.statusCode=="-100"){
		 				alert(data.message,3);
		 			}else{
		 				alert('<i18n:I18n key="i18n_common_title_createsuccess" defaultValue="发送成功!" />');
		 				parent.elsDeskTop.closeCurWin('purchaseSupplyManagerAdd',callBack);
		 			}
		 		},
		 		error : function(data) {
		 			parent.elsDeskTop.hideLoading();
		 			if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
		 		}
		 	});
	 	
	     }});
        }
	 });
	
  //回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
    function callBack(){
    	if(parent.frames['iframeApp_purchaseSupplyManager']) {
    		parent.frames['iframeApp_purchaseSupplyManager'].purchQuery();
    	}
    }
	
	//模板下载 //模板提交
	$('.fbk1,.templatePath').live("click", function(event) {
		var obj=event.target;
		if(obj){
			var id = obj.id;
			rowIndex = id.split("_")[1];
			selectFbk1=obj.className;
		}
		
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
	        'windowTitle':'<i18n:I18n key="i18n_title_documentmaterialAllocationRelationship" defaultValue="查看文档分配物料关系" />',
	        'windowSubTitle': companyShortName,
	        'iframSrc':'<%=basePath%>filemanage/findFileInfo.jsp?frameAppId=purchaseSupplyManagerAdd&rowIndexId',
	        'showAdv': false,
	        'windowStatus': 'regular',
	        'windowMinWidth': 960,
	        'windowMinHeight': 550,
	        'windowPositionTop':20,
	        'windowWidth':960,
	        'windowHeight':550,
	        'parentPanel':".currDesktop"
	    });
	})
	//回调
   var setFileNumbers = function(fileNumbers){
        var row = fileNumbers.split("@file@");
		var fileNumber = row[0];
		var versionNumber = row[1];
		var fileName = row[2];
		if(selectFbk1=='fbk1'){//模板下载
			document.getElementById("standardSupplierItemList[][fbk1]_"+rowIndex).setAttribute("value",fileName);
			document.getElementById("standardSupplierItemList[][fbk2]_"+rowIndex).setAttribute("value",fileNumber);
			document.getElementById("standardSupplierItemList[][fbk3]_"+rowIndex).setAttribute("value",versionNumber);
		}else{//模板提交
			document.getElementById("standardSupplierItemList[][templatePath]_"+rowIndex).setAttribute("value",fileName);
			document.getElementById("standardSupplierItemList[][fbk4]_"+rowIndex).setAttribute("value",fileNumber);
			document.getElementById("standardSupplierItemList[][fbk5]_"+rowIndex).setAttribute("value",versionNumber);
		}
		
   }
	   

//回调
function selectModelCallbackFunc(rows){
	var modelNum = rows.templateNumber;
	var modelName = rows.templateName;
	$("#templateName").val(modelName);
	$("#templateNumber").val(modelNum);
	initModelRegion();
}

//下拉-准入单类型
$("#toElsAccount").after('<span id="span" style="color: red;">*</span>');
$("#templateName").after('<span id="span" style="color: red;">*</span>');
$(".standardType").change(function(val){
	var select = document.getElementById("standardType");
    var val = select.options[select.selectedIndex].value;
    $("#span").remove();
    if(val==1||val==2||val==3){
    	$("#toElsAccount").after('<span id="span" style="color: red;">*</span>');
    }
});

//==============================添加供应商==================================

	
	  //初始化联系人弹窗,将联系人的列表传人
    function initContact(list, dir, had) {
    	if(list && list.length) {
    		var oldArr = list;
    		$('body').data('cacheOldArr',oldArr);
        	var txt ="";
        	if(dir == 'left') {
        		$('.box-left').html('');
        		for(var i =0;i<oldArr.length;i++) {
        			var ifShow="block";
        			if(had && had.length) {
        				for(var j=0;j<had.length;j++) {
        					if(oldArr[i].toElsAccount == had[j].toElsAccount) {
        						ifShow="none";
        					}
        				}
        			}
            		txt +='<p class="contact-people" style="display:'+ifShow+';margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">left</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
            	}
        		$('.box-left').append(txt);
        		leftScroll.resize();
        	}
        	else if(dir == 'right') {
        		$('.box-right').html('');
        		for(var i =0;i<oldArr.length;i++) {
        			var ifShow="none";
        			if(had && had.length) {
        				for(var j=0;j<had.length;j++) {
        					if(oldArr[i].toElsAccount == had[j].toElsAccount) {
        						ifShow="block";
        					}
        				}
        			}
            		txt +='<p class="contact-people" style="display:'+ifShow+';margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">right</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
            	}
        		$('.box-right').append(txt);
        		rightScroll.resize();
        	}
    	}
    };
	

	  //添加供应商信息
    $("#supplierList").click(function(){
   	var contactP = $('body').data('cacheOldArr');
   	var tableRows = [];
/*    	if(editSupplieTable && editSupplieTable.rowsLength()) {
   		tableRows = editSupplieTable.rows();
   	} */
   	if(!contactP){
   		$.ajax({
    			url :"<%=basePath%>rest/FriendsService/findMyFriendsByType",
    			type :"POST",
    			contentType : "application/json",
    			dataType : "json",
    			//data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
    			data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount}),
    			success : function(data) {
    				var rows = data.rows;
    				for(var i = 0 ; i < rows.length ; i ++){
    					rows[i]["fromIndex"]=i;
    				}
    				//首次进入初始化
    				initContact(rows,'left',tableRows);
    				initContact(rows,'right',tableRows);
    			},
    			error: function (xhr, type, exception) {//获取ajax的错误信息
                    alert(xhr.responseText, "Failed"); 
           }
    		});
   	} else {
   		   //当表格已经有数据，初始化右边数据
           initContact(contactP,'left',tableRows);
           initContact(contactP,'right',tableRows);
   	}
   	$('.supplie-groud').show();
	    rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
	    leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
	});
    
  //存储临时的选择数据
    var cacheData = {};
    $('.contact-people').live('mouseover',function() {
    	$('.contacts-box').find('p').removeClass('add-contact');
        $(this).addClass('add-contact');
    });
    $('.contact-people').live('click',function() {
        cacheData.index = parseInt($(this).find('.people-index').text());
        cacheData.dir = $(this).find('.storeData-from').text();
        $('body').data('cachePeople',cacheData);
        var oldObj = $('body').data('cachePeople');
        if(oldObj && oldObj.dir=='left') {
        	$('.box-left').find('.contact-people').eq(oldObj.index).hide();
        	$('.box-right').find('.contact-people').eq(oldObj.index).show();
        	//清空临时存储的数据
        	$('body').data('cachePeople','');
        	rightScroll.resize();
       } else if(oldObj && oldObj.dir=='right') {
 	       	$('.box-left').find('.contact-people').eq(oldObj.index).show();
 	    	$('.box-right').find('.contact-people').eq(oldObj.index).hide();
 	    	//清空临时存储的数据
 	    	$('body').data('cachePeople','');
 	    	leftScroll.resize();
    	}
    });
    $('.contact-search').keyup(function() {
    	var val = $(this).val();
    	var all = $('.box-left').find('p').hide();
    	if(!val){
 			all.show();
 		} else {
 			all.filter(function(index,html) {
 	    		var oldText=$(html).find('.friend-name').text();
 	    		return oldText.indexOf(val) != -1;
 	    	}).show();
 		}
    });
    //选择左边全部
    $('.all-pre').click(function() {
    	var left =$('.box-left').find('.contact-people');
    	var right =$('.box-right').find('.contact-people');
    	left.each(function() {
    		if($(this).css("display")=="block"){
                var showInd = $(this).find('.people-index').text();
                right.eq(showInd).show();
            }
    	});
    	$('.box-left').find('.contact-people').hide();
    	//清空临时存储的数据
    	$('body').data('cachePeople','right');
    	rightScroll.resize();
    });
    //选择右边全部
 	$('.all-back').click(function() {
 		var left =$('.box-left').find('.contact-people');
    	var right =$('.box-right').find('.contact-people');
    	right.each(function() {
    		if($(this).css("display")=="block"){
                var showInd = $(this).find('.people-index').text();
                left.eq(showInd).show();
            }
    	});
    	$('.box-right').find('.contact-people').hide();
    	//清空临时存储的数据
    	$('body').data('cachePeople','left');
    	leftScroll.resize();
    });
    $('.sure-selct').click(function() {
    	var storeNewArr = $('.box-right').find(".contact-people:visible");
    	console.log(storeNewArr);
    	var lastArr = [];
        if(storeNewArr && storeNewArr.length) {
        	for(var i=0;i<storeNewArr.length; i++) {
        		var textObj = JSON.parse($(storeNewArr[i]).find('.storeData').text());
        		var Account = textObj.friendElsAccount;
                var fromIndex = textObj.fromIndex;
                var nameDes = textObj.friendCompanyName;
                var obj = {
               		"toElsAccount":Account,
                	"toElsDesc":nameDes,
                    "toFromIndex":fromIndex,
                };
                lastArr.push(obj);
        	}
        	//添加加载入供应商输入框 
        	//editSupplieTable.load(lastArr);
        	var length = lastArr.length;
        	var toElsAccounts = "";
        	var toElsAccountNames = "";
        	if(length>0){
	        	for(var i = 0;i<length;i++){
	        		var supplier = lastArr[i].toElsAccount;
	        		var supplierName = lastArr[i].toElsDesc;
	        		//去除toElsAccounts为空时多余的;
	        		if(toElsAccounts!=""){
			        	toElsAccounts = toElsAccounts + ";" +supplier;
	        		}else{
	        			toElsAccounts = supplier ;
	        		}
	        		if(toElsAccountNames!=""){
	        			toElsAccountNames = toElsAccountNames + ";" +supplierName;
	        		}else{
	        			toElsAccountNames = supplierName ;
	        		}
	        	}
	        	$("#toElsAccount").val(toElsAccounts);
	        	$("#supplierElsDesc").val(toElsAccountNames);
        	}
        } 
        $('.supplie-groud').hide();
        rightScroll.resize();
        leftScroll.resize();
    });
    //移除供应商信息
    $("#btnDelSupplie").click(function(){
    	 var selectedIndexes = editSupplieTable.selectedRowsIndex();
    	 editSupplieTable.removeRow(selectedIndexes);
	});

    $("#contactClose").click(function() {
    	$('.fixed-dialog').hide();
	    if(leftScroll) leftScroll.resize();
	    if(rightScroll)rightScroll.resize();
    });
    
    //------------选择供应商end---------------
    
    //退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('purchaseSupplyManagerAdd');
	});
</script>
</body>
</html>