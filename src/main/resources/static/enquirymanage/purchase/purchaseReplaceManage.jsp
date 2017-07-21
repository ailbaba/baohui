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
        <div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		    <div class="common-box-line"><button id="sendBtn" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button></div>
        </div>
		<div class="fixed-dialog" id="addFileDialog">
        <div class="dialog-tip" style="width: 350px;height: 240px;margin-left: -205px;margin-top: -190px;">
		   <div class="dialog-close-btn" id="dialogFileClose"></div>
			<div class="tip-head">	<img class="icon" src="../../icon/els.PNG" /><span class="dialogTitle"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件"/></span></div>
		   <div class="">
			   <div class="box-wrap pos-relative bg-common">
			   <div class="common-box-line">                
				   <div class="input-and-tip"><span><i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>：</span><input id="fileName" name="fileName" type="text" /></div>
			       <div class="input-and-tip"><span><i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>：</span><input id="filePath" name="filePath" type="text" /></div>
				   <div class="input-and-tip"><span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件"/></div></span>
				   <input id="fileType" name="fileType" type="hidden"/>
				   <input id="filePath" name="filePath" type="hidden" />
				   </div>
				   <div class="mt-40">
				       <button id="addFileBtnOK"     class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定"/></button>
				       <button id="addFileBtnCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消"/></button>
				   </div>
			   </div>
			   </div>
		   </div>
        </div>
		</div>
               
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_enquiry_header_info" defaultValue="询价单头信息"/></span>
            <div class="common-box-line">
               <main class="grid-container">
                  <div class="grid-100"><table id="table-head"></table></div>
               </main>
            </div>
        </div>

		<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_purchase_bargain_item" defaultValue="询价单项目"/></span>
		<div class="common-box-line">
		<div class="tab-wrap" id="sheet-project">
			<ul>
			<li><a href="#sheet-project-one"><i18n:I18n key="i18n_purchase_bargain_item"  defaultValue="询价单项目"/></a></li>
			<li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件"/></a></li>
			</ul>

			<div id="sheet-project-one">
				<main class="grid-container">
					<div class="grid-100" id="scanProject">
					<table id="table-item"></table>
					<div id="pg-price" style="text-align: right;"></div>
					</div>
				</main>
			</div>

			<div id="sheet-project-two">
			<div class="box-wrap pos-relative bg-common">
		    <div class="common-box-line p-zero">
		    <div class="pos-relative upload-wrap">
				<div class="pos-absolute file-list">
					<div class="file-list-head"> <i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型"/>
						<select class="" id="selectFileType" name="selectFileType" >
							<option value="0"><i18n:I18n key="i18n_common_title_ourfile" defaultValue="我方文件"/></option>
							<option value="1"><i18n:I18n key="i18n_common_title_theyfile" defaultValue="对方文件"/></option>
						</select>
					</div>
					<main class="grid-container">
						<div class="grid-100" id="reCreateFile">
						<table id="table-file"></table>
						<div id="pg2" style="text-align: right;"></div>
						</div>
					</main>
				</div>
			    
				<div class="file-scan"> 
					<div class="file-option-zoom">
						<div class="dis-in-b text-left">
							<button id="addFileBtn"      class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加..."/></button>
							<button id="deleteSelectBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除"/></button>
						</div>
					</div>
					<div class="file-display" id="file-display">
						<a id="viewerPlaceHolder"></a>
					</div>
				</div>
			</div>
			</div>
		    </div>
			</div>
		</div>
		</div>
		</div>

	</form>	
	

</div>
 

<div class="fixed-dialog" id="setLadderPriceDialog" >
<div class="dialog-tip" style="width: 500px;height: 345px;margin-left: -315px;margin-top: -240px;">
	<div class="dialog-close-btn" id="btnsetLadderPriceDialogClose"></div>
	<div class="tip-head"><img class="icon" src="../../icon/els.PNG" /><span class="dialogTitle" id="titleLadderPriceDialog"><i18n:I18n key="test" defaultValue="物料阶梯设置"/></span></div>
	<div class="">
		<div class="box-wrap pos-relative bg-common">
			<!-- <span class="dis-in-b pos-absolute box-tip bg-common">阶梯设置</span> -->
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
				<div class="grid-100" ><table id="add-ladder-price-table"></table></div>
				<div class="mt-40 text-center" >
					<button id="btnAddLadderPriceOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定"/></button>
					<button id="btnAddLadderPriceCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消"/></button>
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
	fileUploader;
	
	var obj = getIframeData();
	var toElsAccount		= obj.toElsAccount;
	var elsAccount			= obj.elsAccount;
	var elsSubAccount       = obj.elsSubAccount;
	
	var headitem = null ; 
	var sendCode = 0    ;
	
	$(document).ready(function(){
		//初始化
		$('button').button();
		$('#sheet-project').tabs();
	
		//询价单头部
		var cols = [{ title : '<i18n:I18n key="i18n_enquiry_title_enquirynumber" defaultValue="询价单号"/>'    , name: 'purchaseEnquiryNumber' ,width: 150,align: 'center'}, 
					{ title : '<i18n:I18n key="i18n_label_orderType" defaultValue="订单类型"/>', name: 'orderType' ,width: 80,align: 'center',renderer 	: function (val) {	return ['<i18n:I18n key="i18n_enquiry_select_enquirytype_market" defaultValue="行情询价"/>', '<i18n:I18n key="i18n_enquiry_select_enquirytype_material" defaultValue="物料询价"/>',
			        '<i18n:I18n key="i18n_enquiry_select_enquirytype_texture" defaultValue="材质询价"/>'][parseInt(val)];	}},
					{ title : '<i18n:I18n key="i18n_enquiry_title_enquirystatus" defaultValue="询价单状态"/>'  , name: 'orderStatus'           ,width : 100,align : 'center',renderer: function (val) {
						return ['<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed" defaultValue="报价中"/>', "议价中", '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价"/>','<i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价"/>', "已选择"	][parseInt(val)]; }},
					{ title : '<i18n:I18n key="i18n_enquiry_SelectStatus" defaultValue="中标状态"/>'    , name: 'selectStatus'          ,width : 80,align : 'center',renderer 	: function (val) {return ['<i18n:I18n key="i18n_enquiry_select_isfree" defaultValue="竞标中"/>', '<i18n:I18n key="i18n_enquiry_select_bid" defaultValue="已中标"/>', '<i18n:I18n key="i18n_enquiry_select_nobid" defaultValue="未中标"/>'][parseInt(val)];	}}, 
					{ title : '<i18n:I18n key="i18n_enquiry_title_enquirybegindate" defaultValue="询价开始日期"/>', name: 'beginDate'        ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][beginDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					}},									    
					{ title : '<i18n:I18n key="i18n_enquiry_title_enquiryenddate" defaultValue="询价结束日期"/>', name: 'endDate'          ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}  if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][endDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					}}, 
					{ title : '<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注"/>'       , name: 'enquiryDesc'            ,width: 600, align : 'center'}
				   ];
		//询价单项目头部
		//查看阶梯报价信息
		function ladderPriceDetail(val,item,rowIndex){
			if( val == 0 )
			{
				return "<span></span>";
			}else if( val == 1 )
			{
				return '<span class="col-scan">设置</span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
			}
		};
		var cols_file =[{ title:'申请订单号' , name:'purchaseApplyNumber'     ,hidden:true, width:60 , align:'center' },
	                    { title:'行号'       , name:'purchaseApplyItemNumber' ,hidden:true, width:60 , align:'center' },                 
	                    { title:'文件来源'   , name:'filePath'                ,hidden:true, width:500, align:'center' },
	                    { title:'文件名称'   , name:'fileName'                            , width:100, align:'center' },
	                    { title:'发送状态'   , name:'fileStatus'                          , width:50 , align:'center' },
	                    { title:'物料编码'   , name:'purchaseMaterialNumber'              , width:100, align:'center' },
	                    { title:'物料描述'   , name:'purchaseMaterialDesc'                , width:100, align:'center' },
	                    { title:'时间截'     , name:'logtime'                             , width:120,
						    renderer:function(val){	if (!val) {val = "";}
		                							if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
													return "<span class='showText'>" + val + "</span>" + "<input name='saleEnquiryItemList[][priceValidEndDate]' class='Wdate' onfocus='WdatePicker()' type='text' style='display:none' value='"+val+"'/>";
						}}			
					   ];		

		var cols_item =[{ title:'申请订单号', name:'purchaseRequestNumber'            ,hidden:true, width:60, align:'center'},
	                    { title:'行号',       name:'purchaseRequestLineProjectNumber' ,hidden:true, width:60, align:'center'},
	                    { title:'<i18n:I18n key="i18n_common_title_materialLineNumber" defaultValue="物料行编号"/>', name:'materialLineNumber'      ,width: 60,  align:'center' },
	                    { title:'<i18n:I18n key="i18n_common_title_materialnumber"     defaultValue="物料编码"/>',   name:'materialNumber'          ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述"/>',     name:'materialDesc'            ,width: 400, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_materialSpecification" defaultValue="物料规格"/>',name:'materialSpecification'   ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_procurementtype" defaultValue="采购类型"/>',      name:'purchaseType' ,width: 70 , align:'center', renderer: function(val){if(val==0){ return '<i18n:I18n key="i18n_common_outsourcing" defaultValue="外购"/>';  }  
		                                                                                                            else if(val==1){  return '<i18n:I18n key="i18n_common_assist_outside" defaultValue="外协"/>';     }
													                                                                else if(val==2){  return '<i18n:I18n key="i18n_common_send_the_conductor" defaultValue="寄售票员"/>'; }
						}},
					    { title:'<i18n:I18n key="i18n_common_title_attribute1" defaultValue="属性1"/>',   name:'property1'                   ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_attribute2" defaultValue="属性2"/>',   name:'property2'                   ,width: 100, align:'center' },
					    { title:'<i18n:I18n key="i18n_common_title_attribute3" defaultValue="属性3"/>',   name:'property3'                   ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_attribute4" defaultValue="属性4"/>',   name:'property4'                   ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_attribute5" defaultValue="属性5"/>',   name:'property5'                   ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_minorderquantity" defaultValue="最小订单量"/>', name:'minOrderQuantity'   ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_minpackquantity" defaultValue="最小包装数"/>' , name:'minPackQuantity'    ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_purchasecycle" defaultValue="采购周期"/>'   ,   name:'cycle'              ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_lackoftolerance" defaultValue="不足容差"/>'   , name:'minTolerance'       ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_excessivetolerance" defaultValue="超量容差"/>', name:'maxTolerance'       ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_unlimitedtolerance" defaultValue="无限制"/>',   name:'infinite'           ,width: 100, align:'center' },
						{ title:'<i18n:I18n key="i18n_common_title_currency" defaultValue="币别"/>',     name:'currency'                     ,width: 100, align:'center' },												
				    	{ title : '<i18n:I18n key="i18n_enquiry_title_enquirystatus" defaultValue="询价单状态"/>'  , name: 'orderStatus'     ,width : 100,align : 'center',renderer: function (val) {
						return ['<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed" defaultValue="报价中"/>', "议价中", '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价"/>','<i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束"/>', '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价"/>', "已选择"	][parseInt(val)]; }},
						{ title:'<i18n:I18n key="i18n_common_title_deliverydate" defaultValue="需求日期"/>',   name:'endDate'             ,width: 80 , align:'center'  ,
							renderer:function(val){  if (!val) {val = "";} if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
							    	                 return "<input name='purchaseOrderItemList[][deliveryDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
						}},								
						{ title:'<i18n:I18n key="i18n_common_title_quantityrequired" defaultValue="需求数量"/>' ,    name:'quantity'               ,width:60 , align:'center'},
						{ title:'<i18n:I18n key="i18n_common_title_unitofmeasurement" defaultValue="计量单位"/>',    name:'unitPrice'              ,width:60 , align:'center'},
						{ title:'<i18n:I18n key="i18n_common_title_valuationUOM" defaultValue="计价度量单位"/>',     name:'unitMeasure'            ,width:60 , align:'center'},
						{ title:'<i18n:I18n key="i18n_common_title_valuateunit" defaultValue="计价单位"/>',          name:'unitPrice'              ,width:60 , align:'center'},
				        { title:'<i18n:I18n key="i18n_common_title_setladder" defaultValue="设置阶梯"/>',            name:'quoteMethod'            ,width:60 , align:'center', renderer:ladderPriceDetail},
						{ title:'<i18n:I18n key="i18n_common_title_taxRate" defaultValue="税率"/>',                  name:'taxesCode'              ,width:60 , align:'center', renderer:initInputDouble},
						{ title:'<i18n:I18n key="i18n_common_title_notincludingtaxprice" defaultValue="不含税价"/>', name:'price'                  ,width:100, align:'center', renderer:initInputDouble},		
						{ title:'<i18n:I18n key="i18n_common_title_priceincludingtax" defaultValue="含税价格"/>',    name:'priceIncludingVat'      ,width:100, align:'center', renderer:initInputDouble},		
            	  
						{ title:'<i18n:I18n key="i18n_common_price_effective_begin_date" defaultValue="价格有效开始日期"/>', name: 'priceValidBeginDate'        ,width:100, align:'center',renderer:function(val,item,index){ if (!val) {val = new Date().format("yyyy-MM-dd");} else if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}  return "<input name='purchaseOrderItemList[][priceValidBeginDate]' class=' Wdate' onfocus='WdatePicker()' type='text' style='font-size: 12px;width: 86px;height: 24px;' id='priceValidBeginDate_"+index+"' value='"+val+"'/>";}},									    
					    { title :'<i18n:I18n key="i18n_common_price_effective_end_date" defaultValue="价格有效结束日期"/>', name: 'priceValidEndDate'          ,width:100, align:'center',renderer:function(val,item,index){ if (!val) {val = "";}	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}	return "<input name='purchaseOrderItemList[][priceValidEndDate]' class=' Wdate' onfocus='WdatePicker()' type='text' style='font-size: 12px;width: 86px;height: 24px;' id='priceValidEndDate_"+index+"' value='"+val+"'/>";}}, 						
						{ title:'<i18n:I18n key="i18n_common_title_sellersNote" defaultValue="供应商备注"/>',   name:'remark'                 ,width:200 , align:'center'}
					];		
		//动态加载询价单行项目
		function loaditem(purchaseEnquiryNumber){
			debugger;
	 		var paramStr={"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseEnquiryNumber":purchaseEnquiryNumber  };
	 		$('#scanProject').html('<table id="table-item"></table><div id="pg1" style="text-align: right;"></div>');
	 		itemGrid = $('#table-item').mmGrid({
		        cols: cols_item,
		        height: 220,
		        url : "<%=basePath%>rest/PurchaseReplaceService/queryPurchaseReplaceItemsByHeader",
		        params: paramStr,
		        method:  'POST',
		        root:"rows",
				loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
				noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
		        checkCol: true,
		        multiSelect: true,
		        plugins: [
		            $('#pg-price').mmPaginator({
		                style: 'plain'
		                , totalCountName: 'total'
		                , page: 1
		                , pageParamName: 'currentPage'
		                , limitParamName: 'pageSize'
						, limitLabel: '<i18n:I18n defaultValue="每页{0}条" key="i18n_common_mmgrid_limitlabel"></i18n:I18n>'
						, totalCountLabel: '<i18n:I18n defaultValue="共<span>{0}</span>条记录" key="i18n_common_mmgrid_totalcountlabel"></i18n:I18n>'
		                , limit:null
		                , limitList: [5,10,15,20]
		            })
		        ]
		    });
 		}
		function loadfile(purchaseEnquiryNumber){
	 		var paramStr={"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseEnquiryNumber":purchaseEnquiryNumber  };
			fileGrid = $('#table-file').mmGrid({
				cols: cols_file,
				url : "<%=basePath%>rest/PurchaseReplaceService/findPurchaseReplaceFormFile",
				params: paramStr,
				method:  'POST',
				root:"rows",
				loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
				noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
				plugins: [
					$('#pg2').mmPaginator({
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

		//数据
		function initInput(val,item,index){
			if(!val) { val = '';}
			var name = $(this)[0].name;
			return '<input class="nest-report" style="width:46px;height: 24px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
		}
		function initInputInteger(val,item,index){
			if(!val) { val = '';}
			var name = $(this)[0].name;
			return '<input class="nest-report" onkeyup="value=value.replace(/[^(\\d)]/g,\'\')"  style="width:46px;height: 24px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
		}
		function initInputDouble(val,item,index){
			if(!val) { val = '';}
			var name = $(this)[0].name;
			return '<input class="nest-report blur_'+name+'" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 24px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
		}
		
		//订单头数据初始化
		//订单头列表
		var frm = $("#queryForm").serializeJSON();
		frm['elsAccount']=elsAccount;
		frm['toElsAccount']=toElsAccount;
		frm['elsSubAccount']=elsSubAccount;
		debugger;
		
		headGrid = $('#table-head').mmGrid({
			height:200,
			cols: cols,
			url : "<%=basePath%>rest/PurchaseReplaceService/queryPurchaseReplaceHeaderByCondtion",
			params: frm,
			method:  'POST',
			root:"rows",
			loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
			noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
		});
		headGrid.on('loadSuccess', function (e, data) {
			if (data.rows && data.rows.length > 0) {
				//默认选中第一行
				headGrid.select(0);
				headitem = data.rows[0] ;				
				//初始化询价单项目
				loaditem(data.rows[0].purchaseEnquiryNumber);
				//loadfile(data.rows[0].purchaseEnquiryNumber);
			}
		});
		headGrid.on('cellSelected', function (e, item, rowIndex, colIndex) {
			headitem = item ;	
			loaditem(item.purchaseEnquiryNumber);
				//loadfile(item.purchaseEnquiryNumber);
		})
		
	    /*-----------------------------  阶梯报价  begin ------------------------------------------------------*/
	    var colsLadderPrice = [{title 		: '申请订单号',name     : 'supplierEnquiryNumber',	hidden 		: true,	width 		: 60  ,align 		: 'center'}, 
	                       {title 		: '行号',	name 		: 'orderItemNumber',		hidden 		: true,	width 		: 60  ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_common_title_materialnumber"    defaultValue="物料编码" />'   ,name : 'materialNumber' ,	width 		: 60   ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_common_title_materialdescribe"  defaultValue="物料描述" />' ,name : 'materialDesc'   ,	width 		: 100  ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_ladderprice_title_quantity"     defaultValue="数量从" />'    ,name : 'beginQuantity'  ,	width 		: 60  ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_ladderprice_title_quantityto"   defaultValue="数量到" />'    ,name : 'endQuantity'    ,	width 		: 60  ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_common_title_priceincludingtax" defaultValue="价格" />' ,name: 'price', width : 120 ,align : 'center',renderer : function (val,item,index) { if(!val) { val = ''; }
		        			return '<input class="nest-report" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 24px;"   name="ladderprice"  id="ladderprice_' + index + '" type="text" value="'+val+'"/>';}
						   }];

	    var params = { "elsAccount":"", "toElsAccount":"", "purchaseEnquiryNumber":"", "orderItemNumber":"", "materialNumber":"" };

		$('.nest-report').live('focus',function() {
			$(this).css({'background-color': 'rgba(255,255,255,0.8)'});
		});

		$('.nest-report').live('blur',function() {
			$(this).css({'background-color': 'rgba(0,0,0,0)'});
		});

		addLadderPriceTable = $('#add-ladder-price-table').mmGrid({
			cols: colsLadderPrice,
			url: "<%=basePath%>rest/PurchaseReplaceService/findPurchaseReplaceLadderPriceList",
			height:180,
			params:params,
			method: 'post',
			root: 'rows',
			loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
			noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
			multiSelect: false,
			checkCol: false
		});
	 
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
			if( val == 0 )
			{
				return "<span></span>";
			}else if( val == 1 )
			{
				return '<span class="col-scan"><i18n:I18n key = "i18n_common_label_settings" defaultValue="设置" /></span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
			}
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
				 var id = "#ladderprice_"+i;
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
			var orderItemNumber = sanobj.orderItemNumber;
			var materialNumber = sanobj.materialNumber;
			var materialDesc = sanobj.materialDesc;
			var materialLineNumber = sanobj.materialLineNumber;

			//取出并判断存放价格阶梯json是否为空
			var ladderPriceJson       = sanobj.ladderPriceJson;

			
			if(ladderPriceJson != null && ladderPriceJson != "")
			{ //已经加载过的
				addLadderPriceTable.load(ladderPriceJson);
			}else
			{//第一次加载该物料行阶梯报价信息

				 var params = {
						   "elsAccount":elsAccount,
						   "toElsAccount":toElsAccount,
						   "purchaseEnquiryNumber":sanobj.purchaseEnquiryNumber,
						   "orderItemNumber":sanobj.purchaseRequestLineProjectNumber,
						   "materialLineNumber":materialLineNumber,
						   "materialNumber":materialNumber
						 };
				addLadderPriceTable.load(params);
			}   
			$("#setLadderPriceDialog").show();
		});
		/*----------------------------------- 阶梯报价 end  ----------------------------*/
		

		$("#sendBtn").click(function(){
			/*--------------json begin -------*/
			var jsonObj = frm;
			jsonObj["elsAccount"]=elsAccount;
			jsonObj["toElsAccount"]=toElsAccount;
			//获取表单头信息
			if(headitem != null ){
				jsonObj["orderType"]=headitem.orderType;
				jsonObj["orderStatus"]=headitem.orderStatus;
				jsonObj["selectStatus"]=headitem.selectStatus;
				jsonObj["beginDate"]=headitem.beginDate;
				jsonObj["endDate"]=headitem.endDate;
				jsonObj["maker"]=headitem.maker;
				jsonObj["purchaseEnquiryNumber"]=headitem.purchaseEnquiryNumber;
			}	
			//获取物料信息跟阶梯报价信息
			var saleEnquiryItemVOs =[];
			var saleEnquiryLadderPriceVOs =[];
			var SaleReceiveEnquiryCostConstituteVOs = [];
			
			var itemTableRows = itemGrid.rows();
			if(itemTableRows != "" && itemTableRows != null){
				for(var i = 0 ; i < itemTableRows.length ; i ++ ){
					var singleRow = itemTableRows[i] ;
					singleRow       = inputSetValue(singleRow,i) ;
					var quoteMethod = singleRow.quoteMethod      ;

					if(parseInt(quoteMethod) == 1){
						//设置阶梯报价信息到相应的json存放数组---------begin---------
						var ladderPriceJson = singleRow.ladderPriceJson;
						if(ladderPriceJson != "" && ladderPriceJson != null){
							for(var j = 0 ; j < ladderPriceJson.length ; j++){
								saleEnquiryLadderPriceVOs.push(JSON.stringify(ladderPriceJson[j]));
								if (ladderPriceJson[j].price != null || ladderPriceJson[j].price != "" ){
									ladderCode = 1;
								}
							}
						}
						//设置阶梯报价信息到相应的json存放数组---------end---------
					}

					var taxesCode             = $("#taxesCode_"+i).val()           ; //获取税率
					var taxPrice              = $("#taxPrice_"+i).val()            ;
					var taxpriceIncludingVat  = $("#priceIncludingVat_"+i).val()   ;
					var priceValidBeginDate   = $("#priceValidBeginDate_"+i).val() ;
					var priceValidEndDate     = $("#priceValidEndDate_"+i).val()   ;
					/* //判断用户填的信息是否完善 */
				    /* if(taxesCode==""||taxPrice==""||priceValidBeginDate==""||priceValidEndDate==""){
						sendCode = 2;
					} */
					if(parseInt(quoteMethod) == 0){
						if ($("#price_"+i).val() != "" ||  $("#priceIncludingVat_"+i).val() != "" ){
							textCode = 1 ;
						}
					}					
					singleRow["taxesCode"] = taxesCode;
					//singleRow["price"] = taxPrice;
					singleRow["priceValidBeginDate"] = priceValidBeginDate;
					singleRow["priceValidEndDate"]   = priceValidEndDate;
					singleRow["fbk1"] = elsSubAccount +'_'+username;
					debugger;
					saleEnquiryItemVOs.push(JSON.stringify(singleRow));
				}
			}
			jsonObj['saleEnquiryLadderPriceVOs']            = eval('['+saleEnquiryLadderPriceVOs+']');
			jsonObj['saleEnquiryItemVOs']                   = eval('['+saleEnquiryItemVOs+']');
			debugger;
			if(sendCode==0){
				$.ajax({
					url 		:"<%=basePath%>rest/PurchaseReplaceService/updatePurchaseReplaceItems",
					type 		: "post",
					contentType : "application/json",
					data 		: JSON.stringify(jsonObj),
					//data : 	'{"elsAccount":'+elsAccount+',"toElsAccount":'+toElsAccount+',"purchaseEnquiryNumber":'+purchaseEnquiryNumber+'}',

					dataType 	: "json",
					success 	: function(data){
						alert('<i18n:I18n key="i18n_common_alert_publishsuccessful" defaultValue="发送成功" />');
					},
					error : function(data){
							//showMsg("发送失败");
					}
			  });
			}else{
				parent.elsDeskTop.tip.init({dispalyType:2,type:'alert',message: returnFailureMessage(sendCode)});
			
			}			
		});

		//更新行操作 自动填充input框输入值
		function updateMaterialLineByIndex(materialLine , index){
		    materialLine = inputSetValue(materialLine,index)
		    itemGrid.updateRow(materialLine,index);
		}
		   
	   
		function inputSetValue(materialLine,index){
			//获取改行计价度量单位
			var priceMetricQuantity             = $("#priceMetricQuantity_"+index).val();
			materialLine["priceMetricQuantity"] = priceMetricQuantity;
			//获取改行计价单位
			var priceQuantity                   = $("#priceQuantity_"+index).val();
			materialLine["priceQuantity"]       = priceQuantity     ;
			//获取最小订单量
			var minOrderQuantity                = $("#minOrderQuantity_"+index).val();
			materialLine["minOrderQuantity"]    = minOrderQuantity  ;
			//获取最小包装数
			var minPackQuantity                 = $("#minPackQuantity_"+index).val();
			materialLine["minPackQuantity"]     = minPackQuantity   ;
			//获取含税价格
			var price                           = $("#price_"+index).val();
			materialLine["price"]               = price    ;
			//获取不含税价
			var priceIncludingVat               = $("#priceIncludingVat_"+index).val();
			materialLine["priceIncludingVat"]   = priceIncludingVat ;
			//获取不足容差
			var minTolerance                    = $("#minTolerance_"+index).val();
			materialLine["minTolerance"]        = minTolerance ;
			//获取超量容差
			var maxTolerance                    = $("#maxTolerance_"+index).val();
			materialLine["maxTolerance"]        = maxTolerance ;
			//获取改行计价单位
			var infinite                        = $("#infinite_"+index).val()  ;
			materialLine["infinite"]            = infinite ;   
			var taxesCode                       = $("#taxesCode_"+index).val() ;
			materialLine["taxesCode"]           = taxesCode;   
			var fbk7                            = $("#fbk7_"+index).val()      ;
			materialLine["fbk7"]                = fbk7     ;
			var fbk8                            = $("#fbk8_"+index).val()      ;
			materialLine["fbk8"]                = fbk8     ;   
			var remark                          = $("#remark_"+index).val()    ;
			materialLine["remark"]              = remark   ;   
			//获取价格有效时间 
			var priceValidBeginDate             = $("#priceValidBeginDate_" + index).val() ;
			materialLine["priceValidBeginDate"] = priceValidBeginDate ;   
			//获取价格失效时间 
			var priceValidEndDate               = $("#priceValidEndDate_" + index).val()   ;
			materialLine["priceValidEndDate"]   = priceValidEndDate   ;
			return materialLine;
		}			
	});
	
	//------------含税价、不含税价、税率自动计算；含税价＝不含税价×（1 ＋ 税率 / 100 ）---begin----
	//不含税价格input失去焦点事件
	$('.blur_price').live('blur',function() {
	     var rowIndex = $(this).closest("tr").index();
	     computeTax(rowIndex);
	});
	//税率input失去焦点事件
	$('.blur_taxesCode').live('blur',function() {
	     var rowIndex = $(this).closest("tr").index();
	     computeTax(rowIndex);
	});
	//含税价格input失去焦点事件
	$('.blur_priceIncludingVat').live('blur',function() {
	     var rowIndex = $(this).closest("tr").index();
	     computeTax(rowIndex);
	});
	
	function computeTax(rowIndex){
		var price = $("#price_"+rowIndex).val();
		var taxesCode = $("#taxesCode_"+rowIndex).val();
		var priceIncludingVat = $("#priceIncludingVat_"+rowIndex).val();
		if(price != "" && taxesCode != "" && priceIncludingVat == ""){//根据不含税价格及税率计算含税价格
			priceIncludingVat = price*(1+taxesCode/100.0);
			$("#priceIncludingVat_"+rowIndex).val(priceIncludingVat.toFixed(6));
		}else if(price == "" && taxesCode != "" && priceIncludingVat != ""){//根据含税价格及税率计算不含税价格
			price = priceIncludingVat/(1+taxesCode/100.0);
			$("#price_"+rowIndex).val(price.toFixed(6));
		}else if(price != "" && taxesCode == "" && priceIncludingVat != ""){//根据不含税价格及含税价格计算税率
			var taxesCode = (priceIncludingVat-price)*100.0/price;
			$("#taxesCode_"+rowIndex).val(taxesCode.toFixed(2));
		}
	}
	//------------含税价、不含税价、税率自动计算；含税价＝不含税价×（1 ＋ 税率 / 100 ）---end----
</script>
</body>
</html>