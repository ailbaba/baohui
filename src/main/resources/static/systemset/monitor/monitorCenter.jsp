<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>

	<div class="box-wrap pos-relative bg-common">
		<form id="monitorCenterForm" onsubmit="return false;"
			onkeydown="if(event.keyCode==13)return false;">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
						key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span> <input
					type="hidden" id="elsAccount" name="elsAccount" /> <input
					type="hidden" id="pageSize" name="pageSize" value="20"> <input
					type="hidden" id="currentPage" name="currentPage" value="1">
				<div class="common-box-line">
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="业务数据ID" />:</span> <input
							id="businessId" class="easyui-textbox" name="businessId"
							type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="业务类型" />:</span> <select
							id="businessType" name="businessType">
							<option value="">全部</option>
							<option value="auditResult2ERP">订单审批回写</option>
							<option value="sendMail">邮件发送</option>
							<option value="standardResult2ERP">供应商回写</option>
							<option value="enquiryResult2ERP">价格回写</option>
							<option value="quotaResult2ERP">货源回写</option>
							<option value="createWorkflowBySRM">样品送检</option>
						</select>
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="输入参数" />:</span> <input
							id="inputParam" class="easyui-textbox" name="inputParam"
							type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="状态" />:</span> <select
							id="status" name="status">
							<option value="">全部</option>
							<option value="0">成功</option>
							<option value="1">失败</option>
							<option value="2">关闭</option>
						</select>
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="创建日期" />:</span> <input
							type="text" class="Wdate" onfocus="WdatePicker()"
							id="createDateBegin" name="createDateBegin" /> <span><i18n:I18n
								key="" defaultValue="到" />:</span> <input type="text" class="Wdate"
							onfocus="WdatePicker()" id="createDateEnd" name="createDateEnd" />
					</div>
				</div>
			</div>

			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
						key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
				<div class="common-box-line">
					<div class="dis-in-b input-and-tip">
						<button id="query" class="button-wrap">
							<i18n:I18n key="test" defaultValue="查询" />
						</button>
					</div>
					<div class="dis-in-b input-and-tip">
						<button id="close" class="button-wrap">
							<i18n:I18n key="test" defaultValue="关闭" />
						</button>
					</div>
					<div class="dis-in-b input-and-tip">
						<button id="retry" class="button-wrap">
							<i18n:I18n key="test" defaultValue="批量重试" />
						</button>
					</div>
				</div>
			</div>

			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
						key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
				<div class="common-box-line">
					<main class="bg-common p-6">
					<div class="grid-100">
						<table id="monitor-center-table"></table>
						<div id="tablePage" style="text-align: right;"></div>
					</div>
					</main>
				</div>
			</div>
		</form>
	</div>
	<script>


var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var monitorCenterTable;



$(document).ready(function(){
	
	$("#elsAccount").val(elsAccount);
    
     //var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleDeliveryPlanReport_ls"/>;
	 var cols = [
			            //{title:'<i18n:I18n key="" defaultValue="Els账号" />', name:'elsAccount', width: 100, align: 'center'},
			            {title:'<i18n:I18n key="" defaultValue="操作" />', name:'operation', width: 80, align: 'center',renderer : operation},
			            {title:'<i18n:I18n key="" defaultValue="业务类型" />', name:'businessType', width: 120, align: 'center',renderer: businessType},
			            {title:'<i18n:I18n key="" defaultValue="业务数据ID" />', name:'businessId', width: 120, align: 'center'},
			            { title:'<i18n:I18n key="" defaultValue="状态" />', name:'status' , width:80, align:'center',renderer : resultStatus},
		                { title:'<i18n:I18n key="" defaultValue="异常信息" />', name:'errorMsg' , width:250, align:'center',renderer: rendererInput},
		                { title:'<i18n:I18n key="" defaultValue="耗时（毫秒）" />', name:'costTime' , width:100, align:'center'},
		                { title:'<i18n:I18n key="" defaultValue="输入参数" />', name:'inputParam' , width:200, align:'center',renderer: rendererInput},
		                { title:'<i18n:I18n key="" defaultValue="输出参数" />', name:'outputParam' ,width:200, align:'center',renderer: rendererInput},
		                { title:'<i18n:I18n key="" defaultValue="重试次数" />', name:'retryCount' ,width:80, align:'center',renderer : retryCount},
		                { title:'<i18n:I18n key="" defaultValue="创建时间" />', name:'createDate' ,width:150, align:'center',renderer : formatTime},
		                { title:'<i18n:I18n key="" defaultValue="创建人" />', name:'createUser' ,width:100, align:'center'},
		                { title:'<i18n:I18n key="" defaultValue="最后更新时间" />', name:'lastUpdateDate' ,width:150, align:'center',renderer : formatTime},
		                { title:'<i18n:I18n key="" defaultValue="最后更新人" />', name:'lastUpdateUser' ,width:100, align:'center'}
			        ];
	 
	 monitorCenterTable= $('#monitor-center-table').mmGrid({
   	 	cols : cols,
        url : "<%=basePath%>rest/ElsMonitorCenterService/queryMonitorInfo",
        params : $("#monitorCenterForm").serializeJSON() ,       
        method : 'post',
        root : "rows",
        height :350,
        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据"/>',
	    indexCol : true,
	    checkCol : true,
	    multiSelect : true,
	    nowrap:true,
	    plugins: [
	              $('#tablePage').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	                  , limit: null
	                  , limitList: [20,50,100,200,500]
	              })
	          ]
        });
	   
});	  

function operation(val ,item ,index){
	var obj={};
	$.extend(obj,item);
	if(obj.status != 2){
		obj["errorMsg"]="";
		obj["outputParam"]="";
		return '<span class="retry" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">重试</span><span style="display: none;">'+JSON.stringify(obj)+'</span>';
	}else{
		return "";
	}
}

function rendererInput(val,item,index){
	if(!val){
		val = "";
	}
	var name = $(this)[0].name;
	var id = name+"_"+index;
	if(item.status == 0 && name == "errorMsg"){
		return "";
	}
	return '<textarea rows="1" id="'+id+'" >'+val+'</textarea>';
	
}

function formatTime(val){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	     return val;
}

function retryCount(val){
	if (val == 0){
		return "";
	}
	return val;
}

function resultStatus(val){
	if(val == 0){
		return '<span style="color: green">成功</span>';
	}else if(val == 1){
		return '<span style="color: red">失败</span>';
	}else if(val == 2){
		return '已关闭';
	}else{
		return "";
	}
}

function businessType(val){
	if(val == "auditResult2ERP"){
		return "订单审批回写";
	}else if(val == "sendMail"){
		return "邮件发送";
	}else if(val == "standardResult2ERP"){
		return "供应商回写";
	}else if(val == "enquiryResult2ERP"){
		return "价格回写";
	}else if(val == "quotaResult2ERP"){
		return "货源回写";
	}else if(val =="createWorkflowBySRM"){
		return "样品送检";
	}else{
		return "";
	}
}


//----查询-----
$("#query").click(function(){
	query();
});

function query(){
	var frmObj = $("#monitorCenterForm").serializeJSON();
	monitorCenterTable.opts.params = frmObj;
	monitorCenterTable.load({page:1});
}

function showMsg(businessType){
	var text = "";
	if(businessType == "getOrder"){
		text = "提取采购订单";
	}else if(businessType == "sendOrder"){
		text = "发送采购订单";
	}else if(businessType == "getERPMaterialVoucherByNumber"){
		text = "提取物料凭证";
	}
	alert(text+" 暂不支持批量重试！请单条重试",2);
}

//----批量重试---
$("#retry").click(function(){
	debugger;
	var selectRows = monitorCenterTable.selectedRows();
	if(selectRows.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var purchaseOrderNumbers ="";
	for(var i = 0 ; i < selectRows.length ; i ++){
		var item = selectRows[0];
		if(item.businessType != "auditResult2ERP"){
			debugger;
			showMsg(item.businessType);
			return;
		}
		if(item.status == 1){
			purchaseOrderNumbers += selectRows[i].businessId+",";
		}
	}
	if(purchaseOrderNumbers.length == 0){
		alert('<i18n:I18n defaultValue="请选择失败的记录" key=""/>',2);
		return;
	}
	
	purchaseOrderNumbers = purchaseOrderNumbers.substring(0,purchaseOrderNumbers.length - 1);
	
	var json={"elsAccount":elsAccount,"businessId":purchaseOrderNumbers};
	var paramStr = JSON.stringify(json);
	parent.elsDeskTop.tip.init({type: 'confirm',message: "重试？",closeEvent:function(){
	    executeRetry(paramStr);
	}});
});


//重试
$(".retry").live("click", function() {
	 var scanCol = $(this).next();
     var sanContent = scanCol.text();
     var item = JSON.parse(sanContent);
     var rowIndex = $(this).closest("tr").index();
     var inputVal = $("#inputParam_"+rowIndex).val();
     item["inputParam"]=inputVal;
     parent.elsDeskTop.tip.init({type: 'confirm',message: "重试？",closeEvent:function(){
    	 var type = item.businessType;
    	 var url='';
    	 if(type == "auditResult2ERP"){
    		 url = "<%=basePath%>rest/ElsWsService/retryWs"
    	 }else if(type == "sendMail"){
    		 url = "<%=basePath%>rest/ElsMonitorCenterService/retrySendMail"
    	 }
    	 executeRetryByAjax(JSON.stringify(item),url);
     }});
	 
});

function executeRetryByAjax(param,url){
	parent.elsDeskTop.showLoading("重试中");
	$.ajax({
		url : url ,
		contentType : "application/json",
 		type : "post",
 		dataType : "json",
 		data:param,
 		success : function(data) {
 			parent.elsDeskTop.hideLoading();
 			if(data.statusCode == "-100"){
 				alert("重试失败："+data.message,3);
 				return;
 			}
 			alert('<i18n:I18n key="" defaultValue="操作已执行" />',1);
 			query();
 		},
 		error : function(data) {
 			parent.elsDeskTop.hideLoading();
 			alert('<i18n:I18n key="" defaultValue="操作失败" />',3);
 		}
 	});
}


function executeRetry(param){
	debugger;
	$.ajax({
		url : "<%=basePath%>rest/ElsWsService/batchRetryWs" ,
		contentType : "application/json",
 		type : "post",
 		dataType : "json",
 		data:param,
 		success : function(data) {
 			parent.elsDeskTop.hideLoading();
 			alert('<i18n:I18n key="" defaultValue="操作已执行" />',1);
 			query();
 		},
 		error : function(data) {
 			parent.elsDeskTop.hideLoading();
 			alert('<i18n:I18n key="" defaultValue="操作失败" />',3);
 		}
 	});
}

//----关闭-----
$("#close").click(function(){
	var selectRows = monitorCenterTable.selectedRows();
	if(selectRows.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var obj = {"elsAccount":elsAccount};
	obj['monitorCenterVOs']=selectRows;
	
	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认关闭？",closeEvent:function(){
		parent.elsDeskTop.showLoading("关闭中");
		$.ajax({
			url : "<%=basePath%>rest/ElsMonitorCenterService/closeMonitorInfo" ,
			contentType : "application/json",
	 		type : "post",
	 		dataType : "json",
	 		data:JSON.stringify(obj),
	 		success : function(data) {
	 			parent.elsDeskTop.hideLoading();
	 			alert('<i18n:I18n key="" defaultValue="已关闭" />',1);
	 			query();
	 		},
	 		error : function(data) {
	 			parent.elsDeskTop.hideLoading();
	 			alert('<i18n:I18n key="" defaultValue="操作失败" />',3);
	 		}
	 	});
	}});
});



</script>

</body>
</html>
