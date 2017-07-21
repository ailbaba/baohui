<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap ">
	<form id="queryForm" onsubmit="return false;" method="POST">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
				<input type="hidden" id="elsAccount" name="elsAccount" />
				<input type="hidden" id="elsSubAccount" name="elsSubAccount" />
				<div class="common-box-line">
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS" />： </span>
						<input type="text" id="toElsAccount" name="toElsAccount" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_lable_suppliercompany" defaultValue="供应商公司名" />： </span>
						<input type="text" id="fullName" name="fullName" />
					</div>
<%-- 					<button id="downloadBtn" class="button-wrap"><i18n:I18n key="i18n_common_lable_exportasexcel" defaultValue="导出到EXCEL" /></button> --%>
<%-- 					<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button> --%>
				</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_lable_purchaseorderreport" defaultValue="供应商报表" /></span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100" id="purchaseOrderReportGrid">
					<table id="purchaseOrderReportTable"></table>
					<div id="pg" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>
		</form>
	</div>
	<script type="text/javascript">
	var selector = '<base:subAccount role='purchase' elsAccount='${elsAccount }' type='select' name='fbk4' id='fbk4' ></base:subAccount>';
	selector = selector.replace('id="fbk4">','id="fbk4"><option value="">全部</option>');
	var height=$(document).height()-212;
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
// 	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseOrderReport_mt"/>;
	
	   var cols = [ {title:'<i18n:I18n key="i18n_common_label_elsAccount" defaultValue="ELS帐号" />', name:'elsAccount', width: 120, align: 'center',hidden:true},
    {title:'<i18n:I18n key="i18n_materialRelation_title_purchaseName" defaultValue="采购方名称" />', name:'fbk2', width: 120, align: 'center',hidden:true},
    {title:'<i18n:I18n key="i18n_enquiry_label_toElsAccount" defaultValue="供应商Els帐号" />', name:'toElsAccount' ,width:120, align:'center' },
    {title:'<i18n:I18n key="i18n_enquiry_label_supplierName" defaultValue="供应商名称" />', name:'companyShortName', width: 200, align: 'center'},
    {title:'<i18n:I18n key="i18n_enquiry_label_ErpSupplierCode" defaultValue="ERP供应商编码" />', name:'vender', width: 120, align: 'center'},
    {title:'<i18n:I18n key="i18n_common_label_ErpSystem" defaultValue="地址" />', name:'address', width: 150, align: 'center'},
    {title:'<i18n:I18n key="test" defaultValue="联系方式" />', name:'telephone1', width: 150, align: 'center'},
    { title:'<i18n:I18n key="i18n_common_title_Accesstype" defaultValue="国家" />', name:'countryCode' ,width:70, align:'center'},
    { title:'<i18n:I18n key="i18n_lable_deliverystatus" defaultValue="省份" />', name:'province' ,width:60, align:'center'},
    { title:'<i18n:I18n key="i18n_common_auditstatus" defaultValue="城市" />', name:'city' ,width:80, align:'center'},
    {title:'<i18n:I18n key="test" defaultValue="联络人" />', name:'fbk2', width: 150, align: 'center'},
//     {title:'<i18n:I18n key="test" defaultValue="冻结状态" />', name:'frozenStatus', width: 150, align: 'center'},
//     {title:'<i18n:I18n key="test" defaultValue="一级类型" />', name:'firstType', width: 120, align: 'center'},
//     {title:'<i18n:I18n key="test" defaultValue="分类一" />', name:'fbk11', width: 120, align: 'center',renderer:class1initValue},
//     {title:'<i18n:I18n key="test" defaultValue="分类二" />', name:'fbk12', width: 120, align: 'center',renderer:class2initValue},
//     {title:'<i18n:I18n key="test" defaultValue="分类三" />', name:'fbk13', width: 120, align: 'center',renderer:class3initValue},
//     {title:'<i18n:I18n key="test" defaultValue="分类四" />', name:'fbk14', width: 120, align: 'center',renderer:class4initValue},
//     {title:'<i18n:I18n key="test" defaultValue="分类五" />', name:'fbk15', width: 120, align: 'center',renderer:class5initValue},
//     {title:'<i18n:I18n key="test" defaultValue="创建人" />', name:'', width: 150, align: 'center'},
//     {title:'<i18n:I18n key="test" defaultValue="负责人" />', name:'fbk16', width: 150, align: 'center'},
//     {title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />', name:'logtime' ,width:150, align:'center', renderer:formatDateTime},
  ];   
    $("#fbk4Selector").html(selector);
// 	   $("#fbk4").find("option").each(function(){
// 	     	$(this).attr("value",$(this).text().split("_")[0]);
// 	     }); 
//	     $("#fbk4").val(elsSubAccount + "_" + username);
	     $("#fbk4").attr("placeholder",'<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />');
	     $("#fbk4").SumoSelect({optAfter:'#div-fbk4',optCancel:'#div-fbk4 .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	 	 $(".SlectBox").each(function(){
	 		$(this).css({ "padding-top": "0",
	 		              "padding-bottom": "0",
	 		              "line-height": "20px",
	 		              "height": "21px",
	 		              "font-size": "12px",
	 		              "max-width": "150px",
	 		              "border-radius": "2px"
	 		              });
	 	});
	function installTable(){
		debugger;
	 	var fbk4Param = $("#fbk4").val();
	 	$("#fbk4Param").val(fbk4Param);
		$('#purchaseOrderReportGrid').html('<table id="purchaseOrderReportTable"></table><div id="pg" style="text-align: right;"></div>');
		//本地示例
	     var headGrid= $('#purchaseOrderReportTable').mmGrid({
	    	 cols: cols,
	    	 url: '<%=basePath%>rest/SupplierMainDataService/querySupplierMainDataReport',
	         params:$("#queryForm").serializeJSON(),
	         method:'post',
	         root:"rows",
	         loadingText: '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>',
	 		noDataText: '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>',
	         height:height,
	         remoteSort:true,
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
	}
	
	installTable();
	
	$("#queryBtn").click(function(){
		installTable();
	});
	
	$("#columnDefineBtn").click(function(){
		 $("#columnDefineBtn").click(function(){
		     parent.elsDeskTop.defineWin({
		    	    'iconSrc':'icon/els-icon.png',
		    	    'windowsId':'subAccountColumnSetting',
		    	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		    	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseOrderReport_mt" + "&window=iframeApp_purchaseOrderReport_mt",
		    	    windowMinWidth  : 480,
		    	    windowMinHeight : 600,
		    	    'windowWidth'   : 480,
		    	    'windowHeight'  : 600,
		    	    'parentPanel'   :".currDesktop"
		     });
		 });
	});
	
	function renderPurchaseType(val,item) {
		if(val == '0')
			return "<i18n:I18n key='i18n_common_select_procurementtype_standard' defaultValue='标准' />";
		else if(val == '1')
			return "<i18n:I18n key='i18n_common_select_procurementtype_restrict' defaultValue='限制' />";
		else if(val == '2')
			return "<i18n:I18n key='i18n_common_select_procurementtype_consignment' defaultValue='寄售' />";
		else if(val == '3')
			return "<i18n:I18n key='i18n_common_select_procurementtype_subcontract' defaultValue='分包' />";
		else if(val == '4')
			return "<i18n:I18n key='i18n_common_select_procurementtype_anunknowncommodity' defaultValue='未知的商品' />";
		else if(val == '5')
			return "<i18n:I18n key='i18n_common_select_procurementtype_thirdparty' defaultValue='第三方' />";
		else if(val == '6')
			return "<i18n:I18n key='i18n_common_select_procurementtype_text' defaultValue='文本' />";
		else if(val == '7')
			return "<i18n:I18n key='i18n_common_select_procurementtype_stocktransfer' defaultValue='库存转储' />";
		else if(val == '8')
			return "<i18n:I18n key='i18n_common_select_procurementtype_commoditytype' defaultValue='商品类目' />";
		else if(val == '9')
			return "<i18n:I18n key='i18n_common_select_procurementtype_service' defaultValue='服务' />";
		else
			return "";	
	}
	
	$("#downloadBtn").click(function(){
		var data = $("#queryForm").serializeJSON();
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/PurchaseOrderService/order/exportAsExcel",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + data.message;
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	});
	
	 // 渲染   @author jiangzhidong 20160120  begin
	//只允许数字输入框
	var initInputNumber = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var initInputAny = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var enquiryHandle2 = function(val,item,index){
		if(!val) { val = '';}
		return '记录'+index;
	};
	//时间
	var formatDateTime = function (val,item,index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
		return val;
	};
	//单据状态
	var initStandardStatus = function (val,item,index){
		//0:未发送 1:已发送2：已撤回3：已作废 4:已回复  5:部分评分6：全部评分
		if (val == "0") {
			return '<i18n:I18n key="i18n_label_notSent" defaultValue="未发送" />';
		}else if (val == "1"){
			return '<i18n:I18n key="i18n_label_Sent" defaultValue="已发送" />';
		}else if (val == "2"){
			return '<i18n:I18n key="test" defaultValue="已撤回" />';
		}
		else if (val == "3"){
			return '<i18n:I18n key="test" defaultValue="已作废" />';
		}
		else if (val == "4"){
			return '<i18n:I18n key="test" defaultValue="已回复" />';
		}
		else if (val == "5"){
			return '<i18n:I18n key="test" defaultValue="部分评分" />';
		}
		else if (val == "6"){
			return '<i18n:I18n key="test" defaultValue="全部评分" />';
		}
	};
	//供应商分类   0-供应商  1-潜在供应商  2-陌生供应商  3-失效供应商
	var initFirstType = function (val,item,index){
		if (val == "0") return '<i18n:I18n key="test" defaultValue="供应商" />' ;
		else if (val == "1") return '<i18n:I18n key="test" defaultValue="潜在供应商" />' ; 
		else if (val == "2") return '<i18n:I18n key="test" defaultValue="陌生供应商" />' ;
		else if (val == "3") return '<i18n:I18n key="test" defaultValue="失效供应商" />' ;
	};
	// 冻结状态
	var initFrozenStatus = function (val,item,index){
		if (val == "" || val == null) return '<i18n:I18n key="" defaultValue="正常" />' ;
	}
	//准入类型  1:新增准入 2:变更准入 3:公开招投标准入
	var initStandardType = function (val,item,index){
		     if (val == "1") return '<i18n:I18n defaultValue='新增准入' key='test'/>'   ;
		else if (val == "2") return '<i18n:I18n defaultValue='变更准入' key='test'/>'     ;
		else if (val == "3") return '<i18n:I18n defaultValue='公开招标准入' key='i18n_common_title_Opentenderaccess'/>' ;
		
	};
	//审批状态
	var initAuditStatus = function (val,item,index){
		//0:审批通过  1:未审批  2:审批中  3:审批拒绝
		if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" />'
		else if (val == "1") return '<i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" />'
		else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
		else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" />';
	};
	//准入单号
	var initStandardNumber = function (val,item,index){
		if (!val) {val = "";}
		return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
</script>
</body>
</html>