<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
		
		<%-- <div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_label_elsAccount" defaultValue="ELS帐号" /></span>
					<input type="text" id="checkElsAccount" name="checkElsAccount" />
				</div>
				
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司简称" /></span>
					<input type="text" id="checkCompanyName" name="checkCompanyName" />
				</div>
				<br>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_createdate" defaultValue="创建日期" />：</span></div>
                <input type="radio" name="dateArea" value="week"><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" />
                <input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
                <input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
                <input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startCreateDate" name="startCreateDate"/></div>
                <div class="dis-in-b input-and-tip" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endCreateDate" class="Wdate" onfocus="WdatePicker()" name="endCreateDate" /></div>
            	<button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			</div>
		</div> --%>
		
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><p id="statusText" >帐号信息</p></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="questionnaire">
							<table id="billsTable"></table>
							<div id="enquiryPage" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	 var questionnaire;
	 var excelUploader      ; //上传Excel控件 
	 var elsAcct = GetQueryString("elsAcct");
	 var flag = GetQueryString("flag");
	 var billsType = GetQueryString("billsType");
	 var status = GetQueryString("status");
	 var startDate = GetQueryString("startDate");
	 var endDate = GetQueryString("endDate");
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var elsSubAccount = <%=session.getAttribute("elsSubAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	 
	
	/*  //查询
	 $("#queryBtn").click(function(){
		 changeDateArea();
		 var elsAccount = $("#checkElsAccount").val();
		 var userName = $("#checkUserName").val();
		 var companyName = $("#checkCompanyName").val();
		 var startCreateDate =$("#startCreateDate").val();
		 var endCreateDate =$("#endCreateDate").val();
		 var status =$("#status").val();
		 var GobalparamStr={"elsAccount":elsAccount,"userName":userName,"companyName":companyName,"startCreateDate":startCreateDate,"endCreateDate":endCreateDate,"status":status};
		 questionnaire.load(GobalparamStr);
		 reset();
	 }); */
	 
	 
	
	 function changeDateArea() {
		var dateArea = $("input:radio[name=dateArea]:checked").val();
		if (dateArea == "define") {
			//$("#startCreateDate").val("");
			//$("#endCreateDate").val(""); 
			$("#startCreateDate").parent().show();
			$("#endCreateDate").parent().show();
		} else {
			$("#startCreateDate").parent().hide();
			$("#endCreateDate").parent().hide();
			$("#endCreateDate").val(new Date().format("yyyy-MM-dd"));
			var startOrderDate = "";
			if (dateArea == "week") {
				startOrderDate = getDate(-7);
			} else if (dateArea == "month") {
				startOrderDate = getDate(-30);
			} else if (dateArea == "threeMonth") {
				startOrderDate = getDate(-90);
			}
			
			$("#startCreateDate").val(startOrderDate);
		}
	}
	 
	 function getDate(dates){
		var dd = new Date();
		dd.setDate(dd.getDate()+dates);
		return dd.format("yyyy-MM-dd");
	 }
	 
	var reset = function() {
	 	if(!isFirst){
	 		 var data = questionnaire.opts.cols;
			 for(var i= 0; i<=data.length-1; i++) {
				 var row = data[i];
				 if(row.name && arr.indexOf(row.name) != -1)
					 row.renderer = null;
				 else if(row.name && arr2.indexOf(row.name) != -1)
				     row.renderer = enquiryHandle;
				 else if(row.name && arr3.indexOf(row.name) != -1)
				     row.renderer = null;
			 }
	 	}
	 	isFirst=true;
	};
 
	//按钮
	var enquiryHandle = function(val, item, index){
		return '&nbsp;&nbsp;<span class="enquiry-detail"  id="checkBtn" name="checkBtn" style="color:blue;"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	
	//只允许数字输入框
	var initInputNumber = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	
	
   var cols = [ 
    	        {title:'<i18n:I18n key="i18n_common_label_elsAccount" defaultValue="ELS帐号" />', name:'toElsAccount', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司名称" />', name:'companyName', width: 250, align: 'center'},
    	        ];
   	
   if("2"==flag){
	   cols = [ 
   	        {title:'<i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />', name:'billsName', width: 300, align: 'center'},
   	        {title:'<i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司名称" />', name:'companyName', width: 250, align: 'center'},
   	        ];
   }else if("3"==status&&flag=="3"){
  	 cols = [ 
  	        {title:'<i18n:I18n key="i18n_label_username" defaultValue="用户名" />', name:'elsSubAccount', width: 120, align: 'center'},
  	        {title:'<i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司名称" />', name:'companyName', width: 250, align: 'center'},
  	        ];
   };
    //单据
    var url = "${pageContext.request.contextPath}/rest/BillsReportService/findBillsElsAccount/"+elsAccount;
    var frm = {"elsAccount":elsAcct,"flag":flag,"billsType":billsType,"billsStatus":status,"startDate":startDate,"endDate":endDate};
    //在线用户
    if(status=="3"){
     	url = "${pageContext.request.contextPath}/rest/BillsReportService/findOnlineAccount/"+elsAccount;
     	frm = {"elsAccount":elsAcct,flag:flag};
    }
   
  	var billsAccount = $('#billsTable').mmGrid({
 	    	 		cols: cols,
 	         		url: url,
 					params : frm,
 					method : 'post',
 					root : "rows",
 					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
 			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
 					checkCol : true,
 			        multiSelect: true,
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

	
	
</script>
</body>
</html>