<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative ">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="modifyBtn" class="button-wrap"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
<%--                 <button id="sendBtn" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button> --%>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/PurchaseQuotationService/findPurchaseQuotation">
            	<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount}"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount" value="${elsSubAccount}"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_quotation_number" defaultValue="报价单号" />：</span><input name="quotationNumber" type="text"/></div>
<!--            <div class="dis-in-b input-and-tip"><span>供应商ELS: </span><input type="text" name="toElsAccount"/></div> -->
                <br><div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_quotation_date" defaultValue="报价日期" />：</span></div>
                <input type="radio" name="dateArea" value="week" checked><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" /><input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" /><input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" /><input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate"/></div>
                <div class="dis-in-b input-and-tip" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate" /></div>
            	<button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            	<button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
            </div>
            </form>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_quotationheader" defaultValue="报价单头" /></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_lable_quotationitem" defaultValue="报价单行项目" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_lable_quotationitem" defaultValue="报价单行项目" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                    </ul>
                    <div id="sheet-project-one">
                    	<button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                        <main class="grid-container">
		                    <div class="grid-100">
		                        <table id="table-item"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two">
                        <main class="grid-container">
		                    <div class="grid-100">
		                        <table id="table-file"></table>
		                    </div>
		                </main>
                    </div>
                </div>
            </div>
        </div>

    </div>
<script type="text/javascript">
var headGrid;
var itemGrid;
var fileGrid;
// var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleQuotationManageHeader"/>;
var cols_head = [{title:"<i18n:I18n key='i18n_quotation_number' defaultValue='报价单号' />",name:"quotationNumber",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_quotation_purchaseels' defaultValue='采购商ELS号' />",name:"elsAccount",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_purchaser' defaultValue='采购商' />",name:"companyShortName",align:"center",width:168},
                 {title:"<i18n:I18n key='i18n_quotation_saleels' defaultValue='供应商ELS号' />",name:"toElsAccount",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_enquiry_label_supplier' defaultValue='供应商' />",name:"toCompanyShortName",align:"center",width:168},
                 {title:"<i18n:I18n key='i18n_quotation_person' defaultValue='报价人' />",name:"quotationSubAccount",align:"center",width:98,hidden:true},
                 {title:"<i18n:I18n key='i18n_quotation_date' defaultValue='报价日期' />",name:"quotationDate",align:"center",width:168,renderer:function(val){return dateFormat(val,"yyyy-MM-dd")}},
                 {title:"<i18n:I18n key='i18n_fileManage_title_createUser' defaultValue='创建人' />",name:"createUser",align:"center",width:168,hidden:true},
                 {title:"<i18n:I18n key='i18n_common_title_createdate' defaultValue='创建时间' />",name:"createDate",align:"center",width:168,renderer:function(val){return dateFormat(val,"yyyy-MM-dd")},hidden:true},
                 {title:"<i18n:I18n key='i18n_label_logtime' defaultValue='时间戳' />",name:"logtime",align:"center",width:168,renderer:function(val){return dateFormat(val,"yyyy-MM-dd hh:mm:ss")}},
                 {title:"<i18n:I18n key='i18n_label_currency' defaultValue='货币' />",name:"currency",align:"center",width:168,hidden:true}];
// var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleQuotationManageItem"/>;
var cols_item = [{title:"<i18n:I18n key='i18n_quotation_number' defaultValue='报价单号' />",name:"quotationNumber",align:"center",width:98},
//                 {title:"<i18n:I18n key='i18n_quotation_supplynumber' defaultValue='供货编号' />",name:"supplyNumber",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_lable_materialnumber' defaultValue='物料编号' />",name:"materialNumber",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_label_materialdescribe' defaultValue='物料描述' />",name:"materialDesc",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_common_title_materialgroup' defaultValue='物料组' />",name:"materialGroup",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_quotation_purchaseels' defaultValue='采购商ELS号' />",name:"elsAccount",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_purchaser' defaultValue='采购商' />",name:"companyShortName",align:"center",width:168},
                 {title:"<i18n:I18n key='i18n_quotation_saleels' defaultValue='供应商ELS号' />",name:"toElsAccount",align:"center",width:98},
                 {title:"<i18n:I18n key='i18n_enquiry_label_supplier' defaultValue='供应商' />",name:"toCompanyShortName",align:"center",width:168}
                 ];
var cols_file = [
                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
                  	if (val == elsAccount) {
                 		return "<i18n:I18n key="i18n_common_purchase" defaultValue="采购方" />";
                 	} else {
                 		return "<i18n:I18n key="i18n_common_sale" defaultValue="销售方" />";
                 	} 
                 }},
                 { title:'<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" />', name:'filePath', width: 80, align: 'center',renderer:function(val){
                	 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/downloadServlet?filePath="+ val +"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
                 }},
                 { title:'<i18n:I18n key="i18n_common_saleels" defaultValue="销售方ELS号" />', name:'toElsAccount', width: 150, align: 'center'},
                 { title:'<i18n:I18n key="i18n_common_purchaseels" defaultValue="采购方ELS号" />', name:'elsAccount' ,width:150, align:'center'},
                 { title:'<i18n:I18n key="i18n_quotation_number" defaultValue="报价单号" />', name:'quotationNumber' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_label_filetype" defaultValue="文件类型" />', name:'orderItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return '<i18n:I18n key="i18n_lable_quotationheadfile" defaultValue="报价单头文件" />';
	                	} else{
	                		return '<i18n:I18n key="i18n_lable_quotationitemfile" defaultValue="报价单项文件" />';
	                	}
	                }},
                 { title:'<i18n:I18n key="i18n_quotation_itemnumber" defaultValue="行项目编号" />', name:'orderItemNumber' ,width:150, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_label_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态" />', name:'fileStatus' ,width:150, align:'center',renderer:function(val){
                 	if (val == "0") {
                		return "<i18n:I18n key="i18n_label_notSent" defaultValue="未发送" />";
                	} else {
                		return "<i18n:I18n key="i18n_label_sent" defaultValue="已发送" />";
                	} 
                }}];
var $sob;
var chatFromUrlFlag;
var peopleList=[];
var toElsAccount;
$().ready(function(){
	init();
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10));
	});
	$("#queryBtn").click(function(){
		query();
	});
	$("#addBtn").click(function(){
		addQuotation();
	});
	$("#modifyBtn").click(function(){
		modifyQuotation();
	});
});
function modifyQuotation() {
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	if (headGrid.selectedRows().length==0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var quotationNumber = headGrid.selectedRows()[0].quotationNumber;
	var toElsAccount = headGrid.selectedRows()[0].toElsAccount;
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'PurchaseOrderUpdate',
        'windowTitle':'<i18n:I18n key="i18n_quotation_check" defaultValue="查看报价单" />',
        'iframSrc':'<%=basePath%>quotation/purchase/editPurchaseQuotation.jsp?quotationNumber=' + quotationNumber + "&toElsAccount=" + toElsAccount,
        windowMinWidth: 960,
        windowMinHeight: 700,
        windowStatus: 'maximized',
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function getDate(dates){
	var dd = new Date();
	dd.setDate(dd.getDate()+dates);
	return dd.format("yyyy-MM-dd");
}
function init(){
	$("#sheet-project").tabs();
	changeDateArea();
	$("[name=dateArea]").click(changeDateArea);
	var frm = $("#queryForm");
	headGrid = $('#table-head').mmGrid({
        cols: cols_head,
        url : frm[0].action,
        params: frm.serializeJSON(),
        method:  frm[0].method,
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:"200px",
        checkCol:true,
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
	// 加载明细项
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex){
    	loadItem();
    	loadFormFile();
    });
	itemGrid = $('#table-item').mmGrid({
        cols: cols_item,
        items:[]
	});
	fileGrid = $('#table-file').mmGrid({
        cols: cols_file,
        items:[]
	});
}
function changeDateArea() {
	var dateArea = $("[name=dateArea]:checked").val();
	if (dateArea == "define") {
		$("#startOrderDate").val("");
		$("#endOrderDate").val("");
		$("#startOrderDate").parent().show();
		$("#endOrderDate").parent().show();
	} else {
		$("#startOrderDate").parent().hide();
		$("#endOrderDate").parent().hide();
		$("#endOrderDate").val(new Date().format("yyyy-MM-dd"));
		var startOrderDate = "";
		if (dateArea == "week") {
			startOrderDate = getDate(-7);
		} else if (dateArea == "month") {
			startOrderDate = getDate(-30);
		} else if (dateArea == "threeMonth") {
			startOrderDate = getDate(-90);
		}
		$("#startOrderDate").val(startOrderDate);
	}
}
function loadFormFile() {
	if (headGrid.selectedRows().length==0) {
		if (fileGrid) {
			fileGrid.load([]);
		}
		if (itemGrid) {
			itemGrid.load([]);
		}
		return;
	}
	var param={"elsAccount":elsAccount,"toElsAccount":headGrid.selectedRows()[0].toElsAccount,"quotationNumber":headGrid.selectedRows()[0].quotationNumber}
	var url = "<%=basePath%>rest/PurchaseQuotationService/findAllFormFile";
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(param),
		success : function(data) {
			fileGrid.load(data);
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function loadItem() {
	if (headGrid.selectedRows().length==0) {
		if (fileGrid) {
			fileGrid.load([]);
		}
		if (itemGrid) {
			itemGrid.load([]);
		}
		return;
	}
	var param={"elsAccount":elsAccount,"toElsAccount":headGrid.selectedRows()[0].toElsAccount,"quotationNumber":headGrid.selectedRows()[0].quotationNumber}
	var url = "<%=basePath%>rest/PurchaseQuotationService/findMaterialItem";
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		contentType : "application/json",
		data:JSON.stringify(param),
		success : function(data) {
			itemGrid.load(data.rows);
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function query() {
	var frm = $("#queryForm");
	if (fileGrid) {
		fileGrid.load([]);
	}
	if (itemGrid) {
		itemGrid.load([]);
	}
	headGrid.opts.params = frm.serializeJSON();
	headGrid.load({});
}
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleQuotationManageHeader" + "&window=iframeApp_saleQuotationManage",
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':480,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});
$("#itemColumnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleQuotationManageItem" + "&window=iframeApp_saleQuotationManage",
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