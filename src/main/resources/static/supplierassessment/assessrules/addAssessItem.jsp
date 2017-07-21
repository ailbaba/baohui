<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
     <form id="assessmentClassForm" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_assessrules_lable_assessmentItemName" defaultValue="评估信息"/></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="assessmentTemplateNumber"><i18n:I18n key="i18n_assessrules_table_assessmentClassNumber" defaultValue="评估类型编号"/>:<i18n:I18n key="i18n_assessrules_lable_automaticNumbering" defaultValue="自動編號"/>&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="templateVersionNumber"><i18n:I18n key="i18n_assessrules_lable_versionNumber" defaultValue="评估版本号"/>:1.0v&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n key="i18n_assessrules_table_assessmentClassName" defaultValue="评估类型名称"/>:&nbsp;<input type="text" id="assessmentClassName" name="assessmentClassName">&nbsp;<span style="color: red">*</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n key="i18n_common_label_describe" defaultValue="描述" />:&nbsp;<input type="text" id="remark" name="remark">
		        </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
		        <div class="dis-in-b input-and-tip">
                     <button id="findAssessRules" class="button-wrap" ><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteAssessRules" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="saveAssessRules" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <input type="hidden" id="elsAccount" name="elsAccount">
            <input type="hidden" id="pageSize" name="pageSize" value="10">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-assessmentClassInfo"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
     </form>
</div>


<script>
var assessmentClassGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';

$().ready(function(){
	init();
	
	function close() {}
	window.beforeClose = function(close){
	    top.elsDeskTop.tip.init({
	        type            : 'confirm',
	        displayType     : 2, 
	        message         : '<i18n:I18n key="i18n_common_alert_confirmTheShutDown" defaultValue="确认关闭" />?',
	        closeEvent : function () {
	           close();
	        }
	    });
	}; 
});	
//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//渲染定量公式
function rendererAssessmentFlag(val,item,rowIndex){
	var sel = "<div><select class='select-assessmentFlag' name='supplierAssessmentItemVOs[][assessmentFlag]'>";
	if(val == "0"){
		return sel+"<option value='0' selected ><i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" /></option><option value='1'><i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" /></option></select></div>";
	}else{
		return sel+"<option value='0' ><i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" /></option><option value='1' selected><i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" /></option></select></div>";
	}
}

//指标类型
function rendererRationFormula(val,item,rowIndex){
	if(item.assessmentFlag == "0"){
		return "";
	}else{
		return "<select name='supplierAssessmentItemVOs[][fbk1]'><option value='0'><i18n:I18n key="i18n_assessrules_select_timelyDeliveryRate" defaultValue="交货及时率" /></option><option value='1'><i18n:I18n key="i18n_assessrules_select_incomingQualifiedRate" defaultValue="入库合格率" /></option></select>";
	}
}

$('.select-assessmentFlag').live('change',function(e) {
	var value = $(this).find("option:selected").val();
	var rowIndex = $(this).closest("tr").index();
    var frmObj = $("#assessmentClassForm").serializeJSON(); 
	var rows = frmObj.supplierAssessmentItemVOs;
    rows[rowIndex]["assessmentFlag"]=value;
    assessmentClassGrid.updateRow(rows[rowIndex],rowIndex);
});

var assessmentClassCols = [
	                       { title:'<i18n:I18n key="i18n_assessrules_lable_assessmentItemName" defaultValue="评估项名" />', name:'assessmentItemName' ,width:200, align:'center',renderer:function(val){
	           				return "<input name='supplierAssessmentItemVOs[][assessmentItemName]'   type='text' value='"+val+"'/>";
           			     }},
           			    { title:'<i18n:I18n key="i18n_assessrules_select_targetType" defaultValue="指标类型" />', name:'assessmentFlag' ,width:120, align:'center',clickDisable:true,renderer:rendererAssessmentFlag},
        			    { title:'<i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="定量公式" />', name:'fbk1' ,width:120, align:'center',clickDisable:true,renderer:rendererRationFormula},
                           { title:'<i18n:I18n key="i18n_assessrules_table_assessmentRules" defaultValue="评估规则" />', name:'assessmentRule' ,width:400, align:'center',renderer:function(val){
               				return "<input name='supplierAssessmentItemVOs[][assessmentRule]'   type='text' value='"+val+"'/>";
               			}}
                    ];

function init(){
	$("#elsAccount").val(elsAccount);
    var frm = $("#assessmentClassForm");
    assessmentClassGrid=$('#table-assessmentClassInfo').mmGrid({
	    cols: assessmentClassCols,
	    url: '',
	    params: frm.serializeJSON(),
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    checkCol:true,
	    multiSelect:true
	});
} 


$("#findAssessRules").click(function(){
	var row={"assessmentItemName" :"","assessmentRule":"","assessmentFlag":"0","fbk1":""};
	assessmentClassGrid.addRow(row);
});
$("#deleteAssessRules").click(function(){
	var selectRows = assessmentClassGrid.selectedRows();
	if(selectRows.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var indexs = assessmentClassGrid.selectedRowsIndex();
	assessmentClassGrid.removeRow(indexs);
});

$("#saveAssessRules").click(function(){

	var assessmentClassName = $("#assessmentClassName").val();
	if(assessmentClassName == null || assessmentClassName == ""){
		alert('<i18n:I18n defaultValue="请输入评估类型名！" key="i18n_assessrules_alert_pleaseEnterTheEvaluationTypeName"/>',2);
		$("#assessmentClassName").focus();
		return;
	}
	var frm = $("#assessmentClassForm");
	var frmObj = frm.serializeJSON();
	var rows = frmObj.supplierAssessmentItemVOs;
	if(rows == null){
		alert("<i18n:I18n defaultValue="至少添加一条评估明细项！" key="i18n_assessrules_alert_addAtLeastOneAssessmentItemDetail"/>",2);
		return;
	}else{
		for(var i = 0 ; i < rows.length ; i ++){
			var row = rows[i];
			var assessmentItemName = row.assessmentItemName;
			if(assessmentItemName == "" || assessmentItemName == null){
				alert("<i18n:I18n defaultValue="评估项名称不能为空！" key="i18n_assessrules_alert_evaluateNameCannotBeEmpty"/>",2);
				return;
			}
			var assessmentRule = row.assessmentRule;
			if(assessmentRule == "" || assessmentRule == null){
				alert("<i18n:I18n defaultValue="评估项规则不能为空！" key="i18n_assessrules_alert_assessmentRulesCannotBeEmpty"/>",2);
				return;
			}
		}
		
	}

	$.ajax({
		url :"<%=basePath%>rest/SupplierAssessmentClassService/addAssessmentClass",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(frm.serializeJSON()),
		success : function(data) {
			if(data.statusCode == "-100"){
				alert(data.message,3);
			}else{
				alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
				parent.frames['iframeApp_assessRulesManage'].queryIntegrationInfo();
			    parent.elsDeskTop.closeCurWin('addAssessItem');
			}
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
            alert(exception,3); 
        }
  });
});


</script>

</body>
</html>
