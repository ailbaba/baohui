<%@ page language="java" contentType="text/html; charset=utf-8"   pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String businessElsAccount    = request.getParameter("businessElsAccount");
String purchaseEnquiryNumber = request.getParameter("purchaseEnquiryNumber");
String stretegyCode          = request.getParameter("stretegyCode");
String flowCode              = request.getParameter("flowCode");
String auditType             = request.getParameter("auditType");
%>
<script type="text/javascript"	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<script type="text/javascript">  var hasRight = false; </script>
<link    rel="stylesheet"       type="text/css"  href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript"  src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>

<div class="box-wrap pos-relative bg-common">
	<span class="dis-in-b pos-absolute box-tip bg-common">操作</span>
	<div class="common-box-line">
		<div>
			<base:audit elsSubAccount="${elsSubAccount }" businessElsAccount="${param.businessElsAccount }" businessId="${param.purchaseEnquiryNumber }" elsAccount="${elsAccount }" businessType="saleEnquiry">
			<button id="passBtn" class="todo button-wrap">审批通过</button>
			<button id="noPassBtn" class="todo button-wrap">审批拒绝</button>
			<script type="text/javascript">
			hasRight = true;
			</script>
			</base:audit>
			<button id="cancelBtn" class="done button-wrap">撤销审批</button>
			<button id="flowBtn"   class="button-wrap">查看流程</button>
			<button id="exitBtn"   class="button-wrap">退出</button>
		</div>
	</div>
</div>

<div class="pos-relative public-wrap">
<form id="queryForm" onsubmit="return false;" method="POST" action="">
	<input type="hidden" id="elsAccount"            name="elsAccount"            value="<%=request.getParameter("elsAccount")%>"/>
	<input type="hidden" id="toElsAccount"          name="toElsAccount"          value="<%=request.getParameter("toElsAccount")%>"/>
	<input type="hidden" id="elsSubAccount"         name="elsSubAccount"         value="<%=session.getAttribute("elsSubAccount")%>"/>
	<input type="hidden" id="purchaseEnquiryNumber" name="purchaseEnquiryNumber" value="<%=request.getParameter("purchaseEnquiryNumber")%>"/>
	<input type="hidden" id="itemIds"               name="itemIds" /> 

	<div class="fixed-dialog" id="addFileDialog">
	<div class="dialog-tip" style="width: 350px;height: 240px;margin-left: -205px;margin-top: -190px;">
		<div class="dialog-close-btn" id="dialogFileClose"></div>
		<div class="tip-head"><img class="icon" src="../../icon/els.PNG" /><span class="dialogTitle">选择表单文件</span></div>
		<div class="box-wrap pos-relative bg-common">
			<div class="common-box-line">         
				<div class="input-and-tip"><span>文件名称：</span><input id="fileName" name="fileName" type="text" /></div>
				<div class="input-and-tip"><span>文件路径：</span><input id="filePath" name="filePath" type="text" /></div>
				<div class="input-and-tip"><span><div id="btnFileUpload" class="btn btnUpload">选择表单文件</div></span>
					<input id="fileType" name="fileType" type="hidden"/>
					<input id="filePath" name="filePath" type="hidden" />
				</div>
				<div class="mt-40">
					<button id="addFileBtnOK" class="button-wrap tip-option-btn">确定</button>
					<button id="addFileBtnCancel" class="button-wrap tip-option-btn">取消</button>
				</div>
			</div>
		</div>
	</div>
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
				<ul>
					<li><a href="#sheet-project-one">询价单行项目</a></li>
					<li><a href="#sheet-project-two">表单文件</a></li>
				</ul>
				<div id="sheet-project-one">
						<base:auditConfig elsAccount="${param.businessElsAccount }" businessType="saleEnquiry" type="item">
						<button id="itemPassBtn" style="display:none" class="button-wrap add-bottom-btn">通过</button>
						<button id="itemNoPassBtn" style="display:none" class="button-wrap add-bottom-btn">不通过</button>
						</base:auditConfig>		
					<main class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
							<div id="pg1" style="text-align: right;"></div>
						</div>
					</main>
				</div>
				<div id="sheet-project-two">
				<div class="box-wrap pos-relative bg-common">
				<div class="common-box-line p-zero">
				<div class="pos-relative upload-wrap">
				<div class="pos-absolute file-list">
							<div class="file-list-head"> 文件类型
							   <select class="" id="selectFileType" name="selectFileType" >
							   <option value="0">我方文件</option>
							   <option value="1">对方文件</option>
							   </select>
							 </div>
							<main class="grid-container">
								<div class="grid-100" id="reCreateFile">
									<table id="table-file"></table>
								</div>
							</main>
				</div>
				<div class="file-scan">
					<div class="file-option-zoom">
						<div class="dis-in-b text-left"> <button id="deleteSelectBtn" class="button-wrap">移除文件</button>	</div>
					</div>
					<div class="file-display" id="file-display"><a id="viewerPlaceHolder"></a>
					</div>
				</div>
				</div>
				</div>
				</div>					
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
	fileGrid,
	currentPurchaseEnquiryNumber,
	addLadderPriceTable,
	fileUploader,
	toElsAccount		= GetQueryString("toElsAccount"),
	elsAccount			= GetQueryString("elsAccount"),
	elsSubAccount       = GetQueryString("elsSubAccount");
	var headitem = null ; 
	var sendCode = 0    ;
	var auditType             = "<%=auditType%>" ;
	var purchaseEnquiryNumber = "<%=purchaseEnquiryNumber%>" ;
	var elsAccount            = "<%=businessElsAccount%>" ;
	var strs = new Array(); 
	    strs = purchaseEnquiryNumber.split(","); 
	$("#elsAccount").val(elsAccount);
	$("#toElsAccount").val(strs[0]);
	$("#purchaseEnquiryNumber").val(strs[1]);
	$(document).ready(function(){
		//初始化
		$('button').button();
		$('#sheet-project').tabs();
		//询价单头部
		var cols = [{ title : '询价单号',name: 'purchaseEnquiryNumber',width: 150,align: 'center'}, 
					{ title : '订单类型',name: 'orderType',width: 80,align: 'center',renderer 	: function (val) {	return ["行情询价", "物料询价", "材质询价"][parseInt(val)];	}},
					{ title : '询价单状态',name : 'orderStatus',width : 100,align : 'center',renderer: function (val) {
						return ["新建", "报价中", "议价中", "审批中", "重报价","已定价", "已拒绝", "已结束", "已报价", "已选择"	][parseInt(val)]; }},
					{ title : '中标状态',name : 'selectStatus',width : 80,align : 'center',renderer 	: function (val) {return ["竞标中", "已中标", "未中标"][parseInt(val)];	}}, 
					{ title:'询价开始日期', name:'beginDate' ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][beginDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					}},									    
					{ title:'询价结束日期', name:'endDate' ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}  if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][endDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					}}, 
					{ title : '备注',name : 'enquiryDesc', width: 200, align : 'center'}
				   ];
		var cols_file =[{ title:'申请订单号' , name:'purchaseApplyNumber'     ,hidden:true, width:60 , align:'center' },
	                    { title:'行号'       , name:'purchaseApplyItemNumber' ,hidden:true, width:60 , align:'center' },                 
	                    { title:'文件来源'   , name:'filePath'                ,hidden:true, width:500, align:'center' },
	                    { title:'文件名称'   , name:'fileName'                            , width:100, align:'center' },
	                    { title:'发送状态'   , name:'fileStatus'                          , width:50 , align:'center' },
	                    { title:'物料编码'   , name:'purchaseMaterialNumber'              , width:100, align:'center' },
	                    { title:'物料描述'   , name:'purchaseMaterialDesc'                , width:100, align:'center' },
	                    { title:'时间截'     , name:'logtime' , width:120, renderer:function(val){	if (!val) {val = "";} if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
				          return "<span class='showText'>" + val + "</span>" + "<input name='saleEnquiryItemList[][priceValidEndDate]' class='Wdate' onfocus='WdatePicker()' type='text' style='display:none' value='"+val+"'/>";
						}}			
					   ];
		var cols_item =[{ title:'申请订单号', name:'purchaseRequestNumber'            ,hidden:true, width:60, align:'center'},
	                    { title:'行号',       name:'purchaseRequestLineProjectNumber' ,hidden:true, width:60, align:'center'},
	                    { title:'物料行编号', name:'materialLineNumber'               ,width: 60,  align:'center' },
	                    { title:'物料编码',   name:'materialNumber'                   ,width: 100, align:'center' },
						{ title:'物料描述',   name:'materialDesc'                     ,width: 180, align:'center' },
						{ title:'物料规格',   name:'materialSpecification' ,width:180, align:'center' },						
						{ title:'采购类型',   name:'purchaseType' ,width: 70 , align:'center', renderer: function(val){	 if(val==0){  return "外购";     }  
		                                                                                                            else if(val==1){  return "外协";     }
													                                                                else if(val==2){  return "寄售票员"; }
						}},
					    { title:'属性1',   name:'property1'                   ,hidden:true ,width: 100, align:'center' },
						{ title:'属性2',   name:'property2'                   ,hidden:true ,width: 100, align:'center' },
					    { title:'属性3',   name:'property3'                   ,hidden:true ,width: 100, align:'center' },
						{ title:'属性4',   name:'property4'                   ,hidden:true ,width: 100, align:'center' },
						{ title:'属性5',   name:'property5'                   ,hidden:true ,width: 100, align:'center' },
						{ title:'最小订单量', name:'minOrderQuantity'         ,width: 100, align:'center' },
						{ title:'最小包装数', name:'minPackQuantity'          ,width: 100, align:'center' },												
						{ title:'采购周期',   name:'cycle'                    ,width: 100, align:'center' },																		
						{ title:'不足容差', name:'minTolerance'               ,width: 100, align:'center' },
						{ title:'超量容差', name:'maxTolerance'               ,width: 100, align:'center' },												
						{ title:'无限制',   name:'infinite'                   ,width: 100, align:'center' },
						{ title:'币别',     name:'currency'                   ,width: 100, align:'center' },												
						{ title:'询价单状态', name:'orderStatus'              ,width: 70 , align:'center',
							renderer: function(val){	 if(val==0){  return "新建";	 }
							                        else if(val==1){  return "报价中";   }
													else if(val==2){  return "议价中";   }
													else if(val==3){  return "审批中";   }
													else if(val==4){  return "重报价";   }
													else if(val==5){  return "已定价";   }
													else if(val==6){  return "已拒绝";   }
													else if(val==7){  return "已结束";   }
													else if(val==8){  return "已报价";   }
													else if(val==9){  return "已选择";   }
						}},
						{ title:'需求日期',   name:'endDate'                     ,width: 80 , align:'center'  ,
							renderer:function(val){   	 if (!val) {val = "";}
							    	                     if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
							    	                     return "<input name='purchaseOrderItemList[][deliveryDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
						}},								
						{ title:'需求数量',     name:'quantity'                         ,width:60, align:'center'},
						{ title:'计量单位',     name:'unitPrice'                        ,width:60, align:'center'},
						{ title:'计价度量单位', name:'unitMeasure'                    ,width:60, align:'center'},
						{ title:'计价单位',     name:'unitPrice'                        ,width:60, align:'center'},
				        { title:'设置阶梯',     name:'quoteMethod'                      ,width:60, align:'center' ,renderer: ladderPriceDetail},
						{ title:'采购商备注',   name:'remark'                           ,width:60, align:'center'},
						{ title:'税率',         name:'taxesCode' ,width:60, align:'center' },
						{ title:'不含税价',     name:'price' ,width:100, align:'center'},		
						{ title:'含税价',       name:'priceIncludingVat' ,width:100, align:'center'},		
            	        { title:'设置成本',     name:'showCost' ,width:100, align:'center',renderer:showCostDetail},
							
						{ title:'价格有效期从', name:'priceValidBeginDate' ,width:110, align:'center',renderer:function(val,item,index){
		                  	if (!val) {val = "";}  	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
							return "<input name='purchaseOrderItemList[][priceValidEndDate]' class=' Wdate' onfocus='WdatePicker()' type='text' style='font-size: 12px;width: 86px;height: 14px;line-height: 12px;' id='priceValidBeginDate_"+index+"' value='"+val+"'/>";
						}},	
						{ title:'价格有效期到', name:'priceValidEndDate' ,width:110, align:'center',renderer:function(val,item,index){
		                  	if (!val) {val = "";}  	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
							return "<input name='purchaseOrderItemList[][priceValidEndDate]' class=' Wdate' onfocus='WdatePicker()' type='text' style='font-size: 12px;width: 86px;height: 14px;line-height: 12px;' id='priceValidEndDate_"+index+"' value='"+val+"'/>";
						}},				 
						{ title:'供应商备注',  name:'remark' ,width:60, align:'center'},
				        { title:'JSON',   name:'ladderPriceJson' ,width:200, align:'center',hidden:true}
			          ];

		//订单头数据初始化
		//订单头列表
		var frm  = $("#queryForm");
		headGrid = $('#table-head').mmGrid({
			height: 100,
			cols: cols,
			url : "<%=basePath%>rest/SaleEnquiryService/querySaleEnquiryHeader",
			params: frm.serializeJSON(),
			method:  frm[0].method,
			root:"rows",
			loadingText: '正在载入',
			noDataText: '暂无数据',
		});
		itemGrid = $('#table-item').mmGrid({
			cols: cols_item,
			url : "<%=basePath%>rest/SaleEnquiryService/querySaleEnquiryItemsByHead",
			params: frm.serializeJSON(),
			method: frm[0].method,
			root:"rows",
	        multiSelect: true,
	        checkCol:true,			
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
		fileGrid = $('#table-file').mmGrid({
			cols: cols_file,
			url : "<%=basePath%>rest/SaleEnquiryService/findSaleEnquiryFormFile",
			params: frm.serializeJSON(),
			method: frm[0].method,
			root:"rows",
			loadingText: '正在载入',
			noDataText: '暂无数据',
			checkCol: true,
		})
	    /*-----------------------------  阶梯报价  begin ------------------------------------------------------*/
	    var colsLadderPrice = [{title 		: '申请订单号',	name 		: 'supplierEnquiryNumber',hidden 		: true,	width : 60, align 		: 'center'}, 
		     				   {title 		: '行号',		name 		: 'orderItemNumber'      ,hidden 		: true,	width : 60, align 		: 'center'}, 
			    			   {title 		: '物料行编号',	name 		: 'materialLineNumber'   ,hidden 		: true,	width : 60, align 		: 'center'}, 						   
				    		   {title 		: '物料编码',	name 		: 'materialNumber',	                            width : 60, align 		: 'center'}, 
					    	   {title 		: '物料描述',	name 		: 'materialDesc',	                            width : 100,align 		: 'center'}, 
						       {title 		: '数量从',		name 		: 'beginQuantity',	                            width : 60,	align 		: 'center'}, 
    						   {title 		: '数量到',		name 		: 'endQuantity',	                            width : 60,	align 		: 'center'}, 
	    					   {title 		: '价格',		name 		: 'price',width : 120,align : 'center',	renderer : function (val, item, index) { if (!val) { val = '';	}
									return '<input class="nest-report" style="border:none;width:100px;background-color: rgba(0,0,0,0);box-shadow: none;border: none;" name="price" id="price_' + index + '" type="text" value="' + val + '"/>';}
		    				   }];
	    var params = {  "elsAccount":"", "toElsAccount":"", "purchaseEnquiryNumber":"", "orderItemNumber":"", "materialNumber":"" };

		$('.nest-report').live('focus',function() {
			$(this).css({'background-color': 'rgba(255,255,255,0.8)'});
		});

		$('.nest-report').live('blur',function() {
			$(this).css({'background-color': 'rgba(0,0,0,0)'});
		});

		addLadderPriceTable = $('#add-ladder-price-table').mmGrid({
			cols: colsLadderPrice,
			url: "<%=basePath%>rest/SaleEnquiryService/findEnquiryLadderPriceList",
			height:180,
			params:params,
			method: 'post',
			root: 'rows',
			loadingText: '正在载入',
			noDataText: '暂无数据',
			multiSelect: false,
			checkCol: false
		});
	    
		if (hasRight) {
	    	$("#itemPassBtn").show();
	    	$("#itemNoPassBtn").show();
	    	$("#itemPassBtn").click(function(){
	    		itemPass();
	    	});
			$("#itemNoPassBtn").click(function(){
	    		itemNoPass();
	    	});
	    }
	    
		$("#btnsetLadderPriceDialogClose").click(function(){
			$("#setLadderPriceDialog").hide();
		});
		 
		//取消按钮
		$("#btnAddLadderPriceCancel").click(function(){
			$("#setLadderPriceDialog").hide();
		});
		
		//查看阶梯报价信息
		function ladderPriceDetail(val,item,rowIndex)
		{
			if( val == 0 ){  return "<span></span>"; }
			else if( val == 1 ){  return '<span class="col-scan">设置</span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';	}
		}

	    //确定按钮
	    $("#btnAddLadderPriceOK").click(function(){
			var materialLineJson = JSON.parse($("#materialLineJson").val());
			var materialRowIndex = $("#materialRowIndex").val();
			var ladderPriceJson = [];
			var ladderPriceItmes = addLadderPriceTable.rows();
			for(var i=0; i< ladderPriceItmes.length;i++)
			{
				// ladderPriceJson.push(JSON.stringify(ladderPriceItmes[i]));
				var priceItem = ladderPriceItmes[i];
				var id = "#price_"+i;
				var price = $(id).val();
				priceItem["price"] = price;
				ladderPriceJson.push(JSON.stringify(priceItem));
			}
			//alert("ladderPriceJson "+ladderPriceJson); 
			materialLineJson['ladderPriceJson']= eval('['+ladderPriceJson+']');
			itemGrid.updateRow(materialLineJson,materialRowIndex);
			$("#setLadderPriceDialog").hide();
		});

		$('.col-scan').live("click", function() {
			var scanCol = $(this).next();  
			var sanContentText = scanCol.text();
			var sanContent = sanContentText.split("@enquiry@"); 
			var rowIndex = sanContent[1];  //当前是多少行
			var materialLineJson = sanContent[0]; //当前物料行数据
			$("#materialRowIndex").val(rowIndex);
			$("#materialLineJson").val(materialLineJson);
			var sanobj = JSON.parse(materialLineJson);
			var supplierEnquiryNumber = sanobj.supplierEnquiryNumber;
			var orderItemNumber       = sanobj.orderItemNumber;
			var materialNumber        = sanobj.materialNumber;
			var materialDesc          = sanobj.materialDesc;
			var materialLineNumber    = sanobj.materialLineNumber;
			//取出并判断存放价格阶梯json是否为空
			var ladderPriceJson       = sanobj.ladderPriceJson;
			if(ladderPriceJson != null && ladderPriceJson != "")
			{ //已经加载过的
				addLadderPriceTable.load(ladderPriceJson);
			}else
			{//第一次加载该物料行阶梯报价信息
				var params = { "elsAccount":elsAccount, "toElsAccount":$("#toElsAccount").val(), "purchaseEnquiryNumber":sanobj.purchaseEnquiryNumber,
						        "orderItemNumber":sanobj.purchaseRequestLineProjectNumber, "materialLineNumber":materialLineNumber,  "materialNumber":materialNumber
						     };
				addLadderPriceTable.load(params);
			}   
			$("#setLadderPriceDialog").show();
		});
		/*----------------------------------- 阶梯报价 end  ----------------------------*/
		$("#sendBtn").click(function(){	});

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
			url    : "<%=basePath%>rest/SaleEnquiryService/findSaleCompleteEnquiryCostConstitute",
			height : 180,
			params : costparams,
			method : 'post',
			root   : 'rows',
			loadingText : '正在载入',
			noDataText  : '暂无数据',
			multiSelect : false,
			checkCol    : false
		});
		
		if (auditType == "todo") {
			$(".todo").show();
			$(".done").hide();
		} else {
			$(".todo").hide();
			$(".done").show();
		}
		$("#passBtn").click(function(){
			pass();
		});
		$("#noPassBtn").click(function(){
			nopass();
		});
		$("#flowBtn").click(function(){
			flow();
		});
		$("#cancelBtn").click(function(){
			cancel();
		});
		$("#exitBtn").click(function(){
			parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
		});
		
		function pass() 
		{
			parent.elsDeskTop.tip.init({type: 'confirm',message:'确认要审批通过吗？',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url         : "<%=basePath%>rest/SaleEnquiryService/sendSaleEnquiryPass",
				type        : "post",
				contentType : "application/json",
				data        : JSON.stringify(frm.serializeJSON()),
				dataType    : "json",
				success     : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("操作成功");
					parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
				},
				error       : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.status == "401") {
						alert("订单行项目未全部通过不能审批通过",3);
					} else if (data.status == "403") {
						alert("没有审批权限",3);
					} else {
						alert("请求出错",3);
					}
				}
			});
			}});
		}		
		
		function nopass() 
		{
			parent.elsDeskTop.tip.init({type: 'confirm',message:'确认要审批拒绝吗？',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url         : "<%=basePath%>rest/SaleEnquiryService/sendSaleEnquiryNoPass",
				type        : "post",
				contentType : "application/json",
				data        : JSON.stringify(frm.serializeJSON()),
				dataType    : "json",
				success     : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("操作成功");
					parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
				},
				error       : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("请求出错",3);
				}
			});
			}});
		}
		
		function cancel() 
		{
			parent.elsDeskTop.tip.init({type: 'confirm',message:'确认要撤销审批吗？',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url         : "<%=basePath%>rest/SaleEnquiryService/cancelAudit",
				type        : "post",
				contentType : "application/json",
				data        : JSON.stringify(frm.serializeJSON()),
			    dataType    : "json",
				success     : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("操作成功");
					parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
				},
				error       : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.status == "401") {
						alert("流程结束的单据不能撤销审批",3);
				    } else if (data.status == "403") {
						alert("只有上一级处理人才能撤销审批",3);
					} else {
						alert("请求出错",3);
					}
				}
			});
			}});
		}
		
		function flow() 
		{
			var targetElsAccount = elsAccount;
			var businessType     = "saleEnquiry";
			var businessId       = purchaseEnquiryNumber;

			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'auditFlowList',
		        'windowTitle':'查看流程',
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
		        showAdv: true,
		        advArr: ['icon/test-car.png','icon/test-car2.png'],
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':680,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		}
		
		function itemPass() 
		{
			var allRows=itemGrid.rows();
			var rows = itemGrid.selectedRows();
			if (rows.length == 0) {
				alert("请选择行项目",2);
				return;
			}
			var itemIds = "";
			for (var i=0;i<rows.length;i++){
				itemIds += rows[i].purchaseEnquiryNumber + ':' + rows[i].materialLineNumber + ",";
			}
			itemIds = itemIds.substring(0,itemIds.length-1);
			$("#itemIds").val(itemIds);
			parent.elsDeskTop.showLoading();
			$.ajax({
				url         : "<%=basePath%>rest/SaleEnquiryService/itemPass",
				type        : "post",
				contentType : "application/json",
				data        : JSON.stringify(frm.serializeJSON()),
				dataType    : "json",
				success     : function(data) {
					parent.elsDeskTop.hideLoading();
				},
				error       : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("请求出错",3);
				}
			});
		}

		function itemNoPass() 
		{
			var allRows=itemGrid.rows();
			var rows = itemGrid.selectedRows();
			if (rows.length == 0) {
				alert("请选择行项目",2);
				return;
			}
			var itemIds = "";
			for (var i=0;i<rows.length;i++){
				itemIds += rows[i].purchaseEnquiryNumber + ':' + rows[i].materialLineNumber + ",";
			}
			itemIds = itemIds.substring(0,itemIds.length-1);
			$("#itemIds").val(itemIds);
			parent.elsDeskTop.showLoading();
			$.ajax({
				url         : "<%=basePath%>rest/SaleEnquiryService/itemNoPass",
				type        : "post",
				contentType : "application/json",
				data        : JSON.stringify(frm.serializeJSON()),
				dataType    : "json",
				success     : function(data) {
					parent.elsDeskTop.hideLoading();
				},
				error       : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("请求出错",3);
				}
			});
		}
		
		//成本窗口关闭
		$("#showCostDialogClose").click(function(){	  $("#showCostDialog").hide();   });
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
			var materialLineNumber = sanobj.materialLineNumber;
			if(costJson!=null&&costJson!=""){
				showCostTable.load(costJson);
			}else{
				var costparams = 
				{
					"elsAccount":elsAccount,
					"toElsAccount":$("#toElsAccount").val(),
					"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val(),
					"materialLineNumber":rowIndex
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