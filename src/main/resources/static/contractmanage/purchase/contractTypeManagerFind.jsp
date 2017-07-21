<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="queryForm">
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型编码" />:</span>
			       <input id="contractTypeCode" name="contractTypeCode" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_common_title_contracttypename" defaultValue="合同类型名称" />:</span>
			       <input id="contractTypeName" name="contractTypeName" type="text" style="width:200px;"/>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryHeadBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="addContractType" class="button-wrap" ><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
                </div>
                
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="headTable"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="itemTable"></table>
                        <div id="item-pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>


<script>

var headTable;
var itemTable;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var createUser='<%=session.getAttribute("username") %>';
var frameAppId ="<%=request.getParameter("frameAppId") %>";
var rowIndexSelect=0;

$().ready(function(){
	init();
});	

//渲染   @author jiangzhidong 20160305  begin
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
//渲染   @author jiangzhidong 20160305  end

var colst_head = [{ title:'<i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型编码" />', name:'contractTypeCode', width: 100, align: 'center'},
  	        	{ title:'<i18n:I18n key="i18n_common_title_contracttypename" defaultValue="合同类型名称" />', name:'contractTypeName' ,width:150, align:'center' },
  	        	{ title:'<i18n:I18n key="i18n_common_title_Ordertolerancecontrol" defaultValue="订单容差控制比例%" />', name:'tolerance' ,width:100, align:'center' },
  	        	{ title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:100, align:'center' },
  	        	{ title:'<i18n:I18n key="i18n_common_title_createdate" defaultValue="创建日期" />', name:'createDate' ,width:100, align:'center', renderer:formatDate},
  	        	{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark' ,width:100, align:'center'}];
  	        	
  	        	
var cols_item = [{ title:'<i18n:I18n key="i18n_common_title_contractclausecode" defaultValue="合同条款编码" />', name:'contractClauseCode', width: 100, align: 'center'},
                { title:'<i18n:I18n key="i18n_common_title_contracDescName" defaultValue="合同条款简称" />', name:'contractClauseName', width: 150, align: 'center'},
  	            { title:'<i18n:I18n key="i18n_common_title_contracdetailcontent" defaultValue="合同条款明细内容" />', name:'detailContent' ,width:200, align:'center'},
  	            { title:'<i18n:I18n key="i18n_common_title_superiorClauseCode" defaultValue="上级合同条款编码" />', name:'superiorClauseCode', width: 100, align: 'center'},
  	            { title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:100, align:'center' },
	        	{ title:'<i18n:I18n key="i18n_common_title_createdate" defaultValue="创建日期" />', name:'createDate' ,width:100, align:'center', renderer:formatDate},
  	            { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark', width: 100, align: 'center'}];


function init(){
    var formObj = $("#queryForm").serializeJSON();
	formObj["elsAccount"]=elsAccount;
	formObj["pageSize"]=10;
	formObj["currentPage"]=1;
	 
    headTable=$('#headTable').mmGrid({
	    cols: colst_head,
	    url: '<%=basePath%>rest/SupplierContractTypeService/querySupplierContractHeadByCondtion',
	    params: formObj,
	    height: 150,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        multiSelect : false,
        checkCol : true,
        indexCol : false,
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
                 , limitList: [5,10,15,20]
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
	
	itemTable=$('#itemTable').mmGrid({
	    cols: cols_item,
	    url : '<%=basePath%>rest/SupplierContractTypeService/querySupplierContractItemByCondtion',
	    params: null,
	    height: 300,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    plugins: [
	              $('#item-pg').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	                  , limit: null
	                  , limitList: [10,15,20,40]
	              })
	          ]
	});
    
    
}

//加载行
var loadItem = function() {
	var obj = headTable.selectedRows();
 	if(obj.length<=0){return;}
	var head = obj[0];
	//itemTable.opts.params = JSON.stringify(head);
	itemTable.load(head);
}


//查询
$("#queryHeadBtn").click(function(){
	 var formObj = $("#queryForm").serializeJSON();
	 formObj["elsAccount"]=elsAccount;
	 
	 headTable.opts.params = formObj;
	 headTable.load({page:1});
});


$("#addContractType").click(function() {
	var selectRows = headTable.selectedRows();
	if(selectRows.length > 0){
		var headRow = selectRows[0];
		var itemRows = itemTable.rows();
		headRow["supplierContractItemList"]=itemRows;
		parent.frames['iframeApp_'+frameAppId].selectContractTypeCallbackFunc(headRow);
	    parent.elsDeskTop.closeCurWin('contractTypeManagerFind');
		
	}else{
		parent.elsDeskTop.closeCurWin('contractTypeManagerFind');
	}
});


</script>

</body>
</html>
