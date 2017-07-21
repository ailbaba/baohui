<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body> 
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
		    <input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsSubAccount")%>"/>
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="queryHeadBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
				<button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
                <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
                 <base:auditConfig elsAccount="${elsAccount}" businessType="bargainEnquiry">
					<button id="entryBtn" class="button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批" /></button>
					<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
					<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button>
				</base:auditConfig>
                <button class="button-wrap" id="generatePdfBtn"><i18n:I18n key="i18n_common_title_generatePDF" defaultValue="生成PDF" /></button>
                <button class="button-wrap" id="previewPdfBtn"><i18n:I18n key="i18n_common_title_PreviewPDF" defaultValue="预览PDF" /></button>
                <button class="button-wrap" id="downPdfBtn"><i18n:I18n key="i18n_common_title_DownloadPDF" defaultValue="下载PDF" /></button>
			</div>
		</div>
		
		<form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_contractcode" defaultValue="合同编码" /></span>
					<input type="text" id="contractNumber" name="contractNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_contracName" defaultValue="合同名称" />:</span>
					<input type="text" id="contractDesc" name="contractDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_contracName" defaultValue="创建人" />:</span>
					<input type="text" id="createUser" name="createUser" />
				</div>
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
		</div>
		</form>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="表头信息" /></span>
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
		
				<div class="tab-wrap" id="add-enq-sheet">
					<ul>
						<li><a href="#edit-line-bail"><i18n:I18n key="i18n_common_title_billofmaterials" defaultValue="物料清单" /></a></li>
						<li class="edit-line-content"><a href="#edit-line-content"><i18n:I18n key="i18n_common_title_contractterms" defaultValue="合同条款" /></a></li>
					</ul>
					<!-- 物料清单-->
				   <div id="edit-line-bail" style="padding: 0;">
				    <div class="box-wrap pos-relative bg-common" style="padding: 0;">
				            <div class="common-box-line">
				                <div class="tab-wrap" id="sheet-project">
				                    <div id="sheet-project-one">
				                         <main class="grid-container nest-table">
						                    <div class="grid-100" id="reCreate">
						                        <table id="materialTable"></table>
						                    </div>
						                </main>
				                    </div>
				                </div>
				            </div></div>
				</div>
					
					<!-- 合同条款 -->
					<div id="edit-line-content" style="padding: 0;">
					 <div class="box-wrap pos-relative bg-common" style="padding: 0;">
				            <div class="common-box-line">
				                <div class="tab-wrap" id="sheet-project">
				                    <div id="sheet-project-one">
				                         <main class="grid-container nest-table">
						                    <div class="grid-100" id="reCreate">
						                        <table id="clauseTable"></table>
						                    </div>
						                </main>
				                    </div>
				                </div>
				            </div></div>
					</div>
					
				</div>
		
	</div>

	<script>
	$( '#add-enq-sheet').tabs();
	 var headTable;
	 var materialTable;
	 var clauseTable;
	 var type="";
	 var roleCode="";
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	 var rowIndexSelect=0;
	 var excelUploader;
	
	 //初始化记载信息 
	 $(document).ready(function(){
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
	 
	   //查看按钮
		function enquiryHandle(val, item, rowIndex){
			return '<span class="enquiry-detail" style="color:blue;"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		}
		
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
		//日期input
		var formatDateInput = function (val, item, index){
			if(!val) { val = '';}
			return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
		};
		//允许任何字符输入框  readonly
		var initInputAnyReadonly = function(val, item, index){
			if(!val) { val = '';}
			return '<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
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
		//供应商els帐号
		var initSupplierElsAccount = function (val,item,index){
			return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		};
		
		//合同状态
		var initAuditStatus = function (val,item,index){
			//0:审批通过  1:未审批  2:审批中  3:审批拒绝
			if (val == "0") return '<i18n:I18n key="i18n_common_button_create" defaultValue="新建" />'
			else if (val == "1") return '<i18n:I18n key="i18n_requirementsPlanning_select_carriedOut" defaultValue="进行中" />'
			else if (val == "2") return '<i18n:I18n key="i18n_common_title_contractsigning" defaultValue="合同签订" />';
			else if (val == "3") return '<i18n:I18n key="i18n_js_close" defaultValue="关闭" />';
		};
		//合同状态 select
		var initcontractStatusSelect = function(val,item,index) {
			if(item.auditMode==3){
				var sel=' selected="true"';
				var selected = '<select name="auditStatusSelect" id="auditStatusSelect" style="color:blue; min-width:70px;"><option value="0"';
				if(val==0) selected = selected +sel;
				selected =selected + '><i18n:I18n key="i18n_common_button_create" defaultValue="新建" /></option><option value="1"'
				if(val==1) selected = selected +sel;
				selected =selected + '><i18n:I18n key="i18n_requirementsPlanning_select_carriedOut" defaultValue="进行中" /></option><option value="2"'
				if(val==2) selected = selected +sel;
				selected =selected + '><i18n:I18n key="i18n_common_title_contractsigning" defaultValue="合同签订" /></option><option value="3"'
				if(val==3) selected = selected +sel;
				selected =selected + '><i18n:I18n key="i18n_js_close" defaultValue="关闭" /></option></select>'
				return selected;
			}
			return initAuditStatus(val,item,index);
		};
		
	 // 渲染   @author jiangzhidong 20160120  end
	 
	  //新增
	 $("#addBtn").click(function(){
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "contractManagerAdd",
			        windowTitle : "<i18n:I18n defaultValue='新建合同管理' key='i18n_contract_title_createcontractmanagement'/>",
			        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/contractManagerAdd.jsp",
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
			});
	 
	    //查看
		$('.enquiry-detail').live("click", function() {
	         var scanCol = $(this).next();
	         
	         var sanContent = scanCol.text();
	         var item = JSON.parse(sanContent);
	         
        	//兼容ie 冒泡事件
		    if (event && event.preventDefault) {
		        event.preventDefault();
		        event.stopPropagation();
		    } else {
		        window.event.returnValue = false;
		    }
		    parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
		        'windowsId':'contractManagerDetail',
		        'windowTitle':'<i18n:I18n key="i18n_common_title_contracdetailcheck" defaultValue="合同明细查看" />',
		        windowSubTitle: companyShortName,
		        'iframSrc':'<%=basePath%>contractmanage/purchase/contractManagerDetail.jsp?contractNumber='+item.contractNumber,
		        showAdv: false,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
        	
	     });
		
	 
	   //修改
	   $("#updBtn").click(function(){
		   var head = headTable.selectedRows();
			 if(head.length<=0){
				 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
				 return;
			 }
	 	    var contractNumber=head[0].contractNumber;
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "contractManagerUpd",
			        windowTitle : "<i18n:I18n defaultValue='修改合同管理' key='i18n_contract_title_modifycontractmanagement'/>",
			        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/contractManagerUpd.jsp?contractNumber="+contractNumber,
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
		});
	 

		//删除
		$("#delBtn").click(function(){
			 var head = headTable.selectedRows();
			 if(head.length<=0){
				 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
				 return;
			 }
			 parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
				    parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_label_deleting" defaultValue="删除中" />');
				    var param=head[0];
					 var clause = clauseTable.rows();
					 param["contractManageClauseVODelList"]=clause;
					 var material = materialTable.rows();
					 param["contractManageMaterialVODelList"]=material;
			 		 $.ajax({
			 			url : '<%=basePath%>rest/ContractManageService/deleteContractManage',
			 			type : 'POST',
			 			contentType : "application/json",
			 			data : JSON.stringify(param),
			 			dataType : "json",
			 			success : function(data) {
			 				headTable.load({});
			 				alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
			 			},
			 			error : function(data) {
			 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="删除失败!" />',3);
			 			},complete : function(data) {
			    			parent.elsDeskTop.hideLoading();
			    		}
			 		 });
			 }});
		});
		
	//生成PDF
	$("#generatePdfBtn").click(function(){
		 var head = headTable.selectedRows();
		 if(head.length<=0){
			 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
			 return;
		 }
		 parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认生成PDF？" />',closeEvent:function(){
			     parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_title_generatingPDF" defaultValue="生成PDF中" />');
			     var param=head[0];
				 var clause = clauseTable.rows();
				 param["contractManageClauseVOList"]=clause;
				 var material = materialTable.rows();
				 param["contractManageMaterialVOList"]=material;
		 		 $.ajax({
		 			url : '<%=basePath%>rest/ContractManageService/generalContract',
		 			type : 'POST',
		 			contentType : "application/json",
		 			data : JSON.stringify(param),
		 			dataType : "json",
		 			success : function(data) {
		 				if("200"==data.statusCode){
			 				alert('<i18n:I18n key="i18n_common_title_generatePDFsuccess" defaultValue="生成PDF成功!" />',1);
			 				var formObj = $("#queryForm").serializeJSON();
							formObj["elsAccount"]=elsAccount;
							headTable.opts.params = formObj;
							headTable.load({page:1});
		 				} else {
		 					alert(data.message);
		 				}
		 			},
		 			error : function(data) {
		 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="生成PDF失败!" />',3);
		 			},complete : function(data) {
		    			parent.elsDeskTop.hideLoading();
		    		}
		 		 });
		 }});
	});
		
	//预览PDF
	$("#previewPdfBtn").click(function(){
		 var head = headTable.selectedRows();
		 if(head.length<=0){
			 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
			 return;
		 }
		 var param=head[0];
		 var filePath = param.fbk1;
		 if("undefined" != filePath && "" != filePath){
			 window.open("${pageContext.request.contextPath}/contractmanage/purchase/previewPdf.jsp?filePath="+filePath);
			 //window.location.href = "${pageContext.request.contextPath}/contractmanage/purchase/previewPdf.jsp?filePath="+filePath;
		 } else {
			 alert("<i18n:I18n key="i18n_common_title_PDF_contract_not_exist" defaultValue="PDF合同不存在" />",2);
		 }
	});
		
	//下载PDF
	$("#downPdfBtn").click(function(){
		 var head = headTable.selectedRows();
		 if(head.length<=0){
			 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
			 return;
		 }
		 var param=head[0];
		 var filePath = param.fbk1;
		 if("undefined" != filePath && "" != filePath){
			 window.location.href = "${pageContext.request.contextPath}/servlet/downloadServlet?filePath="+filePath;
		 } else {
			 alert("<i18n:I18n key="i18n_common_title_PDF_contract_not_exist" defaultValue="PDF合同不存在" />",2);
		 }
	});
	 
	 //查询
	 $("#queryHeadBtn").click(function(){
		 var formObj = $("#queryForm").serializeJSON();
		 formObj["elsAccount"]=elsAccount;
		 
		 headTable.opts.params = formObj;
		 headTable.load({page:1});
	 });
	 
	window.purchQuery = function() {
		headTable.load({});
	}

  
	   //===========================================表头===========================================
	   var colst_head = [{name:'operation',title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />',width:60, align:'center',renderer: enquiryHandle},
	                    { title:'<i18n:I18n key="i18n_common_title_contractcode" defaultValue="合同编码" />', name:'contractNumber', width: 100, align: 'center' },
	     	        	{ title:'<i18n:I18n key="i18n_common_title_contracName" defaultValue="合同名称" />', name:'contractDesc' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型" />', name:'contractTypeCode' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_contractsigningdate" defaultValue="合同签订日期" />', name:'contractSignedDate' ,width:100, align:'center',renderer:formatDate},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_contractcommencementdate" defaultValue="合同生效日期" />', name:'contractStartDate' ,width:100, align:'center',renderer:formatDate},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_contractterminationdate" defaultValue="合同终止日期" />',name:'contractEndDate' ,width:100, align:'center',renderer:formatDate},
	     	        	{ title:'<i18n:I18n key="i18n_enquiry_label_supplier" defaultValue="供应商" />', name:'toElsAccount' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_label_currencyType" defaultValue="币种" />', name:'currency' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_advancepaymentamount" defaultValue="预付款金额" />', name:'paymentAmount' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_cumulativePaymentAmount" defaultValue="累计付款金额" />', name:'totalPaymentAmount' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_contracttotalamount" defaultValue="合同总金额" />', name:'totalContractAmount' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_contractstatus" defaultValue="合同状态" />', name:'contractStatus' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_assesstemplate_table_templateVersionNumber" defaultValue="版本号" />', name:'contractVersion' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_suppliercontactphone" defaultValue="供应商联系人电话" />', name:'saleContactPhone' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_purchasecontactphone" defaultValue="采购联系人电话" />', name:'purchaseContactPhone' ,width:100, align:'center'},
	     	        	{ title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:100, align:'center' },
	    	        	{ title:'<i18n:I18n key="i18n_common_title_createdate" defaultValue="创建日期" />', name:'createDate' ,width:100, align:'center', renderer:formatDate}];


  	  var GobalparamStr={"elsAccount":elsAccount};
  	  var height=$(document).height()-155;
  	  headTable= $('#headTable').mmGrid({
  	    	 		cols: colst_head,
  	         		url: '<%=basePath%>rest/ContractManageService/queryContractManageHeadByCondtion',
  					params : GobalparamStr,
  					method : 'post',
  					root : "rows",
  					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
  			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
  			        multiSelect : false,
  			        checkCol : true,
  			        indexCol : false,
  			     	 height: 200,
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
 					                , limitList: [10, 30, 40, 50]
 					            })
				]
  				});
  	  
  				headTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
			     	rowIndexSelect=rowIndex;
			     	loadMaterialItem();
					loadClause();
			    });
  	 
  				headTable.on('loadSuccess', function(e, data) {
  					//clauseTable.removeRow();
  					if (data.total > 0) {
  						headTable.select(rowIndexSelect);
  						loadMaterialItem();
  						loadClause();
  					} 
  				});




	//===========================================物料清单===========================================
			 var cols_material= [{ title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber', width: 100, align: 'center'},
				                { title:'<i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />', name:'materialDesc', width: 120, align: 'center'},
				  	            { title:'<i18n:I18n key="i18n_material_pinpai" defaultValue="品牌" />', name:'attribute1' ,width:100, align:'center'},
				  	            { title:'<i18n:I18n key="i18n_material_color" defaultValue="颜色" />', name:'attribute2', width: 70, align: 'center'},
				  	            { title:'<i18n:I18n key="i18n_material_long" defaultValue="长" />', name:'attribute3', width: 70, align: 'center'},
				  		        { title:'<i18n:I18n key="i18n_material_width" defaultValue="宽" />', name:'attribute4', width: 70, align: 'center'},
				  		        { title:'<i18n:I18n key="i18n_material_height" defaultValue="高" />', name:'attribute5', width: 70, align: 'center'},
				  		        { title:'<i18n:I18n key="i18n_common_label_unitofmeasurement" defaultValue="计量单位" />', name:'measureUnit', width: 70, align: 'center'},
				  		        { title:'<i18n:I18n key="i18n_common_title_deliverydate" defaultValue="需求日期" />', name:'requireDate',width:100, align:'center',renderer:formatDate },
				  		        { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_placeOfReceipt" defaultValue="收货地点" />', name:'receiptAddr',width:150, align:'center'},
				  		        { title:'<i18n:I18n key="i18n_common_title_paymentTerms" defaultValue="付款条件" />', name:'paymentClause',width:100, align:'center'},
				  		        { title:'<i18n:I18n key="i18n_common_title_price" defaultValue="单价" />', name:'price', width: 70, align: 'center'},
				  				{ title:'<i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />', name:'quantity', width: 70, align: 'center'},
				  				{ title:'<i18n:I18n key="i18n_common_title_taxRate" defaultValue="税率" />', name:'rate',width:70, align:'center'},
				  				{ title:'<i18n:I18n key="i18n_common_title_amount" defaultValue="金额" />', name:'amount',width:70, align:'center'},
				  				{ title:'<i18n:I18n key="i18n_common_title_quantity" defaultValue="采购订单数量" />', name:'purchaseOrderQuantity',width:80, align:'center'},
				  				{ title:'<i18n:I18n key="i18n_common_deliveredquantity" defaultValue="已发货数量" />', name:'deliveryQuantity',width:80, align:'center'},
				  				{ title:'<i18n:I18n key="i18n_common_title_receivedquantity" defaultValue="已收货数量" />', name:'receiveQuantity',width:80, align:'center'},
				  				{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark',width:150, align:'center'}];


	
			 materialTable = $('#materialTable').mmGrid({
		        cols: cols_material,
		        height: 180,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: true,
		        multiSelect: true
		    });
		 
		//加载物料清单
		 var loadMaterialItem = function() {
		 	    var obj = headTable.selectedRows();
	 	    	if(obj.length<=0){return;}
		 	    var head = obj[0];
		 	   // console.log(head);
		 		$.ajax({
		 			url : '<%=basePath%>rest/ContractManageService/queryContractManageMaterialByCondtion' + "?t="+new Date().getTime(),
		 			type : 'POST',
		 			contentType : "application/json",
		 			data : JSON.stringify(head),
		 			dataType : "json",
		 			success : function(data) {
		 				materialTable.load(data.rows);
		 			},
		 			error : function(data) {
		 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
		 			}
		 		});
		 }
		
			
  //===========================================合同条款===========================================
		 var cols_clause = [{ title:'<i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型编码" />', name:'contractTypeCode', width: 100, align: 'center'},
		                { title:'<i18n:I18n key="i18n_common_title_contractclausecode" defaultValue="合同条款编码" />', name:'contractClauseCode', width: 100, align: 'center'},
		                { title:'<i18n:I18n key="i18n_common_title_contracDescName" defaultValue="合同条款简称" />', name:'contractDesc', width: 100, align: 'center'},
		  	            { title:'<i18n:I18n key="i18n_common_title_contracdetailcontent" defaultValue="合同条款明细内容" />', name:'detailContent' ,width:300, align:'center'},
		  	            { title:'<i18n:I18n key="i18n_common_title_superiorClauseCode" defaultValue="上级合同条款编码" />', name:'superiorClauseCode' ,width:150, align:'center'},
		  	            { title:' <i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark', width: 200, align: 'center'}];

	
		 clauseTable = $('#clauseTable').mmGrid({
		        cols: cols_clause,
		        height: 180,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: true,
		        multiSelect: true
		    });
		 
		 
	     //加载合同条款
		 var loadClause = function() {
		 	    var obj = headTable.selectedRows();
	 	    	if(obj.length<=0){return;}
		 	    var head = obj[0];
		 		$.ajax({
		 			url : '<%=basePath%>rest/ContractManageService/queryContractManageClauseByCondtion' + "?t="+new Date().getTime(),
		 			type : 'POST',
		 			contentType : "application/json",
		 			data : JSON.stringify(head),
		 			dataType : "json",
		 			success : function(data) {
		 				clauseTable.load(data.rows);
		 			},
		 			error : function(data) {
		 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
		 			}
		 		});
		 }

	     
</script>
</body>
</html>