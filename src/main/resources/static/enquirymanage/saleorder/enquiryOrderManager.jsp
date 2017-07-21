<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<base:supplierAuth elsAccount="${param['toElsAccount'] }" authCode="enquiry" toElsAccount="${elsAccount }"></base:supplierAuth>
<body>
	<div class="pos-relative public-wrap ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/">
            <input type="hidden" id="elsAccount"    name="elsAccount"/>
            <input type="hidden" id="elsSubAccount" name="elsSubAccount"/>			
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_enquiry_label_enquirynumber"  defaultValue="询价单号" />：</span><input id="purchaseEnquiryNumber" name="purchaseEnquiryNumber" type="text" />
				</div>
				<div class="dis-in-b input-and-tip">&nbsp;&nbsp;
					<span><i18n:I18n key="i18n_enquiry_label_enquirydate"    defaultValue="询价日期" />：</span><input  type="text"  id="loginTimeBegin" name="loginTimeBegin" class="Wdate" onfocus="WdatePicker()" />
					<span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" />&nbsp;</span><input  type="text" id="loginTimeEnd" name="loginTimeEnd" class="Wdate" onfocus="WdatePicker()" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_purchaser" defaultValue="采购商"/>：</span><input id="toElsAccount" name="toElsAccount" type="text" />
				</div>
				<div class="dis-in-b input-and-tip"><i18n:I18n key="i18n_enquiry_label_enquirystatus" defaultValue="询价单状态" />：
						<select class="" id="orderStatus" name="orderStatus">
							<option value=""> <i18n:I18n key="i18n_common_select_all"                           defaultValue="全部"   /></option>
							<option value="0"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create"         defaultValue="新建"   /></option>
							<option value="1"><i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed"   defaultValue="报价中" /></option>
							<option value="4"><i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote"     defaultValue="重报价" /></option>
							<option value="3"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option>	
							<option value="5"><i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing"    defaultValue="已定价" /></option>	
							<option value="6"><i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected"       defaultValue="已拒绝" /></option>
							<option value="7"><i18n:I18n key="i18n_enquiry_select_enquirystatus_finished"       defaultValue="已结束" /></option>	
							<option value="8"><i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice"    defaultValue="已报价" /></option>					
						</select>
				</div>				
				<div class="dis-in-b input-and-tip">
				    &nbsp;&nbsp;
					<button class="button-wrap" id="seachBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>&nbsp;&nbsp;
<%-- 					<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退  出" /></button> --%>
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
	<script type="text/javascript">
	var headGrid    = null ;
	var hadSelected = []   ;
	
	// 渲染   @author update/jiangzhidong 20160523  begin
	//渲染订单状态
	var rendererOrderStatus = function(val){
        	if(val==0){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />';
        	}else if(val==1){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed" defaultValue="报价中" />';
        	}else if(val==4){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价" />';
        	}else if(val==3){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
        	}else if(val==5){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价" />';
        	}else if(val==6){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝" />';
        	}else if(val==7){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束" />';
        	}else if(val==8){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价" />';
        	}else if(val==10){
        		return '已作废';
        	}
	}
	//询价单类型
	var rendererOrderType = function(val){
		if(val==0){
    		return '<i18n:I18n key="i18n_enquiry_select_enquirytype_market" defaultValue="行情询价" />';
    	}else if(val==1){
    		return '<i18n:I18n key="i18n_enquiry_select_enquirytype_material" defaultValue="物料询价" />';
    	}else if(val==2){
    		return '<i18n:I18n key="i18n_enquiry_select_enquirytype_texture" defaultValue="材质询价" />';
    	}
	}
	//中标状态
	var rendererSelectStatus = function(val){
		if(val==0){ return '<i18n:I18n key="i18n_enquiry_select_isfree" defaultValue="竞标中"/>'; }
        else if(val==1){ return '<i18n:I18n key="i18n_enquiry_select_bid"    defaultValue="已中标"/>'; }
        else if(val==2){ return '<i18n:I18n key="i18n_enquiry_select_nobid"  defaultValue="未中标"/>'; }
	}
	//询价开始日期
	var rendererBeginDate = function(val){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][deliveryDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50}})' type='text' style='display:none' value='"+val+"'/>";
	}
	//询价结束日期
	var rendererEndDate = function(val){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][deliveryDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50}})' type='text' style='display:none' value='"+val+"'/>";
	}
	//询价结束日期
	var rendererPurchaseEnquiryNumber = function(val){
		return '<span class="reportMoney" style="font-family:宋体; color:blue; "><i18n:I18n key="i18n_enquiry_quote" defaultValue="报价" /></span>';
	}
	// 渲染   @author update/jiangzhidong 20160523  end
	
	$(document).ready(function(){
		var toElsAccount          = GetQueryString("toElsAccount")  ;
		var elsSubAccount         = GetQueryString("elsSubAccount") ;
		var purchaseEnquiryNumber = null     ;
		$('button').button()                 ;
		$("#toElsAccount").val(toElsAccount) ;
		$("#elsAccount").val(elsAccount)     ;
		
		var cols = [{ title:'审批策略', name:'stretegyCode' ,hidden:true, width:60, align:'center'},
                    { title:'审批过程', name:'flowCode'     ,hidden:true, width:60, align:'center'},
                    { title:'审批状态', name:'auditStatus'  ,hidden:true, width:60, align:'center'},
	            	{ title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="采购负责人" />'       , name:'FBK4' ,hidden:true,     width:60,  align:'center'},
					{ title:'<i18n:I18n key="i18n_enquiry_label_sales_principal" defaultValue="销售负责人" />' , name:'FBK5' ,hidden:true,     width:60,  align:'center'},
					{ title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />'             , name:'purchaseEnquiryNumber', width:50,  align:'center', renderer: rendererPurchaseEnquiryNumber},
					{ title:'<i18n:I18n key="i18n_label_additionCost_toElsAccount" defaultValue="采购商" /> '   , name:'toElsAccount',          width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_account_title_companyAbbreviation" defaultValue="公司简称" />' , name:'toCompanyShortName' ,   width:120, align:'center'},
					{ title:'<i18n:I18n key="i18n_enquiry_title_enquirynumber" defaultValue="询价单号" />'     , name:'purchaseEnquiryNumber' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_enquiry_title_describe"      defaultValue="描述"/>'          , name:'enquiryDesc'           ,width:148, align:'center'},
					{ title:'<i18n:I18n key="i18n_enquiry_title_enquirytype"   defaultValue="询价类型"/>'      , name:'orderType'             ,width:100, align:'center', renderer: rendererOrderType},
					{ title:'<i18n:I18n key="i18n_enquiry_title_enquirystatus" defaultValue="询价单状态"/>'    , name:'orderStatus'           ,width:100, align:'center', renderer: rendererOrderStatus},
					{ title:'<i18n:I18n key="i18n_enquiry_SelectStatus" defaultValue="中标状态"/>' , name:'selectStatus' ,width:100, align:'center' ,renderer: rendererSelectStatus, hidden:true,},
					{ title:'<i18n:I18n key="i18n_enquiry_title_enquirybegindate" defaultValue="询价开始日期"/>', name:'beginDate' ,width:100, align:'center',renderer: rendererBeginDate},
					{ title:'<i18n:I18n key="i18n_enquiry_title_enquiryenddate" defaultValue="询价结束日期"/>', name:'endDate' ,width:100, align:'center',renderer: rendererEndDate}];
		
		//var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="sale_enquiry_header"/>;
		var paramStr={"elsAccount":elsAccount,"toElsAccount":toElsAccount,"FBK5":elsSubAccount,"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val().trim(),"orderStatus":$("#orderStatus").val().trim(),"loginTimeBegin":$("#loginTimeBegin").val().trim(),"loginTimeEnd":$("#loginTimeEnd").val().trim()};
		
		$("#columnDefineBtn").click(function() {
			parent.elsDeskTop.defineWin({
				'iconSrc'        : 'icon/els-icon.png'       ,
				'windowsId'      : 'subAccountColumnSetting' ,
				'windowTitle'    : '<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
				 windowSubTitle  : ""   ,
	            'iframSrc'       : '<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=sale_enquiry_header" + "&window=iframeApp_sale_enquiry_header",
				 showAdv         : true ,
				 advArr          : ['icon/test-car.png','icon/test-car2.png'],
				 windowMinWidth  : 480  ,
				 windowMinHeight : 600  ,
				'windowWidth'    : 480  ,
				'windowHeight'   : 600  ,
				'parentPanel'    : ".currDesktop"
			});
		});
		
		//退出
// 		$("#exitBtn").click(function(){
// 			if (winId) {
// 				parent.elsDeskTop.closeCurWin(winId);
// 			} else {
// 				parent.elsDeskTop.closeCurWin('enquiryOrderManager');
// 			}		
// 		});
		
		headGrid= $('#saleEnquiryHeaderTable').mmGrid({
	    	 cols        : cols     ,
	         url         : "<%=basePath%>rest/SaleEnquiryService/querySaleEnquiryHeadByCondtion",
	         params      : paramStr ,       
	         method      : 'post'   ,
	         root        : "rows"   ,
	         loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	         noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据"/>',
	         indexCol    : true     ,
	         emoteSort   : true     ,
	         plugins     : 
	         [
	             $('#pg').mmPaginator({
	                   style           : 'plain'
	                 , totalCountName  : 'total'
	                 , page            : 1
	                 , pageParamName   : 'currentPage'
	                 , limitParamName  : 'pageSize'
	                 , limitLabel      : '<i18n:I18n key="i18n_common_mmgrid_limitlabel"      defaultValue="每页{0}条"/>'
	                 , totalCountLabel : '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	                 , limit           : null
	                 , limitList       : [10,20]
	             })
	         ]
	    });
		
		//已作废  @author add/jiangzhidong 20160523  begin
		headGrid.on('loadSuccess',function(e,data) {
		       $('#saleEnquiryHeaderTable').find("tr").each(function(){
		           var item = $(this).data("item");
		           if (item&&item.orderStatus == "10") {
		               $(this).css("background-color","rgba(213, 58, 58, 0.1)");
		           }
		       });
		});
		//已作废   @author add/jiangzhidong 20160523  end
		
 		headGrid.on('cellSelected', function (e, item, rowIndex, colIndex) {
 			if($(e.target).is('.reportMoney')) {
 				var stretegyCode      = item.stretegyCode ;
 				var flowCode          = item.flowCode     ;
 				var auditStatus       = item.auditStatus  ;
 				var orderStatus       = item.orderStatus  ;
 				
 				toElsAccount          = item.toElsAccount          ;
 				purchaseEnquiryNumber = item.purchaseEnquiryNumber ;
 				var toCompanyName     = null                       ;		
 				toCompanyName         = item.toCompanyShortName    ;
 				
 				if (!purchaseEnquiryNumber) {
 					alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单!"/>',2);
 					return;
 				}
 				//已作废不可操作
 				if (orderStatus==10) {
 					alert('<i18n:I18n key="test" defaultValue="不可操作，此单据已作废!"/>',2);
 					return;
 				}
 				//兼容ie 冒泡事件
 			    if (event && event.preventDefault) {
 			        event.preventDefault()  ;
 			        event.stopPropagation() ;
 			    } else {
 			        window.event.returnValue = false;
 			    }
 				//获取对方elsAccount i18n_enquiry_quotedmanage
 			    parent.elsDeskTop.defineWin({
 			        'iconSrc'        : 'icon/els-icon.png'   ,
 			        'windowsId'      : 'PurchaseOrderUpdate' ,
 			        'windowTitle'    : '<i18n:I18n key="i18n_enquiry_quotedmanage" defaultValue="询报价管理"/>',
 			        'windowSubTitle' : toCompanyName         ,
 			        'iframSrc'       : '<%=basePath%>enquirymanage/saleorder/quotedManage.jsp?toElsAccount=' + toElsAccount + "&purchaseEnquiryNumber="+purchaseEnquiryNumber,
 			         windowStatus    : 'maximized'           ,
 			         windowMinWidth  : 960                   ,
 			         windowMinHeight : 700                   ,
 			        'windowWidth'    : 960                   ,
 			        'windowHeight'   : 700                   ,
 			        'parentPanel'    : ".currDesktop"
 			    });
 			}
	    });
 		
		//点击查询 
		$("#seachBtn").click(function(){
			var purchaseEnquiryNumber = $("#purchaseEnquiryNumber").val().trim()     ;
			var loginTimeBegin        = $("#loginTimeBegin").val()                   ;
			var loginTimeEnd          = $("#loginTimeEnd").val()                     ;
			var toElsAccount          = $("#toElsAccount").val().trim()              ;
			var orderStatus           = $("#orderStatus").val()                      ;   
			var elsSubAccount		  = '<%=session.getAttribute("elsSubAccount")%>' ;
			var paramStr              = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"FBK5":elsSubAccount,"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val().trim(),"orderStatus":$("#orderStatus").val().trim(),"loginTimeBegin":$("#loginTimeBegin").val().trim(),"loginTimeEnd":$("#loginTimeEnd").val().trim()};
			headGrid.opts.params = paramStr ;
			headGrid.load({page:1}) ;
		});
	});
	</script>
</body>
</html>