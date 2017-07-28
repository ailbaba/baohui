<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="elsHeader.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线竞标专业版</title>
<style type="text/css">
	h1{
		font-family: 微软雅黑;
		color:darkred;
	}
	img{
		position: absolute;
		left: 525px;
		top: 150px;
	}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/function.js"></script>
</head>
<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"></span>
            <div class="common-box-line">
               <form id="accoutForm">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span>子账号:</span><input id="elsSubAccount" name="elsSubAccount" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>姓名:</span><input id="name" name="name" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			        <select class="" id="station" name="station">
						<option value="">全部岗位</i18n:I18n></option>
						<option value="purchase">采购岗位</option>
						<option value="sale">销售岗位</option>
					</select>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryAccountInfo" class="button-wrap">查询</button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="addAccountInfo" class="button-wrap" >增加</button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="updateAccountInfo" class="button-wrap">修改</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteAccountInfo" class="button-wrap">删除</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="assignRole" class="button-wrap">分配角色</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="assignPermission" class="button-wrap">分配权限</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="assignApp" class="button-wrap">分配应用</button>
                </div>
            	</div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">信息浏览</span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-account"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>
<tbody><tr>
			<td width="6" height="24" colspan="2" rowspan="2">　</td>
			<td width="30" height="24" colspan="2" rowspan="2">手机号：</td>
			<td width="134" height="24" colspan="2" rowspan="2"> 
            <input name="yonghuming" size="18" style="border: 1px solid #A5ACB2; color:#A5ACB2"></td>
			<td width="6" height="24" colspan="2" rowspan="2">　</td>
			<td width="30" height="24" colspan="2" rowspan="2">密码:</td>
			<td width="151" height="24" colspan="2" rowspan="2">&nbsp;<input type="password" name="mima" size="18" style="border: 1px solid #A5ACB2; color:#A5ACB2">
                            </td>
			<td width="138" height="24" colspan="1" rowspan="2" valign="middle"><img src="${pageContext.request.contextPath}/image/LAND.GIF" width="51" height="20" style="CURSOR: hand" onclick="check1();"> &nbsp;&nbsp;<a href="register.jsp" target="_blank"><img src="${pageContext.request.contextPath}/image/REGISTER.GIF" width="51" height="20" border="0"></a></td>
			<td width="200" height="24" colspan="1" rowspan="2">
			
            &nbsp;
            还没有注册?，请点击<a href="register.jsp"><font color="red">注册</font></a>
            &nbsp;
             
			</td>
		  </tr>
		<tr><td height="1" colspan="16" rowspan="2"></td></tr>
		
	</tbody>
    =================helloworld jsp=================
	<h1 align="center" style="display: none">携凌云之势,御苍穹之风</h1><br/>
	<h3>填写资料,立即报名</h3>  
 <form method="post" action="/activity/saveActivityIndividual" class="form1">  
  <h3>个人报名</h3>  
  <p> 姓名:<input type="text" name="name" /></p>  
  <p> 性别: <input type="text" name="sex" /></p>  
  <p> 星座:<input type="text" name="constellation" /></p>  
  <p> 电话: <input type="text" name="telephoneNumber" /></p>  
  <input type="button" value="Submit" class="btn1" />  
</form> 
	<img align="middle" style="display: none" src="${pageContext.request.contextPath}/image/1.jpg" alt="萌妹子">
</body>
<script>	

var accountGrid;
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

function rendererStation(val){
	if (!val) {val = "";}
	if (val == "sale"){
		val =  '<i18n:I18n defaultValue="销售岗位" key="i18n_account_select_stationtype_sell"></i18n:I18n>';
	}else {
	    val =  '<i18n:I18n defaultValue="采购岗位" key="i18n_account_select_stationtype_purchase"></i18n:I18n>';
	}
	return val;
}

function rendererAccountStutas(val){
	if (val == "N"){
		val =  '<font color="green"><i18n:I18n defaultValue="正常" key="i18n_account_select_accountStatus_normal"/></font>';
	}else if(val == "Y"){
	    val =  '<font color="red"><i18n:I18n defaultValue="已冻结" key="i18n_account_select_accountStatus_frozen"/></font>';
	}else{
		val = "";
	}
	return val;
}

var accountCols = [
                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:80, align:'center'},
                   { title:'<i18n:I18n defaultValue="子账号" key="i18n_common_title_elssubaccount"></i18n:I18n>', name:'elsSubAccount' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="是否管理员" key="i18n_account_title_isadmin"></i18n:I18n>', name:'isAdmin' ,width:90, align:'center'},
                   { title:'<i18n:I18n defaultValue="工作性质" key=""></i18n:I18n>', name:'station' ,width:90, align:'center',renderer:rendererStation},
                   { title:'<i18n:I18n defaultValue="角色" key=""></i18n:I18n>', name:'roleName' ,width:90, align:'center',},
                   { title:'<i18n:I18n defaultValue="姓名" key="i18n_common_title_username"></i18n:I18n>', name:'name' ,width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="邮箱" key="i18n_account_title_email"></i18n:I18n>', name:'email' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="手机号" key="i18n_account_title_phonenumber"></i18n:I18n>', name:'telphone1' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="电话" key="i18n_account_title_telephone"></i18n:I18n>', name:'telphone2' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="传真" key="i18n_account_title_faxnumber"></i18n:I18n>', name:'fax' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="昵称" key="i18n_account_title_nickname"/>', name:'nickname' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="员工号" key="i18n_account_title_employeenumber"/>', name:'employeeNumber' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="微信账号" key="i18n_account_title_wxaccount"/>', name:'wxAccount' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="QQ账号" key="i18n_account_title_qqaccount"/>', name:'qqAccount' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="账户状态" key="i18n_account_title_accountStatus"/>', name:'frozenFlag' ,width:100, align:'center',renderer:rendererAccountStutas},
                   { title:'<i18n:I18n defaultValue="账户有效期限至" key="i18n_account_title_validityDate"/>', name:'accountValidityDate' ,width:100, align:'center',renderer:rendererDate},
                   { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdate"></i18n:I18n>', name:'lastUpdateDate' ,width:120, align:'center',renderer:rendererTime}
            ];

function init(){
	
	$("#elsAccount").val(elsAccount);//设置当前登录账号
	
	var frm = $("#accoutForm").serialize();
	 //初始化控件
//     $('button').button();
    var json1 = $(".form1").serialize();
		$(".btn1").on("click", function() {
			$.ajax({
				url : "/user/list?format=json",
				type : "POST",
				data : frm,
				success : function(data, textStatus) {
					alert(data.scode); // 1 success  -1 error  
				},
				error : function(data) {
					alert("Connection error");
				}
			});
		});
	accountGrid=$('#table-account').mmGrid({
	    cols: accountCols,
	    url: '<%=basePath%>rest/AccountService/subAccountList',
	    params: frm,
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    fullWidthRows:true,
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

function queryAccountInfo() {
	var frm = $("#accoutForm");
	accountGrid.opts.params = frm.serializeJSON();
	accountGrid.load({page:1});
}

//查询
$("#queryAccountInfo").click(function() {
	queryAccountInfo();
});
//新增子账号
$("#addAccountInfo").click(function() {
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'addSubAccount',
        'windowTitle':'<i18n:I18n defaultValue="新增子账号" key="i18n_label_add_subAccount"/>',
        'iframSrc':'<%=basePath%>account/addSubAccount.jsp',
        windowStatus: 'regular',
        windowMinWidth: 500,
        windowMinHeight: 530,
        windowPositionTop:24,
        'windowWidth':500,
        'windowHeight':530,
        'parentPanel':".currDesktop"
    });
});
//编辑账号信息
$("#updateAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url='<%=basePath%>account/editSubAccount.jsp?elsAccount='+selectRow[0].elsAccount+'&elsSubAccount='+selectRow[0].elsSubAccount;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'editSubAccount',
        'windowTitle':'<i18n:I18n defaultValue="编辑子账号" key="i18n_label_edit_subAccount"/>',
        'iframSrc':url,
        windowStatus: 'regular',
        windowMinWidth: 500,
        windowMinHeight: 550,
        windowPositionTop:24,
        'windowWidth':500,
        'windowHeight':550,
        'parentPanel':".currDesktop"
    });
});
//删除账号
$("#deleteAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var elsAccount=selectRow[0].elsAccount;
	var elsSubAccount=selectRow[0].elsSubAccount;
	if(elsSubAccount == "1001"){
		alert('<i18n:I18n defaultValue="1001账号的删除操作请联系系统管理员！" key="i18n_account_alert_delete1001"/>',2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除?" key="i18n_common_alert_confirmdelete"/>',closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/AccountService/removeSubaccount/"+elsAccount+"/"+elsSubAccount,
			type :"POST",
			contentType : "application/json",
			data : {},
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.tip.init({type: 'alert',displayType:1,message:'<i18n:I18n defaultValue="删除成功" key="i18n_common_alert_deletesuccess"></i18n:I18n>'});
				queryAccountInfo();   
			},
			error : function(data) {
				parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n defaultValue="请求出错" key="i18n_common_alert_requestfail"></i18n:I18n>'});
			}
		});
	}});
});
//分配角色
$("#assignRole").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url="editAccountRole.jsp?elsAccount="+selectRow[0].elsAccount+"&elsSubAccount="+selectRow[0].elsSubAccount;
	parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'roleAssign',
	        'windowTitle':'<i18n:I18n defaultValue="分配角色" key="i18n_label_assign_role"></i18n:I18n>',
	        'iframSrc':url,
	        windowMinWidth: 400,
	        windowMinHeight: 500,
	        windowPositionTop:24,
	        'windowWidth':400,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
});
//分配权限
$("#assignPermission").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url="resource/editAccountResource.jsp?elsAccount="+selectRow[0].elsAccount+"&elsSubAccount="+selectRow[0].elsSubAccount;
	 parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'editAccountResource',
	        'windowTitle':'<i18n:I18n defaultValue="分配权限" key="i18n_label_assign_permission"></i18n:I18n>',
	        'iframSrc':url,
	        windowMinWidth: 400,
	        windowMinHeight: 500,
	        windowPositionTop:24,
	        'windowWidth':400,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
});
//分配应用
$("#assignApp").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url="editAccountApp.jsp?elsAccount="+selectRow[0].elsAccount+"&elsSubAccount="+selectRow[0].elsSubAccount;
	 parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'editAccountApp',
	        'windowTitle':'<i18n:I18n defaultValue="分配应用" key="i18n_label_assign_app"></i18n:I18n>',
	        'iframSrc':url,
	        windowMinWidth: 400,
	        windowMinHeight: 500,
	        windowPositionTop:24,
	        'windowWidth':400,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
});
//数据权限
$("#dataPermission").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'dataRuleManage',
        'windowTitle':'<i18n:I18n defaultValue="数据权限" key="i18n_label_data_permission"></i18n:I18n>',
        windowSubTitle: selectRow[0].name,
        'iframSrc':'<%=basePath%>datapermission/dataRuleManage.jsp?ruleType=2&ruleTarget=' + selectRow[0].elsSubAccount,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
});


//更改密码 
$("#passWordChange").click(function(){
	$('.fixed-dialog').show();
	//将选择行的信息填充到对应的窗口下 .
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'changePassword',
        'windowTitle':'<i18n:I18n defaultValue="更改密码" key="i18n_account_button_passwordchange"></i18n:I18n>',
        windowSubTitle: selectRow[0].name,
        'iframSrc':'<%=basePath%>systemset/passwordmanage/changeSubAccountPassword.jsp?elsAccount='+selectRow[0].elsAccount+'&elsSubAccount='+selectRow[0].elsSubAccount,
        windowMinWidth: 300,
        windowMinHeight: 300,
        windowPositionTop:24,
        'windowWidth':350,
        'windowHeight':400,
        'parentPanel':".currDesktop"
    });

});

//密码更改记录
$("#passWordRecord").click(function(){
	$('.fixed-dialog').show();
	//将选择行的信息填充到对应的窗口下 .
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'changePassword',
        'windowTitle':'<i18n:I18n defaultValue="查看密码更改记录" key="i18n_account_button_passwordrecord"></i18n:I18n>',
        windowSubTitle: selectRow[0].name,
        'iframSrc':'<%=basePath%>systemset/passwordmanage/passwordRecord.jsp?elsAccount='+selectRow[0].elsAccount+'&elsSubAccount='+selectRow[0].elsSubAccount,
        windowMinWidth: 300,
        windowMinHeight: 300,
        windowPositionTop:24,
        'windowWidth':800,
        'windowHeight':400,
        'parentPanel':".currDesktop"
    });

});

//代理授权
$("#agent").click(function() {
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'agentSubAccount',
        'windowTitle':'<i18n:I18n defaultValue="代理授权" key="i18n_label_agent_subAccount"/>',
        'iframSrc':'<%=basePath%>account/agentSubAccount.jsp',
        windowStatus: 'regular',
        windowMinWidth: 500,
        windowMinHeight: 530,
        windowPositionTop:24,
        'windowWidth':550,
        'windowHeight':330,
        'parentPanel':".currDesktop"
    });
});

//代理授权查询
$("#agentList").click(function() {
	$('.fixed-dialog').show();
	//将选择行的信息填充到对应的窗口下 .
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'agentListSubAccount',
        'windowTitle':'<i18n:I18n defaultValue="代理授权查询" key=""></i18n:I18n>',
        windowSubTitle: selectRow[0].name,
        'iframSrc':'<%=basePath%>account/listAgentSubAccount.jsp?elsAccount='+selectRow[0].elsAccount+'&elsSubAccount='+selectRow[0].elsSubAccount,
        windowMinWidth: 300,
        windowMinHeight: 300,
        windowPositionTop:24,
        'windowWidth':800,
        'windowHeight':400,
        'parentPanel':".currDesktop"
    });
});

$("#frozenOrUnfreeze").click(function(){
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var frozenFlag = selectRow[0].frozenFlag;
	var elsSubAccount = selectRow[0].elsSubAccount;
	if(elsSubAccount == "1001"){
		alert('<i18n:I18n defaultValue="1001账号的冻结操作请联系系统管理员！" key="i18n_account_alert_frozen1001"/>',2);
		return;
	}
	var messageText;
	if(frozenFlag == 'N'){
		messageText = '<i18n:I18n defaultValue="您将冻结子账号：" key="i18n_account_alert_frozenSubAccount"/>'+elsSubAccount;
		frozenFlag = "Y";
	}else{
		messageText = '<i18n:I18n defaultValue="您将解冻子账号：" key="i18n_account_alert_unfreezeSubAccount"/>'+elsSubAccount;
		frozenFlag = 'N'
	}
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:messageText,closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/AccountService/frozenOrUnfreeze",
			type :"POST",
			contentType : "application/json",
			data : JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"frozenFlag":frozenFlag}),
			dataType : "json",
			success : function(data) {
				alert('<i18n:I18n defaultValue="操作成功" key=""></i18n:I18n>',1);
				queryAccountInfo();   
			},
			error : function(data) {
				parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n defaultValue="请求出错" key="i18n_common_alert_requestfail"></i18n:I18n>'});
			}
		});
	}});
	
});

</script>
</html>