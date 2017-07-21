<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
     	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            	<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div> 
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
<script type="text/javascript">
var itemGrid;
var cols_item = [
                 {title:'<i18n:I18n key="i18n_label_time" defaultValue="时间" />', name:'time', width: 150,align:"center"},
                 {title:'<i18n:I18n key="i18n_label_deliveryInfo" defaultValue="物流信息" />', name:'content', width: 320,align:"left"}
             ];
$().ready(function(){
	init();
});
var fromWindow = "<%=request.getParameter("window")%>";
function init(){
	//初始化控件
	var id = "<%=request.getParameter("id")%>";
	var order = "<%=request.getParameter("order")%>";
	// 获取用户自定义表格
	$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/viewDeliveryFlow/"+id+"/" + order,
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if(data&&data.errcode&&data.errcode == "0000") {
					itemGrid =  $('#table-item').mmGrid({
				        cols: cols_item,
				        height:350,
				        items:data.data
					});
				} else {
					itemGrid =  $('#table-item').mmGrid({
				        cols: cols_item,
				        height:350,
				        items:[]
					});
					alert("<i18n:I18n key="i18n_alert_norelatedinfo" defaultValue="没有查到相关信息" />",2)
				}
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('deliveryFlowList');
	});
}
function closeCallback() {
	if (fromWindow && parent.frames[fromWindow]) {
		parent.frames[fromWindow].location.reload();
	}
}
</script>
</body>
</html>