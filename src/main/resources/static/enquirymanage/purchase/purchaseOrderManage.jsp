<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative public-wrap active">
    
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
            <div class="common-box-line">
                <button class="button-wrap">从ERP获取</button>
                <button id="addBtn" class="button-wrap">新建</button>
                <button id="modifyBtn" class="button-wrap">修改</button>
                <button id="deleteBtn" class="button-wrap">删除</button>
                <button id="sendBtn" class="button-wrap">发送</button>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">条件查询</span>
            <form id="queryForm" onsubmit="return false;" method="POST">
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
            	<input type="hidden" id="toElsAccount" name="toElsAccount" value="<%=request.getParameter("toElsAccount")%>"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span>采购订单：</span><input name="purchaseOrderNumber" type="text"/></div>
                <div class="dis-in-b input-and-tip"><span>订单日期：</span><input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate"/></div>
                <div class="dis-in-b input-and-tip"><span>到 </span><input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate"/></div>
				<div class="dis-in-b input-and-tip"><span>采购组: </span><input type="text" name="purchaseGroup"/></div>
                <div class="dis-in-b input-and-tip"><span>物料组: </span><input type="text" name="materialGroup"/></div>
            	<button id="queryBtn" class="button-wrap">查询</button>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">采购订单头</span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">采购行项目</span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one">采购行项目</a></li>
                        <li><a href="#sheet-project-two">表单文件</a></li>
                    </ul>
                    
                    <%--采购行项目 --%>
                    <div id="sheet-project-one">
                        <main class="grid-container">
		                    <div class="grid-100">
		                        <table id="table-item"></table>
		                    </div>
		                </main>
                    </div>
                    
                    <%--表单文件 --%>
                    <div id="sheet-project-two">
                    </div>
                </div>
            </div>
        </div>
        
 		<%--聊天窗口 --%>
        <div class="pos-absolute saying-dialog">
            <div class="saying-wrap">
                <div class="pos-relative saying-bar">
                    <img class="dis-block pos-absolute option-bar come" src="<%=basePath %>extend/images/hover.png" alt="" title="点击收起" />
                    <img class="dis-block pos-absolute option-bar back" src="<%=basePath %>extend/images/hover-back.png" alt="" title="点击展开" />
                    <div class="dialog-content">
                        <div class="saying-box-wrap">
                            对话进行中...
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
// 定义变量
var headGrid;
var itemGrid;
var currentPurchaseOrderNumber;
$().ready(function(){
	init();
});

//列--头
var cols = [
    {title:'采购凭证号', name:'purchaseOrderNumber', width: 150, align: 'center'},
    { title:'订单类型', name:'orderType' ,width:100, align:'center' },
    { title:'采购订单状态', name:'orderStatus' ,width:150, align:'center',renderer:function(val){
    	if (val == "0") {
    		return "对方未确认";
    	} else if (val == "1") {
    		return "对方已确认";
    	} else if (val == "2") {
    		return "对方退回";
    	} else if (val == "7") {
    		return "更新生成状态";
    	}
    }},
    { title:'订单发送状态', name:'orderSendStatus' ,width:150, align:'center',renderer:function(val){
    	if (val == "0") {
    		return "未发送";
    	} else if (val == "1") {
    		return "已发送，对方已接收";
    	} else if (val == "2") {
    		return "已发送，等待对方接收";
    	}
    }},
    { title:'采购凭证日期', name:'orderDate' ,width:150, align:'center'},
    { title:'货币', name:'currency' ,width:60, align:'center'},
    { title:'订单交收状态', name:'deliveryStatus' ,width:150, align:'center',renderer:function(val){
    	if (val == "0") {
    		return "未交收";
    	} else if (val == "1") {
    		return "订单交货在途";
    	} else if (val == "2") {
    		return "部分交收";
    	} else if (val == "3") {
    		return "全部交收";
    	} else if (val == "4") {
    		return "超量交货";
    	}
    }},
    { title:'备注', name:'remark' ,width:100, align:'center'},
    { title:'时间戳', name:'logtime' ,width:100, align:'center',renderer:function(val){
    	if (!val) {
    		return "";
    	}
    	return new Date(val).format("yyyy-MM-dd");
    }},
    { title:'备注1', name:'fbk1' ,width:100, align:'center'},
    { title:'备注2', name:'fbk2' ,width:100, align:'center'},
    { title:'备注3', name:'fbk3',width:100, align:'center'},
    { title:'负责人', name:'fbk4' ,width:100, align:'center'},
    { title:'对方负责人', name:'fbk5' ,width:100, align:'center'}
];
//列--行
var cols_item = [
            {title:'项目编号', name:'orderItemNumber', width: 150, align: 'center'},
            { title:'网格值', name:'gridValue' ,width:100, align:'center' },
            { title:'物料号', name:'materialNumber' ,width:150, align:'center'},
            { title:'物料描述', name:'materialDesc' ,width:150, align:'center'},
            { title:'采购订单数据', name:'quantity' ,width:150, align:'center'},
            { title:'单价', name:'price' ,width:60, align:'center'},
            { title:'数量单位', name:'unitQuantity' ,width:150, align:'center'},
            { title:'价格单位', name:'unitPrice' ,width:100, align:'center'},
            { title:'价格度量单位', name:'unitMeasure' ,width:100, align:'center'},
            { title:'已经发货数量', name:'deliveredQuantity' ,width:100, align:'center'},
            { title:'在途数量', name:'onWayQuantity',width:100, align:'center'},
            { title:'已经收货数量', name:'receivedQuantity' ,width:100, align:'center'},
            { title:'退货数量', name:'retuenQuantity' ,width:100, align:'center'},
            { title:'订单批次', name:'orderBatch' ,width:100, align:'center'},
            { title:'订单生产状态', name:'productionStatus' ,width:100, align:'center'},
            { title:'交货日期', name:'deliveryDate' ,width:100, align:'center'},
            { title:'工厂', name:'factory' ,width:100, align:'center'},
            { title:'103品检收货折百数量', name:'WESBS' ,width:100, align:'center'},
            { title:'103品检实物收货数量', name:'WESBZ' ,width:100, align:'center'},
            { title:'总金额', name:'totalAmount' ,width:100, align:'center'},
            { title:'材质属性', name:'materialAttr' ,width:100, align:'center'},
            { title:'材质编码', name:'materialEncode' ,width:100, align:'center'},
            { title:'库存地点', name:'inventoryLocation' ,width:100, align:'center'},
            { title:'物料组', name:'materialGroup' ,width:100, align:'center'},
            { title:'ERP系统的已交货数量', name:'erpDeliveredQuantity' ,width:100, align:'center'},
            { title:'备注', name:'remark' ,width:100, align:'center'},
            { title:'时间戳', name:'logtime' ,width:100, align:'center',renderer:function(val){
            	if (!val) {
            		return "";
            	}
            	return new Date(val).format("yyyy-MM-dd");
            }}
        ];
function init() {
	//初始化控件
    $( "#sheet-project").tabs();
	
//     $( "#startOrderDate" ).datepicker();
//     $( "#endOrderDate" ).datepicker();
    
    //订单头列表
    var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
    headGrid = $('#table-head').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderByCondtion",
        params: frm.serializeJSON(),
        method:  frm[0].method,
        root:"rows",
        loadingText: '正在载入',
        noDataText: '暂无数据',
        remoteSort:true,
        plugins: [
            $('#pg').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '每页{0}条'
                , totalCountLabel: '共<span>{0}</span>条记录'
                , limit:null
                , limitList: [10,20]
            })
        ]
    });
    // 勾选加载明细项
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	currentPurchaseOrderNumber = item.purchaseOrderNumber
    	loadItem(currentPurchaseOrderNumber);
    });
    // 订单头加载成功加载明细项
    headGrid.on('loadSuccess',function(e, data) {
    	//为空
    	if (!itemGrid) {
    	    itemGrid = $('#table-item').mmGrid({
    	        cols: cols_item,
    	        items: []
    	    });
    	}
    	// 不为空
    	if (data.rows && data.rows.length > 0) {
			//默认选中第一行并查询订单行信息
			headGrid.select(0);
			currentPurchaseOrderNumber = data.rows[0].purchaseOrderNumber;
			loadItem(currentPurchaseOrderNumber);
		}
    });
    //功能操作
    // 聊天界面 点击展开
    $('.option-bar.come').click(function() {
        $('.dialog-content').hide();
        $(this).hide();
        $('.option-bar.back').show();
        $('.public-wrap').removeClass('active');
        $('.saying-dialog').addClass('active');

    });
    // 聊天界面 点击收起
    $('.option-bar.back').click(function() {
        $('.dialog-content').show();
        $(this).hide();
        $('.option-bar.come').show();
        $('.public-wrap').addClass('active');
        $('.saying-dialog').removeClass('active');
    });
    // 查询按钮
    $("#queryBtn").click(function(){
    	query();
    });
    // 新建按钮
    $("#addBtn").click(function(){
    	insertPurchaseOrder();
    });
    // 发送按钮
    $("#sendBtn").click(function(){
    	sendPurchaseOrder();
    });
    // 修改按钮
    $("#modifyBtn").click(function(){
    	modifyPurchaseOrder();
    });
    // 删除按钮
    $("#deleteBtn").click(function(){
    	deletePurchaseOrder();
    });
    //初始化对话框
    var dh = $('.saying-bar').height();
    var dw = $('.saying-bar').width();
    $('.saying-box-wrap').css({'height': parseInt(dh-60) + 'px','width': parseInt(dw-10) + 'px'});
}
// 删除方法
function deletePurchaseOrder(){
	if (!currentPurchaseOrderNumber) {
		alert("请选择订单！");
		return;
	}
	//获取当前选中的
	if (confirm("确认删除吗")) {
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseOrderService/deletePurchaseOrder/" +currentPurchaseOrderNumber +"/" + elsAccount + "/" + elsSubAccount, 
    		type : "get",
    		dataType : "json",
    		success : function(data) {
    			alert("删除成功");
    			query();
    		},
    		error : function(data) {
    			alert("删除出错");
    		}
    	});
	}
}
// 发送方法
function sendPurchaseOrder(){
	if (!currentPurchaseOrderNumber) {
		alert("请选择订单！");
		return;
	}
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"purchaseOrderNumber":currentPurchaseOrderNumber};
	//获取当前选中的
	if (confirm("确认发送订单吗")) {
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseOrderService/sendPurchaseOrderByNumber",
    		contentType : "application/json",
    		type : "post",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			alert("发送成功");
    			query();
    		},
    		error : function(data) {
    			alert("发送失败");
    		}
    	});
	}
}
// 修改方法
function modifyPurchaseOrder(){
	if (!currentPurchaseOrderNumber) {
		alert("请选择订单！");
		return;
	}
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	//获取对方elsAccount
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'PurchaseOrderUpdate',
        'windowTitle':'修改采购订单',
        windowSubTitle: toCompanyName,
        'iframSrc':'<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=' + toElsAccount + "&purchaseOrderNumber="+currentPurchaseOrderNumber,
        showAdv: true,
        advArr: ['icon/test-car.png','icon/test-car2.png'],
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
// 新建方法
function insertPurchaseOrder(){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	//获取对方elsAccount
	var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
	var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'PurchaseOrderUpdate',
        'windowTitle':'新建采购订单',
        windowSubTitle: toCompanyName,
        'iframSrc':'<%=basePath%>ordermanage/purchaseorder/editPurchaseOrder.jsp?toElsAccount=' + toElsAccount,
        showAdv: true,
        advArr: ['icon/test-car.png','icon/test-car2.png'],
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
// 查询订单行信息
function loadItem(purchaseOrderNumber) {
	$.ajax({
		url : "<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderItemByNumber/" + elsAccount + "/" + purchaseOrderNumber,
		type : "get",
		dataType : "json",
		success : function(data) {
			itemGrid.load(data.rows);
		},
		error : function(data) {
			alert("提示", "查询出错");
		}
	});
}
// 查询按钮方法
function query() {
	var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#queryForm");
	headGrid.opts.params = frm.serializeJSON();
	headGrid.load({});
}
</script>
</body>
</html>