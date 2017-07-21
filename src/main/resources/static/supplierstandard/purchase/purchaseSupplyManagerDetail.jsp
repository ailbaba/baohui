<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">
html, body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
}

#flashContent {
	display: none;
}

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
				<input id="scoreAccountBegin" name="standardDesc" type="text" style="width: 80px; max-width: 180px;" />
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
				    			<td colspan="1" align="right" style="width: 160px;"><i18n:I18n key="test" defaultValue="单据类型" />:</td>
				    			<td colspan="1" align="left">
				    				<select class="standardType" id="standardType" name="standardType" style="width: 194px; max-width: 194px; height:24px;">
										<option value="1"><i18n:I18n key="test" defaultValue="新增准入" /></option>
										<option value="6"><i18n:I18n key="test" defaultValue="新增评估" /></option>
<%-- 										<option value="2"><i18n:I18n key="test" defaultValue="变更准入" /></option> --%>
<%-- 										<option value="3"><i18n:I18n key="test" defaultValue="公开招标准入" /></option> --%>
<%-- 										<option value="4"><i18n:I18n key="test" defaultValue="新增准入模板" /></option> --%>
<%-- 										<option value="5"><i18n:I18n key="test" defaultValue="变更准入模板" /></option> --%>
									</select>
								</td>
								<td colspan="1" align="right" style="width: 160px;"><i18n:I18n key="test" defaultValue="单据描述" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="standardDesc" name="standardDesc" type="text" style="width: 180px; max-width: 180px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_applyDate" defaultValue="申请日期" />:</td>
				    			<td colspan="1" align="left">
								<input type="text" class="Wdate" onfocus="WdatePicker()" id="applyDate" name="applyDate" style="width: 180px; max-width: 180px;"/>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="" defaultValue="Sourcing负责人" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="person" name="person" type="text" style="width: 180px; max-width: 180px;"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right" style="width: 160px;"><i18n:I18n key="test" defaultValue="Buyer负责人" />:</td>
				    			<td colspan="1" align="left">
				    				<input id="fbk4" name="fbk4" type="text" style="width: 180px; max-width: 180px;" />
								</td>
								<td colspan="1" align="right" style="width: 160px;"><i18n:I18n key="test" defaultValue="付款方式" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="fbk5" name="fbk5" type="text" style="width: 180px; max-width: 180px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_enquiry_label_toElsAccount" defaultValue="供应商els帐号" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="toElsAccount" name="toElsAccount" type="text" onkeyup="addEnterpriseName(this.value,' + index+')" style="width: 180px; max-width: 180px;" readonly="readonly"/>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_supplieelsDesc" defaultValue="供应商els名称" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="supplierElsDesc" name="supplierElsDesc" type="text" style="width: 180px; max-width: 180px;" readonly="readonly"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_Supplierlevel" defaultValue="供应商级别" />:</td>
				    			<td colspan="1" align="left">
									<select id="fbk1" name="fbk1" style="width: 194px; max-width: 194px; height:24px;">
										<option value="A"><i18n:I18n key="test" defaultValue="A" /></option>
										<option value="B"><i18n:I18n key="test" defaultValue="B" /></option>
										<option value="C"><i18n:I18n key="test" defaultValue="C" /></option>
										<option value="D"><i18n:I18n key="test" defaultValue="D" /></option>
										<option value="E"><i18n:I18n key="test" defaultValue="E" /></option>
										<option value="F"><i18n:I18n key="test" defaultValue="F" /></option>
									</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="单据状态" />:</td>
				    			<td colspan="1" align="left">
				    				<select id="sendStatus" name="sendStatus" style="width: 194px; max-width: 194px; height:24px;" disabled="disabled">
											<option value="0"><i18n:I18n key="test" defaultValue="未发送" /></option>
											<option value="1"><i18n:I18n key="test" defaultValue="已发送" /></option>
											<option value="2"><i18n:I18n key="test" defaultValue="已撤回" /></option>
											<option value="3"><i18n:I18n key="test" defaultValue="已作废" /></option>
											<option value="4"><i18n:I18n key="test" defaultValue="已回复" /></option>
											<option value="5"><i18n:I18n key="test" defaultValue="已评分" /></option>
									</select>
								</td>
				    		</tr>
				    		<tr>
<%-- 				    			<td colspan="1" align="right"><i18n:I18n key="i18n_lable_deliverystatus" defaultValue="单据状态" />:</td> --%>
<!-- 				    			<td colspan="1" align="left"> -->
<!-- 				    				<select id="standardStatus" name="standardStatus" style="width: 194px; max-width: 194px; height:24px;" disabled="disabled"> -->
<%-- 										<option value="0"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" /></option> --%>
<%-- 										<option value="1"><i18n:I18n key="i18n_common_fillIn" defaultValue="填写中" /></option> --%>
<%-- 										<option value="2"><i18n:I18n key="i18n_common_inEvaluation" defaultValue="评估中" /></option> --%>
<%-- 										<option value="3"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option> --%>
<!-- 									</select> -->
<!-- 								</td> -->
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_auditmode" defaultValue="审批方式" />:</td>
				    			<td colspan="1" align="left">
									<select id="auditMode" name="auditMode" style="width: 194px; max-width: 194px; height:24px;">
										<option value="1"><i18n:I18n key="i18n_title_auditflow" defaultValue="审批流" /></option>
										<option value="3"><i18n:I18n key="i18n_title_artificialaudit" defaultValue="人工" /></option>
									</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />:</td>
				    			<td colspan="1" align="left">
									<select id="auditStatus" name="auditStatus" style="width: 194px; max-width: 194px; height:24px;" disabled="disabled">
										<option value="0"><i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" /></option>
										<option value="1" selected="selected"><i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" /></option>
										<option value="2"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option>
										<option value="3"><i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" /></option>
									</select>
								</td>
				    		</tr>
				    		<tr>
				    			
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="采购组" />:</td>
				    			<td colspan="1" align="left">
									<input id="purchaseGroup" name="purchaseGroup" type="text" style="width: 180px; max-width: 180px;" />
								</td>
								<td colspan="1" align="right"><i18n:I18n key="i18n_password_title_updateUser" defaultValue="更新用户" />:</td>
				    			<td colspan="1" align="left">
									<input id="createUser" name="createUser" type="text" style="width: 180px; max-width: 180px;"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"style="display:none;"><i18n:I18n key="test" defaultValue="供应商分类" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
									<select id="groupName" name="groupName" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="test" defaultValue="供应商" /></option>
										<option value="1"><i18n:I18n key="test" defaultValue="潜在供应商" /></option>
										<option value="2" selected="selected"><i18n:I18n key="test" defaultValue="陌生供应商" /></option>
										<option value="3"><i18n:I18n key="test" defaultValue="失效供应商" /></option>
									</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="ERP供应商编码" />:</td>
				    			<td colspan="1" align="left">
									<input id="vender" name="vender" type="text" style="width: 180px; max-width: 180px;"/>
								</td>
								
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="选择模板" />:</td>
				    			<td colspan="1" align="left">
				    				<input readonly  id="templateName"  name = "templateName" type="text" style="width: 180px; max-width: 180px;"/>
				    				<input id="templateNumber"  name = "templateNumber" type="hidden" style="width: 180px; max-width: 180px;"/>
				    				<button id = "modelList">选择模板</button>
								</td>
								
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n__supplierrassessreport_table_totalscore" defaultValue="总评分" />:</td>
				    			<td colspan="1" align="left">
									<input id="totalScore" name="totalScore" type="text" maxlength="20" onkeyup="value=value.replace(/[^0-9.]/g,'')" style="width: 180px; max-width: 180px;"/>
								</td>
								
<%-- 								<td colspan="1" align="right"><i18n:I18n key="i18n_password_title_updateUser" defaultValue="更新用户" />:</td> --%>
<!-- 				    			<td colspan="1" align="left"> -->
<!-- 									<input id="createUser" name="createUser" type="text" style="width: 180px; max-width: 180px;"/> -->
<!-- 								</td> -->
				    		</tr>
				    		<tr>
<%-- 				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="选择模板" />:</td> --%>
<!-- 				    			<td colspan="1" align="left"> -->
<!-- 				    				<input readonly  id="templateName"  name = "templateName" type="text" style="width: 180px; max-width: 180px;"/> -->
<!-- 				    				<input id="templateNumber"  name = "templateNumber" type="hidden" style="width: 180px; max-width: 180px;"/> -->
<!-- 				    				<button id = "modelList">选择模板</button> -->
<!-- 								</td> -->
								</tr>
								<tr>
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />:</td>
				    			<td colspan="1" align="left">
									<textarea id="remark" name="remark" rows="5" cols="300"></textarea>
								</td>
				    		</tr>	
				    		<tr>
				    			<td colspan="1" align="right"style="display:none;"><i18n:I18n key="test" defaultValue="通过后供应商类型" />:</td>
				    			<td colspan="1" align="left"style="display:none;">
				    				<select id="fbk3" name="fbk3" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="test" defaultValue="供应商" /></option>
										<option value="1"><i18n:I18n key="test" defaultValue="潜在供应商" /></option>
										<option value="2"><i18n:I18n key="test" defaultValue="陌生供应商" /></option>
										<option value="3"><i18n:I18n key="test" defaultValue="失效供应商" /></option>
									</select>
								</td>
								
				    		</tr>
				    		
				    	</tbody>
				      </table>
				      
			</div>
		
			<!-- 行信息 -->
			<div id="edit-line-item">
					<div class="tab-wrap" id="sheet-project">
					<div id="sheet-project-one">
						<main class="grid-container nest-table">
						<div class="grid-100" id="reCreate">
							<table id="itemTable"></table>
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
</div>

<script>
	var itemTable           ;
	var type           = "" ;
	var roleCode       = "" ;
	var elsAccount     = "<%=session.getAttribute("elsAccount")%>";
	var companyName    = "<%=session.getAttribute("companyShortName")%>";
	var standardNumber = getParam('standardNumber');
	var templateNumber = '<%= request.getParameter("templateNumber")%>'
	var rowIndexSelect = 0  ;
	var excelUploader       ;
	var rowIndex;
	var selectFbk1;
	 
	function getParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		var r = window.location.search.substr(1).match(reg);
		if (r != null) 
			return decodeURI(r[2]); 
		return null;
	}

	// 渲染   @author jiangzhidong 20160120  begin
	//允许任何字符输入框  readonly
	var initInputAnyReadonly = function(val, item, index){
		if(!val) { val = '';}
		return '<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};

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

	//日期input
	var formatDateInput = function (val, item, index){
		if (!val) { val = '';}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
	};

	//时间input
	var formatDateTimeInput = function (val, item, index){
		if(!val) { val = '';}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
		return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
	};

	//日期
	var formatDate = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};

	//时间
	var formatDateTime = function (val, item, index){
		if (!val) {val = "";}
		return new Date(val).format("yyyy-MM-dd hh:mm:ss");
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
	//参与对象 1-采购方 2-销售方
	var initParticipants = function(val,item,index) {
		if (!val) {val = "";}
		var sel=' selected="true"';
		var selected = '<select name="standardSupplierItemList[][participants]" id="standardSupplierItemList[][participants]" style="min-width:70px; padding:5px;"><option value="1"';
			if(val=="sale") selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="销售方" /></option><option value="2"'
			if(val=="purchese") selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="采购方" /></select>'
		return selected;
	};
	
	//评分账户
	var initScoreAccount = function(val, item, index){
		debugger;
		if(!val) { val = '';}
		return '<input type="text" id="'+this.name+'_'+index+'" value="'+val+'" style="width:200px;padding-right:20px;" onkeyup="value=value.replace(/[^(\d,)]/g,"")"/>'+
		'<img class="scoreAccount dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 2px;cursor: pointer;" id='+index+' title="<i18n:I18n key="" defaultValue="查找帐号" />" />';
	};
	//评分类型   1-合格/不合格 2-通过/不通过 3-记分制
	var initsScoreType = function(val,item,index) {
		if (!val) {val = "";}
		var sel=' selected="true"';
		var selected = '<select name="standardSupplierItemList[][scoreType]" id="standardSupplierItemList[][scoreType]" style="min-width:100px; padding-left:12px;"><option value="1"';
			if(val==1) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="合格/不合格" /></option><option value="2"'
			if(val==2) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="通过/不通过" /></option><option value="3"'
			if(val==3) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="记分制" /></select>'
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
		  		  		{ title:'评分账户', name:'fbk10' ,width:200, align:'center' ,renderer:initScoreAccount},
		  				{ title:'<i18n:I18n key="i18n_assesstemplate_table_weight" defaultValue="权重%" />', name:'weight',width:100, align:'center'},
		  				{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreStandard" defaultValue="评分标准说明" />', name:'scoreStandard', width: 120, align: 'center'}];

	//初始化
	$(document).ready(function(){
		$('#add-enq-sheet').tabs();
		$("#saveStandard").hide();
	    $("#sendStandard").hide();
	    
	    itemTable = $('#itemTable').mmGrid({
	        cols: cols_item,
	        height: 300,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
// 	        checkCol: true,
	    });
	    itemTable.on('cellSelected',function(e, item, rowIndex, colIndex){
			var _this=$(e.target);
			if(_this.hasClass("scoreAccount")) {
				showAccount('#itemTable',rowIndex,colIndex);
			}
		});
	    
	    var GobalparamStr = {"elsAccount":elsAccount,"standardNumber":standardNumber};
		$.ajax({
			url         : '<%=basePath%>rest/SupplierStandardService/queryStandardSupplierHeadByCondtion' + "?t="+new Date().getTime(),
			type        : 'POST',
			contentType : "application/json",
			data        : JSON.stringify(GobalparamStr),
			dataType    : "json",
			success     : function(data) {
				var p = data.rows;
				if(p.length>0){
					debugger;
					$("#standardNumber").val(p[0].standardNumber);
					$("#standardType").val(p[0].standardType);
					$("#standardDesc").val(p[0].standardDesc);
					var val = p[0].applyDate;
					if (!val) {val = "";}
					if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
					$("#applyDate").val(val);
					$("#person").val(p[0].person);
					$("#fbk4").val(p[0].fbk4);
					$("#fbk5").val(p[0].fbk5);
					$("#toElsAccount").val(p[0].toElsAccount);
					$("#supplierElsDesc").val(p[0].supplierElsDesc);
					$("#fbk1").val(p[0].fbk1);
					$("#sendStatus").val(p[0].sendStatus);
					$("#standardStatus").val(p[0].standardStatus);
					$("#auditMode").val(p[0].auditMode);
					$("#auditStatus").val(p[0].auditStatus);
					$("#totalScore").val(p[0].totalScore);
					$("#fbk3").val(p[0].fbk3);
					$("#remark").val(p[0].remark);
					$("#purchaseGroup").val(p[0].purchaseGroup);
					$("#groupName").val(p[0].groupName);
					$("#vender").val(p[0].vender);
					$("#createUser").val(p[0].createUser);
					$("#templateName").val(p[0].templateName);
					$("#templateNumber").val(p[0].templateNumber);
					$("body").data("templateNumberOld",p[0].templateNumber);
					
					var select = document.getElementById("standardType");
				    var val = select.options[select.selectedIndex].value;
				    if(val==1||val==2||val==3){
				    	$("#toElsAccount").after('<span id="span" style="color: red;">*</span>');
				    }
				   
				    if(p[0].sendStatus==0&&p[0].auditStatus=="1"){
				    	$("#saveStandard").show();
					    $("#sendStandard").show();
				    }
					loadItem(p[0]);
				}
			},
			error : function(data) {
				if (!permissionError(data)) {
 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
 				}
			}
		});	
		
	});
	
	//加载行
	var loadItem = function(obj) {
		debugger;
 	    var params = {"elsAccount":obj.elsAccount,"templateNumber":obj.templateNumber,"standardNumber":obj.standardNumber,"fbk13":"@detail@"};
 		$.ajax({
 			url : '<%=basePath%>rest/SupplierStandardService/queryStandardSupplierItemByCondtion' + "?t="+new Date().getTime(),
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
			 debugger;
				var _this=$(e.target);
				if(_this.hasClass("scoreAccount")) {
					showAccount('#itemTable',rowIndex,colIndex);
				} 
			});
	}
	
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
	//替换评分账号
	$("#replaceBtn").click(function(){
		 var itemTableRows = itemTable.rows();
		 debugger;
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
				var fbk10End = $('#fbk10_'+i).val();
				if(fbk10End==null||fbk10End=='')
					fbk10End = item.fbk10;
				$('#fbk10_'+i).val(fbk10End.replace(begin,end));
			}
 	});
  
	//保存准入
    $("#saveStandard").click(function(){
    	var select = document.getElementById("standardType");
        var val = select.options[select.selectedIndex].value;
        if(val==1||val==2||val==3){
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
    	
        debugger;
    	$("#elsAccount").val(elsAccount);
	    var formObj = $("#form").serializeJSON();
	    formObj["fbk13"]="@detail@";
	    formObj["fbk14"]=$("body").data("templateNumberOld");
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	    parent.elsDeskTop.showLoading('<i18n:I18n key="test" defaultValue="准入评估信息保存中" />');
		    debugger;
			var itemTableRows = itemTable.rows();
			if(itemTableRows != "" && itemTableRows != null && itemTableRows.length > 0){
				for(var i = 0 ; i < itemTableRows.length ; i ++ ){
					var item = itemTableRows[i];
					var scoreAccount = $('#fbk10_'+i).val();
					if(scoreAccount!=item.fbk10){
						formObj["fbk15"]="@true@";
					}
					item["fbk10"]=scoreAccount;
				}
			}
			formObj["standardTemplateVOs"]=itemTableRows;
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
		 				alert('<i18n:I18n key="i18n_common_title_createsuccess" defaultValue="保存成功!" />');
		 				parent.elsDeskTop.closeCurWin('purchaseSupplyManagerDetail',callBack);
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
	     
	 });
	
	//发送准入
	$("#sendStandard").click(function(){
		var select = document.getElementById("standardType");
	    var val = select.options[select.selectedIndex].value;
	    if(val==1||val==2||val==3){
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
		
		$("#elsAccount").val(elsAccount);
	    var formObj = $("#form").serializeJSON();
	    formObj["fbk13"]="@detail@";
	    formObj["fbk14"]=$("body").data("templateNumberOld");
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认准入评估发布？" />',closeEvent:function(){
	    parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_title_accessinformationrelease" defaultValue="准入评估信息发布中" />');
		    debugger;
			var itemTableRows = itemTable.rows();
			if(itemTableRows != "" && itemTableRows != null && itemTableRows.length > 0){
				for(var i = 0 ; i < itemTableRows.length ; i ++ ){
					var item = itemTableRows[i];
					var scoreAccount = $('#fbk10_'+i).val();
					if(scoreAccount!=item.fbk10){
						formObj["fbk15"]="@true@";
					}
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
		 				parent.elsDeskTop.closeCurWin('purchaseSupplyManagerDetail',callBack);
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
	 });
	
	//更改评分账号
	$("#btnSelectAccountDialogClose").click(function(){
    	$("#selectAccountDialog").hide();
    });
    $("#btnSelectAccountCancel").click(function(){
    	$("#selectAccountDialog").hide();
    });
    var selectAccountable;
    var accountCols = [{ title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:80, align:'center'},
                       { title:'<i18n:I18n defaultValue="子账号" key="i18n_common_title_elssubaccount"></i18n:I18n>', name:'elsSubAccount' , width:100, align:'center'},
                       { title:'<i18n:I18n defaultValue="姓名" key="i18n_common_title_username"></i18n:I18n>', name:'name' ,width:140, align:'center'}];
    
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
	// 查询子账号
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
	        'iframSrc':'<%=basePath%>regulation/template/templateCallBack.jsp?frameAppId=purchaseSupplyManagerDetail',
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
	 
	//回调
	function selectModelCallbackFunc(rows){
		debugger;
		var modelNum = rows.templateNumber;
		var modelName = rows.templateName;
		$("#templateName").val(modelName);
		$("#templateNumber").val(modelNum);
		initModelRegion();
	}
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
    function callBack(){
    	if(parent.frames['iframeApp_purchaseSupplyManager']) {
    		parent.frames['iframeApp_purchaseSupplyManager'].purchQuery();
    	}
    }
	
    //退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('purchaseSupplyManagerDetail');
	});


</script>
</body>
</html>