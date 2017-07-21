<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="assessmentClassForm">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_assessrules_table_assessmentClassNumber" defaultValue="评估类型编号:" /></span>
			       <input id="assessmentClassNumber" name="assessmentClassNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_assessrules_table_assessmentClassName" defaultValue="评估类型名称:" /></span>
			       <input id="assessmentClassName" name="assessmentClassName" type="text" style="width:200px;"/>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryIntegrationInfo" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="addAssessRules" class="button-wrap" ><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
                </div>
                
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-assessmentClassInfo"></table>
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
                        <table id="table-assessmentItemInfo"></table>
                        <div id="item-pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>


<script>

var assessmentClassGrid;
var assessmentItemGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var createUser='<%=session.getAttribute("username") %>';
var frameAppId ="<%=request.getParameter("frameAppId") %>";

$().ready(function(){
	init();
});	


function rendererOperation(val, item, rowIndex){      
	var text = '<span class="version-history" style="color:blue;cursor:pointer;"> <i18n:I18n defaultValue="历史" key="i18n_purchase_bargain_history"></i18n:I18n></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	return text;
}


//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//渲染定量公式
function rendererAssessmentFlag(val,item,rowIndex){
	if(val == "1" ){
		return "<i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" />";
	}else{
		return "<i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" />";
	}
}

//指标类型
function rendererRationFormula(val,item,rowIndex){
	if(val== "0"){
		return "<i18n:I18n key="i18n_assessrules_select_timelyDeliveryRate" defaultValue="交货及时率" />";
	}else if(val== "1"){
		return "<i18n:I18n key="i18n_assessrules_select_incomingQualifiedRate" defaultValue="入库合格率" />";
	}else{
		return "";
	}
}

var assessmentClassCols = [
                           { title:'<i18n:I18n key="i18n_assessrules_table_assessmentClassNumber" defaultValue="评估类型编号:" />', name:'assessmentClassNumber' , width:200, align:'center'},
                           { title:'<i18n:I18n key="i18n_assessrules_table_assessmentClassName" defaultValue="评估类型名称:" />', name:'assessmentClassName' ,width:100, align:'center'},
                           { title:'<i18n:I18n key="i18n_common_label_describe" defaultValue="描述" />', name:'remark' ,width:140, align:'center'},
                           { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                           { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime}
                    ];
                    
var assessmentItemCols = [
                           { title:'<i18n:I18n key="i18n_assessrules_lable_assessmentItemNumber" defaultValue="评估项编号" />', name:'assessmentItemNumber' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_assessrules_lable_assessmentItemName" defaultValue="评估项名称" />', name:'assessmentItemName' ,width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_assessrules_lable_versionNumber" defaultValue="评估项版本号" />', name:'versionNumber' ,width:100, align:'center'},
                           { title:'<i18n:I18n key="i18n_assessrules_select_targetType" defaultValue="指标类型" />', name:'assessmentFlag' ,width:120, align:'center',renderer:rendererAssessmentFlag},
           			       { title:'<i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="定量公式" />', name:'fbk1' ,width:120, align:'center',renderer:rendererRationFormula},
                           { title:'<i18n:I18n key="i18n_assessrules_table_assessmentRules" defaultValue="评估规则" />', name:'assessmentRule' ,width:400, align:'center'},
                           { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                           { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime}
                    ];                    

function init(){
	$("#elsAccount").val(elsAccount);
	$("#hidden_elsAccount").val(elsAccount);
	$("#hidden_createUser").val(createUser);
    var frm = $("#assessmentClassForm");
    var param = {"elsAccount":elsAccount,"assessmentClassNumber":""};
    assessmentItemGrid=$('#table-assessmentItemInfo').mmGrid({
	    cols: assessmentItemCols,
	    url: '<%=basePath%>rest/SupplierAssessmentClassService/findAssessmentItemList',
	    params: JSON.stringify(param),
	    height: 200,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    multiSelect:true,
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
                 , limitList: [5,10,15,20]
             })
         ]
	});
    
    assessmentItemGrid.on('loadSuccess',function(e, data) {
    	assessmentItemGrid.select("all");
    });
    
    assessmentClassGrid=$('#table-assessmentClassInfo').mmGrid({
	    cols: assessmentClassCols,
	    url: '<%=basePath%>rest/SupplierAssessmentClassService/findAssessmentClassList',
	    params: frm.serializeJSON(),
	    height: 150,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
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
    
    // 加载明细项
    assessmentClassGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	var selectRows = assessmentClassGrid.selectedRows();
    	if(selectRows.length != 0){
    		loadItem(selectRows[0].assessmentClassNumber);
    	}
    });
    assessmentClassGrid.on('loadSuccess',function(e, data) {
    	if (data.rows && data.rows.length > 0) {
    		assessmentClassGrid.select(0);
    		var row = data.rows[0];
    		loadItem(row.assessmentClassNumber);
    	}else{
    		assessmentItemGrid.removeRow();
    	}
    });
}

function loadItem(assessmentClassNumber){
	var param = {
	    	'elsAccount':elsAccount,
	    	'assessmentClassNumber':assessmentClassNumber
	    };
	assessmentItemGrid.opts.params = param;
	assessmentItemGrid.load({page:1});
}

function queryIntegrationInfo() {
	var frm = $("#assessmentClassForm");
	assessmentClassGrid.opts.params = frm.serializeJSON();
	assessmentClassGrid.load({page:1});
}

//查询
$("#queryIntegrationInfo").click(function() {
	queryIntegrationInfo();
});

$("#addAssessRules").click(function() {
	var rows = assessmentClassGrid.selectedRows();
	if(rows.length < 1){
		alert("<i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择"/>!",2);
		return;
	}
	var selectRows = assessmentItemGrid.selectedRows();
	parent.frames['iframeApp_'+frameAppId].callbackFun(selectRows,rows);
    parent.elsDeskTop.closeCurWin('findAssessRules');
});


</script>

</body>
</html>
