<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative ">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="addBtn" class="button-wrap"><i18n:I18n key="i18n_delivery_lable_createdelivery" defaultValue="新建发货单" /></button>
                <button  id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form style="margin:0;" id="queryForm" onsubmit="return false;">
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input name="purchaseOrderNumber" id="purchaseOrderNumberParam" type="text"/></div>
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_saleOrderNumber" defaultValue="销售订单号" />：</span><input name="saleOrderNumber" type="text"/></div>
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_delivery_lable_deliveryorderstatus" defaultValue="交货状态" />: </span>
                	<select name="deliveryStatus">
                		<option value="1"><i18n:I18n key="i18n_delivery_lable_delivernotall" defaultValue="未全部交货" /></option>
                		<option value="2"><i18n:I18n key="i18n_delivery_lable_deliverall" defaultValue="全部交货" /></option>
                	</select>
                </div>
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_additionCost_toElsAccount" defaultValue="客户ELS号" />: </span><input type="text" name="toElsAccount"/></div>
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_tocompanyshortname" defaultValue="客户ELS名称" />: </span><input type="text" name="companyShortName"/></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_deliverydate" defaultValue="交货日期" />：</span></div>
                <input type="radio" name="dateArea" value="twoDays"><i18n:I18n key="i18n_delivery_lable_intwodays" defaultValue="未来两天" /><input type="radio" name="dateArea" value="week"><i18n:I18n key="i18n_delivery_lable_nextweek" defaultValue="未来一周" /><input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_delivery_lable_nextmonth" defaultValue="未来一个月" /><input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startDeliveryDate" name="startDeliveryDate"/></div>
                <div class="dis-in-b input-and-tip" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endDeliveryDate" class="Wdate" onfocus="WdatePicker()" name="endDeliveryDate" /></div>
            	<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_orderitems" defaultValue="订单行项目" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
    </div>
<script type="text/javascript">
var itemGrid;
var outParam;
$().ready(function(){
	init();
});

var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="createDelivery_mt"/>;
function getDate(dates){
	var dd = new Date();
	dd.setDate(dd.getDate()+dates);
	return dd.format("yyyy-MM-dd");
}
function changeDateArea() {
	var dateArea = $("[name=dateArea]:checked").val();
	if (dateArea == "define") {
		$("#startDeliveryDate").val("");
		$("#endDeliveryDate").val("");
		$("#startDeliveryDate").parent().show();
		$("#endDeliveryDate").parent().show();
	} else {
		$("#startDeliveryDate").parent().hide();
		$("#endDeliveryDate").parent().hide();
		//$("#startDeliveryDate").val(new Date().format("yyyy-MM-dd"));
		$("#startDeliveryDate").val("");
		var endDeliveryDate = "";
		if (dateArea == "twoDays") {
			endDeliveryDate = getDate(2);
		} else if (dateArea == "week") {
			endDeliveryDate = getDate(7);
		} else if (dateArea == "month") {
			endDeliveryDate = getDate(30);
		}
		$("#endDeliveryDate").val(endDeliveryDate);
	}
}

function init() {
	//初始化控件
    changeDateArea();
    $("#elsAccount").val(currentElsAccount);
// 	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#queryForm");
	outParam=frm.serializeJSON();
    $("[name=dateArea]").click(changeDateArea);
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId);
		} else {
			parent.elsDeskTop.closeCurWin("createDelivery");
		}
	});
	$("#queryBtn").click(function(){
		query();
	});
	$("#addBtn").click(function(){
		addDelivery();
	});
	var height=$(document).height()-300;
    //订单头列表
    var frm = $("#queryForm");
	itemGrid = $('#table-head').mmGrid({
        cols: cols_item,
        url: "<%=basePath%>rest/MaterialVoucherService/querySaleOrderItemList",
        params: frm.serializeJSON(),
        method:  "post",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        multiSelect:true,
        checkCol:true,
        height:height,
        remoteSort:true,
        plugins: [
            $('#pg').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                , limit:null
                , limitList: [10,20]
            })
        ]
    });
}
function query() {
	var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#queryForm");
	outParam=frm.serializeJSON();
	itemGrid.opts.params = outParam;
	itemGrid.load({});
}
function addDelivery() {
	var rows = itemGrid.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key='i18n_refund_chooseitem' defaultValue='请选择行项目' />",2);
		return;
	}
	var toElsAccount = rows[0].toElsAccount;
	var flag = true;
	var isExit=false;
	var selectedItems = "";
	if(rows.length==itemGrid.rows().length){//如果是全选
		if(confirm("是否选择全部符合条件的订单项？")){
			$.ajax({
				url :'<%=basePath%>rest/MaterialVoucherService/getSelectItemStr',
				type :"post",
				contentType : "application/json",
				async:false,
				data : JSON.stringify(outParam),
				dataType : "json",
				success : function(data) {
					if(data!=null&&data.statusCode=="-100"){
						alert(data.message,2);
						isExit=true;
					}else{
						selectedItems=data.itemIds+"";
					}
				},
				error : function(data) {
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
					isExit=true;
				}
			});
		}else{
			for (var i=0;i< rows.length;i++) {
				if (rows[i].toElsAccount != toElsAccount) {
					flag = false;
				}
				selectedItems += rows[i].saleOrderNumber + "-" + rows[i].orderItemNumber + ",";
			}
		}
	}else{//如果不是全选
		//判断是否是一个客户的订单
		for (var i=0;i< rows.length;i++) {
			if (rows[i].toElsAccount != toElsAccount) {
				flag = false;
			}
			selectedItems += rows[i].saleOrderNumber + "-" + rows[i].orderItemNumber + ",";
		}
	}
	
	if (!flag) {//如果不是同一个客户
		alert("<i18n:I18n key='i18n_delivery_toelsmustbesame' defaultValue='只能选择同一客户的订单行项目' />",2);
		return;
	}
	if(isExit){//如果全选查询失败
		return;
	}
	selectedItems = selectedItems.substring(0,selectedItems.length - 1);
	//创建发货单
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editDelivery',
        'windowTitle':'<i18n:I18n key="i18n_delivery_lable_createdelivery" defaultValue="新建发货单" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>ordermanage/materialVoucher/editDelivery.jsp?toElsAccount='+toElsAccount+'&selectedItems=' + selectedItems,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}

$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=createDelivery_mt" + "&window=iframeApp_createDelivery",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
</script>
</body>
</html>