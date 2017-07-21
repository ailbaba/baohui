<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                <button class="button-wrap" id="affirmBtn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
		  <form id="requirementsplanningForm">
		    <input type="hidden" id="elsAccount" name="elsAccount">
            <input type="hidden" id="pageSize" name="pageSize" value="20">
		    <input type="hidden" id="currentPage" name="currentPage" value="1"> 
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
			    <div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="i18n_requirementsPlanning_lable_demandPlanNumber" defaultValue="需求计划编号" />:</span>
					<input type="text" id="projectNumber" name="projectNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_orderitemnumber" defaultValue="项目编号" />:</span>
					<input type="text" id="projectNumber" name="projectNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_requirementsPlanning_table_projectItemNumber" defaultValue="项目行编号" />:</span>
					<input type="text" id="projectItemNumber" name="projectItemNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />:</span>
					<input type="text" id="materialNumber" name="materialNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名" />:</span>
					<input type="text" id="materialName" name="materialName" />
				</div>
                <div class="dis-in-b input-and-tip">
                	<span><i18n:I18n key="" defaultValue="需求开始时间" /></span>
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="dateRequiredBegin" name="dateRequiredBegin"/>
                </div>
                <div class="dis-in-b input-and-tip">
	                <span><i18n:I18n key="" defaultValue="需求结束时间" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="dateRequiredEnd" name="dateRequiredEnd" />
                </div>
			</div>
		  </form>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_requirementsPlanning_table_materialDetail" defaultValue="物料明细" /></span>
			<div class="common-box-line">
				<main class="grid-container">
					<div class="grid-100">
						<table id="table-requirementsPlanningHead"></table>
						<div id="pg" style="text-align: right;"></div>
					</div>
				</main>
			</div>
		</div>
		
	</div>
<script type="text/javascript">
var elsAccount = "${sessionScope.elsAccount}";
var frameAppId ="<%=request.getParameter("frameAppId") %>";
var requirementsPlanningItemGrid;

var renderFormatStatus = function(val,item,rowIndex){
	if("0"==val){
		return "<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />";
	} else if("1"==val){
		return "<i18n:I18n key="testssst" defaultValue="审批中" />";
	} else if("2"==val){
		return "<i18n:I18n key="i18n_requirementsPlanning_select_projectApproval" defaultValue="立项" />";
	} else if("3"==val){
		return "<i18n:I18n key="i18n_js_close" defaultValue="关闭" />";
	} else {
		return "";
	}
};

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//日期格式渲染 yyyy-MM-dd
function rendererDate(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
	return val;
}


var requirementsPlanningItemCols = [
                                    { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_demandPlanNumber" defaultValue="需求计划编号"/>', name:'requirementsPlanningNumber' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_common_title_orderitemnumber" defaultValue="项目编号" />', name:'projectNumber' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_quotation_itemnumber" defaultValue="行项目编号"/>', name:'projectItemNumber' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber' , width:120, align:'center',},
                                    { title:'<i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />', name:'materialName' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_material_pinpai" defaultValue="品牌" />', name:'property1' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_material_color" defaultValue="颜色" />', name:'property2' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_material_long" defaultValue="长度" />', name:'property3' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_material_width" defaultValue="宽度" />', name:'property4' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_material_height" defaultValue="高度" />', name:'property5' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_common_label_deliverydate" defaultValue="需求日期" />', name:'dateRequired' , width:120, align:'center',renderer :rendererDate},
                                    { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_placeOfReceipt" defaultValue="收货地点" />', name:'placeOfReceipt' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_proposedPurchasePrice" defaultValue="建议采购价格" />', name:'suggestPrice' , width:120, align:'center'},
                                    { title:'<i18n:I18n key="i18n_label_remark" defaultValue="备注" />', name:'remark' , width:120, align:'center'},
                                    { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                                    { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                                    { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
                                    { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime}
                                    
                             ];
  	
	
$(document).ready(function(){
    init();
});

function init(){
	
    $("#elsAccount").val(elsAccount);
	
	var frm = $("#requirementsplanningForm")
	
	requirementsPlanningItemGrid=$('#table-requirementsPlanningHead').mmGrid({
	    cols: requirementsPlanningItemCols,
	    url: '<%=basePath%>rest/RequirementsPlanningService/findItemList',
	    params: frm.serializeJSON(),
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    multiSelect:true,
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
	                  , limitList: [10,20,50,100]
	              })
	          ]
	});
}

$("#queryBtn").click(function(){
	refreshData();
});

function refreshData(){
	var frm = $("#requirementsplanningForm");
	requirementsPlanningItemGrid.opts.params = frm.serializeJSON();
	requirementsPlanningItemGrid.load();
}

$("#affirmBtn").click(function(){
	var records = requirementsPlanningItemGrid.selectedRows();
	parent.frames['iframeApp_'+frameAppId].callbackFun(records);
	parent.elsDeskTop.closeCurWin('findRequirementsplanning');
	
});





</script>
</body>
</html>