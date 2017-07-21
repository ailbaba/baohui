<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="requirementTypeForm">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1">
		        <!-- i18N配置 -->
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementTypeHead_table_requirementGroupCode" defaultValue="需求组编号:" /></span>
			       <input id="requirementGroupCode" name="requirementGroupCode" type="text" style="width:200px;"/>
		        </div>
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementTypeHead_table_requirementGroupName" defaultValue="需求组名称:" /></span>
			       <input id="requirementGroupName" name="requirementGroupName" type="text" style="width:200px;"/>
		        </div>
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementTypeHead_table_requirementTypeCode" defaultValue="需求类型编号:" /></span>
			       <input id="requirementTypeCode" name="requirementTypeCode" type="text" style="width:200px;"/>
		        </div>
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_requirementTypeHead_table_requirementTypeName" defaultValue="需求类型名称:" /></span>
			       <input id="requirementTypeName" name="requirementTypeName" type="text" style="width:200px;"/>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="query-requirementType" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="add-requirementType" class="button-wrap"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新增" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
					<button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
				</div>
                <div class="dis-in-b input-and-tip">
                	<button id="close-requirementType" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
                </div>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
	         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_requirementType_list" defaultValue="需求类型列表" /></span>
	         <div class="common-box-line">
	             <main class="grid-container">
	                 <div class="grid-100">
	                      <table id="table-requirementTypeHead"></table>
	                      <div id="pg" style="text-align: right;"></div>
	                 </div>
	             </main>
	         </div>
		</div>
</div>




<script>
var requirementTypeHeadGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';

$().ready(function(){
	init();
});	

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//日期格式渲染 yyyy-MM-dd
function rendererDate(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
	return val;
}

var renderFormatLock = function(val,item,rowIndex){
	if(1==val){
		return "是";
	} else {
		return "否";
	}
};

$('.check-requirementType').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    showFrame(item,"check");
});

$('.update-requirementType').live("click", function() {
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
        'windowsId':'detailsrequirementType',
        'windowTitle':'<i18n:I18n key="i18n_requirementType_title_requirementTypeDetail" defaultValue="需求类型明细项"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>projectmanage/requirementType/detailsrequirementType.jsp?frameAppId=requirementTypeManage&operationType='
        		+operation+'&requirementTypeNumber='+item.requirementTypeNumber+'&projectNumber='+item.projectNumber+'&projectItemNumber='+item.projectItemNumber,
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


var requirementTypeHeadCols = [
                           { title:'<i18n:I18n key="i18n_requirementType_lable_requirementTypeEls" defaultValue="els号"/>', name:'elsAccount' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_requirementType_lable_requirementGroupCode" defaultValue="需求组编号"/>', name:'requirementGroupCode' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_common_title_requirementGroupName" defaultValue="需求组名称"/>', name:'requirementGroupName' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_quotation_requirementTypeCode" defaultValue="需求类型编号"/>', name:'requirementTypeCode' , width:120, align:'center'},
                           { title:'<i18n:I18n key="i18n_requirementType_table_requirementTypeName" defaultValue="需求类型名称"/>', name:'requirementTypeName' , width:120, align:'center'},
                           { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                           { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime},
                           { title:'<i18n:I18n key="i18n_label_lockStatus" defaultValue="是否锁定"/>', name:'lockStatus' , width:120, align:'center',renderer:renderFormatLock},
                           { title:'<i18n:I18n key="i18n_label_remark" defaultValue="备注"/>', name:'remark' , width:120, align:'center'}
                    ];

function init(){

	$("#updBtn").click(function(){
		modifyRequirementType();
	});
	$("#elsAccount").val(elsAccount);
	var frm = $("#requirementTypeForm");
	
    requirementTypeHeadGrid=$('#table-requirementTypeHead').mmGrid({
	    cols: requirementTypeHeadCols,
	    url: '<%=basePath%>rest/RequirementTypeService/findHeadList',
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
$("#add-requirementType").click(function() {
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'addrequirementType',
        'windowTitle':'<i18n:I18n key="i18n_requirementType_title_new" defaultValue="新增需求类型"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>requirement/requirementtype/addRequirementType.jsp',
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


function queryrequirementType() {
	var frm = $("#requirementTypeForm");
	requirementTypeHeadGrid.opts.params = frm.serializeJSON();
	requirementTypeHeadGrid.load({page:1});
}

//查询
$("#query-requirementType").click(function() {
	queryrequirementType();
});


$('.delete-requirementType').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除需求类型？" key="i18n_requirementType_alert_confirmDeleteRequirementPlan"/>',closeEvent:function(){
    	$.ajax({
			url :"<%=basePath%>rest/requirementTypeService/delete",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(item),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}  else if(data.statusCode == "-200"){
					parent.elsDeskTop.hideLoading();
					alert(data.message,2);
				} else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryrequirementType();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
    }});
});

$('#close-requirementType').live("click", function() {
	var selectRows = requirementTypeHeadGrid.selectedRows();
	if(selectRows.length < 1){
		alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据！"/>',2);
		return;
	}
	/*
	*删除前的处理
	var row = selectRows[0];
	if(row.status == 3){
		alert("该需求计划已经关闭，无需再次操作！",2);
		return;
	}
	*/
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除需求类型？" key="i18n_requirementType_alert_determineDelRequirementType"/>',closeEvent:function(){
    	$.ajax({
			url :"<%=basePath%>rest/RequirementTypeService/delete",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(selectRows[0]),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}  else if(data.statusCode == "-200"){
					parent.elsDeskTop.hideLoading();
					alert(data.message,2);
				}else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryrequirementType();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
    	
    }});
});

function callbackFun(rows){
	alert(rows);
}

function modifyRequirementType() {
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	if (requirementTypeHeadGrid.selectedRows().length==0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var requirementTypeCode = requirementTypeHeadGrid.selectedRows()[0].requirementTypeCode;
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'updrequirementType',
        'windowTitle':'<i18n:I18n key="i18n_requirementType_title_upd" defaultValue="修改需求类型"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>requirement/requirementtype/addRequirementType.jsp?requirementTypeCode='+requirementTypeCode,
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

</script>

</body>
</html>
