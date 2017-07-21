<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
     <form id="subAccountOrgForm" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="基础信息"/></span>
            <div class="common-box-line">
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n key="" defaultValue="子账号"/>:&nbsp;<input type="text" id="elsSubAccount" name="elsSubAccount" readonly="readonly">&nbsp;
			       <span style="color: red">*</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n key="" defaultValue="姓名" />:&nbsp;<input type="text" id="elsSubDesc" name="elsSubDesc" readonly="readonly">
		        </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
		        <div class="dis-in-b input-and-tip">
                     <button id="findOrgInfo" class="button-wrap" ><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="saveOrgInfo" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteOrgInfo" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <input type="hidden" id="elsAccount" name="elsAccount">
            <input type="hidden" id="elsDesc" name="elsDesc">
            <input type="hidden" id="pageSize" name="pageSize" value="10000">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-subAccountOrgInfo"></table>
                    </div>
                </main>
            </div>
        </div>
     </form>
</div>

<script>
var subAccountOrgGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsDesc ='<%=session.getAttribute("companyShortName")%>';

var elsSubAccount ="<%=request.getParameter("elsSubAccount") %>";
var elsSubDesc ="<%=request.getParameter("elsSubDesc") %>";

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

var subAccountOrgCols = [
	                       { title:'<i18n:I18n key="" defaultValue="组织类别编码" />', name:'orgCategoryId' ,width:150, align:'center',renderer:function(val){
	           				  return val+"<input name='organizationInfoVOs[][orgCategoryId]' style='display:none;'  type='text' value='"+val+"'/>";
           			       }},
           			       { title:'<i18n:I18n key="" defaultValue="组织类别描述" />', name:'orgCategoryDesc' ,width:150, align:'center',renderer:function(val){
	           				  return val+"<input name='organizationInfoVOs[][orgCategoryDesc]' style='display:none;'  type='text' value='"+val+"'/>";
         			       }},
         			       { title:'<i18n:I18n key="" defaultValue="组织编码" />', name:'orgId' ,width:100, align:'center',renderer:function(val){
	           				  return val+"<input name='organizationInfoVOs[][orgId]' style='display:none;'  type='text' value='"+val+"'/>";
           			       }},
           			       { title:'<i18n:I18n key="" defaultValue="组织描述" />', name:'orgDesc' ,width:150, align:'center',renderer:function(val){
	           				  return val+"<input name='organizationInfoVOs[][orgDesc]' style='display:none;' type='text' value='"+val+"'/>";
         			       }},
         			       { title:'<i18n:I18n key="" defaultValue="ERP编码" />', name:'fbk1' ,width:150, align:'center',renderer:function(val){
         			    	  if(!val){val = ""}
	           				  return "<input name='organizationInfoVOs[][fbk1]'  type='text' value='"+val+"'/>";
         			       }},
         			      { title:'<i18n:I18n key="" defaultValue="内码" />', name:'fbk2' ,width:150, align:'center',renderer:function(val){
         			    	  if(!val){val = ""}
	           				  return "<input name='organizationInfoVOs[][fbk2]'  type='text' value='"+val+"'/>";
         			       }},
         			     { title:'<i18n:I18n key="" defaultValue="名称" />', name:'fbk3' ,width:150, align:'center',renderer:function(val){
        			    	  if(!val){val = ""}
	           				  return "<input name='organizationInfoVOs[][fbk3]'  type='text' value='"+val+"'/>";
        			       }},
         			    { title:'<i18n:I18n key="" defaultValue="短码" />', name:'fbk4' ,width:150, align:'center',renderer:function(val){
       			    	  if(!val){val = ""}
	           				  return "<input name='organizationInfoVOs[][fbk4]'  type='text' value='"+val+"'/>";
       			       }},
         			   { title:'<i18n:I18n key="" defaultValue="备注" />', name:'remark' ,width:150, align:'center',renderer:function(val){
      			    	  if(!val){val = ""}
	           				  return "<input name='organizationInfoVOs[][remark]'  type='text' value='"+val+"'/>";
      			       }}
                    ];

function init(){
	$("#elsAccount").val(elsAccount);
	$("#elsDesc").val(elsDesc);
	$("#elsSubAccount").val(elsSubAccount);
	$("#elsSubDesc").val(elsSubDesc);
	var param = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
    subAccountOrgGrid=$('#table-subAccountOrgInfo').mmGrid({
	    cols: subAccountOrgCols,
	    url: '<%=basePath%>rest/ElsOrganizationService/querySubaccountOrganizationInfo',
	    params: param,
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    checkCol:true,
	    multiSelect:true
	});
} 


function callbackFun(rows){
	var gridRows = subAccountOrgGrid.rows();
	if(gridRows != ""){
		for(var i = 0 ; i < gridRows.length ; i ++){
			for(var j = 0 ; j < rows.length ; j ++){
				var orgCategoryId = gridRows[i].orgCategoryId;
				var orgId = gridRows[i].orgId;
				var _orgCategoryId = rows[j].orgCategoryId;
				var _orgId = rows[j].orgId;
				if(orgCategoryId == _orgCategoryId && orgId == _orgId){
					rows.splice(j,1);
				}
			}
		}
	}
	subAccountOrgGrid.addRow(rows);
}

$("#findOrgInfo").click(function(){
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'findOrgInfo',
        'windowTitle':'<i18n:I18n key="" defaultValue="选择企业组织结构"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>organizationmanage/findOrgInfo.jsp?frameAppId=updateSubAccountOrgInfo',
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

$("#deleteOrgInfo").click(function(){
	var indexs = subAccountOrgGrid.selectedRowsIndex();
	if(indexs.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	subAccountOrgGrid.removeRow(indexs);
});

$("#saveOrgInfo").click(function(){
	
	var frm = $("#subAccountOrgForm");
	var frmObj = frm.serializeJSON();
	var elsSubAccount = frmObj.elsSubAccount;
	if(elsSubAccount == ""){
		alert("子账号为必填项",2);
		$("#elsSubAccount").focus();
		return;
	}
	var organizationInfoVOs = frmObj.organizationInfoVOs;
	if(!organizationInfoVOs){
		alert("至少添加一条数据",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认保存修改?" key=""/>',closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/ElsOrganizationService/updateSubaccountOrganizationInfo",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(frm.serializeJSON()),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					parent.frames['iframeApp_orgSubAccountInfoManage'].refreshData();
				    parent.elsDeskTop.closeCurWin('updateSubAccountOrgInfo');
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
