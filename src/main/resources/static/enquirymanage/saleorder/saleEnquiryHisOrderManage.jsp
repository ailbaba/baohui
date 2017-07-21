<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/">
            <input type="hidden" id="elsAccount"    name="elsAccount"/>
            <input type="hidden" id="elsSubAccount" name="elsSubAccount"/>			
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_enquiry_title_enquirynumber" defaultValue="报价单号" />：</span><input id="purchaseEnquiryNumber" name="purchaseEnquiryNumber" type="text" />
				</div>
	 
				<div class="dis-in-b input-and-tip">
				    &nbsp;&nbsp;
					<button class="button-wrap" id="seachBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>&nbsp;&nbsp;
					<button class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退  出" /></button>
				</div>
			</div>
			</form>
		</div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
               <div class="grid-100"  id="saleEnquiryHeaderGrid">
				   <table id="saleEnquiryHeaderTable"></table>
				   <div id="pg" style="text-align: right;"></div>
               </div>
               </main>
            </div>
        </div>
	</div>
	<script>
	var headGrid    = null ;
	var hadSelected = [];
	$(document).ready(function()
	{
		var toElsAccount          = GetQueryString("toElsAccount");
		var purchaseEnquiryNumber = null;
		$('button').button();
		$("#toElsAccount").val(toElsAccount);
		$("#elsAccount").val(elsAccount);	
		//列
		var cols = [	{ title:'采购负责人', name:'FBK4'               ,hidden:true, width:60,  align:'center' },
						{ title:'销售负责人', name:'FBK5'               ,hidden:true, width:60,  align:'center' },
						{ title:'<i18n:I18n key="i18n_purchaser" defaultValue="采购商" />'    , name:'toCompanyShortName' ,hidden:true, width:60,  align:'center' },
						{ title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'purchaseEnquiryNumber'          , width:50,  align:'center' ,
			              renderer: function(val) { return '<span class="reportMoney" style="font-family:宋体; color:blue; "><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></span>';  }},
						{ title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="采购商名称" />', name:'toElsAccount'                   , width:100, align:'center' },
						{ title:'<i18n:I18n key="i18n_enquiry_title_enquirynumber" defaultValue="询价单号" />', name:'purchaseEnquiryNumber'          , width:100, align:'center' },
						{ title:'<i18n:I18n key="i18n_enquiry_title_describe" defaultValue="描述" />'      , name:'enquiryDesc'                    , width:148, align:'center' },
						{ title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />'    , name:'logtime'                        , width:100, align:'center' ,
						  renderer:function(val){	if (!val) {val = "";}  if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						  return "<span class='showText'>" + val + "</span>" + "<input name='logtime' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";}},							
					    { title : '<i18n:I18n key="i18n_label_orderType" defaultValue="订单类型"/>', name: 'orderType' ,width: 80,align: 'center',renderer 	: function (val) {	return ['<i18n:I18n key="i18n_enquiry_select_enquirytype_market" defaultValue="行情询价"/>', '<i18n:I18n key="i18n_enquiry_select_enquirytype_material" defaultValue="物料询价"/>',
				        '<i18n:I18n key="i18n_enquiry_select_enquirytype_texture" defaultValue="材质询价"/>'][parseInt(val)];	}},
					    { title : '<i18n:I18n key="i18n_enquiry_title_enquirystatus" defaultValue="询价单状态"/>'  , name: 'orderStatus'           ,width : 100,align : 'center',renderer: function (val) {
						return ['<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed" defaultValue="报价中"/>', "议价中", '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价"/>','<i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价"/>', "已选择"	][parseInt(val)]; }},
					    { title : '<i18n:I18n key="i18n_enquiry_SelectStatus" defaultValue="中标状态"/>'    , name: 'selectStatus'          ,width : 80,align : 'center',renderer 	: function (val) {return ['<i18n:I18n key="i18n_enquiry_select_isfree" defaultValue="竞标中"/>', '<i18n:I18n key="i18n_enquiry_select_bid" defaultValue="已中标"/>', '<i18n:I18n key="i18n_enquiry_select_nobid" defaultValue="未中标"/>'][parseInt(val)];	}}, 
					    { title : '<i18n:I18n key="i18n_enquiry_title_enquirybegindate" defaultValue="询价开始日期"/>', name: 'beginDate'        ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][beginDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";}},									    
    					{ title : '<i18n:I18n key="i18n_enquiry_title_enquiryenddate" defaultValue="询价结束日期"/>', name: 'endDate'          ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}  if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][endDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";}}
				   ];
		var paramStr =  {"elsAccount":elsAccount,"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val()};
		var frm      = $("#queryForm");

		headGrid= $('#saleEnquiryHeaderTable').mmGrid({
	    	 cols        : cols,
	         url         : "<%=basePath%>rest/SaleEnquiryServiceHis/querySaleEnquiryHeaderHisByCondtion",
	         params      : paramStr,       
	         method      : 'post',
	         root        : "rows",
	         loadingText : '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>' ,
	         noDataText  : '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>' ,
	         indexCol    : true,
	         remoteSort  : true,
	         plugins: [
	             $('#pg').mmPaginator({
	                 style: 'plain'
	                 , totalCountName: 'total'
	                 , page: 1
	                 , pageParamName: 'currentPage'
	                 , limitParamName: 'pageSize'
	                 , limitLabel: '<i18n:I18n defaultValue="每页{0}条" key="i18n_common_mmgrid_limitlabel"></i18n:I18n>'
	                 , totalCountLabel: '<i18n:I18n defaultValue="共<span>{0}</span>条记录" key="i18n_common_mmgrid_totalcountlabel"></i18n:I18n>'
	                 , limit:null
	                 , limitList: [10,20]
	             })
	         ]
	    }); 
 		headGrid.on('cellSelected', function (e, item, rowIndex, colIndex) {
 			if($(e.target).is('.reportMoney')) {
 				toElsAccount          = item.toElsAccount;
 				purchaseEnquiryNumber = item.purchaseEnquiryNumber;
 				logtime               = item.logtime;
 				var toCompanyName = null;		
 				toCompanyName = item.toCompanyShortName;
 				if (!purchaseEnquiryNumber) {
 					alert('<i18n:I18n defaultValue="请选择订单！" key="i18n_enquiry_pleaseSelectTheOrder"></i18n:I18n>');
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
 			    parent.elsDeskTop.defineWin({
 			        'iconSrc'        : 'icon/els-icon.png',
 			        'windowsId'      : 'PurchaseOrderUpdate',
 			        'windowTitle'    : '<i18n:I18n defaultValue="询报价管理" key="i18n_enquiry_quotedmanage"></i18n:I18n>',
 			        'windowSubTitle' :  toCompanyName,
 			        'iframSrc'       : '<%=basePath%>enquirymanage/saleorder/quotedHisManage.jsp?toElsAccount=' + toElsAccount + "&elsAccount=" + elsAccount + "&purchaseEnquiryNumber="+purchaseEnquiryNumber + "&logtime=" + logtime,
 			         windowStatus    : 'maximized',
 			         windowMinWidth  : 960,
 			         windowMinHeight : 700,
 			        'windowWidth'    : 960,
 			        'windowHeight'   : 700,
 			        'parentPanel'    : ".currDesktop"
 			    });
 			}
	    });
		//点击查询 
		$("#seachBtn").click(function(){
			var purchaseEnquiryNumber = $("#purchaseEnquiryNumber").val();
			var paramStr              = {"elsAccount":elsAccount,"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val()};
	 		headGrid.load(paramStr);
		});
	});
	</script>
</body>
</html>