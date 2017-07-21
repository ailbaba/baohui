<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
	String standardNumber = request.getParameter("standardNumber");
%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
		<input type="hidden" id="standardNumber" name="standardNumber" value="<%=session.getAttribute("standardNumber")%>"/>
		<input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsSubAccount")%>"/>
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
			<button class="button-wrap" id="sendBtn"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
			<button class="button-wrap" id="detBtn"><i18n:I18n key="test" defaultValue="详情" /></button>
			<button class="button-wrap" id="passBtn"><i18n:I18n key="test" defaultValue="通过" /></button>
			<button class="button-wrap" id="returnBtn"><i18n:I18n key="test" defaultValue="撤回" /></button>
			<%-- 		<button class="button-wrap" id="cancelBtn"><i18n:I18n key="test" defaultValue="作废" /></button> --%>
			<button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
			<button class="button-wrap" id="scoreItemBtn"><i18n:I18n key="test" defaultValue="提交评分" /></button>
			<button id="headcolumnDefineBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="头信息列自定义" /></button>
 			<button id="itemcolumnDefineBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="行信息列自定义" /></button> 
			<base:auditConfig elsAccount="${elsAccount }" businessType="standardSupplier">
				<button id="entryBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="提交审批"/></button>
				<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report"  defaultValue="撤销审批"/></button>
				<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow"  defaultValue="查看流程"/></button>
			</base:auditConfig>
			<%--	<button id="uploadToERP" class="button-wrap"><i18n:I18n key="test" defaultValue="回写ERP" /></button>
                <button class="button-wrap" id="copyBtn"><i18n:I18n key="test" defaultValue="参考模板新增" /></button> --%>
            <button id="downloadBtn" class="button-wrap"><i18n:I18n key="" defaultValue="导出EXCEL" /></button>
		</div>
	</div>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common">
			<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
		</span>
		<form id="queryForm" onsubmit="return false;">
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_standardNumber" defaultValue="准入评估单号" /></span>
					<input type="text" id="standardNumber" name="standardNumber"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_projectDesc" defaultValue="单据描述" />:</span>
					<input type="text" id="standardDesc" name="standardDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="test" defaultValue="负责人子账号" />:</span>
					<input type="text" id="person" name="person" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS账号" />:</span>
					<input type="text" id="toElsAccount" name="toElsAccount" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_supplieelsDesc" defaultValue="供应商ELS名称" />:</span>
					<input type="text" id="supplierElsDesc" name="supplierElsDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="test" defaultValue="单据状态" />:</span>
					<select class="sendStatus" id="sendStatus" name="sendStatus">
						<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
						<option value="0"><i18n:I18n key="test" defaultValue="未发送" /></option>
						<option value="1"><i18n:I18n key="test" defaultValue="已发送" /></option>
						<option value="2"><i18n:I18n key="test" defaultValue="已撤回" /></option>
						<option value="3"><i18n:I18n key="test" defaultValue="已作废" /></option>
						<option value="4"><i18n:I18n key="test" defaultValue="已回复" /></option>
						<option value="5"><i18n:I18n key="test" defaultValue="部分评分" /></option>
						<option value="6"><i18n:I18n key="test" defaultValue="全部评分" /></option>
					</select>
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="test" defaultValue="审批状态" />:</span>
					<select class="auditStatus" id="auditStatus" name="auditStatus">
						<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
						<option value="0"><i18n:I18n key="test" defaultValue="审批通过" /></option>
						<option value="1"><i18n:I18n key="test" defaultValue="未审批" /></option>
						<option value="2"><i18n:I18n key="test" defaultValue="审批中" /></option>
						<option value="3"><i18n:I18n key="test" defaultValue="审批拒绝" /></option>
					</select>
				</div>

				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="test" defaultValue="单据类型" />:</span>
					<select class="standardType" id="standardType" name="standardType">
						<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
						<option value="1"><i18n:I18n key="test" defaultValue="新增准入" /></option>
						<option value="6"><i18n:I18n key="test" defaultValue="新增评估" /></option> 
						<option value="2"><i18n:I18n key="test" defaultValue="变更准入" /></option>
						<option value="3"><i18n:I18n key="test" defaultValue="公开招投标准入" /></option>
<%-- 					<option value="4"><i18n:I18n key="test" defaultValue="新增准入模板" /></option> --%>
<%-- 					<option value="5"><i18n:I18n key="test" defaultValue="变更准入模板" /></option> --%>
					</select>
				</div>
				<button class="button-wrap" id="queryHeadBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				<br>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_applyDate" defaultValue="申请日期" />:</span>
					<input type="radio" name="dateArea" value="lastMonth" checked="checked"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
					<input type="radio" name="dateArea" value="lastThreeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
					<input type="radio" name="dateArea" value="defineDateArea"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
				</div>
				<div class="dis-in-b input-and-tip" style="display:none;">
					<input type="text" class="Wdate" onfocus="WdatePicker()" id="startCreateDate" name="startCreateDate"/>
				</div>
				<div class="dis-in-b input-and-tip" style="display:none;">
					<span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
					<input type="text" class="Wdate" onfocus="WdatePicker()" id="endCreateDate" name="endCreateDate" />
				</div>
			</div>
		</form>
	</div>


	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_headerinformation" defaultValue="头信息" /></span>
		<div class="common-box-line">
			<div class="tab-wrap" id="sheet-head">
				<div id="sheet-item-one">
					<main class="grid-container">
						<div class="grid-100">
							<table id="headTable"></table>
							<div id="enquiryPage" style="text-align: right;"></div>
						</div>
					</main>
				</div>
			</div>
		</div>
	</div>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_requirementsPlanning_table_projectInformation" defaultValue="行信息(表单文件)" /></span>
		<div class="common-box-line">
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

 <!-- 支持多个策略  begin  @jiangzhidong @date 20160428 -->
       <input type='hidden' name='stretegyCode' id="stretegyCode" />
       <div id="dialog2" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_selectStrategy" defaultValue="新选择审批策略" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_audit_lable_stretegy" defaultValue="审批策略" />：</span> 
							<select id="stretegySelctor">
							</select>
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		  </div>
		</div>
		<!-- 支持多个策略  end  @jiangzhidong @date 20160428 -->
		
        <!-- 对话框 -->
<div class="fixed-dialog" id="sendMsgDialog">
           <div class="dialog-tip bg-common" style="width: 420px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="<%=basePath%>/icon/destop-icon/desktop_icon_09.gif" />
                   <span class="dialogTitle"><i18n:I18n key="test" defaultValue="填写上报意见" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <textarea id="msgArea" style="width: 100%; box-sizing: border-box;margin: 0; display: block;resize: none;height: 150px;" maxlength="200"  onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0,200)" ></textarea>
	                       <div class="mt-20 text-center">
	                          <button id="sendMsgBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>

<script>
	var headTable           ;
	var itemTable           ;
	var type           = "" ;
	var roleCode       = "" ;
	var elsAccount     = "<%=session.getAttribute("elsAccount")%>"       ;
	var companyName    = "<%=session.getAttribute("companyShortName")%>" ;
	var subAccount  = "<%=session.getAttribute("elsSubAccount")%>" ;
	var standardNumber='<%=standardNumber%>';
	var rowIndexSelect =  0;
	var excelUploader       ;
	//初始化记载信息 
	$(document).ready(function(){
		$('.mmg-title:first').text('');
		$("input[name='dateArea']").click(function(){
			var dateArea = $(this).val();
			var currDate = new Date();

			if("lastMonth" == dateArea){
				$("#startCreateDate").parent().hide();
				$("#endCreateDate").parent().hide();

				var currDateMill = currDate.getTime();
				var startDate = new Date();
				startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
				var currMonthMaxDay = startDate.getDate();//本月天数
				startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));

				$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
				$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
			} else if("lastThreeMonth" == dateArea){
				$("#startCreateDate").parent().hide();
				$("#endCreateDate").parent().hide();

				var currDateMill = currDate.getTime();
				var startDate = new Date();
				startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
				var currMonthMaxDay = startDate.getDate();//本月天数
				startDate.setMonth(currDate.getMonth(), 0);//上月最后一日
				var lastMonthMaxDay = startDate.getDate();//上月天数
				startDate.setMonth(currDate.getMonth()-1, 0);//前第二月最后一日
				var last2MonthMaxDay = startDate.getDate();//前第二月天数

				startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay+lastMonthMaxDay+last2MonthMaxDay-1));
				$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
				$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
			} else if("defineDateArea" == dateArea) {
				$("#startCreateDate").val("");
				$("#endCreateDate").val("");
				$("#startCreateDate").parent().show();
				$("#endCreateDate").parent().show();
			} else {//默认查最近一月
				$("#startCreateDate").parent().hide();
				$("#endCreateDate").parent().hide();

				var currDateMill = currDate.getTime();
				var startDate = new Date();
				startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
				var currMonthMaxDay = startDate.getDate();//本月天数
				startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));

				$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
				$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
			}
		});
	});

	// 渲染   @author jiangzhidong 20160120  begin 
	//评分结果-只允许数字输入框
	var initInputNumber = function(val, item, index){
		if(val===null) { val = '';}
		// 判断是否是评分账户
		var flag = false;
		var fbk10s = item.fbk10.split(",");
		for(var i=0 ;i<fbk10s.length;i++){
			if(elsSubAccount == fbk10s[i]){
				flag = true;
			}
		}
		//评分类型为合格/不合格
		if(item.scoreType == "2"){
			var val0 ='';
			var val100 ='';
			if(val==0) val0='selected';
			if(val==100) val100='selected';
			if(flag){
				var selected = '<select name="'+this.name+'" id="'+this.name+'_'+index+'"  style="min-width:80px; padding:5px;">'
						+'<option value="100"'+val100+'><i18n:I18n key="test" defaultValue="合格" /></option>'
						+'<option value="0"'+val0+'><i18n:I18n key="test" defaultValue="不合格" /></option></select>'
			}else{
				var selected = '<select disabled="disabled" name="'+this.name+'" id="'+this.name+'_'+index+'"  style="min-width:80px; padding:5px;">'
				+'<option value="100"'+val100+'><i18n:I18n key="test" defaultValue="合格" /></option>'
				+'<option value="0"'+val0+'><i18n:I18n key="test" defaultValue="不合格" /></option></select>'
			}
			return selected;
		}else{//评分类型为记分制
			if(flag){
				return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
			}else{
				return '<input type="text" readonly="readonly" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
			}
		}
	};
	//允许任何字符输入框 -评审备注渲染
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		var fbk10s = item.fbk10.split(",");
		for(var i=0 ;i<fbk10s.length;i++){
			if(elsSubAccount == fbk10s[i]){
				return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
			}else{
				return '<input type="text" readonly="readonly" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
			}
		}
	};
	//评分 (判断评分类型 ,如果是记分制则返回填分框 )
	var initSorce = function(val, item, index){
		if(!val) { val = '';}
		//评分类型为合格/不合格
		if(item.scoreType == "2"){
			var selected = '<select name="standardSupplierItemList[][scoreType]" id="standardSupplierItemList[][scoreType]"  style="min-width:80px; padding:5px;">'
					+'<option value="1"><i18n:I18n key="test" defaultValue="请选择" /></option>'
					+'<option value="2"><i18n:I18n key="test" defaultValue="合格" /></option>'
					+'<option value="3"><i18n:I18n key="test" defaultValue="不合格" /></option></select>'
			return selected;
		}
		//评分类型为记分制
		if(item.scoreType == "1"){
			return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		}else{
			return '<span></span>'
		}
	};
	//行信息有效期
	var initFBK14 = function(val, item, index){
		if(!val) { val = '未输入';}
		if(item.fbk14 != "" && item.fbk14 != null){
			var date = new Date().format("yyyy-MM-dd");
			if(date.localeCompare(item.fbk14) > 0){
				return '已过期';
			}else{
				return item.fbk14;
			}
		}else{
			return '未输入';
		}
	};
	//允许任何字符输入框 只读
	var initInputAny2 = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" readonly="readonly" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};

	var initParticipants = function(val,item,index) {
		if (val == "sale") return '<i18n:I18n key="test" defaultValue="销售方" />';
		else if (val == "purchese") return '<i18n:I18n key="test" defaultValue="采购方" />';
	};

	//评分类型   1-百分比   2-合格/不合格
	var initScoreType = function(val,item,index) {
		if (val == "1") return '<i18n:I18n key="test" defaultValue="百分比" />';
		else if (val == "2") return '<i18n:I18n key="test" defaultValue="合格/不合格" />';
	};
	//企业名称
	var initCompanyName = function (val, item, index){
		if(!val) { val = '';}
		var name = this.name;
		var value = this.value;
		return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
	}
	//日期
	var formatDate = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};
	//时间
	var formatDateTime = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
		return val;
	};

	//审批方式
	var initAuditMode = function (val,item,index){
		//1-审批流 2-自动 3-人工
		if (val == "1" || val == null) return '<i18n:I18n key="i18n_title_auditflow" defaultValue="审批流" />';
		else if (val == "2") return '<i18n:I18n key="i18n_title_autoaudit" defaultValue="自动" />';
		else if (val == "3") return '<i18n:I18n key="i18n_title_artificialaudit" defaultValue="人工" />';
	};
	//总评分  人工
	var initTotalScore = function(val, item, index){
		if (!val) {val = "";}
		return '<div style="color: red;">' +val+ '</div>';
	};
	//单据状态
	var initSendStatus = function (val,item,index){
		//0:未发送 1:已发送2：已撤回3：已作废 4:已回复  5:部分评分6：全部评分
		if (val == "0") {
			return '<i18n:I18n key="i18n_label_notSent" defaultValue="未发送" />';
		}else if (val == "1"){
			return '<i18n:I18n key="i18n_label_Sent" defaultValue="已发送" />';
		}else if (val == "2"){
			return '<i18n:I18n key="test" defaultValue="已撤回" />';
		}
		else if (val == "3"){
			return '<i18n:I18n key="test" defaultValue="已作废" />';
		}
		else if (val == "4"){
			return '<i18n:I18n key="test" defaultValue="已回复" />';
		}
		else if (val == "5"){
			return '<i18n:I18n key="test" defaultValue="部分评分" />';
		}
		else if (val == "6"){
			return '<i18n:I18n key="test" defaultValue="全部评分" />';
		}
	};
	//准入类型  1:新增准入 2:变更准入 3:公开招投标准入 4:新增准入模板 5:变更准入 模板
	var initStandardType = function (val,item,index){
			     if (val == "1") return '<i18n:I18n defaultValue='新增准入' key='test'/>'   ;
			else if (val == "2") return '<i18n:I18n defaultValue='变更准入' key='test'/>'   ;
			else if (val == "3") return '<i18n:I18n defaultValue='公开招标准入' key='test'/>' ;
			else if (val == "4") return '<i18n:I18n defaultValue='新增准入模板' key='test'/>'   ;
			else if (val == "5") return '<i18n:I18n defaultValue='变更准入模板' key='test'/>'   ;
			else if (val == "6") return '<i18n:I18n defaultValue='新增评估' key='test'/>'   ;
		};
	//审批状态
	var initAuditStatus = function (val,item,index){
		//审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
		if(item.auditMode=="3"||(item.auditMode=="1"&&val != "2")){
			if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
			else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
	 		else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
	 		else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';
		}else{
			var fbk32Tmp = item.fbk32;
			debugger;
 			//if(fbk32==='流程'){
 			//	return '流程';
 			//}else{
 				return '<span class="flowBtn" style="color:blue;"><i18n:I18n key="test" defaultValue="'+fbk32Tmp+'" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
 			//}
 		}
	};
	//评分账户
	var initScoreAccount = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="templateList[]['+this.name+']" id="'+this.name+'_'+index+'" value="'+val+'"  style="width:200px;padding-right:20px;" readonly="readonly" onkeyup="value=value.replace(/[^(\d,)]/g,"")"/>'//+
// 		'<img class="scoreAccount dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 2px;cursor: pointer;" id='+index+' title="<i18n:I18n key="" defaultValue="查找帐号" />" />';
		
	};
	//供应商els帐号
	var initToElsAccount = function (val,item,index){
		return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};

	//模板条例明细 
	var initModelRegulation  = function (val,item,index){
		return '<span class="regulationDetailBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};

	//查看准入条例
	var ModelRegulationCheck  = function (val,item,index){
		return '<span class="regulationCheckBtn" style="color:blue;">供应商条例选项</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	//渲染模板名称进入不同模板界面 
	var selectModel = function(val,item,index){
		if(val!=""){
			if(val=="检验工厂"){
				return val+'<span class="selectModel" style="color:blue;">&nbsp;检验</span><span style="display: none;">'+JSON.stringify(item) +'</span>';
			}else if(val=="检验样品"){
				return val+'<span class="selectModel" style="color:blue;">&nbsp;检验</span><span style="display: none;">'+JSON.stringify(item) +'</span>';
			}else{
				return val+'<span class="selectModel" style="color:blue;">&nbsp;查看</span><span style="display: none;">'+JSON.stringify(item) +'</span>';
			}
		}
	}
	//行状态   1-模板上传、2-已提交、3-已评分
	var initItemStatus = function(val,item,index) {
		if (val == "1") return '<i18n:I18n key="test" defaultValue="模板上传" />'
		else if (val == "2") return '<i18n:I18n key="test" defaultValue="已提交" />'
		else if (val == "3") return '<i18n:I18n key="test" defaultValue="已评分" />'
	};
	//评分类型   1-合格/不合格 2-通过/不通过 3-记分制
	var initScoreType = function(val,item,index) {
		if (val == "1") return '<i18n:I18n key="test" defaultValue="百分比" />';
		else if (val == "2") return '<i18n:I18n key="test" defaultValue="合格/不合格" />';
	};
	//供应商分类   0-供应商  1-潜在供应商  2-陌生供应商  3-失效供应商
	var initGroupName = function(val,item,index) {
		if (val == "0") return '<i18n:I18n key="test" defaultValue="供应商" />'
		else if (val == "1") return '<i18n:I18n key="test" defaultValue="潜在供应商" />'
		else if (val == "2") return '<i18n:I18n key="test" defaultValue="陌生供应商" />'
		else if (val == "3") return '<i18n:I18n key="test" defaultValue="失效供应商" />'
	};
	// 渲染   @author jiangzhidong 20160120  end	 
    //头信息列自定义
	$("#headcolumnDefineBtn").click(function(){
			 parent.elsDeskTop.defineWin({
			     'iconSrc':'icon/els-icon.png',
			     'windowsId':'subAccountColumnSetting',
			     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="头信息列自定义" />',
			     windowSubTitle: "",
			     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchase_supply_header_mt" + "&window=iframeApp_purchase_supply_header_mt",
			     windowMinWidth: 480,
			     windowMinHeight: 600,
			     'windowWidth':480,
			     'windowHeight':600,
			     'parentPanel':".currDesktop"
			  });
			 });
	
	 //行信息列自定义
	$("#itemcolumnDefineBtn").click(function(){
			 parent.elsDeskTop.defineWin({
			     'iconSrc':'icon/els-icon.png',
			     'windowsId':'subAccountColumnSetting',
			     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="行信息列自定义" />',
			     windowSubTitle: "",
			     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchase_supply_item_mt" + "&window=iframeApp_purchase_supply_item_mt",
			     windowMinWidth: 480,
			     windowMinHeight: 600,
			     'windowWidth':480,
			     'windowHeight':600,
			     'parentPanel':".currDesktop"
			  });
			 });

	//新增
	$("#addBtn").click(function(){
		parent.elsDeskTop.defineWin({
			iconSrc : "icon/icon9.png",
			windowsId : "purchaseSupplyManagerAdd",
			windowTitle : "<i18n:I18n defaultValue='准入评估新建管理' key='i18n_common_title_Newaccessmanagement'/>",
			iframSrc : "${pageContext.request.contextPath}/supplierstandard/purchase/purchaseSupplyManagerAdd.jsp",
			showAdv : true,
			windowStatus : "regular",
			windowMinWidth : 960,
			windowMinHeight : 700,
			windowWidth : 960,
			windowHeight : 700,
			parentPanel : ".currDesktop"
		});
	});

	//撤回准入单
	$("#returnBtn").click(function(){
		var head = headTable.selectedRows();
		if(head.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus =="2"){
			alert('<i18n:I18n key="test" defaultValue="该单据已经撤回" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus =="0"){
			alert('<i18n:I18n key="test" defaultValue="该单据未发送，无需撤回" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus =="3"){
			alert('<i18n:I18n key="test" defaultValue="该单据已作废，无法撤回" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus =="4"){
			alert('<i18n:I18n key="test" defaultValue="销售方已回复，无法撤回" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus =="5" || head[0].sendStatus =="6" ){
			alert('<i18n:I18n key="test" defaultValue="已评分，无法撤回" />',2);
			return;
		}
		//判断发送状态
		if(head[0].standardStatus =="2"){
			alert('<i18n:I18n key="test" defaultValue="销售方已填写，无法撤回" />',2);
			return;
		}
		//判断是否为当前用户或管理员
		if(head[0].person.split("_")[0]!=subAccount && subAccount != "1001"){
			alert('<i18n:I18n key="test" defaultValue="当前用户非单剧发起人" />',2);
			return;
		}
		if(head[0].auditStatus != "1"){
			alert('<i18n:I18n key="test" defaultValue="已提交审批，不能撤回!" />',2);
			return;
		}
		var params = {"elsAccount":head[0].elsAccount,"toElsAccount":head[0].toElsAccount,"standardNumber":head[0].standardNumber};
		$.ajax({
			url : '<%=basePath%>rest/SupplierStandardService/purchasereCallStandard',
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				headTable.load({});
				alert('<i18n:I18n key="test" defaultValue="撤回成功!" />',1);
			},
			error : function(data) {
				if (!permissionError(data)) {
 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
 				}
			},complete : function(data) {
				parent.elsDeskTop.hideLoading();
			}
		});

	});

	//作废准入单
	$("#cancelBtn").click(function(){
		var head = headTable.selectedRows();
		if(head.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus == "3"){
			alert('<i18n:I18n key="test" defaultValue="该单据已作废" />',2);
			return;
		}

		//判断是否为当前用户
		if(head[0].person.split("_")[0]!=subAccount){
			alert('<i18n:I18n key="test" defaultValue="当前用户非单剧发起人" />',2);
			return;
		}
		var params = {"elsAccount":head[0].elsAccount,"toElsAccount":head[0].toElsAccount,"standardNumber":head[0].standardNumber};
		$.ajax({
			url : '<%=basePath%>rest/SupplierStandardService/purchasereCancelStandard',
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				headTable.load({});
				alert('<i18n:I18n key="test" defaultValue="作废成功!" />',1);
			},
			error : function(data) {
				if (!permissionError(data)) {
 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
 				}
			},complete : function(data) {
				parent.elsDeskTop.hideLoading();
			}
		});

	});


	//详情
	$("#detBtn").click(function(){
		var head = headTable.selectedRows();
		if(head.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		var standardNumber=head[0].standardNumber;
		var templateNumber=head[0].templateNumber;
		parent.elsDeskTop.defineWin({
			iconSrc : "icon/icon9.png",
			windowsId : "purchaseSupplyManagerDetail",
			windowTitle : "<i18n:I18n defaultValue='准入评估详情管理' key='i18n_common_title_Updateaccessmanagement'/>",
			iframSrc : "${pageContext.request.contextPath}/supplierstandard/purchase/purchaseSupplyManagerDetail.jsp?standardNumber="+standardNumber,
			showAdv : true,
			windowStatus : "regular",
			windowMinWidth : 960,
			windowMinHeight : 700,
			windowWidth : 960,
			windowHeight : 700,
			parentPanel : ".currDesktop"
		});
	});

	//发送
	$("#sendBtn").click(function(){
		var head = headTable.selectedRows();
		if(head.length<=0){
			alert('<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />',2);
			return;
		}
		//判断是否为当前用户
		if(head[0].person.split("_")[0]!=subAccount){
			alert('<i18n:I18n key="test" defaultValue="当前用户非单剧发起人" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus == "1"){
			alert('<i18n:I18n key="test" defaultValue="该单据已经发送" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus == "3"){
			alert('<i18n:I18n key="test" defaultValue="该单据已作废，无法发送" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus == "2"){
			alert('<i18n:I18n key="test" defaultValue="该单据已撤回，无法发送" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus == "4"){
			alert('<i18n:I18n key="test" defaultValue="销售方已回复，无法发送" />',2);
			return;
		}
		//判断发送状态
		if(head[0].sendStatus == "5"|| head[0].sendStatus =="6"){
			alert('<i18n:I18n key="test" defaultValue="已评分，无法发送" />',2);
			return;
		}
		if(head[0].auditStatus != "1"){
			alert('<i18n:I18n key="test" defaultValue="已提交审批，无法发送!" />',2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认准入发布？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_title_accessinformationrelease" defaultValue="准入信息发布中" />');
			var param= {"elsAccount":elsAccount,"toElsAccount": head[0].toElsAccount, "standardNumber": head[0].standardNumber,"sendStatus":head[0].sendStatus};
			$.ajax({
				url : '<%=basePath%>rest/SupplierStandardService/purchaseSendStandard',
				type : 'POST',
				contentType : "application/json",
				data : JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					headTable.load({});
					alert('<i18n:I18n key="test" defaultValue="发送成功!" />',1);
					console.log("success");
				},
				error : function(data) {
					if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	 				}
				},complete : function(data) {
					parent.elsDeskTop.hideLoading();
				}
			});
		}});
	});

	//参考模板新增
	/* 	$("#copyBtn").click(function(){
	 var head = headTable.selectedRows();
	 if(head.length != 1){
	 alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
	 return;
	 }
	 var standardNumber=head[0].standardNumber;
	 parent.elsDeskTop.defineWin({
	 iconSrc : "icon/icon9.png",
	 windowsId : "purchaseSupplyManagerCopy",
	 windowTitle : "<i18n:I18n defaultValue='参考模板新增' key='test'/>",
	 iframSrc : "${pageContext.request.contextPath}/supplierstandard/purchase/purchaseSupplyManagerCopy.jsp?standardNumber="+standardNumber,
	 showAdv : true,
	 windowStatus : "regular",
	 windowMinWidth : 960,
	 windowMinHeight : 700,
	 windowWidth : 960,
	 windowHeight : 700,
	 parentPanel : ".currDesktop"
	 });
	 }); */


	//删除
	$("#delBtn").click(function(){
		var head = headTable.selectedRows();
		if(head.length<=0){
			alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
			return;
		}
		//判断单据状态是否完成,如果完成,则不能删除 
		if(head[0].standardStatus == "4"){
			alert('<i18n:I18n key="test" defaultValue="该单据状态已完成,不可删除！" />',2);
			return;
		}

		//判断发送状态
		if(head[0].sendStatus != "0" && head[0].sendStatus != "2"){
			alert('<i18n:I18n key="test" defaultValue="该单据已经发送，不能删除！" />',2);
			return;
		}
		if(head[0].auditStatus != "1"){
			alert('<i18n:I18n key="test" defaultValue="已提交审批，不能删除!" />',2);
			return;
		}
		//判断是否为当前用户或管理员
		if(head[0].person.split("_")[0]!=subAccount && subAccount != "1001"){
			alert('<i18n:I18n key="test" defaultValue="当前用户非单剧发起人" />',2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_label_deleting" defaultValue="删除中" />');
			var param=head[0];
			var item = itemTable.rows();
			param["standardSupplierItemList"]=item;
			$.ajax({
				url : '<%=basePath%>rest/SupplierStandardService/deleteStandardSupplier',
				type : 'POST',
				contentType : "application/json",
				data : JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					headTable.load({});
					alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
				},
				error : function(data) {
					if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	 				}
				},
				complete : function(data) {
					parent.elsDeskTop.hideLoading();
				}
			});
		}});
	});

	//查询
	$("#queryHeadBtn").click(function(){
		var formObj = $("#queryForm").serializeJSON();
		formObj["elsAccount"]=elsAccount;
		headTable.opts.params = formObj;
		headTable.load({page:1});
	});
	
	//导出excel
	$("#downloadBtn").click(function(){
		var formObj = $("#queryForm").serializeJSON();
		formObj["elsAccount"]=elsAccount;
		headTable.opts.params = formObj;
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/SupplierStandardService/exportStandardToExcel",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(formObj),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + data.message;
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="" defaultValue="导出失败" />',3);
				}
			}
		});
	});

	//下拉
	/* $(".standardType").change(function(){
	 var formObj = $("#queryForm").serializeJSON();
	 formObj["elsAccount"]=elsAccount;
	 headTable.opts.params = formObj;
	 headTable.load({page:1});
	 }); */

	window.purchQuery = function() {
		headTable.load({});
	}

	//双击
	$('#headTable').on('dblclick','tr',function() {
		var standardItem = $('body').data('standardItem');
		var url='<%=basePath%>suppliermaindata/supplierMainDataManager.jsp?elsAccountNumber='+standardItem.toElsAccount;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
			'windowsId':'supplierMainDataManager',
			'windowTitle':'<i18n:I18n defaultValue="供应商主数据" key="test"></i18n:I18n>',
			'iframSrc':url,
			windowStatus: 'regular',
			windowMinWidth: 1200,
			windowMinHeight: 600,
			'windowWidth':1200,
			'windowHeight':600,
			windowPositionTop:40,
			'parentPanel':".currDesktop"
		});
	});

	//添加企业名称
	var addEnterpriseName = function(val,index){
		var selectRows = val;
		if(val.length>=6)
			autoGetEnterpriseName(selectRows,index);
	}

	//查询企业名称
	var autoGetEnterpriseName = function (val,index){
		if(val!=null&&val!=""){
			var elsAccount = val;
			var id ="#supplierElsDesc_" + index;
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
						$ (id).val(error);
					}
					if(data!=null&&data!="" ){
						enterpriseName =  data["fullName"];
						$ (id).val(enterpriseName);
					}
				},
				error: function (xhr, type, exception) {
					alert(xhr.responseText, "Failed");
				}
			});
		}
	}

	var colst_head =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchase_supply_header_mt"/>;
	
// 	var colst_head = [
// 		{ title:'<i18n:I18n key="i18n_common_title_standardNumber" defaultValue="准入单号" />', name:'standardNumber', width: 120, align: 'center'},
// 		{ title:'<i18n:I18n key="i18n_common_title_Accesstype" defaultValue="单据类型" />', name:'standardType' ,width:80, align:'center',renderer:initStandardType},
// 		{ title:'<i18n:I18n key="i18n_common_title_projectDesc" defaultValue="单据描述" />', name:'standardDesc' ,width:150, align:'center' },
// 		{ title:'<i18n:I18n key="i18n_common_title_applyDate" defaultValue="申请日期" />', name:'applyDate' ,width:80, align:'center', renderer:formatDate},
// 		{ title:'<i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />', name:'person' ,width:100, align:'center' },
// 		{ title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商els帐号" />', clickDisable:true, name:'toElsAccount' ,width:90, align:'center', renderer:initToElsAccount},
// 		{ title:'<i18n:I18n key="i18n_common_title_supplieelsDesc" defaultValue="供应商els名称" />', name:'supplierElsDesc' ,width:140, align:'center'},
// 		{ title:'<i18n:I18n key="i18n_common_title_Supplierlevel" defaultValue="供应商级别" />', name:'fbk1' ,width:70, align:'center'},
// 		{ title:'<i18n:I18n key="i18n_lable_deliverystatus" defaultValue="单据状态" />', name:'standardStatus' ,width:60, align:'center', renderer:initSendStatus},
// 		{ title:'<i18n:I18n key="i18n_common_auditmode" defaultValue="审批方式" />', name:'auditMode' ,width:70, align:'center', renderer:initAuditMode},
// 		{ title:'<i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />', name:'auditStatus' ,width:80, align:'center', renderer:initAuditStatus},
// 		{ title:'<i18n:I18n key="test" defaultValue="采购组" />', name:'purchaseGroup' ,width:100, align:'center'},
// 		{ title:'<i18n:I18n key="test" defaultValue="供应商分类" />', name:'groupName' ,width:100, align:'center', renderer:initGroupName},
// 		{ title:'<i18n:I18n key="test" defaultValue="ERP供应商编码" />', name:'vender' ,width:100, align:'center'},
// 		{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_totalscore" defaultValue="总评分" />', name:'totalScore' ,width:100, align:'center', renderer:initTotalScore},
// 		{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark' ,width:100, align:'center'},
// 		{ title:'<i18n:I18n key="i18n_password_title_updateUser" defaultValue="更新用户" />', name:'createUser' ,width:100, align:'center'}];
	if(standardNumber == "null"){
		standardNumber = "";
	}
	var GobalparamStr={"elsAccount":elsAccount,"standardNumber":standardNumber};
	var height=$(document).height()-155;
	headTable= $('#headTable').mmGrid({
		cols: colst_head,
		url: '<%=basePath%>rest/SupplierStandardService/queryStandardSupplierHeadByCondtion',
		params : GobalparamStr,
		method : 'post',
		root : "rows",
		loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		checkCol : true,
		indexCol : true,
		plugins : [
			$('#enquiryPage').mmPaginator({
				style: 'plain'
				, totalCountName: 'total'
				, page: 1
				, pageParamName: 'currentPage'
				, limitParamName: 'pageSize'
				, limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
				, totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
				, limit: null
				, limitList: [100, 50, 30 , 10]
			})
		]
	});

	headTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
		$('body').data('standardItem',item);
		rowIndexSelect=rowIndex;
		loadItem();
	});

	headTable.on('loadSuccess', function(e, data) {
		itemTable.removeRow();
		if (data.total > 0) {
			headTable.select(rowIndexSelect);
			loadItem();
		}
	});


	//企业基本信息  查看
	$('.elsAccountBtn').live("click", function() {
		var editCol = $(this).next().text();
		var headRow = JSON.parse(editCol);
		var url='<%=basePath%>account/regulationDisplayAccount.jsp';
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
			'windowsId':'PurchaseEnHisPrice',
			'windowTitle':'<i18n:I18n defaultValue="账户信息" key="i18n_account_title_accountInformation"></i18n:I18n>',
			'iframSrc':url,
			windowStatus: 'regular',
			windowMinWidth: 900,
			windowMinHeight: 600,
			'windowWidth':900,
			'windowHeight':600,
			windowPositionTop:0,
			'parentPanel':".currDesktop",
	        data:headRow
		});
	});


	//模板条例  查看
	$('.regulationDetailBtn').live("click", function() {
		var editCol = $(this).next().text();
		var headRows = JSON.parse(editCol);
		var url='<%=basePath%>regulation/regulationDetail.jsp?elsAccount='+elsAccount
				+ "&regulationNumber=" +  headRows.regulationNumber;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
			'windowsId':'regulationDetail',
			'windowTitle':'<i18n:I18n defaultValue="条例信息" key="test"></i18n:I18n>',
			'iframSrc':url,
			windowStatus: 'regular',
			windowMinWidth: 900,
			windowMinHeight: 500,
			'windowWidth':900,
			'windowHeight':500,
			windowPositionTop:40,
			'parentPanel':".currDesktop"
		});
	});


	//供应商条例选项 (查看供应的准入条例资料)
	$('.regulationCheckBtn').live("click", function() {
		var editCol = $(this).next().text();
		var headRows = JSON.parse(editCol);
		var url;
		if(headRows.participants == "purchese"){
			url='<%=basePath%>supplierstandard/sale/regulationCheck.jsp?toElsAccount='+elsAccount
			+ "&regulationNumber=" +  headRows.regulationNumber
			+ "&standardNumber=" + headRows.standardNumber
			+  "&standardItemNumber=" + headRows.standardItemNumber
			+ "&frameAppId=purchaseSupplyManager " ;
		}else{
			var url='<%=basePath%>regulation/regulationCheck.jsp?elsAccount='+elsAccount
					+ "&regulationNumber=" +  headRows.regulationNumber
					+ "&standardNumber=" + headRows.standardNumber
					+  "&standardItemNumber=" + headRows.standardItemNumber;
		}
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
			'windowsId':'regulationInfo',
			'windowTitle':'<i18n:I18n defaultValue="条例信息" key="test"></i18n:I18n>',
			'iframSrc':url,
			windowStatus: 'regular',
			windowMinWidth: 700,
			windowMinHeight: 500,
			'windowWidth':700,
			'windowHeight':500,
			windowPositionTop:40,
			'parentPanel':".currDesktop"
		});
	});
	
  	var cols_item =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchase_supply_item_mt"/>;

// 	 var cols_item = [
// 		{ title:'<i18n:I18n key="i18n_common_title_headerinformation" defaultValue="抬头信息" />', name:'standardNumber', width: 120, align: 'center',hidden:true},
// 		{ title:'<i18n:I18n key="i18n_common_title_standardItemNumber" defaultValue="准入单行号" />', name:'standardItemNumber', width: 120, align: 'center'},
// 		{ title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />', name:'templateNumber', width: 130, align: 'center'},
// 		{ title:'<i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />', name:'templateName', width: 150, align: 'center'},
// 		{ title:'<i18n:I18n key="i18n_common_title_templatedesc" defaultValue="模板描述" />', name:'templateDesc', width: 120, align: 'center'},
// 		{ title:'<i18n:I18n key="test" defaultValue="条例编号" />', name:'regulationNumber', width: 150, align: 'center', renderer: initModelRegulation},
// 		{ title:'<i18n:I18n key="test" defaultValue="条例名称" />', name:'regulationName', width: 150, align: 'center'},
// 		{ title:'<i18n:I18n key="test" defaultValue="条例明细" />', name:'regulationDetail', width: 150, align: 'center'},
// 		{ title:'<i18n:I18n key="i18n_common_title_participants" defaultValue="参与对象" />', name:'participants' ,width:70, align:'center',renderer: initParticipants},
// 		{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreType" defaultValue="评分类型" />', name:'scoreType', width: 130, align: 'center' ,renderer: initScoreType},
//      { title:'评分账户', name:'scoreAccount' ,width:200, align:'center' ,renderer:initScoreAccount},
// 		{ title:'<i18n:I18n key="i18n_assesstemplate_table_weight" defaultValue="权重%" />', name:'weight' ,width:100, align:'center'},
// 		{ title:'<i18n:I18n key="test" defaultValue="查看条例" />', name:'score' ,width:100, align:'center', renderer:ModelRegulationCheck },
// 		{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_score" defaultValue="评分结果" />', name:'score' ,width:100, align:'center', renderer: initInputNumber},
// 		{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreStandard" defaultValue="评分标准说明" />', name:'scoreStandard', width: 120, align: 'center'},
// 		{ title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />', name:'logtime' ,width:150, align:'center', renderer: formatDateTime}];

	itemTable = $('#itemTable').mmGrid({
		cols: cols_item,
		height: 300,
		loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
// 		checkCol: true,
		//multiSelect: true
	});

	//加载行
	var loadItem = function() {
		var obj = headTable.selectedRows();
		if(obj.length<=0){return;}
		var head = obj[0];
		$.ajax({
			url : '<%=basePath%>rest/SupplierStandardService/queryStandardSupplierItemByCondtion' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(head),
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

	//提交评分
	$("#scoreItemBtn").click(function(){
		var head = headTable.selectedRows();
		if(head.length<=0){
			alert('<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />',2);
			return;
		}
		var itemRows = itemTable.rows();
		// 判断是否是评分账户,非评分账户行移除提交
		var flag = false;
		for(var i= 0; i<itemRows.length; i++) {
			var fbk10s = itemRows[i].fbk10.split(",");
			for(var j=0 ;j<fbk10s.length;j++){
				if(elsSubAccount == fbk10s[j]){
					flag = true;
				}
			}
			if(!flag){
				itemTable.removeRow(i);
				itemRows.splice(i,1);
				i--;
			}
		}
		if(!flag){
			alert('<i18n:I18n key="test" defaultValue="不存在可评分条例，不能评分!" />',2);
			return;
		}
		// 当参与对象为销售方时
		for(var i= 0; i<=itemRows.length-1; i++) {
			if(itemRows[i].participants=="sale"){
				if(!(head[0].sendStatus == "4"||head[0].sendStatus == "5"||head[0].sendStatus == "6")){
					alert('<i18n:I18n key="test" defaultValue="未发送或销售方未回复，不能评分!" />',2);
					return;
				}
			}
		}
		if(head[0].auditStatus != "1"){
			alert('<i18n:I18n key="test" defaultValue="已提交审批或审批拒绝，不能评分!" />',2);
			return;
		}
		//赋值
		for(var i= 0,trs=itemTable.find('tr');i<=itemRows.length-1; i++) {
			var value =document.getElementsByName("score")[i].value;
			var remark =document.getElementsByName("remark")[i].value;
			itemRows[i].score = value;
			itemRows[i].remark = remark;
		}

		//权重%
		for(var i= 0; i<=itemRows.length-1; i++) {
			if(itemRows[i].weight===null || itemRows[i].weight===''){
				alert('<i18n:I18n key="test" defaultValue="权重%不能为空" />!',2);
				return;
			}
		}
		
		//评分结果
		for(var i= 0; i<=itemRows.length-1; i++) {
			if(itemRows[i].score===null || itemRows[i].score===''){
				alert('<i18n:I18n key="test" defaultValue="评分结果不能为空" />!',2);
				return;
			}
			if(itemRows[i].score > 100 || itemRows[i].score < 0){
				alert('<i18n:I18n key="test" defaultValue="评分结果数值超出范围" />!',2);
				return;
			}
		}

		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_selectscorerecord" defaultValue="是否确认评分选中记录?" />',closeEvent:function(){
			parent.elsDeskTop.showLoading('<i18n:I18n key="test" defaultValue="评分中" />');
			$.ajax({
				url: '<%=basePath%>rest/SupplierStandardService/scoreStandardSupplierItem' + "?t="+new Date().getTime(),
				type: 'POST',
				contentType: "application/json",
				data: JSON.stringify(itemRows),
				dataType: "json",
				success: function(data) {
					alert('<i18n:I18n key="test" defaultValue="评分成功!" />',1);
					headTable.load({});
				},
				error: function(data) {
					alert(data.message,3);
				},complete : function(data) {
					parent.elsDeskTop.hideLoading();
				}
			});
		}});
	});

	//文件下载(即查看)
	$('.fbk1Show').live("click", function(event) {

		var scanCol = $(this).next().text();
		var item = JSON.parse(scanCol);
		var data = item.fbk2+'_'+item.fbk3+'_'+ item.fbk1;

		var param = {"fileNumber":data,"elsAccount":elsAccount};

		$.ajax({
			url :"<%=basePath%>rest/ElsFileCenterService/findFileByNumberAndVersion",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert("请先上传文件！",2);
				}else{
					var rows = data.rows;
					var filePath = rows[0].filePath;
					var fileName = rows[0].fileName+"."+rows[0].fileType;
					window.location.href = "<%=basePath%>" + "servlet/download4OSSServlet?filePath=" + filePath+'&fileName='+fileName;
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				alert(exception,3);
			}
		});

	});

	//文件下载(即查看)
	$('.templatePathShow').live("click", function(event) {
		if (event && event.preventDefault) {
			event.preventDefault();
			event.stopPropagation();
		} else {
			window.event.returnValue = false;
		}

		var scanCol = $(this).next().text();
		var item = JSON.parse(scanCol);
		var data = item.fbk4+'_'+item.fbk5+'_'+ item.templatePath;

		var headRows = headTable.selectedRows();

		var param = {"fileNumber":data,"elsAccount":headRows[0].toElsAccount};

		$.ajax({
			url :"<%=basePath%>rest/ElsFileCenterService/findFileByNumberAndVersion",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert("请先上传文件！",2);
				}else{
					var rows = data.rows;
					var filePath = rows[0].filePath;
					var fileName = rows[0].fileName+"."+rows[0].fileType;
					window.location.href = "<%=basePath%>" + "servlet/download4OSSServlet?filePath=" + filePath+'&fileName='+fileName;
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				alert(exception,3);
			}
		});

	});




	//进入不同的模板
	$('.selectModel').live("click", function(event) {
		if (event && event.preventDefault) {
			event.preventDefault();
			event.stopPropagation();
		} else {
			window.event.returnValue = false;
		}
		//获取头项目的头信息供应商els编号 
		var head = headTable.selectedRows();
		var toElsAccount = head[0].toElsAccount;

		var scanCol = $(this).next().text();
		var item = JSON.parse(scanCol);
		var modelName = item.templateName;
		var standardNumber = item.standardNumber;
		var standardItemNumber = item.standardItemNumber;
		var load = false;
		if(modelName =="联系人资料"){
			srcPath =  '<%=basePath%>supplierstandard/data/supplierContactInfoView.jsp?standardNumber='
					+ standardNumber + '&standardItemNumber=' + standardItemNumber
					+ '&toElsAccount=' +  toElsAccount;
			load = true;
		}else if(modelName =="地址资料"){
			srcPath =  '<%=basePath%>supplierstandard/data/supplierCommunicationInfoView.jsp?standardNumber='
					+ standardNumber + '&standardItemNumber=' + standardItemNumber
					+ '&toElsAccount=' +  toElsAccount;
			load = true;
		}else if(modelName =="银行资料"){
			srcPath =  '<%=basePath%>supplierstandard/data/supplierBankInfoView.jsp?standardNumber='
					+ standardNumber + '&standardItemNumber=' + standardItemNumber
					+ '&toElsAccount=' +  toElsAccount;
			load = true;
		}else if(modelName =="认证资料"){
			srcPath =  '<%=basePath%>supplierstandard/data/supplierCertificateInfoView.jsp?standardNumber='
					+ standardNumber + '&standardItemNumber=' + standardItemNumber
					+ '&toElsAccount=' +  toElsAccount;
			load = true;
		}else if(modelName =="检验工厂"){
			testFactory(item);
		}else if(modelName =="检验样品"){
			testSample(item);
		}else{
			alert("找不到模板信息",2);
			return;
		}

		if(load){
			parent.elsDeskTop.defineWin({
				'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
				'windowsId':'showInfo',
				'windowTitle':modelName,
				'windowSubTitle': companyShortName,
				'iframSrc':srcPath,
				'showAdv': false,
				'windowStatus': 'regular',
				'windowMinWidth': 960,
				'windowMinHeight': 550,
				'windowPositionTop':20,
				'windowWidth':960,
				'windowHeight':550,
				'parentPanel':".currDesktop"
			});
		}

	});

	//检验工厂
	var testFactory = function(item){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认检验工厂？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading('<i18n:I18n key="test" defaultValue="检验工厂中" />');
			$.ajax({
				url : "<%=basePath%>rest/SupplierStandardService/testStandardFactory",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(item),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data.statusCode=="-100"){
						alert(data.message,2);
					}else{
						alert('<i18n:I18n key="test" defaultValue="检验成功!" />');
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

	//检验样品
	var testSample = function(item){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认检验样品？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading('<i18n:I18n key="test" defaultValue="检验中" />');
			$.ajax({
				url : "<%=basePath%>rest/SupplierStandardService/testStandardSample",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(item),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data.statusCode=="-100"){
						alert(data.message,2);
					}else{
						alert('<i18n:I18n key="test" defaultValue="检验成功!" />');
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

	//通过按钮
	$("#passBtn").click(function(){
		var headRows = headTable.selectedRows();
		if(headRows.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		//判断是否为当前用户
		if(headRows[0].person.split("_")[0]!=subAccount){
			alert('<i18n:I18n key="test" defaultValue="当前用户非单剧发起人" />',2);
			return;
		}
		if(headRows[0].auditMode != "3"){
			alert('<i18n:I18n key="test" defaultValue="审批方式非人工操作,不能通过!" />',2);
			return;
		}
		if(headRows[0].auditStatus != "1"){
			alert('<i18n:I18n key="test" defaultValue="审批已经提交,不能通过!" />',2);
			return;
		}
		var paramStr={"elsAccount":elsAccount,"toElsAccount":headRows[0].toElsAccount,"standardNumber":headRows[0].standardNumber};
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax(
					{ 
						url         : "<%=basePath%>rest/SupplierStandardService/passStandardHeader",
						type        : "post",
						contentType : "application/json",
						data 		  : JSON.stringify(paramStr),
						dataType    : "json",
						success     : function(data) {
							parent.elsDeskTop.hideLoading();
							alert('<i18n:I18n key="test"    defaultValue="审批通过" />');
							headTable.load({});
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							if (!permissionError(data)) {
			 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			 				}
						},
						complete : function(data) {
							headTable.load({});
						}
					});
		}
		});
	});

	 //查看流程
	$("#flowBtn").click(function(){
		var headRows      = headTable.selectedRows();
		var headRowsIndex = headTable.selectedRowsIndex();
		if(headRows.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		if(headRows[0].auditMode != "1"){
			alert('<i18n:I18n key="test" defaultValue="非审批流程方式，不能查看!" />',2);
			return;
		}
		if(headRows[0].auditStatus != "2"&&headRows[0].auditStatus != "0"&&headRows[0].auditStatus != "3"){
			alert('<i18n:I18n key="test" defaultValue="未提交审批，不能查看!" />',2);
			return;
		}
		var businessId = headRows[0].toElsAccount + "," + headRows[0].standardNumber ;
		parent.elsDeskTop.defineWin({
			'iconSrc'       : 'icon/els-icon.png' ,
			'windowsId'     : 'auditFlowList'     ,
			'windowTitle'   : '<i18n:I18n key="i18n_common_viewflow"    defaultValue="查看流程" />',
			windowSubTitle : ""                  ,
			'iframSrc'      : '<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=standardSupplier&businessId='+ businessId,
			showAdv        : true                ,
			advArr         : ['icon/test-car.png','icon/test-car2.png'] ,
			windowMinWidth : 480 ,
			windowMinHeight: 600 ,
			'windowWidth'   : 680 ,
			'windowHeight'  : 600 ,
			'parentPanel'   : ".currDesktop"
		});
	});

	//撤销审批
	$("#cancelEntryBtn").click(function(){
		var headRows = headTable.selectedRows();
		if(headRows.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		if(headRows[0].auditMode != "1"){
			alert('<i18n:I18n key="test" defaultValue="非审批流程方式，不能撤销!" />',2);
			return;
		}
		if(headRows[0].auditStatus != "2"){
			alert('<i18n:I18n key="test" defaultValue="未提交审批或审批拒绝，不能撤销!" />',2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : "<%=basePath%>rest/SupplierStandardService/cancelAudit",
				type: "post",
				contentType: "application/json",
				data: JSON.stringify(headRows[0]),
				dataType: "json",
				success: function(data) {
					alert(data.message,1);
					headTable.load({});
				},
				error : function(data) {
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				},complete : function(data) {
					parent.elsDeskTop.hideLoading();
				}
			});
		}
		});
	});

	//提交审批
	$("#entryBtn").click(function(){
			var headRows = headTable.selectedRows();
			if(headRows.length != 1){
				alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!"/>',2);
				return;
			}
			//判断是否为当前用户
			if(headRows[0].person.split("_")[0]!=subAccount){
				alert('<i18n:I18n key="test" defaultValue="当前用户非单剧发起人"/>',2);
				return;
			}
			if(headRows[0].auditMode != "1"){
				alert('<i18n:I18n key="test" defaultValue="非审批流程方式，不能提交!"/>',2);
				return;
			}
			if(headRows[0].auditStatus != "1"){
				alert('<i18n:I18n key="test" defaultValue="已提交审批或审批拒绝，不能提交!"/>',2);
				return;
			}
			if(headRows[0].sendStatus != "6"){
				alert('<i18n:I18n key="test" defaultValue="未全部评分，不能提交!"/>',2);
				return;
			}
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_confirmReportAudit" defaultValue="是否确定提交审批?" />',closeEvent:function(){
				$("body").data("headRowsJson",headRows);
				$("#sendMsgDialog").show();
			}});
	});

	//更新头
	$("#sendMsgBtnOK").click(function() {
		var headRows = $("body").data("headRowsJson")
		//提交赋值
		for(var i= 0; i<=headRows.length-1; i++) {
			//支持多个策略  begin  @jiangzhidong @date 20160428
			headRows[i].stretegyCode = $("#stretegyCode").val();
			//支持多个策略  begin  @jiangzhidong @date 20160428
			//上报意见  begin  @jiangzhidong @date 20160602
			headRows[i].remark = $("#msgArea").val();
			//上报意见  end  @jiangzhidong @date 20160602
		}
		parent.elsDeskTop.showLoading("上报中");
		$.ajax({
			url: "<%=basePath%>rest/SupplierStandardService/entryStandardSupplier",
			type: "post",
			contentType: "application/json",
			data: JSON.stringify(headRows[0]),
			dataType: "json",
			success: function(data) {
				$("#sendMsgDialog").hide();
				//支持多个策略  begin  @jiangzhidong @date 20160428
				if (data.rows) {
					showStretegySelector(data.rows);
					return;
				}
				$('#dialog2').hide();
				//支持多个策略  end  @jiangzhidong @date 20160428
				alert(data.message,1);
				headTable.load({});
			},
			error: function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
				parent.elsDeskTop.hideLoading();
			},complete : function(data) {
				parent.elsDeskTop.hideLoading();
			}
		});
	});
	
	//支持多个策略  begin  @jiangzhidong @date 20160428
	function showStretegySelector(stretegyList) {
		$(".dialog-tip").height(40);
		var html = "";
		for (var i=0;i<stretegyList.length;i++){
			html += "<option value='"+stretegyList[i].stretegyCode+"'>"+stretegyList[i].stretegyName+"</option>";
		}
		$("#stretegySelctor").empty().html(html);
		$('#dialog2').show();
		$("#btnFileOK2").unbind("click").click(function(){
			$("#stretegyCode").val($("#stretegySelctor").val());
			$("#sendMsgBtnOK").click();
		});
	}
	$('.dialog-close-btn').click(function(){
	    $('.fixed-dialog').hide();
	});
	$('.tip-option-btn').click(function(){
	    $('.dialog-close-btn').trigger('click');
	});
	//支持多个策略 end @jiangzhidong @date 20160428
	
	//显示当前待审批节点 @author jiangzhidong @date 20160524  begin
	$('.flowBtn').live("click", function() {
	    var scanCol = $(this).next().text();
	    var head = JSON.parse(scanCol);
		var targetElsAccount = head.elsAccount;
		var businessType = "standardSupplier";
		var businessId = head.toElsAccount+","+head.standardNumber;
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'auditFlowList',
	        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
	        windowMinWidth: 480,
	        windowMinHeight: 600,
	        'windowWidth':680,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	//显示当前待审批节点 @author jiangzhidong @date 20160524  end
	

	//回写ERP
	$("#uploadToERP").click(function(){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'确认要发送到ERP吗？',closeEvent:function(){
			var headRows      = headTable.selectedRows();
			var headRowsIndex = headTable.selectedRowsIndex();
			if(headRows.length != 1){
				alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
				return;
			}
			if(!(headRows[0].toElsAccount != null&&headRows[0].toElsAccount != '')){
				alert('<i18n:I18n key="test" defaultValue="供应商ELS账号不能空,才执行操作!" />',2);
				return;
			}
			parent.elsDeskTop.defineWin({
				'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
				'windowsId':'supplierMainDataUpd',
				'windowTitle':'<i18n:I18n defaultValue="供应商主数据" key="test"></i18n:I18n>',
				'iframSrc':'<%=basePath%>suppliermaindata/supplierMainDataUpd.jsp?elsAccount=' + elsAccount
				+"&toElsAccount=" + headRows[0].toElsAccount
				+"&vender=" +headRows[0].supplierMainDataVO.vender,
				windowStatus: 'regular',
				windowMinWidth: 1000,
				windowMinHeight: 600,
				'windowWidth':1000,
				'windowHeight':600,
				windowPositionTop:40,
				'parentPanel':".currDesktop"
			});
			$.ajax({
				url: "<%=basePath%>rest/SupplierStandardService/sendStandardInfoToERP",
				type: "post",
				contentType: "application/json",
				data: JSON.stringify(headRows[0]),
				dataType: "json",
				success: function(data) {
					parent.elsDeskTop.hideLoading();
					alert('<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />');
					headTable.load({});
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert('<i18n:I18n key="i18n_common_alert_requestfail"    defaultValue="请求出错" />',3);
				}
			});
		}});
	});
	//回调
	function selectCallbackFunc(){
		loadItem();
	}
</script>
</body>
</html>