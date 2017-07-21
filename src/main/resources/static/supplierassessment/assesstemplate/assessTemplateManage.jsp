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
                     <button id="addIntegrationInfo" class="button-wrap" ><i18n:I18n defaultValue="增加" key="i18n_common_button_create"/></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteAssessInfo" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
                <!-- <div class="dis-in-b input-and-tip">
                     <button id="testFindAssess" class="button-wrap">Test</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="testFindTemplate" class="button-wrap">Test_template</button>
                </div> -->
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
</div>


<div class="fixed-dialog" id="integrationInfoDialog" >
	<div class="dialog-tip bg-common" style="width: 403px;height: 220px;margin-left: -251px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="integrationInfoDialogDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/destop-icon/desktop_icon_93.gif" />
	        <span class="integrationInfoDialogTitle"></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"></span>
	            <form id="addIntegrationInfoForm">
	            <input type="hidden" id="hidden_elsAccount" name="elsAccount">
	            <input type="hidden" id="hidden_createUser" name="createUser">
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td ><i18n:I18n defaultValue="评估类型名" key="i18n_assessrules_table_assessmentClassName"></i18n:I18n></td>
	                		<td><input class="easyui-textbox" type="text" id="add_assessmentClassName" name="assessmentClassName"/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="评估規則" key="i18n_assessrules_table_assessmentRules"></i18n:I18n>:</td>
	                		<td><input class="easyui-textbox" type="text" id="add_ruleName" name="ruleName" /></td>
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

var assessTemplateGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var createUser='<%=session.getAttribute("username") %>';

$().ready(function(){
	init();
});	


function rendererOperation(val, item, rowIndex){      
	var text = '<span class="version-history" style="color:blue;cursor:pointer;"> <i18n:I18n defaultValue="历史" key="i18n_purchase_bargain_history"></i18n:I18n> </span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	           +'&nbsp;&nbsp;<span class="loadAssessmentItem" style="color:blue;cursor:pointer;"><i18n:I18n defaultValue="编辑" key="i18n_label_edit_I18n"></i18n:I18n></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	return text;
}

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
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'assessTemplateHis',
        'windowTitle':'<i18n:I18n defaultValue="评估模板历史记录" key="i18n_assesstemplate_title_assessHistoricalRecordTemplate"></i18n:I18n>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>supplierassessment/assesstemplate/assessTemplateHis.jsp?assessmentTemplateNumber='+item.assessmentTemplateNumber
        		+'&frameAppId=assessTemplateManage&templateVersionNumber='+item.templateVersionNumber,
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
    
});

$('.loadAssessmentItem').live("click", function() {
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
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'updateAssessTemplateItemManage',
        'windowTitle':'<i18n:I18n key="i18n_assesstemplate_title_editEvaluationTemplateDetailItems" defaultValue="编辑评估模板明细项" />',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>supplierassessment/assesstemplate/updateAssessTemplateItemManage.jsp?assessmentTemplateNumber='+item.assessmentTemplateNumber
        		+'&assessmentTemplateName='+item.assessmentTemplateName+'&assessmentTemplateDesc='+item.assessmentTemplateDesc+'&templateVersionNumber='+item.templateVersionNumber,
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
    
});

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

var assessmentTemplateCols = [
                           { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:130, align:'center', clickDisable:true,renderer: rendererOperation},
                           { title:'<i18n:I18n defaultValue="评估模板编号" key="i18n_assesstemplate_table_assessmentTemplateNumber"></i18n:I18n>', name:'assessmentTemplateNumber' , width:120, align:'center'},
                           { title:'<i18n:I18n defaultValue="评估模板名称" key="i18n_assesstemplate_table_assessmentTemplateName"></i18n:I18n>', name:'assessmentTemplateName' ,width:140, align:'center'},
                           { title:'<i18n:I18n defaultValue="版本号" key="i18n_assesstemplate_table_templateVersionNumber"></i18n:I18n>', name:'templateVersionNumber' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="评估模板描述" key="i18n_assesstemplate_table_assessmentTemplateDesc"></i18n:I18n>', name:'assessmentTemplateDesc' ,width:140, align:'center'},
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
    assessTemplateGrid=$('#table-assessmentClassInfo').mmGrid({
	    cols: assessmentTemplateCols,
	    url: '<%=basePath%>rest/SupplierAssessTemplateService/findAssessTemplateList',
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
	assessTemplateGrid.opts.params = frm.serializeJSON();
	assessTemplateGrid.load({page:1});
}

//查询
$("#queryIntegrationInfo").click(function() {
	queryIntegrationInfo();
});

//增加
$("#addIntegrationInfo").click(function() {
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'addAassessTemplateItem',
        'windowTitle':'<i18n:I18n defaultValue="新增评估模板" key="i18n_assesstemplate_title_addEvaluationModule"></i18n:I18n>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>supplierassessment/assesstemplate/addAassessTemplateItem.jsp',
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
	
});



//删除
$("#deleteAssessInfo").click(function() {
	var selectRows = assessTemplateGrid.selectedRows();
	if(selectRows.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var assessmentTemplateNumbers="";
	for(var i = 0 ; i < selectRows.length ; i ++){
		var row = selectRows[i];
		var assessmentTemplateNumber = row.assessmentTemplateNumber;
		assessmentTemplateNumbers += ";"+assessmentTemplateNumber;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除?" key="i18n_common_alert_confirmdelete"/>',closeEvent:function(){
	 $.ajax({
		url :"<%=basePath%>rest/SupplierAssessTemplateService/deleteAssessTemplate",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify({"elsAccount":elsAccount,"assessmentTemplateNumbers":assessmentTemplateNumbers.substring(1)}),
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
  }});
});


//test------------------------------------
$("#testFindAssess").click(function(){
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
        'windowTitle':'<i18n:I18n defaultValue="选择评估类型" key="i18n_assesstemplate_alert_selectAssessmentTypes"></i18n:I18n>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>supplierassessment/assessrules/findAssessRules.jsp?frameAppId=assessTemplateManage',
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 960,
        'windowMinHeight': 500,
        'windowPositionTop':24,
        'windowWidth':960,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
});

function callbackFun(selectRows){
	alert(selectRows);
}

$("#testFindTemplate").click(function(){
    //兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'findAssessTemplate',
        'windowTitle':'<i18n:I18n defaultValue="选择评估类型" key="i18n_assesstemplate_alert_selectAssessmentTypes"></i18n:I18n>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>supplierassessment/assesstemplate/findAssessTemplate.jsp?frameAppId=assessTemplateManage',
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

function selectTemplateCallbackFunc(rows){
	alert(rows);
}

</script>

</body>
</html>
