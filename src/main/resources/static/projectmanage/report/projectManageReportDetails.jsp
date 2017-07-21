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
			       <span>子项目编号：</span>
			       <input id="subProjectNumber" name="subProjectNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>子项目名称：</span>
			       <input id="subProjectName" name="subProjectName" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>发料单据号：</span>
			       <input id="requirementsPlanningNumber" name="requirementsPlanningNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>招/投标单据号：</span>
			       <input id="biddingNumber" name="biddingNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>询/报价单据号：</span>
			       <input id="purchaseEnquiryNumber" name="purchaseEnquiryNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>合同单号：</span>
			       <input id="contractNumber" name="contractNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>采购订单号：</span>
			       <input id="orderNumber" name="orderNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>收货单号：</span>
			       <input id="receiptNumber" name="receiptNumber" type="text" style="width:200px;"/>
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
                     <button id="exprot-project" class="button-wrap">导出Excel</button>
                </div>
                <div class="dis-in-b input-and-tip" id="isShow">
                     <button id="custom-project" class="button-wrap">列自定义</button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">信息浏览</span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-requirementsPlanningHead"></table>
                        <div id="pg-head" style="text-align: right;"></div>
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
var projectNumber =<%=request.getParameter("projectNumber")%>;


$().ready(function(){
	init();
});	

function relevanceRequirementsPlanning(val, item, rowIndex){
	var text = '<span class="relevance-requirementsplanning" style="color:blue;cursor:pointer;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
    return text;
}

$('.relevance-requirementsplanning').live("click", function() {
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
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'requirementsPlanningManage',
        'windowTitle':'<i18n:I18n key="" defaultValue="需求计划管理"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>projectmanage/requirementsplanning/requirementsPlanningManage.jsp?requirementsPlanningNumber='+item.requirementsPlanningNumber,
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



var requirementsPlanningHeadCols = [
                                    { title:'项目编号', name:'projectNumber' , width:120, align:'center'},
                                    { title:'项目名称', name:'projectName' , width:150, align:'center'},
                                    { title:'子项目编号', name:'subProjectNumber' , width:120, align:'center'},
                                    { title:'子项目名称', name:'subProjectName' , width:120, align:'center'},
                                    { title:'发料单据号', name:'requirementsPlanningNumber' , width:120, align:'center',renderer: relevanceRequirementsPlanning},
                                    { title:'招/投标单据号', name:'biddingNumber' , width:120, align:'center'},
                                    { title:'询/报价单据号', name:'purchaseEnquiryNumber' , width:120, align:'center'},
                                    { title:'合同单号', name:'contractNumber' , width:120, align:'center'},
                                    { title:'采购订单号', name:'orderNumber' , width:120, align:'center'},
                                    { title:'收货单号', name:'receiptNumber' , width:120, align:'center'},
                                    { title:'备注', name:'remark' , width:120, align:'center'}
                             ];
    
var head_datas = [
                  {"projectNumber":"201600000002","projectName":"首都机场航站楼项目-A008","subProjectNumber":"1","subProjectName":"门","requirementsPlanningNumber":"121600000002","biddingNumber":"301600000002","purchaseEnquiryNumber":"411600000001","contractNumber":"00000001","orderNumber":"201600000005","receiptNumber":"211600000001","remark":""},
                  {"projectNumber":"201600000002","projectName":"首都机场航站楼项目-A008","subProjectNumber":"1","subProjectName":"门","requirementsPlanningNumber":"121600000003","biddingNumber":"301600000002","purchaseEnquiryNumber":"411600000001","contractNumber":"00000001","orderNumber":"201600000005","receiptNumber":"211600000001","remark":""},
                  {"projectNumber":"201600000002","projectName":"首都机场航站楼项目-A008","subProjectNumber":"3","subProjectName":"马桶","requirementsPlanningNumber":"121600000004","biddingNumber":"","purchaseEnquiryNumber":"","contractNumber":"","orderNumber":"","receiptNumber":"","remark":""}
             ];
             

function init(){
    
	
	$("#elsAccount").val(elsAccount);
	

    requirementsPlanningHeadGrid=$('#table-requirementsPlanningHead').mmGrid({
    	cols: requirementsPlanningHeadCols,
        items:head_datas,
	    height: 350,
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
    	if(projectNumber != '201600000002'){
    		requirementsPlanningHeadGrid.removeRow();
    	}
    	
  	});
    
}

$("#query-project").click(function() {
	var frmObj = $("#requirementsplanningForm").serializeJSON();
	
	var subProjectNumber = frmObj.subProjectNumber;
	var subProjectName = frmObj.subProjectName;
	var requirementsPlanningNumber = frmObj.requirementsPlanningNumber;
	var biddingNumber = frmObj.biddingNumber;
	var purchaseEnquiryNumber = frmObj.purchaseEnquiryNumber;
	var contractNumber = frmObj.contractNumber;
	var orderNumber = frmObj.orderNumber;
	var receiptNumber = frmObj.receiptNumber;
	
	var rows = [];
	for(var i = 0 ; i < head_datas.length ; i ++){
		var row = head_datas[i];
		if((subProjectNumber == "" || row.subProjectNumber == subProjectNumber) && 
				(subProjectName == "" || row.subProjectName == subProjectName) && 
				(biddingNumber == "" || row.biddingNumber == biddingNumber) &&
				(purchaseEnquiryNumber == "" || row.purchaseEnquiryNumber == purchaseEnquiryNumber) &&
				(contractNumber == "" || row.contractNumber == contractNumber) &&
				(orderNumber == "" || row.orderNumber == orderNumber) &&
				(receiptNumber == "" || row.receiptNumber == receiptNumber) &&
				(requirementsPlanningNumber == "" || row.requirementsPlanningNumber == requirementsPlanningNumber)){
			rows.push(head_datas[i]);
		}
	}
		
	if(rows.length > 0){
		requirementsPlanningHeadGrid.load(rows);
	}else{
		requirementsPlanningHeadGrid.removeRow();
	}
	
	
});



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
        'windowsId':'addRequirementsPlanning',
        'windowTitle':'<i18n:I18n key="" defaultValue="项目管理报表详细"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>projectmanage/requirementsplanning/addRequirementsPlanning.jsp',
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


</script>

</body>
</html>
