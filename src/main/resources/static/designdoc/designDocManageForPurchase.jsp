<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative ">
<%--         <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
<!--                 <button id="addBtn" class="button-wrap">新建</button> -->
                <button  id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div> --%>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form style="margin:0;" id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/DesignDocService/queryDesignDocForPurchase">
            	<input type="hidden" id="elsAccount" name="elsAccount"/>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单号：</span><input name="designNumber" type="text"/></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单状态: </span>
                	<select name="orderStatus">
                		<option value="">全部</option>
                		<option value="1">采购分配供应商</option>
                		<option value="2">内部流程审核中</option>
                		<option value="3">供应商处理中</option>
                		<option value="4">已完结</option>
                		<option value="5">作废</option>
                	</select>
                </div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计师: </span><input type="text" name="designer"/></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">采购人员: </span><input type="text" name="purchaseInCharge"/></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">业务时间：</span></div>
                <input type="radio" name="dateArea" value="week" checked><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" /><input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" /><input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" /><input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startDeliveryDate" name="orderDateStart"/></div>
                <div class="dis-in-b input-and-tip" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endDeliveryDate" class="Wdate" onfocus="WdatePicker()" name="orderDateEnd" /></div>
            	<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
	            <button id="printBtn" class="button-wrap"><i18n:I18n key="i18n_button_print" defaultValue="打印" /></button>
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
var cols_item = [{title:"操作",name:"operate",align:"center",width:154,renderer:function(val,item,rowIndex){
                  return "<span style='color:blue;cursor:pointer' onclick=\"go('"+item.designNumber+"','"+item.purchaseInCharge+"','"+item.orderStatus+"');\">分配供应商</span>";
                 }},
                 {title:"设计单状态",name:"orderStatus",align:"center",width:154,renderer:function(val,item,rowIndex){
                	 var text = "";
                	 if (val==0) text = "设计师新建文档";
                	 else if(val==1) text = "采购分配供应商";
                	 else if(val==2) text = "内部流程审核中";
                	 else if(val==3) text = "供应商处理中";
                	 else if(val==4) text = "已完结";
                	 else if(val==5) text = "作废";
                	 if(text != "")
                		 return "<span style='color:blue;cursor:pointer' onclick=\"showHis('"+item.designNumber+"');\">"+text+"</span>";
                 }},
                 {title:"审核状态",name:"auditStatus",align:"center",width:154,renderer:function(val,item,rowIndex){
                	 var text = "";
                	 if (val==0) text = "审核通过";
                	 else if(val==1) text = "未开始审核";
                	 else if(val==2) text = "审核中";
                	 else if(val==3) text = "审核拒绝";
                	 if(text != "")
                		 return "<span style='color:blue;cursor:pointer' onclick=\"flow('"+item.designNumber+"','"+item.flowCode+"');\">"+text+"</span>";
                 }},
                 {title:"供应商响应状态",name:"supplierStatus",align:"center",width:100,renderer:function(val,item,rowIndex){
                	 if(val)
                		 return "<span style='color:blue;cursor:pointer' onclick=\"showSupplierList('"+item.designNumber+"','"+val+"');\">"+val+"</span>"
                 }},
                 {title:"设计单号",name:"designNumber",align:"center",width:100},
                 {title:"业务日期",name:"orderDate",align:"center",width:100,renderer:function(val){
                	 if (!val) { return ""; }
                	 return new Date(val).format("yyyy-MM-dd"); }
                 },
                 {title:"物料编号",name:"materialNumber",align:"center",width:100},
                 {title:"物料描述",name:"materialDesc",align:"center",width:120},
                 {title:"尺寸",name:"attribute1",align:"center",width:110},
                 {title:"材质属性",name:"attribute2",align:"center",width:180},
                 {title:"材质规格",name:"materialSpec",align:"center",width:110},
                 {title:"版本号",name:"revision",align:"center",width:110},
                 {title:"制版处理",name:"plateProcess",align:"center",width:120,renderer:function(val){
                	 if (val==0) return "新制版";
                	 else if(val==1) return "改版原版保留";
                	 else if(val==2) return "改版原版作废";
                	 else return "";}
                 },
                 {title:"改版内容",name:"changeContent",align:"center",width:120,renderer:function(val){
                	 if (val==0) return "图案文字";
                	 else if(val==1) return "材质工艺";
                	 else if(val==2) return "尺寸";
                	 else if(val==3) return "其他";
                	 else return "";}
                 },
                 {title:"是否打样",name:"makeSample",align:"center",width:110,renderer:function(val){
                	 if (val==0) return "打样";
                	 else if(val==1) return "不打样";
                	 else return "";}
                 },
                 {title:"制版数量",name:"plateQuantity",align:"center",width:120},
                 {title:"设计师",name:"designer",align:"center",width:98},
                 {title:"产品经理",name:"productManager",align:"center",width:98},
                 {title:"采购员",name:"purchaseInCharge",align:"center",width:98},
                 {title:"变更编号",name:"changeNumber",align:"center",width:98},
                 {title:"材质工艺代码",name:"materialTechCode",align:"center",width:98},
                 {title:"物料原始版次号",name:"materialInitRevision",align:"center",width:98}];
                 
function init() {
	//初始化控件
    changeDateArea();
    $("[name=dateArea]").click(changeDateArea);
	$("#queryBtn").click(function(){
		query();
	});
	$("#addBtn").click(function(){
		goCreateDesignDoc("");
	});
	$("#printBtn").click(function(){
		var datas = itemGrid.selectedRows();
		if(!datas.length)return alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
		datas.templateType = 'sjg';
		//查询表单图片文件
		parent.elsDeskTop.showLoading();
		for (var i =0;i< datas.length;i++) {
			var param = {"elsAccount":elsAccount,"designNumber":datas[i].designNumber};
			$.ajax({
				url :"<%=basePath%>rest/DesignDocService/getDesignDoc",
				dataType : "json",
				type :"post",
				async:false,
				contentType : "application/json",
				data : JSON.stringify(param),
				success : function(data) {
					datas[i].purchaseDesignFileList = [];
					for (var j =0;j<data.purchaseDesignFileList.length;j++) {
						if (data.purchaseDesignFileList[j]
								&&data.purchaseDesignFileList[j].fileType == "1"
						) {
							datas[i].purchaseDesignFileList.push(data.purchaseDesignFileList[j]);
						}
					}
					datas[i].supplier = [];
					for ( j =0;j<data.purchaseSupplierList.length;j++) {
						if(data.purchaseSupplierList[j])
						datas[i].supplier.push(data.purchaseSupplierList[j].companyShortName) ;
					}
					datas[i].supplier = datas[i].supplier.join();
				}
			});
		}
		 parent.elsDeskTop.defineWin({
			'iconSrc':'icon/els-icon.png',
			'windowsId':'ePrintTemplatesManager',
			'windowTitle':'<i18n:I18n key="i18n_windowtitle_orderprint" defaultValue="订单打印" />',
			'iframSrc':'<%=basePath%>ePrintTemplatesManager.jsp',
			'windowStatus': 'maximized',
			'windowMinWidth': 960,
			'windowMinHeight': 700,
			'windowWidth':960,
			'windowHeight':700,
			'parentPanel':".currDesktop",
			 data:datas
		});
		 parent.elsDeskTop.hideLoading();
	});
	var height=$(document).height()-300;
    //订单头列表
    var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	itemGrid = $('#table-head').mmGrid({
        cols: cols_item,
        url : frm[0].action,
        params: frm.serializeJSON(),
        method:  frm[0].method,
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
		$("#endDeliveryDate").val(new Date().format("yyyy-MM-dd"));
		var startOrderDate = "";
		if (dateArea == "week") {
			startOrderDate = getDate(-7);
		} else if (dateArea == "month") {
			startOrderDate = getDate(-30);
		} else if (dateArea == "threeMonth") {
			startOrderDate = getDate(-90);
		}
		$("#startDeliveryDate").val(startOrderDate);
	}
}
function flow(designNumber,flowCode){
    if (flowCode == "null" || flowCode == "" || flowCode == "00") {
		alert("<i18n:I18n key="i18n_delivery_nsssport" defaultValue="单据尚未开始审核" />",2);
	} else {
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'auditFlowList',
	        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
	        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=designDoc&businessId=' + designNumber,
	        'windowWidth':680,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
	}
}
function showHis(designNumber){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'viewDesignDocHis',
        'windowTitle':'<i18n:I18n key="ll" defaultValue="设计文档历史记录" />',
        'iframSrc':'<%=basePath%>designdoc/viewDesignDocHis.jsp?designNumber='+designNumber,
        'windowWidth':730,
        'windowHeight':450,
        'parentPanel':".currDesktop"
    });
}
function showSupplierList(designNumber,val){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'supplierList',
        'windowTitle':'<i18n:I18n key="ll" defaultValue="供应商处理状态" />',
        'iframSrc':'<%=basePath%>designdoc/supplierList.jsp?designNumber='+designNumber+'&supplierStatus='+val,
        'windowWidth':580,
        'windowHeight':400,
        'parentPanel':".currDesktop"
    });
}
function go(designNumber,purchaseInCharge,orderStatus){
	var purchaseInCharge = purchaseInCharge.split("_")[0];
	if(elsSubAccount == purchaseInCharge && orderStatus != 5)
		goAssignDesignDoc(designNumber);
	else
		goViewDesignDoc(designNumber);
/* 	var purchaseInCharge = purchaseInCharge.split("_")[0];
	if(elsSubAccount == purchaseInCharge && (orderStatus == '1' || orderStatus == '2'))
		goAssignDesignDoc(designNumber);
	else
		goViewDesignDoc(designNumber); */
}
function goViewDesignDoc(designNumber){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'viewDesignDoc',
        'windowTitle':'<i18n:I18n key="i18n_windowsssx" defaultValue="查看设计文档" />',
        'iframSrc':'<%=basePath%>designdoc/viewDesignDoc.jsp?designNumber='+designNumber,
        'windowStatus': 'maximized',
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function goAssignDesignDoc(designNumber){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'assignDesignDoc',
        'windowTitle':'<i18n:I18n key="i18n_windowsssx" defaultValue="分配供应商" />',
        'iframSrc':'<%=basePath%>designdoc/assignDesignDoc.jsp?designNumber='+designNumber,
        'windowStatus': 'maximized',
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}
function query() {
	var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#queryForm");
	itemGrid.opts.params = frm.serializeJSON();
	itemGrid.load({});
}
$().ready(function(){
	init();
});
</script>
</body>
</html>