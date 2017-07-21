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
				<button class="button-wrap" id="addBtn"><i18n:I18n key="test" defaultValue="新增" /></button>
				<base:auditConfig elsAccount="${elsAccount }" businessType="standardSupplier">
					<button id="entryBtn"       class="button-wrap"><i18n:I18n key="i18n_label_entryAudit" defaultValue="上报"    /></button>
					<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report"      defaultValue="撤销上报"/></button>
					<button id="flowBtn"        class="button-wrap"><i18n:I18n key="i18n_common_viewflow"  defaultValue="查看流程"/></button>
				</base:auditConfig>		
				<button id="uploadToERP" class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_uploadToERP" defaultValue="发送至ERP" /></button>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="test" defaultValue="评估编号" /></span>
					<input type="text" id="assessmentNumber" name="assessmentNumber"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="" defaultValue="评估名称" />:</span>
					<input type="text" id="assessmentTemplateName" name="assessmentTemplateName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="" defaultValue="创建人" />:</span>
					<input type="text" id="createUser" name="createUser" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="" defaultValue="评估状态" />:</span>
					<select id="assessmentStatus" name="assessmentStatus">
						<option value="">请选择</option>
						<option value="0">进行中</option>
						<option value="1">待审批</option>
						<option value="2">已完成</option>
					</select>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="" defaultValue="创建日期" />:</span>
	                <input type="radio" name="dateArea" value="lastMonth" checked="checked"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
	                <input type="radio" name="dateArea" value="lastThreeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
	                <input type="radio" name="dateArea" value="defineDateArea"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
				</div>
                <div class="dis-in-b input-and-tip" style="display:none;">
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="startCreateDate" name="beginDate"/>
                </div>
                <div class="dis-in-b input-and-tip" style="display:none;">
	                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="endCreateDate" name="endDate" />
                </div>
                <br>列表查询结果：点击评分，跳转至“供应商评估-评分”
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="抬头信息" /></span>
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
		//按钮
		var enquiryHandle = function(val, item, index){
			return '<span class="enquiry-detail" style="color:blue;cursor:pointer;"><i18n:I18n key="test" defaultValue="评分" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
			+'&nbsp;&nbsp;<span class="markBtn" style="color:blue;cursor:pointer;"><i18n:I18n key="test" defaultValue="查看" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';

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
			return new Date(val).format("yyyy-MM-dd hh:mm:ss");
		};
		//发送状态
		var initSendStatus = function (val,item,index){
			//0:未发送 1:已发送
			if (val == "0") return '<i18n:I18n key="test" defaultValue="未发送" />'
			else if (val == "1") return '<i18n:I18n key="test" defaultValue="已发送" />';
		};
		//评估状态
		var initAssessmentStatus = function (val,item,index){
			//评估状态：\n 0:进行中\n 1:待审批\n 2:已完成'
			if (val == "0") return '<i18n:I18n key="test" defaultValue="进行中" />'
			else if (val == "1") return '<i18n:I18n key="test" defaultValue="待审批" />';
			else if (val == "2") return '<i18n:I18n key="test" defaultValue="已完成" />';
		};
		//审批状态
		var initAuditStatus = function (val,item,index){
			//0:审批通过  1:未审批  2:审批中  3:审批拒绝
			if (val == "0") return '<i18n:I18n key="test" defaultValue="审批通过" />'
			else if (val == "1") return '<i18n:I18n key="test" defaultValue="未审批" />'
			else if (val == "2") return '<i18n:I18n key="test" defaultValue="审批中" />';
			else if (val == "3") return '<i18n:I18n key="test" defaultValue="审批拒绝" />';
		};
		//审批状态 select
		var initAuditStatusSelect = function(val,item,index) {
			if(item.auditMode==3){
				var sel=' selected="true"';
				var selected = '<select name="auditStatusSelect" id="auditStatusSelect" style="color:blue; min-width:70px;"><option value="0"';
				if(val==0) selected = selected +sel;
				selected =selected + '><i18n:I18n key="test" defaultValue="审批通过" /></option><option value="1"'
				if(val==1) selected = selected +sel;
				selected =selected + '><i18n:I18n key="test" defaultValue="未审批" /></option><option value="2"'
				if(val==2) selected = selected +sel;
				selected =selected + '><i18n:I18n key="test" defaultValue="审批中" /></option><option value="3"'
				if(val==3) selected = selected +sel;
				selected =selected + '><i18n:I18n key="test" defaultValue="审批拒绝" /></option></select>'
				return selected;
			}
			return initAuditStatus(val,item,index);
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
			        windowsId : "assessmentSupplyAdd",
			        windowTitle : "<i18n:I18n defaultValue='新建评估管理' key=''/>",
			        iframSrc : "${pageContext.request.contextPath}/supplierassessment/supplier/assessmentSupplyAdd.jsp",
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
		});
	 
	 //评分
     $('.enquiry-detail').live("click", function() {
 		 var scanCol = $(this).next();
         var sanContent = scanCol.text();
         var item = JSON.parse(sanContent);
         
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "assessmentSupplyMark",
			        windowTitle : "<i18n:I18n defaultValue='评分管理' key=''/>",
			        iframSrc : "${pageContext.request.contextPath}/supplierassessment/supplier/assessmentSupplyMark.jsp?assessmentNumber="+item.assessmentNumber,
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
	$('.markBtn').live("click", function() {
         var scanCol = $(this).next();
         
         var sanContent = scanCol.text();
         var item = JSON.parse(sanContent);
         
         var beginDate = item.beginDate;
        	if (beginDate!=null&&beginDate.length!=10) {
        		beginDate = new Date(beginDate).format("yyyy-MM-dd");
        	}	
        	var endDate = item.endDate;
        	if (endDate!=null&&endDate.length!=10) {
        		endDate = new Date(endDate).format("yyyy-MM-dd");
        	}
        	//兼容ie 冒泡事件
		    if (event && event.preventDefault) {
		        event.preventDefault();
		        event.stopPropagation();
		    } else {
		        window.event.returnValue = false;
		    }
		    parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
		        'windowsId':'assessmentSupplyDetail',
		        'windowTitle':'<i18n:I18n key="test" defaultValue="供应商评估明细查看" />',
		        windowSubTitle: companyShortName,
		        'iframSrc':'<%=basePath%>supplierassessment/supplier/assessmentSupplyDetail.jsp?assessmentTemplateNumber='+ item.assessmentTemplateNumber
		        		+"&assessmentNumber=" + item.assessmentNumber,
		        showAdv: false,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
        	
     });
	 
	 //查询
	 $("#queryHeadBtn").click(function(){
		 var assessmentNumber = $("#assessmentNumber").val();
		 var assessmentTemplateName = $("#assessmentTemplateName").val();
		 var createUser = $("#createUser").val();
		 var assessmentStatus = $("#assessmentStatus").val();
		 var beginDate = $("#beginDate").val();
		 var endDate = $("#endDate").val();
		 
		 var GobalparamStr={"elsAccount":elsAccount,"assessmentNumber":assessmentNumber,
				 "assessmentTemplateName":assessmentTemplateName,"createUser":createUser,
				 "assessmentStatus":assessmentStatus,"beginDate":beginDate,
				 "endDate":endDate};
		 headTable.load(GobalparamStr);
	 });
	 
	//重新加载
	var query = function() {
	 	headTable.load({});
	};
	
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
				{ title:'操作', clickDisable:true, name:'standardDesc' ,width:80, align:'center',renderer:enquiryHandle },
	            { title:'评估编号', name:'assessmentNumber', width: 120, align: 'center'},
	            { title:'评估名称', name:'assessmentTemplateName' ,width:200, align:'center' },
	            { title:'评估模板编号', name:'assessmentTemplateNumber', width: 120, align: 'center'},
	            { title:'评估模板版本号', name:'templateVersionNumber', width: 120, align: 'center'},
	        	{ title:'状态', name:'assessmentStatus' ,width:80, align:'center',renderer:initAssessmentStatus},
	        	{ title:'创建人', name:'createUser' ,width:150, align:'center' },
	        	{ title:'开始日期', name:'beginDate' ,width:100, align:'center', renderer:formatDate},
	        	{ title:'结束日期', name:'endDate' ,width:100, align:'center', renderer:formatDate},
	        	{ title:'开始周期', name:'cycleBeginDate' ,width:100, align:'center', renderer:formatDate},
	        	{ title:'结束周期', name:'cycleEndDate' ,width:100, align:'center', renderer:formatDate},
	        	{ title:'创建日期', name:'createDate' ,width:100, align:'center', renderer:formatDate},
	        	{ title:'考评评语', name:'remark' ,width:150, align:'center'}
	        	];
	   

  	  var GobalparamStr={"elsAccount":elsAccount};
  	  var height=$(document).height()-155;
  	  headTable= $('#headTable').mmGrid({
  	    	 		cols: colst_head,
  	         		url:"<%=basePath%>rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentCheckHearderByCondtion/"+elsAccount,
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
			    });
  	 
  				headTable.on('loadSuccess', function(e, data) {
  					if (data.total > 0) {
  						headTable.select(rowIndexSelect);
  					} 
  				});


	//删除
	$('.deleteBtn').live("click", function() {
		var scanCol = $(this).next();
        var sanContent = scanCol.text();
        var obj = JSON.parse(sanContent);
        if(obj.auditStatus!=1){
       		alert('<i18n:I18n key="test" defaultValue="审批通过或审批中或审批拒绝,不能删除!" />',2);
       		return;
        }
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除?" />',closeEvent:function(){
		$.ajax({
    		url :"<%=basePath%>rest/SupplierStandardService/deleteStandardSupplierHead",
    		type :"post",
    		contentType : "application/json",
    		data : sanContent,
    		dataType : "json",
    		success : function(data) {
    			alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
    			query();
    		},
    		error : function(data) {
    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
    		}
    	}); 
		}});
		
	});
	

//查看流程
$("#flowBtn").click(function(){
var headRows      = headTable.selectedRows();
var headRowsIndex = headTable.selectedRowsIndex();
	if(headRows.length != 1){
		alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
		return;
	}		
	var tstandardNumber = elsAccount + "," + headRows[0].standardNumber ;
	parent.elsDeskTop.defineWin({
	   	'iconSrc'       : 'icon/els-icon.png' ,
		'windowsId'     : 'auditFlowList'     ,
		'windowTitle'   : '<i18n:I18n key="i18n_common_viewflow"    defaultValue="查看流程" />',
		 windowSubTitle : ""                  ,
		'iframSrc'      : '<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=standardSupplier&businessId='+ tstandardNumber,
		 showAdv        : true                ,
		 advArr         : ['icon/test-car.png','icon/test-car2.png'] ,
		 windowMinWidth : 480 ,
		 windowMinHeight: 600 ,
		'windowWidth'   : 680 ,
		'windowHeight'  : 600 ,
		'parentPanel'   : ".currDesktop"
	});
});
	
//撤销上报
$("#cancelEntryBtn").click(function(){
 	var headRows      = headTable.selectedRows();
 	var headRowsIndex = headTable.selectedRowsIndex();
		if(headRows.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		//contentType : "application/json",
		//dataType : "json",
		//data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
		var paramStr={"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"standardNumber":headRows[0].standardNumber};
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
	parent.elsDeskTop.showLoading();
	$.ajax({  url         : "<%=basePath%>rest/SupplierStandardService/cancelAudit",
			  type        : "post",
			  contentType : "application/json",
			  data 		  : JSON.stringify(paramStr),
			  dataType    : "json",
			  success     : function(data) {
				  parent.elsDeskTop.hideLoading();
				  alert('<i18n:I18n key="i18n_delivery_revokesuccess"    defaultValue="撤销成功" />');
				  query();
		      },
		      error : function(data) {
				  parent.elsDeskTop.hideLoading();
				       if (data.status == "401") {  alert('<i18n:I18n key="i18n_audit_overcantcancel"    defaultValue="流程结束的单据不能撤销审批" />'  ,3);  } 
				  else if (data.status == "403") {  alert('<i18n:I18n key="i18n_audit_higherlevelcando"  defaultValue="只有上一级处理人才能撤销审批" />',3);  } 
				  else {  alert('<i18n:I18n key = "i18n_common_alert_requestfail" defaultValue="请求出错！" />',3);	  }
			 },
			 complete : function(data) {
				  query();
	    	 }
	    });
	}
	});
});

//上报
$("#entryBtn").click(function(){
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确认要上报吗？',closeEvent:function(){
	var headRows      = headTable.selectedRows();
	var headRowsIndex = headTable.selectedRowsIndex();
		if(headRows.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		//contentType : "application/json",
		//dataType : "json",
		//data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
		var paramStr={"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"standardNumber":headRows[0].standardNumber};
		
		$.ajax({	url     : "<%=basePath%>rest/SupplierStandardService/entryStandardSupplier",
				type        : "post",
				contentType : "application/json",
				//data 		: JSON.stringify(headRows[0]),
				data 		: JSON.stringify(paramStr),
				dataType    : "json",
				success 	: function(data) {
					parent.elsDeskTop.hideLoading();
					alert('<i18n:I18n key="i18n_common_report_success" defaultValue="发送成功" />');
					query();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.status == "401") {    alert('<i18n:I18n key="i18n_common_orders_cannot_be_repeated_to_report"    defaultValue="供应商准入不能重复上报" />',3);    } 
					else {	alert('<i18n:I18n key="i18n_common_alert_requestfail"    defaultValue="请求出错" />',3);	};
				}
		});
	}});
});
		</script>
</body>
</html>