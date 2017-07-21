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
			<button class="button-wrap" id="sendStandard"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
			<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
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
				    			<td colspan="1" align="right" style="width: 160px;"><i18n:I18n key="test" defaultValue="准入评估类型" />:</td>
				    			<td colspan="1" align="left">
				    				<select id="standardType" name="standardType" style="width: 194px; max-width: 194px; height:24px;">
										<option value="1"><i18n:I18n key="test" defaultValue="新增准入" /></option>
										<option value="2"><i18n:I18n key="test" defaultValue="变更准入" /></option>
										<option value="3"><i18n:I18n key="test" defaultValue="公开招标准入" /></option>
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
								<td colspan="1" align="right"><i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="person" name="person" type="text" style="width: 180px; max-width: 180px;"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_enquiry_label_toElsAccount" defaultValue="供应商els帐号" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="toElsAccount" name="toElsAccount" type="text" onkeyup="addEnterpriseName(this.value,' + index+')" style="width: 180px; max-width: 180px;"/><span style="color: red;">*</span>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_supplieelsDesc" defaultValue="供应商els名称" />:</td>
				    			<td colspan="1" align="left">
				    			<input id="supplierElsDesc" name="supplierElsDesc" type="text" style="width: 180px; max-width: 180px;"/>
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
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态" />:</td>
				    			<td colspan="1" align="left">
				    				<select id="sendStatus" name="sendStatus" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="i18n_label_notSent" defaultValue="未发送" /></option>
										<option value="1"><i18n:I18n key="i18n_label_Sent" defaultValue="已发送" /></option>
									</select>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_lable_deliverystatus" defaultValue="单据状态" />:</td>
				    			<td colspan="1" align="left">
				    				<select id="standardStatus" name="standardStatus" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" /></option>
										<option value="1"><i18n:I18n key="i18n_common_fillIn" defaultValue="填写中" /></option>
										<option value="2"><i18n:I18n key="i18n_common_inEvaluation" defaultValue="评估中" /></option>
										<option value="3"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option>
									</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_auditmode" defaultValue="审批方式" />:</td>
				    			<td colspan="1" align="left">
									<select id="auditMode" name="auditMode" style="width: 194px; max-width: 194px; height:24px;">
										<option value="1"><i18n:I18n key="i18n_title_auditflow" defaultValue="审批流" /></option>
										<option value="2"><i18n:I18n key="i18n_title_autoaudit" defaultValue="自动" /></option>
										<option value="3"><i18n:I18n key="i18n_title_artificialaudit" defaultValue="人工" /></option>
									</select>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />:</td>
				    			<td colspan="1" align="left">
									<select id="auditStatus" name="auditStatus" style="width: 194px; max-width: 194px; height:24px;">
										<option value="0"><i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" /></option>
										<option value="1" selected="selected"><i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" /></option>
										<option value="2"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option>
										<option value="3"><i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" /></option>
									</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="采购组" />:</td>
				    			<td colspan="1" align="left">
									<input id="purchaseGroup" name="purchaseGroup" type="text" style="width: 180px; max-width: 180px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="供应商分类" />:</td>
				    			<td colspan="1" align="left">
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
				    		</tr>
				    		<tr>
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
								<td colspan="1" align="right"><i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />:</td>
				    			<td colspan="1" align="left">
									<textarea id="remark" name="remark" rows="5" cols="300"></textarea>
								</td>
				    		</tr>	
				    	</tbody>
				      </table>
				      
			</div>
		
			<!-- 行信息 -->
			<div id="edit-line-item">
	           		<button class="button-wrap" id="addItemRowBtn"><i18n:I18n key="i18n_delivery_button_createaitem" defaultValue="新增行" /></button>
					<button class="button-wrap" id="delItemRowBtn"><i18n:I18n key="i18n_delivery_button_removeaitem" defaultValue="删除行" /></button>
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
</div>

<script>
	var itemTable           ;
	var type           = "" ;
	var roleCode       = "" ;
	var elsAccount     = "<%=session.getAttribute("elsAccount")%>";
	var companyName    = "<%=session.getAttribute("companyShortName")%>";
	var standardNumber = getParam('standardNumber');
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
			if(val==1) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="采购方" /></option><option value="2"'
			if(val==2) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="销售方" /></select>'
		return selected;
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
	
	var cols_item = [{ title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="els账号" />',      name:'standardSupplierItemList[][elsAccount]',         width: 120, align: 'center', renderer:initInputAnyReadonly,hidden:true},
						 { title:'<i18n:I18n key="i18n_common_title_headerinformation" defaultValue="抬头信息" />',     name:'standardSupplierItemList[][standardNumber]',     width: 120, align: 'center', renderer:initInputAnyReadonly,hidden:true},
						 { title:'<i18n:I18n key="i18n_common_title_standardItemNumber" defaultValue="准入评估单行号" />',   name:'standardSupplierItemList[][standardItemNumber]', width: 120, align: 'center', renderer:initInputAnyReadonly,hidden:true},
						 { title:'<i18n:I18n key="i18n_common_title_standardItemDesc" defaultValue="准入评估单行描述" />', name:'standardSupplierItemList[][standardItemDesc]' ,  width: 100, align: 'center', renderer:initInputAny,hidden:true},
						 { title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />',     name:'standardSupplierItemList[][templateNumber]',     width: 130, align: 'center', renderer:initInputAnyReadonly,hidden:true},
						 { title:'<i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />',     name:'standardSupplierItemList[][templateName]',       width: 150, align: 'center', renderer:initTemplateName},
						 { title:'<i18n:I18n key="i18n_common_title_downloadtemplate" defaultValue="模板下载" />',     name:'standardSupplierItemList[][fbk1]',               width: 210, align: 'center', renderer:initFbk1},
						 { title:'<i18n:I18n key="test" defaultValue="模板下载-文档编号" />', name:'standardSupplierItemList[][fbk2]', width: 130, align: 'center',renderer: initInputAny,hidden:true},
		  		   		 { title:'<i18n:I18n key="test" defaultValue="模板下载-文档版本" />', name:'standardSupplierItemList[][fbk3]', width: 130, align: 'center',renderer: initInputAny,hidden:true},
		  		  		 { title:'<i18n:I18n key="test" defaultValue="模板提交-文档编号" />', name:'standardSupplierItemList[][fbk4]', width: 130, align: 'center',renderer: initInputAny,hidden:true},
		  				 { title:'<i18n:I18n key="test" defaultValue="模板提交-文档版本" />', name:'standardSupplierItemList[][fbk5]', width: 130, align: 'center',renderer: initInputAny,hidden:true},
						 { title:'<i18n:I18n key="i18n_common_title_templatecommit" defaultValue="模板提交" />',     name:'standardSupplierItemList[][templatePath]',       width: 210, align: 'center', renderer:initTemplatePath},
						 { title:'<i18n:I18n key="i18n_common_title_templatedesc" defaultValue="模板描述" />',     name:'standardSupplierItemList[][templateDesc]',       width: 120, align: 'center', renderer:initInputAny},
						 { title:'<i18n:I18n key="i18n_common_title_uploadResult" defaultValue="提交结果" />',     name:'standardSupplierItemList[][uploadResult]',       width: 100, align: 'center', renderer:initInputAny},
						 { title:'<i18n:I18n key="i18n_common_title_participants" defaultValue="参与对象" />',     name:'standardSupplierItemList[][participants]',       width: 70,  align: 'center', renderer:initParticipants},
						 { title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreType" defaultValue="评分类型" />',     name:'standardSupplierItemList[][scoreType]',          width: 130, align: 'center', renderer:initsScoreType},
						 { title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreStandard" defaultValue="评分标准说明" />', name:'standardSupplierItemList[][scoreStandard]',      width: 120, align: 'center', renderer:initInputAny},
						 { title:'<i18n:I18n key="i18n_assesstemplate_table_weight" defaultValue="权重%" />',        name:'standardSupplierItemList[][weight]',             width: 100, align: 'center', renderer:initInputNumber},
						 { title:'<i18n:I18n key="i18n__supplierrassessreport_table_score" defaultValue="评分结果" />',     name:'standardSupplierItemList[][score]',              width: 100, align: 'center', renderer:initInputNumber},
						 { title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />',       name:'standardSupplierItemList[][logtime]',            width: 150, align: 'center', renderer:formatDateTimeInput}];
		
	
	//初始化记载信息 
	$(document).ready(function(){
		$( '#add-enq-sheet').tabs();

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
					$("#standardNumber").val(p[0].standardNumber);
					$("#standardType").val(p[0].standardType);
					$("#standardDesc").val(p[0].standardDesc);
					var val = p[0].applyDate;
					if (!val) {val = "";}
					if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
					$("#applyDate").val(val);
					$("#person").val(p[0].person);
					$("#toElsAccount").val('');
					$("#supplierElsDesc").val('');
					$("#fbk1").val(p[0].fbk1);
					//$("#sendStatus").val(p[0].sendStatus);
					//$("#standardStatus").val(p[0].standardStatus);
					$("#auditMode").val(p[0].auditMode);
					//$("#auditStatus").val(p[0].auditStatus);
					$("#totalScore").val(p[0].totalScore);
					$("#remark").val(p[0].remark);
					$("#purchaseGroup").val(p[0].purchaseGroup);
					$("#groupName").val(p[0].groupName);
					$("#vender").val('');
					$("#createUser").val(p[0].createUser);
					loadItem();  
				}
			},
			error : function(data) {
				if (!permissionError(data)) {
 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
 				}
			}
		});	
		
	      				
	    //===========================================项目信息(表单文件)===========================================     				
		var standardItemIndex=0;			
		itemTable = $('#itemTable').mmGrid({
			cols        : cols_item ,
			height      : 300       ,
			loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			checkCol    : true      ,
			multiSelect : true
		});
		
	});
	
	//加载行
	var loadItem = function() {
		var GobalparamStr2 = {"elsAccount":elsAccount,"standardNumber":standardNumber};
		$.ajax({
			url         : '<%=basePath%>rest/SupplierStandardService/queryStandardSupplierItemByCondtion' + "?t="+new Date().getTime(),
			type        : 'POST',
			contentType : "application/json",
			data        : JSON.stringify(GobalparamStr2),
			dataType    : "json",
			success     : function(data) {
				var p = data.rows;
				for(var i = 0 ; i < p.length ; i++ ){
					var k=p[i];
					var itemRow = { 'standardSupplierItemList[][elsAccount]'        :k.elsAccount,
									'standardSupplierItemList[][standardNumber]'    :k.standardNumber,
									'standardSupplierItemList[][standardItemNumber]':k.standardItemNumber,
									'standardSupplierItemList[][standardItemDesc]'  :k.standardItemDesc,
									'standardSupplierItemList[][templateNumber]'    :k.templateNumber,
									'standardSupplierItemList[][templateName]'      :k.templateName,
									'standardSupplierItemList[][fbk1]'              :k.fbk1,
									'standardSupplierItemList[][templatePath]'      :k.templatePath,
									'standardSupplierItemList[][templateDesc]'      :k.templateDesc,
									'standardSupplierItemList[][uploadResult]'      :k.uploadResult,
									'standardSupplierItemList[][participants]'      :k.participants,
									'standardSupplierItemList[][itemStatus]'        :k.itemStatus,
									'standardSupplierItemList[][scoreType]'         :k.scoreType,
									'standardSupplierItemList[][scoreStandard]'     :k.scoreStandard,
									'standardSupplierItemList[][weight]'            :k.weight,
									'standardSupplierItemList[][score]'             :k.score,
									'standardSupplierItemList[][logtime]'           :k.logtime
					}; 
					itemTable.addRow(itemRow);
				}
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
  
	//删除行
	var standardSupplierItemDelList = [];
	$("#delItemRowBtn").click(function(){
		var items = itemTable.selectedRows();
		var itemss = itemTable.selectedRowsIndex();
		itemTable.removeRow(itemss);
		if(items.length<=0){
			alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
			return;
		}
		debugger ;
		for(i=0;i<items.length;i++){
			var row = items[i] ;
			var standardItemNumber = row["standardSupplierItemList[][standardItemNumber]"];
			if(standardItemNumber!=null){
				var str = JSON.stringify(row) ;
				var del = str.replace(/standardSupplierItemList/g,'').replace(/\[|]/gi,'') ;
				standardSupplierItemDelList[i] = JSON.parse(del) ;	 
			}
		}
	});
			
	//生成供应商准入单号item
	$("#addItemRowBtn").click(function(){
		//模板导入  @author jiangzhidong @date 20160204  begin
		var isTrue = $("#checkboxId").is(':checked');
		if(isTrue){
			templete(); 
			return;
		}
		//模板导入  @author jiangzhidong @date 20160204  end

		var standardNumber = $("#standardNumber").val();
		addStandardItem(standardNumber);
	});

	//回调
	var addStandardItem = function (standardNumber){
		var itemRow = {'standardNumber':standardNumber};
		itemTable.addRow(itemRow);			 
	};
	
	//发送准入  参考模板新增
	$("#sendStandard").click(function(){
		if(!($("#toElsAccount").val()!=null&&$("#toElsAccount").val()!='')){
   	 		alert('供应商els帐号不能为空!',2);
   	 		return;
		}
		$("#elsAccount").val(elsAccount);
	    var formObj = $("#form").serializeJSON();
	    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认准入评估发布？" />',closeEvent:function(){
	    parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_title_accessinformationrelease" defaultValue="准入评估信息发布中" />');
		 	$.ajax({
		 		url : "<%=basePath%>rest/SupplierStandardService/sendStandard",
		 		type : "post",
		 		contentType : "application/json",
		 		data : JSON.stringify(formObj),
		 		dataType : "json",
		 		success : function(data) {
		 			parent.elsDeskTop.hideLoading();
		 			if(data.statusCode=="-100"){
		 				alert(data.message,2);
		 			}else{
		 				alert("<i18n:I18n key="i18n_common_title_createsuccess" defaultValue="创建成功！" />");
		 				parent.elsDeskTop.closeCurWin('purchaseSupplyManagerCopy',callBack);
		 			}
		 			console.log(data.statusCode+"   "+data.message);
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
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
    function callBack(){
    	if(parent.frames['iframeApp_purchaseSupplyManager']) {
    		parent.frames['iframeApp_purchaseSupplyManager'].purchQuery();
    	}
    }
		 
	//=================================================================文件=================================================================		 
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
		        'iframSrc':'<%=basePath%>filemanage/findFileInfo.jsp?frameAppId=purchaseSupplyManagerCopy&rowIndexId',
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
			
	//=================================================================模板=================================================================
	//模板导入
	var templete = function (){
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
			'windowsId':'purchaseTemplateManage',
			'windowTitle':'<i18n:I18n defaultValue="模板管理" key="i18n_label_TemplateManage"></i18n:I18n>',
			'iframSrc':'<%=basePath%>enquirymanage/purchase/purchaseTemplateManage.jsp?frameAppId=purchaseSupplyManager',
			 windowMinWidth: 300,
			 windowMinHeight: 300,
			 windowPositionTop:24,
			'windowWidth':800,
			'windowHeight':400,
			'parentPanel':".currDesktop"
		});
	}

	//模板回调
	var setTemplete = function(str){
		var headRows = headTable.selectedRows();
		var standardNumber = headRows[0].standardNumber;
		standardItemIndex = standardItemIndex + 1;
		$.ajax({
			url: "<%=basePath%>rest/SupplierStandardService/getStandardItemNumber/"+elsAccount+"/"+standardNumber+"/"+standardItemIndex+"?t="+new Date().getTime(),
			type: "GET",
			contentType: "application/json",
			dataType: "text",
			success: function(standardItemNumber) {
				if(standardItemNumber!=null&&standardItemNumber!=""){
					autoAddStandardItem(standardItemNumber,str);
				}
			},
			error: function (xhr, type, exception) {
				alert('<i18n:I18n key="i18n_label_operationfailed" defaultValue="失败" />', 2); 
			}
		});
	}

	//赋值
	var autoAddStandardItem = function(standardItemNumber,str){
		 var obj = JSON.parse(str);
		 var headRows = headTable.selectedRows();
		 if(isFirstItem){
			 itemTable.removeRow();
			 isFirstItem = false;
		 }
		 var data = itemTable.opts.cols;
		 for(var i= 0; i<=data.length-1; i++) {
			 var row = data[i];
			 if(row.name && arrItem.indexOf(row.name) != -1)
				 row.renderer = initInputAny;
			 else if(row.name && arrItem2.indexOf(row.name) != -1)
				 row.renderer = enquiryItemHandle2;
			 else if(row.name && arrItem3.indexOf(row.name) != -1)
				 row.renderer = formatDateTimeInput;
			 else if(row.name && arrItem4.indexOf(row.name) != -1)
				 row.renderer = initInputNumber;
			 else if(row.name && arrItem5.indexOf(row.name) != -1)
				 row.renderer = initTemplatePath;
		 }
		 
		 var strs1 = new Array(); 
		 var strs2 = new Array(); 
		 var strs3 = new Array(); 
		 var strs1 = obj[0].keyValue1.split(':');
		 var strs2 = obj[0].keyValue2.split(':');
		 var strs3 = obj[0].keyValue3.split(':');
		 var test  = strs1[0];
		 var test2 = strs2[0];
		 var test3 = strs3[0];
		 var itemRow = {'logtime':new Date().getTime(),
						'standardNumber':headRows[0].standardNumber,
						'standardItemNumber':standardItemNumber,
						'standardItemDesc':obj[0].templateName};
		 itemRow[test] =strs1[1];
		 itemRow[test2]=strs2[1];
		 itemRow[test3]=strs3[1];
		 itemTable.addRow(itemRow);
	}

	//退出
	$("#exitBtn").click(function(){
		//parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>', closeEvent:function(){
			parent.elsDeskTop.closeCurWin('purchaseSupplyManagerCopy');
		//}});
	});
	
	 //退出窗口 
	 window.beforeClose = function(close){ 
		//parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>', closeEvent:function(){
			close();
		//}});
	}

//=================================================数据查找======================================================测试
	 $('.findTemplate').live("click", function(event) {
			var obj=event.target;
			if(obj) 
				rowIndexId = obj.id;
		    //兼容ie 冒泡事件
			if (event && event.preventDefault) {
		        event.preventDefault();
		        event.stopPropagation();
		    } else {
		        window.event.returnValue = false;
		    }
		    parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
		        'windowsId':'purchaseSupplyData',
		        'windowTitle':'<i18n:I18n key="test" defaultValue="选择模板信息" />',
		        'windowSubTitle': companyShortName,
		        'iframSrc':'<%=basePath%>supplierstandard/purchase/purchaseSupplyData.jsp?frameAppId=purchaseSupplyManagerCopy&rowIndexId',
		        'showAdv': false,
		        'windowStatus': 'regular',
		        'windowMinWidth': 960,
		        'windowMinHeight': 500,
		        'windowPositionTop':24,
		        'windowWidth':960,
		        'windowHeight':500,
		        'parentPanel':".currDesktop"
		    });
		});

		//回调
		function selectModelCallbackFunc(rows){
			var modelTypeName = rows.modelTypeName;
			var rowId = "standardSupplierItemList[][templateName]_" + rowIndexId;
			document.getElementById(rowId).setAttribute("value",modelTypeName);
			
		}
</script>
</body>
</html>