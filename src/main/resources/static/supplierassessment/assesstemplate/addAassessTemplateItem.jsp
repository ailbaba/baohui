<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
     <form id="assessmentClassForm" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_assesstemplate_table_evaluationTemplateInformation" defaultValue="评估模板信息" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="assessmentTemplateNumber"><i18n:I18n key="i18n_assesstemplate_table_assessmentTemplateNumber" defaultValue="评估模板编号" />:<i18n:I18n key="i18n_assessrules_lable_automaticNumbering" defaultValue="自动编号" />&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="templateVersionNumber"><i18n:I18n key="i18n_assesstemplate_table_templateVersionNumber" defaultValue="评估模板版本号" />:1.0v&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n defaultValue="评估模板名称" key="i18n_assesstemplate_table_assessmentTemplateName"></i18n:I18n>:&nbsp;<input type="text" id="assessmentTemplateName" name="assessmentTemplateName">&nbsp;<span style="color: red">*</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n defaultValue="评估模板描述" key="i18n_assesstemplate_table_assessmentTemplateDesc"></i18n:I18n>:&nbsp;<input type="text" id="assessmentTemplateDesc" name="assessmentTemplateDesc">
		        </div>
		        <div class="dis-in-b input-and-tip">
                   &nbsp;&nbsp;<button id="saveAssessRules" class="button-wrap"><i18n:I18n defaultValue="保存" key="i18n_button_save"/></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
        <input type="hidden" id="elsAccount" name="elsAccount">
        <input type="hidden" id="pageSize" name="pageSize" value="10">
		<input type="hidden" id="currentPage" name="currentPage" value="1">
		<div class="common-box-line">
        <div class="tab-wrap" id="sheet-project">
			<ul>
				<li><a href="#sheet-item-one">模板明细</a></li>
				<li><a href="#sheet-item-two">评分建议</a></li>
			</ul>
			<div id="sheet-item-one">
                  <div class="edit-box-wrap">
	              <div class="dis-in-b input-and-tip">
                        <button id="findAssessRules" class="button-wrap" ><i18n:I18n defaultValue="增加" key="i18n_common_button_addition"/></button>
                     </div>
                     <div class="dis-in-b input-and-tip">
                        <button id="deleteAssessRules" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                     </div>
                  </div>
                  <main class="grid-container">
                     <div class="grid-100">
                        <table id="table-assessmentClassInfo"></table>
                        <div id="pg" style="text-align: right;"></div>
                     </div>
                  </main>
		    </div>
		    <div id="sheet-item-two">
				<div class="edit-box-wrap">
				<div class="dis-in-b input-and-tip">
				    <button class="button-wrap edit-btn" id="addItem">添加</button>
					<button class="button-wrap edit-btn" id="deleteItem">移除</button>
				</div>
				</div>
				<main class="grid-container">
					<div class="grid-100">
						<table id="table-assessmentOptions"></table>
					</div>
				</main>
		   </div>
	    </div>
	    </div>
        </div>
     </form>
</div>


<script>

var assessmentClassGrid;
var assessmentOptionGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';

$().ready(function(){
	$( "#sheet-project").tabs();
	init();
	window.beforeClose = function(close){
	    top.elsDeskTop.tip.init({
	        type            : 'confirm',
	        displayType     : 2, 
	        message         :'<i18n:I18n key="i18n_common_alert_confirmTheShutDown" defaultValue="确认关闭" />?',
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

var assessmentClassCols = [
                           { title:'<i18n:I18n defaultValue="评估模板项编号" key="i18n_assesstemplate_table_assessmentTemplateItemNumber"></i18n:I18n>', name:'assessmentTemplateItemNumber' , width:120, align:'center',renderer:function(val){
                				return "<span>"+val+"</span><input name='supplierAssessmentTemplateItemVOs[][assessmentTemplateItemNumber]'  style='display:none;'  type='text' value='"+val+"'/>";
                			}},
                           { title:'<i18n:I18n defaultValue="评估模板项版本号" key="i18n_assesstemplate_table_templateVersionNumber"></i18n:I18n>', name:'templateVersionNumber' ,width:100, align:'center',renderer:function(val){
               				return "<span>"+val+"</span><input name='supplierAssessmentTemplateItemVOs[][templateVersionNumber]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}},
                           { title:'<i18n:I18n defaultValue="评估类型名" key="i18n_assessrules_table_assessmentClassName"></i18n:I18n>', name:'assessmentClassName' ,width:120, align:'center',renderer:function(val){
               				return "<span>"+val+"</span><input name='supplierAssessmentTemplateItemVOs[][assessmentClassName]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}},
                           { title:'<i18n:I18n defaultValue="评估模板项名" key="i18n_assesstemplate_table_assessmentItemName"></i18n:I18n>', name:'assessmentItemName' ,width:120, align:'center',renderer:function(val){
               				return "<span>"+val+"</span><input name='supplierAssessmentTemplateItemVOs[][assessmentItemName]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}},
               			    { title:'<i18n:I18n defaultValue="指标类型" key="i18n_assessrules_select_targetType"></i18n:I18n>', name:'assessmentFlag' ,width:100, align:'center',renderer:function(val){
               			    	var show = "";
               			    	if(val == "1"){
               			    		show = "<i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" />";
               			    	}else{
               			    		show = "<i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" />";
               			    	}
               				return "<span>"+show+"</span><input name='supplierAssessmentTemplateItemVOs[][assessmentFlag]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}},
               			   { title:'<i18n:I18n defaultValue="定量公式" key="i18n_assessrules_select_theQuantitativeFormula"></i18n:I18n>', name:'fbk1' ,width:100, align:'center',renderer:function(val){
               				   var show = "";
               				   if(val== "0"){
               					   show = "<i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="交货及时率" />";
               				   }else if(val== "1"){
               					   show = "<i18n:I18n key="i18n_assessrules_select_incomingQualifiedRate" defaultValue="入库合格率" />";
               				   }
               				   return "<span>"+show+"</span><input name='supplierAssessmentTemplateItemVOs[][fbk1]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}},
               			   { title:'<i18n:I18n defaultValue="权重(%)" key="i18n_assesstemplate_table_weight"></i18n:I18n>', name:'weight' ,width:120, align:'center', clickDisable:true,renderer:function(val){
                       		return "<input name='supplierAssessmentTemplateItemVOs[][weight]' type='text' onkeyup='value=value.replace(/[^(\\d\\.)]/g,\"\")' value='"+val+"'/>";
                       	}},
                           { title:'<i18n:I18n defaultValue="评估規則" key="i18n_assessrules_table_assessmentRules"></i18n:I18n>', name:'assessmentRule' ,width:300, align:'center',renderer:function(val){
               				return "<span>"+val+"</span><input name='supplierAssessmentTemplateItemVOs[][assessmentRule]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}},
                           { title:'<i18n:I18n defaultValue="评估类型编号" key="i18n_assessrules_table_assessmentClassNumber"></i18n:I18n>', name:'assessmentClassNumber' ,width:120, align:'center',hidden: true,renderer:function(val){
               				return "<span>"+val+"</span><input name='supplierAssessmentTemplateItemVOs[][assessmentClassNumber]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}},
                           { title:'<i18n:I18n defaultValue="评估项编号" key="i18n_assessrules_lable_assessmentItemNumber"></i18n:I18n>', name:'assessmentItemNumber' ,width:120, align:'center',hidden: true,renderer:function(val){
               				return "<span>"+val+"</span><input name='supplierAssessmentTemplateItemVOs[][assessmentItemNumber]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}},
                           { title:'<i18n:I18n defaultValue="评估项版本号" key="i18n_assessrules_lable_versionNumber"></i18n:I18n>', name:'versionNumber' ,width:120, align:'center',hidden: true,renderer:function(val){
               				return "<span>"+val+"</span><input name='supplierAssessmentTemplateItemVOs[][versionNumber]'  style='display:none;'  type='text' value='"+val+"'/>";
               			}}
                    ];
                    
var cols_options = [
    				{title:'编号',name:'optionNumber', width: 120, align: 'center',hidden:true, renderer:function(val){
   				     return val + "<input name='optionList[][optionNumber]' type='hidden' value='"+val+"'/>";
   				    }},
     				{title:'最终得分',name:'score', width: 180, align: 'center',renderer:function(val,item,rowIndex){
     					var rightLogic = "&lt;";
     					var rightScore = "";
     					if(rowIndex == 0){
     						rightLogic = "≤";
     						rightScore = "100";
     					}else {
     						var preScore = $("#table-assessmentOptions").find("tr").eq(rowIndex-1).find("input[name='optionList[][score]']").val();
     						if(preScore && preScore != ""){
     							rightScore = preScore;
     						} 
     					}
     				     return "<div class='s_i_a'><span>≥</span>" + 
     				            "<input name='optionList[][score]' type='text' value='"+val+"'/>," + 
     				            "<span class='right'>" + rightLogic + rightScore + "</span></div>";
     				}},
     				{title:'等级判定',name:'level', width: 200, align: 'center',renderer:function(val){
     					 return "<input name='optionList[][level]' type='text' value='"+val+"'/>";
     				}},
     				{title:'建议处理方式',name:'options', width: 120, align: 'center',renderer:function(val){
     					return "<select name='optionList[][options]'>" + 
     					       "<option value='0'>无</option>" + 
     					       "<option value='1'>冻结</option>" + 
     					       "<option value='2'>转失效</option>" +
     					       "<option value='3'>转潜在</option>" +
     					       "</select>";
     				}}
     			   ];

var blankOptionsRow = {"optionNumber":"1","score":"0","level":"","options":"0"};

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
    
    assessmentOptionGrid=$('#table-assessmentOptions').mmGrid({
	    cols: cols_options,
	    height: 340,
        items: [],
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    checkCol:true
	});
    assessmentOptionGrid.on('loadSuccess',function(e, d) {
    	bindItemEvent($("#table-assessmentOptions"));
	});
}

function bindItemEvent($obj){
	$obj.find("input[name='optionList[][score]']").keyup(function(){
		$this=$(this);
		var val = $this.val();
		if (isNaN(val)) {
			$this.val("");
			return;
		}
		if(val > 0){
			var next=$this.parents('tr:first').next().find('.s_i_a>.right');
			if(next.length)next.text(next.text().replace(/\d+/,val))
		}
	});
}

$("#addItem").click(function(){
	//取出最大的 optionNumber
	var optionNumber = 0;
	$("#table-assessmentOptions").find("tr").each(function(i,o){
		var temOptionNumber = parseInt($(this).find("input[name='optionList[][optionNumber]']").val());
		if(optionNumber < temOptionNumber)
			optionNumber = temOptionNumber;
	});
	//添加一行
	var newRow = $.extend({}, blankOptionsRow);
	newRow.optionNumber = optionNumber + 1;
	assessmentOptionGrid.addRow(newRow,assessmentOptionGrid.rowsLength());
	var $last = $("#table-assessmentOptions").find("tr").eq(assessmentOptionGrid.rowsLength()-1);
	bindItemEvent($last);
});

$("#deleteItem").click(function(){
	var selectRows = assessmentOptionGrid.selectedRows();
	if(selectRows.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	if(assessmentOptionGrid.rowsLength() > 1){
		var index = assessmentOptionGrid.selectedRowsIndex()[0];
        if(index == assessmentOptionGrid.rowsLength()-1){
			$("#table-assessmentOptions .selected").prev("tr").find("input[name='optionList[][score]']").val("0");
		}else{
			var right = $("#table-assessmentOptions .selected").find(".right").text();
			$("#table-assessmentOptions .selected").next("tr").find(".right").text(right);
		}
	}
	assessmentOptionGrid.removeRow(index);
});

$("#findAssessRules").click(function(){
    //兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'findAssessRules',
        'windowTitle':'<i18n:I18n key="i18n_assesstemplate_alert_selectAssessmentTypes" defaultValue="选择评估类型"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>supplierassessment/assessrules/findAssessRules.jsp?frameAppId=addAassessTemplateItem',
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 620,
        'windowPositionTop':0,
        'windowWidth':960,
        'windowHeight':620,
        'parentPanel':".currDesktop"
    });
});
//选择评估项回调函数
function callbackFun(selectRows,rows){
	var assessmentClassName = rows[0].assessmentClassName;
    for(var i = 0 ; i < selectRows.length; i ++){
    	var row = selectRows[i];
    	row["assessmentTemplateItemNumber"]="<i18n:I18n defaultValue="自动编号" key="i18n_assessrules_lable_automaticNumbering"/>";
    	row["templateVersionNumber"]="1.0v";
    	row["assessmentClassName"]=assessmentClassName;
    	row["weight"]="";
    	assessmentClassGrid.addRow(row);
    }	
}

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
	var assessmentTemplateName = $("#assessmentTemplateName").val();
	if(assessmentTemplateName == null || assessmentTemplateName == ""){
		alert('<i18n:I18n defaultValue="请输入评估模块名称！" key="i18n_assesstemplate_alert_pleaseEnterTheEvaluationModuleName"/>!',2);
		$("#assessmentTemplateName").focus();
		return;
	}
	var frm = $("#assessmentClassForm");
	
	var rows = assessmentClassGrid.rows();
	if(rows == ""){
		alert('<i18n:I18n defaultValue="至少添加一条模板明细项目！" key="i18n_assesstemplate_alert_addAtLeastOneTemplateSubsidiaryProject"/>',2);
		return;
	}
	
	var frmObj = frm.serializeJSON();
	var rows = frmObj.supplierAssessmentTemplateItemVOs;
	var total = 0;
	for(var i = 0 ; i < rows.length; i ++){
		var row = rows[i];
		var weight = row.weight;
		if(weight == ""){
			alert('<i18n:I18n defaultValue="权重不能为空" key="i18n_assesstemplate_alert_weightCantBeEmpty"/>',2);
			return;
		}
		total += parseInt(weight);
	}
	if(total != 100){
		alert('<i18n:I18n defaultValue="各项权重之和必须等于100" key="i18n_assesstemplate_alert_allWeightsMustBeEqualToTheSumOfOneHundred"/>',2);
		return;
	}
	  $.ajax({
		url :"<%=basePath%>rest/SupplierAssessTemplateService/addAssessTemplate",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(frmObj),
		success : function(data) {
			if(data.statusCode == "-100"){
				alert(data.message,3);
			}else{
				alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
				parent.frames['iframeApp_assessTemplateManage'].queryIntegrationInfo();
			    parent.elsDeskTop.closeCurWin('addAassessTemplateItem');
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