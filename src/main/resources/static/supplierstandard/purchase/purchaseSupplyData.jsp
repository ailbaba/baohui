<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryDataBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                     <button id="addDataType" class="button-wrap" ><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
                     <button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="queryForm">
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="test" defaultValue="模板编码" />:</span>
			       <input id="modelTypeCode" name="modelTypeCode" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="test" defaultValue="模板名称" />:</span>
			       <input id="modelTypeName" name="modelTypeName" type="text" style="width:200px;"/>
		        </div>
                </form>
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
</div>


<script>

var headTable;
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

var colst_head = [{ title:'<i18n:I18n key="test" defaultValue="模板编号" />', name:'modelTypeCode', width: 100, align: 'center'},
  	        	{ title:'<i18n:I18n key="test" defaultValue="模板名称" />', name:'modelTypeName' ,width:150, align:'center' },
  	        	{ title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:100, align:'center' },
  	        	{ title:'<i18n:I18n key="i18n_common_title_createdate" defaultValue="创建日期" />', name:'createDate' ,width:100, align:'center', renderer:formatDate},
  	        	{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark' ,width:100, align:'center'}];

var initData = [{"modelTypeCode":"00001","modelTypeName":"银行资料","createUser":"","createDate":"","remark":"银行模板资料"},
               	 {"modelTypeCode":"00002","modelTypeName":"地址资料","createUser":"","createDate":"","remark":"银行模板资料"},
               	 {"modelTypeCode":"00003","modelTypeName":"认证资料资料","createUser":"","createDate":"","remark":"银行模板资料"},
              	 {"modelTypeCode":"00004","modelTypeName":"联系人资料","createUser":"","createDate":"","remark":"银行模板资料"},
              	 {"modelTypeCode":"00005","modelTypeName":"检验工厂","createUser":"","createDate":"","remark":"检验样品资料"},
              	 {"modelTypeCode":"00006","modelTypeName":"检验样品","createUser":"","createDate":"","remark":"检验样品资料"}

];
  	        	


function init(){
    var formObj = $("#queryForm").serializeJSON();
	formObj["elsAccount"]=elsAccount;
	formObj["pageSize"]=10;
	formObj["currentPage"]=1;
	 
    headTable=$('#headTable').mmGrid({
	    cols: colst_head,
	  //  params: formObj,
	  	items:initData,
	    height: 200,
	 //   method: 'post',
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
     	$('body').data('supplyDataItem',item);
	 });
	
	headTable.on('loadSuccess', function(e, data) {
		if (data.total > 0) {
			headTable.select(rowIndexSelect);
		} 
	});
}


//查询
$("#queryDataBtn").click(function(){
	 var formObj = $("#queryForm").serializeJSON();
	 formObj["elsAccount"]=elsAccount;
// 	 headTable.opts.params = formObj;
// 	 headTable.load({page:1});
});

//确定
$("#addDataType").click(function() {
	var selectRows = headTable.selectedRows();
	if(selectRows.length > 0){
		var headRow = selectRows[0];
		parent.frames['iframeApp_'+frameAppId].selectModelCallbackFunc(headRow);
	    parent.elsDeskTop.closeCurWin('purchaseSupplyData');
		
	}else{
		parent.elsDeskTop.closeCurWin('purchaseSupplyData');
	}
});

//双击
$('#headTable').on('dblclick','tr',function() {
	var supplyDataItem = $('body').data('supplyDataItem');
	parent.frames['iframeApp_'+frameAppId].selectModelCallbackFunc(supplyDataItem);
    parent.elsDeskTop.closeCurWin('purchaseSupplyData');
});

//退出
$("#exitBtn").click(function(){
	//parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>', closeEvent:function(){
		parent.elsDeskTop.closeCurWin('purchaseSupplyData');
	//}});
});

</script>

</body>
</html>
