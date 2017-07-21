<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
    <form id="requirementsplanningForm" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">查询条件</span>
            <div class="common-box-line">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
		        <div class="dis-in-b input-and-tip">
			       <span>项目编号：</span>
			       <input id="projectNumber" name="projectNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>项目名称：</span>
			       <input id="projectName" name="projectName" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>责任人：</span>
			       <input id="principal" name="principal" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>&nbsp;&nbsp;&nbsp;&nbsp;最近一周</span>
			       <input  id="actualStartDate" name="actualStartDate" type="radio" checked="checked"/>
			       <span>&nbsp;&nbsp;最近一个月</span>
			       <input  id="actualStartDate" name="actualStartDate" type="radio"/>
			       <span>&nbsp;&nbsp;最近三个月</span>
			       <input  id="actualStartDate" name="actualStartDate" type="radio"/>
		        </div>
		        
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="query-project" class="button-wrap">查询</button>
                </div>
		        <div class="dis-in-b input-and-tip" id="isShow">
                     <button id="details-project" class="button-wrap">查询详细信息</button>
                </div>
                <div class="dis-in-b input-and-tip" id="isShow">
                     <button id="exprot-project" class="button-wrap">导出Excel</button>
                </div>
                <div class="dis-in-b input-and-tip" id="isShow">
                     <button id="custom-project" class="button-wrap">列自定义</button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">项目信息</span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-requirementsPlanningHead"></table>
                        <div id="pg-head" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">子项目信息</span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-requirementsPlanningItem"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
        
   </form>
</div>




<script>
var requirementsPlanningHeadGrid;
var requirementsPlanningItemGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';


$().ready(function(){
	init();
});	



var requirementsPlanningHeadCols = [
                                    { title:'项目编号', name:'projectNumber' , width:120, align:'center'},
                                    { title:'项目名称', name:'projectName' , width:150, align:'center'},
                                    { title:'项目预计时间', name:'3' , width:120, align:'center'},
                                    { title:'项目预计时间', name:'4' , width:120, align:'center'},
                                    { title:'发料次数', name:'5' , width:120, align:'center'},
                                    { title:'招/投标次数', name:'6' , width:120, align:'center'},
                                    { title:'询/报价单据数', name:'7' , width:120, align:'center'},
                                    { title:'合同数', name:'8' , width:120, align:'center'},
                                    { title:'预算金额', name:'9' , width:120, align:'center'},
                                    { title:'实际发生金额', name:'10' , width:120, align:'center'},
                                    { title:'实际已支付金额', name:'11' , width:120, align:'center'},
                                    { title:'开始时间', name:'12' , width:120, align:'center'},
                                    { title:'结束时间', name:'13' , width:120, align:'center'},
                                    { title:'负责人', name:'principal' , width:120, align:'center'}
                             ];
                    
var requirementsPlanningItemCols = [
                           { title:'子项目编号', name:'1' , width:120, align:'center'},
                           { title:'子项目名称', name:'2' , width:120, align:'center'},
                           { title:'项目预计时间', name:'3' , width:120, align:'center'},
                           { title:'项目实际时间', name:'4' , width:120, align:'center'},
                           { title:'发料次数', name:'5' , width:120, align:'center'},
                           { title:'询/报价单据数', name:'6' , width:120, align:'center'},
                           { title:'合同数', name:'7' , width:120, align:'center'},
                           { title:'预算金额', name:'8' , width:120, align:'center'},
                           { title:'实际发生金额', name:'9' , width:120, align:'center'},
                 		   { title:'实际已支付金额', name:'10' , width:120, align:'center'},
                 		   { title:'开始时间', name:'11' , width:120, align:'center'},
                           { title:'结束时间', name:'12' , width:120, align:'center'}
                    ];
                    
var head_datas = [
                  {"projectNumber":"201600000002","projectName":"首都机场航站楼项目-A008","3":"40","4":"9","5":"3","6":"1","7":"1","8":"1","9":"650000","10":"","11":"","12":"2016-03-01","13":"2016-04-08","principal":"江河创建"},
                  {"projectNumber":"201600000001","projectName":"首都机场航站楼项目-A006","3":"30","4":"9","5":"1","6":"0","7":"0","8":"0","9":"200000","10":"","11":"","12":"2016-03-01","13":"2016-03-30","principal":"江河创建"}
             ];
             
var item_datas = [
                  {"1":"1","2":"门","3":"20","4":"9","5":"2","6":"1","7":"1","8":"300000","9":"","10":"","11":"2016-03-01","12":"2016-03-20"},
                  {"1":"2","2":"水盆","3":"20","4":"0","5":"0","6":"0","7":"0","8":"200000","9":"","10":"","11":"2016-03-01","12":"2016-03-05"},
                  {"1":"3","2":"马桶","3":"30","4":"2","5":"1","6":"0","7":"0","8":"150000","9":"","10":"","11":"2016-03-01","12":"2016-04-08"}
              ];

function init(){
    
	
	$("#elsAccount").val(elsAccount);
	
    requirementsPlanningHeadGrid=$('#table-requirementsPlanningHead').mmGrid({
    	cols: requirementsPlanningHeadCols,
        items:head_datas,
	    height: 150,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    multiSelect:false,
	    plugins: [
	              $('#pg-head').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	                  , limit: null
	                  , limitList: [10,15,20]
	              })
	          ]
	});
    
    requirementsPlanningHeadGrid.on("loadSuccess", function(e, data){
    	requirementsPlanningHeadGrid.select(0);
  	});
    
    requirementsPlanningHeadGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
  		var projectNumber = item.projectNumber;
  		if(projectNumber == '201600000002'){
  			requirementsPlanningItemGrid.load(item_datas);
  		}else{
  			requirementsPlanningItemGrid.removeRow();
  		}
  	}); 
    
    
    requirementsPlanningItemGrid=$('#table-requirementsPlanningItem').mmGrid({
	    cols: requirementsPlanningItemCols,
	    items:item_datas,
	    height: 250,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    multiSelect:false,
	    plugins: [
	              $('#pg').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	                  , limit: null
	                  , limitList: [10,15,20]
	              })
	          ]
	});
}


$("#details-project").click(function() {
	var selectRows = requirementsPlanningHeadGrid.selectedRows();
	if(selectRows.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'projectManageReportDetails',
        'windowTitle':'<i18n:I18n key="" defaultValue="项目管理报表详细"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>projectmanage/report/projectManageReportDetails.jsp?projectNumber='+selectRows[0].projectNumber,
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
	
});

$("#query-project").click(function() {
	var frmObj = $("#requirementsplanningForm").serializeJSON();
	
	var projectNumber = frmObj.projectNumber;
	var projectName = frmObj.projectName;
	var principal = frmObj.principal;
	
	var rows = [];
	for(var i = 0 ; i < head_datas.length ; i ++){
		var row = head_datas[i];
		if((projectNumber == "" || row.projectNumber == projectNumber) && 
				(projectName == "" || row.projectName == projectName) &&
				(principal == "" || row.principal == principal)){
			rows.push(head_datas[i]);
		}
	}
		
	
	if(rows.length > 0){
		requirementsPlanningHeadGrid.load(rows);
		requirementsPlanningItemGrid.load(item_datas);
	}else{
		requirementsPlanningHeadGrid.removeRow();
		requirementsPlanningItemGrid.removeRow();
	}
	
	
});


</script>

</body>
</html>
