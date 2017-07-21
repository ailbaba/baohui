<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="elsHeader.jsp"%>
<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="accoutForm">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="toElsAccount" name="toElsAccount">
                <input type="hidden" id="toElsSubAccount" name="toElsSubAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"/>:</span>
			       <input id="fromElsAccount" name="fromElsAccount" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="公司名称" key="test"/>:</span>
			       <input id="companyName" name="companyName" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_handleFlag" defaultValue="处理状态" />：</span>
            	<select id="verifyStatus" name="verifyStatus">
            		<option value="3"><i18n:I18n key="test" defaultValue="全部" /></option>
            		<option value="0"><i18n:I18n key="test" defaultValue="待验证" /></option>
            		<option value="1"><i18n:I18n key="test" defaultValue="已通过" /></option>
            		<option value="2"><i18n:I18n key="test" defaultValue="已拒绝" /></option>
            	</select>
            	</div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryAccount" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="agreement" class="button-wrap" ><i18n:I18n key="i18n_common_button_agree" defaultValue="同意" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="reject" class="button-wrap"><i18n:I18n key="i18n_common_button_reject" defaultValue="拒绝" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="check" class="button-wrap"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看账户信息" /></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
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

<script>

var accountGrid;
var winId = "<%= request.getParameter("winId") %>";
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';

$().ready(function(){
	init();
});	

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

function rendererVerifyStatus(val){
	if (val == "0") {
        return '<font color="red"><i18n:I18n key="i18n_account_select_verifyStatus_waitingVerification" defaultValue="待验证" /></font>';
    }
    else if (val == "1") {
        return '<font color="green"><i18n:I18n key="i18n_account_select_verifyStatus_pass" defaultValue="通过" /></font>';
    }else{
    	return '<i18n:I18n key="i18n_account_select_verifyStatus_reject" defaultValue="拒绝" />';
    }
}

var accountCols = [
                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'fromElsAccount' , width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司名称" />', name:'companyName' , width:100, align:'center'},
                   { title:'<i18n:I18n key="i18n_account_title_verificationInformation" defaultValue="验证信息" />', name:'requestContent' ,width:140, align:'center'},
                   { title:'<i18n:I18n key="i18n_account_title_verificationStatus" defaultValue="验证状态" />', name:'verifyStatus' ,width:100, align:'center',renderer:rendererVerifyStatus},
                   { title:'<i18n:I18n key="i18n_common_title_requestdate" defaultValue="请求时间" />', name:'requestDateTime' ,width:140, align:'center',renderer:rendererTime},
                   { title:'<i18n:I18n key="i18n_account_title_rejectReason" defaultValue="拒绝理由" />', name:'rejectReason' ,width:200, align:'center'},
                   { title:'requestId', name:'requestId' ,width:200, align:'center',hidden:true}
            ];

function init(){
	$("#toElsAccount").val(elsAccount);
    $("#toElsSubAccount").val(elsSubAccount);
    // 截取fromElsAccount
    $("#fromElsAccount").val(winId.substring(12,18));
   var frm = $("#accoutForm");
	 //初始化控件
   $('button').button();
	accountGrid=$('#table-account').mmGrid({
	    cols: accountCols,
	    url: '<%=basePath%>rest/FriendsService/findMyFriendVerify',
	    params: frm.serializeJSON(),
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
	
	accountGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
   	    $('body').data('account',item);
    });
	accountGrid.on('loadSuccess',function(e, item, rowIndex, colIndex) {
		$("#currentPage").val(item.currentPage);
    });
}

function queryAccount() {
	var frm = $("#accoutForm");
	accountGrid.opts.params = frm.serializeJSON();
	var currentPage = $("#currentPage").val();
	accountGrid.load({page:currentPage});
}

//查询
$("#queryAccount").click(function() {
	queryAccount();
});
//同意
$("#agreement").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	if(selectRow[0].verifyStatus=="0"){
		var url='<%=basePath%>friends/agreeFriend.jsp?requestId='+selectRow[0].requestId+'&parentWinId='+winId;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_29.gif',
	        'windowsId':'agreeFriend',
	        'windowTitle':'<i18n:I18n key="i18n_account_title_agreeAdd" defaultValue="同意添加好友" />',
	        'iframSrc':url,
	        windowStatus: 'regular',
	        windowMinWidth: 400,
	        windowMinHeight: 200,
	        'windowWidth':400,
	        'windowHeight':200,
	        windowPositionTop:100,
	        'parentPanel':".currDesktop"
	    });
	}
});

//拒绝
$("#reject").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	if(selectRow[0].verifyStatus=="0"){
		var url='<%=basePath%>friends/rejectFriend.jsp?requestId='+selectRow[0].requestId+'&parentWinId='+winId;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_29.gif',
	        'windowsId':'rejectFriend',
	        'windowTitle':'<i18n:I18n key="i18n_account_title_rejectAdd" defaultValue="拒绝添加好友" />',
	        'iframSrc':url,
	        windowStatus: 'regular',
	        windowMinWidth: 400,
	        windowMinHeight: 240,
	        'windowWidth':400,
	        'windowHeight':240,
	        windowPositionTop:100,
	        'parentPanel':".currDesktop"
	    });
	}
});

//查看资料
$("#check").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url='<%=basePath%>account/displayAccount.jsp?elsAccountNumber='+selectRow[0].fromElsAccount;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_29.gif',
        'windowsId':'PurchaseEnHisPrice',
        'windowTitle':'<i18n:I18n defaultValue="账户信息" key="i18n_account_title_accountInformation"></i18n:I18n>',
        'iframSrc':url,
        windowStatus: 'regular',
        windowMinWidth: 900,
        windowMinHeight: 500,
        'windowWidth':900,
        'windowHeight':550,
        windowPositionTop:0,
        'parentPanel':".currDesktop"
    });
});

$('#table-account').on('dblclick','tr',function() {
	var account = $('body').data('account');
	var url='<%=basePath%>account/displayAccount.jsp?elsAccountNumber='+account.fromElsAccount;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
        'windowsId':'PurchaseEnHisPrice',
        'windowTitle':'<i18n:I18n defaultValue="账户信息" key="i18n_account_title_accountInformation"></i18n:I18n>',
        'iframSrc':url,
        windowStatus: 'regular',
        windowMinWidth: 900,
        windowMinHeight: 500,
        'windowWidth':900,
        'windowHeight':550,
        windowPositionTop:0,
        'parentPanel':".currDesktop"
    });
});
</script>

</body>
</html>
