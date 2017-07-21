<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="integrationForm">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="ELS账号" key="i18n_label_elsAccount"/>:</span>
			       <input id="elsAccount" name="elsAccount" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="公司名称" key="i18n_common_lable_companyname"/>:</span>
			       <input id="companyShortName" name="companyShortName" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="集成类型" key="i18n_elsMessage_list_integratedType"/></span>
			       <select id="integrationType" name="integrationType">
			          <option value=""><i18n:I18n defaultValue="全部" key="i18n_common_select_all"/></option>
			          <option value="MiddleTable"><i18n:I18n defaultValue="中间表" key="i18n_elsMessage_lable_intermediateChart"/></option>
			          <option value="WebService"><i18n:I18n defaultValue="服务" key="i18n_common_select_procurementtype_service"/></option>
			          <option value="SAP"><i18n:I18n defaultValue="SAP" key="i18n_elsMessage_lable_SAP"/></option>
			          <option value="other"><i18n:I18n defaultValue="其它" key="i18n_elsMessage_lable_other"/></option>
			       </select>
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
                     <button id="updateIntegrationInfo" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_common_button_update"/></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteIntegrationInfo" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-integrationInfo"></table>
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
	        <img class="icon" src="../icon/destop-icon/desktop2_icon_181.png" />
	        <span class="integrationInfoDialogTitle"></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"></span>
	            <form id="addIntegrationInfoForm">
	            <input type="hidden" id="id" name="id">
	            <input type="hidden" id="umId" name="umId">
	            <input type="hidden" id="hidden_elsAccount" name="elsAccount">
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td ><i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="add_elsAccount" name="elsAccount"/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n defaultValue="集成类型" key="i18n_elsMessage_list_integratedType"/>:</td>
	                		<td>
	                		   <select id="add_integrationType" name="integrationType">
			                       <option value="WebService" selected><i18n:I18n defaultValue="服务" key="i18n_common_select_procurementtype_service"/></option>
			                       <option value="MiddleTable"><i18n:I18n defaultValue="中间表" key="i18n_elsMessage_lable_intermediateChart"/></option>
			                       <option value="SAP"><i18n:I18n defaultValue="SAP" key="i18n_elsMessage_lable_SAP"/></option>
			                       <option value="K3"><i18n:I18n defaultValue="K3" key="test"/></option>
			                       <option value="other"><i18n:I18n defaultValue="其它" key="i18n_elsMessage_lable_other"/></option>
			                   </select>
	                		</td>
	                	</tr>
	                	<tr class="line-height-tr isShow">
	                		<td><i18n:I18n key="i18n_elsMessage_lable_enterpriseServiceAddress" defaultValue="企业服务地址" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="add_serviceURL" name="serviceURL" /></td>
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

var integrationInfoGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';

$().ready(function(){
	init();
});	

//渲染集成类型
function rendererIntegrationType(val){
	if (!val) {val = "";}
	if(val == "WebService"){
		return '<i18n:I18n key="i18n_common_select_procurementtype_service" defaultValue="服务" />';
	}else if(val == "MiddleTable"){
		return "<i18n:I18n defaultValue="中间表" key="i18n_elsMessage_lable_intermediateChart"/>";
	}else if(val == "SAP"){
		return "<i18n:I18n defaultValue="SAP" key="i18n_elsMessage_lable_SAP"/>";
	}else if(val == "other"){
		return "<i18n:I18n defaultValue="其它" key="i18n_elsMessage_lable_other"/>";
	}else{
		return "其他";
	}
}


var integrationInfoCols = [
                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:150, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司名称" />', name:'companyShortName' , width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="集成类型" key="i18n_elsMessage_list_integratedType"/>', name:'integrationType' ,width:140, align:'center',renderer : rendererIntegrationType},
                   { title:'<i18n:I18n key="i18n_elsMessage_lable_enterpriseServiceAddress" defaultValue="企业服务地址" />', name:'serviceURL' ,width:200, align:'center'}
            ];

function init(){
	$("#hidden_elsAccount").val(elsAccount);
    var frm = $("#integrationForm");
    integrationInfoGrid=$('#table-integrationInfo').mmGrid({
	    cols: integrationInfoCols,
	    url: '<%=basePath%>rest/IntegrationManageService/findPageList',
	    params: frm.serializeJSON(),
	    height: 340,
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
                 , limitList: [10,15,20]
             })
         ]
	});
}

function queryIntegrationInfo() {
	var frm = $("#integrationForm");
	integrationInfoGrid.opts.params = frm.serializeJSON();
	integrationInfoGrid.load({page:1});
}

//查询
$("#queryIntegrationInfo").click(function() {
	queryIntegrationInfo();
});

function clearAddIntegrationInfo(){
	$("#add_elsAccount").val("");
	$("#add_integrationType").val("WebService");
	$("#add_serviceURL").val("");
	$(".isShow").show();
}
//增加
$("#addIntegrationInfo").click(function() {
	clearAddIntegrationInfo();
	$(".integrationInfoDialogTitle").text('<i18n:I18n defaultValue="配置集成方式" key="i18n_alert_modifiedIntegratedWay"/>');
	$("#add_elsAccount").attr("disabled",false);
	$('body').data("operationType","add");
	$("#integrationInfoDialog").show();
});

//集成方式改变事件
$("#add_integrationType").change(function() {
	var integrationType = $(this).val();
	if("WebService" == integrationType){
		$(".isShow").show();
	}else{
		$("#add_serviceURL").val("");
		$(".isShow").hide();
	}
});

//修改
$("#updateIntegrationInfo").click(function() {
	var selectRow = integrationInfoGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var id=selectRow[0].id;
	var umId=selectRow[0].umId;
	var elsAccount = selectRow[0].elsAccount;
	var serviceURL = selectRow[0].serviceURL;
	var integrationType = selectRow[0].integrationType;
	if("WebService" == integrationType){
		$(".isShow").show();
	}else{
		$(".isShow").hide();
	}
	$("#add_elsAccount").val(elsAccount);
	$("#hidden_elsAccount").val(elsAccount);
	$("#add_integrationType").val(integrationType);
	$("#add_serviceURL").val(serviceURL);
	$("#id").val(id);
	$("#umId").val(umId);
	$(".integrationInfoDialogTitle").text("<i18n:I18n defaultValue="修改集成方式！" key="i18n_alert_modifiedIntegratedWay"/>");
	$("#add_elsAccount").attr("disabled",true);
	$('body').data("operationType","update");
	$("#integrationInfoDialog").show();
});

//删除
$("#deleteIntegrationInfo").click(function() {
	var selectRow = integrationInfoGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var id=selectRow[0].id;
	var umId=selectRow[0].umId;
	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认是否删除？",closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/IntegrationManageService/deleteIntegrationMethod",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"id":id,"umId":umId,"elsAccount":elsAccount}),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryIntegrationInfo();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
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
	var elsAccount = $("#add_elsAccount").val();
	if(elsAccount == null || elsAccount == ""){
		alert("<i18n:I18n key='i18n_elsMessage_alert_elsAccountforTheRequiredFields' defaultValue='ELS账号为必填项'/>",2);
		$("#add_elsAccount").focus();
		return;
	}
	var frm = $("#addIntegrationInfoForm");
	var operationType = $('body').data("operationType");
	if(operationType == "add"){
		$.ajax({
			url :"<%=basePath%>rest/IntegrationManageService/addIntegrationMethod",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(frm.serializeJSON()),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryIntegrationInfo();
					$("#integrationInfoDialog").hide();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
	}else{
		var frmObj = frm.serializeJSON();
		$.ajax({
			url :"<%=basePath%>rest/IntegrationManageService/updateIntegrationMethod",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(frm.serializeJSON()),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					queryIntegrationInfo();
					$("#integrationInfoDialog").hide();
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
	}
});


</script>

</body>
</html>
