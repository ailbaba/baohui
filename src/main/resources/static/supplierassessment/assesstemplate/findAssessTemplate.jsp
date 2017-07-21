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
			       <span><i18n:I18n key="i18n_assesstemplate_table_assessmentTemplateNumber" defaultValue="评估模板编号:" /></span>
			       <input id="assessmentTemplateNumber" name="assessmentTemplateNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_assesstemplate_table_assessmentTemplateName" defaultValue="评估模板名称:" /></span>
			       <input id="assessmentTemplateName" name="assessmentTemplateName" type="text" style="width:200px;"/>
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

var assessTemplateGrid;
var assessTemplateItemGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var createUser='<%=session.getAttribute("username") %>';
var frameAppId ="<%=request.getParameter("frameAppId") %>";

$().ready(function(){
	init();
});	


function rendererOperation(val, item, rowIndex){      
	var text = '<span class="version-history" style="color:blue;cursor:pointer;"> <i18n:I18n defaultValue="历史" key="i18n_purchase_bargain_history"></i18n:I18n> </span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	return text;
}
//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//指标类型
function rendererAssessmentFlag(val,item,rowIndex){
	if(val == "1" ){
		return "<i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" />";
	}else{
		return "<i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" />";
	}
}

//渲染定量公式
function rendererRationFormula(val,item,rowIndex){
	if(val== "0"){
		return "<i18n:I18n key="i18n_assessrules_select_timelyDeliveryRate" defaultValue="交货及时率" />";
	}else if(val== "1"){
		return "<i18n:I18n key="i18n_assessrules_select_incomingQualifiedRate" defaultValue="入库合格率" />";
	}else{
		return "";
	}
}

var assessTemplateCols = [
                          { title:'<i18n:I18n defaultValue="评估模板编号" key="i18n_assesstemplate_table_assessmentTemplateNumber"></i18n:I18n>', name:'assessmentTemplateNumber' , width:120, align:'center'},
                          { title:'<i18n:I18n defaultValue="评估模板名称" key="i18n_assesstemplate_table_assessmentTemplateName"></i18n:I18n>', name:'assessmentTemplateName' ,width:140, align:'center'},
                          { title:'<i18n:I18n defaultValue="版本号" key="i18n_assesstemplate_table_templateVersionNumber"></i18n:I18n>', name:'templateVersionNumber' ,width:100, align:'center'},
                          { title:'<i18n:I18n defaultValue="评估模板描述" key="i18n_assesstemplate_table_assessmentTemplateDesc"></i18n:I18n>', name:'assessmentTemplateDesc' ,width:140, align:'center'},
                          { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                          { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                          { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
                          { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime}
                   ];
                    
var assessTemplateItemCols = [
                             { title:'<i18n:I18n defaultValue="评估模板项编号" key="i18n_assesstemplate_table_assessmentTemplateItemNumber"></i18n:I18n>', name:'assessmentTemplateItemNumber' , width:120, align:'center'},
                             { title:'<i18n:I18n defaultValue="评估模板项版本号" key="i18n_assesstemplate_table_templateVersionNumber"></i18n:I18n>', name:'templateVersionNumber' ,width:120, align:'center'},
                             { title:'<i18n:I18n defaultValue="评估类型名" key="i18n_assessrules_table_assessmentClassName"></i18n:I18n>', name:'assessmentClassName' ,width:100, align:'center'},
                             { title:'<i18n:I18n defaultValue="评估模板项名" key="i18n_assesstemplate_table_assessmentItemName"></i18n:I18n>', name:'assessmentItemName' ,width:100, align:'center'},
                             { title:'<i18n:I18n defaultValue="评估規則" key="i18n_assessrules_table_assessmentRules"></i18n:I18n>', name:'assessmentRule' ,width:340, align:'center'},
                             { title:'<i18n:I18n key="i18n_assessrules_select_targetType" defaultValue="指标类型" />', name:'assessmentFlag' ,width:120, align:'center',renderer:rendererAssessmentFlag},
             			     { title:'<i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="定量公式" />', name:'fbk1' ,width:120, align:'center',renderer:rendererRationFormula},
                             { title:'<i18n:I18n defaultValue="权重(%)" key="i18n_assesstemplate_table_weight"></i18n:I18n>', name:'weight' ,width:120, align:'center'},
                             { title:'<i18n:I18n defaultValue="评估类型编号" key="i18n_assessrules_table_assessmentClassNumber"></i18n:I18n>', name:'assessmentClassNumber' ,width:120, align:'center',hidden: true},
                             { title:'<i18n:I18n defaultValue="评估项编号" key="i18n_assessrules_lable_assessmentItemNumber"></i18n:I18n>', name:'assessmentItemNumber' ,width:120, align:'center',hidden: true},
                             { title:'<i18n:I18n defaultValue="评估项版本号" key="i18n_assessrules_lable_versionNumber"></i18n:I18n>', name:'versionNumber' ,width:120, align:'center',hidden: true},
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
    assessTemplateItemGrid=$('#table-assessmentItemInfo').mmGrid({
	    cols: assessTemplateItemCols,
	    url: '<%=basePath%>rest/SupplierAssessTemplateService/findAssessTemplateItemList',
	    params: frm.serializeJSON(),
	    height: 200,
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
	                  , limitList: [5,10,15,20]
	              })
	          ]
	});
    
    assessTemplateGrid=$('#table-assessmentClassInfo').mmGrid({
	    cols: assessTemplateCols,
	    url: '<%=basePath%>rest/SupplierAssessTemplateService/findAssessTemplateList',
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
    assessTemplateGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	var selectRows = assessTemplateGrid.selectedRows();
    	if(selectRows.length != 0){
    		loadItem(selectRows[0].assessmentTemplateNumber);
    	}
    });
    assessTemplateGrid.on('loadSuccess',function(e, data) {
    	if (data.rows && data.rows.length > 0) {
    		assessTemplateGrid.select(0);
    		var row = data.rows[0];
    		loadItem(row.assessmentTemplateNumber);
    	}else{
    		assessTemplateItemGrid.removeRow();
    	}
    });
}

function loadItem(assessmentTemplateNumber){
	var param = {
	    	'elsAccount':elsAccount,
	    	'assessmentTemplateNumber':assessmentTemplateNumber
	    };
	assessTemplateItemGrid.opts.params = param;
	assessTemplateItemGrid.load({page:1});
}

function queryIntegrationInfo() {
	var frm = $("#assessmentClassForm");
	assessTemplateGrid.opts.params = frm.serializeJSON();
	assessTemplateGrid.load({page:1});
}

//查询
$("#queryIntegrationInfo").click(function() {
	queryIntegrationInfo();
});

$("#addAssessRules").click(function() {
	var selectRows = assessTemplateGrid.selectedRows();
	if(selectRows.length > 0){
		var assessmentTemplateNumber = selectRows[0].assessmentTemplateNumber;
		var param = {"elsAccount":elsAccount,"assessmentTemplateNumber":assessmentTemplateNumber};
		$.ajax({
			url :"<%=basePath%>rest/SupplierAssessTemplateService/findAssessAllTemplateItemList",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					parent.frames['iframeApp_'+frameAppId].selectTemplateCallbackFunc(data.rows);
				    parent.elsDeskTop.closeCurWin('findAssessTemplate');
				}
			}
	  });
	}else{
		parent.elsDeskTop.closeCurWin('findAssessTemplate');
	}
});


</script>

</body>
</html>
