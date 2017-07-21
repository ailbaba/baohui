<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
	String purchaseEnquiryNumber = request.getParameter("purchaseEnquiryNumber");
	String toElsAccount = request.getParameter("toElsAccount");
%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>

<body>
    <div class="pos-relative public-wrap">
	<form id="queryForm" onsubmit="return false;" method="POST" action="">
		<input type="hidden" id="elsAccount"            name="elsAccount" /> 
		<input type="hidden" id="toElsAccount"          name="toElsAccount" />
		<input type="hidden" id="elsSubAccount"         name="elsSubAccount" />
		<input type="hidden" id="purchaseEnquiryNumber" name="purchaseEnquiryNumber"/>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip pos-relative">
					<span><i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />：</span><input id="FBK5" name="FBK5" type="text"  readonly width:200px;padding-right:20px;/>
					<img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryPrincipal" title='<i18n:I18n key="i18n_enquiry_LookingPrincipal" defaultValue="查找负责人" />' />
				</div>						
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>			
				<button id="sendBtn"  class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>			
				<button style="margin-left: 10px;" id="columnDefineBtn"	    class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_headerName" defaultValue="头" /><i18n:I18n key="i18n_common_button_columncustom" defaultValue="头列自定义" /></button>	
				<button style="margin-left: 10px;" id="itemcolumnDefineBtn"	class="button-wrap"><i18n:I18n key="i18n_purchase_bargain_itemName" defaultValue="行" /><i18n:I18n key="i18n_common_button_columncustom" defaultValue="行列自定义" /></button>
				<base:auditConfig elsAccount="${elsAccount }" businessType="saleEnquiry">
					<button id="entryBtn"       class="button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批"    /></button>
					<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report"      defaultValue="撤销审批"/></button>
					<button id="flowBtn"        class="button-wrap"><i18n:I18n key="i18n_common_viewflow"  defaultValue="查看流程"/></button>
				</base:auditConfig>
				<div class="dis-in-b input-and-tip pos-relative" style="font-size: 12px;">
				<strong><i18n:I18n key="test" defaultValue="最后刷新时间" />：</strong><span style="color: red;" id="refurbish" class="refurbish"></span>
				</div>
			</div>
        </div>
        
		<div class="fixed-dialog" id="addFileDialog">
		<div class="dialog-tip bg-common" style="width: 262px;height: auto; margin-left: -131px;margin-top: -190px;">
			<div class="dialog-close-btn" id="dialogFileClose"></div>
			<div class="tip-head">	<img class="icon" src="../../icon/els.PNG" /><span class="dialogTitle"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件"/></span></div>
			<div class="">
	   		<div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
			<div class="common-box-line">
				<div class="input-and-tip"><span><i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>：</span><input id="fileName" name="fileName" type="text" /></div>
				<div class="input-and-tip"><span><i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>：</span><input id="filePath" name="filePath" type="text" /></div>
				<div class="input-and-tip text-right"><span><button id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件"/></button></span>
					<input id="fileType" name="fileType" type="hidden"/>
					<input id="filePath" name="filePath" type="hidden" />
				</div>
				<div class="mt-20 text-center">
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
                  <div class="grid-100">
				  <table id="table-head"></table>
                  </div>
               </main>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_enquiry_item_info" defaultValue="询价单行/物料信息"/></span>
			<div class="common-box-line">
			<div class="tab-wrap" id="sheet-project">
				<ul>
					<li><a href="#sheet-project-one"><i18n:I18n key="i18n_purchase_bargain_item"  defaultValue="询价单项目"/></a></li>
					<li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件"/></a></li>
				</ul>
				<div id="sheet-project-one">
					<button style="margin-left: 10px;margin-bottom:10px;" id="fillTime" class="button-wrap"><i18n:I18n key="i18n_label_fillcolumn" defaultValue="填充列" /></button>
					<button style="margin-left: 10px;margin-bottom:10px;" class="button-wrap" id="exportBtn">导出EXCEL</button>
					<button style="margin-left: 10px;margin-bottom:10px;" class="button-wrap" id="importBtn">导入EXCEL</button>
					<main class="grid-container">
					<div class="grid-100" id="enquiryOrdertItemGird">
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
						<div class="file-list-head"> <i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型"/>
							<select class="" id="selectFileType" name="selectFileType" >
								<option value="0"><i18n:I18n key="i18n_common_title_ourfile" defaultValue="我方文件"/></option>
								<option value="1"><i18n:I18n key="i18n_common_title_theyfile" defaultValue="对方文件"/></option>
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
						<div class="dis-in-b text-left">
							<!-- <button id="preViewBtn" class="button-wrap">预览文件</button> -->
							<button id="deleteSelectBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="移除文件"/></button>
							<button id="DownloadBtn"     class="button-wrap"><i18n:I18n key="i18n_common_title_downfile"    defaultValue="下载文件"/></button>
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

		<div class="saying-dialog">
			<div class="fl-left left-content pos-relative">
				<div class="dis-block pos-absolute option-bar pre-active next"></div>
			</div>
			<div class="fl-left right-content pos-relative none-active">
				<div class="saying-box-wrap">
				<iframe class="testIframe" frameborder="0" width="100%">
				</iframe>
				</div>
			</div>
			<div class="clear-both"></div>
		</div>
	</form>	
	</div>

	<div class="fixed-dialog" id="setLadderPriceDialog" >
	<div class="dialog-tip" style="width: 500px;height: 345px;margin-left: -315px;margin-top: -240px;">
	    <div class="dialog-close-btn" id="btnsetLadderPriceDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" /><span class="dialogTitle" id="titleLadderPriceDialog"><i18n:I18n key="test" defaultValue="物料阶梯设置"/></span>
	    </div>
	    <div class="">
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
	            <button id="btnAddLadderPriceOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定"/></button>
	            <button id="btnAddLadderPriceCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消"/></button>
	        </div>
            </main>
	    </div>
	    </div>
    </div>
    </div>

	<div class="fixed-dialog" id="selectPrincipalDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
		<div class="dialog-close-btn" id="btnSelectPrincipalDialogClose"></div>
		<div class="tip-head"><img class="icon" src="../../icon/els.PNG" /> <span class="dialogTitle" id="titleSelectPrincipalDialog"><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择"/></span></div>
		<div class="">
		<div class="box-wrap pos-relative bg-common">
			<main class="bg-common p-6">
			<div class="grid-100" > <table id="select-principal-table"></table>	</div>
			<div class="mt-40 text-center" style="margin-top: 14px;">
				<button id="btnSelectPrincipalOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定"/></button>
				<button id="btnSelectPrincipalCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消"/></button>
			</div>
			</main>
		</div>
		</div>
	</div>
	</div>

	<div class="fixed-dialog" id="showCostDialog" >
	<div class="dialog-tip" style="width: 800px;height: 345px;margin-left: -315px;margin-top: -240px;">
	    <div class="dialog-close-btn" id="showCostDialogClose"></div>
        <div class="tip-head"><img class="icon" src="../../icon/els.PNG" /> <span class="dialogTitle" id="titleshowCostDialog"><i18n:I18n key="i18n_common_cost_constitute_info" defaultValue="成本结构信息"/></span></div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <input type="hidden" id ="materialLineJson"/>
	            <input type="hidden" id ="materialLineJson_Cost"/>
	            <input type="hidden" id ="materialRowIndex"/>
	            <input type="hidden" id ="materialLineJson-File"/>
	        </div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="showCostTable"></table>
                    </div>
                    <div class="mt-40 text-center" >
                        <button id="addCostOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定"/></button>
	                    <button id="showCostClose" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消"/></button>
	                </div>
                </main>
	        </div>
	    </div>
    </div>
	</div>

	<div class="fixed-dialog" id="selectTaxesCodeDialog" >
		<div class="dialog-tip bg-common" style="width: 430px;height: 383px;margin-left: -205px;margin-top: -270px;">
		    <div class="dialog-close-btn" id="btnSelectTaxesCodeOfMeasurementClose"></div>
	        <div class="tip-head">
		        <img class="icon" src="../../icon/els.PNG" />
		        <span class="dialogTitle" id="titleTaxesCodeDialog"><i18n:I18n key="i18n_common_title_selectRate" defaultValue="请选择税率"/></span>
		        <input type="hidden" id ="taxesCode_index"/>
		        <input type="hidden" id ="taxesCode_materialLineJson"/>
		    </div>
		    <div style=" background: #fff;position: absolute; right: 0;left: 0;top: 50px; bottom: 0px;border-radius: 10px;" >
		        <div class="box-wrap pos-relative bg-common" >
		            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filtercondition" defaultValue="过滤条件" /></span>
		            <div class="common-box-line">
		                <table>
		                	<tr class="line-height-tr">
		                		<td width="80px"><input  type="text" id="taxName" name="taxName" /></td>
		                	</tr>
		                </table>
		            </div>
		        </div>
		        <div class="box-wrap pos-relative bg-common" >
		            <main class="bg-common p-6">
	                    <div class="grid-100" >
	                        <table id="taxesCode-of-measurement-table"></table>
	                    </div>
	                    <div class="mt-20 text-center" >
		                    <button id="btnTaxesCodeOfMeasurementOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                    <button id="btnTaxesCodeOfMeasurementCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
		                </div>
	                 </main>
		        </div>
		    </div>
	    </div>
	</div>

<script>
		var headGrid;
		var itemGrid;
		var fileGrid;
		var updateFile;
		var currentPurchaseEnquiryNumber;
		var selectTaxesCodeOfMeasurementTable;
		var addLadderPriceTable;
		var sendCode = 0;
		var textCode = 0;
		var ladderCode = 0;
		var elsAccount = currentElsAccount;
		var elsSubAccount = elsSubAccount;
		var fileUploader;
		var excelUploader;
		var $sob ;
		var peopleList ;
		var purchaseEnquiryNumber='<%=purchaseEnquiryNumber%>';
		var toElsAccount='<%=toElsAccount%>';
		$("#purchaseEnquiryNumber").val(purchaseEnquiryNumber);
		$("#elsAccount").val(currentElsAccount);
		$("#elsSubAccount").val(elsSubAccount);
		$("#toElsAccount").val(toElsAccount);
		var taxRate=[];
		
		// 从数据字典获取付款方式
		var param = {"elsAccount":'160000',"tableName":"supplier_main_data","fieldName":"paymentList"};
		$.ajax({
		    url:"<%=basePath%>rest/ElsSearchDictionaryService/findValueList",
		    data:JSON.stringify(param),
			type :"post",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				paymentWayList = data.rows;
			},
			error : function(data) {
				if (!permissionError(data)) {
					console.log("查询付款方式请求异常");
				}
			}
		});
		
	    // 初始化付款方式下拉框
	    function rendererPaymentWaySelector(val,item,rowIndex){
			var html = "";
			for (var i=0;i<paymentWayList.length;i++){
				var selected = "";
				var code = paymentWayList[i].fieldValue;
				var name = paymentWayList[i].fieldValueText;
				if(val == name)
					selected = "selected";
			    html += "<option value='" + name + "'"+selected+">" + name + "</option>";
			}
			return "<select id='FBK36_"+rowIndex+"' >"+html+"</select>";
	    }
	    
		//初始化聊天窗口
		//ELS账号+订单号 作为 businessID
		function initChat(businessID,fbk4, hadSelected) {
			//供应商
			var report    = toElsAccount+'-'+hadSelected[0].toCompanyShortName ;
			var orderType = hadSelected[0].orderType  ;
			var beginDate = new Date(hadSelected[0].beginDate).format("yyyy-MM-dd") ;
			var endDate   = new Date(hadSelected[0].endDate).format("yyyy-MM-dd") ;
			//采购凭证号
			var purchaseOrderNumberList = [] ;
			//订单号
			var bIdList  = [] ;
			//聊天显示列表
			var chatList = [] ;
			var business = '' ;
			if(hadSelected && hadSelected.length) {
				hadSelected.forEach(function(d,i){
					var obj ={} ;
					var fString = '' ; 
					if(d.fbk4) {
						var f    = d.fbk4 ;
						var fArr = f.split(';') ;
						fArr.forEach(function(item,i){
						if(i==fArr.length-1) {
							fString +=item ;
						} else {
							fString +=item + ',' ;
						}
						}) ;
					}
					var fArr    = [] ;
					fArr[0]     = fString ;
					obj[report] = fArr ;
					bIdList.push(obj) ; 
					//供应商
					chatList.push(report)        ;
					//报价聊天只有一行
					business=d.purchaseEnquiryNumber;
				})                               ;
				chatList=chatList.map(function(d){	return {name:d}	}); 
		    };
			//初始化iframe
			var toElsSubAccount                  ;
			//多人聊天  type=multi 一对一 type=single  list 用来显示列表人
			bIdString      = bIdList&&bIdList.length?'['+bIdList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
			chatListString = chatList&&chatList.length?'['+chatList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
			var url = "multiChat_p.jsp?type=multi&fromElsAccount=" + elsAccount
						+ "&fromElsSubAccount="
						+ elsSubAccount
						+ "&toElsAccount="
						+ report
						+ "&toElsSubAccount="+bIdString
						+ "&businessType=enquiry"
						+ "&businessID="+business
		                + "&list="+ chatListString
		                + "&orderType="+orderType
 	 	              	+ "&beginDate="+beginDate
 	 	              	+ "&endDate="+endDate
						+ "&t="+new Date().getTime();
	    	$('.testIframe').attr('src','<%=basePath%>'+ url);
			//滚动条美化niceScroll
			$('.public-wrap').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
		}
		
		// 渲染   @author move/add/jiangzhidong 20160513  begin
		//价格采购开始日期
	    function priceValidBeginDateRenderer(val,item,index){
			if (!val) 
				{val = new Date().format("yyyy-MM-dd");} 
			else if (val!=""&&val.length != 10)
				{val = new Date(val).format("yyyy-MM-dd");}
			return "<input name='enquiryOrdertItemList[][priceValidBeginDate]' class=' Wdate' onfocus='WdatePicker()' type='text' style='font-size: 12px;width: 86px;height: 24px;' id='priceValidBeginDate_"+index+"' value='"+val+"'/>";
		}
	  	//价格采购结束日期
		function priceValidEndDateRenderer(val,item,index){ 
			if (!val) 
				{val = "";} 
			if (val!=""&&val.length != 10) 
				{val = new Date(val).format("yyyy-MM-dd");} 
			return "<input name='enquiryOrdertItemList[][priceValidEndDate]' class=' Wdate' onfocus='WdatePicker()' type='text' style='font-size: 12px;width: 86px;height: 24px;' id='priceValidEndDate_"+index+"' value='"+val+"'/>";
		}
	    function initInput(val,item,index){
	    	if(!val) { val = '';}
	    	var name = $(this)[0].name;
			return '<input class="nest-report" style="width:46px;height: 24px;"  name="enquiryOrdertItemList[]'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	    }
	    function initInputInteger(val,item,index){
	    	if(!val) { val = '';}
	    	var name = $(this)[0].name;
			return '<input class="nest-report" onkeyup="value=value.replace(/[^(\\d)]/g,\'\')"  style="width:46px;height: 24px;"  name="enquiryOrdertItemList[]'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	    }
	    function initInputDouble(val,item,index){
	    	if(!val) { val = '';}
	    	var name = $(this)[0].name;
			return '<input class="nest-report blur_'+name+'" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 24px;"  name="enquiryOrdertItemList[]'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	    }
	    function itemRender(val,item,index){
	    	if(!val) { val = '';}
	    	var name = $(this)[0].name;
	    	return '<input class="nest-report" style="width:46px;height: 24px;"  name="enquiryOrdertItemList[]'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
			/* if("currency"==colName){//货币
				return "<input typpe='text' name='"+colName+"' class='itemColsEdit' value='"+val+"' />";
			} else if("FBK10"==colName){//采购单位
				return "<input typpe='text' name='"+colName+"' class='itemColsEdit' value='"+val+"' />";
			} else if("unitPrice"==colName){//价格单位
				return "<input typpe='text' name='"+colName+"' class='itemColsEdit' value='"+val+"' />";
			} else {
				return "<input typpe='text' name='"+colName+"' class='itemColsEdit' value='"+val+"' />";
			} */
	    }
	    //渲染税率表格
	    function initTaxesCode(val,item,index){
			 if(!val) { val = '';}
			 var name = $(this)[0].name;
			 return '<input style="width:46px;height: 14px;" class="blur_'+name+'"  name="purchaseEnquiryItemVOs[]['+name+']" id="taxesCode_'+index+'" type="text" value="'+val+'"/>'+
			 '<img class="dis-in-b input-taxesCode" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 4px;cursor: pointer;" title="查找税率" />'+
			 '<span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+name+'</span>';
	    }
	  	//作废
		var selectDown1 = function(val,item,index) {
			var selected = '<select name="taxesCode" id="taxesCode"  style="color:blue; min-width:70px; padding:5px;"></select>'
			return selected;
		};
		//审批状态  auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
		var rendererAuditStatus = function (val,item,index){
			if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
			else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
			else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
			else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';
		};
		//订单的发送状态：0：未发送 1：已发送，对方已接收 2：已发送，等到对方接收
		var rendererOrderSendStatus = function (val,item,index){
			if (val == "0") return '<i18n:I18n key="test" defaultValue="未发送" />';
			else if (val == "1" || val == null) return '<i18n:I18n key="test" defaultValue="已发送，对方已接收" />';
			else if (val == "2") return '<i18n:I18n key="test" defaultValue="已发送，等到对方接收" />';
		};
		//附件需求
		var initAccessoryRequire = function (val,item,index){
			if (val == "0") return '<i18n:I18n key="i18n_common_select_accessoryrequire_choosable" defaultValue="附件可选" />';
			else if (val == "1") return '<i18n:I18n key="i18n_common_select_accessoryrequire_require" defaultValue="必须附件" />';
		};
		//查看阶梯报价信息 
		var initLadderPriceDetail = function (val,item,rowIndex){
			if( item.quoteMethod == 0 ){
				return "<span></span>";
			}else if( item.quoteMethod == 1 ){
				debugger;
				//加载阶梯是否填写完整 @author update/jiangzhidong @date 20160607 begin
				var ladderPriceJson = JSON.parse(item.ladderPriceJson);
				var total=0;
				var css='';
				if(ladderPriceJson != "" && ladderPriceJson != null){
					for(var j = 0 ; j < ladderPriceJson.length ; j++){
						if (ladderPriceJson[j].price != null && ladderPriceJson[j].price != ""){
							 total=total+1;
						}
					}
				}
				if(total==ladderPriceJson.length)
				css='style="color: blue;"';
			    return '<span class="col-scan" id="col-scan'+rowIndex+'"'+css+'><i18n:I18n key = "i18n_common_lable_set_quotation" defaultValue="设置/报价" /></span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
				//加载阶梯是否填写完整 @author update/jiangzhidong @date 20160607 end
			}
		}
		//计量单位
		var initUnitQuantity = function(val,item,index) {
			var val='';
			if(item.materialVO!=null){
				if (!item.materialVO.unitQuantity) {val = "";}
				else val=item.materialVO.unitQuantity;
			}
			return val;
		};
		//计价度量单位
		var initPriceMetricQuantity = function(val,item,index) {
			var val='';
			if(item.materialVO!=null){
				if (!item.materialVO.priceMetricQuantity) {val = "";}
				else val=item.materialVO.priceMetricQuantity;
			}
			return val;
		};
		//计价单位
		var initPriceQuantity = function(val,item,index) {
			var val='';
			if(item.materialVO!=null){
				if (!item.materialVO.priceQuantity) {val = "";}
				else val=item.materialVO.priceQuantity;
			}
			return val;
		};
		//含量%
		var initFBK13 = function(val,item,index) {
			if(!val) { val = '';}
	    	var name = $(this)[0].name;
			return '<input class="nest-report blur_'+name+'" onkeyup="addFBK13(this.value, '+index+')"  style="width:46px;height: 24px;"  name="enquiryOrdertItemList[]'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
		};
		//价格类型 如果填了含量,显示:折百价; 不填留空  诺普信
		var initFBK14 = function(val,item,index) {
			var val='';
			if(item.FBK13!=null&&item.FBK13!='')
				var val='<input style="background-color: yellow;" readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="折百价"/>';
			else
				var val='<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value=""/>';
			return val;
		};
		//含税价格
		var initPriceIncludingVat = function(val,item,index) {
			if(!val) { val = '';}
	    	var name = $(this)[0].name;
	    	// 如果是阶梯报价，则不可修改
	    	if (item.quoteMethod=="1") {
	    		return '<input style="display:none;" class="nest-report blur_'+name+'" name="enquiryOrdertItemList[]'+name+'" id="'+name+'_'+index+'" type="text" value="0" readOnly/>';
	    	}
	    	if(item.FBK13!=null&&item.FBK13!='')
	    		return '<input style="background-color: yellow;" class="nest-report blur_'+name+'" onblur="addPriceIncludingVat(this.value, '+index+')" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 24px;"  name="enquiryOrdertItemList[]'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	    	else
	    		return '<input class="nest-report blur_'+name+'" onblur="addPriceIncludingVat(this.value, '+index+')" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 24px;"  name="enquiryOrdertItemList[]'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
		};
		//阶梯价格
		var initLadderprice = function(val,item,index) {
			if(!val) { val = ''; }
			return '<input class="nest-report" onkeyup="addLadderprice(this.value, '+index+')"  style="width:46px;height: 24px;" name="ladderprice"  id="ladderprice_' + index + '" type="text" value="'+val+'"/>';
		};
		// 税码/税率  @author jiangzhidong @date 20160523 begin
	    var initTaxCode = function (val,item,index) {
	    	var name = $(this)[0].name;
	        var sel = '<div><p style="display: none;">'+JSON.stringify(item)+'</p><select onchange="changeTaxCode(this.id, '+index+')" name="'+this.name+'" id="'+name+'_'+index+'" class="taxType" style="padding: 0;height: 25px;">';
	        for(var i = 0 ; i < taxRate.length ; i ++){
				var row = taxRate[i];
				if(row.taxCode==val)
				sel += '<option value="'+row.taxCode+'" taxValue="'+row.taxValue+'" selected>'+row.taxCode+'_'+row.taxName+'</option>';
				else
				sel += '<option value="'+row.taxCode+'" taxValue="'+row.taxValue+'">'+row.taxCode+'_'+row.taxName+'</option>';
			}
	        return sel;
	    }
	    var initTaxValue = function (val,item,index) {
	    	if(!val) {
	    		val = '';
	    		if(taxRate.length>0){
		         	var row = taxRate[0];
		         	val = row.taxValue;
		        }
			}
	    	var name = $(this)[0].name;
			return '<input readonly="readonly" style="width:46px;height: 14px;" name="'+this.name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	    }
		var changeTaxCode = function(val,index){
			var obj=document.getElementById(val);  
			var selIndex=obj.selectedIndex;  
			var text=obj.options[selIndex].getAttribute("taxValue");  
			$('#FBK16_'+index).val(text);
			return val;
		}
	    // 税码/税率 @author jiangzhidong @date 20160523 end
		// 渲染   @author move/add/jiangzhidong 20160513  end
		
		//含量%与价格类型(折百价)
		var addFBK13 = function(val,index){
			var fbk13 ="#FBK13_" + index;
			var fbk14 ="#FBK14_" + index;
			var val=val.replace(/[^(\\0-9\\.)]/g,'');
			if(val!=null&&val!=''){
				$(fbk13).val(val);
				$(fbk14).val('折百价').css("background-color","yellow");
			}else{
				$(fbk13).val('');
				$(fbk14).val('').css("background-color","");
			}
			return val;
		}
		
		//含税价格与含量%(弹出)
		var addPriceIncludingVat = function(val,index){
			var id ="#FBK13_" + index;
			var id2 ="#priceIncludingVat_" + index;
			var fbk13 = $(id).val();
			if(fbk13!=null&&fbk13!=''){
				$(id2).css("background-color","yellow");
				alert("注意!此价格为折百价并且为含税价格,请不要录录入错误",2)
			}else{
				$(id2).css("background-color","");
			}
			return val;
		}
		
		//阶梯价格(即:采购方设置了阶梯报价，那么第一阶梯报价比如填写了120，那么第二阶梯价格不能大于或等于120，以此类推)
		var addLadderprice = function(val,index){
			var val=val.replace(/[^(\\0-9\\.)]/g,'');
			var id ="#ladderprice_" + (index-1);
			var id2 ="#ladderprice_" + index;
			if(index>0){
				var ladderprice = $(id).val();
				if(val == ""){
					alert("注意!此价格不能为空",2);
				}
				if(parseFloat(val)>parseFloat(ladderprice)){
					$(id2).val('');
					alert("注意!此价格不能大于前阶梯价格",2);
				}
			}else{
				$(id2).val(val);
			}
			return val;
		}
	
	//刷新 @author jiangzhidong @date 20160601
	$("#refurbish").click(function(){
		query();
	});      
	      
	//加载head/item
	function query() {
		var frm = $("#queryForm");
		headGrid.opts.params = frm.serializeJSON();
		headGrid.load({});
		itemGrid.opts.params = frm.serializeJSON();
		itemGrid.load({});
		var logtime = new Date().format("yyyy-MM-dd hh:mm:ss");
		$("#refurbish").text(logtime);
	}
		
	$(document).ready(function(){
		var showCheck=true;
		initExcelUploader();
		init();
		
		//最后刷新时间  @author jiangzhidong @date 20160401
		var logtime = new Date().format("yyyy-MM-dd hh:mm:ss");
		$("#refurbish").text(logtime);
		
		//获取询报价-税码、税率
		$.ajax({
		    url :"<%=basePath%>rest/ElsTaxRateService/queryElsTaxRateList",
		    type :"post",
		    contentType : "application/json",
		    data : JSON.stringify({"elsAccount":toElsAccount}),
		    dataType : "json",
		    success : function(data) {
		    	if(data.statusCode == "-100"){
				}else{
					taxRate = data.rows;
				}
		    },
		    error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
	    });
		
		$("#columnDefineBtn").click(function(){
			parent.elsDeskTop.defineWin({
				'iconSrc'        : 'icon/els-icon.png'       ,
				'windowsId'      : 'subAccountColumnSetting' ,
				'windowTitle'    : '<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
				 windowSubTitle  : ""            ,
			    'iframSrc'       : '<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=sale_enquiry_header_mt" + "&window=iframeApp_sale_enquiry_header",
				 showAdv         : true          ,
				 advArr          : ['icon/test-car.png','icon/test-car2.png'],
				 windowMinWidth  : 480           ,
				 windowMinHeight : 600           ,
				'windowWidth'    : 480           ,
				'windowHeight'   : 600           ,
				'parentPanel'    : ".currDesktop"});
		});
		$("#itemcolumnDefineBtn").click(function(){
			parent.elsDeskTop.defineWin({
				'iconSrc'        : 'icon/els-icon.png'       ,
				'windowsId'      : 'subAccountColumnSetting' ,
				'windowTitle'    : '<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
				 windowSubTitle  : ""            ,
			    'iframSrc'       : '<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=sale_enquiry_item_mt" + "&window=iframeApp_sale_enquiry_item",
				 showAdv         : true          ,
				 advArr          : ['icon/test-car.png','icon/test-car2.png'],
				 windowMinWidth  : 480           ,
				 windowMinHeight : 600           ,
				'windowWidth'    : 480           ,
				'windowHeight'   : 600           ,
				'parentPanel'    : ".currDesktop"});
		});
		
		$("#cancelBtn").click(function(){ 
			var frm                   = $("#queryForm") ;
			var elsAccount            = $("#elsAccount").val() ;
			var toElsAccount          = $("#toElsAccount").val() ;	
			var purchaseEnquiryNumber = $("#purchaseEnquiryNumber").val() ;	
			//var FBK5                  = $("#FBK5").val() ;
			var jsonObj = frm.serializeJSON() ;
			//组装json开始---------------
			//jsonObj["toElsAccount"]          = elsAccount ;
			jsonObj["elsAccount"]            = toElsAccount ;
			jsonObj["purchaseEnquiryNumber"] = purchaseEnquiryNumber ;
			$.ajax({
					url 		: "<%=basePath%>rest/SaleEnquiryService/invalidateSaleEnquiryInfo" ,
					type 		: "post" ,
					contentType : "application/json" ,
					data 		:  JSON.stringify(jsonObj) ,
					dataType 	: "json" ,
			  }).done(function(data){
				  alert(data.message||data,1) ;
			  }).fail(function(data){
				  alert(data.message||data,0) ;
			  }) ;
		}) ;
		
		//询报价-报价-保存 @author update/jiangzhidong @date 20160601
		$("#saveBtn").click(function(){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading('询价单保存中');
				var frm = $("#queryForm");
				var elsAccount = $("#elsAccount").val();
				var toElsAccount = $("#toElsAccount").val();	
				var purchaseEnquiryNumber = $("#purchaseEnquiryNumber").val();
				var FBK5 = $("#FBK5").val();
				var jsonObj = frm.serializeJSON();
				//组装json开始---------------
				jsonObj["elsAccount"]=elsAccount;
				jsonObj["toElsAccount"]=toElsAccount;
				jsonObj["purchaseEnquiryNumber"]=purchaseEnquiryNumber;
				
				//获取表单头信息
				var headTableRows = headGrid.rows();
				if(headTableRows != "" && headTableRows != null && headTableRows.length > 0){
					var item = headTableRows[0];
					jsonObj["orderType"] = item.orderType;
					jsonObj["orderStatus"] = item.orderStatus;
					jsonObj["selectStatus"] = item.selectStatus;
					jsonObj["beginDate"] = item.beginDate;
					jsonObj["endDate"] = item.endDate;
					jsonObj["maker"] = item.maker;
					jsonObj["FBK5"] = FBK5;
				}
								
				//获取表单文件信息
				var saleCreateEnquiryFileVOs = [];//用于存放表单文件信息
				//判断是否切换文件显示的界面，如果没有切换，则不需要更新文件信息 
				if(updateFile==true){
				 	var fileTableRows = fileGrid.rows();
					if(fileTableRows != "" && fileTableRows != null){
						for(var i = 0 ; i < fileTableRows.length ; i ++){
							saleCreateEnquiryFileVOs.push(JSON.stringify(fileTableRows[i]));
						}
					}
					jsonObj['saleCreateEnquiryFileVOs'] = eval('['+saleCreateEnquiryFileVOs+']');
				}
				//获取物料信息跟阶梯报价信息
				var saleEnquiryItemVOs =[];
				var saleEnquiryLadderPriceVOs =[];
				var saleCompleteEnquiryCostConstituteVOs = [];
				debugger;
				var itemTableRows = itemGrid.rows();
				if(itemTableRows != "" && itemTableRows != null){
					for(var i = 0 ; i < itemTableRows.length ; i ++ ){
						var singleRow = itemTableRows[i];
						singleRow       = inputSetValue(singleRow,i);
						var quoteMethod = singleRow.quoteMethod;
						if(parseInt(quoteMethod) == 1){
							//设置阶梯报价信息到相应的json存放数组---------begin---------
							//@author update/jiangzhidong @date 20160601 begin
							var ladderPriceJson = JSON.parse(singleRow.ladderPriceJson);
							if(ladderPriceJson != "" && ladderPriceJson != null){
								for(var j = 0 ; j < ladderPriceJson.length ; j++){
									saleEnquiryLadderPriceVOs.push(JSON.stringify(ladderPriceJson[j]));
									if (ladderPriceJson[j].price != null && ladderPriceJson[j].price != "" ){
										ladderCode = 1;
									}
								}
							}
							//@author update/jiangzhidong @date 20160601 end
							//设置阶梯报价信息到相应的json存放数组---------end---------
						}
						//设置成本报价信息到相应的json存放数组---------begin---------
						var costJson = singleRow.costConstituteJson;
						if(costJson!=""&&costJson!=null){
							for(var j = 0 ; j < costJson.length ; j++){
								saleCompleteEnquiryCostConstituteVOs.push(JSON.stringify(costJson[j]));
							}
						}
						//设置成本报价信息到相应的json存放数组---------end---------
						var taxesCode = $("#taxesCode_"+i).val(); //作废
						var taxPrice = $("#taxPrice_"+i).val();   //作废
						var taxpriceIncludingVat = $("#priceIncludingVat_"+i).val();
						var priceValidBeginDate = $("#priceValidBeginDate_"+i).val();
						var priceValidEndDate = $("#priceValidEndDate_"+i).val();
						var cycle = $("#cycle_"+i).val();
						var FBK13 = $("#FBK13_"+i).val();//含量%
						var FBK15 = $("#FBK15_"+i).val();//税码
						var FBK16 = $("#FBK16_"+i).val();//税率
						if(parseInt(quoteMethod) == 0){
							if ($("#price_"+i).val() != "" ||  $("#priceIncludingVat_"+i).val() != "" ){
								textCode = 1;
							}
						}					
						singleRow["taxesCode"] = taxesCode; //作废
						//singleRow["price"] = taxPrice;    //作废
						singleRow["priceValidBeginDate"] = priceValidBeginDate;
						singleRow["priceValidEndDate"]   = priceValidEndDate;
						singleRow["cycle"]   = cycle;
						singleRow["FBK13"]   = FBK13;//含量%
						singleRow["FBK15"]   = FBK15;//税码
						singleRow["FBK16"]   = FBK16;//税率
						saleEnquiryItemVOs.push(JSON.stringify(singleRow));
					}
				}
				jsonObj['saleEnquiryLadderPriceVOs'] = eval('['+saleEnquiryLadderPriceVOs+']');
				jsonObj['saleCompleteEnquiryCostConstituteVOs'] = eval('['+saleCompleteEnquiryCostConstituteVOs+']');
				jsonObj['saleEnquiryItemVOs'] = eval('['+saleEnquiryItemVOs+']');

				debugger;
				$.ajax({
					url : "<%=basePath%>rest/SaleEnquiryService/saveSaleEnquiryInfo",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(jsonObj),
					dataType : "json",
				}).done(function(data){
				 alert(data.message||data,1) ;
				 parent.elsDeskTop.hideLoading();
				 query();
				}).fail(function(data){
				 alert(data.message||data,0) ;
				 parent.elsDeskTop.hideLoading();
				 query();
				});
			}});
		});
		
		function returnFailureMessage(sendCode){
			if(sendCode == 1){
				return  '<i18n:I18n key="i18n_common_orderstatus_notsupported" defaultValue="订单状态不支持发布" />' ;
			}
			if (ladderCode == 0 || textCode == 0 ) {
				return  '<i18n:I18n key="i18n_common_not_fill_in_the_price" defaultValue="询价单没有填写价格" />'    ; 
			}
		}
		
		//询报价-报价-发布 @author update/jiangzhidong @date 20160601
		$("#sendBtn").click(function(){
			var frm                   = $("#queryForm") ;
			var elsAccount            = $("#elsAccount").val() ;
			var toElsAccount          = $("#toElsAccount").val()          ;	
			var purchaseEnquiryNumber = $("#purchaseEnquiryNumber").val() ;	
			var FBK5                  = $("#FBK5").val()                  ;
			var jsonObj = frm.serializeJSON()                             ;
			//组装json开始---------------
			jsonObj["elsAccount"]=elsAccount                              ;
			jsonObj["toElsAccount"]=toElsAccount                          ;
			jsonObj["purchaseEnquiryNumber"]=purchaseEnquiryNumber        ;
			
			//获取表单头信息
			var headTableRows = headGrid.rows()                           ;
			if(headTableRows != "" && headTableRows != null && headTableRows.length > 0){
				var item = headTableRows[0]                               ;
				jsonObj["orderType"]      = item.orderType                ;
				jsonObj["orderStatus"]    = item.orderStatus              ;
				jsonObj["selectStatus"]   = item.selectStatus             ;
				jsonObj["beginDate"] = item.beginDate           ;
				jsonObj["endDate"]   = item.endDate             ;
				jsonObj["maker"]          = item.maker                    ;
				jsonObj["FBK5"]           = FBK5                          ;
			}
			//判断当前的表单状态 
			var status =  jsonObj["orderStatus"]                          ;
			if(status!=0&& status!=1 &&status!=4){
				sendCode = 1 ;
			}
			
			//获取表单文件信息
			var saleCreateEnquiryFileVOs = [];//用于存放表单文件信息
			//判断是否切换文件显示的界面，如果没有切换，则不需要更新文件信息 
			debugger;
			if(updateFile==true){
			 	var fileTableRows = fileGrid.rows() ;
				if(fileTableRows != "" && fileTableRows != null){
					for(var i = 0 ; i < fileTableRows.length ; i ++){
						saleCreateEnquiryFileVOs.push(JSON.stringify(fileTableRows[i]));
					}
				}
				jsonObj['saleCreateEnquiryFileVOs'] = eval('['+saleCreateEnquiryFileVOs+']'); 
			}
			//获取物料信息跟阶梯报价信息
			var saleEnquiryItemVOs =[] ;
			var saleEnquiryLadderPriceVOs =[] ;
			var saleCompleteEnquiryCostConstituteVOs = [] ;
			var itemTableRows = itemGrid.rows() ;
			if(itemTableRows != "" && itemTableRows != null){
				for(var i = 0 ; i < itemTableRows.length ; i ++ ){
					var singleRow   = itemTableRows[i] ;
					singleRow       = inputSetValue(singleRow,i) ;
					var quoteMethod = singleRow.quoteMethod ;
					if(parseInt(quoteMethod) == 1){
						//设置阶梯报价信息到相应的json存放数组---------begin---------
						//@author update/jiangzhidong @date 20160601 begin
						var ladderPriceJson = JSON.parse(singleRow.ladderPriceJson);
						if(ladderPriceJson != "" && ladderPriceJson != null){
							for(var j = 0 ; j < ladderPriceJson.length ; j++){
								saleEnquiryLadderPriceVOs.push(JSON.stringify(ladderPriceJson[j]));
								if (ladderPriceJson[j].price == null||ladderPriceJson[j].price == ''){
									alert("阶梯价格不能空!",2);
									return;
								}
							}
						}
						//@author update/jiangzhidong @date 20160601 end
						//设置阶梯报价信息到相应的json存放数组---------end---------
					}
					//设置成本报价信息到相应的json存放数组---------begin---------
					var costJson = singleRow.costConstituteJson;
					if(costJson!=""&&costJson!=null){
						for(var j = 0 ; j < costJson.length ; j++){
							saleCompleteEnquiryCostConstituteVOs.push(JSON.stringify(costJson[j]));
						}
					}
					//设置成本报价信息到相应的json存放数组---------end---------
					var price                 = $("#price_"+i).val();
					var priceIncludingVat     = $("#priceIncludingVat_"+i).val();
					var taxesCode             = $("#taxesCode_"+i).val()           ; //作废
					var taxPrice              = $("#taxPrice_"+i).val()            ; //作废
					var taxpriceIncludingVat  = $("#priceIncludingVat_"+i).val()   ;
					var priceValidBeginDate   = $("#priceValidBeginDate_"+i).val() ;
					var priceValidEndDate     = $("#priceValidEndDate_"+i).val()   ;
					var cycle                 = $("#cycle_"+i).val();
					var FBK13                 = $("#FBK13_"+i).val();//含量%
					var FBK15                 = $("#FBK15_"+i).val();//税码
					var FBK16                 = $("#FBK16_"+i).val();//税率
					singleRow["taxesCode"] = taxesCode                    ;//作废
					//singleRow["price"] = taxPrice						  ;//作废
					singleRow["priceValidBeginDate"] = priceValidBeginDate;
					singleRow["priceValidEndDate"]   = priceValidEndDate  ;
					singleRow["cycle"]               = cycle;
					singleRow["fbk13"]               = FBK13;//含量%
					singleRow["fbk15"]               = FBK15;//税码
					singleRow["fbk16"]               = FBK16;//税率
					//@author update/zhongbaohui @date 20160817 begin
					//@author update/jiangzhidong @date 20160601 begin
// 					if(parseInt(quoteMethod) == 0){
// 						if (priceIncludingVat==''||priceIncludingVat==null){
// 							alert("含税价格不能空!",2);
// 							return;
// 						}
// 					}	
// 					if(priceValidBeginDate==''||priceValidBeginDate==null){
// 						alert("价格有效开始日期不能空!",2);
// 						return;
// 					}
// 					if(priceValidEndDate==''||priceValidEndDate==null){
// 						alert("价格有效结束日期不能空!",2);
// 						return;
// 					}
					//@author update/jiangzhidong @date 20160601 end
					//@author update/zhongbaohui @date 20160817 end
					saleEnquiryItemVOs.push(JSON.stringify(singleRow))    ;
				}
			}
			jsonObj['saleEnquiryLadderPriceVOs']            = eval('['+saleEnquiryLadderPriceVOs+']');
			jsonObj['saleCompleteEnquiryCostConstituteVOs'] = eval('['+saleCompleteEnquiryCostConstituteVOs+']');
			jsonObj['saleEnquiryItemVOs']                   = eval('['+saleEnquiryItemVOs+']');
			if( sendCode==0 ){
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_whetherConfirmatinIssued" defaultValue="是否确认发布？" />',closeEvent:function(){
					parent.elsDeskTop.showLoading('询价单发布中');
					$.ajax({
						url 		:"<%=basePath%>rest/SaleEnquiryService/updateSaleEnquiryInfo",
						type 		:"post" ,
						contentType : "application/json" ,
						data 		: JSON.stringify(jsonObj) ,
						dataType 	: "json" ,
					 }).done(function(data){
						  alert(data.message||data,1) ;
						  parent.elsDeskTop.hideLoading();
						  query();
					 }).fail(function(data){
						  alert(data.message||data,0) ;
						  parent.elsDeskTop.hideLoading();
						  query();
					 }) ;
				}}) ;
			}else{
				parent.elsDeskTop.tip.init({type:'alert', displayType:2, message: returnFailureMessage(sendCode)});
			}
			
		}) ;
		
		$("#entryBtn").click(function(){
			var url ;
			var frm = $("#queryForm") ;
			var jsonObj = frm.serializeJSON() ;
		    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading() ;
				//组装json开始---------------
				jsonObj["elsAccount"]            = $("#elsAccount").val() ;
				jsonObj["toElsAccount"]          = $("#toElsAccount").val() ;
				jsonObj["purchaseEnquiryNumber"] = $("#purchaseEnquiryNumber").val() ;

				//获取表单头信息
				var headTableRows = headGrid.rows() ;
				if(headTableRows != "" && headTableRows != null && headTableRows.length > 0){
					var item = headTableRows[0] ;
					jsonObj["orderType"]      = item.orderType ;
					jsonObj["orderStatus"]    = item.orderStatus ;
					jsonObj["selectStatus"]   = item.selectStatus ;
					jsonObj["beginDate"] 	  = item.beginDate ;
					jsonObj["endDate"]        = item.endDate ;
					jsonObj["maker"]          = item.maker ;
					jsonObj["FBK5"]           = $("#FBK5").val() ;
				}
				//获取表单文件信息
				var saleCreateEnquiryFileVOs = [] ;
				if(updateFile==true){
					var fileTableRows = fileGrid.rows() ;
					if(fileTableRows != "" && fileTableRows != null){
						for(var i = 0 ; i < fileTableRows.length ; i ++){
							saleCreateEnquiryFileVOs.push(JSON.stringify(fileTableRows[i]));
						}
					}
					jsonObj['saleCreateEnquiryFileVOs'] = eval('['+saleCreateEnquiryFileVOs+']'); 
				}
				//获取报价单行信息
				var saleEnquiryItemVOs                   = []             ;
				var saleEnquiryLadderPriceVOs            = []             ;
				var saleCompleteEnquiryCostConstituteVOs = []             ;
				var itemTableRows = itemGrid.rows()                       ;
				if(itemTableRows != "" && itemTableRows != null)
				{
					for(var i = 0 ; i < itemTableRows.length ; i ++ )
					{
						var singleRow = itemTableRows[i]                  ;
							singleRow = inputSetValue(singleRow,i)        ;
						var quoteMethod = singleRow.quoteMethod           ;
						if(parseInt(quoteMethod) == 1)
						{
							//设置阶梯报价信息到相应的json存放数组---------begin---------
							var ladderPriceJson = singleRow.ladderPriceJson;
							if(ladderPriceJson != "" && ladderPriceJson != null){
								for(var j = 0 ; j < ladderPriceJson.length ; j++){
									saleEnquiryLadderPriceVOs.push(JSON.stringify(ladderPriceJson[j]));
								}
							}
							//设置阶梯报价信息到相应的json存放数组---------end---------
						}
						//设置成本报价信息到相应的json存放数组---------begin---------
						var costJson = singleRow.costConstituteJson       ;
						if(costJson!=""&&costJson!=null){
							for(var j = 0 ; j < costJson.length ; j++){
								saleCompleteEnquiryCostConstituteVOs.push(JSON.stringify(costJson[j]));
							}
						}
						//设置成本报价信息到相应的json存放数组---------end---------
						var taxesCode           = $("#taxesCode_"+i).val()           ; //获取税率
						var taxPrice            = $("#taxPrice_"+i).val()            ;
						var priceValidBeginDate = $("#priceValidBeginDate_"+i).val() ;
						var priceValidEndDate   = $("#priceValidEndDate_"+i).val()   ;
						singleRow["taxesCode"]           = taxesCode                 ;
						singleRow["priceValidBeginDate"] = priceValidBeginDate       ;
						singleRow["priceValidEndDate"]   = priceValidEndDate         ;
						saleEnquiryItemVOs.push(JSON.stringify(singleRow))           ;
					}
				}
				jsonObj['saleEnquiryLadderPriceVOs'] = eval('['+saleEnquiryLadderPriceVOs+']');
				jsonObj['saleCompleteEnquiryCostConstituteVOs'] = eval('['+saleCompleteEnquiryCostConstituteVOs+']');
				jsonObj['saleEnquiryItemVOs'] = eval('['+saleEnquiryItemVOs+']');
				
				$.ajax({	url         : "<%=basePath%>rest/SaleEnquiryService/entrySaleEnquiry",
							type        : "post",
							contentType : "application/json",
							data 		: JSON.stringify(jsonObj),
							dataType    : "json",
							success 	: function(data) {
								parent.elsDeskTop.hideLoading();
								alert('<i18n:I18n key="i18n_common_report_success"    defaultValue="发送失败" />');
								if (purchaseEnquiryNumber != "") {
									window.location="<%=basePath%>enquirymanage/saleorder/quotedManage.jsp?toElsAccount=" + toElsAccount + "&purchaseEnquiryNumber=" + purchaseEnquiryNumber;
								}
							},
							error : function(data) {
								parent.elsDeskTop.hideLoading();
								if (data.status == "401") {    alert('<i18n:I18n key="i18n_common_orders_cannot_be_repeated_to_report"    defaultValue="订单不能重复上报" />',3);    } 
								else {	alert('<i18n:I18n key="i18n_common_alert_requestfail"    defaultValue="请求出错" />',3);	};
							}		
				});
			}});
		});
		
		$("#flowBtn").click(function(){
			var tpurchaseEnquiryNumber = toElsAccount + "," + $("#purchaseEnquiryNumber").val() ;
			parent.elsDeskTop.defineWin({
			   	'iconSrc'       : 'icon/els-icon.png' ,
				'windowsId'     : 'auditFlowList'     ,
				'windowTitle'   : '<i18n:I18n key="i18n_common_viewflow"    defaultValue="查看流程" />',
				 windowSubTitle : ""                  ,
				'iframSrc'      : '<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=saleEnquiry&businessId='+ tpurchaseEnquiryNumber,
				 showAdv        : true                ,
				 advArr         : ['icon/test-car.png','icon/test-car2.png'] ,
				 windowMinWidth : 480 ,
				 windowMinHeight: 600 ,
				'windowWidth'   : 680 ,
				'windowHeight'  : 600 ,
				'parentPanel'   : ".currDesktop"
			});
		});

		$("#cancelEntryBtn").click(function(){
			var frm = $("#queryForm");
		    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			//var param = {"businessElsAccount":elsAccount,"purchaseEnquiryNumber":purchaseEnquiryNumber,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
			$.ajax({  url         : "<%=basePath%>rest/SaleEnquiryService/cancelAudit",
					  type        : "post"             ,
					  contentType : "application/json" ,
					  data        : JSON.stringify(frm.serializeJSON()),
					  dataType    : "json"             ,
					  success     : function(data) {
						  parent.elsDeskTop.hideLoading();
						  alert('<i18n:I18n key="i18n_delivery_revokesuccess"    defaultValue="撤销成功" />');
						  window.location="<%=basePath%>enquirymanage/saleorder/quotedManage.jsp?toElsAccount=" + toElsAccount + "&purchaseEnquiryNumber=" + $("#purchaseEnquiryNumber").val().trim();
				      },
				      error : function(data) {
						  parent.elsDeskTop.hideLoading();
						       if (data.status == "401") {  alert('<i18n:I18n key="i18n_audit_overcantcancel"    defaultValue="流程结束的单据不能撤销审批" />'  ,3);  } 
						  else if (data.status == "403") {  alert('<i18n:I18n key="i18n_audit_higherlevelcando"  defaultValue="只有上一级处理人才能撤销审批" />',3);  } 
						  else {  alert('<i18n:I18n key = "i18n_common_alert_requestfail" defaultValue="请求出错！" />',3);	  }
					 }
			    });
			}
			});			    
		});	
	});
		/*
		var cols = [{ title : '采购商'     , name: 'toCompanyShortName'   ,hidden:true, width:60  , align:'center'},
		            { title : '询价单号'   , name: 'purchaseEnquiryNumber'            , width:100 , align:'center'}, 
					{ title : '订单类型'   , name: 'orderType'                        , width:70  , align:'center' ,	
					  renderer : function (val) { return ["行情询价", "物料询价", "材质询价"][parseInt(val)];    }}, 
					{ title	: '询价单状态' , name: 'orderStatus'                      ,	width:70,	align:'center' ,
					  renderer : function (val) { return ["新建", "报价中", "议价中", "审批中", "重报价",	"已定价", "已拒绝", "已结束", "已报价", "已选择"][parseInt(val)];}}, 
					{ title	: '中标状态'   , name: 'selectStatus'                     ,	width:70  ,	align: 'center',
				      renderer 	: function (val) {	return ["竞标中", "已中标", "未中标"][parseInt(val)];        }}, 
					{ title:'询价开始日期',  name:'beginDate' ,width:80, align:'center',renderer:function(val){  if (!val) {val = "";}  if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
				      return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][beginDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>"; }},									    
	  		        { title:'询价结束日期',  name:'endDate' ,width:80, align:'center',renderer:function(val){  if (!val) {val = "";}	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	    			  return "<span class='showText'>" + val + "</span>" + "<input name='purchaseOrderItemList[][endDate]' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>"; }}, 
					{ title : '备注',		 name: 'enquiryDesc'                      , width:150 , align:'center'},
					{ title : '采购负责人' , name: 'FBK4'                ,hidden:false, width:130  , align:'center'},
		            { title : '销售负责人' , name: 'FBK5'                ,hidden:false, width:128  , align:'center'}
		           ];*/
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="sale_enquiry_header_mt"/>;
	//阶梯报价相关-------begin-------
	var colsLadderPrice = [{title : '申请订单号',name     : 'supplierEnquiryNumber',	hidden 		: true,	width 		: 60  ,align 		: 'center'}, 
	                       {title : '行号',	name 		: 'orderItemNumber',		hidden 		: true,	width 		: 60  ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_common_title_materialnumber"    defaultValue="物料编码" />'   ,name : 'materialNumber' ,	width 		: 60   ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_common_title_materialdescribe"  defaultValue="物料描述" />' ,name : 'materialDesc'   ,	width 		: 100  ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_ladderprice_title_quantity"     defaultValue="数量从" />'    ,name : 'beginQuantity'  ,	width 		: 60  ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_ladderprice_title_quantityto"   defaultValue="数量到" />'    ,name : 'endQuantity'    ,	width 		: 60  ,align 		: 'center'}, 
	                       {title : '<i18n:I18n key = "i18n_common_title_priceincludingtax" defaultValue="含税价格" />' ,name: 'price', width : 120 ,align : 'center',renderer: initLadderprice }];
	var params = {"elsAccount":"", "toElsAccount":"", "purchaseEnquiryNumber":"", "orderItemNumber":"", "materialNumber":"" };
	//报价成本-------begin------------- 成本项目名称 
	var colsCostConstitute = [{	title : '<i18n:I18n key = "i18n_common_title_materialnumber"        defaultValue="物料编码" />',    name : 'materialNumber', width : 60  , align : 'center'}, 
			                  {	title : '<i18n:I18n key = "i18n_common_title_materialdescribe"      defaultValue="物料描述" />',	name : 'materialDesc'  , width : 100 , align : 'center'}, 
			                  {	title : '<i18n:I18n key = "i18n_coststructure_label_costitemname"   defaultValue="成本名称" />',	name : 'costItemName'  , width : 60  , align : 'center'}, 
			                  {	title : '<i18n:I18n key = "i18n_coststructure_title_costitemamount" defaultValue="成本金额" />',    name : 'costItemAmount', width : 80  , align : 'center' ,renderer 	: function (val,item,index)   {	if (!val) { val = ''; }
							    return '<input class="nest-report" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 24px;"   name="costItemAmount"  id="costItemAmount_' + index + '" type="text" value="'+val+'"/>';}}, 
							  {	title : '<i18n:I18n key = "i18n_additionCost_costDescription" defaultValue="说明" />'   ,	name : 'remark'          ,width : 500,	align : 'center', renderer 	: function (val, item, index) {	if (!val) {	val = ''; }
								return '<input class="nest-report" style="border:none;width:450px;background-color: rgba(0,0,0,0);box-shadow: none;border: none;" name="remark" id="remark_' + index +'"type="text" value="' + val + '"/>';}}
							 ];
	var costparams = {"elsAccount":"","toElsAccount":"","purchaseEnquiryNumber":"","materialLineNumber":"",};
	//报价成本-------end -------------
    //选择负责人相关-----------------begin---------------i18n_label_elsSubAccount  
    var colsPrincipal = [{ title:'<i18n:I18n key = "i18n_label_elsSubAccount" defaultValue="用户编码" />', name:'elsSubAccount' , width:60, align:'center'},
		                 { title:'<i18n:I18n key = "i18n_label_rolename"      defaultValue="用户名称" />', name:'name'          , width:60, align:'center'} ];
    var selectPrincipalTable=$('#select-principal-table').mmGrid({
        cols        : colsPrincipal  ,
        url         : "<%=basePath%>rest/AccountService/subAccountList" ,
        params      : {"elsAccount":elsAccount,"station":"sale"}        ,
        method      : 'post'         ,
        root        : 'rows'         ,
        loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
        noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
        multiSelect : true           ,
        checkCol    : true           ,
        indexCol    : true
    });
    //触发负责人弹出框事件，并用负责人文本框数据初始化窗口table的选中数据 
    $("#queryPrincipal").click(function(){
    	var principal = $("#FBK5").val();
    	var principalArray = principal.split(";");//根据“;”获取以选择的负责人数组
    	var totalRows = selectPrincipalTable.rows()             ;
    	if(totalRows != "" &&totalRows != null && principalArray){
    		for(var i = 0 ; i < totalRows.length ; i ++){
    			for(var j = 0 ; j < principalArray.length ; j ++ ){
    				var elsSubAccount = totalRows[i].elsSubAccount;
    				var name = totalRows[i].name                ;
    				var _principal = principalArray[j]          ;
    				var _principalArray = _principal.split("_") ;
    				var _elsSubAccount = _principalArray[0]     ;
    				var _name = _principalArray[1]              ;
    				if(elsSubAccount == _elsSubAccount && name == _name){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
    					selectPrincipalTable.select(i)          ;
    					continue                                ;
    				}
    			}
    		}
    	}
    	$("#selectPrincipalDialog").show()                      ;
    });
    //选择负责人弹出框确认按钮单击事件
    $("#btnSelectPrincipalOK").click(function(){
    	var selectedRows = selectPrincipalTable.selectedRows()  ;
    	var principals   = ""                                   ;
    	if(selectedRows != "" ){
    		for(var i = 0 ; i < selectedRows.length ; i ++){
    			var singleRow = selectedRows[i]                 ;
    			var elsSubAaccount = singleRow.elsSubAccount    ;
    			var name = singleRow.name                       ;
    			if(i == 0){
    				principals +=     elsSubAaccount+"_"+name   ;
    			}else{
    			    principals += ";"+elsSubAaccount+"_"+name   ;
    			}
    		}
    	}else{
    		alert('<i18n:I18n key = "i18n_alert_atLeast_select_oneItem"      defaultValue="至少选择一条记录！" />');
    		return                                              ;
    	}
    	$("#FBK5").val(principals)                              ;
    	$("#selectPrincipalDialog").hide()                      ;
    });
    $("#btnSelectPrincipalDialogClose").click( function(){  $("#selectPrincipalDialog").hide();  });
    $("#btnSelectPrincipalCancel").click( function(){  $("#selectPrincipalDialog").hide();  });
    //选择负责人相关----------------end----------------
    $('.nest-report').live('focus',function() {
	     $(this).css({'background-color': 'rgba(255,255,255,0.8)'});
    });
    $('.nest-report').live('blur',function() {
	    $(this).css({'background-color': 'rgba(0,0,0,0)'});
    });
    addLadderPriceTable = $('#add-ladder-price-table').mmGrid({
	    cols        : colsLadderPrice,
	    url         : "<%=basePath%>rest/SaleEnquiryService/findEnquiryLadderPriceList",
	    height      : 180,
	    params      : params,
	    method      : 'post',
	    root        : 'rows',
        loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
        noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
	    multiSelect : false,
	    checkCol    : false
    });
	$("#btnsetLadderPriceDialogClose").click(function(){
		$("#setLadderPriceDialog").hide();
	});
	//取消按钮
	$("#btnAddLadderPriceCancel").click(function(){
	 	$("#setLadderPriceDialog").hide();
	});
 	// 查看成本
	showCostTable = $('#showCostTable').mmGrid({
	    cols        : colsCostConstitute,
	    url         : "<%=basePath%>rest/SaleEnquiryService/findSaleCompleteEnquiryCostConstitute",
	    height      : 180,
	    params      : costparams,
	    method      : 'post',
	    root        : 'rows',
        loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
        noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
	    multiSelect : false,
	    checkCol    : false
	});
 
	//成本窗口关闭
	$("#showCostDialogClose").click(function(){
		$("#showCostDialog").hide();
	});
	
	$("#showCostClose").click(function(){
	  	$("#showCostDialog").hide();
	});

	function showCostDetail(val,item,rowIndex){
		return '<span class="col-showCost"><i18n:I18n key = "i18n_common_title_setcostconstitute"  defaultValue="设置成本" /></span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
	}
	 
	//渲染阶梯报价方式  
	function quoteMethod(val){
		if( val == 0 ){
			return '<i18n:I18n key = "i18n_ladderprice_select_normalBidding" defaultValue="常规报价" />';
		}else if( val == 1 ){
			return '<i18n:I18n key = "i18n_ladderprice_select_ladderBidding" defaultValue="阶梯报价" />';
		}
	}
	
	function queryHis(val){  return '<span class="col-price-his"><i18n:I18n key = "i18n_enquiry_label_check" defaultValue="查看" /></span><span style="display: none;">'+JSON.stringify(cols_item)+'</span>'; }
	
	function setAccessory(val,item,index){  
		return '<span class="col-scan-file" style="color:blue;cursor:pointer;"><i18n:I18n key = "i18n_enquiry_label_upload" defaultValue="上传" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'; 
	}
	
    //确定按钮
    $("#btnAddLadderPriceOK").click(function(){
			 var materialLineJson = JSON.parse($("#materialLineJson").val());
			 var materialRowIndex = $("#materialRowIndex").val();
			 var ladderPriceJson = [];
			 var ladderPriceItmes = addLadderPriceTable.rows();
			 var total=0;
			 for(var i=0; i< ladderPriceItmes.length;i++){
				 var priceItem = ladderPriceItmes[i];
				 var id = "#ladderprice_"+i;
				 var price = $(id).val();
				 debugger;
				 if(price == ""){
					 alert("阶梯报价不能存在空值",2);
					 return;
				 }
				 priceItem["price"] = price;
				 ladderPriceJson.push(JSON.stringify(priceItem));
				 if(price!=null&&price!='')
				 total=total+1;
			 }
			 //@author update/jiangzhidong @date 20160601 begin
	    	 //materialLineJson['ladderPriceJson']= eval('['+ladderPriceJson+']');
	    	 materialLineJson['ladderPriceJson']= '['+ladderPriceJson+']';
	    	 //@author update/jiangzhidong @date 20160601 end
	    	 updateMaterialLineByIndex(materialLineJson,materialRowIndex);
	    	 itemGrid.updateRow(materialLineJson,materialRowIndex);
	    	 //@author add/jiangzhidong @date 20160607 begin
	    	 var rowIndex = $("body").data("ladderRowIndex");
	    	 if(total==ladderPriceItmes.length)
	    	 $("#col-scan"+rowIndex).css("color","blue"); 
	    	 //@author add/jiangzhidong @date 20160607 end
			 $("#setLadderPriceDialog").hide();
		 }
	 );
     
    //成本价格确定修改按钮
    $("#addCostOK").click(function(){
		var materialLineJson = JSON.parse($("#materialLineJson").val());
		var materialRowIndex = $("#materialRowIndex").val();
		var costConstituteJson = [];
		var costConstituteItmes = showCostTable.rows();
		for(var i=0; i< costConstituteItmes.length;i++){
	 		var Item = costConstituteItmes[i];
			var costid = "#costItemAmount_"+i;
			var price = $(costid).val();
			var remarkid = "#showCostTable #remark_" + i;
			var remark = $(remarkid).val();
			Item["costItemAmount"] = price;
			Item["remark"] = remark;
			costConstituteJson.push(JSON.stringify(Item)); 
		}
    	materialLineJson['costConstituteJson']= eval('['+costConstituteJson+']');  
	    updateMaterialLineByIndex(materialLineJson,materialRowIndex);
	    itemGrid.updateRow(materialLineJson,materialRowIndex);
		$("#showCostDialog").hide();
	});
     
	$('.col-scan').live("click", function() {
	    var scanCol        = $(this).next();  
	    var sanContentText = scanCol.text();
	    var sanContent     = sanContentText.split("@enquiry@"); 
	    var materialLineJson = sanContent[0]; //当前物料行数据
	    var rowIndex       = sanContent[1];  //当前是多少行
	    //@author update/jiangzhidong @date 20160607 begin
	    $("body").data("ladderRowIndex",rowIndex);
	    //@author update/jiangzhidong @date 20160607 end
	    $("#materialRowIndex").val(rowIndex);
	    $("#materialLineJson").val(materialLineJson);
	    var sanobj = JSON.parse(materialLineJson);
	    var supplierEnquiryNumber = sanobj.supplierEnquiryNumber;
		var orderItemNumber       = sanobj.orderItemNumber;
		var materialNumber        = sanobj.materialNumber;
		var materialDesc          = sanobj.materialDesc;
	    //取出并判断存放价格阶梯json是否为空
	    var ladderPriceJson       = sanobj.ladderPriceJson;
	    var purchaseEnquiryNumber = sanobj.purchaseOrderNumber;
		var orderItemNumber       = sanobj.orderItemNumber;
		var materialNumber        = sanobj.materialNumber;
		var materialLineNumber    = sanobj.materialLineNumber; 
		
	    if(ladderPriceJson != null && ladderPriceJson != "") {
	    	//@author update/jiangzhidong @date 20160601 begin
	   		addLadderPriceTable.load(JSON.parse(ladderPriceJson));
	   	 	//@author update/jiangzhidong @date 20160601 end
	    }else{//第一次加载该物料行阶梯报价信息
	    	var params = {  "elsAccount"     : elsAccount,  "toElsAccount" : toElsAccount,  "purchaseEnquiryNumber" : $("#purchaseEnquiryNumber").val(),  "orderItemNumber" : sanobj.purchaseRequestLineProjectNumber,
	    	                "materialNumber" : sanobj.materialNumber,"materialLineNumber"    : materialLineNumber  };
	    	addLadderPriceTable.load(params);
	    }
	    debugger;
	    $("#setLadderPriceDialog").show();
	});

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
	    	var costparams = { "elsAccount":elsAccount, "toElsAccount":toElsAccount,
	    	 		           "purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val(), "materialLineNumber":materialLineNumber };
	    	showCostTable.load(costparams);
	    }
	    $("#showCostDialog").show();
	});
	
	function initFactory(val,item){
		if (!item.materialVO.factory) {
			return "";
		}else if(item.materialVO.factoryDesc != null && item.materialVO.factoryDesc!="")
		{
			return item.materialVO.factory + "_" + item.materialVO.factoryDesc;
		}else{
			return item.materialVO.factory;
		}
	}
	function initStock(val,item) {
		if (!item.materialVO.stockPoint) {
			return "";
		}else if(item.materialVO.stockPoint != null && item.materialVO.stockPoint!=""){
			return item.materialVO.stockPoint + "_" + item.materialVO.stockPointDesc;
		}else{
			return item.materialVO.stockPoint;
		}
	}
	function initMaterialGroup(val,item) {
		if (item.materialVO.materialGroup !=null && item.materialVO.materialGroupDesc == null) {
			return item.materialVO.materialGroup;
		}
		else if(item.materialVO.materialGroup!=null && item.materialVO.materialGroupDesc != null){
			return item.materialVO.materialGroup + "_" + item.materialVO.materialGroupDesc;
		}
	}
	var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="sale_enquiry_item_mt"/>;
	
	var cols_file = [{ title:'项目行编号' , name:'materialLineNumber'      ,hidden:true, width:60 , align:'center'},
	                 { title:'申请订单号' , name:'purchaseApplyNumber'     ,hidden:true, width:60 , align:'center'},
	                 { title:'行号'       , name:'purchaseApplyItemNumber' ,hidden:true, width:60 , align:'center'},                 
	                 { title:'文件来源'   , name:'filePath'                ,hidden:true, width:500, align:'center'},
	                 { title:'<i18n:I18n key = "i18n_common_title_filename"       defaultValue="文件名称" />'   , name:'fileName'                            , width:100, align:'center'},
	                 { title:'<i18n:I18n key = "i18n_common_title_sendstatus"     defaultValue="发送状态" />'   , name:'fileStatus'                          , width:50 , align:'center' ,renderer : function(val){
						switch(val){
							case '0' : return '<i18n:I18n key = "i18n_label_notSent" defaultValue="未发送" />';
							case '1' : return '<i18n:I18n key = "i18n_label_Sent" defaultValue="已发送" />';
							case '2' : return '<i18n:I18n key = "i18n_common_title_sendstatus_received" defaultValue="已接收" />';
							default : return "";
							}
	                 	}},
	                 { title:'<i18n:I18n key = "i18n_common_title_materialnumber" defaultValue="物料编码" />'   , name:'purchaseMaterialNumber'              , width:100, align:'center'},
	                 { title:'<i18n:I18n key = "i18n_common_title_materialdescribe" defaultValue="物料描述" />' , name:'purchaseMaterialDesc'                , width:100, align:'center'},
	                 { title:'<i18n:I18n key = "i18n_label_logtime"       defaultValue="时间戳" />', name:'logtime' , width:120, renderer:function(val){ if (!val) { val = ""; } 
					 if ( val != "" && val.length != 10 ){ val = new Date(val).format("yyyy-MM-dd"); }
		             return "<span class='showText'>" + val + "</span>" + "<input name='saleEnquiryItemList[][priceValidEndDate]' class='Wdate' onfocus='WdatePicker()' type='text' style='display:none' value='"+val+"'/>";}}			
					];
function init() {
	$sob = $('.saying-dialog .option-bar');
    $("#FBK5").val(elsSubAccount+"_"+username);
    $('button').button();
    $("#sheet-project").tabs();
    //订单头列表      
    var frm = $("#queryForm");
	$("#elsAccount").val(elsAccount);
	initElsTaxRateList();
	
    headGrid = $('#table-head').mmGrid({
    	height      : 100  ,
        cols        : cols ,
        url         : "<%=basePath%>rest/SaleEnquiryService/querySaleEnquiryHeader" ,
        params      : frm.serializeJSON() ,
        method      : frm[0].method ,
        root        : "rows" ,
        loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
        noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
    });
    
    //@author add/jiangzhidong @date 20160521  begin
    headGrid.on('loadSuccess',function(e, data) {
		if (data.rows && data.rows.length > 0) {
			var obj = data.rows[0];
			//审批
			if (obj.flowCode!="" && obj.flowCode!="00") {
				if (obj.auditStatus!="0"){
					$("#entryBtn").hide() ;
					$("#cancelEntryBtn").show() ;
					$("#flowBtn").show() ;
				}else{
					$("#entryBtn").hide() ;
					$("#cancelEntryBtn").hide() ;
					$("#flowBtn").hide() ;
				}
			}else {
				$("#entryBtn").show();
				$("#cancelEntryBtn").hide();
				$("#flowBtn").hide();
			}
			//订单状态
			if (obj.orderStatus=="0"||obj.orderStatus=="1"||obj.orderStatus=="4"){
				$("#sendBtn").show() ;
			}else{
				$("#sendBtn").hide() ;		
			}
		}
    });
    //@author add/jiangzhidong @date 20160521  end
	//上传附件按钮
    $('.col-scan-file').live("click", function() {
        var scanCol = $(this).next();    
        var sanContentText = scanCol.text();
        var sanobj = eval('('+sanContentText+')');
        $("#materialLineJson-File").val(sanContentText);       
        $("#addFileDialog").show();
        initFileUploader(fileUploader);
    });
    
    $("#addFileBtn").click(function(){
    	$("#addFileDialog").show();
    	initFileUploader(fileUploader);
    	clearAddFileInfo();
    });  
    
    $("#addFileBtnCancel").click(function(){
    	$("#addFileDialog").hide();
    	clearAddFileInfo();
    });   
    //添加文件弹出框取消按钮
    $("#addFileBtnCancel").click(function(){
    	$("#addFileDialog").hide();
    	clearAddFileInfo();
    });   
    $("#dialogFileClose").click(function(){
    	$("#addFileDialog").hide();
    	clearAddFileInfo();
    });  
    $("#addFileBtnOK").click(function(){
     	$("#addFileDialog").hide();
     	var filePath = $("#filePath").val();
     	enquiryFileAddInfo(fileGrid);
     	clearAddFileInfo();
     	//tab切换
     	$('#add-enq-sheet').tabs({active:1});
   	    updateFile = true;
     	//预览文件内容
     	//previewFile(filePath);
    });
    
    function clearAddFileInfo(){
    	$("#fileName").val("");
    	$("#filePath").val("");
    }
    
    //判断是否切换到文件窗口 
    $('a[href=#sheet-project-two]').click(function(){
    	updateFile = true;
    })

    //增加文件到表单文件table
    function enquiryFileAddInfo(table){	
   		var fileName = $("#fileName").val();
   		var filePath = $("#filePath").val();
   		var fileType = "" ;
   		if(fileName != null && fileName != ""){
   			fileType = fileName.substring(fileName.lastIndexOf('.')+1)
   		}
   		var materialLineJson        = $("#materialLineJson-File").val();
   		var purchaseApplyNumber     = "" ;
		var purchaseApplyItemNumber = "" ;
		var purchaseMaterialNumber  = "" ;
		var purchaseMaterialDesc    = "" ; 
		var materialLineNumber      = "" ;

   		if(materialLineJson != null && materialLineJson != ""){   
			//不为空说明是在物料行上选的添加
   			var materialLineJsonObj = JSON.parse(materialLineJson);
   			purchaseApplyNumber     = materialLineJsonObj.purchaseRequestNumber;
   			purchaseApplyItemNumber = materialLineJsonObj.purchaseRequestLineProjectNumber;
   			purchaseMaterialNumber  = materialLineJsonObj.materialNumber;
   			purchaseMaterialDesc    = materialLineJsonObj.materialDesc;
   			materialLineNumber      = materialLineJsonObj.materialLineNumber;
   		}

   		var item = {
   			filePath                : filePath,
   			fileName                : fileName,
   			fileStatus              : 0,
   			purchaseApplyNumber     : purchaseApplyNumber, 
   			purchaseApplyItemNumber : purchaseApplyItemNumber,
   			materialLineNumber      : materialLineNumber,
   			purchaseMaterialNumber  : purchaseMaterialNumber,
   			purchaseMaterialDesc    : purchaseMaterialDesc,
   			logtime                 : 0
   		};
   	    table.addRow(item);    
   	    var fileTableJson = $("#fileTableJson").val();
   	    var tbleRows;
   	    if(fileTableJson != null && fileTableJson != ""){
   	    	tbleRows = JSON.parse(fileTableJson);
   	    	tbleRows.push(item);
   	    }else{
   	    	tbleRows = [];
      	    tbleRows.push(item);
   	    }
   	    $("#fileTableJson").val(JSON.stringify(tbleRows));
   	    $("#materialLineJson-File").val("");
   	}    

    //表单文件tag页 文件类型更改事件
    $("#selectFileType").change(function (){
   	    var selectFileTypeText = $("#selectFileType").find("option:selected").text();
   	    if(selectFileTypeText == '<i18n:I18n key="i18n_common_title_ourfile" defaultValue="我方文件"/>'){
   		    var fileTableJson =  $("#fileTableJson").val();
   		    //判断是否是临时查看,如果临时查看fileTableJson 为空 
   	        if(fileTableJson!=""&&fileTableJson!=null){
   		    	var myfileJson  = JSON.parse(fileTableJson);
   		    	fileGrid.load(myfileJson);
   	   		}else{
   		   		var filejson = frm.serializeJSON();
   		   		fileGrid.load(filejson);/**/
   		    }
   	    }else if(selectFileTypeText == '<i18n:I18n key="i18n_common_title_theyfile" defaultValue="对方文件"/>'){
   		    //对方文件的参数       
   			var fileparams = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val(), "materialLineNumber":"" };
            getOtherFile(fileparams);
   	    }else{
   		    //根据物料号寻找对应的文件
   			var fileparams = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseEnquiryNumber":$("#purchaseEnquiryNumber").val(), "materialLineNumber":($("#selectFileType").find("option:selected").val()-2 ) };
   		    fileGrid.load(fileparams);
   	    }
    });
    
	function initFileUploader(fileUploader){
		elsAccount			='<%=session.getAttribute("elsAccount") %>';
    	//新增表单文件
    	if (!fileUploader) {
    	  	fileUploader = WebUploader.create({
    	  	    swf      : '<%=basePath%>jsLib/webuploader/Uploader.swf',
    	  	    auto     : true,
    	  	    server   : '<%=basePath%>servlet/UploadServlet',
    	  	    pick     : '#btnFileUpload',
    	  	    resize   : false,
    	  	    formData : { elsAccount : elsAccount }
    	  	});
    	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
    	  	    var filePath = response.url;
    	  	    var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
    	        $("#filePath").val(filePath);
    	  	});
    		fileUploader.on( "fileQueued" , function(file){
    			var fileName = file.name;
    			$("#fileName").val(fileName);
    			$("#fileType").val(file.ext);
    		});
    	}
    }    
	
	headGrid.on('cellSelected', function (e, item, rowIndex, colIndex) {
		if (item && item.purchaseEnquiryNumber) {
			// 动态加载聊天窗口
			var hadSelected = headGrid.selectedRows() ;
			if(hadSelected && hadSelected.length) {
				initChat(elsAccount+"_"+item.purchaseEnquiryNumber,item.fbk4,hadSelected) ;
	    	}		
			// 加载采购表单文件
		}
	}).on('loadSuccess', function (e, data) {
		if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			headGrid.select(0);
			// 动态加载聊天窗口
			var hadSelected = [];
			if(headGrid.selectedRows() && headGrid.selectedRows().length) {
    			hadSelected = headGrid.selectedRows()
    		}
			initChat('','',hadSelected);
			if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
            $sob.click();
		}
	});

	itemGrid = $('#table-item').mmGrid({
        cols        : cols_item,
        url         : "<%=basePath%>rest/SaleEnquiryService/querySaleEnquiryItemsByHead",
        params      : frm.serializeJSON(),
        method      : frm[0].method,
        root        : "rows",
        loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
        noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
        checkCol	: true,
        multiSelect : true,
        plugins: [
            $('#pg1').mmPaginator({
                  style           : 'plain'
                , totalCountName  : 'total'
                , page            : 1
                , pageParamName   : 'currentPage'
                , limitParamName  : 'pageSize'
                , limitLabel      : '<i18n:I18n key = "i18n_common_mmgrid_limitlabel"  defaultValue="每页{0}条" />'
                , totalCountLabel : '<i18n:I18n key = "i18n_common_mmgrid_totalcountlabel"  defaultValue="共<span>{0}</span>条记录" />'
                , limit           : null
                , limitList       : [100,200,300,500]
            })
        ]
    });
	
	itemGrid.on('loadSuccess',function(e,data) {
		bindItemEvent();
		if(showCheck){
			showCheck();
			showCheck=false;
		}
		$('.input-taxesCode').off('click').on("click", function() {
			var rowIndex = $(this).closest("tr").index();
			var scanCol = $(this).next();
			var sanContentText = scanCol.text();
			var sanContent = sanContentText.split("@enquiry@");
			$('body').data("rowIndex",rowIndex);
			$("#oldMaterialRowIndex").val(sanContent[1]);
			//$("#taxesCode_index).val(rowIndex);
			$('body').data('currentLineObj',JSON.parse(sanContent[0]));
			var _w = $("#selectTaxesCodeDialog").show();
			$("#btnTaxesCodeOfMeasurementCancel,#btnSelectTaxesCodeOfMeasurementClose").one('click',function(){_w.hide()});
			
			if(selectTaxesCodeOfMeasurementTable == null || selectTaxesCodeOfMeasurementTable ==""){
				var colsTaxesCodeOfMeasurement = [{ title:'税率代码', name:'taxCode' , width:100, align:'center'},
					{ title:'税率名称', name:'taxName' , width:180, align:'center'}];
				//初始化table
				selectTaxesCodeOfMeasurementTable = $('#taxesCode-of-measurement-table').mmGrid({
					height      : 180,
					width       : 410,
					cols        : colsTaxesCodeOfMeasurement,
					url         : "<%=basePath%>rest/ElsTaxRateService/queryElsTaxRateList",
					params      : {"elsAccount":elsAccount},
					method      : 'post',
					root        : 'rows',
					loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
					noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
					indexCol    :  true
				});
				selectTaxesCodeOfMeasurementTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
					$('body').data('unitRow',item);
				});
			}
		});


    	for(var i = 0;i<data.rows.length;i++){
    		//文件是物料行号判断 ，物料行号从0开始，加上之前的我们文件和对方文件的序号，选项值 得从2开始 
    		$("#selectFileType").append("<option  value = " + (data.rows[i].materialLineNumber + 2)+"> " + data.rows[i].materialNumber  +"</option>")
    	} 
	});

	fileGrid = $('#table-file').mmGrid({
        cols: cols_file,
        url : "<%=basePath%>rest/SaleEnquiryFileService/findSaleCreateEnquiryFile",
        params: frm.serializeJSON(),
        method:  frm[0].method,
        root:"rows",
        nowrap:true,
        loadingText : '<i18n:I18n key = "i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />' ,
        noDataText  : '<i18n:I18n key = "i18n_common_mmgrid_nodatatext"  defaultValue="暂无数据" />' ,
        checkCol: true,
    });
    //rowSelelected 的方法统一改成cellSelected,其他的统一修改 
    fileGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
// 		previewFile(item.filePath);
	}); 
	
	//移除文件按钮 
	$("#deleteSelectBtn").click(function(){
		// 判断是否有选中的行项目  
		var selectedIndexes = fileGrid.selectedRowsIndex();
		var selectRow = fileGrid.selectedRows();
		var index = fileGrid.index();
		if(selectRow!=null&&selectRow!=""){
			if(selectRow[index].toElsAccount !=null){
				if(selectRow[index].filePath.match(selectRow[index].toElsAccount))
				{
					alert("<i18n:I18n key = 'test'  defaultValue='对方文件无法删除' />",2);
					return;
				}
			}
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key = "i18n_common_confirm_delete"  defaultValue="是否确认删除" />' + selectRow[index].fileName ,closeEvent:function(){
// 				var filepath = selectRow[index].filePath;
// 				fileGrid.removeRow(selectedIndexes);  
				debugger;
				//var filepath = selectRow[index].filePath;
				var fileItem = fileGrid.selectedRows()[0];
				$.ajax({
					 	type        : "POST"                     ,  
			 	        url         : "<%=basePath%>rest/SaleEnquiryFileService/deleteSaleCreateEnquiryFile", 
			 	        data        : JSON.stringify(fileItem) , 
			 	        contentType : "application/json"         ,
			 	 		dataType    : "json"                     ,
			 	        success     : function(data){ 
			 	        						$("#selectFileType").val(0);
			 	        						fileGrid.load({}) ;
			 	        			  },
			 	        error       : function(data){  alert('<i18n:I18n key = ""  defaultValue="删除文件失败" />') ; }
				});
			}});
		}else{
		    alert('<i18n:I18n key = "i18n_select_the_file"  defaultValue="请选择文件" />');
		}
	});  
	   
	$("#DownloadBtn").click(function(){
		// 判断是否有选中的行项目 
		debugger;
	    var selectedIndexes = fileGrid.selectedRowsIndex();
	    var selectRow = fileGrid.selectedRows();
	    var index = fileGrid.index();
	    if(selectRow!=null&&selectRow!=""){
	    	SelectRow =  selectRow[index];
	    	var filepath = SelectRow.filePath;
	    	window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filepath;
	    }else{
	    	parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key = "i18n_please_select_a_file_to_download"  defaultValue="请选择要下载的文件" />' });
	    }
	});     	
	//预览文件按钮  
	/**预览服务器启动不了暂时注掉
	$("#preViewBtn").click(function(){
		var selectRow = fileGrid.selectedRows();
        var index = fileGrid.index();
        if(selectRow!=null&&selectRow!=""){
			var filepath = selectRow[index].filePath;
			var filepathjson = JSON.parse(filepath) 
			previewFile(filepathjson);
        }else{
		    alert('<i18n:I18n key = "i18n_select_the_file"  defaultValue="请选择文件" />');
        }
	});**/
    //通过ajax 获取对方文件信息 json 并且将json 返回 
    function getOtherFile(fileparams){
	    $.ajax({    type        : "POST"                     ,  
	 	            url         : "<%=basePath%>rest/SaleEnquiryService/findPurchaseEnquiryFormFile", 
	 	            data        : JSON.stringify(fileparams) , 
	 	            contentType : "application/json"         ,
	 	 			dataType    : "json"                     ,
	 	            success     : function(data){  fileGrid.load(data) ;   },
	 	            error       : function(data){  alert('<i18n:I18n key = "i18n_failed_to_load_file"  defaultValue="加载文件失败" />') ; }
	 	});
    }
	//查看历史报价纪录  
    $('.col-price-his').live("click", function() {
        var scanCol = $(this).next().text() ;
        var item = JSON.parse(scanCol)      ;
        parent.elsDeskTop.defineWin({
            'iconSrc'       : 'icon/els-icon.png',
            'windowsId'     : 'PurchaseEnHisPrice',
            'windowTitle'   : '<i18n:I18n key = "i18n_view_the_history_quotation_record"  defaultValue="查看历史报价记录" />',
             windowSubTitle : '<i18n:I18n key = "i18n_quotation_record"  defaultValue="报价记录" />', 
            'iframSrc':'<%=basePath%>enquirymanage/saleorder/saleEnquiryHisManage.jsp?purchaseRequestLineProjectNumber=' + item.purchaseRequestLineProjectNumber 
            		+ "&purchaseRequestNumber="+item.purchaseRequestNumber
            		+ "&materialNumber="+item.materialNumber
            		+ "&quoteMethod="+item.quoteMethod
            		+ "&purchaseEnquiryNumber="+ $("#purchaseEnquiryNumber").val()
            		+ "&elsAccount="+elsAccount
            		+ "&toElsAccount="+toElsAccount,            		
            //showAdv: true,
            //advArr: ['icon/test-car.png','icon/test-car2.png'],
             windowStatus: 'regular',
             windowMinWidth: 880,
             windowMinHeight: 450,
            'windowWidth':880,
            'windowHeight':450,
            'parentPanel':".currDesktop"
        });    
    });
}

	function changeButtonStatus() {
		//根据flowCode改变各按钮状态auditStatus
		if ((flowCode != "" && flowCode != "00") ) {
			if (auditStatus != "0"){
				$("#entryBtn").hide() ;
				$("#cancelEntryBtn").show() ;
				$("#flowBtn").show() ;
				$("#sendBtn").hide() ;
			}else{
				$("#entryBtn").show() ;
				$("#cancelEntryBtn").hide() ;
				$("#flowBtn").hide() ;
			}
		} 
	}

    function selectDown(val,item,rowIndex) {
        var sel = '' ;
        var ind = 0  ;
        if(val && val.length) {
        	if(parseInt(item.accessoryRequire) == 1 ){
        		ind = 1 ;
        	}
            sel += '<div><p style="display: none;">' +JSON.stringify(item) + '</p><h6 style="display: none;">' +rowIndex+
				   '</h6><span class="select-item">' + val[ind].name + '</span><select class="select-tag" style="display: none;">';

            for(var i=0; i<=val.length-1;i++) {
                if(i == val.length-1) {
                    sel += '<option class="line-height-40" value="'+val[i].value+'">'+ val[i].name +'</option><lect>';
                } else {
                    sel += '<option class="line-height-40" value="'+val[i].value+'">'+ val[i].name +'</option>';
                }
            }
        }
        return sel;
    }
	//选择计量单位弹出框确认按钮单击事件
	$("#btnTaxesCodeOfMeasurementOK").click(function(){
		var selectedRows = selectTaxesCodeOfMeasurementTable.selectedRows();
		if(selectedRows != "" && selectedRows != null ){
			var taxCode = selectedRows[0].taxCode;
			var busType = $("body").data("busType");
			if(busType){//判断是否批量设置弹出框
				$("#"+busType).val(unitCode);
				$("body").data("busType",null);
			}else{
				var taxesCode_index = $("#taxesCode_index").val();
				var name = $("#oldMaterialRowIndex").val();//列名
				var currentLineObj = $('body').data('currentLineObj');
				var index = $('body').data("rowIndex");
				$("#taxesCode_"+index).val(taxCode);
				computeTax(index);
				//var frmObj = $("#queryForm").serializeJSON();
				//var materialLineJsonObj = frmObj.purchaseEnquiryItemVOs[taxesCode_index];
				//currentLineObj[taxesCode]=taxCode;
				//materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
				//editTable.updateRow(materialLineJsonObj,taxesCode_index);
			}
		}
		$("#selectTaxesCodeDialog").hide();
	});
  
	//填充列按钮功能
	$("#fillTime").click(function(){
		var selecteds=$("#table-item tr[class$='selected']");
		var columnSelected=$("#enquiryOrdertItemGird").find("th input:checked");          
		if(selecteds.length<1){
				alert("<i18n:I18n key='i18n_alert_fillLine' defaultValue='请选择填充行!'/>",2);
			return;
		}
		if(columnSelected.length<1){
				alert("<i18n:I18n key='i18n_alert_fillRow' defaultValue='请选择填充列!'/>",2);
			return;
		}
		$("#enquiryOrdertItemGird").find("th input:checked").each(function(){
			var className=$(this).parent().parent().attr("class").split(" ")[0];
			var val=selecteds.eq(0).find("."+className+" input").val();
			$("#table-item tr[class$='selected']").each(function(){
				$(this).find("."+className+" input").val(val);
			});
		});
	});
		
    //显示表标题复选框
    function showCheck(){
		$("#enquiryOrdertItemGird").find("th").each(function(){
			var className=$(this).attr("class").split(" ")[0];
			var addCheck="<input type='checkbox' class='mmg-column-check'>";
			var count=$("."+className).find("input[name^='enquiryOrdertItemList[]']").not(".noEdit").length;
			if(count>0){
				$(this).find(".mmg-titleWrapper").css('white-space','nowrap').prepend(addCheck);
			}
		});
	}
	
    function initElsTaxRateList(){
    	$.ajax({
    		url         : "<%=basePath%>rest/SaleEnquiryService/queryElsTaxRateList" ,
    		type        : "POST" ,
    		contentType : "application/json" ,
    		dataType    : "json" ,
    		data        : JSON.stringify({"elsAccount":elsAccount}) ,
    		success     : function(data) {
    			if( data != null && data != "" ){
    			    $.each(data,function(){
    		        	$("#taxesCode").append("<option value=" + data.taxCode + ">" + this.taxCode + "</option>");
    		        });
    			}
    		}
    	});	    	
    }
    
	function bindItemEvent(){
	}	
	//预览文件
	function previewFile(filePath){
		var param = {"elsAccount":elsAccount,"filePath":filePath}
		$.ajax({        url : "${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
	 			       type : "POST",
	 			       data:JSON.stringify(param),
	 			contentType : "application/json",
	 			   dataType : "json",
	 			    success : function(data) {
	 				var resStatus = data.statusCode;
	 				var message   = data.message;
	 				if("200" == resStatus){
	 					var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
	 					var width   = $("#file-display").width();
	 					var height  = $("#file-display").height();
	 					$("#viewerPlaceHolder").css("width",width+"px");  
	 					$("#viewerPlaceHolder").css("height",height+"px");  
	 					$("#viewerPlaceHolder").css("display","block" );  
	 					var fp = new FlexPaperViewer( '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer', 'viewerPlaceHolder', 
	 					            {config : {
	 					                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
	 					                Scale : 1.5,//初始化缩放比例(1=100%)
	 					                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
	 					                ZoomTime : 0.5,//切换缩放比例延迟显示时间
	 					                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
	 					                FitPageOnLoad : false,//初始化时自适应页面
	 					                FitWidthOnLoad : false,//初始化时自适应宽度
	 					                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
	 					                ProgressiveLoading : false,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
	 					                MinZoomSize : 0.2,//最小缩放比例
	 					                MaxZoomSize : 5,//最大缩放比例
	 					                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
	 					                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
	 					                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
	 					                ZoomToolsVisible : true,//工具浪是否显示缩放工具
	 					                NavToolsVisible : true,//工具栏是否显示导航工具
	 					                CursorToolsVisible : true,//工具栏是否显示光标
	 					                SearchToolsVisible : true,//工具栏是否显示搜索工具
	 					                localeChain: 'zh_CN'//地区语言(en_US:English,)
	 					            	}
	 					});
	 				} else {
	 					parent.elsDeskTop.tip.init({ type : 'alert', displayType : 3,  message : message });
	 				}
	 			},
	 			error : function(data) {
	 				parent.elsDeskTop.tip.init({ type : 'alert', displayType : 3,  message : data.message });
	 			}
	 		});
		var showDiv = $("#file-display");
		var viewerPlaceA = $("#viewerPlaceHolder");
		viewerPlaceA.empty();
		var param = {
				elsAccount : elsAccount,
				filePath : filePath
		};
		
		if(isSupportImage(filePath)){//系统支持的图片,直接显示
			showDiv.css("overflow","auto");
			$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
		} else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
			showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
	    	$.ajax({
				url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
				type :"POST",
				data : JSON.stringify(param),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					var resStatus = data.statusCode;
					var message = data.message;
					if("200" == resStatus){
						var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
						var width=$("#file-display").width()              ;
						var height=$("#file-display").height()            ;
						$("#viewerPlaceHolder").css("width",width+"px")   ;  
						$("#viewerPlaceHolder").css("height",height+"px") ;  
						$("#viewerPlaceHolder").css("display","block" )   ;  
	
						var fp = new FlexPaperViewer(
						            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
						            'viewerPlaceHolder', 
						            {config : {
						                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
						                Scale : 1.5,//初始化缩放比例(1=100%)
						                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
						                ZoomTime : 0.5,//切换缩放比例延迟显示时间
						                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
						                FitPageOnLoad : false,//初始化时自适应页面
						                FitWidthOnLoad : false,//初始化时自适应宽度
						                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
						                ProgressiveLoading : true,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
						                MinZoomSize : 0.2,//最小缩放比例
						                MaxZoomSize : 5,//最大缩放比例
						                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
						                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
						                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
						                ZoomToolsVisible : true,//工具浪是否显示缩放工具
						                NavToolsVisible : true,//工具栏是否显示导航工具
						                CursorToolsVisible : true,//工具栏是否显示光标
						                SearchToolsVisible : true,//工具栏是否显示搜索工具
						                localeChain: 'zh_CN'//地区语言(en_US:English,)
						            	}
						            });
					} else {
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : message});
					}
				},
				error : function(data) {
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
				}
			});
		} else {
			parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "<i18n:I18n key='i18n_alert_fileType_notSupport' defaultValue='不支持在线预览的文档类型!'/>"});
		}
	}
	
	//更新行操作 自动填充input框输入值
	function updateMaterialLineByIndex(materialLine , index){
		materialLine = inputSetValue(materialLine,index);
	    itemGrid.updateRow(materialLine,index);
	}
	
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
	function inputSetValue(materialLine,index){
	    //获取改行计价度量单位
	    var priceMetricQuantity             = $("#priceMetricQuantity_"+index).val();
	    materialLine["priceMetricQuantity"] = priceMetricQuantity;
	    //获取改行计价单位
	    var priceQuantity                   = $("#priceQuantity_"+index).val();
	    materialLine["priceQuantity"]       = priceQuantity;
	    //获取最小订单量
	    var minOrderQuantity                = $("#minOrderQuantity_"+index).val();
	    materialLine["minOrderQuantity"]    = minOrderQuantity;
	    //获取最小包装数
	    var minPackQuantity                 = $("#minPackQuantity_"+index).val();
	    materialLine["minPackQuantity"]     = minPackQuantity;
	    //获取含税价格
	    var price                           = $("#price_"+index).val();
	    materialLine["price"]               = price;
	    //获取不含税价
	    var priceIncludingVat               = $("#priceIncludingVat_"+index).val();
	    materialLine["priceIncludingVat"]   = priceIncludingVat;
	    //获取不足容差
	    var minTolerance                    = $("#minTolerance_"+index).val();
	    materialLine["minTolerance"]        = minTolerance;
	    //获取超量容差
	    var maxTolerance                    = $("#maxTolerance_"+index).val();
	    materialLine["maxTolerance"]        = maxTolerance;
	    //获取改行计价单位
	    var infinite                        = $("#infinite_"+index).val();
	    materialLine["infinite"]            = infinite;   
	    var taxesCode                       = $("#taxesCode_"+index).val();
	    materialLine["taxesCode"]           = taxesCode;   
	    var FBK7                            = $("#FBK7_"+index).val();
	    materialLine["FBK7"]                = FBK7;
	    var FBK8                            = $("#FBK8_"+index).val();
	    materialLine["FBK8"]                = FBK8;   
	    var FBK9                            = $("#FBK9_"+index).val();
	    materialLine["FBK9"]                = FBK9;   
	    var FBK10                           = $("#FBK10_"+index).val();
	    materialLine["FBK10"]               = FBK10;   
	    var FBK11                           = $("#FBK11_"+index).val();
	    materialLine["FBK11"]               = FBK11;   
		var remark                          = $("#remark_"+index).val();
		materialLine["remark"]              = remark;   
	    //获取价格有效时间 
	    var priceValidBeginDate             = $("#priceValidBeginDate_" + index).val() ;
	    materialLine["priceValidBeginDate"] = priceValidBeginDate;   
	    //币别
	    var currency                        = $("#currency_" + index).val();
	    materialLine["currency"]            = currency;
	    //价格单位 
	    var unitPrice                       = $("#unitPrice_" + index).val();
	    materialLine["unitPrice"]           = unitPrice;
	    //获取价格失效时间 
	    var priceValidEndDate               = $("#priceValidEndDate_" + index).val();
	    materialLine["priceValidEndDate"]   = priceValidEndDate;
	    //付款方式  @author jiangzhidong @date 20160812 begin
	    var FBK36                           = $("#FBK36_"+index).val();
	    materialLine["FBK36"]               = FBK36;
	    materialLine["fbk36"]               = FBK36;
	    //付款方式  @author jiangzhidong @date 20160812 end
	    return materialLine;
	}
	
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
		var FBK16 = $("#FBK16_"+rowIndex).val();
		var priceIncludingVat = $("#priceIncludingVat_"+rowIndex).val();
		if(price != "" && FBK16 != "" && priceIncludingVat == ""){//根据不含税价格及税率计算含税价格
			priceIncludingVat = price*(1+FBK16/100.0);
			$("#priceIncludingVat_"+rowIndex).val(priceIncludingVat.toFixed(6));
		}else if(price == "" && FBK16 != "" && priceIncludingVat != ""){//根据含税价格及税率计算不含税价格
			price = priceIncludingVat/(1+FBK16/100.0);
			$("#price_"+rowIndex).val(price.toFixed(6));
		}else if(price != "" && FBK16 == "" && priceIncludingVat != ""){//根据不含税价格及含税价格计算税率
			var FBK16 = (priceIncludingVat-price)*100.0/price;
			$("#FBK16_"+rowIndex).val(FBK16.toFixed(2));
		}
	}
	//------------含税价、不含税价、税率自动计算；含税价＝不含税价×（1 ＋ 税率 / 100 ）---end----
	
	//-----------导出excel--------------------
	$('#exportBtn').click(function() {
		var headTableRows = headGrid.rows();
		var elsAccount = headTableRows[0].elsAccount;
		var toElsAccount = headTableRows[0].toElsAccount;
		var purchaseEnquiryNumber = headTableRows[0].purchaseEnquiryNumber;
 		window.location.href = "<%=basePath%>rest/SaleEnquiryService/exportExcel/"+elsAccount + "/" + toElsAccount+"/"+purchaseEnquiryNumber;
	});
	//-----------导出excel--------------------
	
	 //excel导入-------------begin-------------------
	   function initExcelUploader(){
			if(!excelUploader){
				excelUploader = WebUploader.create({
				    // swf文件路径
				    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
				    auto: true,
				    duplicate :true,
				    accept:{
				    	extensions:"xls"
				    },
				    // 文件接收服务端。
				    server: '<%=basePath%>servlet/UploadServlet',
				    // 选择文件的按钮。可选。
				    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
				    pick: '#importBtn',
				    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
				    resize: false,
				    formData : {
	    		     	elsAccount : elsAccount
	    		     }
				});
				excelUploader.on( 'uploadAccept', function( obj, response ) {
				  	var filePath = response.url;
				  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
				  	$.ajax({
						url :"<%=basePath%>rest/SaleEnquiryService/importExcel",
						type :"POST",
						contentType : "application/json",
						dataType : "json",
						data:JSON.stringify({"filePath":filePath,"elsAccount":elsAccount}),
						success : function(data) {
							if(data.statusCode=="-100"){
								parent.elsDeskTop.hideLoading();
								alert("<i18n:I18n key='i18n_alert_importFail' defaultValue = '导入失败！请检查文件内容，异常信息：'/>"+data.message,3);
							}else{
								parent.elsDeskTop.hideLoading();
								var materialRows = itemGrid.rows();
								if(materialRows != "" && data != null){
									for( var i = 0 ; i < materialRows.length ; i ++){
										for( var j = 0 ; j < data.length ; j ++){
											var materialRow = materialRows[i];
											var selectRow = data[j];
											var purchaseEnquiryNumber = materialRow.purchaseEnquiryNumber;
											var lineNumber = materialRow.materialLineNumber;
											var _purchaseEnquiryNumber = selectRow.purchaseEnquiryNumber;
											var _lineNumber = selectRow.materialLineNumber;
											if(purchaseEnquiryNumber == _purchaseEnquiryNumber && lineNumber == _lineNumber){//确定物料行
												materialRow['cycle']=selectRow.cycle;
												materialRow['priceIncludingVat']=selectRow.priceIncludingVat;
												materialRow['price']=selectRow.price;
												materialRow['taxesCode']=selectRow.taxesCode;
												materialRow['minOrderQuantity']=selectRow.minOrderQuantity;
												materialRow['minPackQuantity']=selectRow.minPackQuantity;
												materialRow['priceValidBeginDate']=selectRow.priceValidBeginDate;
												materialRow['priceValidEndDate']=selectRow.priceValidEndDate;
												materialRow['remark']=selectRow.remark;
												itemGrid.updateRow(materialRow,i);
											}
										}
									}
								}
								alert('<i18n:I18n key="i18n_common_alert_successfulImprot" defaultValue="导入成功！" />',1);
							}
						},
						error: function (data) {//获取ajax的错误信息
							parent.elsDeskTop.hideLoading();
							alert('<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误！" />',3);
			            }
					});
				});
			}
		}
	   //excel导入-------------end-------------------
</script>
</body>
</html>