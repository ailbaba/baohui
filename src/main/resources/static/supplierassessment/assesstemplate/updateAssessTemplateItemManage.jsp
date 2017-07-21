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
			       &nbsp;&nbsp;<span class="assessmentTemplateNumber"><i18n:I18n key="i18n_assesstemplate_table_assessmentTemplateNumber" defaultValue="评估模板编号" />:&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="templateVersionNumber"><i18n:I18n key="i18n_assesstemplate_table_templateVersionNumber" defaultValue="评估模板版本号" />:&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n defaultValue="评估模板名称" key="i18n_assesstemplate_table_assessmentTemplateName"></i18n:I18n>:&nbsp;<input type="text" id="assessmentTemplateName" name="assessmentTemplateName">
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n defaultValue="评估模板描述" key="i18n_assesstemplate_table_assessmentTemplateDesc"></i18n:I18n>:&nbsp;<input type="text" id="assessmentTemplateDesc" name="assessmentTemplateDesc">
		        </div>
		        <div class="dis-in-b input-and-tip">
                   &nbsp;&nbsp;<button id="saveAssessRules" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <input type="hidden" id="elsAccount" name="elsAccount">
            <input type="hidden" id="assessmentTemplateNumber" name="assessmentTemplateNumber">
            <input type="hidden" id="templateVersionNumber" name="templateVersionNumber">
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
                            <button id="findAssessRules" class="button-wrap" ><i18n:I18n key="i18n_common_button_addition" defaultValue="增加" /></button>
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

var assessmentTemplateNumber ="<%=request.getParameter("assessmentTemplateNumber") %>";
var assessmentTemplateName ="<%=request.getParameter("assessmentTemplateName") %>";
var assessmentTemplateDesc ="<%=request.getParameter("assessmentTemplateDesc") %>";
var templateVersionNumber ="<%=request.getParameter("templateVersionNumber") %>";

$().ready(function(){
	$( "#sheet-project").tabs();
	init();
	window.beforeClose = function(close){
	    top.elsDeskTop.tip.init({
	        type            : 'confirm',
	        displayType     : 2, 
	        message         : '确认关闭?',
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
               			   { title:'<i18n:I18n defaultValue="指标类型" key=""></i18n:I18n>', name:'assessmentFlag' ,width:100, align:'center',renderer:function(val){
           			    	var show = "";
           			    	if(val == "1"){
           			    		show = "定量指标";
           			    	}else{
           			    		show = "定性指标";
           			    	}
           				    return "<span>"+show+"</span><input name='supplierAssessmentTemplateItemVOs[][assessmentFlag]'  style='display:none;'  type='text' value='"+val+"'/>";
           			    }},
           			      { title:'<i18n:I18n defaultValue="定量公式" key=""></i18n:I18n>', name:'fbk1' ,width:100, align:'center',renderer:function(val){
           				   var show = "";
           				   if(val== "0"){
           					   return "交货及时率";
           				   }else if(val== "1"){
           					   return "入库合格率";
           				   }
           				   return "<span>"+show+"</span><input name='supplierAssessmentTemplateItemVOs[][fbk1]'  style='display:none;'  type='text' value='"+val+"'/>";
           			   }},
           			       { title:'<i18n:I18n defaultValue="权重(%)" key="i18n_assesstemplate_table_weight"></i18n:I18n>', name:'weight' ,width:100, align:'center', clickDisable:true,renderer:function(val, item, rowIndex){
                   		   return "<input name='supplierAssessmentTemplateItemVOs[][weight]' type='text' class='weight_update' id='weight_"+rowIndex+"' value='"+val+"'/>"+"<span style='display: none;'>"+JSON.stringify(item)+"_$_@_"+rowIndex+"</span>";
                       }},
                           { title:'<i18n:I18n defaultValue="评估規則" key="i18n_assessrules_table_assessmentRules"></i18n:I18n>', name:'assessmentRule' ,width:340, align:'center',renderer:function(val){
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
	$(".assessmentTemplateNumber").append(assessmentTemplateNumber);
	$(".templateVersionNumber").append(templateVersionNumber);
	$("#elsAccount").val(elsAccount);
	$("#assessmentTemplateNumber").val(assessmentTemplateNumber);
	$("#assessmentTemplateName").val(assessmentTemplateName);
	$("#assessmentTemplateDesc").val(assessmentTemplateDesc);
	$("#templateVersionNumber").val(templateVersionNumber);
	$('body').data("isUpdate",false);
    var frm = $("#assessmentClassForm");
    assessmentClassGrid=$('#table-assessmentClassInfo').mmGrid({
	    cols: assessmentClassCols,
	    url: '<%=basePath%>rest/SupplierAssessTemplateService/findAssessAllTemplateItemList',
	    params: frm.serializeJSON(),
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    checkCol:true,
	    multiSelect:true
	});
    assessmentClassGrid.on('loadSuccess',function(e, data) {
    	$('body').data("rows",data.rows);
    	
    	//加载得分处理建议
        assessmentOptionGrid=$('#table-assessmentOptions').mmGrid({
    	    cols: cols_options,
    	    url: '<%=basePath%>rest/SupplierAssessTemplateService/findAssessOptionsItemList',
    	    params: frm.serializeJSON(),
    	    height: 340,
    	    method: 'post',
    	    root: 'rows',
    	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
    	    checkCol:true
    	});
        assessmentOptionGrid.on('loadSuccess',function(e, d) {
        	initItemSelector();
        	bindItemEvent($("#table-assessmentOptions"));
        	bindChange();
    	});
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

function initItemSelector(){
	if(assessmentOptionGrid.rowsLength() > 0){
		$("#table-assessmentOptions").find("tr").each(function(i,o){
			var val = $(this).data("item").options;
			$(this).find("select[name='optionList[][options]']").val(val);
			
			if(i > 0){
				var preScore = $(this).prev("tr").find("input[name='optionList[][score]']").val();
				if(preScore && preScore != ""){
					$(this).find(".right").text("<"+preScore);
				}
			} 
		});		
	}
}

function bindChange(){
	$("#table-assessmentOptions").find("input").change(function(){
		$('body').data("isUpdate",true);
	});
	$("#table-assessmentOptions").find("select").change(function(){
		$('body').data("isUpdate",true);
	});
}

$("#addItem").click(function(){
	$('body').data("isUpdate",true);
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
	$('body').data("isUpdate",true);
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
        'iframSrc':'<%=basePath%>supplierassessment/assessrules/findAssessRules.jsp?frameAppId=updateAssessTemplateItemManage',
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
    	row["assessmentTemplateItemNumber"]="";
    	row["templateVersionNumber"]="1.0v";
    	row["assessmentClassName"]=assessmentClassName;
    	row["weight"]="";
    	assessmentClassGrid.addRow(row);
    	$('body').data("isUpdate",true);
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
	$('body').data("isUpdate",true);
});

/* $('.weight_update').live('blur',function(e) {
	var scanCol = $(this).next();
    var sanContentText = scanCol.text();
    var sanContent = sanContentText.split("_$_@_"); 
    var index = sanContent[1];
    var itemObj = JSON.parse(sanContent[0]);
    var weight = itemObj.weight;
    var newWeight = $("#weight_"+index).val();
    if(weight != newWeight){
    	$('body').data("weightIsUpdate",true);
    }
}); */

$("#saveAssessRules").click(function(){
	var assessmentTemplateNameText = $("#assessmentTemplateName").val();
	var assessmentTemplateDescText = $("#assessmentTemplateDesc").val();
	if(assessmentTemplateNameText == null || assessmentTemplateNameText == ""){
		alert("<i18n:I18n defaultValue="请输入评估评估模块名称" key="i18n_assesstemplate_alert_pleaseEnterTheEvaluationModuleName"/>!",2);
		$("#assessmentTemplateName").focus();
		return;
	}
	var frm = $("#assessmentClassForm");
	var frmObj = frm.serializeJSON();
	//------------判断是否有修改----------begin------------
	if(assessmentTemplateName == assessmentTemplateNameText && assessmentTemplateDescText == assessmentTemplateDesc){
		var isUpdate = $('body').data("isUpdate");
		if(!isUpdate){
			 var rows = $('body').data("rows");
			var frmRows = frmObj.supplierAssessmentTemplateItemVOs;
			var flag = false;
		    for(var i = 0 ; i < rows.length ; i ++){
				var row = rows[i];
				var frmRow = frmRows[i];
				if(row.weight != frmRow.weight){
					flag = true;
				}
			} 
			if(!flag){
				alert('<i18n:I18n defaultValue="您未做任何修改" key="i18n_assesstemplate_alert_youDoNotMakeAnyChanges"/>',2);
				return;
			}
		}
	}
	
	//------------判断是否有修改----------end------------
	var rows = assessmentClassGrid.rows();
	if(rows == ""){
		alert('<i18n:I18n defaultValue="至少添加一条模板明细项目" key="i18n_assesstemplate_alert_addAtLeastOneTemplateSubsidiaryProject"/>',2);
		return;
	}
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
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="保存将会创建新版本，是否继续？" key="i18n_assesstemplate_alert_saveWillCreateANewVersionWhetherToContinue"/>',closeEvent:function(){
	  $.ajax({
		url :"<%=basePath%>rest/SupplierAssessTemplateService/updateAssessTemplate",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(frmObj),
		success : function(data) {
			if(data.statusCode == "-100"){
				alert(data.message,3);
			}else{
				alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
				parent.frames['iframeApp_assessTemplateManage'].queryIntegrationInfo();
			    parent.elsDeskTop.closeCurWin('updateAssessTemplateItemManage');
			}
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
            alert(exception,3); 
        }
      });
	}});
});


</script>

</body>
</html>
