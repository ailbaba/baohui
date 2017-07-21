<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
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
			</div>
		</div>
		
		<form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>类型:</span>
					<select id="regulationType" name="regulationType">
						<option value="">请选择</option>
						<option value="0">条例</option>
						<option value="1">条例组</option>
					</select>
				</div>
				<div class="dis-in-b input-and-tip">
					<span>编号:</span>
					<input type="text" id="typeNumber" name="typeNumber"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span>名称:</span>
					<input type="text" id="typeName" name="typeName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />:</span>
					<input type="text" id="createUser" name="createUser" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_sampleManage_createDate" defaultValue="创建日期" />:</span>
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
		
		var initStandardStatus = function (val,item,index){
			if (val == "0") return '<i18n:I18n key="" defaultValue="条例" />'
			else if (val == "1") return '<i18n:I18n key="" defaultValue="条例组" />';
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
				'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
		        'windowsId':'addType',
		        'windowTitle':"<i18n:I18n defaultValue='添加' key='i18n_common_button_addition'/>",
		        'iframSrc':"${pageContext.request.contextPath}/regulation/type/addType.jsp?pid=regulationType",
		        windowStatus: 'regular',
		        windowMinWidth: 400,
		        windowMinHeight: 340,
		        'windowWidth':400,
		        'windowHeight':340,
		        windowPositionTop:100,
		        'parentPanel':".currDesktop"
		    });
	});
	 
	 $("#updBtn").click(function(){
		 var head = headTable.selectedRows();
		 if(head.length<=0){
			 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
			 return;
		 }
		 var regulationType = head[0].regulationType;
		 var typeNumber = head[0].typeNumber;
		 var typeName = head[0].typeName;
		 var typeDesc = head[0].typeDesc;
		 var url = "${pageContext.request.contextPath}/regulation/type/editType.jsp?typeNumber="+typeNumber+"&typeName="+typeName+"&typeDesc="+typeDesc+"&regulationType="+regulationType;
		 parent.elsDeskTop.defineWin({
				'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
		        'windowsId':'editType',
		        'windowTitle':"<i18n:I18n defaultValue='修改' key='i18n_common_button_addition'/>",
		        'iframSrc':url,
		        windowStatus: 'regular',
		        windowMinWidth: 400,
		        windowMinHeight: 340,
		        'windowWidth':400,
		        'windowHeight':340,
		        windowPositionTop:100,
		        'parentPanel':".currDesktop"
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
			 		 $.ajax({
			 			url : '<%=basePath%>rest/RegulationService/deleteRegulationType',
			 			type : 'POST',
			 			contentType : "application/json",
			 			data : JSON.stringify(param),
			 			dataType : "json",
			 			success : function(data) {
			 				if(data.statusCode=="106"){
				 				alert('<i18n:I18n key="test" defaultValue="此类型已经被引用请误删除!" />',2);
			 				}else {
				 				alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
				 				headTable.load({});
			 				}
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
	 
	 //查询
	 $("#queryHeadBtn").click(function(){
		 queryRegulation();
		
	 });
	 function queryRegulation(){
		 var formObj = $("#queryForm").serializeJSON();
		 formObj["elsAccount"]=elsAccount;
		 headTable.opts.params = formObj;
		 headTable.load({page:1});
	 }
	 
	window.purchQuery = function() {
		headTable.load({});
	}
 
    
  
	   var colst_head = [
	            { title:'<i18n:I18n key="" defaultValue="编码" />', name:'typeNumber', width: 200, align: 'center'},
	        	{ title:'<i18n:I18n key="" defaultValue="名称" />', name:'typeName' ,width:200, align:'center' },
	        	{ title:'<i18n:I18n key="" defaultValue="类别" />', name:'regulationType' ,width:200, align:'center',renderer:initStandardStatus},
	        	{ title:'<i18n:I18n key="" defaultValue="描述" />', name:'typeDesc' ,width:200, align:'center' },
	        	{ title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:150, align:'center' },
	        	{ title:'<i18n:I18n key="i18n_fileManage_title_createDate" defaultValue="创建日期" />', name:'createDate' ,width:150, align:'center', renderer:formatDateTime},
	        	//{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark' ,width:200, align:'center'}
	        	];
	   

  	  var GobalparamStr={"elsAccount":elsAccount};
  	  var height=$(document).height()-155;
  	  headTable= $('#headTable').mmGrid({
  	    	 		cols: colst_head,
  	         		url: '<%=basePath%>rest/RegulationService/getRegulationTypeList',
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


	
</script>
</body>
</html>