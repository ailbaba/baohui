<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
      <input type="hidden" id="elsAccount" name="elsAccount">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="close" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-file"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>


<script>

var fileGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var versionNumber ="<%=request.getParameter("versionNumber") %>";
var assessmentItemNumber ="<%=request.getParameter("assessmentItemNumber") %>";
var assessmentClassNumber ="<%=request.getParameter("assessmentClassNumber") %>";

$().ready(function(){
	init();
});	

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

function rendererOperation(val, item, rowIndex){
	var text = '';
	if(item.versionNumber != versionNumber){
		text += '<span class="version-rollback" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_title_rollBack" defaultValue="回退" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>&nbsp;&nbsp;'
	}
	return text;
}
//变更文档版本
$('.version-rollback').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_assesstemplate_alert_confirmBackToTheCurrentVersion" defaultValue="确认回退到当前版本？" />',closeEvent:function(){
     $.ajax({
		url :"<%=basePath%>rest/SupplierAssessmentClassService/assessmentVersionRollback",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(item),
		success : function(data) {
			if(data.statusCode == "-100"){
				alert(data.message,3);
			}else{
				alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
			    closeWin();
			}
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
            alert(exception,3); 
        }
	  });
    }});
    
});

function closeWin(){
	parent.frames['iframeApp_assessItemManage'].queryIntegrationInfo();
    parent.elsDeskTop.closeCurWin('assessItemManageVersionHistory');
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
		return "交货及时率";
	}else if(val== "1"){
		return "入库合格率";
	}else{
		return "";
	}
}

/* var fileCols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="fileManageCenter_his"/>;
 */
 var fileCols = [
                   { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' ,clickDisable:true, width:120, align:'center',renderer: rendererOperation},
                   { title:'<i18n:I18n key="i18n_assessrules_lable_assessmentItemNumber" defaultValue="评估项编号" />', name:'assessmentItemNumber' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="评估项名称" key="i18n_assessrules_lable_assessmentItemName"></i18n:I18n>', name:'assessmentItemName' , width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="评估项版本号" key="i18n_assessrules_lable_versionNumber"></i18n:I18n>', name:'versionNumber' , width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_assessrules_table_assessmentRules" defaultValue="评估规则" />', name:'assessmentRule' ,width:400, align:'center'},
                   { title:'<i18n:I18n key="i18n_assessrules_select_targetType" defaultValue="指标类型" />', name:'assessmentFlag' ,width:120, align:'center',renderer:rendererAssessmentFlag},
   			       { title:'<i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="定量公式" />', name:'fbk1' ,width:120, align:'center',renderer:rendererRationFormula},
                   { title:'<i18n:I18n defaultValue="创建人" key="i18n_common_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:140, align:'center',renderer:rendererTime},
                   { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' , width:140, align:'center',renderer:rendererTime},
            ];

function init(){
	$("#elsAccount").val(elsAccount);
	param = {"assessmentItemNumber":assessmentItemNumber,"elsAccount":elsAccount,"assessmentClassNumber":assessmentClassNumber};
	 //初始化控件
    $('button').button();
    fileGrid=$('#table-file').mmGrid({
	    cols: fileCols,
	    url: '<%=basePath%>rest/SupplierAssessmentClassService/findAssessmentClassListHis',
	    params: param,
	    height: 320,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
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
                  , limitList: [10,20]
              })
          ]
	});
    
}

$("#close").click(function(){
	parent.elsDeskTop.closeCurWin('fileVersionHistory');
});

//列自定义
$("#columnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     'windowSubTitle': "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=fileManageCenter_his" + "&window=iframeApp_fileVersionHistory",
	     'windowMinWidth': 480,
	     'windowMinHeight': 600,
	     'windowPositionTop':10,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	});
});

</script>

</body>
</html>
