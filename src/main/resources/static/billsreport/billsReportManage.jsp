<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">统计报表</span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one">单据类型</a></li>
                        <li><a href="#sheet-project-two">用户在线</a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container nest-table">
                        	<div class="box-wrap pos-relative bg-common">
					            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
					            <div class="common-box-line">
					                 <div id="div-billsType" class="dis-in-b input-and-tip">
					                    <span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="单据类型" />： </span>
					                    <input type="hidden" id="billsTypeParm" name="billsTypeParm"/>
					                    <select id="billsType" multiple="multiple">
					                		<option value="po">采购订单</option>
											<option value="so">销售订单</option>
											<option value="pmv">收货单</option>
											<option value="smv">发货单</option>
											<option value="pa">采购附加费用单</option>
											<option value="sa">销售附加费用单</option>
											<option value="pe">询价单</option>
											<option value="se">报价单</option>
					                	</select>
					                </div>
									<div class="dis-in-b input-and-tip"> 
										<span>单据日期:</span>
										<input type="text" id="billsStartDate" name="billsStartDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
									</div>	
					            	<div class="dis-in-b input-and-tip"> 
										<span><i18n:I18n defaultValue="到" key="i18n_common_label_to"/>:</span>
										<input type="text" id="billsEndDate" name="billsEndDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
									</div>
					            	<div class="dis-in-b input-and-tip"> 
					            	  <button id="queryBillsBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
									</div>
					            </div>
					        </div>
		                    <div class="box-wrap pos-relative bg-common" id="reCreate">
		                        <table id="billsTable"></table>
		                        <div id="billsPage" style="text-align: right;"></div>
		                    </div>
		                    
		                </main>
                    </div>
                    
                    <div id="sheet-project-two">
	                   <main class="grid-container nest-table">
                        	<%-- <div class="box-wrap pos-relative bg-common">
					            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
					            <div class="common-box-line">
						            <div class="dis-in-b input-and-tip"> 
										<span>单据类型:</span>
										<select>
											<option>采购订单</option>
											<option>销售订单</option>
											<option>收货入库单</option>
											<option>发货单</option>
											<option>附加费用单</option>
											<option>询价单</option>
											<option>报价单</option>
										</select>
									</div>	
									<div class="dis-in-b input-and-tip"> 
										<span>单据日期:</span>
										<input type="text" id="startDate" name="startDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
									</div>	
					            	<div class="dis-in-b input-and-tip"> 
										<span><i18n:I18n defaultValue="到" key="i18n_common_label_to"/>:</span>
										<input type="text" id="endDate" name="endDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
									</div>
					            	<div class="dis-in-b input-and-tip"> 
					            	  <button id="queryssBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
									</div>
					            </div>
					        </div> --%>
		                    <div class="box-wrap pos-relative bg-common" id="reCreate">
		                        <table id="onlineTable"></table>
		                        <div id="onlinePage" style="text-align: right;"></div>
		                    </div>
		                    
		                </main>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
<script>
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	
	
	var renderItemStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "新建";
		} else if("1"==val){
			return "已发送";
		} else if("2"==val){
			return "已收货";
		} else {
			return "已结束";
		}
	};
	var rendererBillsType = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("po"==val){
			return "采购订单";
		}else if("so"==val){
			return "销售订单";
		}else if("pmv"==val){
			return "收货单";
		}else if("smv"==val){
			return "发货单";
		}else if("pe"==val){
			return "询价单";
		}else if("se"==val){
			return "报价单";
		}else if("pa"==val){
			return "采购附加费用单";
		}else if("sa"==val){
			return "销售附加费用单";
		}else {
			return "其他订单";
		}
	};
	
	var rendererDelivered = function(val,item,rowIndex){
		return '<a  href="javascript:showDeliveredElsAccount('+item.elsAccount+',1,'+val+')" >'+val+'</a>';
	};
	
	var rendererReceived = function(val,item,rowIndex){
		return '<a  href="javascript:showReceivedElsAccount('+item.elsAccount+',1,'+val+')" >'+val+'</a>';
	};
	
	var rendererSubAccount = function(val,item,rowIndex){
		return '<a  href="javascript:showReceivedElsAccount('+item.elsAccount+',2,'+val+')" >'+val+'</a>';
	};
	
	var rendererOnlineAccount = function(val,item,rowIndex){
		return '<a  href="javascript:showOnlineAccount('+item.elsAccount+',3,'+val+')" >'+val+'</a>';
	};
	var rendererOnlineElsAccount = function(val,item,rowIndex){
		return '<a  href="javascript:showOnlineAccount('+item.elsAccount+',1,'+val+')" >'+val+'</a>';
	};
	
	//时间
	var formatDateTime = function (val,item,index){
		if (!val) {val = "";}
		return new Date().format("yyyy-MM-dd hh:mm:ss");
	};
	
	var billsCols = [
			{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
			{ title:"ELS名称", name:"companyName", width:200, align:"center"},
			{ title:"单据类型", name:"billsType", width:100, align:"center",renderer:rendererBillsType},
			{ title:"记录总数", name:"record", width:200, align:"center"},
			{ title:"发送数", name:"totalDeliveredQuantity", width:200, align:"center"},
			{ title:"已发送ELS数", name:"deliveredElsAccount", width:150, align:"center",renderer:rendererDelivered},
			{ title:"对方确认数", name:"totalReceivedQuantity", width:150, align:"center"},
			{ title:"已回复ELS数", name:"receivedElsAccount", width:150, align:"center",renderer:rendererReceived},
			{ title:"子账号数", name:"elsSubAccountQuantity", width:200, align:"center",renderer:rendererSubAccount},
		];
	
	var onlineCols = [
			{ title:"ELS号", name:"elsAccount", width:200, align:"center"},
			{ title:"ELS名称", name:"companyName", width:222, align:"center"},
			{ title:"总用户数", name:"totalSubAccount", width:150, align:"center"},
			{ title:"在线用户数", name:"onlineSubAccount", width:150, align:"center",renderer:rendererOnlineAccount},
			{ title:'<i18n:I18n key="i18n_js_partner" defaultValue="合作伙伴" />', name:"totalSupplier", width:150, align:"center",renderer:rendererOnlineElsAccount},
			{ title:"当前时间", name:"createDate", width:200, align:"center",renderer:formatDateTime},
		];
	
	var billsGrid = $("#billsTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/BillsReportService/findBills",
	    method:  "POST",
	    autoLoad : false,
	    cols : billsCols,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
        checkCol : true,
        indexCol : false,
	    plugins: [
	        $("#billsPage").mmPaginator({
	            style: "plain",
	            totalCountName: "total",
	            page: 1,
	            pageParamName: "currentPage",
	            limitParamName: "pageSize",
	            limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	            totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	            limit:null,
	            limitList: [10,20]
	        })
	    ]
	}); 

	 var onlineGrid = $("#onlineTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/BillsReportService/findOnline/"+elsAccount+"/"+elsSubAccount,
	    method:  "POST",
	    autoLoad : false,
	    cols : onlineCols,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
        checkCol : true,
        indexCol : false,
	    plugins: [
	        $("#onlinePage").mmPaginator({
	            style: "plain",
	            totalCountName: "total",
	            page: 1,
	            pageParamName: "currentPage",
	            limitParamName: "pageSize",
	            limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	            totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	            limit:null,
	            limitList: [10,20]
	        })
	    ]
	}); 
	
	
	$(document).ready(function(){
		init();
		$("#billsType").SumoSelect({optAfter:'#div-billsType',optCancel:'#div-billsType .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    $("#sheet-project").tabs();
	    queryBills();
	    onlineGrid.load(); 
	}
	
	function queryBills(){
		 var startDate = $("#billsStartDate").val();
		 var endDate = $("#billsEndDate").val();
		 var billsType = $("#billsType").val();
		 console.log(billsType);
		 var queryParam={"elsAccount":elsAccount,"startDate":startDate,"endDate":endDate,"billsTypeList":billsType};
		 $.extend(billsGrid.opts.params,queryParam);
		 billsGrid.load(); 
	}
	
	 $("#queryBillsBtn").click(function(){
		 queryBills();
	 });
	 
	 
	var showDeliveredElsAccount = function(elsAcct,flag,val){
		if("0"==val)return;
		var startDate = $("#billsStartDate").val();
		var endDate = $("#billsEndDate").val();
		var billsType = $("#billsType").val();
		var url = "${pageContext.request.contextPath}/billsreport/billsReportDetail.jsp?status=1&flag="+flag+"&elsAcct="+elsAcct+"&billsType="+billsType+"&startDate="+startDate+"&endDate="+endDate;
		 parent.elsDeskTop.defineWin({
			iconSrc:'icon/destop-icon/desktop2_icon_181.png',
			windowsId :"AccountInfo",
			windowTitle :"<i18n:I18n defaultValue='账户信息' key='i18n_account_title_accountInformation'/>",
		    windowSubTitle : "",
		    iframSrc : url,
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		}); 
	};
	
	var showReceivedElsAccount = function(elsAcct,flag,val){
		if("0"==val)return;
		var startDate = $("#billsStartDate").val();
		var endDate = $("#billsEndDate").val();
		var billsType = $("#billsType").val();
		var url = "${pageContext.request.contextPath}/billsreport/billsReportDetail.jsp?status=2&flag="+flag+"&elsAcct="+elsAcct+"&billsType="+billsType+"&startDate="+startDate+"&endDate="+endDate;
		 parent.elsDeskTop.defineWin({
			iconSrc:'icon/destop-icon/desktop2_icon_181.png',
			windowsId :"AccountInfo",
			windowTitle :"<i18n:I18n defaultValue='账户信息' key='i18n_account_title_accountInformation'/>",
		    windowSubTitle : "",
		    iframSrc : url,
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 600,
		    windowMinHeight : 500,
		    windowWidth :600,
		    windowHeight :500,
		    parentPanel : ".currDesktop"
		}); 
	};
	
	var showOnlineAccount = function(elsAcct,flag,val){
		if("0"==val)return;
		var url = "${pageContext.request.contextPath}/billsreport/billsReportDetail.jsp?status=3&flag="+flag+"&elsAcct="+elsAcct;;
		 parent.elsDeskTop.defineWin({
			iconSrc:'icon/destop-icon/desktop2_icon_181.png',
		    windowsId :"AccountInfo",
		    windowTitle :"<i18n:I18n defaultValue='账户信息' key='i18n_account_title_accountInformation'/>",
		    windowSubTitle : "",
		    iframSrc : url,
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		}); 
	};
	
	
</script>
</body>
</html>