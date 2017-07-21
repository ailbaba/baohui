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
				<button class="button-wrap" id="queryHeadBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
<%-- 				<button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button> --%>
				<button class="button-wrap" id="sendBtn"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<form id="queryForm">
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
					<span><i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />:</span>
					<input type="text" id="person" name="person" />
				</div>
				<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="客户ELS账号" />:</span>
				<input type="text" id="toElsAccount" name="toElsAccount" />
				</div>
				<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="客户ELS名称" />:</span>
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
					<span><i18n:I18n key="i18n_lable_fbk2" defaultValue="审批状态" />:</span>
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
				
				<%-- <div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_lable_deliverystatus" defaultValue="单据状态" />:</span>
					<select class="standardStatus" id="standardStatus" name="standardStatus">
						<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
						<option value="0"><i18n:I18n key="i18n_common_button_create" defaultValue="新建" /></option>
						<option value="1"><i18n:I18n key="i18n_requirementsPlanning_select_carriedOut" defaultValue="进行中" /></option>
						<option value="2"><i18n:I18n key="i18n_label_alreadyFinish" defaultValue="完成" /></option>
						<option value="3"><i18n:I18n key="i18n_js_close" defaultValue="关闭" /></option>
					</select>
				</div>
				<br> --%>
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
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_headerinformation" defaultValue="抬头信息" /></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_requirementsPlanning_table_projectInformation" defaultValue="项目信息(表单文件)" /></span>
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
	
<script>
	var headTable           ;
	var itemTable           ;
	var type           = "" ;
	var roleCode       = "" ;
	var elsAccount     = "<%=session.getAttribute("elsAccount")%>"       ;
	var companyName    = "<%=session.getAttribute("companyShortName")%>" ;
	var standardNumber='<%=standardNumber%>';
	var rowIndexSelect = 0  ;
	var excelUploader       ;
	var rowIndex;
	var selectFbk1;
	var loadItem;
	 
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
		//允许任何字符输入框 只读
		var initInputAny2 = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" readonly="readonly" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		//企业名称
	    var initCompanyName = function (val, item, index){
	    	if(!val) { val = '';}
	    	var name = this.name;
	    	var value = this.value;
			return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
	    }
		//日期input
		var formatDateInput = function (val, item, index){
			if (!val) {val = "";}
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
			return '<input name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
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
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
			return val;
		};
		//通过状态
		var initPass = function (val,item,index){
			//0 未通过 1 通过 
			if (val == "0") return '<span><i18n:I18n key="test" defaultValue="未通过" /></span>';
			else if (val == "1") return '<span style="color:green;"><i18n:I18n key="test" defaultValue="通过" /></span>';
		};
		//发送状态
		var initSendStatus = function (val,item,index){
			//0:未发送 1:已发送2：已撤回3：已作废
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
		//单据状态 0:新建 1:销售方填写中 2:采购方评估中 3:待审批中 4:审批中
		var initStandardStatus = function (val,item,index){
			if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />'
			else if (val == "1") return '<i18n:I18n key="i18n_common_fillIn" defaultValue="填写中" />';
			else if (val == "2") return '<i18n:I18n key="i18n_common_inEvaluation" defaultValue="评估中" />';
			else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
		};
		//审批状态  0:审批通过  1:未审批  2:审批中  3:审批拒绝
		var initAuditStatus = function (val,item,index){
			if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" />'
			else if (val == "1") return '<i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" />'
			else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
			else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" />';
		};
		//供应商els帐号
		var initToElsAccount = function (val,item,index){
			return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		};
		
		
		//渲染模板名称进入不同模板界面 
		var selectModel = function(val,item,index){
			if(val!="银行资料 "){
				return val+'<span class="selectModel" style="color:blue;">&nbsp;编辑</span><span style="display: none;">'+JSON.stringify(item) +'</span>';
			}
		}
		
		var initParticipants = function(val,item,index) {
			if (val == "sale") return '<i18n:I18n key="test" defaultValue="销售方" />';
			else if (val == "purchese") return '<i18n:I18n key="test" defaultValue="采购方" />';
		};
		
		var initWriteStatus = function(val,item,index) {
			if (val == "1") {
				return '<i18n:I18n key="test" defaultValue="已填写" />';
			}else {
			    return '<i18n:I18n key="test" defaultValue="未填写" />';
			}
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
		//准入类型  1:新增准入 2:变更准入 3:公开招投标准入 4:新增准入模板 5:变更准入 模板
		var initStandardType = function (val,item,index){
			     if (val == "1") return '<i18n:I18n defaultValue='新增准入' key='test'/>'   ;
			else if (val == "2") return '<i18n:I18n defaultValue='变更准入' key='test'/>'   ;
			else if (val == "3") return '<i18n:I18n defaultValue='公开招标准入' key='test'/>' ;
			else if (val == "4") return '<i18n:I18n defaultValue='新增准入模板' key='test'/>'   ;
			else if (val == "5") return '<i18n:I18n defaultValue='变更准入模板' key='test'/>'   ;
			else if (val == "6") return '<i18n:I18n defaultValue='新增评估' key='test'/>'   ;
		};
		//总评分  人工
		var initTotalScore = function(val, item, index){
			if (!val) {val = "";}
			return '<div style="color: red;">' +val+ '</div>';
		};
		//查看准入条例
		var ModelRegulationCheck  = function (val,item,index){
			return '<span class="regulationCheckBtn" style="color:blue;">客户条例选项</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		};
		//模板条例明细 
		var initModelRegulation  = function (val,item,index){
			return '<span class="regulationDetailBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		};
	 // 渲染   @author jiangzhidong 20160120  end		
		
		var colst_head = [{ title:'<i18n:I18n key="i18n_common_title_standardNumber" defaultValue="准入评估单号" />', name:'standardNumber', width: 120, align: 'center'},
		  	        	  { title:'<i18n:I18n key="i18n_common_title_businesstype" defaultValue="单据类型" />', name:'standardType' ,width:100, align:'center',renderer:initStandardType},
		  	        	  { title:'<i18n:I18n key="i18n_common_title_projectDesc" defaultValue="单据描述" />', name:'standardDesc' ,width:150, align:'center' },
		  	        	  { title:'<i18n:I18n key="test" defaultValue="单据状态" />', name:'sendStatus' ,width:60, align:'center', renderer:initSendStatus},
		  	        	{ title:'<i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />', name:'auditStatus' ,width:80, align:'center', renderer:initAuditStatus},
		  	        	  { title:'<i18n:I18n key="i18n_common_title_applyDate" defaultValue="申请日期" />', name:'applyDate' ,width:80, align:'center', renderer:formatDate,sortable:true},
		  	        	  { title:'<i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />', name:'person' ,width:100, align:'center' },
		  	        	  { title:'<i18n:I18n key="test" defaultValue="客户els帐号" />', clickDisable:true, name:'toElsAccount' ,width:90, align:'center', renderer:initToElsAccount},
		  	        	  { title:'<i18n:I18n key="test" defaultValue="客户els名称" />', name:'supplierElsDesc' ,width:140, align:'center'},
		  	        	  { title:'<i18n:I18n key="i18n__supplierrassessreport_table_totalscore" defaultValue="总评分" />', name:'totalScore' ,width:100, align:'center', renderer:initTotalScore},
		  	        	  { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark' ,width:100, align:'center'},
		  	        	  { title:'<i18n:I18n key="i18n_password_title_updateUser" defaultValue="更新用户" />', name:'createUser' ,width:100, align:'center'}];
		 if(standardNumber == "null"){
			 standardNumber = "";
		 }
		var GobalparamStr={"elsAccount":elsAccount,"standardNumber":standardNumber};
		var height=$(document).height()-155;
		headTable= $('#headTable').mmGrid({
			cols        : colst_head    ,
			url         : '<%=basePath%>rest/SupplierStandardService/saleStandardSupplierHeadByCondtion',
			params      : GobalparamStr ,
			method      : 'post'        ,
			root        : "rows"        ,
			loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			multiSelect : false         ,
			checkCol    : true          ,
			indexCol    : false         ,
			plugins     : [ $('#enquiryPage').mmPaginator({
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

		 var cols_item = [{ title:'<i18n:I18n key="i18n_common_title_headerinformation" defaultValue="抬头信息" />', name:'standardNumber', width: 120, align: 'center',hidden:true},
		                { title:'<i18n:I18n key="i18n_common_title_standardItemNumber" defaultValue="准入评估单行号" />', name:'standardItemNumber', width: 120, align: 'center',hidden:true},
		  	            { title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />', name:'templateNumber', width: 130, align: 'center'},
		  	            { title:'<i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />', name:'templateName', width: 150, align: 'center'},
		  		        { title:'<i18n:I18n key="i18n_common_title_templatedesc" defaultValue="模板描述" />', name:'templateDesc', width: 120, align: 'center'},
		  		     	{ title:'<i18n:I18n key="test" defaultValue="条例编号" />', name:'regulationNumber', width: 150, align: 'center',renderer: initModelRegulation},
		  	         	{ title:'<i18n:I18n key="test" defaultValue="条例名称" />', name:'regulationName', width: 150, align: 'center'},
		  		        { title:'<i18n:I18n key="i18n_common_title_participants" defaultValue="参与对象" />', name:'participants' ,width:70, align:'center',renderer: initParticipants},
		  		        { title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreType" defaultValue="评分类型" />', name:'scoreType', width: 130, align: 'center',renderer: initScoreType}, 
		  		        { title:'<i18n:I18n key="test" defaultValue="条例选项" />', name:'scoreType', width: 130, align: 'center',renderer:ModelRegulationCheck},
		  		    	{ title:'<i18n:I18n key="test" defaultValue="填写状态" />', name:'fbk11', width: 130, align: 'center', renderer:initWriteStatus},
		  				{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreStandard" defaultValue="评分标准说明" />', name:'scoreStandard', width: 120, align: 'center'},
		  				{ title:'<i18n:I18n key="i18n_assesstemplate_table_weight" defaultValue="权重%" />', name:'weight' ,width:100, align:'center'},
		  				{ title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />', name:'logtime' ,width:150, align:'center', renderer: formatDateTime}];
		  				 
		itemTable = $('#itemTable').mmGrid({
			cols: cols_item,
			height: 300,
			loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			checkCol: true,
			multiSelect: true
		});
			 
		//加载行
		loadItem = function() {
			var obj = headTable.selectedRows();
 	    	if(obj.length<=0){return;}
	 	    var head = obj[0];
	 	    head["participants"] = "sale";//只查询销售方
			$.ajax({
			 	url         : '<%=basePath%>rest/SupplierStandardService/queryStandardSupplierItemByCondtion' + "?t="+new Date().getTime(),
			 	type        : 'POST',
			 	contentType : "application/json",
			 	data        : JSON.stringify(head),
			 	dataType    : "json",
			 	success     : function(data) {
			 		itemTable.load(data.rows);
			 	},
			 	error       : function(data) {
			 		if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	 				}
			 	}
			}); 		 
		}
		headTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
			rowIndexSelect=rowIndex;
			loadItem();
		});
	  	 
		headTable.on('loadSuccess', function(e, data) {
			if (data.total > 0) {
				headTable.select(rowIndexSelect);
				loadItem();
			} 
		});
		 
	});
	
	
	//模板条例  查看
	$('.regulationDetailBtn').live("click", function() {
		var headRow = headTable.selectedRows();
		var toElsAccount  = headRow[0].toElsAccount;
		var editCol = $(this).next().text();
		var headRows = JSON.parse(editCol);
		var url='<%=basePath%>regulation/regulationDetail.jsp?elsAccount='+toElsAccount
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
		//根据采购方的条例去查询条例 ,所以需要采购方的els账号 
		var headRow = headTable.selectedRows();
		var toElsAccount  = headRow[0].toElsAccount;
		var editCol = $(this).next().text();
		var headRows = JSON.parse(editCol);
		var url='<%=basePath%>supplierstandard/sale/regulationCheck.jsp?toElsAccount='+toElsAccount
				+ "&regulationNumber=" +  headRows.regulationNumber
				+ "&standardNumber=" + headRows.standardNumber
				+  "&standardItemNumber=" + headRows.standardItemNumber
				+ "&frameAppId=saleSupplyManager" ;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
	        'windowsId':'regulationInfo',
	        'windowTitle':'<i18n:I18n defaultValue="条例资料" key="test"></i18n:I18n>',
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
	
	//回调
	function selectCallbackFunc(){
		loadItem();
	}
	
	//查询
	$("#queryHeadBtn").click(function(){
	    var formObj = $("#queryForm").serializeJSON();
		formObj["elsAccount"]=elsAccount;
		headTable.opts.params = formObj;
		headTable.load({page:1});
	});
	
	//下拉
	/* $(".standardType").change(function(){
	    var formObj = $("#queryForm").serializeJSON();
		formObj["elsAccount"]=elsAccount;
		headTable.opts.params = formObj;
		headTable.load({page:1});
	}); */
	

	//保存
	$("#saveBtn").click(function(){
		debugger;
		 var head = headTable.selectedRows();
		 if(head.length<=0){
			 alert('<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />',2);
			 return;
		 }
		 parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
		     parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_requirementsPlanning_alert_inTheSave" defaultValue="保存中" />');
		     var param=head[0];
			 var itemRows = itemTable.rows();
			 for(var i= 0; i<=itemRows.length-1; i++) {
				 var templatePath =document.getElementsByName("templatePath")[i].getAttribute("value");
				 itemRows[i].templatePath = templatePath;
				 var fbk4 =document.getElementsByName("fbk4")[i].getAttribute("value");
				 itemRows[i].fbk4 = fbk4;
				 var fbk5 =document.getElementsByName("fbk5")[i].getAttribute("value");
				 itemRows[i].fbk5 = fbk5;
			 }
			 param["standardSupplierItemList"]=itemRows;				 
	 		 $.ajax({
	 			url : '<%=basePath%>rest/SupplierStandardService/saveStandardSupplier',
	 			type : 'POST',
	 			contentType : "application/json",
	 			data : JSON.stringify(param),
	 			dataType : "json",
	 			success : function(data) {
	 				headTable.load({});
	 				alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
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
	
	
	//发送
	$("#sendBtn").click(function(){
		 var head = headTable.selectedRows();
		 var itemRows = itemTable.rows();
		 if(head.length<=0){
			 alert('<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />',2);
			 return;
		 }
		 if(head[0].sendStatus=="2"){
			 alert('<i18n:I18n key="test" defaultValue="该准入单已被采购方撤回！" />',2);
			 return;
		 }
		 if(head[0].sendStatus=="1"){
			 alert('<i18n:I18n key="test" defaultValue="该准入单已发送！" />',2);
			 return;
		 }
		 if(head[0].sendStatus=="3"){
			 alert('<i18n:I18n key="test" defaultValue="该准入单已作废！" />',2);
			 return;
		 }
		 if(head[0].sendStatus=="4"){
			 alert('<i18n:I18n key="test" defaultValue="该准入单已回复！" />',2);
			 return;
		 }
		 if(head[0].sendStatus=="5"){
			 alert('<i18n:I18n key="test" defaultValue="该准入单已评分！" />',2);
			 return;
		 }
		//填写状态验证
		for(var i= 0; i<=itemRows.length-1; i++) {
			if(itemRows[i].fbk11 !="1"){
				alert('<i18n:I18n key="test" defaultValue="存在未填写条例！" />!',2);
				return;
			}
		}
		 debugger;
		 parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认准入发布？" />',closeEvent:function(){
		     parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_title_accessinformationrelease" defaultValue="准入信息发布中" />');
		     var param= {"elsAccount":elsAccount,"toElsAccount": head[0].toElsAccount, "standardNumber": head[0].standardNumber};
	 		 $.ajax({
	 			url : '<%=basePath%>rest/SupplierStandardService/supplierSendStandard',
	 			type : 'POST',
	 			contentType : "application/json",
	 			data : JSON.stringify(param),
	 			dataType : "json",
	 			success : function(data) {
	 				headTable.load({});
	 				alert('<i18n:I18n key="test" defaultValue="发送成功!" />',1);
	 			}, 	
	 			error : function(data) {
	 				if (!permissionError(data)) {
	 					alert(data.message,3);
	 				}
	 			},complete : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
	 		 });
		 }});
	});
	
	//进入不同的模板
	$('.selectModel').live("click", function(event) {
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }

	    var scanCol = $(this).next().text();
        var item = JSON.parse(scanCol);
        var modelName = item.templateName;
        var standardNumber = item.standardNumber;
        var standardItemNumber = item.standardItemNumber;
        console.log("模板号 :" + standardNumber + "   模板子项目号:"  + standardItemNumber);
        if(modelName =="联系人资料"){
        	windowsId = "supplierContactInfoManage";
    		srcPath =  '<%=basePath%>supplierstandard/data/supplierContactInfoManage.jsp?standardNumber='
				+ standardNumber + '&standardItemNumber=' + standardItemNumber;
    	}else if(modelName =="地址资料"){
    		windowsId = "supplierCommunicationInfoManage";
    		srcPath =  '<%=basePath%>supplierstandard/data/supplierCommunicationInfoManage.jsp?standardNumber='
				+ standardNumber + '&standardItemNumber=' + standardItemNumber;
    	}else if(modelName =="银行资料"){
    		windowsId = "supplierBankInfoManage";
    		srcPath =  '<%=basePath%>supplierstandard/data/supplierBankInfoManage.jsp?standardNumber='
				+ standardNumber + '&standardItemNumber=' + standardItemNumber;
    	}else if(modelName =="认证资料资料"){
    		windowsId = "supplierCertificateInfoManage";
    		srcPath =  '<%=basePath%>supplierstandard/data/supplierCertificateInfoManage.jsp?standardNumber='
				+ standardNumber + '&standardItemNumber=' + standardItemNumber;
    	}else{
    		alert("找不到模板信息",2);
    		return;
    	}
		
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
	        'windowsId':windowsId,
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
	
</script>
	
</body>
</html>	