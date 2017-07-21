<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_enquiry_title_supplierinformation" defaultValue="供应商信息" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="toElsAccount"><i18n:I18n key="i18n_enquiry_label_supplierElsAccount" defaultValue="供应商ELS账号" />:&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="toCompanyShortName"><i18n:I18n key="i18n_enquiry_label_supplierName" defaultValue="供应商名称" />:&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="grades" ><i18n:I18n key="i18n__supplierrassessreport_table_averageScore" defaultValue="平均得分" />:&nbsp;</span>
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
var assessmentNumber ="<%=request.getParameter("assessmentNumber") %>";
var toElsAccount ="<%=request.getParameter("toElsAccount") %>";
var toCompanyShortName ="<%=request.getParameter("toCompanyShortName") %>";
var grades ="<%=request.getParameter("grades") %>";

$().ready(function(){
	init();
});	


//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

var assessTemplateCols = [
                          { title:'<i18n:I18n key="i18n_label_elsAccount" defaultValue="ELS账号" />', name:'elsAccount' , width:120, align:'center'},
                          { title:'<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号" />', name:'elsSubAccount' ,width:120, align:'center'},
                          { title:'<i18n:I18n key="i18n_supplierrassessreport_lable_ScorePerson" defaultValue="评分人" />', name:'userName' ,width:100, align:'center'},
                          { title:'<i18n:I18n key="i18n__supplierrassessreport_table_evaluationNumber" defaultValue="评估编号" />', name:'assessmentNumber' ,width:140, align:'center'},
                          { title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoringTime" defaultValue="评分时间" />', name:'logtime' ,width:140, align:'center',renderer:rendererTime},
                          { title:'<i18n:I18n key="i18n__supplierrassessreport_table_score" defaultValue="评分" />', name:'grades' ,width:140, align:'center'}
                   ];
                    
var assessTemplateItemCols = [
                              { title:'<i18n:I18n key="i18n_assesstemplate_table_assessmentTemplateNumber" defaultValue="评估模版编号" />', name:'assessmentNumber' , width:120, align:'center'},
                             { title:'<i18n:I18n key="i18n_assessrules_table_assessmentClassName" defaultValue="评估类型名" />', name:'assessmentClassName' ,width:150, align:'center'},
                             { title:'<i18n:I18n key="i18n_assesstemplate_table_assessmentItemName" defaultValue="评估模板项名" />', name:'assessmentItemName' ,width:250, align:'center'},
                             { title:'<i18n:I18n key="i18n_assesstemplate_table_weight" defaultValue="权重(%)" />', name:'share' ,width:80, align:'center'},
                             { title:'<i18n:I18n key="i18n__supplierrassessreport_table_score" defaultValue="评分" />', name:'grades' ,width:80, align:'center'},
                             { title:'<i18n:I18n key="i18n__supplierrassessreport_table_getScore" defaultValue="得分" />', name:'meterScores' ,width:80, align:'center'}
                      ];          

function init(){
	
	$(".toElsAccount").append(toElsAccount);
	$(".toCompanyShortName").append(toCompanyShortName);
	$(".grades").append(grades);
	
	var param = {"elsAccount":elsAccount,"assessmentNumber":assessmentNumber,"toElsAccount":toElsAccount,"elsSubAccount":""};
    
    assessTemplateItemGrid=$('#table-assessmentItemInfo').mmGrid({
	    cols: assessTemplateItemCols,
	    url: '<%=basePath%>rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentItemDetailsResult',
	    params: param,
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
	    url: '<%=basePath%>rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentDetailsResult',
	    params: param,
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
    		loadItem(selectRows[0].assessmentNumber,selectRows[0].elsSubAccount);
    	}
    });
    assessTemplateGrid.on('loadSuccess',function(e, data) {
    	if (data.rows && data.rows.length > 0) {
    		assessTemplateGrid.select(0);
    		var row = data.rows[0];
    		loadItem(row.assessmentNumber,row.elsSubAccount);
    	}else{
    		assessTemplateItemGrid.removeRow();
    	}
    });
}

function loadItem(assessmentNumber,elsSubAccount){
	var param = {
	    	'toElsAccount':toElsAccount,
	    	'elsAccount':elsAccount,
	    	'assessmentNumber':assessmentNumber,
	    	'elsSubAccount':elsSubAccount
	    };
	assessTemplateItemGrid.opts.params = param;
	assessTemplateItemGrid.load({page:1});
}



</script>

</body>
</html>
