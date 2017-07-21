<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<div class="pos-relative public-wrap">
<form id="queryForm" onsubmit="return false;" method="POST" action="">
	<input type="hidden" id="elsAccount"            name="elsAccount"            value="<%=request.getParameter("elsAccount")%>"/>
	<input type="hidden" id="toElsAccount"          name="toElsAccount"          value="<%=request.getParameter("toElsAccount")%>"/>
	<input type="hidden" id="elsSubAccount"         name="elsSubAccount"         value="<%=session.getAttribute("elsSubAccount")%>"/>
	<input type="hidden" id="purchaseEnquiryNumber" name="purchaseEnquiryNumber" value="<%=request.getParameter("purchaseEnquiryNumber")%>"/>
	<input type="hidden" id="logtime"               name="logtime"               value="<%=request.getParameter("logtime")%>"/>
    <div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common">条件查询</span>
		<div class="common-box-line"><button id="sendBtn" class="button-wrap">发送</button></div>
    </div>

               
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common">询价单头信息</span>
		<div class="common-box-line">
		   <main class="grid-container">
			  <div class="grid-100">  <table id="table-head"></table>  </div>
		   </main>
		</div>
	</div>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common">询价单项目</span>
		<div class="common-box-line">
			<div class="tab-wrap" id="sheet-project">
				<div id="sheet-project-one">
					<main class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
							<div id="pg1" style="text-align: right;"></div>
						</div>
					</main>
				</div>
			</div>
		</div>
	</div>

	<div class="saying-dialog">
		<div class="fl-left left-content pos-relative">
			<div class="dis-block pos-absolute option-bar pre-active next"></div>
		</div>
		<div class="fl-left right-content pos-relative none-active">
			<div class="saying-box-wrap">
				<iframe class="testIframe" frameborder="0" width="100%"></iframe>
			</div>
		</div>
		<div class="clear-both"></div>
	</div>
</form>	
</div>

<div class="fixed-dialog" id="setLadderPriceDialog" >
<div class="dialog-tip" style="width: 500px;height: 345px;margin-left: -315px;margin-top: -240px;">
	<div class="dialog-close-btn" id="btnsetLadderPriceDialogClose"></div>
	<div class="tip-head"> <img class="icon" src="../../icon/els.PNG" />
		<span class="dialogTitle" id="titleLadderPriceDialog"><i18n:I18n key="test" defaultValue="物料阶梯设置"/></span>
	</div>
	<div class="box-wrap pos-relative bg-common">
		<input type="hidden" id ="ladderPrice_purchaseOrderNumber"/>
		<input type="hidden" id ="ladderPrice_orderItemNumber"/>
		<input type="hidden" id ="ladderPrice_materialNumber"/>
		<input type="hidden" id ="ladderPrice_materialDesc"/>
		<input type="hidden" id ="materialLineJson"/>
		<input type="hidden" id ="materialLineJson_ladder"/>
		<input type="hidden" id ="materialRowIndex"/>
		<input type="hidden" id ="materialLineJson-File"/>
		<input type="hidden" id ="fileTableJson"/>
	</div>	        	   
	<div class="box-wrap pos-relative bg-common">
	<main class="bg-common p-6">
		<div class="grid-100" >
			<table id="add-ladder-price-table"></table>
		</div>
		<div class="mt-40 text-center" >
			<button id="btnAddLadderPriceOK" class="button-wrap ">确定</button>
			<button id="btnAddLadderPriceCancel" class="button-wrap tip-option-btn">取消</button>
		</div>
	</main>
	</div>
</div>
</div>

<div class="fixed-dialog" id="selectPrincipalDialog" >
<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	<div class="dialog-close-btn" id="btnSelectPrincipalDialogClose"></div>
	<div class="tip-head">
		<img class="icon" src="../../icon/els.PNG" /> <span class="dialogTitle" id="titleSelectPrincipalDialog">请选择</span>
	</div>
	<div class="box-wrap pos-relative bg-common">
	<main class="bg-common p-6">
		<div class="grid-100" > <table id="select-principal-table"></table>	</div>
		<div class="mt-40 text-center" style="margin-top: 14px;">
			<button id="btnSelectPrincipalOK" class="button-wrap ">确定</button>
			<button id="btnSelectPrincipalCancel" class="button-wrap tip-option-btn">取消</button>
		</div>
	</main>
	</div>
</div>
</div>

<div class="fixed-dialog" id="showCostDialog" >
<div class="dialog-tip" style="width: 800px;height: 345px;margin-left: -315px;margin-top: -240px;">
	<div class="dialog-close-btn" id="showCostDialogClose"></div>
	<div class="tip-head">
		<img class="icon" src="../../icon/els.PNG" />
		<span class="dialogTitle" id="titleshowCostDialog">成本结构信息</span>
	</div>
	<div class="">
		<div class="box-wrap pos-relative bg-common">
			<input type="hidden" id ="materialLineJson"/>
			<input type="hidden" id ="materialLineJson_ladder"/>
			<input type="hidden" id ="materialRowIndex"/>
			<input type="hidden" id ="materialLineJson-File"/>
		</div>      
		<div class="box-wrap pos-relative bg-common">
		<main class="bg-common p-6">
			<div class="grid-100" >
				<table id="showCostTable"></table>
			</div>
			<div class="mt-40 text-center" >
				  <button id="addCostOK" class="button-wrap ">确定</button>
				<button id="showCostClose" class="button-wrap tip-option-btn">取消</button>
			</div>
		</main>
		</div>
	</div>
</div>
</div>
<script>
	var 
	headGrid,
	itemGrid,
	currentPurchaseEnquiryNumber,
	fileUploader;
	var frm  = $("#queryForm");
	$(document).ready(function(){
		var addLadderPriceTable = null ;
	
		var cols = [{ title : '询价单号'    , name: 'purchaseEnquiryNumber' ,width: 150,align: 'center'}, 
					{ title : '订单类型'    , name: 'orderType'             ,width: 80,align: 'center',renderer 	: function (val) {	return ["行情询价", "物料询价", "材质询价"][parseInt(val)];	}},
					{ title : '询价单状态'  , name: 'orderStatus'           ,width : 100,align : 'center',renderer: function (val) {
						return ["新建", "报价中", "议价中", "审批中", "重报价","已定价", "已拒绝", "已结束", "已报价", "已选择"	][parseInt(val)]; }},
					{ title : '中标状态'    , name: 'selectStatus'          ,width : 80,align : 'center',renderer 	: function (val) {return ["竞标中", "已中标", "未中标"][parseInt(val)];	}}, 
					{ title : '询价开始日期', name: 'beginDate'        ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][beginDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					}},									    
					{ title : '询价结束日期', name: 'endDate'          ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}  if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][endDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					}}, 
					{ title : '备注'       , name: 'enquiryDesc'            ,width: 200, align : 'center'}
				   ];
		
		var cols_item =[{ title:'申请订单号', name:'purchaseRequestNumber'            ,hidden:true, width:60, align:'center'},
	                    { title:'行号',       name:'purchaseRequestLineProjectNumber' ,hidden:true, width:60, align:'center'},
	                    { title:'物料行编号', name:'materialLineNumber'               ,width: 60,  align:'center' },
	                    { title:'物料编码',   name:'materialNumber'                   ,width: 100, align:'center' },
						{ title:'物料描述',   name:'materialDesc'                     ,width: 180, align:'center' },
						{ title:'采购类型',   name:'purchaseType' ,width: 70 , align:'center', renderer: function(val){	 if(val==0){  return "外购";     }  
		                                                                                                            else if(val==1){  return "外协";     }
													                                                                else if(val==2){  return "寄售票员"; }
						}},
					    { title:'属性1',   name:'property1'                   ,width: 100, align:'center' },
						{ title:'属性2',   name:'property2'                   ,width: 100, align:'center' },
					    { title:'属性3',   name:'property3'                   ,width: 100, align:'center' },
						{ title:'属性4',   name:'property4'                   ,width: 100, align:'center' },
						{ title:'属性5',   name:'property5'                   ,width: 100, align:'center' },
						{ title:'最小订单量', name:'minOrderQuantity'         ,width: 100, align:'center' },
						{ title:'最小包装数', name:'minPackQuantity'          ,width: 100, align:'center' },												
						{ title:'采购周期',   name:'cycle'                    ,width: 100, align:'center' },																		
						{ title:'不足容差', name:'minTolerance'               ,width: 100, align:'center' },
						{ title:'超量容差', name:'maxTolerance'               ,width: 100, align:'center' },												
						{ title:'无限制',   name:'infinite'                   ,width: 100, align:'center' },
						{ title:'币别',     name:'currency'                   ,width: 100, align:'center' },												
						{ title:'询价单状态', name:'orderStatus'              ,width: 70 , align:'center',
							renderer: function(val){	 if(val==0){  return "新建";	 }else if(val==1){  return "报价中";   }else if(val==2){  return "议价中";   }
													else if(val==3){  return "审批中";   }else if(val==4){  return "重报价";   }else if(val==5){  return "已定价";   }
													else if(val==6){  return "已拒绝";   }else if(val==7){  return "已结束";   }else if(val==8){  return "已报价";   }	else if(val==9){  return "已选择";   }
						}},
						{ title:'需求日期',   name:'endDate'             ,width: 80 , align:'center'  ,
							renderer:function(val){  if (!val) {val = "";} if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
							    	                 return "<input name='purchaseOrderItemList[][deliveryDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
						}},								
						{ title:'需求数量',     name:'quantity'               ,width:60 , align:'center'},
						{ title:'计量单位',     name:'unitPrice'              ,width:60 , align:'center'},
						{ title:'计价度量单位', name:'unitMeasure'            ,width:60 , align:'center'},
						{ title:'计价单位',     name:'unitPrice'              ,width:60 , align:'center'},
				        { title:'设置阶梯',     name:'quoteMethod'            ,width:60 , align:'center' , renderer: ladderPriceDetail},
						{ title:'税率',         name:'taxesCode'              ,width:60 , align:'center'},
						{ title:'不含税价',     name:'price'                  ,width:100, align:'center'},		
						{ title:'含税价',       name:'priceIncludingVat'      ,width:100, align:'center'},		
            	        { title:'设置成本',     name:'showCost'               ,width:100, align:'center' ,renderer: showCostDetail },
						{ title : '价格有效期到', name: 'priceValidBeginDate'        ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='priceValidBeginDate' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
				    	}},									    
					    { title : '价格有效期到', name: 'priceValidEndDate'          ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}  if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='priceValidEndDate' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					    }}, 						
						{ title:'供应商备注',   name:'remark'                 ,width:200 , align:'center'}
					];		
		
		headGrid = $('#table-head').mmGrid({
			height      : 100  ,
			cols        : cols ,
			url         : "<%=basePath%>rest/PurchaseBargainServiceHis/queryPurchaseEnquiryHeaderHis",
			params      : frm.serializeJSON() ,
			method      : frm[0].method       ,
			root        : "rows"              ,
			loadingText : '正在载入' ,
			noDataText  : '暂无数据' ,
		});			

		itemGrid = $('#table-item').mmGrid({
			cols: cols_item,
			url : "<%=basePath%>rest/PurchaseBargainServiceHis/queryPurchaseEnquiryItemsHis",
			params: frm.serializeJSON(),
			method: frm[0].method,
			root:"rows",
			loadingText: '正在载入',
			noDataText: '暂无数据',
			plugins: [
            $('#pg1').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '每页{0}条'
                , totalCountLabel: '共<span>{0}</span>条记录'
                , limit:null
                , limitList: [10,20]
            })]
		});	

		/*-----------------------------  阶梯报价  begin ------------------------------------------------------*/
	    var colsLadderPrice = [{title : '时间截'    ,name : 'logtime'              ,hidden : true, width : 60 , align : 'center'}, 
						      {title : '物料行编号' ,name : 'materialLineNumber'   ,hidden : true, width : 60 , align : 'center'}, 
						      {title : '物料编码'   ,name : 'materialNumber'                     , width : 60 , align : 'center'}, 
						      {title : '物料描述'   ,name : 'materialDesc'                       , width : 100,	align : 'center'}, 
						      {title : '数量从'     ,name : 'beginQuantity'                      , width : 60 ,	align : 'center'}, 
						      {title : '数量到'     ,name : 'endQuantity'                        , width : 60 ,	align : 'center'}, 
						      {title : '价格'       ,name : 'price'                              , width : 120,	align : 'center' , 
							    renderer 	: function (val, item, index) {	 if (!val){	 val = '';	}
								return '<input class="nest-report" style="border:none;width:100px;background-color: rgba(0,0,0,0);box-shadow: none;border: none;" name="price" id="price_' + index + '" type="text" value="' + val + '"/>';}
							 }];
		var params = {"elsAccount":"",
				      "toElsAccount":"",
				      "purchaseEnquiryNumber":"",
				      "materialLineNumber":""};
		
		addLadderPriceTable = $('#add-ladder-price-table').mmGrid({
			cols        : colsLadderPrice,
			url         : "<%=basePath%>rest/PurchaseBargainServiceHis/queryPurchaseEnquiryLadderPriceHisList",
			height      : 180,
			params      : params,
			method      : 'post',
			root        : 'rows',
			loadingText : '正在载入',
			noDataText  : '暂无数据',
			multiSelect : false,
			checkCol    : false
		});			
		
		$('.nest-report').live('focus',function() {
			$(this).css({'background-color': 'rgba(255,255,255,0.8)'});
		});

		$('.nest-report').live('blur',function() {
			$(this).css({'background-color': 'rgba(0,0,0,0)'});
		});

		$("#btnsetLadderPriceDialogClose").click(function(){
			$("#setLadderPriceDialog").hide();
		});
		//取消按钮
		$("#btnAddLadderPriceCancel").click(function(){
			$("#setLadderPriceDialog").hide();
		});
		
		//查看阶梯报价信息
		function ladderPriceDetail(val,item,rowIndex){
			if( val == 0 ){	return "<span></span>";	}else if( val == 1 ){
				return '<span class="col-scan">设置</span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
			}
		}

	    //确定按钮
	    $("#btnAddLadderPriceOK").click(function(){
			$("#setLadderPriceDialog").hide();
		});

		$('.col-scan').live("click", function() {
			var scanCol = $(this).next();  
			var sanContentText = scanCol.text();
			var sanContent = sanContentText.split("@enquiry@"); 
			var rowIndex = sanContent[0];  //当前是多少行
			var materialLineJson = sanContent[0]; //当前物料行数据
			$("#materialRowIndex").val(rowIndex);
			$("#materialLineJson").val(materialLineJson);
			var sanobj = JSON.parse(materialLineJson);

			var materialNumber        = sanobj.materialNumber;
			var materialDesc          = sanobj.materialDesc;
			var materialLineNumber    = sanobj.materialLineNumber;
			var logtime               = sanobj.logtime;

			//取出并判断存放价格阶梯json是否为空
			var ladderPriceJson       = sanobj.ladderPriceJson;
			if(ladderPriceJson != null && ladderPriceJson != ""){ //已经加载过的
				addLadderPriceTable.load(ladderPriceJson);
			}else{//第一次加载该物料行阶梯报价信息
				var paramst = 
				{
					"elsAccount":elsAccount,
					"toElsAccount":$("#toElsAccount").val(),
					"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val(),
					"materialLineNumber":materialLineNumber,
					"logtime":logtime
				};
				addLadderPriceTable.load(paramst);
			}   
			$("#setLadderPriceDialog").show();
		});
		/*----------------------------------- 阶梯报价 end  ----------------------------*/
		
		/*-------------------------报价成本 begin---------------------------------------*/	
		var colsCostConstitute = [{	title: '物料编码',name: 'materialNumber',width: 60,	align: 'center'}, 
			                      {	title: '物料描述',name: 'materialDesc'  ,width: 100,align: 'center'}, 
			                      {	title: '成本名称',name: 'costItemName'  ,width: 60,	align: 'center'}, 
								  {	title: '成本金额',name: 'costItemAmount',width: 80,	align: 'center', renderer 	: function (val, item, index) {	if (!val) {	val = ''; }
                					return '<input class="nest-report" style="border:none;width:60px;background-color: rgba(0,0,0,0);box-shadow: none;border: none;" name="costItemAmount" id="costItemAmount_' + index + '" type="text" value="' + val + '"/>'; }}, 
								  {	title: '说明'    ,name: 'remark',width: 500,align: 'center',renderer: function (val, item, index) {if (!val) {	val = '';	}
									return '<input class="nest-report" style="border:none;width:450px;background-color: rgba(0,0,0,0);box-shadow: none;border: none;" name="remark" id="remark_' + index + '" type="text" value="' + val + '"/>';}}	
								 ];

		var costparams = { "elsAccount":"", "toElsAccount":"",  "purchaseEnquiryNumber":"",  "materialLineNumber":"", };

		showCostTable = $('#showCostTable').mmGrid({
			cols   : colsCostConstitute,
			url    : "<%=basePath%>rest/PurchaseBargainServiceHis/findPurchaseReceiveEnquiryCostConstituteHis",
			height : 180,
			params : costparams,
			method : 'post',
			root   : 'rows',
			loadingText : '正在载入',
			noDataText  : '暂无数据',
			multiSelect : false,
			checkCol    : false
		});
		//成本窗口关闭
		$("#showCostDialogClose").click(function(){	  $("#showCostDialog").hide();   });
		$("#addCostOK").click(function(){  $("#showCostDialog").hide();   });
		$("#showCostClose").click(function(){  $("#showCostDialog").hide();   });
		function showCostDetail(val,item,rowIndex){
			return '<span class="col-showCost">设置成本 </span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
		}
		$('.col-showCost').live("click", function() {
			var scanCol = $(this).next();  
			var sanContentText = scanCol.text();
			var sanContent = sanContentText.split("@enquiry@"); 
			var rowIndex = sanContent[1];  //当前是多少行
			var materialLineJson = sanContent[0]; //当前物料行数据
			$("#materialRowIndex").val(rowIndex);
			$("#materialLineJson").val(materialLineJson);
			var sanobj = JSON.parse(materialLineJson);
			//获取对应的成本结构json 
			var costJson = sanobj.costConstituteJson;
			var supplierEnquiryNumber = sanobj.supplierEnquiryNumber;
			var orderItemNumber = sanobj.orderItemNumber;
			var materialNumber = sanobj.materialNumber;
			//取出并判断存放价格阶梯json是否为空
			var purchaseEnquiryNumber = sanobj.purchaseOrderNumber;
			var materialLineNumber    = sanobj.materialLineNumber;
			var logtime               = sanobj.logtime;

			if(costJson!=null&&costJson!=""){
				showCostTable.load(costJson);
			}else{
				var costparams = 
				{
					"elsAccount"            : elsAccount,
					"toElsAccount"          : $("#toElsAccount").val(),
					"purchaseEnquiryNumber" : $("#purchaseEnquiryNumber").val(),
					"materialLineNumber"    : materialLineNumber,
					"logtime"               : logtime					
				};
				showCostTable.load(costparams);
			}
			console.log(materialLineJson);
			$("#showCostDialog").show();
		});			
	});	
</script>
</body>
</html>