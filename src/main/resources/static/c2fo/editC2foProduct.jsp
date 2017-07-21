<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button id="saveBtn" class="edit-btn button-wrap"><i18n:I18n key="i18n_button_publish" defaultValue="发布" /></button>
            <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
        </div>
    </div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;" action="<%=basePath%>rest/C2foService/findProduct">
	<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount }"/>
     <div class="box-wrap pos-relative bg-common">
          <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_baseInfo" defaultValue="基础信息" /></span>
          <div class="common-box-line">
			<main class="grid-container">
                  <div class="grid-100">
                      <table id="table-head"></table>
                  </div>
              </main>
       	</div>
	</div>
	
	<div class="box-wrap pos-relative bg-common">
          <div class="common-box-line">
          	<div class="tab-wrap" id="sheet-project">
				<ul>
					<li><a href="#sheet-item-one"><i18n:I18n key="i18n_title_filterRule" defaultValue="过滤规则" /></a></li>
					<li><a href="#sheet-item-two"><i18n:I18n key="i18n_titel_payDetail" defaultValue="应付款明细" /></a></li>
				</ul>
				<div id="sheet-item-one">
					<div class="edit-box-wrap">
					合作时间:>=<input id="year" value="1" style="text-align:right;width:30px"/>年&nbsp;&nbsp;
					<input id="havePay" type="checkbox" checked/>当前有应付账款&nbsp;&nbsp;
					<input id="havePlanPay" type="checkbox" checked/>当前有应付暂估&nbsp;&nbsp;
					<button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
					</div>
					<div class="edit-box-wrap">
					发票提前支付上限：<input id="upRate" value="100" style="text-align:right;width:30px"/>%&nbsp;&nbsp;
					电子对账单提前支付上限：<input id="upRatePlan" value="70" style="text-align:right;width:30px"/>%&nbsp;&nbsp;
					支付合计：<input id="totalPay" value="0" style="text-align:right;width:80px" readOnly/>&nbsp;&nbsp;
					折扣收益合计：<input id="totalIncome" value="0" style="text-align:right;width:80px" readOnly/>&nbsp;&nbsp;
					</div>
					<main class="grid-container">
		                  <div class="grid-100">
		                      <table id="table-item"></table>
		                  </div>
		              </main>
				</div>
          	</div>
       	</div>
	</div>
</form>
<script type="text/javascript">
var orderNumber = GetQueryString("orderNumber");
var headGrid;
var itemGrid;
var itemDetailGrid;
var cols_head = [
            { title:'产品订单号', name:'orderNumber' ,width:100, align:'center',renderer:function(val){ if (!val) {val=""} return '<span>&nbsp;</span>';}},
            { title:'总提前支付金额', name:'totalAmount' ,width:100, align:'center',renderer:function(val){
            	if (!val) {val=""}
            	return "<input type='text' name='c2foHeader[totalAmount]' value='"+val+"'/>";
            }},
            { title:'参考折扣率（年）%', name:'discountRateYear' ,width:120, align:'center',renderer:function(val){
            	if (!val) {val=""}
            	return "<input type='text' name='c2foHeader[discountRateYear]' value='"+val+"'/>";
            }},
            { title:'参考折扣率（日）%', name:'discountRateDay' ,width:120, align:'center',renderer:function(val){
            	if (!val) {val=""}
            	return "<input type='text' name='c2foHeader[totalAdiscountRateDaymount]' value='"+val+"' readOnly/>";
            }},
            { title:'最短期限', name:'term' ,width:100, align:'center',renderer:function(val){
            	if (!val) {val=""}
            	return "<select name='c2foHeader[term]' value='"+val+"'><option value='15'>15天</option><option value='30'>30天</option><option value='60'>60天</option><option value='90'>90天</option></select>";
            }},
            { title:'有效截止日', name:'validDate' ,width:100, align:'center',renderer:function(val){
            	if (!val) {val=""}
            	return "<input type='text' name='c2foHeader[validDate]' class='Wdate' onfocus='WdatePicker();' value='"+val+"' />";
            }},
            { title:'预期支付日', name:'planPayDate' ,width:100, align:'center',renderer:function(val){
            	if (!val) {val=""}
            	return "<input type='text' name='c2foHeader[planPayDate]' class='Wdate' onfocus='WdatePicker();' value='"+val+"' />";
            }}
        ];
var cols_item = [
                 { title:'供应商ELS号', name:'toElsAccount' ,width:100, align:'center'},
                 { title:'供应商名称', name:'companyShortName' ,width:100, align:'center'},
                 { title:'当前应付款项', name:'payAmount' ,width:100, align:'center'},
                 { title:'当前应付暂估', name:'planPayAmount' ,width:100, align:'center'},
                 { title:'应付总额', name:'totalPayAmount' ,width:100, align:'center'},
                 { title:'折扣率', name:'discountRate' ,width:100, align:'center'},
                 { title:'提前支付上限', name:'upLimitPayAmount' ,width:100, align:'center'},
                 { title:'折扣金额', name:'discountAmount' ,width:100, align:'center'}
             ];
$().ready(function(){
	init();
});
function init(){
	$( "#sheet-project").tabs();
	if (orderNumber == ""||orderNumber == null) {
		var initItems = [{"orderNumber":"","discountRateYear":"18","discountRateDay":"0.05","term":"15"}];
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height: 100,
	        items:initItems
	    });
		itemGrid = $('#table-item').mmGrid({
			multiSelect: true,
	        checkCol:true,
	        cols: cols_item,
	        items:[]
	    });
		$("#queryBtn").click(function(){
			query();
		});
	}
	
}
function query() {
	var isPlan = "";
	if ($("#havePay").attr("checked") && !$("#havePlanPay").attr("checked")) {
		isPlan = "N";
	} else if (!$("#havePay").attr("checked") && $("#havePlanPay").attr("checked")) {
		isPlan = "Y";
	}
	var year = "";
	if ($("#year").val()!="" && isNaN($("#year").val())) {
		alert("合作时间请输入数字",2);
		return;
	} else {
		year = $("#year").val();
	}
	var json={"elsAccount":elsAccount,"year":year,"isPlan":isPlan};
	var paramStr = JSON.stringify(json);
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/C2foService/queryC2foItem" ,
		contentType : "application/json",
 		type : "post",
 		dataType : "json",
 		data:paramStr,
 		success : function(data) {
 			parent.elsDeskTop.hideLoading();
 			itemGrid.load(data.rows);
 		},
 		error : function(data) {
 			parent.elsDeskTop.hideLoading();
 			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
 		}
 	});
}
//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10));
});

</script>
</body>
</html>