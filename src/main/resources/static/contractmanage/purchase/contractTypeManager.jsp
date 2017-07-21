<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
		    <input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsSubAccount")%>"/>
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="queryHeadBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
				<button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
                <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
                <button class="button-wrap" id="excelDown"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="excel模板下载" /></button>
                <button class="button-wrap" id="excelInsert"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="excel导入" /></button>
			</div>
		</div>
		
		<form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型编码" /></span>
					<input type="text" id="contractTypeCode" name="contractTypeCode"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_contracttypename" defaultValue="合同类型名称" />:</span>
					<input type="text" id="contractTypeName" name="contractTypeName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />:</span>
					<input type="text" id="createUser" name="createUser" />
				</div>
				<!-- 测试回调 -->
				<div class="dis-in-b input-and-tip">
                	<input  class="findTemplate" type="text" style="width: 200px;" readonly="readonly" placeholder="请选择" title="请选择"/>
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
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_header" defaultValue="表头" /></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_body" defaultValue="表体" /></span>
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
	 var headTable;
	 var itemTable;
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
		//发送状态
		var initSendStatus = function (val,item,index){
			//0:未发送 1:已发送
			if (val == "0") return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />'
			else if (val == "1") return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
		};
		//单据状态
		var initStandardStatus = function (val,item,index){
			//0:新建 1:销售方填写中 2:采购方评估中 3:待审批中 4:审批中
			if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />'
			else if (val == "1") return '<i18n:I18n key="i18n_common_fillIn" defaultValue="填写中" />';
			else if (val == "2") return '<i18n:I18n key="i18n_common_inEvaluation" defaultValue="评估中" />';
			else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
		};
		//审批状态
		var initAuditStatus = function (val,item,index){
			//0:审批通过  1:未审批  2:审批中  3:审批拒绝
			if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" />'
			else if (val == "1") return '<i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" />'
			else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
			else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" />';
		};
		//供应商els帐号
		var initSupplierElsAccount = function (val,item,index){
			return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		};
		
	 // 渲染   @author jiangzhidong 20160120  end
	 
	  //新增
	 $("#addBtn").click(function(){
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "contractTypeManagerAdd",
			        windowTitle : "<i18n:I18n defaultValue='新建合同类型及条款' key='i18n_common_Newcontracttypeandterms'/>",
			        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/contractTypeManagerAdd.jsp",
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
			});
	 
	 
	 //修改
	 $("#updBtn").click(function(){
	 	    var head = headTable.selectedRows();
	 	    var contractTypeCode=head[0].contractTypeCode;
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "contractTypeManagerUpd",
			        windowTitle : "<i18n:I18n defaultValue='修改合同管理' key='i18n_contract_title_modifycontractmanagement'/>",
			        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/contractTypeManagerUpd.jsp?contractTypeCode="+contractTypeCode,
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
					 var item = itemTable.rows();
					 param["supplierContractItemList"]=item;				 
			 		 $.ajax({
			 			url : '<%=basePath%>rest/SupplierContractTypeService/deleteSupplierContractByHeader',
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
								enterpriseName =  data["shortName"];
								$ (id).val(enterpriseName);
							}
						},
						error: function (xhr, type, exception) {
			            	alert(xhr.responseText, "Failed"); 
			        	}
					});
		}
	}
  
	   var colst_head = [
	            { title:'<i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型编码" />', name:'contractTypeCode', width: 200, align: 'center'},
	        	{ title:'<i18n:I18n key="i18n_common_title_contracttypename" defaultValue="合同类型名称" />', name:'contractTypeName' ,width:200, align:'center' },
	        	{ title:'<i18n:I18n key="i18n_common_title_Ordertolerancecontrol" defaultValue="订单容差控制比例%" />', name:'tolerance' ,width:200, align:'center' },
	        	{ title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:150, align:'center' },
	        	{ title:'<i18n:I18n key="i18n_fileManage_title_createDate" defaultValue="创建日期" />', name:'createDate' ,width:150, align:'center', renderer:formatDate},
	        	{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark' ,width:200, align:'center'}];
	   

  	  var GobalparamStr={"elsAccount":elsAccount};
  	  var height=$(document).height()-155;
  	  headTable= $('#headTable').mmGrid({
  	    	 		cols: colst_head,
  	         		url: '<%=basePath%>rest/SupplierContractTypeService/querySupplierContractHeadByCondtion',
  					params : GobalparamStr,
  					method : 'post',
  					root : "rows",
  					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
  			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
  			        multiSelect : false,
  			        checkCol : true,
  			        indexCol : false,
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
		var headRows = JSON.parse(editCol);
		var url='<%=basePath%>account/displayAccount.jsp?elsAccountNumber='+headRows.supplierElsAccount;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
	        'windowsId':'PurchaseEnHisPrice',
	        'windowTitle':'<i18n:I18n defaultValue="账户信息" key="i18n_account_title_accountInformation"></i18n:I18n>',
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
	
	
	//===========================================表体===========================================
	 var cols_item = [
	                { title:'<i18n:I18n key="i18n_common_title_contractclausecode" defaultValue="合同条款编码" />', name:'contractClauseCode', width: 200, align: 'center'},
	                { title:'<i18n:I18n key="i18n_common_title_contracDescName" defaultValue="合同条款简称" />', name:'contractClauseName', width: 200, align: 'center'},
	  	            { title:'<i18n:I18n key="i18n_common_title_contracdetailcontent" defaultValue="合同条款明细内容" />', name:'detailContent' ,width:200, align:'center'},
	  	            { title:'<i18n:I18n key="i18n_common_title_superiorClauseCode" defaultValue="上级合同条款编码" />', name:'superiorClauseCode', width: 200, align: 'center'},
	  	            { title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:150, align:'center' },
		        	{ title:'<i18n:I18n key="i18n_common_title_createdate" defaultValue="创建日期" />', name:'createDate' ,width:150, align:'center', renderer:formatDate},
	  	            { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark', width: 200, align: 'center'}];

	
		 itemTable = $('#itemTable').mmGrid({
		        cols: cols_item,
		        height: 300,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: true,
		        multiSelect: true
		    });
		 
		//加载行
		 var loadItem = function() {
		 	    var obj = headTable.selectedRows();
	 	    	if(obj.length<=0){return;}
		 	    var head = obj[0];
		 		$.ajax({
		 			url : '<%=basePath%>rest/SupplierContractTypeService/querySupplierContractItemByCondtion' + "?t="+new Date().getTime(),
		 			type : 'POST',
		 			contentType : "application/json",
		 			data : JSON.stringify(head),
		 			dataType : "json",
		 			success : function(data) {
		 				itemTable.load(data.rows);
		 			},
		 			error : function(data) {
		 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
		 			}
		 		});
		 }
		
//=================================================合同查找======================================================测试
		 $('.findTemplate').live("click", function(event) {
		     //兼容ie 冒泡事件
		 	if (event && event.preventDefault) {
		         event.preventDefault();
		         event.stopPropagation();
		     } else {
		         window.event.returnValue = false;
		     }
		     parent.elsDeskTop.defineWin({
		         'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
		         'windowsId':'contractTypeManagerFind',
		         'windowTitle':'<i18n:I18n key="i18n_common_title_selectcontracttypecode" defaultValue="选择合同类型" />',
		         'windowSubTitle': companyShortName,
		         'iframSrc':'<%=basePath%>contractmanage/purchase/contractTypeManagerFind.jsp?frameAppId=contractTypeManager',
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
		 function selectContractTypeCallbackFunc(rows){
		 	debugger;
		 	console.log(rows);
		 }
			
</script>
</body>
</html>