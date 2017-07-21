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
			       <img class="dis-in-b" src="../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;left: 215px;top: 30px;cursor: pointer;" id="querySubAccount" title="查找子账号" />
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
                     <button id="findOrgInfo" class="button-wrap" ><i18n:I18n key="" defaultValue="匹配组织" /></button>
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
            <input type="hidden" id="pageSize" name="pageSize" value="10">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-subAccountOrgInfo"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
     </form>
</div>

<!-- 选择子账号 -->
<div class="fixed-dialog" id="selectPrincipalDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectPrincipalDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectPrincipalDialog"><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></span>
	    </div>
	    <div class="box-wrap">
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filtercondition" defaultValue="过滤条件" /></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td width="80px"><input  type="text" id="principalName" name="principalName" /></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="select-principal-table"></table>
                    </div>
                    <div class="text-center" style="margin-top: 14px;">
	                    <button id="btnSelectPrincipalOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnSelectPrincipalCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<script>
var subAccountOrgGrid;
var selectPrincipalTable;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsDesc ='<%=session.getAttribute("companyShortName")%>';

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
	                       { title:'<i18n:I18n key="" defaultValue="组织类别编码" />', name:'orgCategoryId' ,width:200, align:'center',renderer:function(val){
	           				  return val+"<input name='organizationInfoVOs[][orgCategoryId]' style='display:none;'  type='text' value='"+val+"'/>";
           			       }},
           			       { title:'<i18n:I18n key="" defaultValue="组织类别描述" />', name:'orgCategoryDesc' ,width:200, align:'center',renderer:function(val){
	           				  return val+"<input name='organizationInfoVOs[][orgCategoryDesc]' style='display:none;'  type='text' value='"+val+"'/>";
         			       }},
         			       { title:'<i18n:I18n key="" defaultValue="组织编码" />', name:'orgId' ,width:200, align:'center',renderer:function(val){
	           				  return val+"<input name='organizationInfoVOs[][orgId]' style='display:none;'  type='text' value='"+val+"'/>";
           			       }},
           			       { title:'<i18n:I18n key="" defaultValue="组织描述" />', name:'orgDesc' ,width:200, align:'center',renderer:function(val){
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
    subAccountOrgGrid=$('#table-subAccountOrgInfo').mmGrid({
	    cols: subAccountOrgCols,
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
	debugger;
	var gridRows = subAccountOrgGrid.rows();
	if(gridRows != ""){
		for(var i = 0 ; i < gridRows.length ; i ++){
			for(var j = 0 ; j < rows.length ; j ++){
				rows[j].fbk1 = "";
				rows[j].fbk2 = "";
				var orgCategoryId = gridRows[i].orgCategoryId;
				var orgId = gridRows[i].orgId;
				var _orgCategoryId = rows[j].orgCategoryId;
				var _orgId = rows[j].orgId;
				if(orgCategoryId == _orgCategoryId && orgId == _orgId){
					rows.splice(j,1);
				}
			}
		}
	}else{
		for(var j = 0 ; j < rows.length ; j ++){
			rows[j].fbk1 = "";
			rows[j].fbk2 = "";
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
        'iframSrc':'<%=basePath%>organizationmanage/findOrgInfo.jsp?frameAppId=addSubAccountOrgInfo',
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
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认保存?" key=""/>',closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/ElsOrganizationService/saveSubaccountOrganizationInfo",
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
				    parent.elsDeskTop.closeCurWin('addSubAccountOrgInfo');
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
	}});
});

//选择子账号相关-----------------begin---------------
var colsPrincipal = [
	                { title:'<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号"/>', name:'elsSubAccount' , width:110, align:'center'},
	                { title:'<i18n:I18n key="i18n_common_title_username" defaultValue="用户名称"/>', name:'name' , width:100, align:'center'}
	                
	            ];

//触发负责人弹出框事件，并用负责人文本框数据初始化窗口table的选中数据
$("#querySubAccount").click(function(){
	$("#selectPrincipalDialog").show();
	if(!selectPrincipalTable){
		selectPrincipalTable=$('#select-principal-table').mmGrid({
	        cols: colsPrincipal,
	        url: "<%=basePath%>rest/AccountService/subAccountList",
	        params: {"elsAccount":elsAccount,"name":"","pageSize":"10000"},
	        method: 'post',
	        root: 'rows',
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	        multiSelect: false,
	        checkCol: true,
	        indexCol:true
	    });
	    
	    selectPrincipalTable.on('loadSuccess', function(e, data){
	    	var principalName = $("#principalName").val();
	    	selectedByInput();
		});
	    selectPrincipalTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
	    	 $('body').data('accountRow',item);
	     });
	}
	selectedByInput();
});
//用责任人框值初始化选中责任人列表的值
function selectedByInput(){
	var principal = $("#elsSubAccount").val();
	var totalRows = selectPrincipalTable.rows();
	if(totalRows != "" &&totalRows != null){
		for(var i = 0 ; i < totalRows.length ; i ++){
			var elsSubAccount = totalRows[i].elsSubAccount;
			if(elsSubAccount == principal){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
				selectPrincipalTable.select(i);
				continue;
			}
		}
	}
}

//模糊查询键入事件
$("#principalName").keyup(function(){
	var principalName = $("#principalName").val();
	selectPrincipalTable.load({"elsAccount":elsAccount,"name":principalName,"pageSize":"10000"});
});
//选择负责人弹出框确认按钮单击事件
$("#btnSelectPrincipalOK").click(function(){
	 var selectedRows = selectPrincipalTable.selectedRows();
	 $("#elsSubAccount").val(selectedRows[0].elsSubAccount);
	 $("#elsSubDesc").val(selectedRows[0].name);   
	 $("#selectPrincipalDialog").hide();
});
//选择负责人弹出框双击事件
$('#select-principal-table').on('dblclick','tr',function() {
	var accountRow= $('body').data('accountRow');
	$("#elsSubAccount").val(accountRow.elsSubAccount);
	 $("#elsSubDesc").val(accountRow.name);
	$("#selectPrincipalDialog").hide();
});
$("#btnSelectPrincipalDialogClose").click(function(){
	$("#selectPrincipalDialog").hide();
});
$("#btnSelectPrincipalCancel").click(function(){
	$("#selectPrincipalDialog").hide();
});
//选择子账号相关-----------------end---------------


</script>

</body>
</html>
