<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
        <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            	<button style="margin-left: 20px;" id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div> 
        </div>
        <div class="box-wrap pos-relative bg-common">
        <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/TableColumnService/updateSubAccountColumn">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_auditflow" defaultValue="审批流程" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                    </div>
                </main>
            </div>
        </form>
        </div>
<script type="text/javascript">
var itemGrid;
var cols_item = [
                 {title:'<i18n:I18n key="i18n_label_auditTime" defaultValue="操作时间" />', name:'auditTime', width: 150, align: 'center', renderer:timeFormat},
                 {title:'<i18n:I18n key="i18n_label_auditElsAccount" defaultValue="操作人ELS号" />', name:'auditElsAccount', width: 100, align: 'center'},
                 {title:'<i18n:I18n key="i18n_label_auditElsSubAccount" defaultValue="操作人ELS子账号" />', name:'auditElsSubAccount' ,width:100, align:'center'},
                 {title:'<i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />', name:'auditStatus', width: 80, align: 'center', renderer:function(val){
                	if (val == "1") {
                		return "<b><i18n:I18n key="i18n_select_approveStatus_notapproved" defaultValue="未审批" /></b>";
                	} else if (val == "2") {
                		return "<font color='blue'><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></font>";
                	} else if (val == "3") {
                		return "<font color='red'><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></font>";
                	} else if (val == "0") {
                		return "<font color='green'><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></font>";
                	} else {
                		return "<i18n:I18n key="i18n_label_entryAudit" defaultValue="上报" />";
                	}
                 } },
                 {title:'<i18n:I18n key="i18n_label_auditOpinion" defaultValue="审批意见" />', name:'auditOpinion' ,width:200, align:'center'}
             ];
$().ready(function(){
	init();
});
var elsAccount = "<%=request.getParameter("elsAccount")%>";
var businessType = "<%=request.getParameter("businessType")%>";
var businessId = "<%=request.getParameter("businessId")%>";
function init(){
	//初始化控件
    var height = $(document).height()-120;
    var param = {'elsAccount':elsAccount,'businessType':businessType,'businessId':businessId,'isHead':'Y'};
	if (!itemGrid) {
		 itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        url : "<%=basePath%>rest/AuditService/queryAuditRecord",
	        method:  "POST",
	        params:param,
	        height: height,
	        root:"rows",
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    });
	}
	
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('auditFlowList');
	});
}
</script>
</body>
</html>