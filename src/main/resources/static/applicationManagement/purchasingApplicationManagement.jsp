<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>
<div class="box-wrap pos-relative bg-common">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div class="dis-in-b input-and-tip">
				<button id="btnQueryEnquiryLocalDatabase" class="button-wrap"><i18n:I18n key="test" defaultValue="查询本地询价申请单" /></button>
			</div>
			<div class="dis-in-b input-and-tip">
				<button id="btnAddEnquiryItemBySAPDialogQuery" class="button-wrap"><i18n:I18n key="test" defaultValue="ERP获取询价申请单" /></button>
			</div>
			<div class="dis-in-b input-and-tip">
				<button id="createEnquiry" class="button-wrap"><i18n:I18n key="" defaultValue="创建询价单" /></button>
			</div>
			<div class="dis-in-b input-and-tip">
				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
			</div>
		</div>
    </div>
        
    <div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<div class="common-box-line">
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="" defaultValue="采购申请类型" />:</span>
				<div class="auto-orderClasses"></div>
			</div>
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="i18n_common_label_requisitionnumber" defaultValue="请求单号" />:</span>
				<input id="purchaseOrderNumber" class="easyui-textbox"  name="purchaseOrderNumber" type="text" style="width:200px;"/>
			</div>
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="开始日期" />:</span>
				<input id="beginDate" name="requestDate" class="Wdate" onfocus="WdatePicker()"  type="text" style="width:200px;"/>
			</div>
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="结束日期" />:</span>
				<input id="endDate" name="requestDate" class="Wdate" onfocus="WdatePicker()"  type="text" style="width:200px;"/>
			</div>
			<!-- 
			<div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_materialnumber" defaultValue="物料编码" />:</span>
			<input id="materialNumber" class="easyui-textbox" name="materialNumber" type="text" style="width:200px;"/>
			</div> -->
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="i18n_common_label_purchasegroup" defaultValue="采购组" />:</span>
				<input  class="easyui-textbox" id="purchaseGroup_sap" name="purchaseGroup_sap" type="text" style="width:200px;"/>
			</div>
<!-- 			<div class="dis-in-b input-and-tip"> -->
<%-- 				<span><i18n:I18n key="i18n_common_label_purchaseorganization" defaultValue="采购组织" />:</span> --%>
<!-- 				<input  class="easyui-textbox" id="purchaseOrganize_sap" name="purchaseOrganize_sap" type="text" style="width:200px;"/> -->
<!-- 			</div> -->
			<!-- 
			<div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_factory" defaultValue="工厂" />:</span>
			<input id="factory_sap" name="factory_sap" type="text" class="easyui-textbox"  style="width:200px;"/>
			</div>
			<div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_trackingnumber" defaultValue="跟踪号" />:</span>
			<input id="trackNumber" name="trackNumber" class="easyui-textbox" type="text" style="width:200px;"/>
			</div> -->
		</div>
    </div>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
		<div class="common-box-line">
			<main class="bg-common p-6">
				<div class="grid-100" >
					<table id="sap-material-table"></table>
					<div id="pg" style="text-align: right;"></div>
				</div>
			 </main>
		</div>
	</div>
</div>

<script>


var editTable            ;
var elsAccount    = "<%=session.getAttribute("elsAccount") %>"    ;
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>" ;
var sapMaterialTable     ;
var selectPrincipalTable ;
var orderType     = 1    ;
var frameAppId    = "<%=request.getParameter("frameAppId") %>"    ;

$(document).ready(function(){
	//需要在通用字典中搜索，配置才有内容:type:n不只读，y只读,getDateUrl:接口地址，tableName:对应的表名，fieldName:页面需要显示的字段
	$('.auto-orderClasses').elsAutoLoad({
		type:'n',
		getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
		elsAccount:elsAccount||'',
		tableName:'purchase_enquiry_requisition',
		fieldName: 'orderClasses',
		antoClass:"auto-orderClasses"
    });
	/*
	if(frameAppId=="null"){
	    var div = document.getElementById('btnAddEnquiryItemBySAPDialogOK');
	    div.style.display = 'none';
	    init();
	}
	init();*/
    var endDate=new Date() ; 
    $("#endDate").val(endDate.format('yyyy-MM-dd')) ;
    var beginDate_milliseconds=endDate.getTime()-1000*60*60*24*10 ; 
    var beginDate=new Date(); 
    beginDate.setTime(beginDate_milliseconds) ; 
    $("#beginDate").val(beginDate.format('yyyy-MM-dd')) ;	

	//获取当前用户默认的采购组、采购组织
	$.ajax({
	    url         : "<%=basePath%>rest/ElsOrganizationService/querySubaccountOrganizationInfo",
	    type        : "post",
	    contentType : "application/json",
	    data        :  JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount}),
	    dataType    : "json",
	    success     :  function(data) {
	    	if(data.statusCode == "-100"){
			}else{
				var rows = data.rows;
				var purchaseGroup="";
				var purchaseOrganization="";
				for(var i = 0 ; i < rows.length ; i ++){
					var row = rows[i];
					var orgCategoryId = row.orgCategoryId;
					if(orgCategoryId == "purchaseOrganization"){//采购组织
						purchaseOrganization += ";"+row.orgId;
					}
					if(orgCategoryId == "purchaseGroup"){//采购组
						purchaseGroup += ";"+row.orgId;
					}
				}
				if(purchaseGroup.length > 0){
					$("#purchaseGroup_sap").val(purchaseGroup.substring(1,purchaseGroup.length));
				}
				if(purchaseOrganization.length > 0){
					$("#purchaseOrganize_sap").val(purchaseOrganization.substring(1,purchaseOrganization.length));
				}
			}
	    }
    });	
	
// 	var colsMaterial = [{title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="请求单号" />', name:'purchaseOrderNumber', width: 140, align: 'center'},
// 		                { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行项目号" />', name:'materialLineNumber' , width:140, align:'center'},
// 		                { title:'<i18n:I18n key="i18n_common_label_trackingnumber" defaultValue="追踪号" />', name:'trackNumber' , width:120, align:'center'},
// 		                { title:'<i18n:I18n key="i18n_common_title_requestdate" defaultValue="请求日期" />', name:'requestDate' ,width:100, align:'center' ,renderer:formatDate},
// 		                { title:'<i18n:I18n key="i18n_common_title_materialnumber" defaultValue="物料编码" />', name:'materialNumber' ,width:130, align:'center'},
// 		                { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述" />', name:'materialDesc' ,width:130, align:'center'},
// 		                { title:'<i18n:I18n key="i18n_common_title_quantityrequired" defaultValue="需求数量" />', name:'quantity' ,width:130, align:'center'},
// 		                { title:'<i18n:I18n key="i18n_common_title_unitofmeasurement" defaultValue="计量单位" />', name:'unitQuantity',width:150, align:'center'},
// 		                { title:'<i18n:I18n key="i18n_common_title_deliverydate" defaultValue="需求日期" />', name:'deliveryDate' ,width:100, align:'center' ,renderer:formatDate},
// 		                { title:'<i18n:I18n key="i18n_common_title_materialgroup" defaultValue="物料组" />', name:'materialGroup' ,width:100, align:'center',renderer:function(val,item){
// 		                	if(val)return val+ "_" + item.materialGroupDesc;
// 		                	return "";
// 		                }},
// 		                { title:'<i18n:I18n key="i18n_enquiry_title_purchasegroup" defaultValue="采购组" />', name:'purchaseGroup' ,width:100, align:'center',renderer:function(val,item){
// 		                	if(val)return val+ "_" + item.purchaseGroupDesc;
// 		                	return "";
// 		                }},
// 		                { title:'<i18n:I18n key="i18n_common_title_storagelocation" defaultValue="库存地点" />', name:'stockPoint' ,width:120, align:'center',renderer:function(val,item){
// 		                	if(val)return val+ "_" + item.stockPointDesc;
// 		                	return "";
// 		                }},
// 		                { title:'<i18n:I18n key="i18n_common_title_factory" defaultValue="工厂" />', name:'factory' ,width:100, align:'center',renderer:function(val,item){
// 		                	if(val)return val+ "_" + item.factoryDesc;
// 		                	return "";
// 		                }},
// 		                //{ title:'<i18n:I18n key="i18n_common_title_itemclasses" defaultValue="项目类别" />', name:'itemClasses' ,width:100, align:'center'}
// 					   ];	
	var colsMaterial=<base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseApplyManage"/>;
  	
	var paramStr = {"elsAccount"          : elsAccount ,
        			"elsSubAccount"       : "" ,
        			"purchaseOrderNumber" : "" ,
        			"beginDate"           : $("#beginDate").val() ,
        			"endDate"             : $("#endDate").val() ,
        			"readSap"             : "0",        			
                	"fbk1"                : "0",         	
        			"purchaseGroup"       : "" ,
        			"purchaseOrganize"    : "" };
	var tableHeight = $(document).height()-250,pageSizeArr=[];
	var baseSize =  parseInt(tableHeight/25)>10?(parseInt(tableHeight/25)%10>0?(parseInt(tableHeight/25) + (10-parseInt(tableHeight/25)%10)):parseInt(tableHeight/25)):parseInt(tableHeight/25);
	pageSizeArr[0]=baseSize;
	pageSizeArr[1]=baseSize * 2;
	sapMaterialTable= $('#sap-material-table').mmGrid({
		height: tableHeight,
   	 	cols        : colsMaterial     ,
        url         : "<%=basePath%>rest/PurchaseEnquiryItemService/findEnquiryMaterialLineBySAP",
        params      : paramStr ,       
        method      : 'post'   ,
        root        : "rows"   ,
        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据"/>',
	    indexCol    : true         ,
	    multiSelect : true         ,
	    checkCol    : true		 ,
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
	                  , limitList: pageSizeArr
	              })
	          ]
    });	
});	

function formatDate(val){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	     return val;
}
function init(){
}

//从sap获取物料信息弹出窗查询按钮单击事件
$("#btnAddEnquiryItemBySAPDialogQuery").click(function(){
	var purchaseOrderNumber = $("#purchaseOrderNumber").val()   ;
	var beginDate           = $("#beginDate").val()             ;
	var endDate             = $("#endDate").val()               ;	
	var fbk1                = "1"                               ;
  	var paramStr = {"elsAccount"          : elsAccount          ,
        			"elsSubAccount"       : elsSubAccount       ,
        			"purchaseOrderNumber" : purchaseOrderNumber ,
        			"beginDate"           : beginDate           ,
        			"endDate"             : endDate             ,
					"readSap"             : "0"                 ,        			        	
        			"fbk1"                : fbk1                ,         	
        			"purchaseGroup"       : $("#purchaseGroup_sap").val().trim(),
        			"purchaseOrganize"    : ""};
  	parent.elsDeskTop.showLoading();
	//发送至供应商
	$.ajax({
		url         : '<%=basePath%>rest/PurchaseEnquiryItemService/getEnquiryMaterialLineBySAP',
		type        : 'POST'                    ,
		contentType : "application/json"        ,
		data        :  JSON.stringify(paramStr) ,
		dataType    : "json"                    ,
		success     : function(data) {
			if(data != null && data.statusCode == "-100"){
				alert(data.message,2)  ;
			}else if(data != null && data.statusCode == "-200"){
				alert(data.message,3) ;
			}else{
				alert("操作成功！",1) ;
				sapMaterialTable.load(paramStr) ;
			}
		},error : function(data) {
			alert(data.message,3) ;
		},complete : function(data) {
			parent.elsDeskTop.hideLoading() ;
		}
	});
});

//从本地数据库获取物料信息弹出窗查询按钮单击事件
$("#btnQueryEnquiryLocalDatabase").click(function(){
	var purchaseOrderNumber = $("#purchaseOrderNumber").val() ;
	var beginDate           = $("#beginDate").val()           ;
	var endDate             = $("#endDate").val()             ;	
	var fbk1                = "0"                             ;
	var orderClasses = "";
	if ($("#orderClasses").val()!="") {
		orderClasses = $("#orderClasses").val().split("_")[0];
	}
  	var paramStr = {"elsAccount"          : elsAccount          ,
		        	"elsSubAccount"       : elsSubAccount       ,
		        	"purchaseOrderNumber" : purchaseOrderNumber ,
		        	"beginDate"           : beginDate           ,
		        	"endDate"             : endDate             ,
        			"readSap"             : "0"                 ,  
        			"orderClasses"        : orderClasses        ,
		        	"fbk1"                : fbk1                , 
		        	"purchaseGroup"       : $("#purchaseGroup_sap").val().trim(),
		        	"purchaseOrganize"    : ""};
  	sapMaterialTable.opts.params = paramStr;
  	sapMaterialTable.load({});
});

//从sap获取物料信息弹出窗确认按钮单击事件
$("#btnAddEnquiryItemBySAPDialogOK").click(function(){
	var rows = sapMaterialTable.selectedRows();
    if(rows.length == 0){
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_selectAtLeastOneRecord" defaultValue="至少选择一条数据！" />'});
		return;
	  }
/* 	parent.frames['iframeApp_'+frameAppId].callbackFun(rows);
    parent.elsDeskTop.closeCurWin('purchasingApplicationManagement'); */
});

//创建采购询价单
$("#createEnquiry").click(function(){
	var rows = sapMaterialTable.selectedRows();
    if(rows.length == 0){
		alert('<i18n:I18n key="i18n_common_alert_selectAtLeastOneRecord" defaultValue="至少选择一条数据！" />',2);
		return;
	}
    //创建询价单前检查是否已经生成询价单
    var purchaseOrderNumbers = "";
    for (var i in rows) {
    	purchaseOrderNumbers += rows[i].purchaseOrderNumber + "_" + rows[i].orderItemNumber + ",";
    }
    if (purchaseOrderNumbers != "") {
    	purchaseOrderNumbers = purchaseOrderNumbers.substring(0,purchaseOrderNumbers.length-1);
    }
    $.ajax({
	    url         : "<%=basePath%>rest/PurchaseEnquiryItemService/checkExists",
	    type        : "post",
	    contentType : "application/json",
	    data        :  JSON.stringify({"elsAccount":elsAccount,"purchaseOrderNumber":purchaseOrderNumbers}),
	    dataType    : "json",
	    success     :  function(data) {
	    	if (data.errMessage && data.errMessage != "") {
	    		parent.elsDeskTop.tip.init({type: 'confirm',message:data.errMessage+'已创建询价单，是否继续创建',closeEvent:function(){
	    				setTimeout(function(){
	    					doCreate(rows);
	    				},100);
	    			}
	    		});
	    	} else {
	    		doCreate(rows);
	    	}
	    },
	    error:function(data){
	    	doCreate(rows);
	    }
    });
    
});
function doCreate(rows) {
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
        'windowsId':'PurchaseEnquiryAdd',
        'windowTitle':'<i18n:I18n key="i18n_enquiry_windowtitle_purchaseenquirydetail" defaultValue="采购询价单明细查看" />',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>enquirymanage/purchase/addEnquiryMain.jsp',
        'showAdv': false,
        'windowStatus': 'maximized',
        'windowMinWidth': 960,
        'windowMinHeight': 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop",
        'data':rows
    });
}
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'subAccountColumnSetting',
        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseApplyManage" + "&window=iframeApp_purchasingApplicationManagement",
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
