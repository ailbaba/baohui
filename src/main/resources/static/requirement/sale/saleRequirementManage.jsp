<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_additionCost_queryCondition" defaultValue="查询条件" /></span>
            <div class="common-box-line">
               <form id="requirementsplanningForm">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_saleRequirement_table_demandOrderNumber" defaultValue="需求单号" />:</span>
			       <input id="requirementNumber" name="requirementNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_materialRelation_title_purchaseElsAccount" defaultValue="采购方ELS账号" />:</span>
			       <input id="toElsAccount" name="toElsAccount" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_saleRequirement_table_purchasingPlanner" defaultValue="采购计划员" />:</span>
			       <input id="purchasePlaner" name="purchasePlaner" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_common_title_responserofpurchase" defaultValue="采购方负责人" />:</span>
			       <input id="purchaseInCharge" name="purchaseInCharge" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_common_title_responserofsupplier" defaultValue="销售方负责人" />:</span>
			       <input id="saleInCharge" name="saleInCharge" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_saleRequirement_table_planningHorizonFrom" defaultValue="计划期间从" />:</span>
			       <input class="Wdate" onfocus="WdatePicker()" id="planDateStart" name="planDateStart" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_saleRequirement_table_planningHorizonTo" defaultValue="计划期间到" />:</span>
			       <input class="Wdate" onfocus="WdatePicker()" id="planDateEnd" name="planDateEnd" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_additionCost_purchaseFactory" defaultValue="采购工厂" />:</span>
			       <input id=puchaseFactory name="puchaseFactory" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_saleRequirement_table_salesFactory" defaultValue="销售工厂" />:</span>
			       <input id="saleFactory" name="saleFactory" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_saleRequirement_table_releaseDate" defaultValue="发布日期" />:</span>
			       <input class="Wdate" onfocus="WdatePicker()" id="publishDate" name="publishDate" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_saleRequirement_table_publishStatus" defaultValue="发布状态" />:</span>
			       <select id="publishStatus" name="publishStatus">
			           <option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
			           <option value="0"><i18n:I18n key="i18n_saleRequirement_table_notReleased" defaultValue="未发布" /></option>
			           <option value="1"><i18n:I18n key="i18n_saleRequirement_table_alreadyReleased" defaultValue="已发布" /></option>
			       </select>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_saleRequirement_table_periodType" defaultValue="期间类型" />:</span>
			       <select id="dateType" name="dateType">
			           <option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
			           <option value="D"><i18n:I18n key="i18n_schedule_selector_day" defaultValue="天" /></option>
			           <option value="W"><i18n:I18n key="i18n_schedule_selector_week" defaultValue="周" /></option>
			           <option value="M"><i18n:I18n key="i18n_schedule_selector_month" defaultValue="月" /></option>
			       </select>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="query-requirementsplanning" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                </div>
		        <!-- <div class="dis-in-b input-and-tip">
                     <button id="add-requirementsplanning" class="button-wrap">新建</button>
                </div> -->
               <!--  <div class="dis-in-b input-and-tip">
                     <button id="delete-requirementsplanning" class="button-wrap">删除</button>
                </div> -->
                <!-- <div class="dis-in-b input-and-tip">
                     <button id="submit-requirementsplanning" class="button-wrap">报批</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="close-requirementsplanning" class="button-wrap">关闭</button>
                </div> -->
                <div class="dis-in-b input-and-tip">
                     <button id="excel-import" class="button-wrap"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="excel-template-download" class="button-wrap"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="Excel模板下载" /></button>
                </div>
                <!-- <div class="dis-in-b input-and-tip">
                     <button id="test-requirementsplanning" class="button-wrap">Test</button>
                </div> -->
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
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




<script>
var requirementsPlanningHeadGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';

var requirementNumber ="<%=request.getParameter("requirementNumber") %>";
var toElsAccount ="<%=request.getParameter("toElsAccount") %>";

$().ready(function(){
	init();
});	


function rendererDateType(val){
	if("D"==val){
		return "<i18n:I18n key="i18n_schedule_selector_day" defaultValue="天" />";
	} else if("W"==val){
		return "<i18n:I18n key="i18n_schedule_selector_week" defaultValue="周" />";
	} else if("M"==val){
		return "<i18n:I18n key="i18n_schedule_selector_month" defaultValue="月" />";
	}else {
		return "";
	}
}

//日期格式渲染 yyyy-MM-dd
function rendererDate(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
	return val;
}

var renderFormatStatus = function(val,item,rowIndex){
	if("0"==val){
		return "<i18n:I18n key="i18n_saleRequirement_table_notReleased" defaultValue="未发布" />";
	} else if("1"==val){
		return "<i18n:I18n key="i18n_saleRequirement_table_alreadyReleased" defaultValue="已发布" />";
	}else {
		return "";
	}
};

function rendererOperation(val, item, rowIndex){      
	var text = '<span class="reply-requirement" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_saleRequirement_table_reply" defaultValue="答复" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	if(item.status == 0){
		text += '&nbsp;&nbsp;<span class="update-requirementsplanning" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_label_edit" defaultValue="修改" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
              +'&nbsp;&nbsp;<span class="delete-requirementsplanning" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	}
	return text;
}

$('.reply-requirement').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    showFrame(item,"reply");
});

$('.update-requirementsplanning').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    showFrame(item,"update");
});

function showFrame(item,operation){
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'replyRequirementPlanning',
        'windowTitle':'<i18n:I18n key="i18n_saleRequirement_title_demandPlanDetailItems" defaultValue="需求计划协同明细项"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>requirement/sale/replyRequirementPlanning.jsp?frameAppId=saleRequirementManage&operationType='
        		+operation+'&requirementNumber='+item.requirementNumber+'&toElsAccount='+item.toElsAccount,
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
}


var requirementsPlanningHeadCols = [
                           { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:120, align:'center',clickDisable:true,renderer:rendererOperation},
                           { title:'<i18n:I18n key="i18n_materialRelation_title_purchaseElsAccount" defaultValue="采购方ELS账号" />', name:'toElsAccount' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_saleRequirement_table_demandOrderNumber" defaultValue="需求单号" />', name:'requirementNumber' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_saleRequirement_table_purchasingPlanner" defaultValue="采购计划员" />', name:'purchasePlaner' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_common_title_responserofpurchase" defaultValue="采购方负责人" />', name:'purchaseInCharge' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_common_title_responserofsupplier" defaultValue="销售方负责人" />', name:'saleInCharge' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_saleRequirement_table_planningHorizonFrom" defaultValue="计划期间从" />', name:'planDateStart' , width:120, align:'center',renderer: rendererDate},
                           { title:'<i18n:I18n key="i18n_saleRequirement_table_planningHorizonTo" defaultValue="计划期间到" />', name:'planDateEnd' , width:120, align:'center',renderer: rendererDate},
                           { title:'<i18n:I18n key="i18n_additionCost_purchaseFactory" defaultValue="采购工厂" />', name:'puchaseFactory' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_saleRequirement_table_salesFactory" defaultValue="销售工厂" />', name:'saleFactory' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_saleRequirement_table_publishStatus" defaultValue="发布状态" />', name:'publishStatus' , width:120, align:'center',renderer :renderFormatStatus},
                           { title:'<i18n:I18n key="i18n_saleRequirement_table_releaseDate" defaultValue="发布日期" />', name:'publishDate' , width:120, align:'center',renderer: rendererDate},
                           { title:'<i18n:I18n key="i18n_saleRequirement_table_periodType" defaultValue="期间类型" />', name:'dateType' , width:120, align:'center',renderer: rendererDateType}
                    ];

function init(){
    
	$("#elsAccount").val(elsAccount);
	
	if(requirementNumber != null && requirementNumber != "null"){
		$("#requirementNumber").val(requirementNumber);
	}
	if(toElsAccount != null && toElsAccount != "null"){
		$("#toElsAccount").val(toElsAccount);
	}
	
	var frm = $("#requirementsplanningForm");
	
    requirementsPlanningHeadGrid=$('#table-requirementsPlanningHead').mmGrid({
	    cols: requirementsPlanningHeadCols,
	    url: '<%=basePath%>rest/SaleRequirementService/findHeadList',
	    params: frm.serializeJSON(),
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
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
	                  , limitList: [10,15,20,50]
	              })
	          ]
	});
    
}

//增加
$("#add-requirementsplanning").click(function() {
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
        'windowTitle':'<i18n:I18n key="i18n_requirementsPlanning_title_newDemandPlan" defaultValue="新增需求计划"/>',
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


function queryRequirementsplanning() {
	var frm = $("#requirementsplanningForm");
	requirementsPlanningHeadGrid.opts.params = frm.serializeJSON();
	requirementsPlanningHeadGrid.load({page:1});
}

//查询
$("#query-requirementsplanning").click(function() {
	queryRequirementsplanning();
});




</script>

</body>
</html>
