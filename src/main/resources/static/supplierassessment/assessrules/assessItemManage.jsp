<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
<form id="assessmentClassForm" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_assessrules_lable_theArticleReviewsTheColumnInformation" defaultValue="考评条列信息" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="assessmentClassNumber"><i18n:I18n key="i18n_assessrules_table_assessmentClassNumber" defaultValue="评估类型编号" />:&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span class="assessmentClassName"><i18n:I18n key="i18n_assessrules_table_assessmentClassName" defaultValue="评估类型名称" />:&nbsp;</span>
		        </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
           
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="assessmentClassNumber" name="assessmentClassNumber">
                <input type="hidden" id="assessmentClassName" name="assessmentClassName">
                <input type="hidden" id="assessmentItemNumber" name="assessmentItemNumber">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_assessrules_lable_assessmentItemNumber" defaultValue="评估项编号:" /></span>
			       <input id="assessmentItemNumber" name="assessmentItemNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_assessrules_lable_assessmentItemName" defaultValue="评估项名称:" /></span>
			       <input id="assessmentItemName" name="assessmentItemName" type="text" style="width:200px;"/>
		        </div>
              
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryIntegrationInfo" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="addIntegrationInfo" class="button-wrap" ><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteItemManage" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
             <div class="dis-in-b input-and-tip">
                     <button id="saveAssessRules" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
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
        </form>
</div>

<div class="fixed-dialog" id="integrationInfoDialog" >
	<div class="dialog-tip bg-common" style="width: 353px;height: 220px;margin-left: -201px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="integrationInfoDialogDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/destop-icon/desktop_icon_93.gif" />
	        <span class="integrationInfoDialogTitle"></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	          <span class="dis-in-b pos-absolute box-tip bg-common"></span>
	          <form id="addIntegrationInfoForm">
	            <input type="hidden" id="hidden_elsAccount" name="elsAccount">
	            <input type="hidden" id="hidden_assessmentClassNumber" name="assessmentClassNumber">
	            <input type="hidden" id="hidden_assessmentClassName" name="assessmentClassName">
	            <input type="hidden" id="hidden_assessmentItemNumber" name="supplierAssessmentItemVOs[][assessmentItemNumber]">
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td ><i18n:I18n key="i18n_assessrules_lable_assessmentItemName" defaultValue="评估项名:" />:</td>
	                		<td><textarea rows="2" cols="100" type="text" id="add_assessmentItemName" name="supplierAssessmentItemVOs[][assessmentItemName]" ></textarea></td>
	                	</tr>
	                	
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n key="i18n_assessrules_table_assessmentRules" defaultValue="评估规则" />:</td>
	                		<td><textarea rows="3" cols="100"  type="text" id="add_assessmentRule" name="supplierAssessmentItemVOs[][assessmentRule]"></textarea></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n key="i18n_assessrules_select_targetType" defaultValue="指标类型" />:</td>
	                		<td><select id="add_assessmentFlag" name="supplierAssessmentItemVOs[][assessmentFlag]">
	                		     <option value="0"><i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" /></option>
	                		     <option value="1"><i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" /></option>
	                		    </select>
	                		</td>
	                	</tr>
	                	<tr class="line-height-tr show-fbk1">
	                	
	                	</tr>
	                </table>
	            </div>
	            </form>
	            <div class="mt-20 text-center" >
	                <button id="integrationInfoOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                <button id="integrationInfoCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	            </div>
	        </div>
    </div>
</div>

<script>
var assessmentClassGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var assessmentClassNumber ="<%=request.getParameter("assessmentClassNumber") %>";
var assessmentClassName ="<%=request.getParameter("assessmentClassName") %>";
$("#assessmentClassName").val(assessmentClassName);
   var isFirst=false;
$().ready(function(){
	init();
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


function rendererOperation(val, item, rowIndex){
	var text =""
	if(item.assessmentItemNumber !=""){
		text = '<span class="version-history" style="color:blue;cursor:pointer;"><i18n:I18n key='i18n_purchase_bargain_history' defaultValue='历史' /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
        +'&nbsp;&nbsp;<span class="loadAssessmentItem" style="color:blue;cursor:pointer;"><i18n:I18n key='i18n_title_VersionUpdating' defaultValue='版本更新' /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	}
	return text;
}	

//变更文档版本
$('.loadAssessmentItem').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
	$("#add_assessmentItemName").val(item.assessmentItemName);
	$("#add_assessmentRule").val(item.assessmentRule);
    $("#hidden_assessmentItemNumber").val(item.assessmentItemNumber);
    $("#add_assessmentFlag").val(item.assessmentFlag);
    if(item.assessmentFlag == "1"){
    	var sel = '<td><i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="定量公式" />:</td>'+
    			  '<td><select id="add_fbk1" name="supplierAssessmentItemVOs[][fbk1]">';
    	if(item.fbk1 == "0"){
    		sel += '<option value="0" selected ><i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="交货及时率" /></option><option value="1"><i18n:I18n key="i18n_assessrules_select_incomingQualifiedRate" defaultValue="入库合格率" /></option></select></td>';
    	}else{
    		sel += '<option value="0"  ><i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="交货及时率" /></option><option value="1" selected><i18n:I18n key="i18n_assessrules_select_incomingQualifiedRate" defaultValue="入库合格率" /></option></select></td>';
    	}
    	$(".show-fbk1").html(sel);
    }

    $('body').data("operationType","update");
    $(".integrationInfoDialogTitle").html("<i18n:I18n key='i18n_title_VersionUpdating' defaultValue='版本更新' />:"+item.assessmentItemNumber+" "+item.versionNumber);
	$("#integrationInfoDialog").show();
});
 
//查看考评版本历史
$('.version-history').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    //兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
        'windowsId':'assessItemManageVersionHistory',
        'windowTitle':"<i18n:I18n key='i18n_assessrules_title_evaluationVersionHistoryRecords' defaultValue='考评历史版本记录' />",
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>supplierassessment/assessrules/assessItemManageVersionHistory.jsp?assessmentItemNumber='+item.assessmentItemNumber+'&versionNumber='+item.versionNumber+'&assessmentClassNumber='+item.assessmentClassNumber,
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 500,
        'windowPositionTop':24,
        'windowWidth':960,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
    
});



//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//渲染定量公式
function rendererAssessmentFlag(val,item,rowIndex){
	if(item.assessmentItemNumber != ""){
		if(val == "0"){
			return '<i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" />';
		}else{
			return '<i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" />';
		}
	}else{
		var sel = "<div><select class='select-assessmentFlag' name='supplierAssessmentItemVOs[][assessmentFlag]'>";
		if(val == "0"){
			return sel+'<option value="0" selected ><i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" /></option><option value="1"><i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" /></option></select></div>';
		}else{
			return sel+'<option value="0" ><i18n:I18n key="i18n_assessrules_select_qualitativeIndex" defaultValue="定性指标" /></option><option value="1" selected><i18n:I18n key="i18n_assessrules_lable_quantitativeIndex" defaultValue="定量指标" /></option></select></div>';
		}
	}
}

//指标类型
function rendererRationFormula(val,item,rowIndex){
	if(item.assessmentItemNumber != ""){
		if(val == "0"){
			return '<i18n:I18n key="i18n_assessrules_select_timelyDeliveryRate" defaultValue="交货及时率" />';
		}else if(val == "1"){
			return '<i18n:I18n key="i18n_assessrules_select_incomingQualifiedRate" defaultValue="入库合格率" />';
		}else{
			return "";
		}
	}else{
		if(item.assessmentFlag == "0"){
			return "";
		}else{
			return "<select name='supplierAssessmentItemVOs[][fbk1]'><option value='0'>交货及时率</option><option value='1'><i18n:I18n key="i18n_assessrules_select_incomingQualifiedRate" defaultValue="入库合格率" /></option></select>";
		}
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
                           { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:120,clickDisable:true, align:'center',renderer: rendererOperation},
                           { title:'<i18n:I18n key="i18n_assessrules_lable_assessmentItemNumber" defaultValue="评估项编号" />', name:'assessmentItemNumber', width:120, align:'center',renderer:function(val){
                 				return val+"<input name='supplierAssessmentItemVOs[][assessmentItemNumber]' style='display:none;' type='text' value='"+val+"'/>";}},
                           { title:'<i18n:I18n key="i18n_assessrules_lable_assessmentItemName" defaultValue="评估项名" />', name:'assessmentItemName' ,width:200, align:'center',renderer:function(val,item,rowIndex){
                        	   var text="";
                        	   if(item.assessmentItemNumber !=""){
                        		   text=val;
                        	   }else{
                        		   text="<input name='supplierAssessmentItemVOs[][assessmentItemName]'   type='text' value='"+val+"'/>";
                        	   }
                        	   
   	           				return text;
              			    }},
                           { title:'<i18n:I18n key="i18n_assessrules_lable_versionNumber" defaultValue="评估项版本号" />', name:'versionNumber' ,width:170, align:'center',renderer:function(val,item,rowIndex){
                        	   var text ="";
                        	   if(item.assessmentItemNumber !=""){
                        		   text=val;
                        	   }else{
                        		   text="1.0v";
                        	   }
                  				return text;
                  			}},
                           { title:'<i18n:I18n key="i18n_assessrules_table_assessmentRules" defaultValue="评估规则" />', name:'assessmentRule' ,width:400, align:'center',renderer:function(val,item,rowIndex){
                        	   var text ="";
                        	   if(item.assessmentItemNumber !=""){
                        		   text=val;
                        	   }else{
                        		   text="<input name='supplierAssessmentItemVOs[][assessmentRule]'   type='text' value='"+val+"'/>";
                        	   }
                  				return text;
                  			}},
                           {title:'<i18n:I18n key="i18n_assessrules_select_targetType" defaultValue="指标类型" />', name:'assessmentFlag' ,width:120, align:'center',clickDisable:true,renderer:rendererAssessmentFlag},
           			       { title:'<i18n:I18n key="i18n_assessrules_select_theQuantitativeFormula" defaultValue="定量公式" />', name:'fbk1' ,width:120, align:'center',clickDisable:true,renderer:rendererRationFormula},
                           { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                           { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime}
                    ];
function init(){
	
	if(assessmentClassName == "null"){
		assessmentClassName = "";
	}
	$(".assessmentClassNumber").append(assessmentClassNumber);
	$(".assessmentClassName").append(assessmentClassName);
	$("#elsAccount").val(elsAccount);
	$("#hidden_elsAccount").val(elsAccount);
	$("#assessmentClassNumber").val(assessmentClassNumber);
	$("#hidden_assessmentClassNumber").val(assessmentClassNumber);
    $("#hidden_assessmentClassName").val(assessmentClassName);
    var frm = $("#assessmentClassForm");
    assessmentClassGrid=$('#table-assessmentClassInfo').mmGrid({
	    cols: assessmentClassCols,
	    url: '<%=basePath%>rest/SupplierAssessmentClassService/findAssessmentItemList',
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
                 , limitList: [10,15,20]
             })
         ]
	});
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

function clearAddIntegrationInfo(){
	$("#add_assessmentItemName").val("");
	$("#add_assessmentRule").val("");
	$("#add_assessmentFlag").val("0");
	$(".show-fbk1").html("");
} 
//增加
$("#addIntegrationInfo").click(function(){
	isFirst=true; 
	
	var row={"assessmentItemName":"","assessmentRule":"","versionNumber":"1.0v","assessmentFlag":"0","fbk1":"","assessmentItemNumber":""};
	
	/*  if(isFirst){
		 assessmentClassGrid.removeRow();
		 isFirst = false;
	 } */
	assessmentClassGrid.addRow(row);
	
});


$("#saveAssessRules").click(function(){
	var frm = $("#assessmentClassForm");
	var frmObj = frm.serializeJSON();
	var rows = frmObj.supplierAssessmentItemVOs;
	if(!isFirst){
		alert('<i18n:I18n key="i18n_common_title_pleaseAddRecord" defaultValue="请先添加记录!" />',2);
		return;
	}
     else{
		for(var i = 0 ; i < rows.length ; i ++){
			var row = rows[i];
			var assessmentItemNumber=row.assessmentItemNumber;
			if(assessmentItemNumber != ""){
				continue;
			}
			var assessmentItemName = row.assessmentItemName;
			if(assessmentItemName == "" || assessmentItemName == null){
				alert('<i18n:I18n defaultValue="评估项名称不能为空！" key="i18n_assessrules_alert_evaluateNameCannotBeEmpty"/>',2);
				return;
			}
			var assessmentRule = row.assessmentRule;
			if(assessmentRule == "" || assessmentRule == null){
				alert('<i18n:I18n defaultValue="评估项规则不能为空！" key="i18n_assessrules_alert_assessmentRulesCannotBeEmpty"/>',2);
				return;
			}
		}
	}
	$.ajax({
		url :"<%=basePath%>rest/SupplierAssessmentClassService/addAssessmentItem",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(frm.serializeJSON()),
		success : function(data) {
			if(data.statusCode == "-100"){
				alert(data.message,3);
			}else{
				alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
				queryIntegrationInfo();
			}
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
            alert(exception,3); 
        }
  }); 
});

//删除
$("#deleteItemManage").click(function(){
	var selectRows = assessmentClassGrid.selectedRows();
	if(selectRows.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var indexs = assessmentClassGrid.selectedRowsIndex();
	var flag = selectRows[0].assessmentItemNumber;
	if(flag == ""){
		assessmentClassGrid.removeRow(indexs);
		return;
	}
	
	
	
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除考评项？" key=""/>',closeEvent:function(){
	    for(var i = 0 ; i < selectRows.length; i ++){
		   var row = selectRows[i];
		   $.ajax({
				url :"<%=basePath%>rest/SupplierAssessmentClassService/deleteAssessmentItem",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify(row),
				success : function(data) {
					if(data.statusCode == "-100"){
						alert(data.message,3);
					}else{
						alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
						queryIntegrationInfo();
					}
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
		            alert(exception,3); 
		        }
		  });
	    }
    }});
});

//弹出框取消按钮
$("#integrationInfoCancel").click(function(){
	$("#integrationInfoDialog").hide();
});
//关闭按钮处理
$("#integrationInfoDialogDialogClose").click(function(){
	$("#integrationInfoDialog").hide();
});

//确认添加/修改
$("#integrationInfoOK").click(function(){
	var assessmentItemName = $("#add_assessmentItemName").val();
	var assessmentRule =$("#add_assessmentRule").val();
	if(assessmentItemName == null || assessmentItemName == ""){
		alert("<i18n:I18n key='i18n_assessrules_alert_pleaseEnterTheNameAssessmentItemDetail' defaultValue='请输入评估明细项名！'/>！",2);
		$("#add_assessmentItemName").focus();
		return;
	}
	if(assessmentRule == null || assessmentRule == ""){
		alert("<i18n:I18n key='i18n_assessrules_alert_pleaseEnterTheEvaluationRules' defaultValue='请输入评估规则！'/>",2);
		$("#add_assessmentRule").focus();
		return;
	}

 	var frm = $("#addIntegrationInfoForm");
	var operationType = $('body').data("operationType");
	if(operationType == "add"){
	<%-- 	$.ajax({
			url :"<%=basePath%>rest/SupplierAssessmentClassService/addAssessmentItem",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(frm.serializeJSON()),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryIntegrationInfo();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });  --%>
	}else{

		$.ajax({
			url :"<%=basePath%>rest/SupplierAssessmentClassService/updateAssessmentItemVsersion",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(frm.serializeJSON()),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryIntegrationInfo();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
	} 
	$("#integrationInfoDialog").hide();
});
</script>

</body>
</html>
